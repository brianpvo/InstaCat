//
//  SafariViewController.m
//  Cats
//
//  Created by Brian Vo on 2018-04-26.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import "SafariViewController.h"
#import <SafariServices/SafariServices.h>

@interface SafariViewController () <SFSafariViewControllerDelegate>

@property (nonatomic) UIImageView *imageView;

@end

@implementation SafariViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView = [[UIImageView alloc] initWithImage:self.image];
    [self.view addSubview:self.imageView];
    
    [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.imageView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.imageView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
    
}
- (IBAction)safariButton:(id)sender {
    SFSafariViewController *sVC = [[SFSafariViewController alloc] initWithURL:self.url];
    sVC.delegate = self;
    
    [self presentViewController:sVC animated:NO completion:nil];
}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
