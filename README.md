# README: Bloom & Brew - Tea Subscription Admin Portal BE
## What is it?

This backend application manages the data of a tea subscription service for admin.  It accepts requests from a front end and returns responses of json to allow for the retrieval of all subscriptions, the details (subscription info, included teas, and current customers) for a single subscription.  This applications data is displayed and interacted with on this applications [frontend](https://github.com/elysableu/tea_subscriptions_fe).

<br>

![](BloomBrew-be-demo.gif)

## Tech Stack
- Ruby 3.2.2
- Rails 7.2.2.1
- Rspec-rails 7.1.1

## Set up Locally
1. Fork this repository
2. Clone the repository: `git clone [remote-address] [new-name]`
    For example: `git clone git@github.com:elysableu/tea_subscriptions_be.git`
3. `cd` into the directory
4. Install the dependencies `bundle install`
5. Run this backend app with `rails s`
6. Enter `control + c` into terminal to stop app from running
7. Enter `rails c` to input ActiveRecord commands to view database

## Endpoints
|       | endpoint                                 | Header                                       | Body                                                                | Description                                                  |
|-------|------------------------------------------|----------------------------------------------|---------------------------------------------------------------------|--------------------------------------------------------------|
| GET   | `/api/v1/subscriptions`                  | n/a                                          | n/a                                                                 | Retrieves all subscriptions                                  |
| GET   | `/api/v1/subscriptions/:subscription_id` | n/a                                          | n/a                                                                 | Retrieves one subscription with `:subscription_id`           |
| PATCH | `/api/v1/subscriptions/:subscription_id` | ```"CONTENT_TYPE"  =>  "application/json"``` | ```{ "subscription" :        { "status" :   ":target_status" } }``` | Updates the status of one subscription at `:subscription_id` |

