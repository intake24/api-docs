### Food lists

#### List root categories

`GET /admin/browse/:locale/root-categories`

#### List uncategorised foods

`GET /admin/browse/:locale/uncategorised-foods`

#### List category contents

`GET  /admin/browse/:locale/:code`

#### Get food parent categories

`GET /admin/browse/:locale/food-parent-categories/:code` 

#### Get all categories that contain a food (transitive)

`GET /admin/browse/:locale/food-all-categories/:code`

#### Get subcategory parent categories

`GET /admin/browse/:locale/category-parent-categories/:code`

#### Get all categories that contain a subcategory (transitive)

`GET /admin/browse/:locale/category-all-categories/:code`


#### Check if a food code is available

`GET /admin/foods/code-available/:code`

#### Get a food record (global + local)

`GET /admin/foods/:locale/:code`

#### Create a new food record (global)

`POST /admin/foods/new`

#### Add food to local list

`POST /admin/foods/add-to-locale` 

#### Create a new food record (local)

`POST /admin/foods/new/:locale`

#### Create a new food record with automatically generated code (global)

`POST /admin/foods/new-with-temp-code`

#### Clone a food record

`POST /admin/foods/:locale/:code/clone`

#### Clone food as local

`POST /admin/foods/:locale/:code/clone-as-local`

#### Update main food record

`POST /admin/foods/:code`

### Update local food record

`POST /admin/foods/:locale/:code`

#### Delete food record

`DELETE /admin/foods/:code`

#### Check if a category code is available

`GET /admin/categories/code-available/:code`

#### Get a category record (global + local)

`GET /admin/categories/:locale/:code`

#### Create a new category (global)

`POST /admin/categories/new`

#### Update a category record (global)

`POST /admin/categories/:code`

#### Update a category record (local)

`POST /admin/categories/:locale/:code`

#### Delete a category record

`DELETE /admin/categories/:code`
