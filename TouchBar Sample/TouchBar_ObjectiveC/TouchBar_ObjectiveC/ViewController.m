//
//  ViewController.m
//  TouchBar_ObjectiveC
//
//  Created by LeeKunHee on 2017. 10. 26..
//  Copyright © 2017년 bruce. All rights reserved.
//

#import "ViewController.h"
#import "GTouchBar.h"
#import "TouchBarDefine.h"

@interface ViewController()
@property GTouchBar* mGTouchBar;
@property (weak, nonatomic) IBOutlet NSButton *buttonTypeRadio;
@property (weak, nonatomic) IBOutlet NSButton *segmentedControlTypeRadio;
@property (weak, nonatomic) IBOutlet NSButton *sliderTypeRadio;
@property (weak, nonatomic) IBOutlet NSButton *popoverTypeRadio;
@property (weak, nonatomic) IBOutlet NSButton *colorPickerTypeRadio;
@property (weak, nonatomic) IBOutlet NSButton *scrubberTypeRadio;
@property (weak, nonatomic) IBOutlet NSButton *animationTypeRadio;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self setTouchBarView];
    
    [self invalidateTouchBar];
}

- (void)invalidateTouchBar {
    // We need to set the first responder status when one of our radio knobs was clicked.
    [self.view.window makeFirstResponder:self.view];
    // Set to nil so makeTouchBar can be called again to re-create our NSTouchBarItem instances.
    self.touchBar = nil;
}

-(void) setTouchBarView{
    if (NSAppKitVersionNumber > 1504) {//NSAppKitVersionNumber10_12
        self.mGTouchBar = [[GTouchBar alloc] init];
    }
}


//#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101201
- (NSTouchBar *)makeTouchBar{
    return [self.mGTouchBar makeTouchBar];
}
//#endif

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

- (IBAction)btnAction:(id)sender {
    [self invalidateTouchBar];
}

- (IBAction)changeTouchBarType:(id)sender {
    [self initButtonState];
    
    NSButton* button = (NSButton*) sender;
    switch (button.tag) {
        case 0:
            [self.buttonTypeRadio setState:NSOnState];
            [self.mGTouchBar setTouchBarType:BUTTON_TYPE];
            break;
        case 1:
            [self.segmentedControlTypeRadio setState:NSOnState];
            [self.mGTouchBar setTouchBarType:SEGMENTED_CONTROL_TYPE];
            break;
        case 2:
            [self.sliderTypeRadio setState:NSOnState];
            [self.mGTouchBar setTouchBarType:SLIDER_TYPE];
            break;
        case 3:
            [self.popoverTypeRadio setState:NSOnState];
            [self.mGTouchBar setTouchBarType:POPOVER_TYPE];
            break;
        case 4:
            [self.colorPickerTypeRadio setState:NSOnState];
            [self.mGTouchBar setTouchBarType:COLOR_PICKER_TYPE];
            break;
        case 5:
            [self.scrubberTypeRadio setState:NSOnState];
            [self.mGTouchBar setTouchBarType:SCRUBBER_TYPE];
            break;
        case 6:
            [self.animationTypeRadio setState:NSOnState];
            [self.mGTouchBar setTouchBarType:ANIMATION_TYPE];
            break;
        default:
            break;
    }
    [self invalidateTouchBar];
}

-(void) initButtonState {
    [self.buttonTypeRadio setState:NSOffState];
    [self.segmentedControlTypeRadio setState:NSOffState];
    [self.sliderTypeRadio setState:NSOffState];
    [self.popoverTypeRadio setState:NSOffState];
    [self.colorPickerTypeRadio setState:NSOffState];
    [self.scrubberTypeRadio setState:NSOffState];
    [self.animationTypeRadio setState:NSOffState];
}



@end
