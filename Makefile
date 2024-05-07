include secrets

all: clean
	mkdir -p ./build
	cp -a files ./build/files
	find build/files -type f -print0 | xargs -0 sed -i 's/%%NEXTCLOUD_POSTGRES_PW%%/${NEXTCLOUD_POSTGRES_PW}/g'
	find build/files -type f -print0 | xargs -0 sed -i 's/%%VW_ADMIN_TOKEN%%/${VW_ADMIN_TOKEN}/g'
	find build/files -type f -print0 | xargs -0 sed -i 's/%%PAPERLESS_SECRET_KEY%%/${PAPERLESS_SECRET_KEY}/g'
	find build/files -type f -print0 | xargs -0 sed -i 's/%%PAPERLESS_ADMIN_PASSWORD%%/${PAPERLESS_ADMIN_PASSWORD}/g'
	find build/files -type f -print0 | xargs -0 sed -i 's/%%PAPERLESS_DBPASS%%/${PAPERLESS_DBPASS}/g'
	find build/files -type f -print0 | xargs -0 sed -i 's/%%SMTP_PASSWORD%%/${SMTP_PASSWORD}/g'
	find build/files -type f -print0 | xargs -0 sed -i 's/%%PIA_USER%%/${PIA_USER}/g'
	find build/files -type f -print0 | xargs -0 sed -i 's/%%PIA_PASS%%/${PIA_PASS}/g'
	find build/files -type f -print0 | xargs -0 sed -i 's/%%DNS_LOGIN_TOKEN%%/${DNS_LOGIN_TOKEN}/g'
	find build/files -type f -print0 | xargs -0 sed -i 's/%%VALHEIM_PASSWORD%%/${VALHEIM_PASSWORD}/g'
	butane --files-dir build/files --output build/homeserver.ign < homeserver.bu
	

serve: all
	cp -a boot.ipxe ./build/
	cd build; python3 -m http.server

clean:
	rm -rf ./build