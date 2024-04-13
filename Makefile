include secrets

all:
	rm -rf ./build/
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
	podman run -i --rm --security-opt label=disable --volume .:/pwd --workdir /pwd quay.io/coreos/butane:release --files-dir build/files --strict --output build/homeserver.ign < homeserver.bu

clean:
	rm -rf ./build