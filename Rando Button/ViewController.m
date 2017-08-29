//
//  ViewController.m
//  Rando Button
//
//  Created by Aditya Srivastava on 8/11/17.
//  Copyright © 2017 Aditya Srivastava. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>

@interface ViewController () <SKProductsRequestDelegate, SKPaymentTransactionObserver>


@end

@implementation ViewController

#define kAddRanderProductIdentifier @"tld.AdiSriv.Rander.RanderIAP"

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
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

- (IBAction)addRander {
    
    //NSLog(@"User requests to add to Rander");
    
    if ([SKPaymentQueue canMakePayments]) {
        
        //NSLog(@"User can make payments");
        
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kAddRanderProductIdentifier]];
        
        productsRequest.delegate = self;
        [productsRequest start];
        
        
    }
    else {
        
        //NSLog(@"User cannot make payments due to parental controls");
        
    }
    
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    SKProduct *validProduct = nil;
    int count = [response.products count];
    
    if (count > 0) {
        
        validProduct = [response.products objectAtIndex:0];
        //NSLog(@"Products Available");
        [self purchase:validProduct];
        
    }
    else {
        
        //NSLog(@"No Products Available");
        
    }
    
}

- (void)purchase:(SKProduct *)product {
    
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}

- (void)restore {
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    
    //NSLog(@"received restored transactions: %lu", (unsigned long)queue.transactions.count);
    for(SKPaymentTransaction *transaction in queue.transactions){
        if(transaction.transactionState == SKPaymentTransactionStateRestored){
            
            //NSLog(@"Transaction state -> Restored");
            
            
            [self doAddtoRander];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            break;
        }
    }
    
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    
    for(SKPaymentTransaction *transaction in transactions) {
        
        switch(transaction.transactionState){
                
            case SKPaymentTransactionStateDeferred:
                break;
                
            case SKPaymentTransactionStatePurchasing: //NSLog(@"Transaction state -> Purchasing");
                
                break;
            case SKPaymentTransactionStatePurchased:
                
                [self doAddtoRander];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                //NSLog(@"Transaction state -> Purchased");
                break;
            case SKPaymentTransactionStateRestored:
                //NSLog(@"Transaction state -> Restored");
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                
                if(transaction.error.code == SKErrorPaymentCancelled){
                    //NSLog(@"Transaction state -> Cancelled");
                    
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
        }
        
    }
    
}

- (void)doAddtoRander {
    
    newScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"newScore"];

    
    NSLog(@"hello you reached me");
    NSLog(@"Score at Purchase is: %li", (long)newScore);
    
    if (newScore > 0) {

        NSLog(@"yup, you reached me too");
        newScore += 50;
        
    }
    else {
        
        NSLog(@"first time yo");
        newScore = 50;
        
    }
    
    areRanderAdded = YES;
    
    [[NSUserDefaults standardUserDefaults] setBool:areRanderAdded forKey:@"areRanderAdded"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setInteger:newScore forKey:@"newScore"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];

    
}


- (IBAction)GameStart {

    [self startGame];
    [self updatesecondslabel];
}

- (IBAction)StopTimer {
    
    [timer invalidate];
    
}
- (IBAction)leftButtonPressed {
    
    areRanderAdded = [[NSUserDefaults standardUserDefaults] boolForKey:@"areRanderAdded"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    newScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"newScore"];
    
    if (areRanderAdded) {
        
        score = score + arc4random_uniform(50) + newScore;
        
    }
    else {
    
    score += arc4random_uniform(50);
        
    }
    
    scorelabel.text = [NSString stringWithFormat:@"Score\n%li", (long)score];
    
    NSLog(@"Score is: %li", (long)newScore);
    
    
}

- (IBAction)rightButtonPressed {
    
    areRanderAdded = [[NSUserDefaults standardUserDefaults] boolForKey:@"areRanderAdded"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    newScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"newScore"];
    
    if (areRanderAdded) {
        
        score = score + arc4random_uniform(50) + newScore;
        
    }
    else {
        
        score += arc4random_uniform(50);
        
    }
    
    scorelabel.text = [NSString stringWithFormat:@"Score\n%li", (long)score];
    
    NSLog(@"Score is: %li", (long)newScore);
    
}


- (void)startGame {
    
    
    HighScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    highscorelabel.text = [NSString stringWithFormat:@"Highest Level\n%li", (long)HighScore];
    
    seconds = 15;
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
