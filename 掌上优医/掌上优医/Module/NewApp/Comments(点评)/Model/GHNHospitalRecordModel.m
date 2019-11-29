//
//  GHNHospitalRecordModel.m
//  掌上优医
//
//  Created by GH on 2019/5/13.
//  Copyright © 2019 GH. All rights reserved.
//

#import "GHNHospitalRecordModel.h"

static NSString *kGHCommentHospitalModelModelId = @"kGHCommentHospitalModelModelId";
static NSString *kGHCommentHospitalModelCategory = @"kGHCommentHospitalModelCategory";
static NSString *kGHCommentHospitalModelChoiceDepartments = @"kGHCommentHospitalModelChoiceDepartments";
static NSString *kGHCommentHospitalModelContactNumber = @"kGHCommentHospitalModelContactNumber";

static NSString *kGHCommentHospitalModelGrade = @"kGHCommentHospitalModelGrade";
static NSString *kGHCommentHospitalModelHospitalAddress = @"kGHCommentHospitalModelHospitalAddress";
static NSString *kGHCommentHospitalModelHospitalName = @"kGHCommentHospitalModelHospitalName";
static NSString *kGHCommentHospitalModelIntroduction = @"kGHCommentHospitalModelIntroduction";

static NSString *kGHCommentHospitalModelMedicalInsuranceFlag = @"kGHCommentHospitalModelMedicalInsuranceFlag";
static NSString *kGHCommentHospitalModelPictures = @"kGHCommentHospitalModelPictures";
static NSString *kGHCommentHospitalModelProfilePhoto = @"kGHCommentHospitalModelProfilePhoto";
static NSString *kGHCommentHospitalModelScore = @"kGHCommentHospitalModelScore";

static NSString *kGHCommentHospitalModelMedicineType = @"kGHCommentHospitalModelMedicineType";
static NSString *kGHCommentHospitalModelGovernmentalHospitalFlag = @"kGHCommentHospitalModelGovernmentalHospitalFlag";

@implementation GHNHospitalRecordModel


- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:ISNIL(self.modelId) forKey:kGHCommentHospitalModelModelId];
    [aCoder encodeObject:ISNIL(self.category) forKey:kGHCommentHospitalModelCategory];
    [aCoder encodeObject:ISNIL(self.choiceDepartments) forKey:kGHCommentHospitalModelChoiceDepartments];
    [aCoder encodeObject:ISNIL(self.contactNumber) forKey:kGHCommentHospitalModelContactNumber];
    
    [aCoder encodeObject:ISNIL(self.grade) forKey:kGHCommentHospitalModelGrade];
    [aCoder encodeObject:ISNIL(self.hospitalAddress) forKey:kGHCommentHospitalModelHospitalAddress];
    [aCoder encodeObject:ISNIL(self.hospitalName) forKey:kGHCommentHospitalModelHospitalName];
    [aCoder encodeObject:ISNIL(self.introduction) forKey:kGHCommentHospitalModelIntroduction];
    
    [aCoder encodeObject:ISNIL(self.medicalInsuranceFlag) forKey:kGHCommentHospitalModelMedicalInsuranceFlag];
    [aCoder encodeObject:ISNIL(self.pictures) forKey:kGHCommentHospitalModelPictures];
    [aCoder encodeObject:ISNIL(self.profilePhoto) forKey:kGHCommentHospitalModelProfilePhoto];
    
    [aCoder encodeObject:ISNIL(self.score) forKey:kGHCommentHospitalModelScore];
    [aCoder encodeObject:ISNIL(self.medicineType) forKey:kGHCommentHospitalModelMedicineType];
    [aCoder encodeObject:ISNIL(self.governmentalHospitalFlag) forKey:kGHCommentHospitalModelGovernmentalHospitalFlag];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.modelId = [aDecoder decodeObjectForKey:kGHCommentHospitalModelModelId];
        self.category = [aDecoder decodeObjectForKey:kGHCommentHospitalModelCategory];
        self.choiceDepartments = [aDecoder decodeObjectForKey:kGHCommentHospitalModelChoiceDepartments];
        self.contactNumber = [aDecoder decodeObjectForKey:kGHCommentHospitalModelContactNumber];
        
        self.grade = [aDecoder decodeObjectForKey:kGHCommentHospitalModelGrade];
        self.hospitalAddress = [aDecoder decodeObjectForKey:kGHCommentHospitalModelHospitalAddress];
        self.hospitalName = [aDecoder decodeObjectForKey:kGHCommentHospitalModelHospitalName];
        self.introduction = [aDecoder decodeObjectForKey:kGHCommentHospitalModelIntroduction];
        
        self.medicalInsuranceFlag = [aDecoder decodeObjectForKey:kGHCommentHospitalModelMedicalInsuranceFlag];
        self.pictures = [aDecoder decodeObjectForKey:kGHCommentHospitalModelPictures];
        self.profilePhoto = [aDecoder decodeObjectForKey:kGHCommentHospitalModelProfilePhoto];
        
        self.score = [aDecoder decodeObjectForKey:kGHCommentHospitalModelScore];
        self.medicineType = [aDecoder decodeObjectForKey:kGHCommentHospitalModelMedicineType];
        self.governmentalHospitalFlag = [aDecoder decodeObjectForKey:kGHCommentHospitalModelGovernmentalHospitalFlag];
        
    }
    return self;
    
}

@end
