//
//  GHAPI.h
//  掌上优医
//
//  Created by GH on 2018/11/7.
//  Copyright © 2018 GH. All rights reserved.
//

#ifndef GHAPI_h
#define GHAPI_h

/**
 POST       发送验证码
 */
//static NSString *kApiSmsCode = @"/v1/sms/code";

/**
 POST       手机登录
 */
//static NSString *kApiSessionPhone = @"/v1/session/phone";

/**
 POST       用户名密码登录POST
 */
static NSString *kApiSessionUsername = @"/v1/session/username";

///**
// POST       微信登录
// */
//static NSString *kApiSessionWeChat = @"/v1/session/wechat";

/**
 GET /v1/user/me 获取我的详情
 PUT /v1/user/me 修改个人信息
 */
static NSString *kApiUserMe = @"/v1/user/me";

/**
 GET /v1/file/pic 申请图片存储空间
 */
static NSString *kApiFilePicName = @"/v1/file/pic/name";

/**
 GET /v1/file/video/name 申请视频文件名
 */
static NSString *kApiFileVideoName = @"/v1/file/video/name";


/**
 POST /v1/push/dev 上报设备ID
 */
static NSString *kApiPushDev = @"/v1/push/dev";

/**
 DELETE /v1/push/dev/user 解绑设备绑定的用户
 POST /v1/push/dev/user 绑定用户到设备
 */
static NSString *kApiPushDevUser = @"/v1/push/dev/user";

/**
 POST /v1/push/notify/all 发送系统通知到所有设备
 */
static NSString *kApiPushNotifyAll = @"/v1/push/notify/all";

///**
// DELETE /v1/my/favorite 刪除收藏
// */
//static NSString *kApiMyFavorite = @"/v1/my/favorite";

/**
 GET /v1/my/favorite 获取收藏
 */
static NSString *kApiMyFavorites = @"/v1/my/favorites";

/**
 GET /v1/my/favorite/doctors
 */
//static NSString *kApiMyFavoriteDoctors = @"/v1/my/favorite/doctors";



/**
 POST /v1/my/favorite/circle 收藏圈子
 DELETE /v1/my/favorite/circle 刪除收藏圈子
 */
static NSString *kApiMyFavoriteCircle = @"/v1/my/favorite/circle";

/**
 POST /v1/my/favorite/doctor 收藏医生
 DELETE /v1/my/favorite/doctor 刪除收藏医生
 */
static NSString *kApiMyFavoriteDoctor = @"/v1/my/favorite/doctor";

/**
 DELETE /v1/doctor/doctor 删除医生
 GET /v1/doctor/doctor 获取医生信息
 POST /v1/doctor/doctor 新增医生
 PUT /v1/doctor/doctor 修改医生
 */
static NSString *kApiDoctorDoctor = @"/v1/doctor";

/**
 GET /v1/doctor/doctors 获取医生信息列表
 */
static NSString *kApiDoctorDoctors = @"/v1/doctors";



/**
 POST  提交医生信息反馈
 */
static NSString *kApiDoctorcheckDoctorinfofeedback = @"/v1/doctorcheck/doctorinfofeedback";

/**
 POST /v1/doctorcheck/likecheck 提交点赞
 */
static NSString *kApiDoctorcheckLikecheck = @"/v1/doctorcheck/likecheck";

/**
 POST /v1/doctorcheck/recommondoctor 提交医生推荐
 */
static NSString *kApiDoctorcheckRecommondoctor = @"/v1/doctorcheck/recommondoctor";


/**
 GET /v1/doctorcheck/recommondoctors 获取推荐的医生信息
 */
static NSString *kApiDoctorcheckRecommondoctors = @"/v1/doctorcheck/recommondoctors";


/**
 GET /v1/info/slideshows 获取轮播图
 */
//static NSString *kApiInfoSlideshows = @"/v1/info/slideshows";


/**
 GET /v1/search/colligation 综合搜索
 */
static NSString *kApiSearchColligation = @"/v1/search/colligation";

/**
 GET /v1/search/disease 搜索疾病
 */
static NSString *kApiSearchDisease = @"/v1/search/disease";

