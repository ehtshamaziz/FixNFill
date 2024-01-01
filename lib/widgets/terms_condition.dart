import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'navbar.dart';

class Terms extends StatelessWidget {
  final String name;
  Terms({super.key, required this.name});
  final List<Map<String, dynamic>>  sections = [
    {
      'title': 'Terms of Service',
      'content':
      'Welcome to Fix n Fill! These Terms of Service (TOS) govern your use of our services. By accessing or using our services, you agree to abide by these terms and conditions.',
    },
    {
      'title': '1. Acceptance of Terms',
      'content':
      'By using Fix n Fill, you accept and agree to comply with these TOS. If you do not agree with any part of these terms, you must not use our services.',
    },
    {
      'title': '2. Eligibility',
      'content':
      'You must be at least 18 years old and have the legal capacity to enter into this agreement to use our services. By using our services, you represent and warrant that you meet these eligibility requirements.',
    },
    {
      'title': '3. User Account',
      'content':
      'To access certain features of our platform, you may be required to create an account. You are responsible for maintaining the confidentiality of your account information and are fully responsible for all activities that occur under your account.',
    },
    {
      'title': '4. Service Usage',
      'content': 'When using Fix n Fill services, you agree to:',
      'items': [
        'Use our services in compliance with all applicable laws and regulations.',
        'Refrain from engaging in any unlawful or unauthorized activity on our platform.',
        'Respect the privacy and rights of other users.',
        'Not create multiple accounts or engage in fraudulent activities.',
      ],
    },
    {
      'title': '5. Payments and Fees',
      'content':
      'Payments for services may be required. You agree to pay all fees and charges associated with services you book or provide through our platform. Payment terms and methods will be clearly defined during the booking process.',
    },
    {
      'title': '6. Intellectual Property',
      'content':
      'All content on Fix n Fill, including but not limited to text, graphics, logos, and images, is protected by intellectual property rights. You may not use our content without our permission.',
    },
    {
      'title': '7. Termination of Service',
      'content':
      'Fix n Fill reserves the right to terminate or suspend your access to our services at any time for violations of these TOS or for any other reason.',
    },
    {
      'title': '8. Changes to Terms',
      'content':
      'We may update these TOS from time to time. You will be notified of any changes, and your continued use of our services constitutes your acceptance of the updated terms.',
    },
    {
      'title': '9. Disclaimer',
      'content':
      'Our platform is provided "as is," and we make no warranties regarding the services we provide. We do not guarantee the accuracy, completeness, or reliability of the information or services.',
    },
    {
      'title': '10. Contact Us',
      'content':
      'If you have any questions or concerns about these Terms of Service, please contact us at fixnfill@gmail.com.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Terms"),
        ),
        backgroundColor: Colors.white,

        // drawer: NavBar(name:name),
        body:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0.w),
            margin:EdgeInsets.all(10.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sections.map<Widget>((section) {
                return Padding(
                  padding:  EdgeInsets.only(bottom: 16.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (section['title'] != null)
                        Text(
                          section['title'],
                          style: TextStyle(
                            fontSize: 24.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      SizedBox(height: 8.0.h),
                      Text(
                        section['content'],
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                      if (section['items'] != null)
                        Padding(
                          padding:  EdgeInsets.only(top: 8.0.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Details:',
                                style: TextStyle(
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: (section['items'] as List<String>)
                                    .map<Widget>((item) {
                                  return Padding(
                                    padding:  EdgeInsets.only(left: 16.0.w),
                                    child: Text(
                                      '- $item',
                                      style: TextStyle(
                                        fontSize: 14.0.sp,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }
}