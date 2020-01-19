//
//  AppDelegate.m
//  Cocoa Preferences Panel
//
//  Created by Nikola Grujic on 15/01/2020.
//  Copyright © 2020 Mac Developers. All rights reserved.
//

#import "AppDelegate.h"
#import "PreferenceController.h"

@implementation AppDelegate

#pragma mark Class methods

+(void)initialize
{
    [self registerDefaultPreferences];
}

+ (void)registerDefaultPreferences
{
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    
    NSError *error = nil;
    NSData *colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSColor yellowColor]
                                                requiringSecureCoding:YES
                                                                error:&error];
    
    if (error != nil)
    {
        NSLog(@"Error code:%d", (int)error.code);
    }
    
    [defaultValues setObject:colorAsData forKey:WindowBackgroundColor];
    [defaultValues setObject:[NSNumber numberWithBool:YES] forKey:WindowResizeEnabledFlag];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
}

- (void)awakeFromNib
{
    [self setBackgroundColor:[PreferenceController preferenceWindowBackgroundColor]];
    [self setResizeEnabled:[PreferenceController preferenceWindowResizeEnabledFlag]];
}

- (void)setBackgroundColor:(NSColor*) color
{
    [_window setBackgroundColor:color];
}

- (void)setResizeEnabled:(BOOL) enabled
{
    if (enabled == YES)
    {
        _window.styleMask |= NSWindowStyleMaskResizable;
    }
    else
    {
        _window.styleMask &= ~NSWindowStyleMaskResizable;
    }
}

#pragma mark Action methods

- (IBAction)showPreferencePanel:(id)sender
{
    if (!preferenceController)
    {
        preferenceController = [[PreferenceController alloc] init];
    }
    
    [preferenceController showWindow:self];
}

@end
