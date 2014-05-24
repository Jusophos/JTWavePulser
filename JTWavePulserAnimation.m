//
//  JSWavePulserAnimation.m
//
//  Created by Richard Jung on 24.05.14.
//  Copyright (c) 2014 Jung IT COM KG. All rights reserved.
//

#import "JTWavePulserAnimation.h"

#import <QuartzCore/QuartzCore.h>

@interface JTWavePulserAnimation ()

@property (assign, readwrite) BOOL wantToStop;
@property (assign, readwrite) BOOL isPulsing;

@end

@implementation JTWavePulserAnimation

#pragma mark - Initialization
- (id)initWithView:(UIView *)view {
    
    if ((self = [self init])) {
        
        self.view = view;
        self.pulseRingScale = 2.0f;
        self.baseView = self.view.superview;
        
        NSAssert(self.baseView != nil, @"The given view has to have a superview!");
    }
    
    return self;
}

- (id)init {
    
    if ((self = [super init])) {
        
        self.pulseRingWidth = 1.0f;
        self.pulseRingColor = [UIColor blueColor];
        self.pulseRingBackgroundColor = [UIColor clearColor];
        self.pulseAnimationDuration = 1.0f;
        self.pulseAnimationInterval = 1.0f;
    }
    
    return self;
}

#pragma mark - Pulsing
- (void)startPulsing {
    
    if (self.isPulsing) {
        
        return;
    }
    
    self.wantToStop = NO;
    self.isPulsing = YES;

    [self pulseRing];
    [self checkTimer];
}

- (void)stopPulsing {
    
    if (!self.isPulsing) {
        
        return;
    }
    
    self.wantToStop = YES;
}

#pragma mark - Helpers
- (void)checkTimer {
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (double)self.pulseAnimationInterval * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if (self.wantToStop) {
            
            self.isPulsing = NO;
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self pulseRing];
        });
        
        [self checkTimer];
    });
}

- (void)pulseRing {
    
    __block UIView *pulseRingView = [self createPulseRing];
    
    [self.baseView addSubview:pulseRingView];
    
    [UIView animateWithDuration:self.pulseAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
    
        pulseRingView.alpha = 0.0;
        pulseRingView.transform = CGAffineTransformMakeScale(self.pulseRingScale, self.pulseRingScale);
        
    } completion:^(BOOL completed) {
        
        [pulseRingView removeFromSuperview];
        pulseRingView = nil;
    }];
}
     
- (UIView *)createPulseRing {
    
    UIView *pulseRingView = [[UIView alloc] initWithFrame:self.view.frame];
    pulseRingView.backgroundColor = [UIColor clearColor];
    pulseRingView.layer.cornerRadius = pulseRingView.bounds.size.width / 2.0f;
    pulseRingView.layer.borderWidth = self.pulseRingWidth;
    pulseRingView.layer.borderColor = [self.pulseRingColor CGColor];
    pulseRingView.layer.backgroundColor = [self.pulseRingBackgroundColor CGColor];
    
    return pulseRingView;
}

@end