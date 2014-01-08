# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transactionable_credit_card, :class => 'CreditCard' do
    credit_cardable_id 1
    credit_cardable_type "MyString"
    name "MyString"
    description "MyString"
    last_four 1
    brand "MyString"
    expiration_month 1
    expiration_year 1
    expiration_date "2014-01-08"
  end
end
