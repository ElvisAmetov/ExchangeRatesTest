//
//  AlertController.h
//  ExchangeRates
//
//  Created by Elvis on 3/10/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertController : NSObject

+ (void)showWithError:(NSError*)error;

+ (void)showWithTitle:(NSString*)title message:(NSString*)message;

+ (void)showWithTitle:(NSString*)title
              message:(NSString*)message
    cancelButtonTitle:(NSString*)cancelButtonTitle
              actions:(NSArray <UIAlertAction*> *)actions;

@end
