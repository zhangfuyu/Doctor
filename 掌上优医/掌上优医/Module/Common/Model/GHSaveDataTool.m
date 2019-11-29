//
//  GHSaveDataTool.m
//  掌上优医
//
//  Created by GH on 2018/11/13.
//  Copyright © 2018 GH. All rights reserved.
//

#import "GHSaveDataTool.h"

#import "GHNoticeSystemModel.h"
#import "GHNoticeCommentModel.h"
#import "GHNoticeLikeModel.h"

#import "NSDate+YYAdd.h"

#import "GHZuJiHospitalModel.h"
#import "GHZuJiDoctorModel.h"
#import "GHZuJiSicknessModel.h"
#import "GHZuJiInformationModel.h"

#import "GHNDoctorRecordModel.h"
#import "GHNHospitalRecordModel.h"

@interface GHSaveDataTool ()

@end

static NSString *GHSaveDataType_Record_Sickness = @"GHSaveDataType_Record_Sickness";
static NSString *GHSaveDataType_Record_Doctor = @"GHSaveDataType_Record_Doctor";
static NSString *GHSaveDataType_Record_Hospital = @"GHSaveDataType_Record_Hospital";
static NSString *GHSaveDataType_Record_Information = @"GHSaveDataType_Record_Information";

static NSString *GHSaveDataType_Comment_Record_Doctor = @"GHSaveDataType_Comment_Record_Doctor";
static NSString *GHSaveDataType_Comment_Record_Hospital = @"GHSaveDataType_Comment_Record_Hospital";

static NSString *GHSaveDataType_PostDetailDraftPath = @"GHSaveDataType_PostDetailDraftPath";
static NSString *GHSaveDataType_PostDetailTitlePath = @"GHSaveDataType_PostDetailTitlePath";

static NSString *GHSaveDataType_CountryPath = @"GHSaveDataType_CountryPath";
static NSString *GHSaveDataType_ProvinceCityAreaPath = @"GHSaveDataType_ProvinceCityAreaPath";
static NSString *GHSaveDataType_SortCityPath = @"GHSaveDataType_SortCityPath";
static NSString *GHSaveDataType_SaveCityTime = @"GHSaveDataType_SaveCityTime";

@implementation GHSaveDataTool

+ (instancetype)shareInstance {
    
    static GHSaveDataTool *_tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[GHSaveDataTool alloc] init];
    });
    return _tool;
    
}

- (void)addObjectToCommentDoctorRecord:(id)object {
    
    if (object == nil) {
        return;
    }
    
    NSArray *dataArray = [self getSandboxNoticeDataWithCommentDoctorRecord];
    
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    
    [newArray addObject:object];
    
    for (GHNDoctorRecordModel *oldModel in dataArray) {
        
        if ([oldModel.modelId longValue] != [((GHNDoctorRecordModel *)object).modelId longValue]) {
            
            [newArray addObject:oldModel];
            
        }
        
    }
    
    NSString *path = [self getSaveDataPathWithFileName:GHSaveDataType_Comment_Record_Doctor];
    
    [NSKeyedArchiver archiveRootObject:[newArray copy] toFile:path];
    
}

- (void)addObjectToCommentHospitalRecord:(id)object {
    
    if (object == nil) {
        return;
    }
    
    NSArray *dataArray = [self getSandboxNoticeDataWithCommentHospitalRecord];
    
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    
    [newArray addObject:object];
    
    for (GHNHospitalRecordModel *oldModel in dataArray) {
        
        if ([oldModel.modelId longValue] != [((GHNHospitalRecordModel *)object).modelId longValue]) {
            
            [newArray addObject:oldModel];
            
        }
        
    }
    
    
    
    NSString *path = [self getSaveDataPathWithFileName:GHSaveDataType_Comment_Record_Hospital];
    
    [NSKeyedArchiver archiveRootObject:[newArray copy] toFile:path];
    
}

