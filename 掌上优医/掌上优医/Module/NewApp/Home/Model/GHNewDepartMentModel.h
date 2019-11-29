//
//  GHNewDepartMentModel.h
//  掌上优医
//
//  Created by apple on 2019/8/30.
//  Copyright © 2019年 GH. All rights reserved.
//


#import "JSONModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface GHNewDepartMentModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *createTime;

@property (nonatomic, strong) NSString<Optional> *departmentName;

@property (nonatomic, strong) NSString<Optional> *iconUrl;

@property (nonatomic, strong) NSString<Optional> *modelid;

@property (nonatomic, strong) NSString<Optional> *introduce;

@property (nonatomic, strong) NSString<Optional> *level;

@property (nonatomic, strong) NSString<Optional> *orderNum;

@property (nonatomic, strong) NSString<Optional> *departmentId;

@property (nonatomic, strong) NSString<Optional> *parentId;

@property (nonatomic, strong) NSString<Optional> *thinkWords;

@property (nonatomic, strong) NSString<Optional> *updateTime;

@property (nonatomic, strong) NSMutableArray<Optional> *secondDepartmentList;

@property (nonatomic, strong) NSNumber<Optional> *isOpen;


@property (nonatomic, assign) NSNumber<Optional> *isSelected;
@end

NS_ASSUME_NONNULL_END
