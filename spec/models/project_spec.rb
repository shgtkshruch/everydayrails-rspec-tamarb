require 'rails_helper'

RSpec.describe Project, type: :model do
  # ユーザー単位では重複したプロジェクト名を許可しないこと
  it "does not allow duplicate project names per user" do
    project_name = 'Read Everyday RSpec'
    user1 = User.create(
      first_name: "Aaron",
      last_name:  "Sumner",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze"
    )

    user1.projects.create(name: project_name)
    project = user1.projects.create(name: project_name)

    project.valid?
    expect(project.errors['name']).to include("has already been taken")
  end

  # 二人のユーザーが同じ名前を使うことは許可すること
  it "allows two users to share a project name" do
    project_name = 'Read Everyday RSpec'
    user = User.create(
      first_name: "Aaron",
      last_name:  "Sumner",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze"
    )

    other_user = User.create(
      first_name: "Tom",
      last_name:  "Sumner",
      email:      "tester-tom@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze"
    )

    user.projects.create(name: project_name)
    other_project = other_user.projects.create(name: project_name)

    expect(other_project).to be_valid
  end
end
