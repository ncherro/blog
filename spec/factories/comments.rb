FactoryGirl.define do

  factory :comment do
    post
    content Lorem::Base.new('words', 12).output
  end

end
