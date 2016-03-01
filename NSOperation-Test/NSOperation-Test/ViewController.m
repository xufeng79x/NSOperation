//
//  ViewController.m
//  NSOperation-Test
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 测试入口
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[self test_NSInvocationOperation_GlobQueue];
    //[self test_NSInvocationOperation_MainQueue];
    //[self test_NSBlockOperation_GlobQueue];
    //[self test_NSBlockOperation_MainQueue];
    //[self test_Sample_NSBlockOperation_GlobQueue];
    //[self test_Sample_NSBlockOperation_MainQueue];
}

/**
 *  测试NSInvocationOperation
 *  运行在全局队列
 */
- (void) test_NSInvocationOperation_GlobQueue
{
    //1. 获取队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 多线程多个操作
    for (int i = 0; i < 10; i++) {
        //2. 以NSInvocationOperation方式来创建operation
        NSOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"invocation"];
        
        //3. 将operation放到queue中
        [queue addOperation:op];
    }
    
    NSLog(@"完成！");
}

/**
 *  测试NSInvocationOperation
 *  运行在主队列
 */
- (void) test_NSInvocationOperation_MainQueue
{
    //1. 获取队列
    NSOperationQueue *queue = [NSOperationQueue mainQueue];

    // 多线程多个操作
    for (int i = 0; i < 10; i++) {
        //2. 以NSInvocationOperation方式来创建operation
        NSOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"invocation"];
        
        //3. 将operation放到queue中
        [queue addOperation:op];
    }
    
    NSLog(@"完成！");
}

- (void) downloadImage:(id) obj
{
    NSLog (@"%@--------%@", [NSThread currentThread], obj);
    NSOperationQueue *queue1 = [NSOperationQueue currentQueue];
    queue1 = nil;
    
}

/**
 *  测试NSBlockOperation
 *  运行在全局队列
 */
- (void) test_NSBlockOperation_GlobQueue
{
    //1. 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    for (int i = 0; i < 10; i++) {
        //2. 以NSInvocationOperation方式来创建operation
        NSOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"------------%@", [NSThread currentThread]);
        }];
        
        //3. 将operation放到queue中
        [queue addOperation:op];
    }
    
    NSLog(@"完成");
}

/**
 *  测试NSBlockOperation
 *  运行在主队列
 */
- (void) test_NSBlockOperation_MainQueue
{
    //1. 创建队列
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    for (int i = 0; i < 10; i++) {
        //2. 以NSInvocationOperation方式来创建operation
        NSOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"------------%@", [NSThread currentThread]);
        }];
        
        //3. 将operation放到queue中
        [queue addOperation:op];
    }
    
    NSLog(@"完成");
}

/**
 *  测试建议方式运行的NSBlockOperation
 *  运行在全局队列
 */
- (void) test_Sample_NSBlockOperation_GlobQueue
{
    //1. 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    for (int i = 0; i < 10; i++) {
        //2. 直接将operation放到queue中
        [queue addOperationWithBlock:^{
            NSLog(@"------------%@", [NSThread currentThread]);
        }];
    }
    
    NSLog(@"完成");
}

/**
 *  测试建议方式运行的NSBlockOperation
 *  运行在主队列
 */
- (void) test_Sample_NSBlockOperation_MainQueue
{
    //1. 创建队列
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    
    for (int i = 0; i < 10; i++) {
        //2. 直接将operation放到queue中
        [queue addOperationWithBlock:^{
            NSLog(@"------------%@", [NSThread currentThread]);
        }];
    }
    
    NSLog(@"完成");
}

@end
