//
//  ViewController.h
//  Calculator
//
//  Created by Mark Glagola on 5/14/12.
//  Copyright (c) 2012 Independent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    //Where all the calculations are shown
    IBOutlet UILabel *mainLabel;
    
    //Stores the last known value before an operand is pressed
    double lastKnownValue;
    
    NSString *operand;
    
    BOOL isMainLabelTextTemporary;
    
}
- (IBAction)clearPressed:(id)sender;
- (IBAction)numberButtonPressed:(id)sender;
- (IBAction)decimalPressed:(id)sender;
- (IBAction)operandPressed:(id)sender;
- (IBAction)equalsPressed:(id)sender;
@end
