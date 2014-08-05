//
//  credit.m
//  FiftyFifty
//
//  Created by yahya on 8/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "credit.h"
#import "StartScene.h"


@implementation credit
{

}




-(void)credit
{
    CCScene *StartScene = [CCBReader loadAsScene:@"StartScene"];
    [[CCDirector sharedDirector] replaceScene:StartScene];
    NSLog(@"clicked");
}




@end