///**
// GET /v1/search/doctor 搜索医生
// */
//static NSString *kApiSearchDoctor = @"/v1/search/doctor";

/**
 GET
 /v1/hospital/firstdepartment/doctors
 获取医院一级科室医生
 */
static NSString *kApiHospitalFirstDepartmentDoctors = @"/v1/hospital/firstdepartment/doctors";

/**
 GET
 /v1/hospital/seconddepartment/doctors
 获取医院二级科室医生
 */
static NSString *kApiHospitalSecondDepartmentDoctors = @"/v1/hospital/seconddepartment/doctors";

/**
 GET /v1/search/news 搜索资讯
 */
static NSString *kApiSearchNews = @"/v1/search/news";

///**
// GET /v1/systemparam/departments 获取科室可选择项
// */
//static NSString *kApiSystemparamDepartments = @"/v1/systemparam/departments";

/**
 GET /v1/systemparam/departments_doctor_use 获取医生用的科室
 */
//static NSString *kApiSystemparamDepartmentsDoctorUse = @"/v1/systemparam/departments_doctor_use";

/**
 GET
 /v1/systemparam/doctorgrades
 获取医生职称可选择项
 */
static NSString *kApiSystemparamDoctorgrade = @"/v1/systemparam/doctorgrades";


/**
 GET /v1/doctors/publicpraise 获取口碑医生
 */
static NSString *kApiDoctorsPublicpraise = @"/v1/doctors/publicpraise";

/**
 GET /v1/systemparam/areas 获取区域可选择项
 */
//static NSString *kApiSystemparamAreas = @"/v1/systemparam/areas";



/**
 GET /v1/systemparam/areas/level
 */
static NSString *kApiSystemparamAreasLevel = @"/v1/systemparam/areas/level";

/**
 GET /v1/systemparam/ver/status 获取
 */
static NSString *kApiSystemparamVerStatus = @"/v1/systemparam/ver/status";

/**
 GET /v1/info/newstypes 获取全部资讯分类
 */
static NSString *kApiInfoNewstypes = @"/v1/info/newstypes";

/**
 GET /v1/info/newstype/nextlevel 获取下级资讯分类
 */
static NSString *kApiInfoNewstypesNextlevel = @"/v1/info/newstype/nextlevel";

/**
 GET /v1/info/news/first 获取一级分类下的资讯
 */
static NSString *kApiInfoNewsFirst = @"/v1/info/news/first";

static NSString *kApiInfoNews = @"/v1/info/news";

/**
 GET /v1/info/news/second 获取二级分类下的资讯
 */
static NSString *kApiInfoNewsSecond = @"/v1/info/news/second";

/**
 GET /v1/diseases/departmentid 获取某个科室中的疾病
 */
//static NSString *kApiDiseasesDepartmentId = @"/v1/diseases/departmentid";

/**
 GET /v1/search/department/doctor 根据科室找医生
 */
static NSString *kApiSearchDepartmentDoctor = @"/v1/search/department/doctor";

/**
 GET /v1/search/diseasename/doctor 根据疾病名称找医生
 */
static NSString *kApiSearchDiseasenameDoctor = @"/v1/search/diseasename/doctor";



/**
 GET /v1/circle/sticky/post 获取置顶帖子
 */
static NSString *kApiCircleStickyPost = @"/v1/circle/sticky/post";

/**
 GET /v1/circle/sticky/circle/post 获取指定圈子的置顶帖子
 */
static NSString *kApiCircleStickyCirclePost = @"/v1/circle/sticky/circle/post";

/**
 GET /v1/circle/posts 获取帖子列表
 */
static NSString *kApiCirclePosts = @"/v1/circle/posts";

/**
 POST /v1/circle/post/like 点赞帖子
 DELETE /v1/circle/post/like 取消点赞帖子
 */
static NSString *kApiCirclePostLike = @"/v1/circle/post/like";

/**
 POST /v1/circle/post 发帖
 GET /v1/circle/post 获取帖子详情
 */
//static NSString *kApiCirclePost = @"/v1/circle/post";

/**
 GET /v1/circle/my/postlike 获取我的点赞
 */
