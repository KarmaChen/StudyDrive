//
//  ViewController.m
//  StudyDrive
//
//  Created by Karma on 16/4/28.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import "ViewController.h"
#import "SelectView.h"
@interface ViewController ()
{
    SelectView * _selectView;
    __weak IBOutlet UIButton *selectButton;
}

@end

@implementation ViewController
- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _selectView.alpha = 1;
            }];
            
        }
            break;
        case 101:
        {
            
        }
             break;
        case 102:
        {
            
        }
             break;
        case 103:
        {
            
        }
             break;
        case 104:
        {
            
        }
             break;
        case 105:
        {
            
        }
             break;
        case 106:
        {
            
        }
             break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _selectView =  [[SelectView alloc]initWithFrame:self.view.frame andBtn:selectButton];
    _selectView.alpha = 0;
    [self.view addSubview:_selectView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
