# SlotsTicker

A Slot Machine like ticker using CoreAnimation.

## Example Screenshots
![ScreenShot 1](http://cloud.github.com/downloads/mglagola/SlotsTicker/screen1.png)
![ScreenShot 2](http://cloud.github.com/downloads/mglagola/SlotsTicker/screen2.png)
![ScreenShot 3](http://cloud.github.com/downloads/mglagola/SlotsTicker/screen3.png)

## Setup

- Add the "SlotsTicker" Folder to your project
- Add QuartzCore.framework to your project
- Import "SlotsController.h"

## Example Useage

### Create SlotsController:

```objc
SlotsController *slots = [[SlotsController alloc] init];
```
### Add the controller to the layer:

```objc
[self.view.layer addSublayer:slots];
```
### Animate the slots:

```objc
//by setting the value property
//the slots will animate from there current value
//to the new value just set
slots.value = 123456789;
```

### Edit the slots attributes:

```objc
//set font size
slots.fontSize = 40.0f;
    
//position the slots
slots.position = CGPointMake(slots.fontSize*1.5, 160);
    
//set the slots color
slots.color = [[UIColor redColor] CGColor];
```

