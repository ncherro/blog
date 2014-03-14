FactoryGirl.define do

  factory :comment do
    post
    comment Lorem::Base.new('paragraphs', 1).output
  end

end
