require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :status }
  it { should validate_presence_of :project_id }

  it { should belong_to :project }
end
