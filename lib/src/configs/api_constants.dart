class ApiConstants {
  static String sendOtp = '/auth/register';
  static String verifyOtp = '/auth/verify_otp';
  static String reSendOtp = '/auth/resend_otp';
  static String user = '/user_profile';
  static String updateUser = '/update_profile';
  static String refreshToken = '/auth/refresh_token';

  //information Apis
  static String creationInformationAPi = "/groupCreation";
  static String infoGroupListAPi = "/groupList";
  static String infoGroupPublicSearchAPi = "/publicGroupSearch";
  static String firstCategoryListApi = "/firstCategories";
  static String secondCategoryListApi = "/secondCategories/";
  static String thirdCategoryListApi = "/thirdCategories/";
  static String getPlanListApi = "/businessGroupPlanList";
  static String validatingPincodeApi = "/validatePincode";
  static String joinGroupApi = "/joinPublicGroup";
  static String getInfoDatapApi = "/groupInfo";
  static String updateInfoDatapApi = "/groupInfoUpdate";
  static String groupProfileApi = "/groupProfile";
  static String groupProfilePicUpdateApi = "/groupProfilePicUpdate";
  static String groupCovPicUpdateApi = "/groupCoverPicUpdate";
  static String addMessageApi = "/addGroupMessage";
  static String viewMessageApi = "/viewGroupChat";
  static String deleteMessageApi = "/deleteGroupMessage";
  static String fileUploadApi = "/fileUpload";
  static String createBannerApi = "/addGroupBanner";
  static String deleteBannerApi = "/deleteGroupBanner";
  static String updateBannerApi = "/updateGroupBanner";
  static String contactSyncApi = "/contactSync";
  static String addUsersToGroupApi = "/addUsersToGroup";
  static String changeGroupUserStatusApi = "/changeGroupUserStatus";
  static String leaveInfoGroupApi = "/leaveGroup";
  static String groupNameUpdateApi = "/groupNameUpdate";
}
