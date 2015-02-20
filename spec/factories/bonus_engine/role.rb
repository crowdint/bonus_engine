FactoryGirl.define do
  factory :user_role, class: 'Role' do
    name "bonus_user"
  end

  factory :admin_role, class: 'Role' do
    name "bonus_admin"
  end

  factory :owner_role, class: 'Role' do
    name "bonus_owner"
  end
end