- (void)addObject:(id)object withType:(GHSaveDataType)type {
    
    if (object == nil) {
        return;
    }
    
    NSArray *dataArray = [self getSandboxNoticeDataWithType:type];
    
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithArray:dataArray];
    
    BOOL isHaveTodayRecord = false;
    
    for (NSMutableDictionary *dicInfo in newArray) {
        
        NSString *time = dicInfo[@"time"];
        
        if ([ISNIL(time) isEqualToString:ISNIL([[NSDate date] stringWithFormat:@"yyyy-MM-dd"])]) {
            
            isHaveTodayRecord = true;
            
            NSArray *data = dicInfo[@"data"];
            
            if (data.count == 0) {
                NSArray *dataArray = @[object];
                dicInfo[@"data"] = dataArray;
            } else {
                
                NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:data];
                [dataArray insertObject:object atIndex:0];
                
                dicInfo[@"data"] = [dataArray copy];
                
            }
            
            break;
            
        }
        
    }
    
    if (isHaveTodayRecord == false) {
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        dic[@"time"] = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
        dic[@"data"] = @[object];
        
        [newArray insertObject:dic atIndex:0];
        
    }
//    1.2.0 版本需求
//    // 为了保持不重复历史记录
//
//    NSString *newsId;
//
//    if (type == GHSaveDataType_Sickness) {
//        newsId = [NSString stringWithFormat:@"%ld", [((GHZuJiSicknessModel *) object).modelId longValue]];
//    } else if (type == GHSaveDataType_Doctor) {
//        newsId = [NSString stringWithFormat:@"%ld", [((GHZuJiDoctorModel *) object).modelId longValue]];
//    } else if (type == GHSaveDataType_Hospital) {
//        newsId = [NSString stringWithFormat:@"%ld", [((GHZuJiHospitalModel *) object).modelId longValue]];
//    } else if (type == GHSaveDataType_Information) {
//        newsId = [NSString stringWithFormat:@"%ld", [((GHZuJiInformationModel *) object).modelId longValue]];
//    }
//
//    // 出现次数
//    NSUInteger count = 0;
//
//    // 数组下标
//    NSUInteger dataIndex = 0;
//
//    // 对象下标
//    NSUInteger objIndex = 0;
//
//    for (NSMutableDictionary *dicInfo in newArray) {
//
//        NSArray *data = dicInfo[@"data"];
//
//        for (id obj in data) {
//
//            NSString *theId;
//
//            if (type == GHSaveDataType_Sickness) {
//                theId = [NSString stringWithFormat:@"%ld", [((GHZuJiSicknessModel *) obj).modelId longValue]];
//            } else if (type == GHSaveDataType_Doctor) {
//                theId = [NSString stringWithFormat:@"%ld", [((GHZuJiDoctorModel *) obj).modelId longValue]];
//            } else if (type == GHSaveDataType_Hospital) {
//                theId = [NSString stringWithFormat:@"%ld", [((GHZuJiHospitalModel *) obj).modelId longValue]];
//            } else if (type == GHSaveDataType_Information) {
//                theId = [NSString stringWithFormat:@"%ld", [((GHZuJiInformationModel *) obj).modelId longValue]];
//            }
//
//            if ([theId longValue] == [newsId longValue]) {
//                count ++;
//            }
//
//            if (count == 2) {
//
//                objIndex = [data indexOfObject:obj];
//                break;
//
//            }
//
//        }
//
//        if (count == 2) {
//
//            dataIndex = [newArray indexOfObject:dicInfo];
//            break;
//
//        }
//
//    }
//
//    // 出现了第二次, 则删除那条记录
//    if (count == 2) {
//
//        NSMutableDictionary *dicInfo = [newArray objectOrNilAtIndex:dataIndex];
//
//        NSArray *data = dicInfo[@"data"];
//
//        NSMutableArray *newData = [[NSMutableArray alloc] initWithArray:data];
//
//        [newData removeObjectAtIndex:objIndex];
//
//        if (newData.count == 0) {
//            // 则删除该天记录
//            [newArray removeObjectAtIndex:dataIndex];
//        } else {
//            dicInfo[@"data"] = newData;
//        }
//
//    }
    
    NSString *path = [self getSaveDataPathWithType:type];
    
    [NSKeyedArchiver archiveRootObject:[newArray copy] toFile:path];
    
}

- (void)replaceArray:(NSArray *)array withType:(GHSaveDataType)type {
    
    NSString *path = [self getSaveDataPathWithType:type];
    
    [NSKeyedArchiver archiveRootObject:array toFile:path];
    
}

- (NSArray *)getSandboxNoticeDataWithType:(GHSaveDataType)type {
    
    NSString *path = [self getSaveDataPathWithType:type];
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return array;
    
}

