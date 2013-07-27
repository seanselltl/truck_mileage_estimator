# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :estimate do
    origin_latitude "9.99"
    origin_longitude "9.99"
    destination_latitude "9.99"
    destination_longitude "9.99"
    miles 1
  end
end
