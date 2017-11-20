//
//  GTouchBar.m
//  TouchBar_ObjectiveC
//
//  Created by LeeKunHee on 2017. 10. 26..
//  Copyright © 2017년 bruce. All rights reserved.
//

#import "GTouchBar.h"
#import "TouchBarDefine.h"
#import "TouchBarItemInvoke.h"
#import <QuartzCore/QuartzCore.h>

@interface GTouchBar()<NSTouchBarDelegate, NSScrubberDelegate, NSScrubberDataSource>
@property TouchBarItemInvoke* mTouchBarItemInvoke;
@end

@implementation GTouchBar

- (instancetype)init {
    self = [super init];
    if (self) {
        self.touchBarType = BUTTON_TYPE;
        self.mTouchBarItemInvoke = [TouchBarItemInvoke new];
        
    }
    return self;
}

- (nullable NSTouchBar *) makeTouchBar{
    NSTouchBar *touchBar = [[NSTouchBar alloc] init];
    touchBar.delegate = self;
    touchBar.customizationIdentifier = @"TOUCH_BAR";
    
    if(self.touchBarType == BUTTON_TYPE){
        touchBar.defaultItemIdentifiers = @[@"textButton", @"imageButton", @"button", NSTouchBarItemIdentifierOtherItemsProxy];
        touchBar.customizationAllowedItemIdentifiers = @[@"textButton", @"imageButton", @"button"];
    } else if(self.touchBarType == SEGMENTED_CONTROL_TYPE){
        touchBar.defaultItemIdentifiers = @[@"segmentedColtrol", NSTouchBarItemIdentifierOtherItemsProxy];
        touchBar.customizationAllowedItemIdentifiers = @[@"segmentedColtrol"];
    } else if(self.touchBarType == SLIDER_TYPE){
        touchBar.defaultItemIdentifiers = @[@"slider", NSTouchBarItemIdentifierOtherItemsProxy];
        touchBar.customizationAllowedItemIdentifiers = @[@"slider"];
    } else if(self.touchBarType == POPOVER_TYPE){
        touchBar.defaultItemIdentifiers = @[@"popover", NSTouchBarItemIdentifierOtherItemsProxy];
        touchBar.customizationAllowedItemIdentifiers = @[@"popover"];
    } else if(self.touchBarType == COLOR_PICKER_TYPE){
        touchBar.defaultItemIdentifiers = @[@"fontColorPicker", @"strokeColorPicker", @"fillColorPicker", NSTouchBarItemIdentifierOtherItemsProxy];
        touchBar.customizationAllowedItemIdentifiers = @[@"fontColorPicker", @"strokeColorPicker", @"fillColorPicker"];
    } else if(self.touchBarType == SCRUBBER_TYPE){
        touchBar.defaultItemIdentifiers = @[@"scrubber", NSTouchBarItemIdentifierOtherItemsProxy];
        touchBar.customizationAllowedItemIdentifiers = @[@"scrubber"];
    } else if(self.touchBarType == ANIMATION_TYPE){
        touchBar.defaultItemIdentifiers = @[@"moveLabel", NSTouchBarItemIdentifierOtherItemsProxy];
        touchBar.customizationAllowedItemIdentifiers = @[@"moveLabel"];
    }
    
    return touchBar;
}

