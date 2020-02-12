## User-facing food data

### Food search

#### Find food by description (regular foods)

`GET /foods/:locale/lookup`

#### Find food by description (recipe ingredients)

`GET /foods/:locale/lookup-for-recipes`

#### Find food by description (limit to specific category)

`GET /foods:locale/lookup-in-category`

#### Suggest splitting into several foods

`GET /foods/:locale/split-description`

### Food browsing

#### List root categories

`GET /categories/:locale`

#### Get category contents

`GET /categories/:locale/:code`

### Portion size estimation

#### Get food data (portion size estimation methods)

`GET /foods/:locale/:code`

#### Get food data (portion size estimation methods, trace data source)

`GET /foods/:locale/:code/with-sources`

#### Get brand names

`GET /foods/:locale/:code/brand-names`

#### Get weight type-in portion size method (dummy)

`GET /portion-size/weight`

#### Get as served image set data 

`GET /portion-size/as-served/:id`

#### Get multiple as served image sets data

`POST /portion-size/as-served`

#### Get guide image data

`GET /portion-size/guide-image/:id`

#### Get image map data

`GET /portion-size/image-maps/:id`

#### Get multiple image maps data

`POST /portion-size/image-maps`

#### Get drinkware set data

`GET /portion-size/drinkware/:id`

#### Get associated foods (manual)

`GET /foods/:locale/:code/associated-foods`

#### Get associated foods (automatic)

`GET /foods/associated/:locale`


### Food composition

#### Get Food composition data

`GET /foods/:locale/:code/composition`

### Dietary feedback

#### Get five a day feedback rules

`GET /feedback/five-a-day`

#### Get food group feedback rules

`GET /feedback/food-groups`

## User profile management

#### Update your user's profile

`PATCH /my-profile`

#### Get your user's physical data (age, weight, etc.)

`GET /my-physical-data`

#### Update your user's physical data (age, weight, etc.)

`PATCH /my-physical-data`


## Analytics

### UX event tracking

#### Log UX event

`POST /event`
