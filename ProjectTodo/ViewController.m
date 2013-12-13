//
//  ViewController.m
//  ProjectTodo
//
//  Created by 董元 on 13-12-12.
//  Copyright (c) 2013年 daniel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 
*/
- (IBAction)input:(UIButton *)sender {
    
    [self.inputField resignFirstResponder];
    
    NSString *command =  self.inputField.text;
    __block NSString *bCommand = command;
    
    
    //    Grand Central Dispatch (GCD)
    //    dispatch_sync(queue, block)同步提交job
    //    dispatch_async (queue, block) 异步提交job
    //    dispatch_after(time, queue, block) 同步延迟提交job
    
    //    其中第一个参数类型是dispatch_queue_t，就是一个表示队列的数据结构typedef struct dispatch_queue_s *dispatch_queue_t;
    //    block就是表示任务的Blocktypedef void (^dispatch_block_t)( void);。
    
    //    dispatch_async函数是异步非阻塞的，调用后会立刻返回，工作由系统在线程池中分配线程去执行工作。
    //    dispatch_sync和dispatch_after是阻塞式的，会一直等到添加的工作完成后才会返回。

    
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // something
    });
    
    // 优先级

    //#define DISPATCH_QUEUE_PRIORITY_DEFAULT 0
    //#define DISPATCH_QUEUE_PRIORITY_HIGH 2
    //#define DISPATCH_QUEUE_PRIORITY_LOW (-2)
    //#define DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN
    //如果使用dispatch_get_global_queue来生成全局队列时，可以设置4种优先级设置，但是如果没有明确的必要，不要在程序中使用不同的优先级来控制Block的执行，尤其是在特殊情况可能会导致这篇Blog提到的Priority Inversion问题，具体为什么直接查看这篇Blog的说明，记住一点尽量只用DISPATCH_QUEUE_PRIORITY_DEFAULT默认的优先级创建全局队列。
    
    
    
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        // something
    });

    // 一次性执行：
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once
    });

//    dispatch_once提供是和pthread库中类似pthread_once的功能
//    dispatch_once接口是指在整个App运行期间运行且仅运行一次提交的Block
//    但是由于dispatch_once会导致调试非常困难，因为最好少用dispatch_once，就像尽量少用NSObject的类方法+initialize()和+(void)load。
//    目前用到dispatch_once比较多的地方是在实现singleton单例模式的时候，要注意第一个参数dispatch_once_t必须是个全局或者static变量。
    
    // 延迟2秒执行：
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // code to be executed on the main queue after delay
         [self.outputLabel setText:[self blockTest:bCommand]];
    });
    //在App中用dispatch_after来控制UI的显示顺序时确实非常危险的
    //可能并不见的严格按照你期望的延迟量去显示UI，所以最好还是少碰dispatch_after，而是通过合适的回调来控制UI先后顺序
    //例如利用-viewWillAppear和-viewDidAppear来处理UI的先后顺序。
    

    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //[self doHardWorkInBackground];
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self updateUI];
        });
    });
    
    
    //Dispatch Group
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//    for(id obj in array)
//        dispatch_group_async(group, queue, ^{
//            [self doWorkOnItem:obj];
//        });
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    dispatch_release(group);
//    阻塞主线程
//    [self doWorkOnArray:array];
    
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_group_t group = dispatch_group_create();
//    for(id obj in array)
//        dispatch_group_async(group, queue, ^{
//            [self doWorkOnItem:obj];
//        });
    
//    dispatch_group_notify(group, queue, ^{
//        [self doWorkOnArray:array];
//    });
//    dispatch_release(group);

    
    
    
    
    //Dispatch Apply
    //要同步的执行对数组元素的逐个操作
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_apply([array count], queue, ^(size_t index){
//        [self doWorkOnItem:obj:[array objectAtIndex:index]];
//    });
//    [self doWorkOnArray:array];
    
    
    
    //Dispatch Barrier
    //在使用dispatch_async异步提交时，是无法保证这些工作的执行顺序的，如果需要某些工作在某个工作完成后再执行，那么可以使用Dispatch Barrier接口来实现
    //barrier也有同步提交dispatch_barrier_async(queue, block)和异步提交dispatch_barrier_sync(queue, block)两种方式
    
//    dispatch_async(queue, block1);
//    dispatch_async(queue, block2);
//    dispatch_barrier_async(queue, block3);
//    dispatch_async(queue, block4);
//    dispatch_async(queue, block5);
    
    //block1和block2的并行执行完成后才会执行block3，完成后再会并行运行block4和block5
    //注意这里的queue应该是一个并行队列，而且必须是dispatch_queue_create(label, attr)创建的自定义并行队列，否则dispatch_barrier_async操作就失去了意义。
    
    
    
}


- (NSString *)blockTest:(NSString *)command{
    
    return [NSString stringWithFormat:@"%@%@",command,command];
}
@end
