//
//  ExchangeRatesViewControllerVM.h
//  ExchangeRates
//
//  Created by Elvis on 3/10/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "ExchangeRatesCellVM.h"

@interface ExchangeRatesViewControllerVM : NSObject

@property (nonatomic, strong) NSArray <ExchangeRatesCellVM *> *cellsData;

@property (nonatomic, strong) RACSubject *startedUpdateSignal;
@property (nonatomic, strong) RACSubject *endedUpdateSignal;
@property (nonatomic, strong) RACSubject *reciveErrorSignal;

- (void)requestData;

@end
