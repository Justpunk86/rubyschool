require "spec_helper"

describe Article, type: :model do
  describe "validations" do
    it { should validate_presence_of(:text)}
    it { should validate_presence_of(:title)}
  end 

  describe "associations" do
    it { should have_many(:comments)}
  end

  describe "#subject" do
    it "returns the article title" do
      #create object Aricle another variant
      aricle = create(:article, title: 'Lorem Ipsum')

      expect(aricle.subject).to eq 'Lorem Ipsum'
    end
  end     
end
  
