class Band < ApplicationRecord
  validates :name, presence: true, uniqueness: true


  has_many :albums, dependent: :destroy,
    primary_key: :id,
    foreign_key: :album_id,
    class_name: :Album
end
