FactoryGirl.define do
  factory :user do
    name "user"
    email "user@mail.com"

    after(:create) do |user|
      user.roles << FactoryGirl.create(:user_role)
    end
  end

  factory :admin_user, class: 'User' do
    name "admin"
    email "admin@mail.com"

    after(:create) do |user|
      user.roles << FactoryGirl.create(:admin_role)
    end
  end

  factory :owner_user, class: 'User' do
    name "owner"
    email "owner@mail.com"

    after(:create) do |user|
      user.roles << FactoryGirl.create(:owner_role)
    end
  end

end
