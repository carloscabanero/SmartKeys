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

#import "SmartKeysView.h"

NSString *const KbdLeftArrowKey = @"◀︎";
NSString *const KbdRightArrowKey = @"▶︎";
NSString *const KbdUpArrowKey = @"▲";
NSString *const KbdDownArrowKey = @"▼";
NSString *const KbdEscKey = @"⎋";
NSString *const KbdTabKey = @"⇥";
int const kNonModifierCount = 7;

@implementation SmartKeysView {
  NSTimer *_timer;
  __weak IBOutlet UIButton *_ctrlButton;
  __weak IBOutlet UIButton *_altButton;
  __weak IBOutlet UIStackView *_stack;
    __weak IBOutlet UIScrollView *_nonModifierScrollView;
    BOOL isLongPress;
}

- (void)awakeFromNib
{
  self.translatesAutoresizingMaskIntoConstraints = NO;
    _nonModifierScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self setupModifierButtons];
}

- (void)setupModifierButtons{
    [_ctrlButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [_altButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    
    UITapGestureRecognizer *ctrlTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modifierButtonTapped:)];
    ctrlTapGesture.numberOfTapsRequired = 1;
    UILongPressGestureRecognizer *ctrlLongPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressOnModifierButton:)];
    ctrlLongPressGesture.minimumPressDuration = 0.3;

    [_ctrlButton addGestureRecognizer:ctrlTapGesture];
    [_ctrlButton addGestureRecognizer:ctrlLongPressGesture];

    UITapGestureRecognizer *altTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(modifierButtonTapped:)];
    altTapGesture.numberOfTapsRequired = 1;
    UILongPressGestureRecognizer *altLongPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressOnModifierButton:)];
    altLongPressGesture.minimumPressDuration = 0.3;
    
    [_altButton addGestureRecognizer:altTapGesture];
    [_altButton addGestureRecognizer:altLongPressGesture];
}

- (NSUInteger)modifiers
{
  // No need to use the tag, as modifiers are predefined.
  NSUInteger modifiers = 0;
  if (_ctrlButton.selected) {
      modifiers |= KbdCtrlModifier;
      if(!isLongPress){
          _ctrlButton.selected = NO;
      }
  }
  if (_altButton.selected) {
      modifiers |= KbdAltModifier;
      if(!isLongPress){
          _altButton.selected = NO;
      }
  }

  return modifiers;
}

- (void)show
{
    self.hidden = NO;
}

- (UIInputViewStyle)inputViewStyle
{
  return UIInputViewStyleDefault;
}

- (void)modifierButtonTapped:(UITapGestureRecognizer*)gesture{
    [self modifiers];
    UIButton *selectedButton = (UIButton*)gesture.view;
    [selectedButton setSelected:!selectedButton.isSelected];
}

- (void)longPressOnModifierButton:(UILongPressGestureRecognizer*)gesture{
    UIButton *selectedButton = (UIButton*)gesture.view;
    if(gesture.state == UIGestureRecognizerStateBegan){
        [selectedButton setSelected:YES];
        isLongPress = YES;
    } else if(gesture.state == UIGestureRecognizerStateEnded){
        [selectedButton setSelected:NO];
        isLongPress = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
}

@end
