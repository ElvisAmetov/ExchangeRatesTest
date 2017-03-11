//
//  Currency.h
//  ExchangeRates
//
//  Created by Elvis on 3/10/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject <Mappable>

@property (nonatomic, strong, nullable) NSString *valuteId;
@property (nonatomic, assign, nullable) NSNumber *numCode;
@property (nonatomic, strong, nullable) NSString *charCode;
@property (nonatomic, strong, nullable) NSNumber *nominal;
@property (nonatomic, strong, nullable) NSString *name;
@property (nonatomic, strong, nullable) NSNumber *value;



@end
