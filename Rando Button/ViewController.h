//
//  ViewController.h
//  Rando Button
//
//  Created by Aditya Srivastava on 8/11/17.
//  Copyright © 2017 Aditya Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    IBOutlet UILabel *scorelabel;
    IBOutlet UILabel *highscorelabel;
    IBOutlet UILabel *timerlabel;
    IBOutlet UILabel *levellabel;
    IBOutlet UILabel *goallabel;
    IBOutlet UILabel *button1label;
    IBOutlet UILabel *button2label;
    IBOutlet UILabel *button3label;
    IBOutlet UILabel *gameScore1;
    IBOutlet UILabel *gameScore2;
    IBOutlet UILabel *gameScore3;

    
    NSInteger score;
    NSInteger seconds;
    NSInteger goalscore;
    NSInteger level;
    NSTimer *timer;
    NSInteger HighScore;
    NSInteger newScore;
    NSInteger trackingScore;
    NSInteger purchaseTracker;
    
    bool areRanderAdded;
    bool keepingTrack;

    
}

- (IBAction)leftButtonPressed;
- (IBAction)rightButtonPressed;
- (IBAction)middleButtonPressed;
- (IBAction)restart;
- (IBAction)GameStart;
- (IBAction)StopTimer;
- (IBAction)restore;
- (IBAction)addRander;



@end

