class Movie < ActiveRecord::Base
  mount_uploader :img_url, PhotoUploader
  has_many :reviews

  def avg
    total = 0
    reviews.each do |r|
      total += r.rating
    end
    if reviews.count == 0
      0
    else
      total.to_f / reviews.count
    end
  end

end
