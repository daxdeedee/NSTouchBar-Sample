//
//  GTouchBar.h
//  TouchBar_ObjectiveC
//
//  Created by LeeKunHee on 2017. 10. 26..
//  Copyright © 2017년 bruce. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GTouchBar : NSTouchBar
@property int touchBarType;

- (nullable NSTouchBar *) makeTouchBar;

@end
