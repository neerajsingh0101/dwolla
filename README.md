# Dwolla Ruby Gem

A Dwolla API wrapper in Ruby.

## Installation

gem install dwolla

## Resources

* View Source on GitHub (https://github.com/jeffersongirao/dwolla)
* Report Issues on GitHub (https://github.com/jeffersongirao/dwolla)

#### Users API

##### With Access Token

```ruby
  user = Dwolla::User.me(ACCESS_TOKEN).fetch
```

##### With Client ID and Secret

```ruby
  client = Dwolla::Client.new(CLIENT_ID, SECRET)
  user = client.user(ACCOUNT_ID) # Dwolla account identifier or email address of the Dwolla account.
```

#### Balance API

```ruby
  user = Dwolla::User.me(ACCESS_TOKEN).fetch
  user.balance
```

#### Contacts API

##### User Contacts

```ruby
  user = Dwolla::User.me(ACCESS_TOKEN).fetch

  # limit default is 10
  # max limit is 200

  # type default is "Dwolla"
  # type can be "All", "Twitter", "Facebook", "LinkedIn" and "Dwolla"

  user.contacts(:search => "Bob", :type => "Dwolla", :limit => 5)
```

#### Transactions API

##### Sending Money

```ruby
  user = Dwolla::User.me(ACCESS_TOKEN).fetch
  other_user_id = 'sample@user.com' # or the Dwolla account id
  pin = '1234'
  amount = 200

  user.send_money_to(other_user_id, amount, pin)
```

##### Requesting Money

```ruby
  user = Dwolla::User.me(ACCESS_TOKEN).fetch
  other_user_id = 'sample@user.com' # or the Dwolla account id
  pin = '1234'
  amount = 200

  user.request_money_from(other_user_id, amount, pin)
```
