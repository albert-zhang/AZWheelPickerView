//
//  ViewController.h
//  AZWheelPickerView
//
//  Created by Albert Zhang on 9/13/14.
//  Copyright (c) 2014 Albert Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZWheelPickerView.h"

@interface ViewController : UIViewController
{
	@private
	IBOutlet UILabel *theLabel;
}

@property (nonatomic, strong) AZWheelPickerView *wheelPicker;

@end
