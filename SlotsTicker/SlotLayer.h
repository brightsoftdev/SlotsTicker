//
//  SlotLayer.h
//  SlotsTickerDemo
//
//  Created by Mark Glagola on 6/21/12.
//  Copyright (c) 2012 Independent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SlotLayer : CALayer

//the current value (number) that is being shown (0 - 9)
//SET THIS to animate the slot ticker
@property (nonatomic) int value;

//the font size for all CATextLayers (0 - 9)
@property (nonatomic) CGFloat fontSize;

//the font color for all CATextLayers (0 - 9)
@property (nonatomic) CGColorRef color;

//the speed at which the slots animate
@property (nonatomic) float speed;

@end
