//
//  ExchangeRatesViewControllerVM.m
//  ExchangeRates
//
//  Created by Elvis on 3/10/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import "ExchangeRatesViewControllerVM.h"
#import "NetworkManager.h"
#import "Currency.h"

@implementation ExchangeRatesViewControllerVM

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.startedUpdateSignal = [[RACSubject subject] setNameWithFormat:@"startedUpdateSignal"];
        self.endedUpdateSignal = [[RACSubject subject] setNameWithFormat:@"endedUpdateSignal"];
        self.reciveErrorSignal = [[RACSubject subject] setNameWithFormat:@"reciveErrorSignal"];
    }
    return self;
}

- (void)requestData {
    [self.startedUpdateSignal sendNext:nil];
    [[NetworkManager sharedManger] GET:kURLPathExchangeRates parameters:nil keyPath:@"ValCurs.Valute" mappableClass:[Currency class] completion:^(id objects, NSError *error) {
        if (error != nil) {
            NSArray *models = [Currency load];
            self.cellsData = [self cellsDataWithModels:models];
            [self.reciveErrorSignal sendNext:error];
        } else {
            NSArray *models = [self filteredCellsDataWithObjects:objects];
            [Currency save:models];
            self.cellsData = [self cellsDataWithModels:models];
            [self.endedUpdateSignal sendNext:nil];
        }
    }];
}

- (NSArray *)cellsDataWithModels:(NSArray *)models {
    NSMutableArray *cellsData = [NSMutableArray new];
    for (Currency *model in models) {
        ExchangeRatesCellVM *vm = [[ExchangeRatesCellVM alloc] initWithModel:model];
        [cellsData addObject:vm];
    }
    return [cellsData copy];
}

- (NSArray *)filteredCellsDataWithObjects:(NSArray *)objects {
    NSMutableArray *filteredArray = [NSMutableArray new];
    for (Currency *currency in objects) {
        if ([currency.charCode isEqualToString:@"USD"] ||
            [currency.charCode isEqualToString:@"EUR"]) {
            [filteredArray addObject:currency];
        }
    }
    return [filteredArray copy];
}

@end
