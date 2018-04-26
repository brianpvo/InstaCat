//
//  ViewController.m
//  Cats
//
//  Created by Brian Vo on 2018-04-26.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self URLRequest];
}

-(void)URLRequest {
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=53fbe5403f875ec142bd4cff9e44215a&tags=cat"]; // 1
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            // This will run on the main queue
//
//        }];
        
        [self processDataToJSON:data];
        
    }]; // 5
    
    [dataTask resume]; // 6
}

-(void)processDataToJSON:(NSData *)responseData {
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:responseData
                                              options:0
                                                error:&error];
    if (error) { // 1
        // Handle the error
        NSLog(@"error: %@", error.localizedDescription);
        return;
    }
    
    if ([json isKindOfClass:[NSDictionary class]]) {
        NSDictionary *jsonDict = (NSDictionary *)json;
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self processResponseDictionary:jsonDict];
        }];
    }
}

- (void)processResponseDictionary:(NSDictionary *)responseDictionary {
    NSDictionary *photos = [[NSDictionary alloc] initWithDictionary:responseDictionary[@"photos"]];
    NSArray *photoArray = photos[@"photo"];
    for (NSDictionary *photoInfo in photoArray) {
        NSString *farmId = photoInfo[@"farm"];
        NSString *serverId = photoInfo[@"server"];
        NSString *photoId = photoInfo[@"id"];
        NSString *secret = photoInfo[@"secret"];
        
        NSString *url = [NSString stringWithFormat:
                         @"https://farm%@.staticflickr.com/%@/%@_%@.jpg",
                         farmId,
                         serverId,
                         photoId,
                         secret];
        
        NSLog(@"url %@", url);
        
    }

    NSLog(@"photo array %@", [photoArray objectAtIndex:0]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end