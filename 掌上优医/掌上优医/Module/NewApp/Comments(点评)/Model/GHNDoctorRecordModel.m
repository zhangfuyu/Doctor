//
//  GHNDoctorRecordModel.m
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNDoctorRecordModel.h"

static NSString *kGHCommentDoctorModelModelId = @"kGHCommentDoctorModelModelId";
static NSString *kGHCommentDoctorModelDoctorName = @"kGHCommentDoctorModelDoctorName";
static NSString *kGHCommentDoctorModelDoctorGrade = @"kGHCommentDoctorModelDoctorGrade";
static NSString *kGHCommentDoctorModelProfilePhoto = @"kGHCommentDoctorModelProfilePhoto";
static NSString *kGHCommentDoctorModelFirstDepartmentId = @"kGHCommentDoctorModelFirstDepartmentId";
static NSString *kGHCommentDoctorModelFirstDepartmentName = @"kGHCommentDoctorModelFirstDepartmentName";
static NSString *kGHCommentDoctorModelSecondDepartmentId = @"kGHCommentDoctorModelSecondDepartmentId";
static NSString *kGHCommentDoctorModelSecondDepartmentName = @"kGHCommentDoctorModelSecondDepartmentName";
static NSString *kGHCommentDoctorModelHospitalId = @"kGHCommentDoctorModelHospitalId";
static NSString *kGHCommentDoctorModelHospitalName = @"kGHCommentDoctorModelHospitalName";
static NSString *kGHCommentDoctorModelScore = @"kGHCommentDoctorModelScore";
static NSString *kGHCommentDoctorModelMedicineType = @"kGHCommentDoctorModelMedicineType";

@implementation GHNDoctorRecordModel


- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:ISNIL(self.modelId) forKey:kGHCommentDoctorModelModelId];
    [aCoder encodeObject:ISNIL(self.doctorName) forKey:kGHCommentDoctorModelDoctorName];
    [aCoder encodeObject:ISNIL(self.doctorGrade) forKey:kGHCommentDoctorModelDoctorGrade];
    [aCoder encodeObject:ISNIL(self.profilePhoto) forKey:kGHCommentDoctorModelProfilePhoto];
    
    [aCoder encodeObject:ISNIL(self.firstDepartmentId) forKey:kGHCommentDoctorModelFirstDepartmentId];
    [aCoder encodeObject:ISNIL(self.firstDepartmentName) forKey:kGHCommentDoctorModelFirstDepartmentName];
    [aCoder encodeObject:ISNIL(self.secondDepartmentId) forKey:kGHCommentDoctorModelSecondDepartmentId];
    [aCoder encodeObject:ISNIL(self.secondDepartmentName) forKey:kGHCommentDoctorModelSecondDepartmentName];
    
    [aCoder encodeObject:ISNIL(self.hospitalId) forKey:kGHCommentDoctorModelHospitalId];
    [aCoder encodeObject:ISNIL(self.hospitalName) forKey:kGHCommentDoctorModelHospitalName];
    
    [aCoder encodeObject:ISNIL(self.score) forKey:kGHCommentDoctorModelScore];
    [aCoder encodeObject:ISNIL(self.medicineType) forKey:kGHCommentDoctorModelMedicineType];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.modelId = [aDecoder decodeObjectForKey:kGHCommentDoctorModelModelId];
        self.doctorName = [aDecoder decodeObjectForKey:kGHCommentDoctorModelDoctorName];
        self.doctorGrade = [aDecoder decodeObjectForKey:kGHCommentDoctorModelDoctorGrade];
        self.profilePhoto = [aDecoder decodeObjectForKey:kGHCommentDoctorModelProfilePhoto];
        
        self.firstDepartmentId = [aDecoder decodeObjectForKey:kGHCommentDoctorModelFirstDepartmentId];
        self.firstDepartmentName = [aDecoder decodeObjectForKey:kGHCommentDoctorModelFirstDepartmentName];
        self.secondDepartmentId = [aDecoder decodeObjectForKey:kGHCommentDoctorModelSecondDepartmentId];
        self.secondDepartmentName = [aDecoder decodeObjectForKey:kGHCommentDoctorModelSecondDepartmentName];
        
        self.hospitalId = [aDecoder decodeObjectForKey:kGHCommentDoctorModelHospitalId];
        self.hospitalName = [aDecoder decodeObjectForKey:kGHCommentDoctorModelHospitalName];
        
        self.score = [aDecoder decodeObjectForKey:kGHCommentDoctorModelScore];
        self.medicineType = [aDecoder decodeObjectForKey:kGHCommentDoctorModelMedicineType];
        
    }
    return self;
    
}



@end
