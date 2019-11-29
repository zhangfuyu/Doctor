//
//  GHZuJiDoctorModel.m
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHZuJiDoctorModel.h"

static NSString *kGHZuJiDoctorModelModelId = @"kGHZuJiDoctorModelModelId";
static NSString *kGHZuJiDoctorModelDoctorName = @"kGHZuJiDoctorModelDoctorName";
static NSString *kGHZuJiDoctorModelDoctorGrade = @"kGHZuJiDoctorModelDoctorGrade";
static NSString *kGHZuJiDoctorModelProfilePhoto = @"kGHZuJiDoctorModelProfilePhoto";
static NSString *kGHZuJiDoctorModelFirstDepartmentId = @"kGHZuJiDoctorModelFirstDepartmentId";
static NSString *kGHZuJiDoctorModelFirstDepartmentName = @"kGHZuJiDoctorModelFirstDepartmentName";
static NSString *kGHZuJiDoctorModelSecondDepartmentId = @"kGHZuJiDoctorModelSecondDepartmentId";
static NSString *kGHZuJiDoctorModelSecondDepartmentName = @"kGHZuJiDoctorModelSecondDepartmentName";
static NSString *kGHZuJiDoctorModelHospitalId = @"kGHZuJiDoctorModelHospitalId";
static NSString *kGHZuJiDoctorModelHospitalName = @"kGHZuJiDoctorModelHospitalName";




@implementation GHZuJiDoctorModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:ISNIL(self.modelId) forKey:kGHZuJiDoctorModelModelId];
    [aCoder encodeObject:ISNIL(self.doctorName) forKey:kGHZuJiDoctorModelDoctorName];
    [aCoder encodeObject:ISNIL(self.doctorGrade) forKey:kGHZuJiDoctorModelDoctorGrade];
    [aCoder encodeObject:ISNIL(self.profilePhoto) forKey:kGHZuJiDoctorModelProfilePhoto];
    
    [aCoder encodeObject:ISNIL(self.firstDepartmentId) forKey:kGHZuJiDoctorModelFirstDepartmentId];
    [aCoder encodeObject:ISNIL(self.firstDepartmentName) forKey:kGHZuJiDoctorModelFirstDepartmentName];
    [aCoder encodeObject:ISNIL(self.secondDepartmentId) forKey:kGHZuJiDoctorModelSecondDepartmentId];
    [aCoder encodeObject:ISNIL(self.secondDepartmentName) forKey:kGHZuJiDoctorModelSecondDepartmentName];
    
    [aCoder encodeObject:ISNIL(self.hospitalId) forKey:kGHZuJiDoctorModelHospitalId];
    [aCoder encodeObject:ISNIL(self.hospitalName) forKey:kGHZuJiDoctorModelHospitalName];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.modelId = [aDecoder decodeObjectForKey:kGHZuJiDoctorModelModelId];
        self.doctorName = [aDecoder decodeObjectForKey:kGHZuJiDoctorModelDoctorName];
        self.doctorGrade = [aDecoder decodeObjectForKey:kGHZuJiDoctorModelDoctorGrade];
        self.profilePhoto = [aDecoder decodeObjectForKey:kGHZuJiDoctorModelProfilePhoto];
        
        self.firstDepartmentId = [aDecoder decodeObjectForKey:kGHZuJiDoctorModelFirstDepartmentId];
        self.firstDepartmentName = [aDecoder decodeObjectForKey:kGHZuJiDoctorModelFirstDepartmentName];
        self.secondDepartmentId = [aDecoder decodeObjectForKey:kGHZuJiDoctorModelSecondDepartmentId];
        self.secondDepartmentName = [aDecoder decodeObjectForKey:kGHZuJiDoctorModelSecondDepartmentName];
        
        self.hospitalId = [aDecoder decodeObjectForKey:kGHZuJiDoctorModelHospitalId];
        self.hospitalName = [aDecoder decodeObjectForKey:kGHZuJiDoctorModelHospitalName];
        
    }
    return self;
    
}

@end
