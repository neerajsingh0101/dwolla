# Dwolla Ruby Gem

A Dwolla API wrapper in Ruby.

## Installation

gem install dwolla

## Resources

* View Source on GitHub (https://github.com/jeffersongirao/dwolla)
* Report Issues on GitHub (https://github.com/jeffersongirao/dwolla/issues)

#### Users API

##### With Access Token 

( Auth Scope Required: accountinfofull )

```ruby
  user = Dwolla::User.me(ACCESS_TOKEN).fetch
```

##### With Client ID and Secret 

( Auth Scope Required : none )

```ruby
  client = Dwolla::Client.new(CLIENT_ID, SECRET)
  user = client.user(ACCOUNT_ID) # Dwolla account identifier or email address of the Dwolla account.
```

#### Balance API 

( Auth Scope Required : balance )

```ruby
  user = Dwolla::User.me(ACCESS_TOKEN)
  user.balance
```

#### Contacts API

##### User Contacts 

( Auth Scope Required : contacts)

```ruby
  user = Dwolla::User.me(ACCESS_TOKEN)

  # limit default is 10
  # max limit is 200

  # type default is "Dwolla"
  # valid types are "All", "Twitter", "Facebook", "LinkedIn" and "Dwolla"

  user.contacts(:search => "Bob", :type => "Dwolla", :limit => 5)
```

#### Transactions API

##### Sending Money 

( Auth Scope Required: send )

```ruby
  user = Dwolla::User.me(ACCESS_TOKEN)
  other_user_id = 'sample@user.com' # or the Dwolla account id
  pin = '1234'
  amount = 200

  user.send_money_to(other_user_id, amount, pin)
```

##### Requesting Money 

( Auth Scope Required: request )

```ruby
  user = Dwolla::User.me(ACCESS_TOKEN)
  other_user_id = 'sample@user.com' # or the Dwolla account id
  pin = '1234'
  amount = 200

  user.request_money_from(other_user_id, amount, pin)
```
