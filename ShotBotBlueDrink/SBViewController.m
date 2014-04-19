//
//  SBViewController.m
//  ShotBotBlueDrink
//
//  Created by Chad Newbry on 4/11/14.
//  Copyright (c) 2014 Chad Newbry. All rights reserved.
//

#import "SBViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface SBViewController () <NSURLConnectionDelegate, NSURLConnectionDataDelegate, AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) AVSpeechSynthesizer *myVoiceSynth;

@property (nonatomic, strong) NSURLRequest *orderDrinkURLRequest;
@property (nonatomic, strong) NSURLConnection *orderDrinkURLConnection;

@property (strong, nonatomic) IBOutlet UIButton *screwDriverSmallButton;
@property (strong, nonatomic) IBOutlet UIButton *screwDriverLargeButton;
@property (strong, nonatomic) IBOutlet UIButton *singleShotButton;
@property (strong, nonatomic) IBOutlet UIButton *doubleShotButton;


@end

@implementation SBViewController
@synthesize myVoiceSynth;
@synthesize orderDrinkURLRequest;
@synthesize orderDrinkURLConnection;

static NSString *baseString = @"http://shotbotserver.herokuapp.com/drink/";

#pragma mark-- LifecycleMethods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.



    // set up voice synthesizer
    myVoiceSynth = [[AVSpeechSynthesizer alloc] init];
    myVoiceSynth.delegate = self;
}



#pragma mark-- NSURLConnnectionDataDelegate Methods

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Connection has finished loading");
    //TODO probably don't need this method
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    AVSpeechUtterance *mySpeechUtternace = [[AVSpeechUtterance alloc] initWithString:@"Shot Bot lives to serve"];
    
    mySpeechUtternace.rate = .1;
    mySpeechUtternace.pitchMultiplier = 1; // .5 to 2.0
    mySpeechUtternace.volume = 1;
    
    NSLog(@"Minimum rate: %f", AVSpeechUtteranceMinimumSpeechRate);
    

    [myVoiceSynth speakUtterance:mySpeechUtternace];
}

#pragma  mark-- SpeechSynthesizerDelagate

-(void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    NSLog(@"Speech finished. Exit.");
    exit(0);
}

#pragma mark-- NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"Connection error");
    NSLog(@"the error: %@", error);
}

@end
