class Task < ActiveRecord::Base
  validates :name, :project_id, presence: true

  belongs_to :project

  default_scope { order('position') }

  acts_as_list scope: :project
end
