//
//  ViewController.m
//  AZWheelPickerView
//
//  Created by Albert Zhang on 9/13/14.
//  Copyright (c) 2014 Albert Zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self.view insertSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AZBg"]] atIndex:0];
	
	
	self.wheelPicker = [[AZWheelPickerView alloc] initWithFrame:CGRectMake(10, 50, 600, 600)];
	
	self.wheelPicker.wheelImage = [UIImage imageNamed:@"wheel"];
	
	// There are totally 8 sectors in the wheel.png
	self.wheelPicker.numberOfSectors = 8;
	
	// Rotate the wheel a little bit so that the pointer at the center of a secotr
	self.wheelPicker.wheelInitialRotation = - (M_PI * 2 / 8) * 0.5;
	
	self.wheelPicker.animationDecelerationFactor = 0.99;
	
	[self.view insertSubview:self.wheelPicker atIndex:1];
	
	[self.wheelPicker addTarget:self action:@selector(onWheelChange:) forControlEvents:UIControlEventValueChanged];
	
	
	theLabel.text = [NSString stringWithFormat:@"Index: %d", self.wheelPicker.selectedIndex];
	
}

- (void)onWheelChange:(UIControl *)control{
	theLabel.text = [NSString stringWithFormat:@"Index: %d", self.wheelPicker.selectedIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
