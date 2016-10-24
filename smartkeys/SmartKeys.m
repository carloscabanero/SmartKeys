////////////////////////////////////////////////////////////////////////////////
//
// B L I N K
//
// Copyright (C) 2016 Blink Mobile Shell Project
//
// This file is part of Blink.
//
// Blink is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Blink is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Blink. If not, see <http://www.gnu.org/licenses/>.
//
// In addition, Blink is also subject to certain additional terms under
// GNU GPL version 3 section 7.
//
// You should have received a copy of these additional terms immediately
// following the terms and conditions of the GNU General Public License
// which accompanied the Blink Source Code. If not, see
// <http://www.github.com/blinksh/blink>.
//
////////////////////////////////////////////////////////////////////////////////

#import "SmartKeys.h"


static NSArray *HelperKeys = nil;
static NSArray *ArrowKeys = nil;
static NSArray *FKeys = nil;

@implementation SmartKeys {
  NSTimer *_timer;
}

@dynamic view;

+ (void)initialize {
  // Make an object. Do not even there to use dicts
  HelperKeys = @[
		 [[SmartKey alloc]initWithName:KbdEscKey symbol:UIKeyInputEscape], 
		    [[SmartKey alloc] initWithName:KbdTabKey symbol:@"\t"],
		    [[SmartKey alloc] initWithName:@"-" symbol:@"-"],
		    [[SmartKey alloc] initWithName:@"_" symbol:@"_"],
		    [[SmartKey alloc] initWithName:@"~" symbol:@"~"],
		    [[SmartKey alloc] initWithName:@"@" symbol:@"@"],
		    [[SmartKey alloc] initWithName:@"*" symbol:@"*"],
            [[SmartKey alloc] initWithName:@"|" symbol:@"|"],
            [[SmartKey alloc] initWithName:@"/" symbol:@"/"],
            [[SmartKey alloc] initWithName:@"\\" symbol:@"\\"],
            [[SmartKey alloc] initWithName:@"^" symbol:@"^"],
            [[SmartKey alloc] initWithName:@"[" symbol:@"["],
            [[SmartKey alloc] initWithName:@"]" symbol:@"]"],
            [[SmartKey alloc] initWithName:@"{" symbol:@"{"],
            [[SmartKey alloc] initWithName:@"}" symbol:@"}"]
		 ];
  
  ArrowKeys = @[
		[[SmartKey alloc]initWithName:KbdUpArrowKey symbol:UIKeyInputUpArrow],
		   [[SmartKey alloc]initWithName:KbdDownArrowKey symbol:UIKeyInputDownArrow],
		   [[SmartKey alloc]initWithName:KbdLeftArrowKey symbol:UIKeyInputLeftArrow],
		   [[SmartKey alloc]initWithName:KbdRightArrowKey symbol:UIKeyInputRightArrow]
		];
}

- (void)viewDidLoad 
{
  [self.view setNonModifiers:HelperKeys];
  self.view.delegate = self;
}

- (void)symbolUp:(NSString *)symbol
{
  if (_timer != nil) {
    [_timer invalidate];
  }
}

- (void)symbolDown:(NSString *)symbol
{
  for (SmartKey *key in HelperKeys) {
    if ([key.name isEqualToString:symbol]) {
      _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(symbolEmit:) userInfo:key.symbol repeats:YES];
      [_timer fire];
      return;
    }
  }

  for (SmartKey *key in ArrowKeys) {
    if ([key.name isEqualToString:symbol]) {
      _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(symbolEmit:) userInfo:key.symbol repeats:YES];
      [_timer fire];
      return;
    }
  }

}

- (void)symbolEmit:(NSTimer *)timer
{
  [_textInputDelegate insertText:timer.userInfo];
}

@end
