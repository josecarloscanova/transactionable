Rails.application.routes.draw do

  mount Transactionable::Engine => "/transactionable"
end
