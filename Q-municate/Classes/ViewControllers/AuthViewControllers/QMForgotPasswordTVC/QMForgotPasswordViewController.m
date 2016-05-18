//
//  QMForgotPasswordTVC.m
//  Qmunicate
//
//  Created by Andrey Ivanov on 30.06.14.
//  Copyright (c) 2014 Quickblox. All rights reserved.
//

#import "QMForgotPasswordViewController.h"
#import "QMTasks.h"
#import "QMNotification.h"

@interface QMForgotPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) BFTask *task;

@end

@implementation QMForgotPasswordViewController

- (void)dealloc {
    ILog(@"%@ - %@",  NSStringFromSelector(_cmd), self);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.emailTextField becomeFirstResponder];
}

#pragma mark - actions

- (IBAction)pressResetPasswordBtn:(id)__unused sender {
    
    if (self.task != nil) {
        // task in progress
        return;
    }
    
    NSString *email = self.emailTextField.text;
    
    if (email.length > 0) {
        
        [self resetPasswordForMail:email];
    }
    else {
        
        [QMNotification showNotificationPanelWithType:QMNotificationPanelTypeWarning message:NSLocalizedString(@"QM_STR_EMAIL_FIELD_IS_EMPTY", nil) timeUntilDismiss:kQMDefaultNotificationDismissTime];
    }
}

- (void)resetPasswordForMail:(NSString *)emailString {

    [QMNotification showNotificationPanelWithType:QMNotificationPanelTypeLoading message:NSLocalizedString(@"QM_STR_LOADING", nil) timeUntilDismiss:0];
    
    @weakify(self);
    self.task = [[QMTasks taskResetPasswordForEmail:emailString] continueWithBlock:^id _Nullable(BFTask * _Nonnull task) {
        
        @strongify(self);
        if (task.isFaulted) {
            
            [QMNotification showNotificationPanelWithType:QMNotificationPanelTypeFailed message:NSLocalizedString(@"QM_STR_USER_WITH_EMAIL_WASNT_FOUND", nil) timeUntilDismiss:kQMDefaultNotificationDismissTime];
        }
        else {
            
            [QMNotification showNotificationPanelWithType:QMNotificationPanelTypeSuccess message:NSLocalizedString(@"QM_STR_MESSAGE_WAS_SENT_TO_YOUR_EMAIL", nil) timeUntilDismiss:kQMDefaultNotificationDismissTime];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        return nil;
    }];
}

@end
