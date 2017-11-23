class Post < ActiveRecord::Base
  mount_uploader :photo, ImgUploader
  belongs_to :user #references로 만들어서
end
