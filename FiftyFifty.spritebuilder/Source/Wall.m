//
//  Wall.m
//  FiftyFifty
//
//  Created by Mitchell Malinin on 8/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Wall.h"
#import "CCEffectPixellate.h"


@implementation Wall

-(void)didLoadFromCCB
{
    [self.physicsBody setType:CCPhysicsBodyTypeStatic];
   // self.effect = [CCEffectPixellate effectWithBlockSize: 4];

}
@end
