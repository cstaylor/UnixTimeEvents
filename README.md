UnixTimeEvents
==============

NSEvent using NSTimeInterval (the time since your computer last booted) as the time when an event occurs.
For logging and other purposes, I'd rather have an absolute time, and coming from Java, I'm used to Unix time
(milliseconds since January 1st, 1970).

I found some great code on Stackoverflow for efficiently converting an NSTimeInterval to a Unix time.  Using an
Objective-C NSEvent category, I added a new property to NSEvent called "unixtimestamp" that gives you the value
in a long long:

NSEvent * someEvent = ...;
NSLog ( @"Here's the unixts: %lld", someEvent.unixtimestamp );

The relevant code is in NSEvent+CSTUnixTimestamp.h/m

At the same time, I wanted something similar to the Java AWT's addEventListener API for handling keyboard events
using blocks.

I'm not an AppKit expert, but from what I gathered the simplest technique is subclassing NSWindow and track the
keyboard events there.  Instead of plopping all of the handling code in there, I made a separate protocol and class
so you can quickly reuse the code in other NSResponder implementations.

The protocol is CSTEventSource.h, and the handling class is CSTEventManager.

Another thing that I found annoying is that NSEvent keycode constants don't exist for most of the standard keys, so
I created one for just a couple of keys as an example of how it could be done.  Check out CSTKeyConstants.h/m to
see how I did it (nothing special).

This project has a complete UI example.  When using these classes in your own project that builds everything from a nib,
remember to input the NSWindow subclass in the object inspector's Custom Class field.

Run the program and press the spacebar.  You should see the down and up events in the attached NSTextField, and the
up event is also logged using NSLog, showing how you can register more than one handler per event type.

Repeat keydown events are blocked by default in the CSTEventManager, but you can enable them using the property
keyDownRepeat:

CSTEventManager * manager = ...;
manager.keyDownRepeat = YES;
