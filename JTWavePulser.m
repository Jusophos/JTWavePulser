//
//  JTWavePulser.m
//
//  Created by Richard Jung on 24.05.14.
//  Copyright (c) 2014 Jung IT COM KG. All rights reserved.
//

#import "JTWavePulser.h"

static JTWavePulser *sharedWavePulserInstance = nil;

@implementation JTWavePulser

#pragma mark - Access management
+ (JTWavePulser *)shared {
    
    if (sharedWavePulserInstance == nil) {
        
        sharedWavePulserInstance = [[JTWavePulser alloc] init];
    }
    
    return sharedWavePulserInstance;
}

#pragma marl - Animation management
+ (JTWavePulserAnimation *)animationWithView:(UIView *)view {
    
    JTWavePulser *pulser = [JTWavePulser shared];
    pulser.keyCounter++;
    JTWavePulserAnimation *animation = [pulser animationForView:view forKey:[NSString stringWithFormat:@"anim_%d", pulser.keyCounter]];
    
    return animation;
}

+ (JTWavePulserAnimation *)animationWithView:(UIView *)view forKey:(NSString *)key {
 
    JTWavePulser *pulser = [JTWavePulser shared];
    JTWavePulserAnimation *animation = [pulser animationForView:view forKey:key];
    
    return animation;
}

- (JTWavePulserAnimation *)animationForView:(UIView *)view forKey:(NSString *)key {
    
    if (self.animations == nil) {
        
        self.animations = [NSMutableDictionary dictionary];
    }
    
    JTWavePulserAnimation *animation = [self.animations objectForKey:key];
    
    if (animation == nil) {
        
        animation = [[JTWavePulserAnimation alloc] initWithView:view];
        [self.animations setObject:animation forKey:key];
    }
    
    return animation;
}

@end
