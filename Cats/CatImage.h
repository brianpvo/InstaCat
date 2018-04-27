//
//  CatImage.h
//  Cats
//
//  Created by Brian Vo on 2018-04-26.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface CatImage : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *photoId;
@property (nonatomic) NSURL *url;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSURL *flickrURL;

- (instancetype)initWithTitleAndURL:(NSString *)title URL:(NSString *)url photoId:(NSString *)photoId;

-(UIImage *)downloadImageFromURL;

@end
