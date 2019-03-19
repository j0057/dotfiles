
default: refresh

HOSTNAME=$(shell hostname | tr A-Z a-z)

STOW=$(if $(VERBOSE),stow -v,stow)
MKDIR=$(if $(VERBOSE),mkdir -v,mkdir)
CP=$(if $(VERBOSE),cp -v,cp)
RM=$(if $(VERBOSE),rm -v,rm)
MV=$(if $(VERBOSE),mv -v,mv)
LN=$(if $(VERBOSE),ln -v,ln)
GREP=$(if $(VERBOSE),grep -v,grep)

install : MODE=-S
install : $(HOSTNAME)

clean : MODE=-D
clean : $(HOSTNAME)

refresh : MODE=-R
refresh : $(HOSTNAME)

nb-xps08	: _hooks _bash _git _tmux _ssh _vim _pip _scripts _fzf_bin
muon		: _hooks _sdreload _bash _git _tmux _ssh _vim _pip _scripts _media _minecraft
photon		: _hooks _bash _git            _vim _pip _scripts _media _admin
proton		: _hooks _bash _git _tmux _ssh _vim _pip _scripts _media
arch		: _hooks _bash _git _tmux _ssh _vim _pip _scripts

_bash:
	$(STOW) $(MODE) bash -t $(HOME)

_git:
	$(STOW) $(MODE) git -t $(HOME)

_tmux:
	$(STOW) $(MODE) tmux -t $(HOME)

_ssh: ssh/config
	@$(MKDIR) -p $(HOME)/.ssh
	$(STOW) $(MODE) ssh -t $(HOME)/.ssh
	$(if $(filter -D,$(MODE)),$(RM) -f ssh/config)

# need OpenSSH 7.2+ for Include directive (current is 7.8)
ssh/config:
	echo 'Include ~/.ssh/$(HOSTNAME).conf' >$@
ifeq ($(HOSTNAME),nb-xps08)
	while $(GREP) ^Include $@; do \
		sed 's#Include ~/\.##' $@ | xargs cat >$@~; \
		$(MV) $@~ $@; \
	done

ssh/config: ssh/*.conf
endif

_vim:
	@$(MKDIR) -p $(HOME)/.vim
	$(STOW) $(MODE) vim -t $(HOME)/.vim

_pip:
	$(STOW) $(MODE) pip -t $(HOME)

_scripts:
	$(STOW) $(MODE) scripts -t $(HOME)/.local/bin

_fzf_bin:
	$(if $(filter -S -R,$(MODE)),make -C fzf VERBOSE=$(VERBOSE))
	sudo -n $(STOW) $(MODE) fzf -t /usr/local
	$(if $(filter -D,$(MODE)),make -C fzf VERBOSE=$(VERBOSE) clean)
	$(if $(filter -S -R,$(MODE)),$(LN) -sf /usr/local/share/fzf/vim vim/bundle/fzf,$(RM) -f vim/bundle/fzf)

_media:
	$(STOW) $(MODE) media -t $(HOME)/.local/bin

_minecraft:
	sudo -n $(STOW) $(MODE) minecraft -t /usr/local

_admin:
	sudo -n $(STOW) $(MODE) admin -t /usr/local

_hooks:
	@$(if $(filter -D -R,$(MODE)),$(RM) -f .git/hooks/prepare-commit-msg)
	@$(if $(filter -S -R,$(MODE)),$(LN) -s ../../hooks/prepare-commit-msg-submodule-summary .git/hooks/prepare-commit-msg)

_sdreload:
	-$(if $(filter -R -D,$(MODE)),sudo -n systemctl disable systemd-reload.service)
	$(if $(filter -R -D,$(MODE)),sudo -n $(RM) -f /etc/systemd/system/systemd-reload.service)
	$(if $(filter -R -S,$(MODE)),sudo -n $(CP) systemd/systemd-reload.service /etc/systemd/system)
	$(if $(filter -R -S,$(MODE)),sudo -n systemctl enable systemd-reload.service)