- (NSArray *)getSandboxNoticeDataWithCommentDoctorRecord {
    
    NSString *path = [self getSaveDataPathWithFileName:GHSaveDataType_Comment_Record_Doctor];
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return array;
    
}

- (NSArray *)getSandboxNoticeDataWithCommentHospitalRecord {
    
    NSString *path = [self getSaveDataPathWithFileName:GHSaveDataType_Comment_Record_Hospital];
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return array;
    
}

- (NSString *)getSaveDataPathWithType:(GHSaveDataType)type {
    
    NSString *path;
    
    if (type == GHSaveDataType_Sickness) {
        // 系统通知
        path = [self getSaveDataPathWithFileName:GHSaveDataType_Record_Sickness];
        
    } else if (type == GHSaveDataType_Doctor) {
        // 评论通知
        path = [self getSaveDataPathWithFileName:GHSaveDataType_Record_Doctor];
        
    } else if (type == GHSaveDataType_Hospital) {
        // 点赞通知
        path = [self getSaveDataPathWithFileName:GHSaveDataType_Record_Hospital];
        
    } else if (type == GHSaveDataType_Information) {
        // 点赞通知
        path = [self getSaveDataPathWithFileName:GHSaveDataType_Record_Information];
        
    }
    
    return path;
    
}

- (NSString *)getSaveDataPathWithFileName:(NSString *)fileName {
    
    //1.获取文件路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return [docPath stringByAppendingPathComponent:ISNIL(fileName)];
    
}

- (void)userLogoutRemoveAllNotice {
    
    NSString *path = [self getSaveDataPathWithType:GHSaveDataType_Sickness];
    
    [NSKeyedArchiver archiveRootObject:@[] toFile:path];
    
    NSString *path1 = [self getSaveDataPathWithType:GHSaveDataType_Doctor];
    
    [NSKeyedArchiver archiveRootObject:@[] toFile:path1];
    
    NSString *path2 = [self getSaveDataPathWithType:GHSaveDataType_Hospital];
    
    [NSKeyedArchiver archiveRootObject:@[] toFile:path2];
    
    NSString *path3 = [self getSaveDataPathWithType:GHSaveDataType_Information];
    
    [NSKeyedArchiver archiveRootObject:@[] toFile:path3];
    
    
    NSString *path4 = [self getSaveDataPathWithFileName:GHSaveDataType_PostDetailDraftPath];
    
    [NSKeyedArchiver archiveRootObject:@[] toFile:path4];
    
    NSString *path5 = [self getSaveDataPathWithFileName:GHSaveDataType_PostDetailTitlePath];
    
    [NSKeyedArchiver archiveRootObject:@"" toFile:path5];
    
}

- (void)userLogoutRemoveWithType:(GHSaveDataType)type {
    
//    NSMutableArray *arr = [NSMutableArray arrayWithArray:[self getSandboxNoticeDataWithType:type]];
//
//    [arr removeFirstObject];
//
//    NSString *path = [self getSaveDataPathWithType:type];
//
//    [NSKeyedArchiver archiveRootObject:arr toFile:path];
    
    NSString *path = [self getSaveDataPathWithType:type];

    [NSKeyedArchiver archiveRootObject:@[] toFile:path];
    
}

- (void)cleanPostDetailDraft {
    
    NSString *path = [self getSaveDataPathWithFileName:GHSaveDataType_PostDetailDraftPath];
    
    [NSKeyedArchiver archiveRootObject:@[] toFile:path];
    
}

- (void)savePostDetailDraftWithHTMLArray:(NSArray *)array {
    
    NSString *path = [self getSaveDataPathWithFileName:GHSaveDataType_PostDetailDraftPath];
    
    [NSKeyedArchiver archiveRootObject:array toFile:path];
    
}

- (NSArray *)loadPostDetailDraft {
    
    NSString *path = [self getSaveDataPathWithFileName:GHSaveDataType_PostDetailDraftPath];
    
    NSArray *html = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return html;
    
}

- (void)cleanPostDetailTitle {
    
    NSString *path = [self getSaveDataPathWithFileName:GHSaveDataType_PostDetailTitlePath];
    
    [NSKeyedArchiver archiveRootObject:@"" toFile:path];
    
}

- (void)savePostDetailTitleWithTitle:(NSString *)title {
    
    NSString *path = [self getSaveDataPathWithFileName:GHSaveDataType_PostDetailTitlePath];
    
    [NSKeyedArchiver archiveRootObject:title toFile:path];
    
}

