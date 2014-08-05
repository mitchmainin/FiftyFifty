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
#import "CCPhysics+ObjectiveChipmunk.h"
#import "CCEffectGlow.h"
#import <RevMobAds/RevMobAds.h>
#import "goal.h"


static  CGFloat scrollSpeed = 500.f;

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

    CCSprite *_wall;
    CCNode *_testicles;
    
//    BOOL _touchedWall;
//    BOOL _collidedFromRightSide;
    
    float _timeSinceObstacle;
    CCLabelTTF *_instructions;
    
    BOOL _gameOver;
    CCNodeColor *_bottomFloor;
    CCSprite *_finger;
    CCNodeColor *_side;
    CCNodeColor *_side2;
    
    float totalGameTime;
    
    bool paused;
    Gameover *_gameOverScreen;
    
    BOOL didShowScreen;
}

-(void) didLoadFromCCB
{
    //_physicsNode.debugDraw = YES;
    //_physicsNode.debugDraw = YES;
    self.userInteractionEnabled = TRUE;
    _physicsNode.collisionDelegate = self;
    _backgrounds = @[_background1, _background2];
    _loadPattern = YES;
    
    [self loadPattern];
    
    [self loadSavedState];
    scrollSpeed = 0.f;
    
    _timeSinceObstacle = 0.0f;
    totalGameTime = 0;
    
    paused = true;
    
    //[[CCDirector sharedDirector] pause];
    

   // [self playBG];
    
//    CCAnimationManager* animationManager = _finger.animationManager;
//    // timeline reference for rolling
//    [animationManager runAnimationsForSequenceNamed:@"Timeline"];
    

}

-(void) doGameOver
{
//    [[GameState sharedInstance] setCurrentScore:points];
//    CCSprite *explosion = (CCSprite *)[CCBReader load:@"particleEffect"];
//    // explosion.autoRemoveOnFinish = TRUE;
//    explosion.position = [player convertToWorldSpace:ccp(50, 31)];
//    [player.parent addChild:explosion];
//    //  _gun.visible = NO;
//    player.physicsBody.collisionCategories = @[];
//    [[CCDirector sharedDirector] replaceScene: [CCBReader load:@"GameOver"]];

    _gameOverScreen.mainScene = self;
    CCAnimationManager* animationManager = self.animationManager;
    [_gameOverScreen trackGameOver];
    [animationManager runAnimationsForSequenceNamed:@"GameoverIn"];
//    if (!didShowScreen) {
//        
//        
//        NSInteger gamesPlayed = [[NSUserDefaults standardUserDefaults] integerForKey:@"gamesPlayed"];
//        gamesPlayed++;
//        [[NSUserDefaults standardUserDefaults] setInteger:gamesPlayed forKey:@"gamesPlayed"];
//        if (gamesPlayed % 3 == 0) {
//            [[RevMobAds session] showFullscreen];
//        }
//        didShowScreen = TRUE;
//    }

//     [[CCDirector sharedDirector] pause];

    // [[CCDirector sharedDirector] pause];
//     [[[CCDirector sharedDirector] responderManager] removeAllResponders];
}

-(void) playEffect
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"button.wav"];
}

-(void)restart
{
    [self playEffect];
    CCAnimationManager* animationManager = self.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"GameoverOut"];
    
    
    
}

//-(BOOL) ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair goal:(CCNode *)nodeA sensor:(CCNode *)nodeB
//{
//    [self removeChild:goal];
//    CCParticleExplosion *explosion = [[CCParticleExplosion alloc] init];
//    CCSprite *explosionPic = [CCSprite spriteWithImageNamed:@"ccbResources/explosionParticle.png"];
//    explosion.texture = explosionPic.texture;
//    explosion.speed = 200;
//    [explosion setTotalParticles:30];
//    [nodeA addChild:explosion];
//    explosion.position = ccp(110 ,110);
//    
//    return false;
//}

