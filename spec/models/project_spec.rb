require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_presence_of :name }

  it { should belong_to :user }

  it { should have_many(:tasks).dependent(:destroy) }
end
