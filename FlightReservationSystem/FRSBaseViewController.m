//
//  FRSBaseViewController.m
//  FlightReservationSystem
//
//  Created by Revanth Kumar on 11/25/15.
//  Copyright © 2015 Revanth Kumar. All rights reserved.
//

#import "FRSBaseViewController.h"
@interface FRSBaseViewController ()

@end

@implementation FRSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.navigationController){
        [TSMessage setDefaultViewController:self.navigationController];
    }
    else {
        [TSMessage setDefaultViewController:self];
    }
        

    //Tap Gesture
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tap:)];
    _tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:_tap];
}

-(void)tap:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self removeKeyBoard];
    }
}
-(void)removeKeyBoard
{
    //    [self MoveScrollViewToDown];
    for (UITextField *tf in self.view.subviews)
    {
        if ([tf isKindOfClass:[UITextField class]]) {
            [tf resignFirstResponder];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
