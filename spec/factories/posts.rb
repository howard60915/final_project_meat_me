FactoryGirl.define do
  sequence(:title) {|n| "AlphaGo#{n}" }
  factory :post do
    title 'AlphaGo'
    content 'succulent plants rocks'
    user do 
      FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
    end  

    factory :post_of_photo do
        photo { File.open("#{Rails.root}/spec/photos/5fpro.png") }
    end
  end
end
