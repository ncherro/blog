FactoryGirl.define do
  sequence :title do |n|
    "title #{n}"
  end

  factory :post do
    title
    copy Lorem::Base.new('paragraphs', 6).output
    pub_date Date.current
  end
end
