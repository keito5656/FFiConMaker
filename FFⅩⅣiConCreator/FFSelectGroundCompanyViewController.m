//
//  FFSelectGroundCompanyViewController.m
//  FFⅩⅣiConCreator
//
//  Created by 山本洸希 on 2014/02/22.
//  Copyright (c) 2014年 keito5656. All rights reserved.
//

#import "FFSelectGroundCompanyViewController.h"
#import "FFViewController.h"

@interface FFSelectGroundCompanyViewController ()

@end

@implementation FFSelectGroundCompanyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectCompany:(id)sender {
    FFViewController *ffVC = [self.storyboard instantiateViewControllerWithIdentifier:@"frameMaker"];
    UIButton *button = sender;
    ffVC.company = button.tag;
    [self.navigationController pushViewController:ffVC animated:YES];
}
@end
