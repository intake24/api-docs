### Survey management

#### List surveys

`GET /` 

#### Validate survey ID

`POST /validate-id`

#### Create survey

`POST /`

#### Get survey data

`GET /:surveyId`

#### Update survey

`PATCH /:surveyId`

#### Delete survey

`DELETE /:surveyId`

#### Add roles to users (possibly duplicated, no relevance to survey)

`POST /:surveyId/acl`

#### Remove roles from users (possibly duplicated, no relevance to survey)

`DELETE /:surveyId/acl`

### Survey user management

#### List survey staff users

`GET /:surveyId/users/staff`

#### Create or update staff users

`POST /:surveyId/users/staff`

#### List survey respondent users

`GET /:surveyId/users/respondents`

#### Create or update respondent users

`POST /:surveyId/users/respondents`

#### Upload respondent users from CSV

`POST /:surveyId/users/respondents/upload-csv`

#### Upload notification schedule CSV

`POST /:surveyId/users/notifications/upload-csv`

#### Delete users (should be merged with global)

`DELETE /:surveyId/users`

#### Create respondent user with physical profile (age, weight etc.)

`POST /:surveyId/users/respondents/with-physical-data`
