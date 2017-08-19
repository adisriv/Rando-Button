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
    IBOutlet UILabel *hs1label;
    
    
    NSInteger score;
    NSInteger seconds;
    NSInteger goalscore;
    NSInteger level;
    NSTimer *timer;
    NSInteger HighScore;
    NSInteger hs1;
    NSInteger firsttime;

    
}

- (IBAction)leftButtonPressed;
- (IBAction)rightButtonPressed;
- (IBAction)restart;
- (IBAction)GameStart;
- (IBAction)StopTimer;

@end

