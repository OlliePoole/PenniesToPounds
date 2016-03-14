//
//  TransactionsViewController.swift
//  Pennies to Pounds
//
//  Created by George McDonnell on 12/03/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class TransactionsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Transactions"

    }
    
    var transactions: [[String : AnyObject]] = [["amount" : "£1.89", "direction" : true, "option" : 1], ["amount" : "£3.19", "direction" : true, "option" : 0], ["amount" : "£15.00", "direction" : true, "option" : 1]]
    
    override func viewDidAppear(animated: Bool) {
        let transaction = ["amount" : "£7.21", "direction" : false, "option" : 1]
        transactions.insert(transaction, atIndex: 0)
        
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let transaction = transactions[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("TransactionTableViewCell") as! TransactionTableViewCell
        cell.amountLabel.text = transaction["amount"] as? String
        
        if (transaction["direction"] as! Bool) {
            cell.arrowNorth.hidden = false
        } else {
            cell.arrowSouth.hidden = false
        }
        
        if (transaction["option"] as! Bool) {
            cell.donateIcon.hidden = false
        } else {
            cell.savingsIcon.hidden = false
        }
        
        return cell
    }

}
