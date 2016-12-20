FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@alpha.com" }
  factory :user do
    email 'howard@alpha.com'
    password '12345678'
    
    factory :auth_user do
      authentication_token "12345678"
    end

    factory :admin_user do
      admin true
    end
  end
end
