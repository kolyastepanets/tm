class Task < ActiveRecord::Base
  validates :name, :status, :project_id, presence: true

  belongs_to :project
end
