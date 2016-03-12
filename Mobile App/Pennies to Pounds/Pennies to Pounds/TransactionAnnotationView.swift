//
//  TransactionAnnotationView.swift
//  Pennies to Pounds
//
//  Created by George McDonnell on 11/03/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit
import MapKit

class TransactionAnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        self.canShowCallout = false;
        self.frame = CGRectMake(0, 0, 40, 40);
        
        let contentView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        contentView.backgroundColor = UIColor(red: 43/255.0, green:65/255.0, blue:77.0/255.0, alpha:0.25)
        contentView.layer.cornerRadius = contentView.frame.size.width / 2
        
        let innerView = UIView(frame: CGRectMake(0, 0, self.frame.size.width / 6, self.frame.size.height / 6))
        innerView.center = contentView.center
        innerView.backgroundColor = UIColor.redColor()
        innerView.layer.cornerRadius = innerView.frame.size.width / 2
        
        contentView.addSubview(innerView)
        
        self.addSubview(contentView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
