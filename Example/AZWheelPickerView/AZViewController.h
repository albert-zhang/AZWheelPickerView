//
//  AZViewController.h
//  AZWheelPickerView
//
//  Created by albert-zhang on 12/23/2014.
//  Copyright (c) 2014 albert-zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AZWheelPickerView/AZWheelPickerView.h>

@interface AZViewController : UIViewController
{
	UILabel *theLabel;
	UIImageView *thePointer;
}

@property (nonatomic, strong) AZWheelPickerView *wheelPicker;

@end
