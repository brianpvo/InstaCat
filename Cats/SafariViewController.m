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

@end

@implementation SafariViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.url = [NSURL URLWithString:@"https:\/\/www.flickr.com\/photos\/145831940@N02\/39914823610\/"];
    SFSafariViewController *sVC = [[SFSafariViewController alloc] initWithURL:self.url];
    sVC.delegate = self;
    
    [self presentViewController:sVC animated:NO completion:nil];
            
}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
