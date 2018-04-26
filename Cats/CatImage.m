//
//  CatImage.m
//  Cats
//
//  Created by Brian Vo on 2018-04-26.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import "CatImage.h"

@implementation CatImage

- (instancetype)initWithTitleAndURL:(NSString *)title URL:(NSString *)url
{
    self = [super init];
    if (self) {
        _title = title;
        _url = [NSURL URLWithString:url];
    }
    return self;
}

-(UIImage *)downloadImageFromURL {
    if (self.image == nil) {
        self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.url]];
    }
    
    return self.image;
}

@end
