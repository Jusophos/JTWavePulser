//
//  JTWavePulser.h
//
//  Created by Richard Jung on 24.05.14.
//  Copyright (c) 2014 Jung IT COM KG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JTWavePulserAnimation.h"

@interface JTWavePulser : NSObject {
    
    
}

@property (assign) NSUInteger keyCounter;
@property (nonatomic, strong) NSMutableDictionary *animations;

#pragma mark - Access management
+ (JTWavePulser *)shared;

#pragma mark - Animation management
+ (JTWavePulserAnimation *)animationWithView:(UIView *)view;
+ (JTWavePulserAnimation *)animationWithView:(UIView *)view forKey:(NSString *)key;

#pragma mark - Actions
- (JTWavePulserAnimation *)animationForView:(UIView *)view forKey:(NSString *)key;

@end
