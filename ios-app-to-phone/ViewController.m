//
//  ViewController.m
//  ios-app-to-phone
//
//  Created by christian jensen on 1/5/15.
//  Copyright (c) 2015 christian jensen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    id<SINClient> _client;
    id<SINCall> _call;
}
@end

@implementation ViewController
@synthesize phoneNumber, callButton;

-(void)initSinchClient
{
    _client = [Sinch clientWithApplicationKey:@""
                            applicationSecret:@""
                              environmentHost:@"sandbox.sinch.com"
                                       userId:@"phonecaller"];
    _client.callClient.delegate = self;
    [_client setSupportCalling:YES];
    [_client start];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSinchClient];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)call:(id)sender {
    if (_call == nil)
    {
        _call = [[_client callClient] callPhoneNumber:phoneNumber.text];
        [callButton setTitle:@"Hangup" forState:UIControlStateNormal];
    }
    else
    {
        [_call hangup];
        [callButton setTitle:@"Call" forState:UIControlStateNormal];
    }
    
}
@end
