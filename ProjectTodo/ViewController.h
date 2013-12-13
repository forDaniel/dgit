//
//  ViewController.h
//  ProjectTodo
//
//  Created by 董元 on 13-12-12.
//  Copyright (c) 2013年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;

- (IBAction)input:(UIButton *)sender;
@end
