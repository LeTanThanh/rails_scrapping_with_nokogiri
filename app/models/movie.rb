class Movie < ApplicationRecord
  scope :now_showing, -> { where("publish_day <= ?", Time.zone.now) }
  scope :coming_soon, -> { where("publish_day > ?", Time.zone.now) }
end
