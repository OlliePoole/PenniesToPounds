//
//  Pulse.m
//  CircularPulse
//
//  Created by Vinay Jain on 6/23/15.
//  Copyright (c) 2015 Vinay Jain. All rights reserved.
//

#import "Pulse.h"

@implementation Pulse

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, 0) radius:100 startAngle:0.0*(M_PI/180.0)  endAngle:360.0*(M_PI/180.0) clockwise:YES].CGPath;
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
        scaleAnimation.fromValue = @(0.0);
        scaleAnimation.toValue = @1.0;
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = @(0.8);
        opacityAnimation.toValue = @0.0;
        self.fillColor = [UIColor colorWithRed:43/255.0 green:65/255.0 blue:77.0/255.0 alpha:0.8].CGColor;
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        NSArray *animations = @[scaleAnimation, opacityAnimation];
        animationGroup.duration = 3.0;
        
        animationGroup.repeatCount = HUGE_VAL;
        
        animationGroup.animations = animations;
        self.position = self.superlayer.position;
        [self addAnimation:animationGroup forKey:@"pulse"];
    }
    return self;
}

@end
