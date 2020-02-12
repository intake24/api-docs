#### Browsing the food database (for admin tool)

### List root categories

`GET /admin/browse/:locale/root-categories`

### List uncategorised foods

`GET /admin/browse/:locale/uncategorised-foods`

### List category contents

`GET  /admin/browse/:locale/:code`

### Get food parent categories

`GET /admin/browse/:locale/food-parent-categories/:code` 

### Get all categories that contain a food (transitive)

`GET /admin/browse/:locale/food-all-categories/:code`

### Get subcategory parent categories

`GET /admin/browse/:locale/category-parent-categories/:code`

### Get all categories that contain a subcategory (transitive)

`GET /admin/browse/:locale/category-all-categories/:code`


