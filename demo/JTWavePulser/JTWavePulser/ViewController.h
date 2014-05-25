//
//  ViewController.h
//  JTWavePulser
//
//  Created by Richard Jung on 25.05.14.
//  Copyright (c) 2014 Jung IT COM KG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *red1;
@property (weak, nonatomic) IBOutlet UIView *red2;
@property (weak, nonatomic) IBOutlet UIView *red3;

@property (weak, nonatomic) IBOutlet UIView *green1;
@property (weak, nonatomic) IBOutlet UIView *green2;
@property (weak, nonatomic) IBOutlet UIView *green3;

@property (weak, nonatomic) IBOutlet UIView *blue1;
@property (weak, nonatomic) IBOutlet UIView *blue2;
@property (weak, nonatomic) IBOutlet UIView *blue3;

@property (nonatomic, strong) NSArray *reds;
@property (nonatomic, strong) NSArray *blues;
@property (nonatomic, strong) NSArray *greens;
@property (nonatomic, strong) NSArray *all;

@property (readwrite, assign) BOOL isPulsing;

- (IBAction)tooglePulsing:(id)sender;


@end
