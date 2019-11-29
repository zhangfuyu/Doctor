//
//  GHSecondDepartModel.h
//  掌上优医
//
//  Created by apple on 2019/9/3.
//  Copyright © 2019年 GH. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GHSecondDepartModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *commonName;

@property (nonatomic, strong) NSString<Optional> *diseaseName;


@property (nonatomic, strong) NSString<Optional> *modelid;

@property (nonatomic, strong) NSString<Optional> *shouldHeight;

@property (nonatomic, assign) NSNumber<Optional> *isSelected;



@end

NS_ASSUME_NONNULL_END
