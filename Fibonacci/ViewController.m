//
//  ViewController.m
//  Fibonacci
//
//  Created by Dhivya on 5/25/20.
//  Copyright © 2020 Dhivya. All rights reserved.
//

#import "ViewController.h"
#import "CacheController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize maxSequenceInput;

- (void)viewDidLoad {
    [super viewDidLoad];
    maxSequenceInput.delegate = self;
    // Do any additional setup after loading the view.
}

/* Handles the Generate button action */
- (IBAction)generateSequence:(id)sender
{
    NSString *inputSequenceNumber = maxSequenceInput.text;
       [[CacheController sharedCache] setUserInputValue: [inputSequenceNumber intValue]];
}
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason
{
    NSString *inputSequenceNumber = textField.text;
    [[CacheController sharedCache] setUserInputValue: [inputSequenceNumber intValue]];
}

@end
