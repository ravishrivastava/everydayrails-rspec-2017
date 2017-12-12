require 'rails_helper'

RSpec.describe Note, type: :model do

	it "is valid with a user, project, and message" do
		note = FactoryGirl.build(:note)
		expect(note).to be_valid
	end

	it "is invalid without a message" do
		note = FactoryGirl.build(:note, message: nil)
		note.valid?
		expect(note.errors[:message]).to include("can't be blank")
	end

	describe "search message for a term" do
		before do
			@note1 = FactoryGirl.create(:note, message: "This is the first note.")
			@note2 = FactoryGirl.create(:note, message: "This is the second note.")
			@note3 = FactoryGirl.create(:note, message: "First, preheat the oven.")
		end

		context "when a match is found" do
		  it "returns notes that match the search term" do
				expect(Note.search("first")).to include(@note1, @note3)
				expect(Note.search("first")).to_not include(@note2)
			end
		end

		context "when no match is found" do
			it "returns an empty collection when no results are found" do
				expect(Note.search("message")).to be_empty
			end
		end
	end
end
