V=20230923

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 ilolicon{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/ilolicon{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
dist:
	git archive --format=tar --prefix=ilolicon-keyring-$(V)/ master | gzip -9 > ilolicon-keyring-$(V).tar.gz
	gpg --default-key BA266106 --detach-sign --use-agent ilolicon-keyring-$(V).tar.gz

upload:
	rsync --chmod 644 --progress ilolicon-keyring-$(V).tar.gz ilolicon-keyring-$(V).tar.gz.sig ilolicon.org:/nginx/var/www/keyring/

.PHONY: install uninstall dist upload

