class Album < ApplicationRecord
  belongs_to :band,
    primary_key: :id,
    foreign_key: :band_id,
    class_name: :User

  has_many :tracks, dependent: :destroy,
    primary_key: :id,
    foreign_key: :track_id,
    class_name: :Track

end
