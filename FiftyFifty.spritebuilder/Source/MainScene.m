//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Player.h"
#import "Gameover.h"

static  CGFloat scrollSpeed = 250.f;

@implementation MainScene
{
    Player *player;
    CCPhysicsNode *_physicsNode;
    CCNodeColor *_background1;
    CCNodeColor *_background2;
    CCNode *_scroller;
    NSArray *_backgrounds;
    BOOL _loadPattern;
    CCNode * _pattern;
    BOOL presentedGameOver;
    float timerTillScrollFaster;
    
    CCLabelTTF *_scoreLabel;
    CCLabelTTF *_highscoreLabel;
    
    NSInteger _points;
    NSInteger _highScore;



}

-(void) didLoadFromCCB
{
    //_physicsNode.debugDraw = YES;
    self.userInteractionEnabled = TRUE;
    _physicsNode.collisionDelegate = self;
    _backgrounds = @[_background1, _background2];
    _loadPattern = YES;
    
    [self loadPattern];
    
    [self loadSavedState];
    scrollSpeed = 200.f;


}

-(void) doGameOver
{
//    [[GameState sharedInstance] setCurrentScore:points];
    
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"GameOver"]];
    presentedGameOver = YES;
    // [[CCDirector sharedDirector] pause];
    // [[[CCDirector sharedDirector] responderManager] removeAllResponders];
}

- (void)update:(CCTime)delta {
    
    
    _scroller.position = ccp(_scroller.position.x , _scroller.position.y - (scrollSpeed *delta));
    // loop the ground
    for (CCNode *background in _backgrounds) {
        // get the world position of the ground
        CGPoint backgroundWorldPosition = [_scroller convertToWorldSpace:background.position];
        // get the screen position of the ground
        CGPoint backgroundScreenPosition = [self convertToNodeSpace:backgroundScreenPosition];
        // if the left corner is one complete width off the screen, move it to the right
        if (backgroundScreenPosition.y <= (-.5*background.contentSize.height*background.scaleY)) {
            background.position = ccp(background.position.x, background.position.y + 2 * background.contentSize.height * background.scaleY);
        }
        scrollSpeed += 3* delta;

    }
    
}
-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair player:(CCSprite *)nodeA boundingBox:(CCNode *)nodeB
{

    return FALSE;
}

-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair player:(CCSprite *)nodeA obstacle:(CCNode *)nodeB
{
    [nodeA removeFromParent];
    [self doGameOver];
    return FALSE;
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

-(void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    player.position = ccp(touchLocation.x, player.position.y);
}



- (void) loadPattern
{
    
    CGPoint screenPosition = [self convertToWorldSpace:ccp(-118, 0)];
    CGPoint lastPosition = [_scroller convertToNodeSpace:screenPosition];
    
    CCNode *pattern;
    
    for (int i =1 ; i <= 50; i++) {
        int random = arc4random() % 4;
        NSLog(@"%i",random);
        switch (random) {
                
            case 0:
                pattern = [CCBReader load:@"pattern1"];
                break;
            case 1:
                pattern = [CCBReader load:@"pattern2"];
                break;
                
            case 2:
                pattern = [CCBReader load:@"pattern3"];
                break;
                
            case 3:
                pattern = [CCBReader load:@"pattern4"];
                break;

        }
        
        pattern.positionInPoints = ccp(-119, lastPosition.y);
        [_scroller addChild:pattern];
        lastPosition = ccp(lastPosition.x , lastPosition.y + pattern.contentSize.height + 2);
        
        
    }
    
    
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair player:(CCNode *)player goal:(CCNode *)goal
{
    [goal removeFromParent];
    _points++;
    _scoreLabel.string = [NSString stringWithFormat:@"%d", (int)_points];
    [self saveStatescore ];
    [self loadSavedStatescore];
    if (_points > _highScore)
    {
        _highScore = _points;
    }
    
    
    // first save your state
    [self saveState];
    [self loadSavedState];
    
    return false;
}
- (void)saveStatescore {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:_points forKey:@"points"];
    [prefs synchronize];
}



- (void)loadSavedStatescore {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    _points = [prefs integerForKey:@"points"];
}



- (void)saveState {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:_highScore forKey:@"highScore"];
    [prefs synchronize];
}

- (void)loadSavedState {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    _highScore = [prefs integerForKey:@"highScore"];
    _highscoreLabel.string = [NSString stringWithFormat:@"%ld",(long)_highScore];
    
}

@end
