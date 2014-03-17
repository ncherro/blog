FactoryGirl.define do
  sequence :title do |n|
    "title #{n}"
  end

  trait :with_comments do
    after(:build) do |post|
      rand(6..20).times do
        post.comments << FactoryGirl.build(:comment, post: post)
      end
    end
  end

  factory :post do
    title
    copy Lorem::Base.new('paragraphs', 6).output
    pub_date Date.current
  end

end
