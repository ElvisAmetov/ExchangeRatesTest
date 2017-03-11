//
//  Currency.m
//  ExchangeRates
//
//  Created by Elvis on 3/10/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import "Currency.h"

@implementation Currency

static NSString *kCurrencyKey = @"CurrencyKey";

- (void)map:(NSDictionary *)dict {
    self.valuteId = dict[@"ID"];
    self.numCode = dict[@"NumCode"];
    self.charCode = dict[@"CharCode"];
    self.nominal = dict[@"Nominal"];
    self.name = dict[@"Name"];
    self.value = dict[@"Value"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.valuteId = [decoder decodeObjectForKey:@"valuteId"];
        self.numCode = [decoder decodeObjectForKey:@"numCode"];
        self.charCode = [decoder decodeObjectForKey:@"charCode"];
        self.nominal = [decoder decodeObjectForKey:@"nominal"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.value = [decoder decodeObjectForKey:@"value"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.valuteId forKey:@"valuteId"];
    [encoder encodeObject:self.numCode forKey:@"numCode"];
    [encoder encodeObject:self.charCode forKey:@"charCode"];
    [encoder encodeObject:self.nominal forKey:@"nominal"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.value forKey:@"value"];
}

+ (void)save:(NSArray*)objects {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:objects];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrencyKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)load {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrencyKey];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return object;
}



@end