static NSString *kApiCircleMyPostLike = @"/v1/circle/my/postlike";

/**
 GET /v1/circle/my/post 获取我的帖子
 */
static NSString *kApiCircleMyPost = @"/v1/circle/my/post";

/**
 GET /v1/circle/circleid/posts 获取指定圈子的帖子列表
 */
static NSString *kApiCircleCircleidPosts = @"/v1/circle/circleid/posts";

/**
 GET /v1/circle/best/post 获取热帖
 */
static NSString *kApiCircleBestPost = @"/v1/circle/best/post";

/**
 GET /v1/circle/best/circle/post 获取指定圈子的热帖
 */
static NSString *kApiCircleBestCirclePost = @"/v1/circle/best/circle/post";

/**
 GET /v1/circle/category 获取圈子
 */
static NSString *kApiCircleCategory = @"/v1/circle/category";

/**
 POST /v1/circle/discuss 发表评论
 GET /v1/circle/discuss 获取评论详情
 */
//static NSString *kApiCircleDiscuss = @"/v1/circle/discuss";

/**
 POST /v1/circle/discuss/like 点赞评论
 DELETE /v1/circle/discuss/like 取消点赞评论
 */
static NSString *kApiCircleDiscussLike = @"/v1/circle/discuss/like";

/**
 GET /v1/circle/postid/discuss 获取帖子下所有评论
 */
//static NSString *kApiCirclePostidDiscuss = @"/v1/circle/postid/discuss";

/**
 GET /v1/circle/postid/hot/discuss 获取帖子下所有评论--热度排序
 */
static NSString *kApiCirclePostidHotDiscuss = @"/v1/circle/postid/hot/discuss";

/**
 GET /v1/circle/discussid/reply 获取评论下所有回复
 */
static NSString *kApiCircleDiscussidReply = @"/v1/circle/discussid/reply";

/**
 POST /v1/circle/reply 发表回复
 GET /v1/circle/reply 获取回复详情
 */
//static NSString *kApiCircleReply = @"/v1/circle/reply";

/**
 DELETE /v1/circle/reply/like 取消点赞
 POST /v1/circle/reply/like 点赞回复
 */
static NSString *kApiCircleReplyLike = @"/v1/circle/reply/like";

/**
 GET /v1/mall/mallslides 获取商城轮播图
 */
static NSString *kApiMallMallslides = @"/v1/mall/mallslides";

/**
 GET /v1/mall/goodscategories 获取商品分类
 */
static NSString *kApiMallGoodsCategories = @"/v1/mall/goodscategories";

/**
 GET /v1/mall/category/goodss 获取指定分类下的商品
 */
static NSString *kApiMallCategoryGoodss = @"/v1/mall/category/goodss";

/**
 GET /v1/mall/goods 获取商品详情
 */
static NSString *kApiMallGoods = @"/v1/mall/goods";

/**
 GET /v1/search/post 搜索帖子
 */
static NSString *kApiSearchPost = @"/v1/search/post";

/**
 GET /v1/push/notifies 获取通知历史
 */
//static NSString *kApiPushNotifies = @"/v1/push/notifies";


/**
 POST
 /v1/doctor/comment
 评价医生
 
 PUT
 /v1/doctor/comment
 重新评价医生
 
 DELETE
 /v1/doctor/comment
 删除对医生的评价
 */
//static NSString *kApiDoctorComment = @"/v1/doctor/comment";

/**
 POST
 /v1/hospital/comment
 评价 医院
 
 PUT
 /v1/hospital/comment
 重新评价医院
 
 DELETE
 /v1/hospital/comment
 删除对医生的医院
 */
static NSString *kApiHospitalComment = @"/v1/hospital/comment";

/**
 GET
 /v1/doctor/comments
 获取医生评价
 */
//static NSString *kApiDoctorComments = @"/v1/doctor/comments";

/**
 GET
 /v1/hospital/comments
 获取医生评价
 */
static NSString *kApiHospitalComments = @"/v1/hospital/comments";

