FZF_VERSION=0.17.4
FZF_REL=https://github.com/junegunn/fzf-bin/releases/download/$(FZF_VERSION)
FZF_REPO=https://raw.githubusercontent.com/junegunn/fzf/$(FZF_VERSION)

CURL=$(if $(VERBOSE),curl,curl -s)
SHA256SUM=$(if $(VERBOSE),sha256sum,sha256sum --quiet)
RM=$(if $(VERBOSE),rm -v,rm)
MKDIR=$(if $(VERBOSE),mkdir -v,mkdir)

fzf: 	bin \
		bin/fzf \
		share/fzf/completion.bash \
		share/fzf/key-bindings.bash \
		share/fzf/vim/doc/fzf.txt \
		share/fzf/vim/plugin/fzf.vim \
		share/man/man1/fzf.1
	$(SHA256SUM) --check fzf-sums.txt

clean:
	$(RM) -rf bin
	$(RM) -rf share

bin:
	$(MKDIR) -p bin

bin/fzf:
	$(CURL) -Lf $(FZF_REL)/fzf-$(FZF_VERSION)-linux_amd64.tgz | tar xzf - -C bin

share/fzf/completion.bash:
	$(CURL) -Lf --create-dirs $(FZF_REPO)/shell/completion.bash -o $@

share/fzf/key-bindings.bash:
	$(CURL) -Lf --create-dirs $(FZF_REPO)/shell/key-bindings.bash -o $@

share/man/man1/fzf.1:
	$(CURL) -Lf --create-dirs $(FZF_REPO)/man/man1/fzf.1 -o $@

share/fzf/vim/doc/fzf.txt:
	$(CURL) -Lf --create-dirs $(FZF_REPO)/doc/fzf.txt -o $@

share/fzf/vim/plugin/fzf.vim:
	$(CURL) -Lf --create-dirs $(FZF_REPO)/plugin/fzf.vim -o $@
