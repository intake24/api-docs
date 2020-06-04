#!/bin/bash

pandoc $(cat api.index) --toc --toc-depth=4 -c pandoc.css -f markdown -t html -s -o html/api-reference.html
pandoc $(cat database.index) --toc --toc-depth=4 -c pandoc.css -f markdown -t html -s -o html/database.html
