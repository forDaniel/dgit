//
//  AppDelegate.h
//  ProjectTodo
//
//  Created by 董元 on 13-12-12.
//  Copyright (c) 2013年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundUpdateTask;

@end
