//
//  SKModifierButton.m
//  smartkeys
//
//  Created by Atul M on 26/10/16.
//  Copyright © 2016 CARLOS CABANERO. All rights reserved.
//

#import "SKModifierButton.h"

#define DEFAULT_BG_COLOR  [UIColor viewFlipsideBackgroundColor];
#define SELECTED_BG_COLOR [UIColor blueColor]

@implementation SKModifierButton
@synthesize backgroundLayer;

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];

    if(selected){
        self.backgroundLayer = [[CALayer alloc]init];
        self.backgroundLayer.cornerRadius = 5;
        self.backgroundLayer.frame = CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10);
        self.backgroundLayer.backgroundColor = [UIColor colorWithRed:86.0/255.0 green:234.0/255.0 blue:241.0/255.0 alpha:1.0].CGColor;
        
        CABasicAnimation *theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
        theAnimation.duration=0.5;
        theAnimation.fromValue=[NSNumber numberWithFloat:0.0];
        theAnimation.toValue=[NSNumber numberWithFloat:1.0];
        [self.backgroundLayer addAnimation:theAnimation forKey:@"animateOpacity"];
        
        [self.layer insertSublayer:self.backgroundLayer atIndex:0];
    }else{
        
        [CATransaction begin];
        CABasicAnimation *theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
        theAnimation.duration=0.5;
        theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
        theAnimation.toValue=[NSNumber numberWithFloat:0.0];
        [CATransaction setCompletionBlock:^{
            if(self.backgroundLayer != nil){
                [self.backgroundLayer removeFromSuperlayer];
            }
        }];
        [self.backgroundLayer addAnimation:theAnimation forKey:@"animateOpacity"];
        [CATransaction commit];

    }
}

@end
