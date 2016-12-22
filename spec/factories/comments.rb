FactoryGirl.define do
  factory :comment do
    content 'succulent'
    post do 
      FactoryGirl.create(:post)
    end
    user do 
      User.first
    end  
  end
end
