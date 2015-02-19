FactoryGirl.define do
  factory :event, :class => 'BonusEngine::Event' do
    cycle nil
    name "MyString"
    opens_at "2015-01-13"
    closes_at "2015-01-13"
  end
end
