import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';

class TermsAndPrivacy extends StatelessWidget {
  const TermsAndPrivacy({super.key});
  final String termsText = '''
These Terms &amp; Conditions (“Terms”) governs the use of (a) our Application/website “Info
91” or any products or services in connection with the Application/Website/App
(Hereinafter collectively referred to as “Website/App/App”).
These Terms constitute an electronic record in accordance with the provisions of the
Information Technology Act, 2000 and the Information Technology (Intermediaries
guidelines) Rules, 2021 thereunder, as amended from time to time.
Your use/access/browsing of the Website/App or its services or products or registration
through any means shall signify your acceptance of the Terms and Your agreement to be
legally bound by the same.
If you do not agree with the Terms or the Privacy Policy, please do not use the
Website/App or avail the services or products. Any access to our services/products through
registrations/subscription is non-transferable.

1.   Except as mentioned below, all information, content, material, trademarks, services
marks, trade names, and trade secrets including but not limited to the software, text,
images, graphics, video, script and audio, contained in the Website/App, services
and products are proprietary property of Info 91 (“Proprietary Information”). No
Proprietary Information may be copied, downloaded, reproduced, modified,
republished, uploaded, posted, transmitted or distributed in any way without
obtaining prior written permission from Info 91 nothing on this Website/App shall
be or products deemed to confer a license of or any other right, interest or title to or
in any of the intellectual property rights belonging to Info 91, to the User. You may
own the medium on which the information, content or materials resides, but Info 91
shall at all times retain full and complete title to the information, content or
materials and all intellectual property rights inserted by Info 91 on such medium.
Certain contents on the Website/App may belong to third parties. Such contents
have been reproduced after taking prior consent from said party and all rights
relating to such content will remain with such third party. Further, you recognize
and acknowledge that the ownership of all trademarks, copyright, logos, service
marks and other intellectual property owned by any third party shall continue to
vest with such party and You are not permitted to use the same without the consent
of the respective third party.

2.   Your use of our products, Website/App and services is solely for Your personal and
non-commercial use. Any use of the Website/App and its services or products or
their contents other than for personal purposes is prohibited. Your personal and
non-commercial use of this Website/App, products and/or our services shall be
subjected to the following restrictions:

3.   You may not decompile, reverse engineer, or disassemble the contents of our
Website/App and/or services/ products or modify, copy, distribute, transmit,
display, perform, reproduce, publish, license, create derivative works from, transfer,
or sell any information or software obtained from our Website/App and/or
services/products, or remove any copyright, trademark registration, or other
proprietary notices from the contents of the Website/App and/or services/products.

4.   You will not (a) use our Website/App and/or any of our product/s or service/s for
commercial purposes of any kind, or (b) advertise or sell the Website/App or any
products, services or domain names or otherwise (whether or not for profit), or
solicit others (including, without limitation, solicitations for contributions or
donations) or use any public forum for commercial purposes of any kind, or (c) use
the Website/App/our products and services in any way that is unlawful, or harms
Info 91 or any other person or entity.

5.   No User shall be permitted to perform any of the following prohibited activities
while availing of our Services:

a.  Making available any content that is misleading, unlawful, harmful,
threatening, abusive, tortious, defamatory, libelous, vulgar, obscene, child-
pornographic, lewd, lascivious, profane, invasive of another&#39;s privacy,
hateful, or racially, ethnically or otherwise objectionable;
b.  Transmitting material that encourages anyone to commit a criminal offence,
that results in civil liability or otherwise breaches any relevant laws,
regulations or code of practice;
c.  Interfering with any other person&#39;s use or enjoyment of the Website/App and
its services;
d.  Making, transmitting or storing electronic copies of materials protected by
copyright without the permission of the owner, committing any act that
amounts to the infringement of intellectual property or making available any
material that infringes any intellectual property rights or other proprietary
rights of anyone else;
e.  Make available any content or material that You do not have a right to make
available under any law or contractual or fiduciary relationship unless You
own or control the rights thereto or have received all necessary consents for
such use of the content;
f.  Impersonate any person or entity, or falsely state or otherwise misrepresent
Your affiliation with a person or entity;
g.  Post, transmit or make available any material that contains viruses, trojan
horses, worms, spyware, time bombs, cancelbots, or other computer
programming routines, code, files or such other programs that may harm the
Website/App;
h.  Access or use the Website/App/services/products in any manner that could
damage, disable, overburden or impair any of the Website/App&#39;s servers or
the networks connected to any of the servers on which the Website/App is
hosted;
i.  Intentionally or unintentionally interfere with or disrupt the services or
violate any applicable laws related to the access to or use of the
Website/App and its services/ products, or violate any requirements,
procedures, policies or regulations of networks connected to the
Website/App and its services/products, or engage in any activity prohibited
by these Terms;
j.  Disrupt or interfere with the security of, or otherwise cause harm to, the
Website/App/services/products, materials, systems resources, or gain
unauthorized access to user accounts, passwords, servers or networks
connected to or accessible through the Website/App/services/products or
any affiliated or linked sites;
k.  Interfere with, or inhibit any user from using and enjoying access to the
Website/App/ services/products, or other affiliated sites, or engage in
disruptive attacks such as denial of service attack on the
Website/App/services/products;
l.  Use deep-links, page-scrape, robot, spider or other automatic devices,
program, algorithm or methodology, or any similar or equivalent manual
process, to increase traffic to the Website/App/services/products, to access,
acquire, copy or monitor any portion of the Website/App/services/products,
or in any way reproduce or circumvent the navigational structure or
presentation of the Website/App, or any content, to obtain or attempt to
obtain any content, documents or information through any means not
specifically made available through the Website/App;
m.  Alter or modify any part of the Website/App;

n.  Use the Website/App for purposes that are not permitted by: (i) these Terms;
and (ii) any applicable law, regulation or generally accepted practices or
guidelines in the relevant jurisdiction; or
o. Violate any of the terms specified under the Terms for the use of the
Website/App/Services/products.

6.   In the preparation of the Website/App and its services/products and contents
therein, every effort has been made to offer the most current, correct, and clearly
expressed information possible. Nevertheless, inadvertent errors may occur. In
particular, but without limiting anything here, Info 91 disclaims any responsibility
for any errors and accuracy of the information that may be contained on the
Website/App. Info 91 also reserves the right and discretion to make any
changes/corrections or withdraw/add content at any time without notice. Neither
Info 91 nor any third parties provide any warranty or guarantee as to the accuracy,
timeliness, performance, completeness or suitability of the information and
materials found or offered on the Website/App and its services/products for any
particular purpose. You acknowledge that such information and materials may
contain inaccuracies or errors and we expressly exclude liability for any such
inaccuracies or errors to the fullest extent permitted by law.


7.   Our Website/App provides Users with access to compiled information and related
sources. Such information is provided on an “As Is basis” and We assume no
liability for the accuracy or completeness or use or non-obsolescence of such
information. We shall not be liable to update or ensure the continuity of such
information contained on the Website/App. We would not be responsible for any
errors, which might appear in such information. From time to time the Website/App
may also include links to other websites. These links are provided for your
convenience to provide further information. They do not signify that we endorse the
website(s). We have no responsibility for the content of the linked website(s). You
may not create a link to the Website/App from another website or document
without the Info 91’s prior written consent.

8.   Access to certain elements of the services including doubt clearance, mentoring
services etc may be subject to separate terms, conditions and fair usage policy. The
Info 91 reserves the right to determine the criteria for the provision of various
elements of services to the different categories of Users based on its policies.
Hence, subscription to the Website/App/products or registrations do not
automatically entitle the User to any elements of Services provided by Info 91 and
the Info 91 shall be entitled to exercise its discretion while providing access to and
determining the continuity of certain elements of Services. We reserve the right to
extend, cancel, discontinue, prematurely withdraw or modify any of our services at
our discretion.

9.   Info 91 and its products and /or Services, including the Website/App and content,
are compatible only with certain devices/tablets/instruments/hardware. The Info 91
shall not be obligated to provide workable products and/or services for any
instruments that are not recognized by the Info 91 or those instruments that may be
purchased from any third party which are not compatible with Info 91’s products
and services. The Info 91 reserves the right to upgrade the table/ type of compatible
devices as required from time to time.
10. Info 91 shall have no responsibility for any loss or damage caused to the tablet or
any other hardware and/or software and/or instrument, including loss of data or
effect on the processing speed, resulting from Your use of our Website/App.


11.   In order to access the services of our Website/App, You shall be required to register
yourself with the Website/App and maintain an account with the Website/App. You
will be required to furnish certain information and details, including Your name,
mobile number, e-mail address payment information (credit/debit card details) if
required, and any other information deemed necessary by the Website/App. With
respect to the provision of information, the following may be noted:-
a. It is Your sole responsibility to ensure that the account information provided
by You is accurate, complete and the latest.
b. You shall be responsible for maintaining the confidentiality of the account
information and for all activities that occur under Your account. You agree
to (a) ensure that You successfully log out from Your account at the end of
each session, and (b) immediately notify Info 91 of any unauthorized use of
Your account. If there is reason to believe that there is likely to be a breach
of security or misuse of Your account, we may request You to change the
password or we may suspend Your account without any liability to Info 91,
for such period as we deem appropriate in the circumstances. We shall not
be liable for any loss or damage arising from Your failure to comply with
this provision.
c.   You acknowledge that Your ability to use Your account is dependent upon
external factors such as internet service providers and internet network
availability and Info 91 cannot guarantee accessibility to the Application at
all times. In addition to the disclaimers outlined in the Terms, the Info 91
shall not be liable to You for any damages arising from Your inability to log
into Your account and access the Website/App at any time.

12.   Persons who are &quot;competent/capable&quot; of contracting within the meaning of the
Indian Contract Act, of 1872 shall be eligible to register for the Website/App and
all Our products or services. Persons who are minors, un-discharged insolvents etc.
are not eligible to register for Our products or Services.

13.   You agree to defend, indemnify and hold harmless the Info 91, its officers,
proprietors, employees and agents, from and against any and all claims, damages,
obligations, losses, liabilities, costs or debt, and expenses (including but not limited
to attorney&#39;s fees) arising from: (i) Your use of and access of the Website/App and
it’s product/services; (ii) Your violation of any term of these Terms or any other
policy of the Info 91; (iii) Your violation of any third party right, including without
limitation, any copyright, property, or privacy right; or (iv) any claim that Your use
of the Website/App and it’s product/services has caused damage to a third party.
This defence and indemnification obligation will survive these Terms. 

14.   In no event shall Info 91, its officers, proprietors, employees, partners or agents be
liable to You or any third party for any special, incidental, indirect, consequential or
punitive damages whatsoever, including those resulting from loss of use, data or
profits or any other claim arising out, of or in connection with, Your use of, or
access to, the Website/App.

15.   In the event of Your breach of these Terms, You agree that the Info 91 will be
irreparably harmed and may not have an adequate remedy in money or damages.
The Info 91 therefore, shall be entitled in such event to obtain an injunction against
such a breach from any court of competent jurisdiction. The Info 91&#39;s right to obtain
such relief shall not limit its right to obtain other remedies.

16.   Any violation by You of the terms of this Clause may result in immediate
suspension or termination of Your Accounts apart from any legal remedy that the
Info 91 can avail. In such instances, Info 91 may also disclose Your Account
Information if required by any Governmental or legal authority. You understand
that the violation of these Terms could also result in civil or criminal liability under
applicable laws.

17.   The Terms shall be governed by and construed in accordance with the laws of
India, without regard to conflict of law principles. Further, the Terms shall be

subject to the exclusive jurisdiction of the competent courts located in Ernakulam
and You hereby accede to and accept the jurisdiction of such courts.
18. Info 91 has the right to change, modify, suspend, or discontinue and/or eliminate
any aspect(s), features or functionality of the Website/App or the services as it
deems fit at any time without notice. Further, Info 91 has the right to amend these
Terms from time to time without prior notice to you. Info 91 makes no
commitment, express or implied, to maintain or continue any aspect of the
Website/App. You agree that the Info 91 shall not be liable to You or any third
party for any modification, suspension or discontinuance of the Application and it’s
services. All prices are subject to change without notice.
19. Any violation by You of the terms of this Clause may result in immediate
suspension or termination of Your Accounts apart from any legal remedy that Info
91 can avail. In such instances, Info 91 may also disclose Your Account
Information if required by any Governmental or legal authority. You understand
that the violation of these Terms could also result in civil or criminal liability under
applicable laws. 

20.   This Website/App and the services are provided on an &quot;as is basis” with all faults
and without any warranty of any kind. Info 91 hereby disclaims all warranties and
conditions with regard to the Website/App and the services, including without
limitation, all implied warranties and conditions of merchantability, fitness for a
particular purpose, title, accuracy, timeliness, performance, completeness,
suitability and non-infringement. Additionally, Info 91 shall not be liable for any
damages arising out of or in connection with the use or performance of this site, the
application or the services. Your use of any information or materials on the
Website/App is entirely at your own risk, for which we shall not be liable. It shall
be your own responsibility to ensure that the services provided by us meet your
specific requirement

21.   The Terms and Conditions and Privacy Policy, as amended from time to time,
constitute the entire agreement between you and Info 91. If any provision of these
Terms of use is considered unlawful, void, or for any reason unenforceable, then
that provision shall be deemed severable from these Terms and Conditions and shall
not affect the validity and enforceability of any remaining provisions.

22.   Any complaints, abuse or concerns with regards to content or breach of these terms shall
be immediately informed to the designated Grievance Officer as mentioned below via
email to ________ [Name of Grievance Officer], email id ______ [email id to receive
grievances]
  ''';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        
        children: [
          CustomAppBar(appBarName: "Terms and Privacy policy"),
          Expanded(child: SingleChildScrollView(child: Padding(
           padding:  EdgeInsets.symmetric(horizontal: marginWidth,vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              greyBoldText("Terms and Privacy policy"),
              SizedBox(height: 20.h,),

              Text(termsText),
            ],
          ),),))
        ],
      ),
    );
  }
}
