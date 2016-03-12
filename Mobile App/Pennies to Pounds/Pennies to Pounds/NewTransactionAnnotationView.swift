//
//  NewTransactionAnnotationView.swift
//  Pennies to Pounds
//
//  Created by George McDonnell on 12/03/2016.
//  Copyright © 2016 George McDonnell. All rights reserved.
//

import UIKit
import MapKit

class NewTransactionAnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        self.canShowCallout = false;
        self.centerOffset = CGPointMake(0, -120);
        self.frame = CGRectMake(0, 0, 250, 220);
        
        let contentView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        contentView.backgroundColor = UIColor.clearColor()
        self.addSubview(contentView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.canShowCallout = false;
        self.centerOffset = CGPointMake(0, -120);
        self.frame = CGRectMake(0, 0, 250, 220);
        
        let contentView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        contentView.backgroundColor = UIColor.clearColor()
        self.addSubview(contentView)
        
        let pulse = Pulse()
        pulse.position = self.center
        layer.addSublayer(pulse)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        let lineWidth: CGFloat = 1.0;
        let radius: CGFloat = 10 + lineWidth / 2.0;
        let bubbleHeight: CGFloat = 20;
        var point = CGPointMake(rect.width / 2.0, 31);
        var nextPoint: CGPoint
        
        // draw the main pin
        
        var path = UIBezierPath()
        path.moveToPoint(point)
        
        nextPoint = CGPointMake(point.x - radius, point.y - bubbleHeight)
        path.addCurveToPoint(nextPoint, controlPoint1: CGPointMake(point.x, point.y - bubbleHeight / 2.0), controlPoint2: CGPointMake(nextPoint.x, nextPoint.y + bubbleHeight / 2.0))
        
        let center = CGPointMake(point.x, nextPoint.y)
        path.addArcWithCenter(center, radius: radius, startAngle: CGFloat(M_PI), endAngle: 0, clockwise: true)
        
        point = CGPointMake(nextPoint.x + radius * 2.0, nextPoint.y)
        nextPoint = CGPointMake(point.x - radius, point.y + bubbleHeight);
        path.addCurveToPoint(nextPoint, controlPoint1:CGPointMake(point.x, point.y + bubbleHeight / 2.0), controlPoint2:CGPointMake(nextPoint.x, nextPoint.y - bubbleHeight / 2.0))
        
        UIColor.blackColor().setStroke()
        UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 0.8).setFill()
        path.lineWidth = lineWidth
        
        path.fill()
        path.stroke()
        
        // draw white filled center
        
        path = UIBezierPath(arcCenter: center, radius: radius, startAngle: radius / 3.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        path.lineWidth = lineWidth;
        UIColor.whiteColor().setFill()
        path.fill()
        
        // if we need it, draw the bubble around the label
        
        //        if ([self.label.text length] > 0) {
        //            CGRect bubbleRect = CGRectMake(1, 33, self.width - 2.0, 10);
        //            path = [UIBezierPath bezierPathWithRoundedRect:bubbleRect cornerRadius:5];
        //            path.lineWidth = lineWidth;
        //            [[UIColor colorWithRed:0.0 green:0.5 blue:1.0 alpha:0.8] setFill];
        //            [path fill];
        //            [path stroke];
        //        }
    }

}
