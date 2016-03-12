//
//  NewTransactionViewController.swift
//  Pennies to Pounds
//
//  Created by George McDonnell on 12/03/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit
import TKSubmitTransition

class NewTransactionViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var savingsIcon: UIImageView!
    @IBOutlet weak var donateIcon: UIImageView!
    
    @IBOutlet weak var savingsSpinner: UIActivityIndicatorView!
    @IBOutlet weak var donateSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "New Transaction"
    }

    @IBAction func makeSaving(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.savingsIcon.alpha = 0
            self.savingsSpinner.alpha = 1
            }) { (complete) -> Void in
                self.performSelector("transactions", withObject: nil, afterDelay: 1)
        }
    }
    
    @IBAction func donate(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.donateIcon.alpha = 0
            self.donateSpinner.alpha = 1
            }) { (complete) -> Void in
                self.performSelector("transactions", withObject: nil, afterDelay: 1)
        }
    }
    
    func transactions() {
        let secondVC = self.storyboard?.instantiateViewControllerWithIdentifier("TransactionsViewController") as! TransactionsViewController
        secondVC.transitioningDelegate = self
        self.presentViewController(secondVC, animated: true, completion: nil)
    }

    // MARK: UIViewControllerTransitioningDelegate
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let fadeInAnimator = TKFadeInAnimator()
        return fadeInAnimator
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