- (nullable NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier {
    if([identifier isEqualToString:@"textButton"]){
        return [self getTextButton];
    } else if([identifier isEqualToString:@"imageButton"]){
        return [self getImageButton];
    } else if([identifier isEqualToString:@"button"]){
        return [self getTextImageButton];
    } else if([identifier isEqualToString:@"segmentedColtrol"]){
        return [self getTestSegmentedControl];
    } else if([identifier isEqualToString:@"slider"]){
        return [self getSliderItem];
    } else if ([identifier isEqualToString:@"popover"]){
        return [self getPopoverItem];
    } else if ([identifier isEqualToString:@"fontColorPicker"]){
        return [self getFontColorPicker];
    } else if ([identifier isEqualToString:@"strokeColorPicker"]){
        return [self getStrokeColorPicker];
    } else if ([identifier isEqualToString:@"fillColorPicker"]){
        return [self getFillColorPicker];
    } else if([identifier isEqualToString:@"moveLabel"]){
        return [self moveTextLabel];
    } else if([identifier isEqualToString:@"scrubber"]){
        return [self getScrubber];
    }
    return nil;
}

// Button TYpe
-(NSCustomTouchBarItem*) getTextButton{
    NSButton* testButton = [NSButton buttonWithTitle:@"textButton" target:self.mTouchBarItemInvoke action:@selector(invokeButton:)];

    NSCustomTouchBarItem* touchBarItem = [[NSCustomTouchBarItem alloc] initWithIdentifier:@"textButton"];
    touchBarItem.view = testButton;
    touchBarItem.customizationLabel = @"textButton.label";
    return touchBarItem;
}

-(NSCustomTouchBarItem*) getImageButton{
    NSButton* testButton = [NSButton buttonWithImage:[NSImage imageNamed:NSImageNameTouchBarHistoryTemplate] target:self.mTouchBarItemInvoke action:@selector(invokeButton:)];
    
    NSCustomTouchBarItem* touchBarItem = [[NSCustomTouchBarItem alloc] initWithIdentifier:@"imageButton"];
    touchBarItem.view = testButton;
    touchBarItem.customizationLabel = @"imageButton.label";
    return touchBarItem;
}

-(NSCustomTouchBarItem*) getTextImageButton{
    NSButton* testButton = [NSButton buttonWithTitle:@"button" image:[NSImage imageNamed:NSImageNameTouchBarHistoryTemplate] target:self.mTouchBarItemInvoke action:@selector(invokeButton:)];
    
    NSCustomTouchBarItem* touchBarItem = [[NSCustomTouchBarItem alloc] initWithIdentifier:@"button"];
    touchBarItem.view = testButton;
    touchBarItem.customizationLabel = @"button.label";
    return touchBarItem;
}

// Segmented Type
-(NSCustomTouchBarItem*) getTestSegmentedControl {
    NSArray* images;
    images = @[[NSImage imageNamed:NSImageNameTouchBarTextLeftAlignTemplate], [NSImage imageNamed:NSImageNameTouchBarTextCenterAlignTemplate], [NSImage imageNamed:NSImageNameTouchBarTextRightAlignTemplate] , [NSImage imageNamed:NSImageNameTouchBarTextJustifiedAlignTemplate]];
    
    NSSegmentedControl* alignmentSegmentedControl = [NSSegmentedControl segmentedControlWithImages:images trackingMode:NSSegmentSwitchTrackingSelectOne target:self.mTouchBarItemInvoke action:@selector(invokeSegmentedControl:)];
    
    NSCustomTouchBarItem* touchBarItem = [[NSCustomTouchBarItem alloc] initWithIdentifier:@"segmentedColtrol"];
    touchBarItem.view = alignmentSegmentedControl;
    
    return touchBarItem;
}

// slider Type

-(NSSliderTouchBarItem*) getSliderItem{
    NSSliderTouchBarItem *sliderTouchBarItem = [[NSSliderTouchBarItem alloc] initWithIdentifier:@"slider"];
    [sliderTouchBarItem.slider setMinValue:0.0f];
    [sliderTouchBarItem.slider setMaxValue:100.0f];
    [sliderTouchBarItem.slider setDoubleValue:50.0f];
    [sliderTouchBarItem.slider setContinuous:YES];
    [sliderTouchBarItem.slider setTarget:self.mTouchBarItemInvoke];
    [sliderTouchBarItem.slider setAction:@selector(invokeSlider:)];
    [sliderTouchBarItem setLabel:@"Slider"];
    [sliderTouchBarItem setCustomizationLabel:@"Slider"];
    
    [sliderTouchBarItem.slider bind:NSValueBinding
                                toObject:[NSUserDefaultsController sharedUserDefaultsController]
                             withKeyPath:@"values.slider"
                                 options:nil];
    return sliderTouchBarItem;
}

// popover
-(NSPopoverTouchBarItem*)getPopoverItem{
    NSPopoverTouchBarItem *popoverTouchBarItem = [[NSPopoverTouchBarItem alloc] initWithIdentifier:@"popover"];
    
    popoverTouchBarItem.collapsedRepresentationLabel = @"popover";
    //popoverTouchBarItem.collapsedRepresentationImage = [NSImage imageNamed:@"touchbar_copyformat"];
    
    NSTouchBar *secondaryTouchBar = [[NSTouchBar alloc] init];
    secondaryTouchBar.delegate = self;
    secondaryTouchBar.defaultItemIdentifiers = @[@"segmentedColtrol"];
    secondaryTouchBar.customizationAllowedItemIdentifiers = @[@"segmentedColtrol"];
    
    popoverTouchBarItem.popoverTouchBar = secondaryTouchBar;
    popoverTouchBarItem.customizationLabel = @"popover";
    popoverTouchBarItem.pressAndHoldTouchBar = secondaryTouchBar; // press위치에 secondview 생성
    popoverTouchBarItem.showsCloseButton = YES;
    return popoverTouchBarItem;
}

// colorPicker Type

-(NSColorPickerTouchBarItem*) getFontColorPicker {
    NSColorPickerTouchBarItem *colorPickerItem = [NSColorPickerTouchBarItem colorPickerWithIdentifier:@"fontColorPicker" buttonImage:[NSImage imageNamed:NSImageNameTouchBarColorPickerFont]];
    [colorPickerItem setTarget:self.mTouchBarItemInvoke];
    [colorPickerItem setAction:@selector(invokeColorPicker:)];
    
    return colorPickerItem;
}
-(NSColorPickerTouchBarItem*) getStrokeColorPicker {
    NSColorPickerTouchBarItem *colorPickerItem = [NSColorPickerTouchBarItem colorPickerWithIdentifier:@"strokeColorPicker" buttonImage:[NSImage imageNamed:NSImageNameTouchBarColorPickerStroke]];
    [colorPickerItem setTarget:self.mTouchBarItemInvoke];
    [colorPickerItem setAction:@selector(invokeColorPicker:)];
    
    return colorPickerItem;
}
-(NSColorPickerTouchBarItem*) getFillColorPicker {
    NSColorPickerTouchBarItem *colorPickerItem = [NSColorPickerTouchBarItem colorPickerWithIdentifier:@"fillColorPicker" buttonImage:[NSImage imageNamed:NSImageNameTouchBarColorPickerFill]];
    [colorPickerItem setTarget:self.mTouchBarItemInvoke];
    [colorPickerItem setAction:@selector(invokeColorPicker:)];
    
    // set Sample Color
    [self setSampleColors:colorPickerItem];
    
    return colorPickerItem;
}

-(void) setSampleColors:(NSColorPickerTouchBarItem*)colorPicker{
    NSColorList* officeColors = [NSColorList.alloc initWithName:@"SampleColorList"];
    [officeColors setColor: [NSColor blackColor]
                    forKey: @"Black"];
    [officeColors setColor: [NSColor redColor]
                    forKey: @"Red"];
    [officeColors setColor: [NSColor greenColor]
                    forKey: @"Green"];
    [officeColors setColor: [NSColor blueColor]
                    forKey: @"Blue"];
    [officeColors setColor: [NSColor whiteColor]
                    forKey: @"White"];
    
    [colorPicker setColorList:officeColors];
}

-(NSCustomTouchBarItem*) getScrubber{
    NSCustomTouchBarItem* touchBarItem = [[NSCustomTouchBarItem alloc] initWithIdentifier:@"scrubber"];
    
    NSArray* testStrings = @[@"Alaska", @"Nevada", @"New York", @"Texas", @"Iowa", @"Florida"];
    
    NSScrubber *scrubber = [[NSScrubber alloc] init];
    scrubber.scrubberLayout = [[NSScrubberFlowLayout alloc] init];
    [scrubber registerClass:[NSScrubberTextItemView class] forItemIdentifier:@"textItem"];
    scrubber.mode = NSScrubberModeFree;
    scrubber.selectionBackgroundStyle = [NSScrubberSelectionStyle outlineOverlayStyle];
    scrubber.delegate = self;
    scrubber.dataSource = self;
    
    touchBarItem.view = scrubber;
    
    return touchBarItem;
}



-(NSCustomTouchBarItem*) moveTextLabel {
    NSView* customView = [[NSView alloc] initWithFrame:NSZeroRect];
    customView.wantsLayer = YES;
    customView.layer.backgroundColor = [NSColor grayColor].CGColor;
    customView.allowedTouchTypes = NSTouchTypeMaskDirect;
    
    NSTextField *textField = [NSTextField labelWithString:@"TouchBar Animation"];
    textField.wantsLayer = YES;
    textField.layer.backgroundColor = [NSColor grayColor].CGColor;
    [textField setTextColor:[NSColor blackColor]];
    
    CGFloat newTabWidth = 0;
    
    if ([[textField stringValue] length] > 0) {
        NSDictionary* attributes = [textField.attributedStringValue  attributesAtIndex:0  effectiveRange:nil] ;
        NSSize size = [textField.stringValue sizeWithAttributes:attributes] ;
        newTabWidth =  MAX(newTabWidth, size.width + 5) ;
    }
    [textField setFrame:NSMakeRect(0, 0, newTabWidth, textField.frame.size.height)];
    
    // bgColor animation
    CAKeyframeAnimation *colorsAnimation = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
    colorsAnimation.values = [NSArray arrayWithObjects: (id)[NSColor greenColor].CGColor,
                              (id)[NSColor yellowColor].CGColor, (id)[NSColor orangeColor].CGColor, (id)[NSColor greenColor].CGColor, nil];
    colorsAnimation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.25], [NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:0.75],[NSNumber numberWithFloat:1.0], nil];
    colorsAnimation.calculationMode = kCAAnimationPaced;
    colorsAnimation.removedOnCompletion = NO;
    colorsAnimation.fillMode = kCAFillModeForwards;
    colorsAnimation.duration = 1.0f;
    [colorsAnimation setRepeatCount:100.0];
    
    // set Animatiom to textField
    [textField.layer addAnimation:[self getLeftRightAnimation:newTabWidth] forKey:@"position"];
    [textField.layer addAnimation:[self getBgColorAnimation] forKey:@"backgroundColor"];
    
    [customView addSubview:textField];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    NSCustomTouchBarItem *touchBarItem = [[NSCustomTouchBarItem alloc] initWithIdentifier:@"moveLabel"];
    touchBarItem.view = customView;//textField;
    
    touchBarItem.customizationLabel = @"moveLabel.label";
    
    return touchBarItem;
}

