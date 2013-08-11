//
//  CSTEventManager.m
//  UnixTimeEvents
//
//  Created by Christopher Taylor on 8/11/13.
//  Copyright (c) 2013 Christopher Taylor. All rights reserved.
//

@interface CSTEventManager() {
    NSUInteger lastKeyDown;
}
@property (nonatomic,strong) NSMutableDictionary *upHandlers;
@property (nonatomic,strong) NSMutableDictionary *downHandlers;
@property (nonatomic,strong) NSMutableIndexSet * upFlags;
@property (nonatomic,strong) NSMutableIndexSet * downFlags;
-(instancetype)init;
@end

@implementation CSTEventManager
-(instancetype)init {
    if ( self = [super init] ) {
        self.upFlags = [[NSMutableIndexSet alloc] init];
        self.downFlags = [[NSMutableIndexSet alloc] init];
        self.upHandlers = [[NSMutableDictionary alloc] init];
        self.downHandlers = [[NSMutableDictionary alloc] init];
        lastKeyDown = 0;
    }
    return self;
}

-(void)sharedRegister:(NSUInteger)keycode indexSet:(NSMutableIndexSet*)set lut:(NSMutableDictionary*)dictionary handler:(CSTEventHandler)handler {
    NSNumber * keycode_obj = [NSNumber numberWithUnsignedInteger:keycode];
    NSMutableArray * handler_array = nil;
    if ( [set containsIndex:keycode] ) {
        handler_array = (NSMutableArray*)dictionary[keycode_obj];
    } else {
        handler_array = [[NSMutableArray alloc] init];
        dictionary[keycode_obj] = handler_array;
        [set addIndex:keycode];
    }
    [handler_array addObject:[handler copy]];
}

-(void)registerKeyUp:(NSUInteger)keycode handler:(CSTEventHandler)handler {
    [self sharedRegister:keycode
          indexSet:self.upFlags
          lut:self.upHandlers
          handler:handler];
}

-(void)registerKeyDown:(NSUInteger)keycode handler:(CSTEventHandler)handler {
    [self sharedRegister:keycode
          indexSet:self.downFlags
          lut:self.downHandlers
          handler:handler];
}

-(void)sharedFiring:(NSUInteger)keycode indexSet:(NSMutableIndexSet*)set lut:(NSMutableDictionary*)dictionary time:(long long)time {
    if ( [set containsIndex:keycode] ) {
        NSNumber * keycode_obj = [NSNumber numberWithUnsignedInteger:keycode];
        NSArray * handlers = dictionary[keycode_obj];
        [handlers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            CSTEventHandler handler = (CSTEventHandler)obj;
            handler ( time );
        }];
    }
}

-(void)keyUp:(NSUInteger)code time:(long long)unixtimestamp {
    [self sharedFiring:code indexSet:self.upFlags lut:self.upHandlers time:unixtimestamp];
    lastKeyDown = 0;
}

-(void)keyDown:(NSUInteger)code time:(long long)unixtimestamp {
    if ( !self.keyDownRepeat && code == lastKeyDown ) return;
    [self sharedFiring:code indexSet:self.downFlags lut:self.downHandlers time:unixtimestamp];
    lastKeyDown = code;
}

@end
