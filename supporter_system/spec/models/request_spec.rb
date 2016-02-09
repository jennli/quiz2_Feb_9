require 'rails_helper'

RSpec.describe Request, type: :model do
  describe "validations" do
    # it is a method that
    # takes a test example description and
    # a block of code where you can construct your test
    # every test scenario must be put with in an 'it' or 'specify' block
    it "doesn't allow creating a request with no name" do
      # Given:
      r = Request.new

      #when
      r_valid = r.valid?

      #Then: expect that campaign_valid = false
      expect(r_valid).to eq(false)

    end
    it "requires a department" do
      #given
      r = Request.new

      # When
      r.valid?

      # Then
      expect(r.errors).to have_key(:department)
    end

  end
end
