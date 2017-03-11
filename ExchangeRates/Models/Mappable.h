//
//  Mappable.h
//  ExchangeRates
//
//  Created by Elvis on 3/11/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Mappable <NSObject>

- (void)map:(NSDictionary*)dict;

@optional

+ (void)save:(NSArray*)objects;
+ (id)load;

@end
