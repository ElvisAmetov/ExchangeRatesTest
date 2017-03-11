//
//  AlertController.m
//  ExchangeRates
//
//  Created by Elvis on 3/10/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import "AlertController.h"
#import "AppDelegate.h"

@interface AlertController ()

@end

@implementation AlertController

static UIAlertController *alertController;

+ (void)showWithTitle:(NSString*)title
              message:(NSString*)message
    cancelButtonTitle:(NSString*)cancelButtonTitle
              actions:(NSArray <UIAlertAction*> *)actions {
    
    if (alertController != nil) {
        alertController.title = title;
        alertController.message = message;
        [((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController  presentViewController:alertController animated:true completion:nil];
        return;
    }
    alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    for (UIAlertAction *action in actions) {
        [alertController addAction:action];
    }
    [((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController  presentViewController:alertController animated:true completion:nil];
}

+ (void)showWithTitle:(NSString*)title message:(NSString*)message {
    [self showWithTitle:title message:message cancelButtonTitle:@"OK" actions:nil];
}

+ (void)showWithError:(NSError*)error {
    [AlertController showWithTitle:@"Ошибка" message:error.localizedDescription cancelButtonTitle:@"OK" actions:nil];
}

@end
