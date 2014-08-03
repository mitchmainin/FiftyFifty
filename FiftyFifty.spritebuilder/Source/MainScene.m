//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Player.h"

@implementation MainScene
{
    Player *player;
    CCPhysicsNode *_physicsNode;
}

-(void) didLoadFromCCB
{
    self.userInteractionEnabled = TRUE;
    _physicsNode.collisionDelegate = self;

}


-(BOOL) ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair player:(CCSprite *)nodeA boundingBox:(CCNode *)nodeB
{

    return TRUE;
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    NSLog(@"jbvjbvbsvbsbfksd");
    
}

-(void) touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    player.position = ccp(touchLocation.x, player.position.y);
}

-(void)restart
{
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];

}
@end
