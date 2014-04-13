//
//  SBViewController.m
//  ShotBotBlueDrink
//
//  Created by Chad Newbry on 4/11/14.
//  Copyright (c) 2014 Chad Newbry. All rights reserved.
//

#import "SBViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "DropItBehavior.h"

@interface SBViewController () <NSURLConnectionDelegate, NSURLConnectionDataDelegate, AVSpeechSynthesizerDelegate, UIDynamicAnimatorDelegate>

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (strong,nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) DropItBehavior *dropItBehavior;
@property (strong, nonatomic) UIView *droppingView;
@property (nonatomic) NSMutableArray *arrayOfDropViews;

@property (weak, nonatomic) IBOutlet UIView *drinkUIView;
@property (nonatomic) BOOL canDropIce;
@property (nonatomic) NSNumber *drinkType;
@end

@implementation SBViewController

static const CGSize DROP_SIZE = { 40, 40 };

#pragma mark-- Getters and Setters

- (UIDynamicAnimator *)animator
{
//    if (!_animator) {
//        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.mainView];
//    }
    
    return _animator;
}

- (DropItBehavior *)dropItBehavior {
    if (!_dropItBehavior)
    {
        _dropItBehavior = [[DropItBehavior alloc] init];
        [self.animator  addBehavior:_dropItBehavior];
    }
    
    return _dropItBehavior;
}

#pragma mark-- MethodsIceStuff

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    
    if ([self.arrayOfDropViews count] >= 3) {
        
        NSLog(@"More than 3 ice cubes");
    }
    
}

- (IBAction)dropIceByTap:(id)sender {
    
    if (_canDropIce) {
//        CGPoint tapPoint = [sender locationInView:self.mainView];
        
//        [self drop:tapPoint];
    }
}

- (void) drop:(CGPoint)tapPoint
{
    NSLog(@"Begining of drop function");
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    //int x = (arc4random()%(int)self.mainView.bounds.size.width) / DROP_SIZE.width;
    frame.origin.x = tapPoint.x;
    frame.origin.y = tapPoint.y;
    
    
    //UIImage *dropView = [[UIImage alloc] initWithContentsOfFile:@"ice_cube.jpg"];
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    //dropView.backgroundColor = [self randomColor];
    
    [dropView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ice_cube_small.png"]]];
    
    //[self.mainView addSubview:dropView];
    self.droppingView = dropView;
    [self.dropItBehavior addItem:dropView];
    
    [self.arrayOfDropViews addObject:dropView];
    
    if ([self.arrayOfDropViews count] >= 3) {
        _canDropIce = NO;
        
        [self fillGlass];
    }
}

- (void)fillGlass {
    
    
    
    
}

#pragma mark-- Helper Methods

- (UIColor *)randomColor
{
    switch (arc4random()%5) {
        case 0: return [UIColor greenColor];
        case 1: return [UIColor blueColor];
        case 2: return [UIColor orangeColor];
        case 3: return [UIColor redColor];
        case 4: return [UIColor purpleColor];
    }
    
    return [UIColor blackColor];
}

#pragma mark-- LifecycleMethods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _arrayOfDropViews = [[NSMutableArray alloc ] init];
    _canDropIce = YES;
    
    NSMutableString *baseString = [[NSMutableString alloc] initWithString:@"http://shotbotserver.herokuapp.com/drink/"];
    
    
    // 1 = blue
    // 2 = red
    // 3 = purple
    _drinkType = [[NSNumber alloc] initWithInt:2];
    
    UIColor *colorToSet = [UIColor blueColor];
    
    if ([_drinkType isEqual:[[NSNumber alloc] initWithInt:1]]) {
        colorToSet = [UIColor blueColor];
    } else if ([_drinkType isEqual:[[NSNumber alloc] initWithInt:2]]) {
        colorToSet = [UIColor redColor];
    } if ([_drinkType isEqual:[[NSNumber alloc] initWithInt:3]]) {
        colorToSet = [UIColor purpleColor];
    }
    
//    [self.drinkUIView setBackgroundColor:colorToSet];
//    
    //set drinkUIView offscreen
    
    //[self.drinkUIView setFrame:CGRectMake(0, self.mainView.frame.size.height, <#CGFloat width#>, <#CGFloat height#>)]
    

    
    [baseString appendString:[_drinkType stringValue]];
    
    NSLog(@"Request string: %@", baseString);
    
    //The Request
    NSURLRequest *myRequest = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:baseString]];
    
    //Starts connection with the specified request
    NSURLConnection *myConnection = [[NSURLConnection alloc]
                                     initWithRequest:myRequest delegate:self startImmediately:YES];
}

#pragma mark-- NSURLConnnectionDataDelegate Methods

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Connection has finished loading");
    //TODO probably don't need this method
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    NSString * myStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"My string received: %@", myStr);
    
    NSMutableString *baseMixingText = [[NSMutableString alloc] initWithString:@"Mixing your " ];
    
    NSString * addString;
    
    if ([_drinkType isEqual:[[NSNumber alloc] initWithInt:1]]) {
        addString = @"ShotBot loves to serve drinks";
    } else if ([_drinkType isEqual:[[NSNumber alloc] initWithInt:2]]) {
        addString = @"ShotBot loves to serve drinks";
    } else if ([_drinkType isEqual:[[NSNumber alloc] initWithInt:3]]) {
        addString = @"ShotBot loves to serve drinks";
    }
                
    
                
    AVSpeechUtterance *mySpeechUtternace = [[AVSpeechUtterance alloc] initWithString:addString];
    
    mySpeechUtternace.rate = .1;
    mySpeechUtternace.pitchMultiplier = 1; // .5 to 2.0
    mySpeechUtternace.volume = 1;
    
    NSLog(@"Minimum rate: %f", AVSpeechUtteranceMinimumSpeechRate);
    
    AVSpeechSynthesizer *myVoiceSynth = [[AVSpeechSynthesizer alloc] init];
    [myVoiceSynth speakUtterance:mySpeechUtternace];
    
    myVoiceSynth.delegate = self;
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
