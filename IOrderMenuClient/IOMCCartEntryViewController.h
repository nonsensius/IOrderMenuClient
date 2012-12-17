//
//  IOMCCartEntryViewController.h
//  IOrderMenuClient
//
/*
 Copyright (c) 2012, Benjamin Pawlowsky
 All rights reserved.
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 •	Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 •	Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
//

#import <UIKit/UIKit.h>
#import "IOMCShoppingCartEntry.h"
#import "IOMCConnectionData.h"

@interface IOMCCartEntryViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *longDescription;
@property (weak, nonatomic) IBOutlet UITextView *optionalExtras;
@property (weak, nonatomic) IBOutlet UITextField *count;

@property NSMutableArray *cartContents;
@property int row;
@property IOMCShoppingCartEntry *editedCartEntry;
@property NSArray *comestibles;

@property (weak, nonatomic) IBOutlet UIStepper *countStepper;
@property (weak, nonatomic) IBOutlet UIButton *orderButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property BOOL fromMenu;
@property IOMCConnectionData *connection;

- (IBAction)orderDish:(id)sender;
- (IBAction)removeDish:(id)sender;
- (id)initWithCartEntry:(IOMCShoppingCartEntry *)aCartEntry connection:(IOMCConnectionData *)aConnection row:(int)theRow nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (id)initWithMenuEntry:(IOMCMenuEntry *)menuEntry connection:(IOMCConnectionData *)aConnection nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

- (IBAction)changeCount:(id)sender;


@end
