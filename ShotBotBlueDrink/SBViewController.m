//
//  SBViewController.m
//  ShotBotBlueDrink
//
//  Created by Chad Newbry on 4/11/14.
//  Copyright (c) 2014 Chad Newbry. All rights reserved.
//

#import "SBViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <FUIButton.h>
#import <UIColor+FlatUI.h>
#import <UIFont+FlatUI.h>


@interface SBViewController () <NSURLConnectionDelegate, NSURLConnectionDataDelegate, AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) AVSpeechSynthesizer *myVoiceSynth;

@property (nonatomic, strong) NSURLRequest *orderDrinkURLRequest;
@property (nonatomic, strong) NSURLConnection *orderDrinkURLConnection;

@property (strong, nonatomic) IBOutlet FUIButton *screwDriverSmallButton;
@property (strong, nonatomic) IBOutlet FUIButton *screwDriverLargeButton;
@property (strong, nonatomic) IBOutlet FUIButton *singleShotButton;
@property (strong, nonatomic) IBOutlet FUIButton *doubleShotButton;


@end

@implementation SBViewController
@synthesize myVoiceSynth;
@synthesize orderDrinkURLRequest;
@synthesize orderDrinkURLConnection;
@synthesize screwDriverSmallButton;
@synthesize screwDriverLargeButton;
@synthesize singleShotButton;
@synthesize doubleShotButton;

static NSString *baseString = @"http://shotbotserver.herokuapp.com/drink/";

#pragma mark-- LifecycleMethods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    screwDriverSmallButton.buttonColor = [UIColor orangeColor];
    screwDriverSmallButton.shadowColor = [UIColor carrotColor];
    screwDriverSmallButton.shadowHeight = 3.0f;
    screwDriverSmallButton.cornerRadius = 6.0f;
    screwDriverSmallButton.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    [screwDriverSmallButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [screwDriverSmallButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];

    screwDriverLargeButton.buttonColor = [UIColor orangeColor];
    screwDriverLargeButton.shadowColor = [UIColor carrotColor];
    screwDriverLargeButton.shadowHeight = 3.0f;
    screwDriverLargeButton.cornerRadius = 6.0f;
    screwDriverLargeButton.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    [screwDriverLargeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [screwDriverLargeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];

    singleShotButton.buttonColor = [UIColor silverColor];
    singleShotButton.shadowColor = [UIColor amethystColor];
    singleShotButton.shadowHeight = 3.0f;
    singleShotButton.cornerRadius = 6.0f;
    singleShotButton.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    [singleShotButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [singleShotButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];

    doubleShotButton.buttonColor = [UIColor silverColor];
    doubleShotButton.shadowColor = [UIColor amethystColor];
    doubleShotButton.shadowHeight = 3.0f;
    doubleShotButton.cornerRadius = 6.0f;
    doubleShotButton.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    [doubleShotButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [doubleShotButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];

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