///**
// GET
// /v1/doctor/my/comment
// 获取我对医生的评价
// 
// DELETE
// /v1/doctor/my/comment
// 删除我对医生的评价
// */
//static NSString *kApiDoctorMyComments = @"/v1/doctor/my/comment";

/**
 GET
 /v1/doctor/negative/comments
 获取医生评价-差评
 */
static NSString *kApiDoctorNegativeComments = @"/v1/doctor/negative/comments";

/**
 GET
 /v1/doctor/positive/comments
 获取医生评价-好评
 */
static NSString *kApiDoctorPositiveComments = @"/v1/doctor/positive/comments";


/**
 GET
 /v1/user/phone
 获取手机号
 
 PUT
 /v1/user/phone
 绑定手机号
 */
static NSString *kApiUserPhone = @"/v1/user/phone";

/**
 GET
 /v1/user/logincount
 获取登录次数
 */
static NSString *kApiUserLogincount = @"/v1/user/logincount";

/**
 GET
 /v1/user/invitationcode
 获取邀请码
 
 POST
 /v1/user/invitationcode
 兑换邀请码
 */
static NSString *kApiUserInvitationcode = @"/v1/user/invitationcode";

/**
 GET
 /v1/finance/userproperty
 获取我的财产
 */
static NSString *kApiFinanceUserproperty = @"/v1/finance/userproperty";

/**
 GET
 /v1/finance/userproperty/virtualcoinbills
 获取我的虚拟币明细
 */
static NSString *kApiFinanceUserpropertyVirtual = @"/v1/finance/userproperty/virtualcoinbills";

/**
 /v1/user/inviter
 获取我的推荐人
 */
static NSString *kApiUserInviter = @"/v1/user/inviter";


/**
// /v1/user/nickname PUT 修改昵称
// */
//static NSString *kApiUserNickname = @"/v1/user/nickname";

/**
// /v1/user/profilephoto PUT 修改头像
// */
//static NSString *kApiUserProfilephoto = @"/v1/user/profilephoto";

/**
 /v1/user/birthday PUT 修改出生日期
 */
static NSString *kApiUserBirthday = @"/v1/user/birthday";

/**
 /v1/user/sex PUT 修改性别
 */
static NSString *kApiUserSex = @"/v1/user/sex";

/**
 /v1/user/stature PUT 修改身高
 */
static NSString *kApiUserStature = @"/v1/user/stature";

/**
 /v1/user/avoirdupois PUT 修改体重
 */
static NSString *kApiUserAvoirdupois = @"/v1/user/avoirdupois";

/**
 /doctor/my/comments GET 获取我的医生评价
 */
static NSString *kApiDoctorMyComments = @"/v1/doctor/my/comments";

/**
 /hospital/my/comments GET 获取我的医院评价
 */
//static NSString *kApiHospitalMyComments = @"/v1/hospital/my/comments";

/**
 /doctor/sampleinfo/ids  GET 根据医生ID获取医生简易信息
 */
static NSString *kApiDoctorSampleinfoIds = @"/v1/doctor/sampleinfo/ids";

/**
 /hospital/sampleinfo/ids  GET 根据医生ID获取医生简易信息
 */
static NSString *kApiHospitalSampleinfoIds = @"/v1/hospital/sampleinfo/ids";

/**
 /v1/systemparam/choicedepartments  GET   获取全部特色科室
 */
static NSString *kApiSystemparamChoicedpartments = @"/v1/systemparam/choicedepartments";

/**
 /v1/systemparam/hospitalcategories GET  获取全部医院类型
 */
static NSString *kApiSystemparamHospitalcategories = @"/v1/systemparam/hospitalcategories";

/**
 GET
 /v1/systemparam/hospitalgrades
 获取医院等级可选择项
 */
static NSString *kApiSystemparamHospitalgrades = @"/v1/systemparam/hospitalgrades";

/**
 /v1/my/favorite/news      POST     收藏资讯
 DELETE   取消收藏资讯
 */
static NSString *kApiMyFavoriteNews = @"/v1/my/favorite/news";

/**
 /v1/my/favorite/newses GET 获取收藏的资讯 
 */
//static NSString *kApiMyFavoriteNewses = @"/v1/my/favorite/newses";

