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

@property (assign, readwrite) int pulsingCount;
@property (assign, readwrite) int pulsingMaxCount;

@property (nonatomic, strong) NSMutableArray *pulseViews;

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
        self.pulseRingInitialAlpha = 1.0f;
        self.pulseViews = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - Pulsing
- (void)startPulsing {
    
    [self startPulsingXTimes:-1];
}

- (void)startPulsingXTimes:(int)times {
    
    if (self.isPulsing) {
        
        return;
    }
    
    self.pulsingCount = 1;
    self.pulsingMaxCount = times;
    self.wantToStop = NO;
    self.isPulsing = YES;
    
    [self pulseRing];
    [self checkTimer];
}

- (void)pulseXTimes:(int)times {
    
    [self startPulsingXTimes:times];
}

- (void)stopPulsing {
    
    if (!self.isPulsing) {
        
        return;
    }
    
    self.wantToStop = YES;
}

- (void)stopPulsingInstantly {
    
    if (!self.isPulsing) {
        
        return;
    }
    
    self.wantToStop = YES;
        
    for (UIView *view in self.pulseViews) {
        
        [view removeFromSuperview];
    }
}

#pragma mark - Helpers
- (void)checkTimer {
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (double)self.pulseAnimationInterval * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if (self.wantToStop) {
            
            self.isPulsing = NO;
            return;
        }
        
        if (self.pulsingMaxCount != -1 && self.pulsingCount >= self.pulsingMaxCount) {
            
            self.isPulsing = NO;
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self pulseRing];
        });
        
        self.pulsingCount++;        

        
        [self checkTimer];
    });
}

- (void)pulseRing {
    
    __block UIView *pulseRingView = [self createPulseRing];
    
    [self.pulseViews addObject:pulseRingView];
    [self.baseView addSubview:pulseRingView];
    
    [UIView animateWithDuration:self.pulseAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
    
        pulseRingView.alpha = 0.0;
        pulseRingView.transform = CGAffineTransformMakeScale(self.pulseRingScale, self.pulseRingScale);
        
    } completion:^(BOOL completed) {
        
        [self.pulseViews removeObject:pulseRingView];
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
    pulseRingView.alpha = self.pulseRingInitialAlpha;
    
    return pulseRingView;
}

@end
