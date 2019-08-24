require 'rails_helper'

RSpec.describe Note, type: :model do
  # 文字列に一致するメッセージを検索する
  describe "search message for a term" do

    # 一致するデータが見つかるとき
    context "when a match is found" do
      # 検索文字列に一致するメモを返すこと
      it "returns notes that match the search term" do
        user = User.create(
          first_name: "Aaron",
          last_name:  "Sumner",
          email:      "tester@example.com",
          password:   "dottle-nouveau-pavilion-tights-furze"
        )

        project = user.projects.create(name: "Test Project")

        note1 = project.notes.create(
          message: 'This is the first note.',
          user: user
        )

        note2 = project.notes.create(
          message: 'This is the second note.',
          user: user
        )

        note3 = project.notes.create(
          message: 'First, preheat the oven..',
          user: user
        )

        expect(Note.search("first")).to include(note1, note3)
        expect(Note.search("first")).to_not include(note2)
      end
    end

    # 一致するデータが1件も見つからないとき
    context "when no match is found" do
      # 検索結果が1件も見つからなければ空のコレクションを返すこと
      it "returns an empty collection when no results are found" do
        user = User.create(
          first_name: "Aaron",
          last_name:  "Sumner",
          email:      "tester@example.com",
          password:   "dottle-nouveau-pavilion-tights-furze"
        )

        project = user.projects.create(name: "Test Project")

        note1 = project.notes.create(
          message: 'This is the first note.',
          user: user
        )

        note2 = project.notes.create(
          message: 'This is the second note.',
          user: user
        )

        note3 = project.notes.create(
          message: 'First, preheat the oven..',
          user: user
        )

        expect(Note.search("tamarb")).to be_empty
      end
    end
  end
end
