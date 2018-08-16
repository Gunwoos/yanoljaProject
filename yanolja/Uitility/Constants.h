//
//  Constants.h
//  yanolja
//
//  Created by seob on 2018. 8. 3..
//  Copyright © 2018년 seob. All rights reserved.
//

#ifndef Constants_h
#define Constants_h
#import <Foundation/Foundation.h>

typedef enum {
    GET,
    POST,
    PATCH,
    PUT,
    DELETE
} HttpMode;

typedef enum {
    FACEBOOK = 1,
    KAKAO,
    EMAIL
} LOGIN_TYPE;

static const int TAB_NONE = 0;
static const int TAB_HOME = 1;
static const int TAB_ARROUND = 2;
static const int TAB_SEARCH = 3;
static const int TAB_FREETALK = 4;
static const int TAB_MORE = 5;
 
// Test Mode
static const BOOL IS_TEST = true;


// 일반거리순 거리값 제한 (단위 m)
static const double g_distance_waxingpanda = 30000.0;

// 광고거리순 거리값 제한 (단위 Km)
static const double g_distance_waxingpanda_ad = 3000.0;

// Alarm
static const int ALARM_ON = 1;
static const int ALARM_OFF = 0;

// Notification
static NSString *const NOTI_PUSH_ALARM = @"noti_push_alarm";
static NSString *const NOTI_TERMS_AGREE = @"noti_term_agree";
static NSString *const NOTI_TERMS_AGREE_ALL = @"noti_term_agree_all";
static NSString *const NOTI_AREA_SEARCH = @"noti_area_search";
static NSString *const NOTI_PHOTO_SELECT = @"noti_photo_select";
static NSString *const NOTI_TALK_SAVE = @"noti_talk_save";
static NSString *const NOTI_TALK_DEL = @"noti_talk_delete";
static NSString *const NOTI_TALK_COMMENT_ADD = @"noti_talk_comment_add";
static NSString *const NOTI_USER_INFO = @"noti_user_info";
static NSString *const NOTI_SETTING_INFO = @"noti_setting_info";
static NSString *const NOTI_SELECT_SHOP = @"noti_select_shop";
static NSString *const NOTI_VIEW_NOTICE = @"noti_view_notice";

// Api Constants
static const int RESULT_OK = 0;
static const int RESULT_DB_ERROR = 1;
static const int RESULT_PARAM_ERROR = 2;
static const int RESULT_NO_INFO_ERROR = 3;
static const int RESULT_FILE_UPLOAD_ERROR = 4;
static const int RESULT_INVALID_PRIVILEGE_ERROR = 5;
static const int RESULT_NO_USER_ERROR = 6;
static const int RESULT_EMAIL_DUP_ERROR = 7;
static const int RESULT_NICKNAME_DUP_ERROR = 8;
static const int RESULT_PHONE_DUP_ERROR = 9;
static const int RESULT_WRONG_PW_ERROR = 10;
static const int RESULT_WRONG_CERT_KEY_ERROR = 11;
static const int RESULT_GENERATE_ID_ERROR = 12;
static const int RESULT_INFO_DUP_ERROR = 13;

static NSString *const MSG_DB_ERROR = @"DB접속에서 오류가 발생하였습니다.";
static NSString *const MSG_PARAM_ERROR = @"파라미터누락 오류입니다.";
static NSString *const MSG_NO_INFO_ERROR = @"요청한 정보가 존재하지 않습니다.";
static NSString *const MSG_FILE_UPLOAD_ERROR = @"파일업로드가 실패하였습니다.";
static NSString *const MSG_INVALID_PRIVILEGE_ERROR = @"권한오류입니다.";
static NSString *const MSG_NO_USER_ERROR = @"등록된 회원이 아닙니다.";
static NSString *const MSG_EMAIL_DUP_ERROR = @"이미 사용중인 이메일입니다.";
static NSString *const MSG_NICKNAME_DUP_ERROR = @"이미 사용중인 닉네임입니다.";
static NSString *const MSG_PHONE_DUP_ERROR = @"이미 사용중인 핸드폰번호입니다.";
static NSString *const MSG_WRONG_PW_ERROR = @"패스워드가 일치하지 않습니다.";
static NSString *const MSG_WRONG_CERT_KEY_ERROR = @"인증번호가 올바르지 않습니다.";
static NSString *const MSG_GENERATE_ID_ERROR = @"인증번호를 더 이상 요청할수 없습니다.";
static NSString *const MSG_INFO_DUP_ERROR = @"이미 존재합니다.";
static NSString *const MSG_NETWORK_ERROR = @"네트워크접속이 실패하였습니다.";


static NSString *const API_URL_HEADER = @"";

static NSString *const RES_RESULT_CODE = @"resultcode";

static NSString *const API_ACT_LOGIN = @"login.php";                // 로그인

#endif /* Constants_h */
