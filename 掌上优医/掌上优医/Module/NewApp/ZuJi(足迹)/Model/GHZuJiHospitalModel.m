//
//  GHZuJiHospitalModel.m
//  掌上优医
//
//  Created by GH on 2019/2/22.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHZuJiHospitalModel.h"

static NSString *kGHZuJiHospitalModelModelId = @"kGHZuJiHospitalModelModelId";
static NSString *kGHZuJiHospitalModelCategory = @"kGHZuJiHospitalModelCategory";
static NSString *kGHZuJiHospitalModelChoiceDepartments = @"kGHZuJiHospitalModelChoiceDepartments";
static NSString *kGHZuJiHospitalModelContactNumber = @"kGHZuJiHospitalModelContactNumber";

static NSString *kGHZuJiHospitalModelGrade = @"kGHZuJiHospitalModelGrade";
static NSString *kGHZuJiHospitalModelHospitalAddress = @"kGHZuJiHospitalModelHospitalAddress";
static NSString *kGHZuJiHospitalModelHospitalName = @"kGHZuJiHospitalModelHospitalName";
static NSString *kGHZuJiHospitalModelIntroduction = @"kGHZuJiHospitalModelIntroduction";

static NSString *kGHZuJiHospitalModelMedicalInsuranceFlag = @"kGHZuJiHospitalModelMedicalInsuranceFlag";
static NSString *kGHZuJiHospitalModelPictures = @"kGHZuJiHospitalModelPictures";
static NSString *kGHZuJiHospitalModelProfilePhoto = @"kGHZuJiHospitalModelProfilePhoto";


@implementation GHZuJiHospitalModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:ISNIL(self.modelId) forKey:kGHZuJiHospitalModelModelId];
    [aCoder encodeObject:ISNIL(self.category) forKey:kGHZuJiHospitalModelCategory];
    [aCoder encodeObject:ISNIL(self.choiceDepartments) forKey:kGHZuJiHospitalModelChoiceDepartments];
    [aCoder encodeObject:ISNIL(self.contactNumber) forKey:kGHZuJiHospitalModelContactNumber];
    
    [aCoder encodeObject:ISNIL(self.grade) forKey:kGHZuJiHospitalModelGrade];
    [aCoder encodeObject:ISNIL(self.hospitalAddress) forKey:kGHZuJiHospitalModelHospitalAddress];
    [aCoder encodeObject:ISNIL(self.hospitalName) forKey:kGHZuJiHospitalModelHospitalName];
    [aCoder encodeObject:ISNIL(self.introduction) forKey:kGHZuJiHospitalModelIntroduction];
    
    [aCoder encodeObject:ISNIL(self.medicalInsuranceFlag) forKey:kGHZuJiHospitalModelMedicalInsuranceFlag];
    [aCoder encodeObject:ISNIL(self.pictures) forKey:kGHZuJiHospitalModelPictures];
    [aCoder encodeObject:ISNIL(self.profilePhoto) forKey:kGHZuJiHospitalModelProfilePhoto];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.modelId = [aDecoder decodeObjectForKey:kGHZuJiHospitalModelModelId];
        self.category = [aDecoder decodeObjectForKey:kGHZuJiHospitalModelCategory];
        self.choiceDepartments = [aDecoder decodeObjectForKey:kGHZuJiHospitalModelChoiceDepartments];
        self.contactNumber = [aDecoder decodeObjectForKey:kGHZuJiHospitalModelContactNumber];
        
        self.grade = [aDecoder decodeObjectForKey:kGHZuJiHospitalModelGrade];
        self.hospitalAddress = [aDecoder decodeObjectForKey:kGHZuJiHospitalModelHospitalAddress];
        self.hospitalName = [aDecoder decodeObjectForKey:kGHZuJiHospitalModelHospitalName];
        self.introduction = [aDecoder decodeObjectForKey:kGHZuJiHospitalModelIntroduction];
        
        self.medicalInsuranceFlag = [aDecoder decodeObjectForKey:kGHZuJiHospitalModelMedicalInsuranceFlag];
        self.pictures = [aDecoder decodeObjectForKey:kGHZuJiHospitalModelPictures];
        self.profilePhoto = [aDecoder decodeObjectForKey:kGHZuJiHospitalModelProfilePhoto];
        
    }
    return self;
    
}


@end
