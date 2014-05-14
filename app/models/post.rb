class Post < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :comments, dependent: :destroy

  validates :title, :slug, :copy, :pub_date, :user, presence: true

  before_validation :set_slug_and_pubdate

  class << self
    def ordered
      order('pub_date DESC')
    end
  end

  private
  def set_slug_and_pubdate
    self.pub_date = Date.current if pub_date.blank?
    self.slug = title.parameterize if slug.blank?
  end

end
