import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});
  final String termsText = '''
Info 91 (“we,” “our,” or “us”) respects the privacy of our users and is committed to protecting
your personal data. This Privacy Policy (“Policy”) outlines how we collect, use, share, and
protect the information provided by users (“you” or “your”) through the use of our website,
application, and related services (collectively referred to as the “Website/App”). By accessing
or using our Website/App, you consent to the collection, use, and disclosure of your personal
data as described in this Policy.The users unconditionally agree that browsing the Website
and/or using its services signifies their unconditional assent to this Privacy Policy. The
Privacy Policy is published in compliance with Section 43A of the Information Technology
Act, 2000 and Regulation 4 of the Information Technology (Reasonable Security Practices
and Procedures and Sensitive Personal Information) Rules, 2011 (the &quot;SPI Rules&quot;)
1. Information We Collect
We may collect different types of information about you when you use our Website/App,
including but not limited to:
1.1. Personal Information:
. Contact Information: Your name, email address, phone number, and other contact
details that you provide when registering or contacting us.
. Account Information: Username, password, and other details when you create an
account.
. Payment Information: If applicable, we may collect billing information such as
credit card numbers or other payment details. When you choose any subscription or
paid service provided as part of our services, our payment gateway provider may
collect your purchase, address or billing information, including your credit card
number, debit card number, UPI Id and card expiration date etc. 
. Profile Information: Information you provide in your profile, such as your
preferences, interests, and feedback.
. Location Data: Information related to your location when you access our services,
either through direct entry or automatically through GPS, Wi-Fi, or IP-based location
detection.
The Personal Information is used for three general purposes: to customize the content you
see, to fulfill your requests for certain services, and to contact you about our services.
1.2. Non-Personal Information:
. Device Information: Information about the device(s) you use to access the
Website/App, including the hardware model, operating system, browser type, IP
address, and unique device identifiers.
. Usage Data: We collect information on how you use the Website/App, including your
browsing activity, viewed pages, accessed services, and interaction with the content.
1.3. Cookies and Tracking Technologies:
. We send cookies (small files containing a string of characters) to your computer,
thereby uniquely identifying your browser. Cookies are used to track your preferences,
  ''';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        
        children: [
          CustomAppBar(appBarName: "Privacy Policy"),
          Expanded(child: SingleChildScrollView(child: Padding(
           padding:  EdgeInsets.symmetric(horizontal: marginWidth,vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              greyBoldText("PRIVACY POLICY"),
              SizedBox(height: 20.h,),

              Text(termsText),
            ],
          ),),))
        ],
      ),
    );
  }
}
