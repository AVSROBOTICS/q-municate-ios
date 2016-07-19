//
//  QMHelpers.m
//  Q-municate
//
//  Created by Vitaliy Gorbachov on 7/19/16.
//  Copyright © 2016 Quickblox. All rights reserved.
//

#import "QMHelpers.h"

CGRect CGRectOfSize(CGSize size) {
    
    return (CGRect) {CGPointZero, size};
}

NSString *QMStringForTimeInterval(NSTimeInterval timeInterval) {
    
    NSInteger minutes = (NSInteger)(timeInterval / 60);
    NSInteger seconds = (NSInteger)timeInterval % 60;
    
    NSString *timeStr = [NSString stringWithFormat:@"%zd:%02zd", minutes, seconds];
    
    return timeStr;
}