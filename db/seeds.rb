10.times do
  FactoryGirl.create(:tag)
end

tags = Tag.all
10.times do
  FactoryGirl.create(:post, tags: tags.shuffle[0..rand(1..5)])
end
