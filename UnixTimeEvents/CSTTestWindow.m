//
//  CSTTestWindow.m
//  UnixTimeEvents
//
//  Created by Christopher Taylor on 8/8/13.
//  Copyright (c) 2013 Christopher Taylor. All rights reserved.
//

@interface CSTTestWindow()
@property (nonatomic,strong) CSTEventManager * events;
@end

@implementation CSTTestWindow
-(id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    if ( self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag])
    {
        self.events = [[CSTEventManager alloc] init];
    }
    return self;
}
    
- (BOOL)acceptsFirstResponder {
    return YES;
}

- (void)keyDown:(NSEvent *)theEvent {
    [self.events keyDown:theEvent.keyCode time:theEvent.unixtimestamp];
}

-(void)keyUp:(NSEvent*)theEvent {
    [self.events keyUp:theEvent.keyCode time:theEvent.unixtimestamp];
}

-(void)registerKeyUp:(NSUInteger)keycode handler:(CSTEventHandler)handler {
    [self.events registerKeyUp:keycode handler:handler];
}
-(void)registerKeyDown:(NSUInteger)keycode handler:(CSTEventHandler)handler {
    [self.events registerKeyDown:keycode handler:handler];
}

@end
