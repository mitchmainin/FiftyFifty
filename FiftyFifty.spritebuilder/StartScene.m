//
//  StartScene.m
//  FiftyFifty
//
//  Created by Mitchell Malinin on 8/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "StartScene.h"

@implementation StartScene

- (void)play
{
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
    NSLog(@"CLicked");

}

@end
