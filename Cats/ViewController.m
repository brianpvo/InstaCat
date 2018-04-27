//
//  ViewController.m
//  Cats
//
//  Created by Brian Vo on 2018-04-26.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import "ViewController.h"
#import "CatImage.h"
#import "CatImageCell.h"
#import "SafariViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) NSMutableArray <CatImage *> *catImageArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.catImageArray = [[NSMutableArray alloc] init];
    [self URLRequest:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=53fbe5403f875ec142bd4cff9e44215a&tags=cat" completion:^(NSDictionary *jsonDict){
        [self processResponseDictionary:jsonDict];
        [self.collectionView reloadData];
    }];
}

-(void)URLRequest:(NSString *)html completion:(void (^)(NSDictionary *dict))completion {
    NSURL *url = [NSURL URLWithString:html]; // 1
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url]; // 2
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 3
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 4
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        //[self processDataToJSON:data];
//        NSError *error = nil;
        id json = [NSJSONSerialization JSONObjectWithData:data
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
//                [self processResponseDictionary:jsonDict];
//                [self.collectionView reloadData];
                completion(jsonDict);
            }];
        }
        
    }]; // 5
    
    [dataTask resume]; // 6
}

- (void)processResponseDictionary:(NSDictionary *)responseDictionary {
    NSDictionary *photos = [[NSDictionary alloc] initWithDictionary:responseDictionary[@"photos"]];
    NSArray *photoArray = photos[@"photo"];
    for (NSDictionary *photoInfo in photoArray) {
        NSString *farmId = photoInfo[@"farm"];
        NSString *serverId = photoInfo[@"server"];
        NSString *photoId = photoInfo[@"id"];
        NSString *secret = photoInfo[@"secret"];
        NSString *title = photoInfo[@"title"];
        
        NSString *url = [NSString stringWithFormat:
                         @"https://farm%@.staticflickr.com/%@/%@_%@.jpg",
                         farmId,
                         serverId,
                         photoId,
                         secret];
        
//        NSLog(@"url %@", url);
        
        CatImage *catImage = [[CatImage alloc] initWithTitleAndURL:title URL:url];
        [self.catImageArray addObject:catImage];
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.catImageArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CatImageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"catImageCellId" forIndexPath:indexPath];
    
    CatImage *catImage = [self.catImageArray objectAtIndex:indexPath.row];
    
    cell.imageView.image = [catImage downloadImageFromURL];
    cell.titleLabel.text = catImage.title;
    
    return cell;
    
}



//- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CatImageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"catImageCellId" forIndexPath:indexPath];
//
//    CatImage *catImage = [self.catImageArray objectAtIndex:indexPath.row];
//    //[self performSegueWithIdentifier:@"safariButtonId" sender:catImage.url];
//
//}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    SafariViewController *sVC = [segue destinationViewController];
//    sVC.url = sender;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
