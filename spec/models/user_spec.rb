require 'rails_helper'

describe User, type: :model do
  it { is_expected.to have_many :items }
  it { is_expected.to have_many :requested_items }
end
