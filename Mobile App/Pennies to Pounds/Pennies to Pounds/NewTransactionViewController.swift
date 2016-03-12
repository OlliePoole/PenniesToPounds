//
//  NewTransactionViewController.swift
//  Pennies to Pounds
//
//  Created by George McDonnell on 12/03/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit

class NewTransactionViewController: UIViewController {
    
    @IBOutlet weak var savingsIcon: UIImageView!
    @IBOutlet weak var donateIcon: UIImageView!
    
    @IBOutlet weak var savingsSpinner: UIActivityIndicatorView!
    @IBOutlet weak var donateSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func makeSaving(sender: AnyObject) {
        UIView.animateWithDuration(0.5) { () -> Void in
            self.savingsIcon.alpha = 0
            self.savingsSpinner.alpha = 1
        }
    }
    
    @IBAction func donate(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.donateIcon.alpha = 0
            self.donateSpinner.alpha = 1
            }) { (complete) -> Void in
                
        }
    }

}
