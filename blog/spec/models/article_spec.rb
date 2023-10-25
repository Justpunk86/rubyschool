require "spec_helper"

describe Article, type: :model do
  describe "validations" do
    it { should validate_presence_of(:text)}
    it { should validate_presence_of(:title)}
    it { should validate_length_of(:text)}
    it { should validate_length_of(:title)}
  end 

  describe "associations" do
    it { should have_many(:comments)}
  end

  describe "#subject" do
    it "returns the article title" do
      #create object Aricle another variant
      article = create(:article, title: 'Lorem Ipsum')

      expect(article.subject).to eq 'Lorem Ipsum'
    end
  end  

  describe "#last_comment" do
    it "returns the last comment" do
      # create srticle with comments
      article = create(:article_with_comments)

      expect(article.last_comment.body).to eq "comment body 3"
    end
  end

end
  
