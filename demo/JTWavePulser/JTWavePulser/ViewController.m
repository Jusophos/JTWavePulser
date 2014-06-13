//
//  ViewController.m
//  JTWavePulser
//
//  Created by Richard Jung on 25.05.14.
//  Copyright (c) 2014 Jung IT COM KG. All rights reserved.
//

#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "JTWavePulser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.reds = @[self.red1,self.red2,self.red3];
    self.greens = @[self.green1,self.green2,self.green3];
    self.blues = @[self.blue1,self.blue2,self.blue3];
    self.all = @[self.red1,self.red2,self.red3,self.green1,self.green2,self.green3,self.blue1,self.blue2,self.blue3];
    
    for (UIView *view in self.all) {
        
        view.layer.cornerRadius = view.layer.bounds.size.width / 2.0f;
    }
    
    for (UIView *view in self.reds) {
        
        view.layer.borderColor = [[UIColor redColor] CGColor];
        
        JTWavePulserAnimation *animation = [JTWavePulser animationWithView:view forKey:[NSString stringWithFormat:@"view_%d",view.tag]];
        animation.pulseRingColor = [UIColor redColor];
    }
    
    for (UIView *view in self.greens) {
        
        view.layer.borderColor = [[UIColor greenColor] CGColor];
        
        JTWavePulserAnimation *animation = [JTWavePulser animationWithView:view forKey:[NSString stringWithFormat:@"view_%d",view.tag]];
        animation.pulseRingColor = [UIColor greenColor];
        animation.pulseAnimationDuration = 1.0f;
        animation.pulseAnimationInterval = 0.5f;
        animation.pulseRingBackgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.5];
    }
    
    for (UIView *view in self.blues) {
        
        view.layer.borderColor = [[UIColor blueColor] CGColor];
        
        JTWavePulserAnimation *animation = [JTWavePulser animationWithView:view forKey:[NSString stringWithFormat:@"view_%d",view.tag]];
        animation.pulseRingColor = [UIColor blueColor];
        animation.pulseAnimationDuration = 1.0f;
        animation.pulseAnimationInterval = 0.25f;
        animation.pulseRingInitialAlpha = 0.5;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tooglePulsing:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    for (UIView *view in self.all) {
        
        JTWavePulserAnimation *animation = [JTWavePulser animationWithView:view forKey:[NSString stringWithFormat:@"view_%d",view.tag]];
    
        
        if (!self.isPulsing) {
            
            [animation startPulsing];
            
        } else {
            
            [animation stopPulsing];
        }
    }
    
    if (!self.isPulsing) {
        
        [button setTitle:@"Stop pulsing" forState:UIControlStateNormal];
        
    } else {
        
        [button setTitle:@"Start pulsing" forState:UIControlStateNormal];
    }
    
    self.isPulsing = !self.isPulsing;
}

@end
