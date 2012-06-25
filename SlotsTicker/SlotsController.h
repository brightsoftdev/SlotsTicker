//
//  SlotsController.h
//  SlotsTickerDemo
//
//  Created by Mark Glagola on 6/21/12.
//  Copyright (c) 2012 Independent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface SlotsController : CALayer

//Array containing all SlotLayers
@property (nonatomic) NSMutableArray *slots;

//the font size for all SlotLayers
@property (nonatomic) CGFloat fontSize;

//the font color for all SlotLayers
@property (nonatomic) CGColorRef color;

//Set this to animate
//MUST BE a positive # between 0 and 999999999
@property (nonatomic) int value;

//the slot animation speed for all SlotLayers
@property (nonatomic) float speed;

@end
