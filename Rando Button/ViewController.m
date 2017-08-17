//
//  ViewController.m
//  Rando Button
//
//  Created by Aditya Srivastava on 8/11/17.
//  Copyright © 2017 Aditya Srivastava. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tile.png"]];
    
    [self startGame];
    [self updatesecondslabel];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftButtonPressed {
    
    score += arc4random_uniform(50);
    
    scorelabel.text = [NSString stringWithFormat:@"Score\n%li", (long)score];
    
}

- (IBAction)rightButtonPressed {
    
    score += arc4random_uniform(50);
    
    scorelabel.text = [NSString stringWithFormat:@"Score \n %li", (long)score];
    
}


- (void)startGame {
    
    HighScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    highscorelabel.text = [NSString stringWithFormat:@"High Score\n%li", (long)HighScore];
    
    seconds = 15;
    score = 0;
    
    timerlabel.text = [NSString stringWithFormat:@"Time: %li", (long)seconds];
    scorelabel.text = [NSString stringWithFormat:@"Score\n%li", (long)score];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector: @selector(subtracttime) userInfo: nil repeats:YES];
    
    score = [[NSUserDefaults standardUserDefaults] integerForKey:@"CurrentScoreSaved"];
    
    
}

- (void)subtracttime {
    
    seconds--;
    
    timerlabel.text = [NSString stringWithFormat:@"Time: %li", (long)seconds];
    
    if (seconds == 0) {
        
        [timer invalidate];
        
        if (score > HighScore) {
            
            HighScore = score;
            
            [[NSUserDefaults standardUserDefaults] setInteger:HighScore forKey:@"HighScoreSaved"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        highscorelabel.text = [NSString stringWithFormat:@"High Score\n%li", (long)HighScore];
        
        UIAlertController *popup = [UIAlertController alertControllerWithTitle:@"Time is Up" message:[NSString stringWithFormat:@"You Scored %li Points", (long)score] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *yah = [UIAlertAction actionWithTitle:@"Play Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self startGame];
        }];
        
        UIAlertAction *nah = [UIAlertAction actionWithTitle:@"Nah, I'm Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
        
        [popup addAction:yah];
        [popup addAction:nah];
        [self presentViewController: popup animated:YES completion:nil];
        
    }
    
}

- (IBAction)restart {
    
    self->seconds = 15;
    self->score = 0;
    [self updatesecondslabel];
    
}

- (void)updatesecondslabel {
    
    self->timerlabel.text = [NSString stringWithFormat:@"Time: %li", (long)self->seconds];
    self->scorelabel.text = [NSString stringWithFormat:@"Score\n%li", (long)self->score];

    
}


@end
