!["Logo"](http://i.imgur.com/NizZhU3.png)

# PenniesToPounds

Pennies to pounds is an innovative new service designed to make it quick and east to save on every transaction a customer makes. The service allows customers to round-up the value of transactions to the nearest £1, £5 or £10 and then decide what to do with the extra money. The service was made at the Realex FinApps Party (/hackathon) in 16 hours. 



### The Platform
The platform is made up of two parts, the first part is the web-service that communicates with Realex. This contains a button that retailers would add to their site allowing customers to checkout with Pennies to Pounds. 

The second part of the platform is the native iOS application written in Swift. The applicaton tracks the locations of payments made on the web (sometimes...) and displays them in app. The app then lets customers decide what to do with the extra money, giving the options to add it to a savings account or to donate it to charity. 

### Next Steps
While integrating with Realex was super easy for the hackathon, it seems logical to move to a bank's API to track all payments made using a debit card instead of limiting it to only retailers who sign up. 
