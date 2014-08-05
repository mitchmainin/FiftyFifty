//
//  Gameover.m
//  FiftyFifty
//
//  Created by Justin Matsnev on 8/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameover.h"
#import "MainScene.h"
#import <RevMobAds/RevMobAds.h>

@implementation Gameover
{
    NSInteger _points;
    NSInteger _highScore;

    CCLabelTTF *_scoreLabel;
    CCLabelTTF *_highscoreLabel;
    
    BOOL didShowScreen;
}

- (void)restart:(id)sender
{
   
    [self.mainScene restart];
}


-(void) playEffect
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"button.wav"];
}


-(void)update:(CCTime)delta

{

    // than reload  state
    [self loadSavedState];
    _highscoreLabel.string = [NSString stringWithFormat:@"%ld", (long)_highScore];
    
    
    [self loadSavedStatescore];
    _scoreLabel.string = [NSString stringWithFormat:@"%ld",(long)_points];
    

}


-(void)loadSavedState {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    _highScore = [prefs integerForKey:@"highScore"];
    _highscoreLabel.string = [NSString stringWithFormat:@"%ld",(long)_highScore];
    
}



- (void)loadSavedStatescore {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    _points = [prefs integerForKey:@"points"];
    _scoreLabel.string = [NSString stringWithFormat:@"%ld",(long)_points];
    
}

-(void)trackGameOver {
        NSInteger gamesPlayed = [[NSUserDefaults standardUserDefaults] integerForKey:@"gamesPlayed"];
        gamesPlayed++;
        [[NSUserDefaults standardUserDefaults] setInteger:gamesPlayed forKey:@"gamesPlayed"];
        if (gamesPlayed % 3 == 0) {
           // [[RevMobAds session] showFullscreen];
        }
}

@end
