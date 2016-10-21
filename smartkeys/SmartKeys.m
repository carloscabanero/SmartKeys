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
		    [[SmartKey alloc] initWithName:@"*" symbol:@"*"]
		 ];
  
  ArrowKeys = @[
		[[SmartKey alloc]initWithName:KbdUpArrowKey symbol:UIKeyInputUpArrow],
		   [[SmartKey alloc]initWithName:KbdDownArrowKey symbol:UIKeyInputDownArrow],
		   [[SmartKey alloc]initWithName:KbdLeftArrowKey symbol:UIKeyInputLeftArrow],
		   [[SmartKey alloc]initWithName:KbdRightArrowKey symbol:UIKeyInputRightArrow]
		];

  FKeys = @[
	    [[SmartKey alloc]initWithName:@"F1" symbol:@""],
	    [[SmartKey alloc]initWithName:@"F2" symbol:@""],
	    [[SmartKey alloc]initWithName:@"F3" symbol:@""],
	    [[SmartKey alloc]initWithName:@"F4" symbol:@""],
	    [[SmartKey alloc]initWithName:@"F5" symbol:@""],
	    [[SmartKey alloc]initWithName:@"F6" symbol:@""],
	    [[SmartKey alloc]initWithName:@"F7" symbol:@""],
	    [[SmartKey alloc]initWithName:@"F8" symbol:@""],
	    [[SmartKey alloc]initWithName:@"F9" symbol:@""],
	    [[SmartKey alloc]initWithName:@"F10" symbol:@""]];
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
  SmartKey *pressedKey;
  for (SmartKey *key in HelperKeys) {
    if (key.name == symbol) {
      pressedKey = key;
    }
  }

  _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(symbolEmit:) userInfo:pressedKey.symbol repeats:YES];
  [_timer fire];  
}

// - (void)nonModifierUp:(UIButton *)sender
// {
//   if (_timer != nil) {
//     [_timer invalidate];
//   }
// }

// - (void)symbolDown:(UIButton *)sender
// {
//     NSLog(@"Woork");
//   NSString *key = sender.titleLabel.text;
//   NSString *symbol;

//   if ([key isEqualToString:KbdUpArrowKey]) {
//     symbol = UIKeyInputUpArrow;
//   } else if ([key isEqualToString:KbdDownArrowKey]) {
//     symbol = UIKeyInputDownArrow;
//   } else if ([key isEqualToString:KbdLeftArrowKey]) {
//     symbol = UIKeyInputLeftArrow;
//   } else if ([key isEqualToString:KbdRightArrowKey]) {
//     symbol = UIKeyInputRightArrow;
//   } else if ([key isEqualToString:KbdTabKey]) {
//     symbol = @"\t";
//   } else if ([key isEqualToString:KbdEscKey]) {
//     symbol = UIKeyInputEscape;
//   } else {
//     symbol = [NSString stringWithString:key];
//   }
    
//     NSUInteger modifiers = [self.view modifiers];
//     if (modifiers & KbdCtrlModifier) {
//         symbol = [NSString stringWithFormat:@"^%@",symbol];
//     } else if(modifiers & KbdAltModifier) {
//         symbol = [NSString stringWithFormat:@"⌥%@",symbol];
//     }

//   _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(symbolEmit:) userInfo:symbol repeats:YES];
//   [_timer fire];
// }

- (void)symbolEmit:(NSTimer *)timer
{
  [_textInputDelegate insertText:timer.userInfo];
}

@end
