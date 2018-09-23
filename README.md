# Read Me

# Bud Technical Task

Project that implements a simple transaction list applications presented in UITableView with image title and subtitle.

# Development

## Coordinators
The application navigation is handled by coordinator. 

## Categories

UIImageView extention that downloads and cash an image from URL, or cancel the request. 

## API
 The API layer is presented of two classes - Server.swift (containing the base url) and TransactionAPIManager.swift (making the url request and handling the data). 
 
## Layout 
As part of a bigger team I'm used to write constraints in code to avoid conflicts with storyboards.  I have used NSLayoutConstraint in TransactionsListViewController.swift and NSLayoutAnchor(easier to read) in TransactionTableViewCell.swift

## Tests

There are two test classes - one that tests the mapping of a transaction object and one that tests the viewModel.

## Pods

Mockingjay, Nimble, URITemplate to help with testing. 

# Enjoy!
