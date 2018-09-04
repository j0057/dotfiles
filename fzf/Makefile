FZF_VERSION=0.17.4
FZF_REL=https://github.com/junegunn/fzf-bin/releases/download/$(FZF_VERSION)
FZF_REPO=https://raw.githubusercontent.com/junegunn/fzf/$(FZF_VERSION)

fzf: 	bin \
		bin/fzf \
		share/fzf/completion.bash \
		share/fzf/key-bindings.bash \
		share/fzf/vim/doc/fzf.txt \
		share/fzf/vim/plugin/fzf.vim \
		share/man/man1/fzf.1
	sha256sum --check --quiet fzf-sums.txt

clean:
	rm -rf bin
	rm -rf share

bin:
	mkdir -p bin

bin/fzf:
	curl -sLf $(FZF_REL)/fzf-$(FZF_VERSION)-linux_amd64.tgz | tar xzf - -C bin

share/fzf/completion.bash:
	curl -sLf --create-dirs $(FZF_REPO)/shell/completion.bash -o $@

share/fzf/key-bindings.bash:
	curl -sLf --create-dirs $(FZF_REPO)/shell/key-bindings.bash -o $@

share/man/man1/fzf.1:
	curl -sLf --create-dirs $(FZF_REPO)/man/man1/fzf.1 -o $@

share/fzf/vim/doc/fzf.txt:
	curl -sLf --create-dirs $(FZF_REPO)/doc/fzf.txt -o $@

share/fzf/vim/plugin/fzf.vim:
	curl -sLf --create-dirs $(FZF_REPO)/plugin/fzf.vim -o $@
