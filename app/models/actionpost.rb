class Actionpost < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  validates :highlight, presence:true

  validates :action, presence:true

  validates :user_id, presence: true
  
end
