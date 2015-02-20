FactoryGirl.define do
  factory :cycle, class: BonusEngine::Cycle do
    name 'name'
    budget 2000
    maximum_points 400
    minimum_points 1
    minimum_people 4
    msg_required true
  end
end
