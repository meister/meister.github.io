#!/usr/bin/env bash

npx meister |
	sed -E 's/\[39m/<\/span>/g' |
	sed -E 's/\[90m/<span class="color-90">/g' |
	sed -E 's/\[38\;5\;([0-9]+)m/<span class="color-\1">/g' > index.html