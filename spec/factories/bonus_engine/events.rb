FactoryGirl.define do
  factory :event, :class => 'BonusEngine::Event' do
    cycle nil
    name "MyString"
    opens_at Date.today.at_beginning_of_month
    closes_at Date.today.at_end_of_month
  end
end
