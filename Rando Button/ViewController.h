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
    
    NSInteger score;
    NSInteger seconds;
    NSTimer *timer;
    NSInteger HighScore;
    
}

- (IBAction)leftButtonPressed;
- (IBAction)rightButtonPressed;


@end

