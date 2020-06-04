# Intake24 food database reference

The current version of Intake24 food database was derived from an older database called “IPSAS” (Interactive Portion Size Assessment System). Originally, the food database was designed to be used in the UK only and did not support localisation in any form. Over time some internationalisation features were added on top of the UK food database allowing to expand the food database to additional regions, however the core structure remained the same.

Intake24 food database consists of a list of foods organised into categories. 

Food records in Intake24 are split into two parts: *main* records that contain data shared across all locales in the system, and *local* records that contain data relevant to a specific region. There can be multiple local records associated with a main record, however only one local record is allowed per locale.

## Main food records

Main food records are stored in the following tables:

### foods

This is the core table containing all foods in Intake24.

* **code**: unique food code consisting of up to 8 characters.
* **description**: English name/description of the food (only used in the admin tool, respondent front-end always uses local description).
* **food_group_id**: NDNS food group ID (obsolete).
* **version**: Record version UUID. Used to resolve concurrent change conflicts when editing food records.

### foods_attributes

Has 1:1 relationship with foods via *food_code*.

* **same_as_before_option**: enable "same as before" feature in respondent frontend for this food.
* **ready_meal_option**: show "was it a ready meal" question for this food in respondent frontend.
* **reasonable_amount**: if reported portion size is greater that this amount (g for solid foods/ml for liquids), this food will be flagged for review in system output.
* **use_in_recipes**: show this food when searching for recipe ingredients.


### foods_categories

Many-to-many relationship between foods and categories via *food_code* and *category_code*. A record (X, Y) in this table means that food X is in the category Y. Foods can be listed in multiple categories at the same time.

## Local food records

Intake24 local food records contain data relevant to a specific geographical region or a subset of population. Local food records are required to define the following: 

* Description of the food in the local language.
* A list of portion size estimation methods.
* One or more references to a food composition table record for nutrient mapping.

Local food records are stored in the following tables:

### foods_local

Has one-to-many relationship with foods via *food_code*.

* **locale_id**: Locale identifier
* **local_description**: Description in the local language
* **simple_local_description**: Description with diacritical marks (umlauts, accents, cedillas etc.) stripped out. Used for search function in the admin tool to allow finding foods using simple characters (i.e. ones available in English keyboard layout) only.
* **version**: Record version UUID. Used to identify concurrent changes to food records.

### foods_local_lists

One-to-many relationship with foods via *food_code*. A record (X, Y) in this table means that food X should be included in locale Y. If there is no such record than food X is ignored in locale Y and will not be able to be reported by study participants.

### foods_nutrient_mapping

One-to-many relationship with foods via *food_code*. 

* **locale_id**: Locale identifier 
* **nutrient_table_id**: Food composition table identifier
* **nutrient_table_record_id**: Food composition table record identifier

### foods_portion_size_methods

One-to-many relationship with foods via *food_code*.

* **locale_id**: Locale identifier
* **method**: Portion size estimation method identifier, e.g. "as-served", "guide-image"
* **description**: Portion size method description key, e.g. "use_an_image", "teaspoons" (NOT free text)
* **image_url**: Link to the thumbnail image for portion size estimation method selection screen
* **use_for_recipes**: Whether this portion size estimation method can be used for recipe ingredients
* **conversion_factor**: Weight adjustment factor for estimation methods that use images of different foods

## Category records

Category records in Intake24 are similarly comprised of main and local parts. Main category records are stored in the following tables:

### categories

* **code**: Unique category code, up to 8 characters long. The code space is not shared with food codes, that is a category can have the same code as a food and that will not cause issues.
* **description**: English category description, similarly to the English food description only used in the admin tool
* **is_hidden**: If a category is hidden it will not appear in any search results or in the category browsing interface in the respondent front-end. Used for special categories such as "Milk in hot drinks", "Sandwich ingredients" etc.
* **version**:  Record version UUID. Used to resolve concurrent change conflicts when editing food records.

### categories_attributes

Similar to `foods_attributes` and used to provide default attributes values for all foods in a category. Individual food records can either inherit these values from their parent category or specify their own.

### categories_categories

Many-to-many relationship between categories and subcategories. A record (X, Y) in this table means that the category X is a subcategory of category Y. Subcategories can be listed in multiple parent categories at the same time, however cyclic relationships are not allowed, that is a subcategory cannot contain any of its parent categories.

## Local category records

### categories_local

Similar to `foods_local` but for category records

### foods_portion_size_methods

Simlar to `foods_portion_size_methods` and used to provide default portion size estimation methods for foods in a category. Individual food records can either inherit these values from their parent category or specify their own.

## Portion size method resolution

Portion size estimation method definition for individual foods can often be omitted in Intake24 for efficiency. If a local food record has no portion size estimation methods defined, the system will try to find suitable estimation methods by going up the category hierarchy (starting with the lexicographically first direct parent, then next direct parent, then the first parent of the first parent etc.)

If there are no estimation methods defined for either the food or any of its parent categories in the current locale, the system will apply the same process for the prototype locale (`prototype_locale_id` field in `locales` table), starting with the food records and going up the category hierarchy in the prototype locale.
