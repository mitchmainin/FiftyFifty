//
//  Gameover.m
//  FiftyFifty
//
//  Created by Justin Matsnev on 8/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameover.h"
#import "MainScene.h"

@implementation Gameover
{
    NSInteger _points;
    NSInteger _highScore;

    CCLabelTTF *_scoreLabel;
    CCLabelTTF *_highscoreLabel;

}

-(void)restart
{
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
    
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
@end
