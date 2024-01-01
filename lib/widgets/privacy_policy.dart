import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'navbar.dart';

class PrivacyPolicy extends StatelessWidget {
  final String name;
  PrivacyPolicy({required this.name});

  final List<Map<String, dynamic>>  sections = [
    {
      'title': 'Our Privacy Policy',

      'content':
      'Welcome to Fix n Fill! At Fix n Fill, we are committed to safeguarding your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, disclose, and protect the personal data we gather from our users, whether you are a customer, worker, or visitor to our website.',
    },
    {
      'title': '1. Information We Collect',
      'content': 'We may collect the following types of information from you:',
      'items': [
        'Personal Information: This includes your name, contact information (such as email address and phone number), address, CNIC number, and date of birth. We collect this information when you create an account, book a service, or apply for a job with Fix n Fill.',
        'Payment Information: If you make a payment through our platform, we may collect payment card information or other financial details. However, we do not store this information on our servers; it is securely processed by our payment partners.',
        'Location Data: When you use our mobile app, we may collect location data to provide you with services, such as connecting you with nearby sellers.',
        "Device Information: We may collect information about the devices you use to access our services, such as your device's unique identifier, IP address, browser type, and operating system.",
        'Service Data: Information related to the services you request or provide, such as service details, appointment dates and times, and customer feedback.',
        'Communication: We may store communications between you and Fix n Fill, including emails and messages sent through our platform.',
      ],
    },
    {
      'title': '2. How We Use Your Information',
      'content': 'We use your personal information for the following purposes:',
    'items': [
        'To provide and improve our services, including booking services and connecting sellers with customers.',
        'To process payments, when applicable.',
        'To personalize your experience, including suggesting services and offers that may interest you.',
        'To communicate with you, including sending service updates, marketing communications, and customer support.',
        'To ensure the safety and security of our platform and users.',
      ],
    },
    {
      'title': '3. Disclosure of Your Information',
      'content': 'We may share your information in the following circumstances:',
      'items': [
        'With sellers and service providers to fulfill service requests.',
        'With our payment processing partners for payment processing.',
        'With legal authorities if required by law, to protect our rights, or to respond to legal requests.',
        'With our affiliated business entities or in connection with a merger, acquisition, or sale of assets.',
      ],
    },
    {
      'title': '4. Data Security',
      'content':
      'We take the security of your personal information seriously. We employ industry-standard security measures to protect your data from unauthorized access, disclosure, alteration, and destruction. While we strive to protect your data, no online service can guarantee absolute security.',
    },
    {
      'title': '5. Your Choices',
      'content': 'You have the following rights regarding your personal information:',
      'items': [
        'You can access, update, or delete your information through your account settings.',
        'You can opt-out of receiving marketing communications by following the unsubscribe instructions in the emails we send.',
      ],
    },
    {
      'title': '6. Changes to this Privacy Policy',
      'content':
      'We may update this Privacy Policy from time to time. Any changes will be posted on our website with the effective date. Please review this Privacy Policy regularly to stay informed about our data practices.',
    },
    {
      'title': '7. Contact Us',
      'content':
      'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at fixnfill@gmail.com.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Policy"),
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
                      fontSize: 16.0,
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