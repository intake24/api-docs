pandoc $(Get-Content index) --toc --toc-depth=4 -c pandoc.css -f markdown -t html -s -o html/api-reference.html
