
HOSTNAME=$(shell hostname | tr A-Z a-z)

ifeq ($(QUIET),0)
	STOW=stow -v
	MKDIR=mkdir -v
	RM=rm -v
else
	STOW=stow
	MKDIR=mkdir
	RM=rm
endif

install : MODE=-S
install : $(HOSTNAME)

clean : MODE=-D
clean : $(HOSTNAME)

refresh : MODE=-R
refresh : $(HOSTNAME)

nb-xps08 : _bash _git _tmux _ssh _vim _pip _scripts _fzf_bin

muon   : _bash _git _tmux _ssh _vim _pip _scripts _media _minecraft
photon : _bash _git            _vim _pip _scripts _media _admin
arch   : _bash _git _tmux _ssh _vim _pip _scripts

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
	while grep ^Include $@ >/dev/null; do \
		sed 's#Include ~/\.##' $@ | xargs cat >$@~; \
		mv $@~ $@; \
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
	./fzf-get
	$(STOW) stow $(MODE) fzf -t /usr/local

_media:
	$(STOW) $(MODE) media -t $(HOME)/.local/bin

_minecraft:
	sudo $(STOW) $(MODE) minecraft -t /usr/local

_admin:
	sudo $(STOW) $(MODE) admin -t /usr/local
