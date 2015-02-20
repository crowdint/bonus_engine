FactoryGirl.define do
  factory :point, class: 'BonusEngine::Point' do
    giver_id 1
    receiver_id 2
    quantity 500
    message "she sell seashells by the seashore"
  end
end
