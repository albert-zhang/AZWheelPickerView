//
//  AZWheelPickerView.m
//  az-garage
//
//  Created by Yang Zhang on 12/27/12.
//  Copyright (c) 2012 Albert Zhang. All rights reserved.
//

#import "AZWheelPickerView.h"
#import <QuartzCore/QuartzCore.h>

#define kAZWheelPickerInertiaTimerAcceptableMaxInterval (1.0 / 30.0) // xx fps
#define kAZWheelPickerInertiaTimerAcceptableMinInterval (1.0 / 60.0) // xx fps


@interface AZWheelPickerView ()

@property (nonatomic, assign) float currentRotation;

@end

@implementation AZWheelPickerView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self myInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
	self = [super initWithCoder:decoder];
	if(self){
		[self myInit];
	}
	return self;
}

- (void)myInit{
	self.animationDecelerationFactor = kAZWheelPickerDefaultDeceleration;
	self.continuousTrigger = NO;
}

- (void)dealloc
{
    [self stopInertiaTimer];
}

#pragma mark -

- (void)didMoveToWindow{
	[super didMoveToWindow];
	
	if(! self.window){
		[self stopInertiaTimer];
		return;
	}
	
	if(! theWheel){
		theWheel = [[UIImageView alloc] initWithImage:self.wheelImage];
		theWheel.userInteractionEnabled = NO;
		theWheel.image = self.wheelImage;
		theWheel.transform = CGAffineTransformMakeRotation(self.wheelInitialRotation);
		[self addSubview:theWheel];
		
		wheelSize = self.wheelImage.size;
	}
	
	[self fixPositionByIndexAnimated:NO];
	
}


#pragma mark -

- (void)stopInertiaTimer{
	if(inertiaTimer){
		[inertiaTimer invalidate];
		inertiaTimer = nil;
	}
}


#pragma mark -


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	isTouchDown = YES;
	isTouchMoved = NO;
	isRotatingByTimerWhenThisTapHappen = NO;
	
	if(inertiaTimer){
		isRotatingByTimerWhenThisTapHappen = YES;
		[self stopInertiaTimer];
	}
	
	CGPoint pos = [[touches anyObject] locationInView:self];
	lastAtan2 = atan2(pos.y - wheelSize.width / 2,
					  pos.x - wheelSize.height / 2);
	
	lastMovedTime1 = 0;
	lastMovedTime2 = 0;
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	isTouchMoved = YES;
	
	if(isTouchDown){
		CGPoint pos = [[touches anyObject] locationInView:self];
		float thisAtan2 = atan2(pos.y - wheelSize.width / 2,
								pos.x - wheelSize.height / 2);
		
		float dur = thisAtan2 - lastAtan2;
		
		if(self.continuousTrigger){
			self.currentRotation += dur;
		}else{
			_currentRotation += dur;
			[self rotateToCurrentRotationAnimated:NO];
		}
		
		lastAtan2 = thisAtan2;
		
		lastMovedTime1 = lastMovedTime2;
		lastMovedTime2 = [NSDate timeIntervalSinceReferenceDate];
		
		lastDuration = dur;
		
	}
	
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
	isTouchDown = NO;
	
	[self handleTouchesEndedOrCancelled:touches];
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	isTouchDown = NO;
	
	[self handleTouchesEndedOrCancelled:touches];
	
}


- (void)handleTouchesEndedOrCancelled:(NSSet *)touches{
	if(isTouchMoved){
		[self continueByInertia];
		
	}else{
		[self fixPositionByRotationAnimated:YES];
		
	}
	
}


#pragma mark -


- (void)continueByInertia{
	if(inertiaTimer){
		return;
	}
	
	if(lastMovedTime1 == lastMovedTime2){
		[self fixPositionByRotationAnimated:YES];
		return;
	}
	
	NSTimeInterval interval = (lastMovedTime2 - lastMovedTime1);
	
	if(interval > kAZWheelPickerInertiaTimerAcceptableMaxInterval){
		[self fixPositionByRotationAnimated:YES];
		return;
	}
	
	currentSpeed = lastDuration;
	
	if(interval < kAZWheelPickerInertiaTimerAcceptableMinInterval){
		currentSpeed = kAZWheelPickerInertiaTimerAcceptableMinInterval * currentSpeed / interval;
		interval = kAZWheelPickerInertiaTimerAcceptableMinInterval;
	}
	
	inertiaTimer = [NSTimer scheduledTimerWithTimeInterval:interval
													target:self selector:@selector(onInertiaTimer)
												  userInfo:nil repeats:YES];
	[self onInertiaTimer]; // excute once immediately
	
}

- (void)onInertiaTimer{
	if(self.continuousTrigger){
		self.currentRotation += currentSpeed;
	}else{
		_currentRotation += currentSpeed;
		[self rotateToCurrentRotationAnimated:NO];
	}
	
	currentSpeed *= self.animationDecelerationFactor;
	
	if(fabsf(currentSpeed) < 0.01){
		[self stopInertiaTimer];
		[self fixPositionByRotationAnimated:YES];
	}
	
}


#pragma mark -

- (float)index2rotation:(int)index{
	float r = self.wheelInitialRotation - (M_PI * 2 / self.numberOfSectors) * index;
	return r;
}

- (int)rotation2index:(float)rotation{
	float rotation2 = rotation + (M_PI * 2 / self.numberOfSectors) / 2;
	
	int index = ((int)floorf((rotation2 - self.wheelInitialRotation) / (M_PI * 2 / self.numberOfSectors))) % self.numberOfSectors;
	if(index > 0){
		index = self.numberOfSectors - index;
	}else if(index < 0){
		index = - index;
	}
	return index;
}



- (void)rotateToCurrentRotationAnimated:(BOOL)animated{
	dispatch_block_t animationBlock = ^{
		theWheel.transform = CGAffineTransformMakeRotation(self.currentRotation);
	};
	
	if(animated){
		[UIView animateWithDuration:0.3 animations:^{
			animationBlock();
		} completion:^(BOOL finished) {
			
		}];
	}else{
		animationBlock();
	}
	
}


- (void)setCurrentRotation:(float)currentRotation{
	[self setCurrentRotation:currentRotation animated:NO];
}

- (void)setCurrentRotation:(float)currentRotation animated:(BOOL)animated{
	_currentRotation = currentRotation;
	
	int index = [self rotation2index:currentRotation];
	
	BOOL isChanged = (_selectedIndex != index);
	_selectedIndex = index;
	
	[self rotateToCurrentRotationAnimated:animated];
	
	if(isChanged){
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
	
}


- (void)setSelectedIndex:(int)selectedIndex{
	[self setSelectedIndex:selectedIndex animated:NO];
}

- (void)setSelectedIndex:(int)selectedIndex animated:(BOOL)animated{
	BOOL isChanged = (_selectedIndex != selectedIndex);
	
	_selectedIndex = selectedIndex;
	
	float rotation = [self index2rotation:selectedIndex];
	_currentRotation = rotation;
	
	[self rotateToCurrentRotationAnimated:animated];
	
	if(isChanged){
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
	
}


- (void)fixPositionByRotationAnimated:(BOOL)animated{
	int index = [self rotation2index:self.currentRotation];
	[self setSelectedIndex:index animated:animated];
}

- (void)fixPositionByIndexAnimated:(BOOL)animated{
	int i = self.selectedIndex;
	[self setSelectedIndex:i animated:animated];
}




@end
