//
//  JTWavePulserAnimation.h
//
//  Created by Richard Jung on 24.05.14.
//  Copyright (c) 2014 Jung IT COM KG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTWavePulserAnimation : NSObject

@property (weak, nonatomic) UIView *view;
@property (weak, nonatomic) UIView *baseView;

#pragma mark - UI Customizing
@property (assign) float pulseRingWidth;
@property (nonatomic, strong) UIColor *pulseRingColor;
@property (nonatomic, strong) UIColor *pulseRingBackgroundColor;
@property (assign) float pulseRingScale;
@property (assign) float pulseRingInitialAlpha;
@property (assign) float pulseAnimationDuration;
@property (assign) float pulseAnimationInterval;

#pragma mark - Initialization
- (id)initWithView:(UIView *)view;

#pragma mark - Pulsing
- (void)startPulsing;
- (void)stopPulsing;
- (void)stopPulsingInstantly;
- (void)pulseXTimes:(int)times;

@end
