## Authentication

Intake24 uses a two-stage authentication system that is based on two classes of authentication tokens called refresh and
access tokens.

**Refresh tokens** are issued through a credentials (i.e. user name and password) based authentication procedure.
Refresh tokens are similar to the traditional API keys in that they are long-lived and must be stored securely by the
API client for long-term use once the credentials have been authenticated.

**Access tokens** are required to access the actual API endpoints. Access tokens are obtained by presenting a valid
refresh token to the server. They are short-lived; the exact validity period depends on the server configuration but is
typically 10 minutes up to 2 hours. They cannot be extended and a new token must be obtained if the previous one has
expired.
    
See <https://auth0.com/blog/refresh-tokens-what-are-they-and-when-to-use-them/> for an in-depth explanation of the
refresh/access token system.

### Signing in using a global account

To obtain a *refresh* token for a global system account (e.g. admin or survey staff), `POST` a sign in request to

`/signin`

with the following JSON body:

~~~ {.json}
{
  "email": "john@smith.com",
  "password": "password123"
}
~~~

where

* *email* is the user's system-wide e-mail address
* *password* is the user's password
        
##### Response

* `HTTP 200 OK`: successful authentication.

  The body is a JSON object containing a single field, *refreshToken*: 
  
  ~~~ {.json} 
  {
    "refreshToken": "(refresh token in JWT format)"
  }
  ~~~

  **NOTE:** The application must cache the refresh token **securely** for long-term use. 
  
* `HTTP 401 Unauthorized`: the provided credentials were not recognised.

### Signing in using a survey alias

To obtain a *refresh* token for a survey respondent using their internal survey alias, `POST` a sign in request to
          
`/signin/alias`
          
with the following JSON body:

~~~ {.json}
{
  "surveyId": "my_survey",
  "userName": "user1",
  "password": "password123"
}
~~~

where

* *survey_id* is the survey id for the user that you are signing in as (user names are unique w.r.t individual surveys,
  but not system-wide).
* *username* is the survey user ID (does not have to be unique system-wide)
* *password* is the user's password

##### Response

* `HTTP 200 OK`: successful authentication.
  The body is a JSON object containing a single field, *refreshToken*: 
  
  ~~~ {.json}
  {
    "refreshToken": "(refresh token in JWT format)"
  }
  ~~~

  **NOTE:** The application must cache the refresh token **securely** for long-term use.
 
* `HTTP 401 Unauthorized`: the provided credentials were not recognised.

### Signing in using an URL-embedded token

To obtain a *refresh* token for a survey respondent using the URL-embedded authentication token, `POST` a sign in
request to

`/signin/token/<token>`

where

* *token* is the user's personal authentication token

##### Response

* `HTTP 200 OK`: successful authentication.
  The body is a JSON object containing a single field, *refreshToken*: 
  
  ~~~ {.json}
  {
    "refreshToken": "(refresh token in JWT format)"
  }
  ~~~

  **NOTE:** The application must cache the refresh token securely for long-term use.
 
* `HTTP 401 Unauthorized`: the provided credentials were not recognised.

### Refreshing the access token

To obtain a new *access* token, `POST` a refresh request to

`/refresh`

with an empty body and the value of a valid *refresh* token in the `X-Auth-Token` header.

##### Response

* `HTTP 200 OK`: successful access token renewal.
  
  The body is JSON object containing a single field, *accessToken*: 

  ~~~ {.json}
  {
    "accessToken": "(access token in JWT format)"
  }
  ~~~
  
  **NOTE**: The application **must cache and reuse** the access token until it is rejected with the `HTTP 401
  Unauthorized` code, in which case the application must request a new access token using this end-point and retry the
  affected request. Existing access tokens are automatically expired and do not need to be de-activated explicitly.

* `HTTP 401 Unauthorized`: the refresh token is missing or invalid.
    
### Using the access token

Any API request that requires authentication (nearly all of them at the moment) must include the access token exactly as
returned by the server.

The token should be sent in the `X-Auth-Token` header.
      
The `HTTP 401 Unauthorized` response must be expected for any API request. To correctly handle this response, the
application must [request a new access token](#refreshing-the-access-token) and retry the request.
