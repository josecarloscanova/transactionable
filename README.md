Transactionable Gem
====================

Overview
--------

Balanced is a marketplace platform that allows users to collect bank and credit card account information in order to carry out financial transactions without having to deal with PCI compliance issues. This gem eases the process of adding the ability to collect account information and carry out financial transactions.

Balanced Documentation & Login
------------------------------

[https://www.balancedpayments.com/](https://www.balancedpayments.com/)

Setup
-----
In your Gemfile:

```console
gem 'transactionable', '~> 0.1'
```

In your app root:
    
```console
rake transactionable:install:migrations
rake db:migrate
```

Add an initializer for your marketplace in config/initializers/balanced.rb

```ruby
# config/initializers/balanced.rb
Balanced.configure(ENV["BALANCED_TOKEN"])
```

Credit Cards
------------

### Models

Add `acts_as_credit_card_transactionable` in any model you wish to enable credit card transactions.

```ruby
class Customer < ActiveRecord::Base
  acts_as_credit_card_transactionable
end
```

Will allow you to do the following

```ruby
customer = Customer.first
customer.add_credit_card(balanced_uri)
credit_card = customer.credit_cards.first
credit_card.debit!(50)
```

Calling the `debit!` method will create a debit transaction. Continuing with the previous example, we can refund the debit to the customer by calling the `refund!` method on the debit.

```ruby
debit = credit_card.debits.first
debit.refund!
```

A refund transaction will then be added to the credit card transactions.

```ruby
credit_card.transactions
```

### Frontend Integration

To get started quickly, run `rails generate transactionable:views` which will copy a ready-to-use credit card form partial into views/transactionable/shared. As it is a barebones example, you may want to style it to fit the design of your site. However, make sure you leave all the classes on the form objects since they are used for hooking up the javascript that securely transmits user payment info to Balanced.

To use call 

```erb
<% # in app/views/customers/add_credit_card.html.erb or whatever %>
<%= render partial: "transactionable/credit_card_form", locals: { action: your_action_path } %>
```
inside your view.

If you do not wish to use the generated views, you must set up the credit card info fields with the correct classes as per the following example:

```erb
<% content_for :head do %>
  <%= javascript_include_tag "https://js.balancedpayments.com/v1/balanced.js" %>
  <%= javascript_include_tag "transactionable/add_credit_card.js" %>
<% end %>

<%= form_tag add_credit_card_path, class: "cc-info-form" do %>
  <%= text_field_tag :name_on_card, nil, class: "cc-name" %>
  <%= text_field_tag :card_number, nil, class: "cc-number" %>
  <%= text_field_tag :expiration_date, nil, class: "cc-exp-date" %>
  <%= text_field_tag :security_code, nil, class: "cc-csc" %>
  <%= text_field_tag :zip_code, nil, class: "cc-postal-code" %>
  <%= hidden_field_tag :balanced_token, nil, class: "cc-balanced-uri" %>
  <%= submit_tag "Add Credit Card", class: "submit-cc-info" %>
<% end %>

<%= javascript_tag do %>
  $(document).ready(function() {
    var marketplaceUri = "<%= Balanced::Marketplace.my_marketplace.uri %>";
    balanced.init(marketplaceUri);
  });
<% end %>
```

Assuming the view is set up correctly, pressing the submit button will make a secure javascript call to Balanced so that the credit card can be stored without ever touching Bustr servers. If the request succeeds, the balanced token field will be updated and passed along to the controller action handling the request.

### Controllers

In your controller, call the `add_credit_card(balanced_token)` method on your credit cardable object.

For example:

```ruby
class CustomersController < ApplicationController

  def add_credit_card
    @customer = Customer.find(params[:id])
    balanced_token = params[:balanced_token]

    @customer.add_credit_card(balanced_token)
    # The rest of your action logic
  end

end
```

The call to `add_credit_card` makes an API call to Balanced, so you may want to handle it asyncronously.

Bank Accounts
-------------

### Models

Include the line `acts_as_bank_account_transactionable` in any model you wish to enable bank account transactions.
    
```ruby
class Company < ActiveRecord::Base
  acts_as_bank_account_transactionable
end
```

Enables the following:

```ruby
company = Company.first
company.add_bank_account(balanced_token)
bank_account = company.bank_accounts.first
bank_account.credit!(500)
credit = bank_account.credits.first
credit.reverse!(250) # Issues a partial reversal
```

### Frontend Integration

To get started quickly, run `rails generate transactionable:views` which will copy a ready-to-use bank account form partial into views/transactionable/shared.

To use call 

```erb
<% # in app/views/customers/add_bank_account.html.erb or whatever %>
<%= render partial: "transactionable/bank_account_form", locals: { action: your_action_path } %>
```
inside your view.

If you do not wish to use the generated views, you must set up the bank account info fields with the correct classes as per the following example:

```erb
<% content_for :head do %>
  <%= javascript_include_tag "https://js.balancedpayments.com/v1/balanced.js" %>
  <%= javascript_include_tag "transactionable/add_bank_account.js" %>
<% end %>

<%= form_tag add_bank_account_path, class: "acct-info-form" do %>
  <%= text_field_tag :name, nil, class: "acct-name" %>
  <%= text_field_tag :account_number, nil, class: "acct-number" %>
  <%= text_field_tag :routing_number, nil, class: "acct-routing-number" %>
  <%= select_tag :account_type, options_for_select(["checking", "savings"]), class: "acct-type" %>
  <%= hidden_field_tag :balanced_token, nil, class: "acct-balanced-uri" %>
  <%= submit_tag "Add Bank Account", class: "submit-bank-acct-info" %>
<% end %>

<%= javascript_tag do %>
  $(document).ready(function() {
    var marketplaceUri = "<%= Balanced::Marketplace.my_marketplace.uri %>";
    balanced.init(marketplaceUri);
  });
<% end %>
```

### Controllers

In your controller, call the `add_bank_account(balanced_token)` method on your bank account transactionable object.

For example:

```ruby
class CompaniesController < ApplicationController

  def add_bank_account
    @company = Company.find(params[:id])
    balanced_token = params[:balanced_token]

    @company.add_credit_card(balanced_token)
    # The rest of your action logic
  end

end
```

Configuration Options
---------------------

### CreditCardTransactionable

If your model will only ever have a single credit card, override the `one_card?` method with a return value of true in your transactionable object.

```ruby    
class Customer
  acts_as_credit_card_transactionable

  def one_card?
    true
  end
end
```

Calling the `add_credit_card` method on this object will now destroy any credit card already associated with this object and replace it with a new one.

### BankAccountTransactionable

The `one_bank_account?` method acts in the same manner for bank accounts.
  
```ruby
class Customer
  acts_as_bank_account_transactionable

  def one_bank_account?
    true
  end
end
```