- (NSString *)loadPostDetailTitle {
    
    NSString *path = [self getSaveDataPathWithFileName:GHSaveDataType_PostDetailTitlePath];
    
    NSString *html = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return html;
    
}


- (NSString *)getSaveCacheDataPathWithFileName:(NSString *)fileName {
    
    //1.获取文件路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return [docPath stringByAppendingPathComponent:ISNIL(fileName)];
    
}

- (BOOL)getCityCacheTimeIsShouldCleanCache {
    
    NSString *timePath = [self getSaveDataPathWithFileName:GHSaveDataType_SaveCityTime];
    
    // 获取存入的时间
    NSString *time = [NSKeyedUnarchiver unarchiveObjectWithFile:timePath];
    
    if (ISNIL(time).length == 0) {
        return false;
    }
    
    NSDate *cacheDate = [NSDate dateWithString:time format:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *currentDate = [NSDate date];
    
    NSTimeInterval delta = [currentDate timeIntervalSinceDate:cacheDate];
    
    // 如果缓存超过了三天则清理
    if (delta > (60 * 60 * 24 * 3)) {
        return true;
    }
    
    return false;
    
}

- (NSArray *)loadSortCityData {
    
    if ([self getCityCacheTimeIsShouldCleanCache]) {
        [self cleanAllCityData];
    }
    
    NSString *path = [self getSaveCacheDataPathWithFileName:GHSaveDataType_SortCityPath];
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return array;
    
}

- (NSArray *)loadProvinceCityAreaData {
    
    if ([self getCityCacheTimeIsShouldCleanCache]) {
        [self cleanAllCityData];
    }
    
    NSString *path = [self getSaveCacheDataPathWithFileName:GHSaveDataType_ProvinceCityAreaPath];
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return array;
    
}

- (NSArray *)loadCountryData {
    
    if ([self getCityCacheTimeIsShouldCleanCache]) {
        [self cleanAllCityData];
    }
    
    NSString *path = [self getSaveCacheDataPathWithFileName:GHSaveDataType_CountryPath];
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return array;
    
}



- (void)saveSortCityDataWithArray:(NSArray *)array {
    
    NSString *path = [self getSaveCacheDataPathWithFileName:GHSaveDataType_SortCityPath];
 
    [NSKeyedArchiver archiveRootObject:array toFile:path];
    
    NSString *timePath = [self getSaveDataPathWithFileName:GHSaveDataType_SaveCityTime];
    
    [NSKeyedArchiver archiveRootObject:ISNIL([[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm:ss"]) toFile:timePath];
}

- (void)saveProvinceCityAreaDataWithArray:(NSArray *)array {
    
    NSString *path = [self getSaveCacheDataPathWithFileName:GHSaveDataType_ProvinceCityAreaPath];
    
    [NSKeyedArchiver archiveRootObject:array toFile:path];
    
}

- (void)saveCountryDataWithArray:(NSArray *)array {
    
    NSString *path = [self getSaveCacheDataPathWithFileName:GHSaveDataType_CountryPath];
    
    [NSKeyedArchiver archiveRootObject:array toFile:path];
    
}

- (void)cleanAllCityData {
    
    NSString *path1 = [self getSaveCacheDataPathWithFileName:GHSaveDataType_SortCityPath];
    
    [NSKeyedArchiver archiveRootObject:@[] toFile:path1];
    
    NSString *path2 = [self getSaveCacheDataPathWithFileName:GHSaveDataType_ProvinceCityAreaPath];
    
    [NSKeyedArchiver archiveRootObject:@[] toFile:path2];
    
    NSString *path3 = [self getSaveCacheDataPathWithFileName:GHSaveDataType_CountryPath];
    
    [NSKeyedArchiver archiveRootObject:@[] toFile:path3];
    
}


- (NSMutableArray *)readInformationIdArray {
    
    if (!_readInformationIdArray) {
        _readInformationIdArray = [[NSMutableArray alloc] init];
    }
    return _readInformationIdArray;
    
}

- (NSMutableArray *)readCommentIdArray {
    
    if (!_readCommentIdArray) {
        _readCommentIdArray = [[NSMutableArray alloc] init];
    }
    return _readCommentIdArray;
    
}

@end
