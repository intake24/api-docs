### Data consistency checks

#### Check food record

`GET /admin/foods/:locale/:code/problems`

#### Check category record

`GET /admin/categories/:locale/:code/problems`

#### Check category recursively (including all subcategories and foods)

`GET /admin/categories/:locale/:code/recursive-problems`