- (CAKeyframeAnimation*) getLeftRightAnimation :(CGFloat)textWidth{
    CGFloat xx = 685 - textWidth;
    NSArray * pathArray = @[
                            [NSValue valueWithPoint:CGPointMake(0., 0.)],
                            [NSValue valueWithPoint:CGPointMake(xx, 0.)],
                            [NSValue valueWithPoint:CGPointMake(0., 0.)],
                            ];
    NSArray *keyTimesArray =
    [NSArray arrayWithObjects: @0, @0.5, @1, nil];
    // move text animation
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //pathAnimation.keyPath = @"position.x";
    pathAnimation.values = pathArray;
    pathAnimation.keyTimes = keyTimesArray;
    pathAnimation.duration = 10;
    pathAnimation.repeatCount = 10000000000000.0;
    
    return pathAnimation;
}

-(CAKeyframeAnimation*) getBgColorAnimation{
    // bgColor animation
    CAKeyframeAnimation *colorsAnimation = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
    colorsAnimation.values = [NSArray arrayWithObjects: (id)[NSColor greenColor].CGColor,
                              (id)[NSColor yellowColor].CGColor, (id)[NSColor orangeColor].CGColor, (id)[NSColor greenColor].CGColor, nil];
    colorsAnimation.keyTimes = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.25], [NSNumber numberWithFloat:0.5], [NSNumber numberWithFloat:0.75],[NSNumber numberWithFloat:1.0], nil];
    colorsAnimation.calculationMode = kCAAnimationPaced;
    colorsAnimation.removedOnCompletion = NO;
    colorsAnimation.fillMode = kCAFillModeForwards;
    colorsAnimation.duration = 1.0f;
    [colorsAnimation setRepeatCount:100.0];
    
    return colorsAnimation;
}

#pragma mark - NSScrubberDataSource

NSString *thumbnailScrubberItemIdentifier = @"thumbnailItem";
NSString *textScrubberItemIdentifier = @"textItem";
int MAX_COUNT = 40;

- (NSInteger)numberOfItemsForScrubber:(NSScrubber *)scrubber
{
    return MAX_COUNT;
}

- (NSScrubberItemView *)scrubber:(NSScrubber *)scrubber viewForItemAtIndex:(NSInteger)index
{
    NSScrubberTextItemView *itemView = [scrubber makeItemWithIdentifier:textScrubberItemIdentifier owner:nil];
    if (index < MAX_COUNT)
    {
        itemView.textField.stringValue = [@(index) stringValue];
    }
    return itemView;
}

#pragma mark - NSScrubberDelegate
- (void)scrubber:(NSScrubber *)scrubber didSelectItemAtIndex:(NSInteger)selectedIndex
{
    NSLog(@"SelectedScrubberIndex = %ld", selectedIndex);
}



@end
