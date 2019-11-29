//
//  GHCoinRecordModel.h
//  掌上优医
//
//  Created by GH on 2019/2/20.
//  Copyright © 2019 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHCoinRecordModel : JSONModel

/**
 交易金额
 */
@property (nonatomic, copy) NSString<Optional> *amount;

/**
 收支类型：1 ：收入 2：支出
 */
@property (nonatomic, copy) NSString<Optional> *balanceChangeType;

/**

 */
@property (nonatomic, copy) NSString<Optional> *gmtCreate;

/**

 */
@property (nonatomic, copy) NSString<Optional> *gmtModified;

/**

 */
@property (nonatomic, copy) NSString<Optional> *modelId;

/**
 交易描述 为1-50个字符
 */
@property (nonatomic, copy) NSString<Optional> *transactionDesc;

/**
 交易ID
 */
@property (nonatomic, copy) NSString<Optional> *transactionId;

/**
 用户ID
 */
@property (nonatomic, copy) NSString<Optional> *userId;

@end

NS_ASSUME_NONNULL_END
