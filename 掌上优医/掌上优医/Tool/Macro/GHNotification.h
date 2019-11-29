//
//  GHNotification.h
//  掌上优医
//
//  Created by GH on 2018/11/2.
//  Copyright © 2018 GH. All rights reserved.
//
//  推送通知

#ifndef GHNotification_h
#define GHNotification_h


/**
 微信授权成功

 @return <#return value description#>
 */
#define kNotificationWeChatAuthSuccess @"kNotificationWeChatAuthSuccess"

/**
 微信授权失败
 
 @return <#return value description#>
 */
#define kNotificationWeChatAuthFailed @"kNotificationWeChatAuthFailed"

#define kNotificationWeChatLoginSuccess @"kNotificationWeChatLoginSuccess"

#define kNotificationLoginSuccess @"kNotificationLoginSuccess"

#define kNotificationLoginPasswordSuccess @"kNotificationLoginPasswordSuccess"

#define kNotificationLogout @"kNotificationLogout"

#define kNotificationHomeMoreSelected @"kNotificationHomeMoreSelected"

#define kNotificationWillEnterForeground @"kNotificationWillEnterForeground"

#define kNotificationWillEnterBackground @"kNotificationWillEnterBackground"

#define kNotificationCancelDoctorCollectionSuccess @"kNotificationCancelDoctorCollectionSuccess"

#define kNotificationDoctorCollectionSuccess @"kNotificationDoctorCollectionSuccess"

#define kNotificationVisitInformationShouldReloadHomeStatus @"kNotificationVisitInformationShouldReloadHomeStatus"

#define kNotificationWillShowPostButton @"kNotificationWillShowPostButton"

#define kNotificationWillHidePostButton @"kNotificationWillHidePostButton"

#define kNotificationZoneHomeIsRefresh @"kNotificationZoneHomeIsRefresh"

#define kNotificationZoneTopicIsRefresh @"kNotificationZoneTopicIsRefresh"

#define kNotificationZoneHomeRefreshFinish @"kNotificationZoneHomeRefreshFinish"

#define kNotificationZoneTopicRefreshFinish @"kNotificationZoneTopicRefreshFinish"

#define kNotificationCircleCollectionSuccess @"kNotificationCircleCollectionSuccess"

#define kNotificationCancelCircleCollectionSuccess @"kNotificationCancelCircleCollectionSuccess"

/**
  获取所有的病友圈点赞信息完成

 @return <#return value description#>
 */
#define kNotificationGetCircleAllLikeFinish @"kNotificationGetCircleAllLikeFinish"

#define kNotificationPostDetailLikeStateChange @"kNotificationPostDetailLikeStateChange"

#define kNotificationSendPostSuccess @"kNotificationSendPostSuccess"

#define kNotificationDoctorCommentSuccess @"kNotificationDoctorCommentSuccess"

#define kNotificationDoctorQuestionSuccess @"kNotificationDoctorQuestionSuccess"

#define kNotificationHospitalCommentSuccess @"kNotificationHospitalCommentSuccess"

#define kNotificationDoctorRecordShouldReload @"kNotificationDoctorRecordShouldReload"

#define kNotificationHospitalRecordShouldReload @"kNotificationHospitalRecordShouldReload"

#endif /* GHNotification_h */
