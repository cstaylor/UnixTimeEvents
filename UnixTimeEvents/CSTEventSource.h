//
//  CSTEventSource.h
//  UnixTimeEvents
//
//  Created by Christopher Taylor on 8/11/13.
//  Copyright (c) 2013 Christopher Taylor. All rights reserved.
//

@protocol CSTEventSource <NSObject>
-(void)registerKeyUp:(NSUInteger)keycode handler:(CSTEventHandler)handler;
-(void)registerKeyDown:(NSUInteger)keycode handler:(CSTEventHandler)handler;
@end
