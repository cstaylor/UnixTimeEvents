//
//  NSEvent+CSTUnixTimestamp.m
//  UnixTimeEvents
//
//  Created by Christopher Taylor on 8/8/13.
//  Copyright (c) 2013 Christopher Taylor. All rights reserved.
//

static long long offset;

static long long currentTimeInMillis ( ) {
    struct timeval t;
    gettimeofday(&t, NULL);
    long long millis = t.tv_sec * 1000 + t.tv_usec / 1000;
    return millis;
}

@implementation NSEvent (CSTUnixTimestamp)
-(long long)getUnixTimestamp {
    return (long long)(self.timestamp * 1000 + offset);
}

+(void)initialize {
    if ( self == [NSEvent class] ) {
        NSTimeInterval uptime = [NSProcessInfo processInfo].systemUptime;
        NSTimeInterval nowTimeIntervalSince1970 = [[NSDate date] timeIntervalSince1970];
        offset = (long long)((nowTimeIntervalSince1970 - uptime) * 1000);
    }
}
@end
