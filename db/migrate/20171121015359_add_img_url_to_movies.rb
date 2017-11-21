class AddImgUrlToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :img_url, :string
  end
end
