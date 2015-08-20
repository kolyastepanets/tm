class Task < ActiveRecord::Base
  validates :name, :project_id, presence: true

  belongs_to :project

  default_scope { order('created_at ASC') }
end
