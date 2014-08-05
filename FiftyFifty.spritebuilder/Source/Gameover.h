//
//  Gameover.h
//  FiftyFifty
//
//  Created by Justin Matsnev on 8/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@class MainScene;

@interface Gameover : CCNode

@property (nonatomic, weak) MainScene *mainScene;

-(void)trackGameOver;
@end
