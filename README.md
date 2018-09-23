# Read Me

# Bud Technical Task

Project that implements a simple transaction list applications presented in UITableView with image, title, subtitle, amout and category.

# Development

## Note
I have changed the url from http://www.mocky.io/v2/5b33bdb43200008f0ad1e256 to --->  https://www.mocky.io/v2/5b33bdb43200008f0ad1e256 as it's supported. Alternately I could have added the url in the Info.plist file under the key NSExceptionAllowsInsecureHTTPLoads. 

## Coordinators
The application navigation is handled by coordinator. 

## Categories

UIImageView extension that downloads and cash an image from URL, or cancel the request. 

## API
 The API layer is presented of two classes - Server.swift (containing the base url) and TransactionAPIManager.swift (making the url request and handling the data). 
 
## Layout 
As part of a bigger team I'm used to write constraints in code to avoid conflicts with storyboards.  I have used NSLayoutConstraint in TransactionsListViewController.swift and NSLayoutAnchor(easier to read) in TransactionTableViewCell.swift

## Tests

There are two test classes - one that tests the mapping of a transaction object and one that tests the viewModel.

## Pods

Mockingjay, Nimble, URITemplate to help with testing. 

# Enjoy!
