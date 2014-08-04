//
//  StartScene.m
//  FiftyFifty
//
//  Created by Mitchell Malinin on 8/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "StartScene.h"
#import "MainScene.h"
@implementation StartScene

-(void)play
{
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio preloadEffect:@"button.wav"];
   // [audio preloadEffect:@""];
    [audio playEffect:@"button.wav"];
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
    NSLog(@"clicked");
}

@end
