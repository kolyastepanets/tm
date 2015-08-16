class Project < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :user

  has_many :tasks, dependent: :destroy

  default_scope { order('created_at ASC') }
end
