

> 11월 21일



### 왓챠 평점 시스템 만들어보기

- watcha 프로젝트 생성 후 movie 컨트롤러, 모델 생성(scaffold)

  `rails new watcha --skip-bundle`

  `bundle install`

  `rails g scaffold movie title desc:text`

  `rake db:migrate`

- devise 생성

  `gem 'devise'`

  `rails g devise:install`

  - config/environments/development.rb

  ```ruby
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  ```

  `rails g devise user`

  `rake db:migrate`

- image uploader 생성

  `gem 'carrierwave', '~> 1.0'`

  `rails g uploader photo`

- movie 모델에 user_id, img_url (string) 칼럼 새로 추가

  `rails g migration add_user_id_to_movies user_id:integer`

  `rails g migration add_img_url_to_movies img_url:string`

  `rake db:migrate`

- model file : uploader mount

  ```ruby
  class User < ActiveRecord::Base
    mount_uploader :img_url, PhotoUploader
  end
  ```



- 국제화

  `gem 'devise-i18n'`

  config > application.rb 에서 두가지 커멘트 아웃

  ```ruby
  config.time_zone = 'Seoul'
  config.i18n.default_locale = :ko
  ```

  `rails g devise:i18n:locale ko`

  `rails g devise:i18n:views`

  ​

- 왓챠 boxoffice.json 크롤링 (watcha.rb)

  ```ruby
  require 'httparty'
  require 'rest-client'
  require 'json'
  require 'awesome_print'
  require 'csv'

  headers = {
    cookie: ""
  }

  res = HTTParty.get(
    "https://watcha.net/boxoffice.json",
    :headers => headers
  )

  watcha = JSON.parse(res.body)

  list = watcha['cards']

  list.each do |item|
    movie = item["items"].first["item"]
    title = movie["title"]
    image = movie["poster"]["large"]
    desc = movie["interesting_comment"]["text"] if movie["interesting_comment"]
    CSV.open("movie_list.csv", "a+") do |csv|
      csv << [title, image, desc]
    end
  end

  ```

- seeds.rb 에서 크롤링 데이터 넣기

  ```ruby
  require 'csv'

  CSV.foreach(Rails.root.join('movie_list.csv')) do |row|
    Movie.create(
      title: row[0],
      remote_img_url_url: row[1],   # remote_컬럼명_url:로 해야 이미지가 보임
      desc: row[2]
    )
  end
  ```

  `rake db:seed`

- review 모델 생성 (댓글 기능 추가하려고)

  `rails g model review movie:references comment:text rating:integer user:references`

  `rake db:migrate`

- review controller 생성

  `rails g controller reviews create`





#### Rails.root.join()

```ruby
pry(main)> Rails.root.join('app', 'views')
=> #<Pathname:/Users/Dahye/dev/ruby/project/watcha/app/views>
```





- role 컬럼추가 (admin계정추가)

  `rails g migration add_role_to_users role:string`

  `rake db:migrate`

- user 콘솔창에서 추가하기 (admin, regular)

  `> User.create email: "admin@asdf.com", password: "123123", password_confirmation: "123123", role: "admin"`

  `>User.create email: "regular@asdf.com", password: "123123", password_confirmation: "123123", role: "regular"`

- 권한설정

  - user.rb

  ```ruby
    def admin?
      if role == "admin"
        true
      else
        false
      end
    end
  ```

- cancancan

  `gem 'cancancan', '~> 2.0'`

  `rails g cancan:ability`

  - model > ability.rb

    ```ruby
        user ||= User.new # guest user (not logged in)
          if user.admin?
            can :manage, Movie
          else
            can :read, Movie
          end
    ```

  - movies_controller

    ```ruby
    load_and_authorize_resource
    ```





### heroku cli 설치

```
$ brew install heroku/brew/heroku
```

- login > heroku login

- gemfile

  ```ruby
  gem 'rails_12factor', group: :production
  gem 'pg', group: :production #postgres 사용하게 해주는 젬

  gem 'sqlite3', group: :development # 개발그룹으로 옮김
  ```

  ​

