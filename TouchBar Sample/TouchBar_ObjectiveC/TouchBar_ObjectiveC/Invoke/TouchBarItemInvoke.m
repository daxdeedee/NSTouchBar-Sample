//
//  TouchBarItemInvoke.m
//  TouchBar_ObjectiveC
//
//  Created by LeeKunHee on 2017. 11. 20..
//  Copyright © 2017년 bruce. All rights reserved.
//

#import "TouchBarItemInvoke.h"

@implementation TouchBarItemInvoke

-(IBAction)invokeButton:(id)sender {
    NSButton* button = (NSButton*) sender;
    NSLog(@"Clicked %@", button.title);
}

-(IBAction)invokeSegmentedControl:(id)sender {
    NSLog(@"invokeSegmentedControl");
}

-(IBAction)invokeSlider:(NSSlider *)sender{
    NSLog(@"Slider Value = %zd", sender.integerValue);
}

- (void)invokeColorPicker:(id)sender{
    NSLog(@"Color Chosen = %@\n", ((NSColorPickerTouchBarItem *)sender).color);
}



@end
