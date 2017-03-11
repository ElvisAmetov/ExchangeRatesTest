//
//  SHXMLParser+Convertation.h
//  ExchangeRates
//
//  Created by Elvis on 3/11/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import <SHXMLParser/SHXMLParser.h>

@interface SHXMLParser (Convertation) 

+ (NSArray *)convertDictionaryArray:(NSArray *)dictionaryArray toObjectArrayWithClassName:(NSString *)className;

@end
