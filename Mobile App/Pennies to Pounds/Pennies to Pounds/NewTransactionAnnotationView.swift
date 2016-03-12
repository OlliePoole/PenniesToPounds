//
//  NewTransactionAnnotationView.swift
//  Pennies to Pounds
//
//  Created by George McDonnell on 12/03/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit
import MapKit
import TKSubmitTransition

class NewTransactionAnnotationView: MKAnnotationView {

    var transitionButton: TKTransitionSubmitButton?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        self.canShowCallout = false;
        self.frame = CGRectMake(0, 0, 250, 220)
        
        let contentView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        contentView.backgroundColor = UIColor.clearColor()
        
        let innerView = UIView(frame: CGRectMake(0, 0, self.frame.size.width / 6, self.frame.size.height / 6))
        innerView.center = contentView.center
        innerView.backgroundColor = UIColor.redColor()
        innerView.layer.cornerRadius = innerView.frame.size.width / 2
        
        let pulse = Pulse()
        pulse.position = self.center
        layer.addSublayer(pulse)
        
        transitionButton = TKTransitionSubmitButton(frame: CGRectMake(0, 0, 44, 44))
        self.addSubview(transitionButton!)
        
        self.addSubview(contentView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
