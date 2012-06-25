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

@synthesize slots = _slots, fontSize = _fontSize, value = _value, speed = _speed, color = _color, size = _size;

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
    int length = ((NSString*)[NSString stringWithFormat:@"%i",integer]).length;

    //make sure the integer is not too big
    if (length > self.size) {
        integer = pow(10, self.size) - 1;
        length = self.size;
    }
    else if (integer < 0) {
        integer = 0;
    }
    
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
        SlotLayer *slot = (SlotLayer*) [self.slots objectAtIndex:(self.size-1)-i];
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


- (void) setDefaults
{
    digits = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.size; i++) {
        SlotLayer *slot = [[SlotLayer alloc] init];
        slot.position = CGPointMake((slot.fontSize * i * .5) + slot.fontSize*.5, slot.fontSize*.5);
        [self.slots addObject:slot];
        [self addSublayer:slot];
        _fontSize = slot.fontSize;
    }
    
    self.speed = 5.0f;
}

- (id) init
{
    if (self = [super init])
    {
        _size = 9;
        [self setDefaults];
    }
    return self;
}

- (id) initWithSize:(int) size
{
    if (self = [super init])
    {
        if (size > 9)
            _size = 9;
        else if (size < 1)
            _size = 1;
        else
            _size = size;
        
        [self setDefaults];
    }
    return self;
}

@end
