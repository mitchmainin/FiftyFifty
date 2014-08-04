//
//  Player.m
//  FiftyFifty
//
//  Created by Justin Matsnev on 8/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Player.h"
#import "CCEffectPixellate.h"

@implementation Player

-(void) didLoadFromCCB
{
    self.physicsBody.collisionType = @"player";
   // self.effect = [CCEffectPixellate effectWithBlockSize: 4];

}


@end
