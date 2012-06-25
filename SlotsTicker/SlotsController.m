//
//  SlotsController.m
//  SlotsTickerDemo
//
//  Created by Mark Glagola on 6/21/12.
//  Copyright (c) 2012 Independent. All rights reserved.
//

#import "SlotsController.h"
#import "SlotLayer.h"

@interface SlotsController ()
{
    NSMutableArray *digits;
}

@end

@implementation SlotsController

@synthesize slots = _slots, fontSize = _fontSize, value = _value, speed = _speed, color = _color;

- (NSMutableArray*) slots
{
    if (_slots == nil) {
        _slots = [[NSMutableArray alloc] init];            
    }
    return _slots;
}

- (void) setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    for (SlotLayer *slot in self.slots) {
        slot.fontSize = _fontSize;
        slot.position = CGPointMake((slot.fontSize * [self.slots indexOfObject:slot] * 0.5f) + slot.fontSize*.5, slot.fontSize*.5);
    }
    
}

- (void) setColor:(CGColorRef)color
{
    _color = color;
    for (SlotLayer *slot in self.slots) {
        slot.color = _color;
    }
}

- (void) setValue:(int)value
{
    //removes all old data
    [digits removeAllObjects];
    
    int integer = value;

    //make sure the integer is not too big
    if (integer > 999999999)
        integer = 999999999;
    else if (integer < 0)
        integer = 0;
    
    int length = ((NSString*)[NSString stringWithFormat:@"%i",integer]).length;

    //seperate the integer into digits
    for (int i = 0; i < length; i++) 
    {
        int digit = integer % 10;
        [digits addObject:[NSNumber numberWithInt:digit]];
        integer = integer / 10;
    }
    
    //animate slots
    for (int i = 0; i < length; i++)
    {
        SlotLayer *slot = (SlotLayer*) [self.slots objectAtIndex:8-i];
        int newValue = [[digits objectAtIndex:i] intValue];
        slot.value = newValue;
    }
}

- (void) setSpeed:(float)speed
{
    _speed = speed;
    for (SlotLayer *slot in self.slots)
        slot.speed = _speed;
}

- (id) init
{
    if (self = [super init])
    {
        digits = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 9; i++) {
            SlotLayer *slot = [[SlotLayer alloc] init];
            slot.position = CGPointMake((slot.fontSize * i * .5) + slot.fontSize*.5, slot.fontSize*.5);
            [self.slots addObject:slot];
            [self addSublayer:slot];
            _fontSize = slot.fontSize;
        }
        
        self.speed = 5.0f;
    }
    return self;
}

@end
