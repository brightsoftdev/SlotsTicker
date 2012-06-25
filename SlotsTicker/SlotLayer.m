//
//  SlotLayer.m
//  SlotsTickerDemo
//
//  Created by Mark Glagola on 6/21/12.
//  Copyright (c) 2012 Independent. All rights reserved.
//

#import "SlotLayer.h"

@interface SlotLayer ()

//the parent layer of all CATextLayers (0 - 9) 
@property (nonatomic) CALayer *numbersLayer;

//Array containing all CATextLayers (0 - 9)
@property (nonatomic) NSMutableArray *numbers;

@end

@implementation SlotLayer

@synthesize numbers = _numbers, fontSize = _fontSize, numbersLayer = _numbersLayer, value = _value, speed = _speed, color = _color;

- (CALayer*) numbersLayer
{
    if (_numbersLayer == nil) {
        _numbersLayer = [[CALayer alloc] init];
        _numbersLayer.frame = CGRectMake(0, 0, self.fontSize, self.fontSize);
        _numbersLayer.position = CGPointMake(0, 0);
    }
    return _numbersLayer;
}

- (NSMutableArray*) numbers
{
    if (_numbers == nil)
        _numbers = [[NSMutableArray alloc] initWithCapacity:10];
    return _numbers;
}

//reset positioning according to new font size 
- (void) setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    for (CATextLayer *textLayer in self.numbers) {
        textLayer.fontSize = _fontSize;
        textLayer.frame = CGRectMake(textLayer.frame.origin.x,textLayer.frame.origin.y, _fontSize, _fontSize);
        textLayer.position = CGPointMake(_fontSize, _fontSize * [self.numbers indexOfObject:textLayer] + _fontSize);
    }
    CGRect frame = self.numbersLayer.frame;
    frame.size = CGSizeMake(_fontSize, _fontSize);
    self.numbersLayer.frame = frame;
    self.numbersLayer.position = CGPointMake(0, 0);
    
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y, _fontSize, _fontSize);
}

//animates when setting a new value 
- (void) setValue:(int)value
{
    //Only animate if a valid value (0 - 9)
    if (value <= 9 && value >= 0)
        [self animateTo:value];
}

- (void) setSpeed:(float)speed
{
    _speed = speed / (speed * speed);
}

- (void) setColor:(CGColorRef)color
{
    _color = color;
    for (CATextLayer *textLayer in self.numbers) {
        textLayer.foregroundColor = _color;
    }
}

- (id) init
{
    if (self = [super init])
    {        
        //sets up defaults
        _fontSize = 20.0f;
        
        self.frame = CGRectMake(0, 0, self.fontSize, self.fontSize);
        self.masksToBounds = YES;
         
        for (int i = 0; i <= 9; i++)
        {
            CATextLayer *textLayer = [[CATextLayer alloc] init];
            textLayer.string = [NSString stringWithFormat:@"%i",i];
            textLayer.wrapped = YES;
            textLayer.fontSize = self.fontSize;
            textLayer.alignmentMode = kCAAlignmentCenter;
            textLayer.frame = CGRectMake(0,0, self.fontSize, self.fontSize);
            textLayer.position = CGPointMake(self.fontSize, self.fontSize * i + self.fontSize);

            [self.numbersLayer addSublayer:textLayer];
            [self.numbers addObject:textLayer];
        }
        
        [self addSublayer:self.numbersLayer];
    }
    return self;
}

//Animates the numbersLayer to the targetValue
//To animate, set the "value" property to an integer between 0 and 9 
- (void) animateTo:(int)targetValue
{        
    float durration =  fabsf((targetValue - self.value)* self.speed);
    
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:durration] forKey:kCATransactionAnimationDuration];
    
    CGPoint newPos = self.numbersLayer.position;
    int distanceY = self.fontSize * abs(targetValue - self.value);
    
    //animate downward
    if (targetValue < self.value) 
        newPos.y += distanceY;
    //animate upward
    else if (targetValue > self.value) 
        newPos.y -= distanceY; 
    
    self.numbersLayer.position = newPos;
    _value = targetValue;
    
    [CATransaction commit];
}
@end
