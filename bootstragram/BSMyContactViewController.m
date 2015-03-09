//
//  BSMyContactViewController.m
//  bootstragram
//
//  Created by Mickaël Floc'hlay on 19/11/2013.
//  Copyright (c) 2013 Bootstragram. All rights reserved.
//

#import "BSMyContactViewController.h"
#import "NSString+Levenshtein.h"
#import <AddressBook/AddressBook.h>

@interface BSMyContactViewController ()

@end

@implementation BSMyContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)allMyContacts {
    // cf. http://stackoverflow.com/questions/12083643/how-do-i-correctly-use-abaddressbookcreatewithoptions-method-in-ios-6
    CFErrorRef error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    __block BOOL accessGranted = NO;
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        accessGranted = granted;
        dispatch_semaphore_signal(sema);
    });
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    if (accessGranted) {
        NSArray *thePeople = (__bridge_transfer NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
        return thePeople;
    } else {
        return nil;
    }
}


- (BOOL)validateEmail:(NSString *)candidate {
    // cf. http://stackoverflow.com/questions/800123/best-practices-for-validating-email-address-in-objective-c
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}


- (BOOL)myContactsContains:(NSString *)refString closestMatch:(NSString **)closestMatch {
    NSArray *allMyContacts = [self allMyContacts];
    if (allMyContacts) {
        BOOL exactMatch = NO;
        NSString *bestMatch = nil;
        NSInteger bestMatchScore = 0;
        
        for (id person in allMyContacts) {
            NSString *email = nil;
            ABMultiValueRef emails = ABRecordCopyValue((__bridge ABRecordRef)person, kABPersonEmailProperty);
            if (emails) {
                email = (__bridge NSString *) ABMultiValueCopyValueAtIndex(emails, 0);
                
                if (email) {
                    if ([email isEqualToString:refString]) {
                        exactMatch = YES;
                    } else {
                        NSInteger score = [refString compareWithWord:email matchGain:10 missingCost:1];
                        NSLog(@"Examining %@ vs %@ - score %ld", refString, email, (long)score);
                        if (score < bestMatchScore) {
                            bestMatch = email;
                            bestMatchScore = score;
                        }
                    }
                }
            }
        }
        
        *closestMatch = bestMatch;
        
        return exactMatch;
    } else {
        return NO;
    }
}


- (IBAction)validateMail:(id)sender {
    UIAlertView *alertView = alertView;
    NSString *refString = [self.textField text];
    
    if ([self validateEmail:refString]) {
        NSString *closestMatch = nil;
        BOOL emailFound = [self myContactsContains:refString closestMatch:&closestMatch];
        if (emailFound) {
            alertView = [[UIAlertView alloc]  initWithTitle:@"Yo!"
                                                    message:@"The address is known."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
            
        } else {
            if (closestMatch) {
                alertView = [[UIAlertView alloc]  initWithTitle:@"Yo!"
                                                        message:[NSString stringWithFormat:@"Did you mean %@?", closestMatch]
                                                       delegate:nil
                                              cancelButtonTitle:@"No, keep mine!"
                                              otherButtonTitles:@"Yes, you're right", nil];
            } else {
                alertView = [[UIAlertView alloc]  initWithTitle:@"Yo!"
                                                        message:@"This address may not be good but uh"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
                
            }
        }
    } else {
        alertView = [[UIAlertView alloc]  initWithTitle:@"Yo!"
                                                message:@"This is not a valid email address"
                                               delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
    }
    [alertView show];
    [self.textField resignFirstResponder];
}


@end
