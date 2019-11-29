//
//  NSAttributedString+GHAdd.h
//  掌上优医
//
//  Created by GH on 2018/10/25.
//  Copyright © 2018 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (GHAdd)

+ (NSMutableAttributedString *)rangeSearchLight:(NSString *)string searchString:(NSString *)searchString;

+ (NSMutableAttributedString *)getAttributedStringWithSearchString:(NSString *)searchString;

@end

NS_ASSUME_NONNULL_END
