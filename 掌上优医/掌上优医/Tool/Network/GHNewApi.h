//
//  GHNewApi.h
//  掌上优医
//
//  Created by apple on 2019/8/21.
//  Copyright © 2019年 GH. All rights reserved.
//

#ifndef GHNewApi_h
#define GHNewApi_h


/**
 POST       发送验证码
 */
static NSString *kApiSmsCode = @"gatewayAction/sendVerificationCode";

/**
 POST       手机登录 验证码
 */
static NSString *kApiSessionPhone = @"gatewayAction/authByPhone";

/**
 POST       微信登录
 */
static NSString *kApiSessionWeChat = @"gatewayAction/authByWxOpenId";


/**
 POST       发送验证码
 */
static NSString *kApiLogout = @"gatewayAction/logout";


/**
 GET /v1/user/me 获取我的详情
 */
static NSString *kApiGetUserMe = @"dzxy-user/user/getAppLoginUser";

/**
 dzxy-user/user/UpdateAppLoginUser  修改个人资料
 */
static NSString *kApiUserNickname = @"dzxy-user/user/UpdateAppLoginUser";

/**
 /v1/user/profilephoto 上传图片
 */
static NSString *kApiProfilePicture = @"pangu-system/file/uploadPic";


/**
 GET       搜索疾病,医院,医生
 */
static NSString *kApiNewAppSearch = @"dzxy-core-search/appSearch/allSearch";

/**
 GET /v1/search/doctor 搜索医生
 */
static NSString *kApiSearchDoctor = @"dzxy-core-search/appSearch/allSearchDoctor";

/**
 GET /v1/search/doctor 搜索医生(只根据医生姓名)
 */
static NSString *kApiSearchDoctorByName = @"dzxy-core-search/appSearch/searchDoctorByName";

/**
 GET 查询医院下的科室下的医生
 */
static NSString *kApiFindDepartmentDoctor = @"dzxy-core-search/appDoctor/findDepartmentDoctor";

/**
 GET dzxy-core-search/appSearch/allSearchArticle 资讯
 */
static NSString *kApiAllSearchArticle = @"dzxy-core-search/appSearch/allSearchArticle";

/**
 GET 医生详情
 */
static NSString *kApiDetailDocotr = @"dzxy-core-search/appDoctor/doctorDetail";


/**
 /v1/search/hospital  GET 搜索医院
 */
static NSString *kApiSearchHospital = @"dzxy-core-search/appSearch/allSearchHospital";

/**
 /v1/search/hospital  GET 推荐医院
 */
static NSString *kApiGetTopHospital = @"dzxy-core-search/appHospital/getTopHospital";

/**
 /v1/search/hospital  GET 推荐医生
 */
static NSString *kApiGetTopDoctor = @"dzxy-core-search/appDoctor/getTopDoctor";

/**
 POST
dzxy-core-search/appComment/addCommentt
 评价医生
 */
static NSString *kApiDoctorComment = @"dzxy-core-search/appComment/addComment";



/**
 GET /v1/search/doctor 搜索  联想词
 */
static NSString *kApiSearchthinkDisease = @"dzxy-core-search/appSearch/thinkDisease";

/**
 GET /v1/systemparam/departments 获取科室可选择项
 */
static NSString *kApiSystemparamDepartments = @"dzxy-core-search/appDepartment/allDepartments";

/**
 GET
 获取医院详情
 */
static NSString *kApiHospital = @"dzxy-core-search/appHospital/hospitalDetail";


/**
 GET /v1/info/slideshows 获取轮播图
 */
static NSString *kApiInfoSlideshows = @"dzxy-operation/appPoster/posters";


/**
 GET allDisease 查疾病
 */
static NSString *kApiAllDisease = @"dzxy-core-search/appDisease/allDisease";

/**
 
 GET
 dzxy-core-search/appComment/allComment
 获取评论
 
 */
static NSString *kApiDoctorComments = @"dzxy-core-search/appComment/allComment";


/**
 /hospital/my/comments post 获取我的评价
 */
static NSString *kApiMyComments = @"dzxy-user-core/appComment/getComment";

/**
 GET
 /v1/commondisease
 常见疾病
 */
static NSString *kApiCommondisease = @"dzxy-core-search/appDisease/findCommonDisease";

/**
 GET /v1/diseases/departmentid 获取某个科室中的疾病
 */