/**
 /v1/search/hospital  GET 搜索医院
 */
//static NSString *kApiSearchHospital = @"/v1/search/hospital";

/**
 /v1/my/favorite/hospital      POST     收藏医院
 DELETE   取消收藏医院
 */
//static NSString *kApiMyFavoriteHospital = @"/v1/my/favorite/hospital";

/**
 /v1/my/favorite/hospitals GET 获取收藏的医院
 */
static NSString *kApiMyFavoriteHospitals = @"/v1/my/favorite/hospitals";

/**
 GET
 /v1/hospital
 获取医院详情
 */
//static NSString *kApiHospital = @"/v1/hospital";

/**
 POST
 /v1/my/suggestionfeedback
 新增意见反馈
 */
//static NSString *kApiMySuggestionfeedback = @"/v1/my/suggestionfeedback";

/**
 GET
 /v1/doctor/comments/choice
 获取精选评价
 */
static NSString *kApiDoctorCommentsChoice = @"/v1/doctor/comments/choice";

/**
 GET
 /v1/comments/choice
 获取精选评价
 */
static NSString *kApiCommentsChoice = @"/v1/comments/choice";


/**
 /v1/businesstask/contentsharedtask POST 做内容分享任务
 */
static NSString *kApiBusinesstaskContentsharedtask = @"/v1/businesstask/contentsharedtask";

/**
 /v1/businesstask/allowstatus GET 查询是否可以做任务
 */
static NSString *kApiBusinesstaskAllowstatus = @"/v1/businesstask/allowstatus";

static NSString *kApiDisease = @"/v1/disease";

/**
 GET
 /v1/search/disease/suggest
 搜索词补全-疾病
 */
static NSString *kApiSearchDiseaseSuggest = @"/v1/search/disease/suggest";

/**
 GET
 /v1/search/hospital/suggest
 搜索词补全-疾病
 */
static NSString *kApiSearchHospitalSuggest = @"/v1/search/hospital/suggest";

/**
 GET
 /v1/hotsearchwrd
 获取热搜词
 */
static NSString *kApiHotSearchwrd = @"/v1/config/hotsearchwrd";

/**
 GET
 /v1/commondisease
 常见疾病
 */
//static NSString *kApiCommondisease = @"/v1/config/commondisease";

/**
 GET
 /v1/comment/id
 获取评价详情
 */
static NSString *kApiCommentId = @"/v1/comment/id";

/**
 
 POST
 /v1/like/comment
 点赞-评价
 
 DELETE
 /v1/like/comment
 取消点赞-评价
 */
static NSString *kApiLikeComment = @"/v1/like/comment";

/**
 GET
 /v1/like/my
 获取我的点赞
 */
static NSString *kApiLikeMy = @"/v1/like/my";

/**
 
 GET
 /v1/hospital/departments
 获取医院所有科室
 
 */
static NSString *kApiHospitalDepartments = @"/v1/hospital/departments";


/**
 
 POST
 /v1/datacollection/doctor
 提交收集的医生数据
 
 */
static NSString *kApiDataCollectionDoctor = @"/v1/datacollection/doctor";

/**
 
 GET
 /v1/datacollection/my/doctors
 获取我收集的医生数据
 
 */
static NSString *kApiDataCollectionMyDoctors = @"/v1/datacollection/my/doctors";


/**
 
 GET
 /v1/datacollection/my/hospitals
 获取我收集的医院数据
 
 */
static NSString *kApiDataCollectionMyHospitals = @"/v1/datacollection/my/hospitals";

/**
 
 POST
 /v1/datacollection/hospital
 提交收集的医院数据
 
 */
static NSString *kApiDataCollectionHospital = @"/v1/datacollection/hospital";


/**
 
 GET
 /v1/location/geocode
 根据地址返回经纬度
 
 */
static NSString *kApiLocationGeocode = @"/v1/location/geocode";


/**
 
 GET
 /v1/circle/doctor/posts
 获取指定医生的帖子(问答)列表
 
 */
//static NSString *kApiCircleDoctorPosts = @"/v1/circle/doctor/posts";

#endif /* GHAPI_h */
