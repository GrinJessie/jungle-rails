# Jungle

_A mini e-commerce application built with Rails 4.2_

## Project Demo
* Review feature
![Review](https://github.com/GrinJessie/jungle-rails/blob/master/doc/review.gif)
* Order placement and confirmation feature
![Order](https://github.com/GrinJessie/jungle-rails/blob/master/doc/order.gif)
* Order email receipt feature
![Order](https://github.com/GrinJessie/jungle-rails/blob/master/doc/email%20receipt.png)
* Admin authentication feature
![Admin](https://github.com/GrinJessie/jungle-rails/blob/master/doc/admin.gif)

## Tech Stacks
![Stacks](https://github.com/GrinJessie/jungle-rails/blob/master/doc/jungle-stack-note.png)



## Extra Features

* When a product is sold out, the "add to cart" button is updated and disabled
* Display average rating of the product along with the price on the main page.
* Display error messages on requirement to meet when a form is not successsully submited. Simple forms like "admin add category" is autofodused.
* When a user signed in, the first name will be display on nav bar.
* In product details page, a simple notice is shown if there is reviews currently. It will be replaced once a review is add.


## Basic Functional Requirements

### Feature: Sold Out Badge
* When a product has 0 quantity, a sold out badge will be displayed on the product list page. (was implemented as a boolean method in view helper).

### Feature: Admin Categories
* Admin users can list and create new categories, add new products using the new category.
* Restful routes (resources) were be used, and there was no extra, unused routes exposed.
* All admin controllers inherit from ApplicationController containing the authentication filter.

### Feature: User Authentication
* A visitor can go to the registration page from any page in order to create an account, sign up for a user account with the e-mail, password, first name and last name, or sign in using the e-mail and password, and log out from any page.
* Signing up with an existing e-mail address (uniqueness validation) is NOT allowed.
* Passwords are not stored as plain text in the database. Instead, has_secure_password is used in the User model, leveraging the bcrypt gem.

### Feature: Order Details Enhancement
* The order page contains items, their image, name, description, quantities and line item totals, the final amount for the order is displayed, the email that was used to place the order is displayed.

### Feature: Email Receipt
* The e-mail content was (minimally) formatted with HTML. It lists the total as well as each line item in the order. The Order ID is in the subject line.


### Feature: Checking Out with Empty Cart
* When the cart is empty and the user goes to the carts#show page, instead of displaying the contents and a stripe checkout button, display a friendly message about how it is empty and link to the home page

### Feature: Product Rating
* Visitors can view the overall rating of products as I browse the catalog, the list of ratings and reviews when viewing the product detail.
* A logged in user can rate & review a product in a single step, can delete a rating or review that I previously created (was implemented by using nested resources in the routing instead of custom controller actions)

## Setup

1. Fork & Clone
2. Run ```bundle install``` to install dependencies
3. Create ```config/database.yml``` by copying ```config/database.example.yml```
4. Create ```config/secrets.yml``` by copying ```config/secrets.example.yml```
5. Run ```bin/rake db:reset``` to create, load and seed db
6. Create .env file based on .env.example
7. Sign up for a Stripe account
8. Put Stripe (test) keys into appropriate .env vars OR use Credit Card # 4111 1111 1111 1111 for testing success scenarios. (More information in their docs: <https://stripe.com/docs/testing#cards>)
9. Run ```bin/rails s -b 0.0.0.0``` to start the server
10. Hit http://localhost:3000/.


## Dependencies

* Rails 4.2 [Rails Guide](http://guides.rubyonrails.org/v4.2/)
* PostgreSQL 9.x
* Stripe
