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
    
    //[self startGame];
    //[self updatesecondslabel]
    
    [self GameStart];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [timer invalidate];
    });

    UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
    
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    
    [self.view insertSubview:backgroundImageView atIndex:0];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GameStart {
    
    [self startGame];
    [self updatesecondslabel];
}

- (IBAction)StopTimer {
    
    [timer invalidate];
    
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
    
    highscorelabel.text = [NSString stringWithFormat:@"Highest Level\n%li", (long)HighScore];
    
    seconds = 3;
    score = 0;
    level = 1;
    goalscore = 50;
    
    timerlabel.text = [NSString stringWithFormat:@"Time: %li", (long)seconds];
    scorelabel.text = [NSString stringWithFormat:@"Score\n%li", (long)score];
    levellabel.text = [NSString stringWithFormat:@"Level %li", (long)level];
    goallabel.text = [NSString stringWithFormat:@"Goal\n%li", (long)goalscore];

    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector: @selector(subtracttime) userInfo: nil repeats:YES];
    
    score = [[NSUserDefaults standardUserDefaults] integerForKey:@"CurrentScoreSaved"];
    
    
}

- (void)subtracttime {
    
    seconds--;
    
    timerlabel.text = [NSString stringWithFormat:@"Time: %li", (long)seconds];
    
    if (seconds != 0) {
        
        if (score >= goalscore) {
            
            [self updategame];
            
        }
        
    }
    
    if (seconds == 0) {
        
        [timer invalidate];
        
        if (score >= goalscore) {
            
            level++;
            
            levellabel.text = [NSString stringWithFormat:@"Level\n%li", (long)level];
            
        }
        
    if (HighScore < level) {
        
        HighScore = level;
        
        [[NSUserDefaults standardUserDefaults] setInteger:HighScore forKey:@"HighScoreSaved"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        highscorelabel.text = [NSString stringWithFormat:@"Highest Level\n%li", (long)level];

        
    }
        
    
    
    UIAlertController *popup = [UIAlertController alertControllerWithTitle:@"Time is Up" message:[NSString stringWithFormat:@"Your Reached Level %li", (long)level] preferredStyle:UIAlertControllerStyleAlert];
        
    UIAlertAction *yah = [UIAlertAction actionWithTitle:@"Play Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self startGame];
        }];
        
    UIAlertAction *nah = [UIAlertAction actionWithTitle:@"Nah, I'm Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        
    }];
        
    [popup addAction:yah];
    [popup addAction:nah];
    [self presentViewController: popup animated:YES completion:nil];
        
    }
    
}

- (IBAction)restart {
    
    self->seconds = 15;
    self->score = 0;
    self->level = 1;
    self->goalscore = 100;
    [self updatesecondslabel];
    
}

- (void)updatesecondslabel {
    
    self->timerlabel.text = [NSString stringWithFormat:@"Time: %li", (long)self->seconds];
    self->scorelabel.text = [NSString stringWithFormat:@"Score\n%li", (long)self->score];
    self->levellabel.text = [NSString stringWithFormat:@"Level %li", (long)self->level];
    self->goallabel.text = [NSString stringWithFormat:@"Goal\n%li", (long)self->goalscore];
    
}

- (void)updategame {
    
    self->seconds = 15;
    self->score = 0;
    self->level++;
    self->goalscore = self->goalscore + 100;
    [self updatesecondslabel];
    
}


@end
