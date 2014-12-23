//
//  AZViewController.m
//  AZWheelPickerView
//
//  Created by albert-zhang on 12/23/2014.
//  Copyright (c) 2014 albert-zhang. All rights reserved.
//

#import "AZViewController.h"

@interface AZViewController ()

@end

@implementation AZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self.view insertSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bg"]] atIndex:0];
	
	
	self.wheelPicker = [[AZWheelPickerView alloc] initWithFrame:CGRectMake(10, 50, 600, 600)];
	
	self.wheelPicker.wheelImage = [UIImage imageNamed:@"Wheel"];
	
	// There are totally 8 sectors in the wheel.png
	self.wheelPicker.numberOfSectors = 8;
	
	// Rotate the wheel a little bit so that the pointer at the center of a secotr
	self.wheelPicker.wheelInitialRotation = - (M_PI * 2 / 8) * 0.5;
	
	self.wheelPicker.continuousTrigger = YES;
	
	self.wheelPicker.animationDecelerationFactor = 0.99;
	
	[self.view addSubview:self.wheelPicker];
	
	[self.wheelPicker addTarget:self action:@selector(onWheelChange:) forControlEvents:UIControlEventValueChanged];
	
	
	thePointer = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer"]];
	[self.view addSubview:thePointer];
	thePointer.center = CGPointMake(self.view.bounds.size.width / 2,
									self.view.bounds.size.height - 510);
	
	
	theLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 400, 200, 30)];
	theLabel.textColor = [UIColor whiteColor];
	theLabel.font = [UIFont boldSystemFontOfSize:20];
	[self.view addSubview:theLabel];
	
	[self onWheelChange:nil]; // force update the label
}


- (void)onWheelChange:(UIControl *)control{
	theLabel.text = [NSString stringWithFormat:@"Index: %d", self.wheelPicker.selectedIndex];
	[theLabel sizeToFit];
	[self.view layoutIfNeeded];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
