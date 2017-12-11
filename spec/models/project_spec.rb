require 'rails_helper'

RSpec.describe Project, type: :model do

	before do
		@user = User.create(
			first_name: "Joe",
			last_name: "Tester",
			email: "joetester@example.com",
			password: "dottle-nouveau-pavilion-tights-furze",
		)

		@user.projects.create(
			name: "Test Project",
		)
	end

  it "does not allow duplicate project names per user" do
		new_project = @user.projects.build(
			name: "Test Project",
		)
		new_project.valid?
		expect(new_project.errors[:name]).to include("has already been taken")
	end

	it "allows two users to share a project name" do
		other_user = User.create(
			first_name: "Ravi",
			last_name: "Shrivastava",
			email: "rsravishri30@gmail.com",
			password: "Tester123",
		)

		other_project = other_user.projects.build(
			name: "Test Project",
		)

		expect(other_project).to be_valid
	end
end
