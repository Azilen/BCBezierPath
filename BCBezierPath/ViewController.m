//
//  ViewController.m
//  BCBezierPath
//
//  Created by Bhavin Chitroda on 6/11/15.
//  Copyright (c) 2015 Bhavin Chitroda. All rights reserved.
//

#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "BCSpiral.h"

@interface ViewController ()
{
    NSMutableArray *arrImages;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)removeOldImages
{
    for (UIImageView *imgView in arrImages)
    {
        [imgView removeFromSuperview];
    }
}

- (NSInteger)randomNumberBetween:(NSInteger)min maxNumber:(NSInteger)max
{
    return min + arc4random() % (max - min);
}

- (void)processMagicAtPoint:(CGPoint)startPoint
{
//    [self removeOldImages];
    
    arrImages = [NSMutableArray array];
    
    NSUInteger noOfDots = [self randomNumberBetween:15 maxNumber:25];
    
    float imgWidth    = 3.5;
    float imgHeight   = 3.5;
    float startRadius = 2.5;
    float startTheta  = 3.0;
    float thetaStep   = 0.28;
    
    NSTimeInterval duration = 1.75;
    
    CGPoint point = startPoint;
    
    for (int i = 0; i < noOfDots; i++)
    {
        UIImageView* theImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgWidth, imgHeight)];
        theImage.image        = [UIImage imageNamed:@"dot_20.png"];
        theImage.center       = point;
        [self.view addSubview:theImage];
        [arrImages addObject:theImage];
        
        float endTheta     = noOfDots - i * (14.0/noOfDots);
        float spacePerLoop = 1.40 - i * (1.0/noOfDots);
        
        UIBezierPath *trackPath = [BCSpiral spiralAtPoint:point
                                              startRadius:startRadius
                                             spacePerLoop:spacePerLoop
                                               startTheta:startTheta
                                                 endTheta:endTheta
                                                thetaStep:thetaStep];
        
        CGFloat scaleFactor = 4.0 - i * (3.6/noOfDots);

        CGPoint destination = [trackPath currentPoint];

        [UIView animateWithDuration:duration animations:^{
            
            // UIView will add animations for both of these changes.
            theImage.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
            theImage.center    = destination;
            
            // Prepare my own keypath animation for the layer position.
            // The layer position is the same as the view center.
            CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            positionAnimation.path = trackPath.CGPath;
            
            // Copy properties from UIView's animation.
            CAAnimation *autoAnimation  = [theImage.layer animationForKey:@"position"];
            positionAnimation.duration  = autoAnimation.duration;
            positionAnimation.fillMode  = autoAnimation.fillMode;
            positionAnimation.beginTime = CACurrentMediaTime() + i * 0.1;
            
            // Replace UIView's animation with my animation.
            [theImage.layer addAnimation:positionAnimation forKey:positionAnimation.keyPath];
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(IBAction) handleTapGesture:(UIGestureRecognizer *) sender
{
    CGPoint sPoint = [sender locationInView:self.view];
    [self processMagicAtPoint:sPoint];
    NSLog(@"tapped");
}

@end
