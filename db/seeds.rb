3.times do
  FactoryGirl.create(:user)
end

10.times do
  FactoryGirl.create(:tag)
end

users = User.all
tags = Tag.all
d = Date.current
200.times do
  FactoryGirl.create(:post, :with_comments,
    tags: tags.shuffle[0..rand(1..5)],
    user: users.sample,
    copy: Lorem::Base.new('paragraphs', 6).output.split("\n\n").shuffle[0..2].join("\n\n"),
    pub_date: (d - rand(1..365).days)
  )
end
