//
//  NSEvent+CSTUnixTimestamp.h
//  UnixTimeEvents
//
//  Created by Christopher Taylor on 8/8/13.
//  Copyright (c) 2013 Christopher Taylor. All rights reserved.
//

@interface NSEvent (CSTUnixTimestamp)
@property (nonatomic,readonly,getter=getUnixTimestamp) long long unixtimestamp;
@end
