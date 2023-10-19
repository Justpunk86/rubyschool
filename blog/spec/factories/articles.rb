FactoryBot.define do
  factory :article do
    title {"Article title"}
    text {"Article text"}

  # create factory name article_with_comments
  # for articles with some comments
    factory :article_with_comments do
      after :create do |article, evaluator|
        create_list :comment, 3, article: article
      end
    end
  end

end