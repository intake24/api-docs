pandoc $(Get-Content api.index) --toc --toc-depth=4 -c pandoc.css -f markdown -t html -s -o html/api-reference.html
pandoc $(Get-Content database.index) --toc --toc-depth=4 -c pandoc.css -f markdown -t html -s -o html/database.html
