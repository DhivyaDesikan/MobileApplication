//
//  ViewController.h
//  Fibonacci
//
//  Created by Dhivya on 5/25/20.
//  Copyright © 2020 Dhivya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic,weak)IBOutlet UITextField *maxSequenceInput;

- (IBAction)generateSequence:(id)sender;

@end

