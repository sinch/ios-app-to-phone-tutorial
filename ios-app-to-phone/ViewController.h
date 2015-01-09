//
//  ViewController.h
//  ios-app-to-phone
//
//  Created by christian jensen on 1/5/15.
//  Copyright (c) 2015 christian jensen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Sinch/Sinch.h>

@interface ViewController : UIViewController
<SINCallClientDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
- (IBAction)call:(id)sender;

@end

