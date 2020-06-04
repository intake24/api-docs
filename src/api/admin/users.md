### User management

#### Find users

`GET /`

#### Create user

`POST /`

#### Delete user

`DELETE /:userId`

#### Update user's profile (name, e-mail, phone etc.)

`PATCH /:userId`

#### Update user's password

`PATCH /:userId/password`

#### Update user's physical data

`PATCH /:userId/physical-data`

#### Delete multiple users

`POST /delete`

#### Request password reset

`POST /password-reset-request`

#### Confirm password reset

`POST /reset-password`