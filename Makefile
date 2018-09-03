
HOSTNAME=$(shell hostname | tr A-Z a-z)

install : MODE=-S
install : $(HOSTNAME)

clean : MODE=-D
clean : $(HOSTNAME)

refresh : MODE=-R
refresh : $(HOSTNAME)

nb-xps08 : _bash _git _tmux _ssh_hack _vim _pip _scripts _fzf_bin

muon   : _bash _git _tmux _ssh _vim _pip _scripts _media _ssh _minecraft
photon : _bash _git            _vim _pip _scripts _media _admin
arch   : _bash _git _tmux _ssh _vim _pip _scripts

_bash:
	stow -v -t $(HOME) $(MODE) bash

_git:
	stow -v -t $(HOME) $(MODE) git

_tmux:
	stow -v -t $(HOME) $(MODE) tmux

_ssh:
	mkdir -pv $(HOME)/.ssh
	$(if $(filter -S -R,$(MODE)),echo 'Include ~/.ssh/$(HOSTNAME).conf' > ssh/config,)
	stow -v -t $(HOME)/.ssh $(MODE) ssh
	$(if $(filter _D,$(MODE)),rm -fv ssh/config,)

_ssh_hack:
	stow -v -t $(HOME)/.ssh $(MODE) ssh
	$(if $(filter -S -R,$(MODE)),cat ssh/$(HOSTNAME).conf | sed 's/Include //' | sed 's_~_$(HOME)_' | xargs cat > ~/.ssh/config,rm -fv ~/.ssh/config)

_vim:
	mkdir -pv $(HOME)/.vim
	stow -v -t $(HOME)/.vim $(MODE) vim

_pip:
	stow -v -t $(HOME) $(MODE) pip

_scripts:
	stow -v -t $(HOME)/.local/bin $(MODE) scripts

_fzf_bin:
	./fzf-get
	sudo stow -v -t /usr/local $(MODE) fzf

_media:
	stow -v -t $(HOME)/.local/bin $(MODE) media

_minecraft:
	sudo stow -v -t /usr/local $(MODE) minecraft

_admin:
	sudo stow -v -t /usr/local $(MODE) admin
