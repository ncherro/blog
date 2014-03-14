class Post < ActiveRecord::Base

  has_and_belongs_to_many :tags
  has_many :comments, dependent: :destroy

  class << self
    def ordered
      order('pub_date DESC')
    end
  end

end
