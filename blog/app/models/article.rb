class Article < ApplicationRecord
  validates :title, presence: true
  validates :text, presence: true
  has_many :comments
  validates :title, length: {maximum: 140}
  validates :text, length: {maximum: 4000}

  def subject
    title
  end

  def last_comment
    comments.last
  end   
end
