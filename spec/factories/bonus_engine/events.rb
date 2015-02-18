FactoryGirl.define do
  factory :event, :class => 'BonusEngine::Event' do
    cycle nil
    name "MyString"
    opens_at "2015-01-13"
    closes_at "2015-01-13"
    budget 2000
    maximum_points 400
    minimum_points 1
    minimum_people 4
    msg_required true
  end
end
