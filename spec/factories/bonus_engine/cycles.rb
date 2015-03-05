FactoryGirl.define do
  factory :cycle, class: BonusEngine::Cycle do
    name 'name'
    budget 2000
    maximum_points 400
    minimum_points 1
    minimum_people 4
    msg_required true

    after(:create) do  |cycle|
      cycle.bonus_engine_users << create(:bonus_engine_user, name: 'Hugo',
                                        email: 'hugo@test.com')
      cycle.bonus_engine_users << create(:bonus_engine_user, name: 'Paco',
                                        email: 'paco@test.com')
      cycle.bonus_engine_users << create(:bonus_engine_user, name: 'Luis',
                                        email: 'luis@test.com')
    end
  end
end
