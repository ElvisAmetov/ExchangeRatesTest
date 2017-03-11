//
//  ExchangeRatesCell.m
//  ExchangeRates
//
//  Created by Elvis on 3/10/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import "ExchangeRatesCell.h"
#import "ExchangeRatesCellVM.h"

@interface ExchangeRatesCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;


@end

@implementation ExchangeRatesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupWithViewModel:(id)viewModel {
    if ([viewModel isKindOfClass:[ExchangeRatesCellVM class]]) {
        ExchangeRatesCellVM *vm = (ExchangeRatesCellVM*)viewModel;
        self.nameLabel.text = vm.name;
        self.valueLabel.text = vm.value;
    }
}


@end
