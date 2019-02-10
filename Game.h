//
//  Game.h
//  Rando Button
//
//  Created by Aditya Srivastava on 8/28/17.
//  Copyright © 2017 Aditya Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Game : UIViewController {
    
    IBOutlet UILabel *scorelabel;
    IBOutlet UILabel *highscorelabel;
    IBOutlet UILabel *timerlabel;
    IBOutlet UILabel *levellabel;
    IBOutlet UILabel *goallabel;
    
    NSInteger score;
    NSInteger seconds;
    NSInteger goalscore;
    NSInteger level;
    NSTimer *timer;
    NSInteger HighScore;
    
    
}


- (IBAction)leftButtonPressed;
- (IBAction)rightButtonPressed;


@end
