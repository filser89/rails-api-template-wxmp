# Amigo Api
### **Amigo** Pet Adoption platform, rebuild from **_Dogether_**

##### make sure get the two files **master.key** && **secrets.yml** and saved under api/config
  - the API key and wx APP ID are in **secrets.yml**

#### run local server
```bash
git clone git@github.com:kittinson/Amigo.git
cd Amigo/api
bundle install
rails db:environment:set RAILS_ENV=development
rails db:create db:migrate db:seed
rails s
```

```ruby
# each API call must include API-Key in request headers
# only /api/v1/users/wx_login do not need X-Auth-Token in request headers
# after wx_login, user returned with an auto_token, after that, every API request will include the auth_token in header as X-Auth-Token
# the auth_token used to indentify a user from DB, in each controlers the method current_user is the user made the API request
# User has a instance method #token to generate a token for test, User.first.token => token string
```
#### Architecture
  - MVC S
  - S is service, wechat open id, images upload, token ... are in app/services
  - Actually no V, directlly render json in controllers, two instance methods in model return hash for json format, Model#index_hash, Model#show_hash
  - Tweak the index_hash and show_hash methods OR add more similar methods to return the data needed in MP. It's better to return all needed data in an API call

#### design
- https://www.figma.com/file/rPQzXeUtbZvZjR93FtMcg0/amigosadoption?node-id=0%3A1

#### APIs
##### all API calls making CUD in database must be POST (Create / Delete) / PUT (Update)
##### only API calls Read from database can be GET

- login POST /api/v1/users/wx_login, params[:code], code from wechat login in MP

- add / remove favorited pet POST with params[:pet_id]
  - /api/v1/users/favorite
  - /api/v1/users/un_favorite

- user profile
  - GET /api/v1/users/:id, return with all the following data
    - list my pets
    - list my favorited pets
    - list applied pets
    - received adoption applications
    - sent adoption applications
    - my adoption agreements

- edit user profile POST /api/v1/users/update_profile

- send adoption agreement
  - rescuer: with rescuer info & pet info
  - not rescuer: send with pet info only

- Pet index GET /api/v1/pets
  - view filtered pets GET /api/v1/pets?adopted=false&spayed=true&relocate=true
  - pets of the week, dogs, cats, others
    - GET /api/v1/pets?featured=true

- add a pet POST /api/v1/pets, params[:pet]

- Pet show GET /api/v1/pets/:id
  - pet and owner's info
  - adoption applications
  - QR code poster
  - favorite / un_favorite a pet

- edit a pet PATCH/PUT /api/v1/pets/:id, params[:pet]
  - update pet how got adopted

- update pet reviewed times POST /api/v1/pets/viewed, params[:pet_id]

- Workers
  - WX notifications - if pet not updated for 1 month - Is adopted - please update or download poster to share
  - others ?
- Other features
  - I18n
  - Generate contract pdf and download
  - Count how many times contacts pdf got downloaded





