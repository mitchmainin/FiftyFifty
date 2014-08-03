//
//  Player.m
//  FiftyFifty
//
//  Created by Justin Matsnev on 8/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Player.h"

@implementation Player

-(void) didLoadFromCCB
{
    self.physicsBody.collisionType = @"player";
}



@end
