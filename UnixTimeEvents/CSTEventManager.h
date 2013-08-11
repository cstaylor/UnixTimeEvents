//
//  CSTEventManager.h
//  UnixTimeEvents
//
//  Created by Christopher Taylor on 8/11/13.
//  Copyright (c) 2013 Christopher Taylor. All rights reserved.
//

@interface CSTEventManager : NSObject<CSTEventSource>
-(void)keyUp:(NSUInteger)code time:(long long)unixtimestamp;
-(void)keyDown:(NSUInteger)code time:(long long)unixtimestamp;
@property (nonatomic,assign) BOOL keyDownRepeat;
@end
