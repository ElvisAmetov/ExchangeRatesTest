//
//  NetworkManager.h
//  ExchangeRates
//
//  Created by Elvis on 3/10/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Completion) (id object, NSError *error);

@interface NetworkManager : NSObject

+ (NetworkManager*)sharedManger;

- (void)GET:(NSString*)path parameters:(NSDictionary*)parameters completion:(Completion)completion;

- (void)GET:(NSString*)path parameters:(NSDictionary*)parameters mappableClass:(Class)klass completion:(Completion)completion;

- (void)GET:(NSString*)path parameters:(NSDictionary*)parameters keyPath:(NSString*)keyPath mappableClass:(Class)klass completion:(Completion)completion;

@end
