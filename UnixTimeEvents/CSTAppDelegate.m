//
//  CSTAppDelegate.m
//  UnixTimeEvents
//
//  Created by Christopher Taylor on 8/8/13.
//  Copyright (c) 2013 Christopher Taylor. All rights reserved.
//

@implementation CSTAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    __weak CSTAppDelegate * me = self;
    
    [self.window registerKeyUp:VK_SPACE handler:^(long long timestamp) {
        me.label.stringValue = [NSString stringWithFormat:@"SPACE UP at unixts: %lld", timestamp];
    }];

    [self.window registerKeyUp:VK_SPACE handler:^(long long timestamp) {
        NSLog ( @"SPACE UP at unixts: %lld", timestamp );
    }];

    [self.window registerKeyDown:VK_SPACE handler:^(long long timestamp) {
        me.label.stringValue = [NSString stringWithFormat:@"SPACE DOWN at unixts: %lld", timestamp];
    }];

}

@end
