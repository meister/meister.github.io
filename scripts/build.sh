#!/usr/bin/env bash

workdir=${GITHUB_WORKSPACE:-.}

cat "${workdir}/_top.md" > "${workdir}/index.md"

npx meister |
	sed '/^$/d' |
	sed 's/[[:blank:]]{2,}$/  /' |
	# sed 's|$|<br/>|' |
	sed -E 's/\[39m/<\/span>/g' |
	sed -E 's/\[90m/<span class="color-90">/g' |
	sed -E 's/\[38\;5\;([0-9]+)m/<span class="color-\1">/g' \
	>> "${workdir}/index.md"

cat "${workdir}/_bottom.md" >> "${workdir}/index.md"
