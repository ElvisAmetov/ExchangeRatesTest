//
//  ExchangeRatesCellVM.m
//  ExchangeRates
//
//  Created by Elvis on 3/10/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import "ExchangeRatesCellVM.h"

@implementation ExchangeRatesCellVM

- (instancetype)initWithModel:(Currency*)model {
    if (self = [super init]) {
        self.name = model.name;
        self.value = [NSString stringWithFormat:@"%@", model.value];
    }
    return self;
}

@end
