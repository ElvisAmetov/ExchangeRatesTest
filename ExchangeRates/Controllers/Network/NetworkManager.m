//
//  NetworkManager.m
//  ExchangeRates
//
//  Created by Elvis on 3/10/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import <SHXMLParser/SHXMLParser.h>
#import "SHXMLParser+Convertation.h"

@interface NetworkManager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) SHXMLParser *parser;

@end

@implementation NetworkManager

static NetworkManager *networkManager = nil;
static NSString *baseUrl = @"http://www.cbr.ru/";

+ (NetworkManager*)sharedManger {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkManager = [[NetworkManager alloc] init];
        networkManager.parser = [[SHXMLParser alloc] init];
        [networkManager setup];
    });
    return networkManager;
}

- (void)setup {
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL: [NSURL URLWithString:baseUrl]];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", nil];
    self.manager.responseSerializer = responseSerializer;
}

- (void)GET:(NSString*)path parameters:(NSDictionary*)parameters completion:(Completion)completion {
    [self GET:path parameters:parameters mappableClass:nil completion:completion];
}

- (void)GET:(NSString*)path parameters:(NSDictionary*)parameters mappableClass:(Class)klass completion:(Completion)completion {
    [self GET:path parameters:parameters keyPath:nil mappableClass:klass completion:completion];
}

- (void)GET:(NSString*)path parameters:(NSDictionary*)parameters keyPath:(NSString*)keyPath mappableClass:(Class)klass completion:(Completion)completion {
    [self.manager GET:path parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        NSDictionary *result = [self.parser parseData:responseObject];

        if (keyPath != nil || ![keyPath isEqualToString:@""]) {
            NSArray *responseArray = [self responseArrayWithKeyPath:keyPath responseDict:result];
            if (klass != nil) {
                NSString *className = NSStringFromClass(klass);
                                
                NSArray *objects = [SHXMLParser convertDictionaryArray:responseArray toObjectArrayWithClassName:className];
                completion(objects, nil);
            } else {
                completion(responseArray, nil);
            }
        } else {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        completion(nil, error);
    }];
}

- (NSArray *)responseArrayWithKeyPath:(NSString *)keyPath responseDict:(NSDictionary *)responseDict {
    NSArray *keyPaths = [keyPath componentsSeparatedByString:@"."];
    NSArray *responseArray = nil;
    NSDictionary *dict = responseDict;
    id tmp = nil;
    for (NSString *path in keyPaths) {
        tmp = [SHXMLParser getDataAtPath:path fromResultObject:dict];
        if ([tmp isKindOfClass:[NSDictionary class]]) {
            dict = tmp;
        } else {
            responseArray = tmp;
        }
    }
    return responseArray;
}


@end
