FactoryGirl.define do
  sequence(:name) {|n| "AlphaGo#{n}" }
  factory :site do
    name 'AlphaGo'
    address 'Taipei city'
    duration '12'
    tel '02-8888-8888'
    user do
     User.find_by_email("howard@alpha.com")
    end

    factory :hot_site do
      hotspot true
    end
  end
end
