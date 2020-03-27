class Portfolio < ApplicationRecord
  validates_presence_of :title, :subtitle, :main_image, :thumb_image, :body
end
