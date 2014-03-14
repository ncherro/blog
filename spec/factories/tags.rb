FactoryGirl.define do
  sequence :name do |n|
    "name #{n}"
  end

  factory :tag do
    name
  end
end
