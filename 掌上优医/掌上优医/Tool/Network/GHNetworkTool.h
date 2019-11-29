//
//  GHNetworkTool.h
//  掌上优医
//
//  Created by GH on 2018/10/23.
//  Copyright © 2018 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GHAPI.h"

#import "GHNewApi.h"

#import <AFNetworking.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^completionBlock)(BOOL isSuccess, NSString * _Nullable msg, id _Nullable response);

typedef enum : NSUInteger {
    GHRequestMethod_GET,
    GHRequestMethod_POST,
    GHRequestMethod_PUT,
    GHRequestMethod_DELETE,
} GHRequestMethod;


typedef enum : NSUInteger {
    GHLoadingType_ShowLoading,
    GHLoadingType_HideLoading,
} GHLoadingType;

typedef enum : NSUInteger {
    GHContentType_Formdata,
    GHContentType_JSON,
    GHContentType_UPLODPICTURE,
} GHContentType;

@interface GHNetworkTool : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
/**
 普通网络请求

 @param method 请求方式 GHRequestMethod_GET/GHRequestMethod_POST/GHRequestMethod_PUT/GHRequestMethod_DELETE
 @param url <#url description#>
 @param parameter <#parameter description#>
 @param loadingType 是否需要请求结果 GHLoadingType_ShowLoading/GHLoadingType_HideLoading
 @param shouldHaveToken 是否需要加入 Token
 @param contentType 请求格式 GHContentType_Formdata/GHContentType_JSON
 @param completionBlock <#completionBlock description#>
 */
- (void)requestWithMethod:(GHRequestMethod)method withUrl:(NSString *)url withParameter:(NSDictionary * __nullable)parameter withLoadingType:(GHLoadingType)loadingType withShouldHaveToken:(BOOL)shouldHaveToken withContentType:(GHContentType)contentType  completionBlock:(completionBlock)completionBlock;

/**
 上传图片使用

 @param url <#url description#>
 @param parameter <#parameter description#>
 @param loadingType <#loadingType description#>
 @param shouldHaveToken <#shouldHaveToken description#>
 @param completionBlock <#completionBlock description#>
 */
- (void)requestUploadTokenWithUrl:(NSString *)url withParameter:(NSDictionary * __nullable)parameter withLoadingType:(GHLoadingType)loadingType withShouldHaveToken:(BOOL)shouldHaveToken completionBlock:(completionBlock)completionBlock;

/**
 请求资源地址

 @param url <#url description#>
 @param parameter <#parameter description#>
 @param data <#data description#>
 @param completionBlock <#completionBlock description#>
 */
- (void)requestUploadWithUrl:(NSString *)url withParameter:(NSDictionary * __nullable)parameter withData:(NSData *)data completionBlock:(completionBlock)completionBlock;


- (void)cancelRequest;

+ (void)detectNetworkAction;

/**
 用户协议

 @return <#return value description#>
 */
- (NSString *)getUserProtocolURL;

/**
 隐私政策

 @return <#return value description#>
 */
- (NSString *)getPrivacyPolicyURL;

/**
 咨询详情

 @param articleId <#articleId description#>
 @return <#return value description#>
 */
- (NSString *)getArticleDetailURLWithArticleId:(NSString *)articleId;

/**
 医生介绍

 @param doctorId <#doctorId description#>
 @return <#return value description#>
 */
- (NSString *)getDoctorDetailURLWithDoctorId:(NSString *)doctorId;

/**
 疾病详情

 @param sicknessId <#sicknessId description#>
 @return <#return value description#>
 */
- (NSString *)getSicknessDetailURLWithSicknessId:(NSString *)sicknessId;

/**
 商品详情

 @param productId <#productId description#>
 @return <#return value description#>
 */
- (NSString *)getProductDetailURLWithProductId:(NSString *)productId;

/**
 医院详情

 @param productId <#productId description#>
 @return <#return value description#>
 */
- (NSString *)getHospitalDetailURLWithHospitalId:(NSString *)hospitalId;

/**
分享链接拼接

 @param productId <#productId description#>
 @return <#return value description#>
 */
- (NSString *)getShareWebViewWith:(NSString *)text;

/**
 免责声明

 @return <#return value description#>
 */
- (NSString *)getGdisclaimerURL;


/**
 免责声明
 
 @return <#return value description#>
 */
- (NSString *)getNewsArticlesURLisShareid:(NSString *)idStr share:(BOOL)isShare;


- (NSString *)getRecommendCodeURLWithCode:(NSString *)code;

@end

NS_ASSUME_NONNULL_END
