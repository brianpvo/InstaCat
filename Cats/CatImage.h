//
//  CatImage.h
//  Cats
//
//  Created by Brian Vo on 2018-04-26.
//  Copyright © 2018 Brian Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatImage : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSURL *url;

- (instancetype)initWithTitleAndURL:(NSString *)title URL:(NSString *)url;

@end
