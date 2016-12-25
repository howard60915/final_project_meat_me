FactoryGirl.define do
  factory :plant do
    name 'hedgehog cactus'
    description 'live in dessert'
    
    factory :white_dragan do
      description '白龍丸'
    end

    factory :other_plant do
      name 'other'
    end

    factory :other_plant_answer do
      name 'other'
      description '熊童子'
    end

    factory :post_of_picture do
        picture { File.open("#{Rails.root}/spec/photos/5fpro.png") }
    end

  end
end
