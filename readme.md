# iOS app to phone tutorial

In this tutorial you will learn how to use the Sinch SDK to make a voice call.

##Start

If you don't have an account with Sinch, sign up for one at [http://www.sinch.com/signup](). Set up a new application using the Dashboard, and take note of your application key and secret. Next:

Launch Xcode and create a new project (File>New>Project)
Select 'Single View Application' and click next
Name the project 'CallingApp' and save it
The easiest way to add the Sinch SDK is to use CocoaPods. Open a terminal window in In your Xcode project directory, create a Podfile with the content below.
```pod init```

Open the podfile and add below.
```
pod 'SinchRTC'
```
Save the file, in the terminal window type.

```pod install```

Note: If you are new to CocoaPods go to cocoapods.org to learn how to install it.

Last thing you have to do is to set the Architectures settings on on your project and the pod project to armv7 and armv7s (We are launching 64bit support in a couple of weeks).


##Setting up the client
Open the Main.storyboard in xcode and add a textfield and a button. Set the text of the button to "Call".

![](images/callscreen.png)

Add outlets and actions in ViewController.h

```objectivec
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
- (IBAction)call:(id)sender;
```
also add an import to Sinch client in your ViewController.h 
```#import <Sinch/Sinch.h>```

In ViewController.m find - (void)viewDidLoad and add after [super viewDidLoad];

```
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSinchClient];
}
```

Add instance variables to ViewController.m

```
@interface ViewController ()
{
    id<SINClient> _client;
    id<SINCall> _call;
}
@end
```

and synthesize the properties 
`@synthesize phoneNumber, callButton;`

Create a method call initSinchClient, add your application key and secret, and set the username to anything you want, in this tutorial we are not going to have login functionality. 

```
-(void)initSinchClient 
{
    _client = [Sinch clientWithApplicationKey:@"your_key"
                            applicationSecret:@"your_secret"
                              environmentHost:@"sandbox.sinch.com"
                                       userId:@"anything you want"];
    _client.callClient.delegate = self;
    [_client setSupportCalling:YES];
    [_client start];}
```
As you can see you have a warning now, lets fix that by adding the SINCallClientDelegate to the ViewController.h file `@interface ViewController : UIViewController
<SINCallClientDelegate>`. For those of that have done the app to app calling tutorial you might notice that we are not listening to active connections by     [_client startListeningOnActiveConnection], that is because its not necessary when you only want to make PSTN calls and outgoing calls. If you don't start the an active connection this will save you money. 
This all the setup needed to make PSTN calls. Next implement placing the call

#Making a call 
Change the `call:` action to look like this 

```
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
```
What we are doing here is changing the functionality to either call or hangup.

Thats its for making a call. Next steps would in a production app you would implement the SINCallDelegate protocol so you could make UI changes on i.e callDidEnd, or callDidEstablish. 

Happy coding

Christian 

