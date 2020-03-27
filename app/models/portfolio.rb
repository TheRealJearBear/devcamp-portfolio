class Portfolio < ApplicationRecord
  validates_presence_of :title, :subtitle, :main_image, :thumb_image, :body

  def self.angular
    where(subtitle: 'Angular')
  end

  scope :ruby_on_rails, -> { where(subtitle: 'Ruby on Rails') }
  after_initialize :set_defaults

  def set_defaults
    self.main_image ||= "https://via.placeholder.com/600x400"
    self.thumb_image ||= "https://via.placeholder.com/350x200"
    ##the ||= is necessary because an = would override the image later if you already how one uploaded in there.
  end
end
