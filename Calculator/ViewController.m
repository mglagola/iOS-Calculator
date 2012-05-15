//
//  ViewController.m
//  Calculator
//
//  Created by Mark Glagola on 5/14/12.
//  Copyright (c) 2012 Independent. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
    {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    }
    else 
    {
        return YES;
    }
}

- (IBAction)clearPressed:(id)sender
{
    lastKnownValue = 0;
    mainLabel.text = @"0";
    isMainLabelTextTemporary = NO;
    operand = @"";
}

- (BOOL)doesStringContainDecimal:(NSString*) string
{
    NSString *searchForDecimal = @".";
    NSRange range = [mainLabel.text rangeOfString:searchForDecimal];
    
    //If we find a decimal return YES. Otherwise, NO
    if (range.location != NSNotFound)
        return YES;
    return NO;
}

- (IBAction)numberButtonPressed:(id)sender
{
    //Resets label after calculations are shown from previous operations
    if (isMainLabelTextTemporary)
    {
        mainLabel.text = @"0";
        isMainLabelTextTemporary = NO;
    }
    
    //Get the string from the button label and main label
    NSString *numString = ((UIButton*)sender).titleLabel.text;
    NSString *mainLabelString = mainLabel.text;

    //If mainLabel = 0 and does not contain a decimal then remove the 0
    if ([mainLabelString doubleValue] == 0 && [self doesStringContainDecimal:mainLabelString] == NO)
        mainLabelString = @"";
        
    //Combine the two strings together
    mainLabel.text = [mainLabelString stringByAppendingFormat:numString];
}

- (IBAction)decimalPressed:(id)sender
{
    //Only add a decimal if the string doesnt already contain one.
    if ([self doesStringContainDecimal:mainLabel.text] == NO) 
        mainLabel.text = [mainLabel.text stringByAppendingFormat:@"."];
}

- (void)calculate
{
    //Get the current value on screen
    double currentValue = [mainLabel.text doubleValue];
    
    // If we already have a value stored and the current # is not 0 , add/subt/mult/divide the values
    if (lastKnownValue != 0 && currentValue != 0)
    {
        if ([operand isEqualToString:@"+"])
            lastKnownValue += currentValue;
        else if ([operand isEqualToString:@"-"])
            lastKnownValue -= currentValue;
        else if ([operand isEqualToString:@"x"])
            lastKnownValue *= currentValue;
        else if ([operand isEqualToString:@"/"])
        {
            //You can't divide by 0! 
            if (currentValue == 0)
                [self clearPressed:nil];
            else
                lastKnownValue /= currentValue;
        }
    }
    else
        lastKnownValue = currentValue;
    
    //Set the new value to the main label 
    mainLabel.text = [NSString stringWithFormat:@"%g",lastKnownValue];
        
    //Make the main label text temp, so we can erase when the next value is entered 
    isMainLabelTextTemporary = YES;
}

- (IBAction)operandPressed:(id)sender
{
    //Calculate from previous operand
    [self calculate];
    
    //Get the NEW operand from the button pressed
    operand = ((UIButton*)sender).titleLabel.text;
}

- (IBAction)equalsPressed:(id)sender
{
    [self calculate];
    
    //reset operand;
    operand = @"";
}

@end
