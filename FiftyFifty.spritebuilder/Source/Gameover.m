//
//  Gameover.m
//  FiftyFifty
//
//  Created by Justin Matsnev on 8/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameover.h"

@implementation Gameover

-(void)play
{
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
    
}

@end
