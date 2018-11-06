//
//  SendDataViewController.h
//  text
//
//  Created by Kosien on 17/4/15.
//  Copyright © 2017年 kosienDGL. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 定义一个名为nameBlock的block
 */
typedef void (^nameBlock)(NSString *);


@interface SendDataViewController : UIViewController

//声明一个block
@property (nonatomic, copy) nameBlock dataBlock;

//@property (nonatomic, copy) void (^dataBlock)(NSString *);

@end