static NSString *kApiDiseasesDepartmentId = @"dzxy-core-search/appDisease/findDiseaseByDepartment";

/**
 GET /v1/systemparam/areas 获取区域可选择项
 */
static NSString *kApiSystemparamAreas = @"dzxy-core-search/appCommon/areas";


/**
 POST /appFootprint/getFootprint 足迹列表
 */
static NSString *kApiGetFootprint = @"dzxy-user-core/appFootprint/getFootprint";

/**
 POSTd  zxy-user-core/appFootprint/emptyFootprint  清空足迹列表
 */
static NSString *kApiEmptyFootprint = @"dzxy-user-core/appFootprint/emptyFootprint";

/**
 POST /appFootprint/getFootprint 添加足迹
 */
static NSString *kApiAddFootprint = @"dzxy-user-core/appFootprint/addFootprint";

/**
 post dzxy-user-core/appConllection/doConllection 收藏
 */
static NSString *kApiDoConllection = @"dzxy-user-core/appConllection/doConllection";

/**
 post 收藏列表
 */
static NSString *kApiGetConllection = @"dzxy-user-core/appConllection/getConllection";

/**
 post   取消收藏
 */
static NSString *kApiMyDonotConllection = @"dzxy-user-core/appConllection/donotConllection";

/**
 post   查看收藏状态
 */
static NSString *kApiIsConllection = @"dzxy-user-core/appConllection/isConllection";


/**
 post   信息报错
 */
static NSString *kApiCreateDoctorInfoError = @"dzxy-operation/doctorInfoErrorApp/createDoctorInfoError";

/**
 post   判断用户能否提交医生信息报错信息/添加医生
 */
static NSString *kApiJudgeDoctorInfoError = @"dzxy-operation/doctorInfoErrorApp/judgeDoctorInfoError";

/**
 post   医生信息报错信息核实详情
 */
static NSString *kApiDoctorInfoErrorDetil = @"dzxy-operation/doctorInfoErrorApp/doctorInfoErrorDetil";

/**
 post   判断用户能否提交医院信息报错信息
 */
static NSString *kApiJudgeHospitalInfoError = @"dzxy-operation/hospitalInfoErrorApp/judgeHospitalInfoError";



/**
 post   -添加医院/信息报错/信息补全
 */
static NSString *kApiCreateHospitalInfoError = @"dzxy-operation/hospitalInfoErrorApp/createHospitalInfoError";

/**
 post   -医院信息报错信息核实详情
 */
static NSString *kApiHospitalInfoErrorDetil = @"dzxy-operation/hospitalInfoErrorApp/hospitalInfoErrorDetil";


/**
 POST
 /v1/my/suggestionfeedback
 新增意见反馈
 */
static NSString *kApiMySuggestionfeedback = @"dzxy-user-core/appFeedback/addFeedback";

/**
 POST
 pangu-system/appVerstatus/compareVerstatus
 对比版本号
 */
static NSString *kApiCompareVerstatus = @"pangu-system/appVerstatus/compareVerstatus";

/**
 POST
 dzxy-user-core/appEquipmentCode/addEquipmentCode
 添加设备号
 */
static NSString *kApiAddEquipmentCode = @"dzxy-user-core/appEquipmentCode/addEquipmentCode";

/**
 POST
 推送消息列表
 */
static NSString *kApiGetPushComment = @"dzxy-user-core/appPushComment/getPushComment";



/**
 POST dzxy-comment/appProblem/putQuestions 发帖
 */
static NSString *kApiCirclePost = @"dzxy-comment/appProblem/putQuestions";


/**
 POST 问题列表接口
 */
static NSString *kApiCircleDoctorPosts = @"dzxy-comment/appProblem/getProblems";

/**
 POST dzxy-comment/appProblem/findProblem 获取帖子下所有评论
 */
static NSString *kApiCirclePostidDiscuss = @"dzxy-comment/appProblem/findProblem";


/**
 POST dzxy-comment/appReply/doReply 回复接口

 */
static NSString *kApiCircleReply = @"dzxy-comment/appReply/doReply";

/**
 POST dzxy-comment/appAnswer/doAnswer 回答接口

 */
static NSString *kApiCircleDiscuss = @"dzxy-comment/appAnswer/doAnswer";



/**
 /v1/my/favorite/newses GET 查询资讯详情
 */
static NSString *kApiMyFavoriteNewses = @"dzxy-core-search/appArticle/findArticleById";

#endif /* GHNewApi_h */