- (void)update:(CCTime)delta {
    
    if (!presentedGameOver) {
        totalGameTime += delta;
        
        // FINGER MOVING
        float centerOfScreen = _instructions.positionInPoints.x;
        _finger.positionInPoints = ccp(cos(totalGameTime * 3) * 70 + centerOfScreen,_finger.positionInPoints.y);
        //
        
        if (paused) return;
        
        _scroller.positionInPoints = ccp(_scroller.positionInPoints.x , _scroller.positionInPoints.y - (scrollSpeed *delta));
        // loop the ground
        for (CCNode *background in _backgrounds) {
            // get the world position of the ground
            CGPoint backgroundWorldPosition = [_scroller convertToWorldSpace:background.positionInPoints];
            // get the screen position of the ground
            CGPoint backgroundScreenPosition = [self convertToNodeSpace:backgroundScreenPosition];
            // if the left corner is one complete width off the screen, move it to the right
            if (backgroundScreenPosition.y <= (-.5*background.contentSize.height*background.scaleY)) {
                background.positionInPoints = ccp(background.positionInPoints.x, background.positionInPoints.y + 2 * background.contentSize.height * background.scaleY);
            }
            scrollSpeed += 2.2* delta;
            
        }
        // Increment the time since the last obstacle was added
        _timeSinceObstacle += delta; // delta is approximately 1/60th of a second
        
        // Check to see if two seconds have passed
        if (_timeSinceObstacle > 0.25f)
        {
            // Add a new obstacle
            [self loadPattern];
            
            // Then reset the timer.
            _timeSinceObstacle = 0.0f;
            
        }

    }
    
    
}

-(void)playBG
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playBg:@"techno.wav" loop:TRUE];
}


-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair player:(CCSprite *)nodeA boundingBox:(CCNode *)nodeB
{

    return FALSE;
}
//-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair player:(CCSprite *)nodeA test:(CCNode *)nodeB
//{
//
//    
//    _touchedWall = true;
//    if((nodeB.positionInPoints.x-nodeA.positionInPoints.x)>0.0)
//    {
//        _collidedFromRightSide = false;
//    }
//    else
//    {
//        _collidedFromRightSide = true;
//    }
//    return FALSE;
//}


-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair player:(CCSprite *)nodeA obstacle:(CCNode *)nodeB
{
    [nodeA removeFromParent];
    if (!_gameOver) {
        presentedGameOver = YES;
        _gameOver = YES;
        CCParticleExplosion *explosion = [[CCParticleExplosion alloc] init];
        CCSprite *explosionPic = [CCSprite spriteWithImageNamed:@"ccbResources/explosionParticle.png"];
        explosion.texture = explosionPic.texture;
        
        explosion.color = [CCColor redColor];
        explosion.speed = 180;
        [explosion setTotalParticles:30];
        [_testicles addChild:explosion];
        explosion.positionInPoints = player.positionInPoints;
        scrollSpeed = 0;
        [self performSelector:@selector(doGameOver) withObject:nil afterDelay:1];
    }
    return FALSE;
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!presentedGameOver) {
        _instructions.visible = FALSE;
       // _bottomFloor.visible = FALSE;
        _finger.visible = FALSE;
        [self performSelector:@selector(side) withObject:nil afterDelay:1];
        [self performSelector:@selector(side2) withObject:nil afterDelay:1];

        scrollSpeed = 500.f;
        paused = false;
    }

    //[[CCDirector sharedDirector] resume];
}

-(void) side
{
    _side.visible = FALSE;
}

-(void) side2
{
    _side2.visible = FALSE;
}


-(void) actualRestart
{
    
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
    [[CCDirector sharedDirector] resume];
}

-(void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!presentedGameOver) {
        CGPoint touchLocation = [touch locationInNode:self];
        player.positionInPoints = ccp(touchLocation.x, player.positionInPoints.y);
    }
}



- (void) loadPattern
{
    
    CGPoint screenPosition = [self convertToWorldSpace:ccp(-118, 0)];
    CGPoint lastPosition = [_scroller convertToNodeSpace:screenPosition];
    
    CCNode *pattern;

    
    
        int random = arc4random() % 2;
        NSLog(@"%i",random);
        switch (random) {
                
            case 0:
                pattern = [CCBReader load:@"pattern1"];
                break;
            case 1:
                pattern = [CCBReader load:@"pattern2"];
                break;
                

        }
        
        pattern.positionInPoints = ccp(-119, lastPosition.y+290);
        [_scroller addChild:pattern];

        lastPosition = ccp(lastPosition.x , lastPosition.y + pattern.contentSize.height);
        
        
    
    
    
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair player:(CCNode *)player goal:(CCNode *)goal
{

    [goal removeFromParent];
    _points++;
//    _obstacle.effect = [CCEffectGlow effectWithBlurStrength:10.0f];
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
