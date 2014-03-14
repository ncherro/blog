10.times do
  FactoryGirl.create(:tag)
end

tags = Tag.all
d = Date.current
20.times do
  d -= 1.day
  FactoryGirl.create(:post,
    tags: tags.shuffle[0..rand(1..5)],
    pub_date: d
  )
end
