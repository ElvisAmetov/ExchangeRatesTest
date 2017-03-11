//
//  ExchangeRatesCellVM.h
//  ExchangeRates
//
//  Created by Elvis on 3/10/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@interface ExchangeRatesCellVM : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;

- (instancetype)initWithModel:(Currency*)model;

@end
