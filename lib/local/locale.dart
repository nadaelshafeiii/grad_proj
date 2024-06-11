import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          'Mind Awake': 'ابق عقلك مستيقظا',
          "Eyes On The Road": "ابق عينك على الطريق",
          "Create an account": "انشاء حساب",
          "Email": "بريد الكتروني",
          "username": "اسم المستخدم",
          "password": "كلمة المرور",
          "Confirm password": "تاكيد كلمة المرور ",
          "Emergency contact": "رقم الطوارئ",
          "Sign up": "تسجيل ",
          'Already have an account? ': "لديك حساب بالفعل؟",
          "Get Started": "ابدا",
          'Log in': 'تسجيل دخول',
          'Welcome Back': ' مرحبا بك',
          'Username': "اسم المستخدم",
          "username is required": "هذا الحقل مطلوب",
          "password is required": "هذا الحقل مطلوب",
          'Forgot passwored?': "نسيت كلمة المرور؟",
          'Do not have an account?': 'ليس لديك حساب؟',
          '\n Sign up !': 'انشاء حساب ',
          'Edit ': 'تعديل',
          'Profile': 'حسابي',
          '    Check Password': '     التحقق من كلمة المرور',
          'Enter new password': 'ادخل كلمة مرور جديدة',
          'Enter old password': 'ادخل كلمة السر الخاصة بك',
          'Save': 'حفظ',
          'Please enter your Email ': 'ادخل البريد الالكتروني الخاص بك',
          'Set Password': 'انشا كلمة مرور جديدة',
          "Password": "كلمة المرور",
          'Reset Password': 'تغيير كلمة المرور',
          "Email is required": "هذا الحثل مطلوب",
          "Passwords don't match": "كلمة المرور غير متطابقة",
          "Emergency contact is required": "هذالحقل مطلوب",
          'Wrong username or password': 'اسم المستخدم او كلمة المرور خاطئة',
          'Please Try Again': 'برجاء التاكد من ادخال بيانات صحيحة',
          'Failed to update user data': 'فشل تحديث البيانات',
          'Wrong Password': 'كلمة المرور ليست صحيحة',
          'Unexpected error occurred':'حدث خطا، برجاء اعادة المحاولة',
          'Error updating user data':'فشل تحديث البيانات',
          'Failed to change password':'فشل تغيير كلمة السر',
          'Passwords do not match.':"كلمة المرور غير متطابقة",
          'Email is not registered.':'يرجى ادخال بريد الكتروني صحيح',
          'My Profile':'حسابى',
          'About Us':'حول التطبيق',
          'Help Center':'كيف يعمل ',
          'Change Language':'تغيير اللغه',
          'English':'الانجليزيه',
          'Privacy and Security':'الامان والخصوصيه',
          'Log out':'تسجيل \nالخروج',
          'Camera Page':'الكاميرا',
          'Camera':'الكاميرا',
          'Notification':'الاشعارات',
          'Location':'الموقع',
          'Allowed':'مسموح',
          'Not Allowed':'غير مسموح',
          'About Us Page':'حول التطبيق',
          'About Our App':'srive ماهو ',
          'Our app, SleepGuard, is a revolutionary solution designed to prevent accidents caused by drowsy driving. We understand the dangers of driving while fatigued, and our mission is to provide drivers with a tool that helps them stay alert and safe on the road.':
          'يعد تطبيقنا  حلاً ثوريًا مصممًا لمنع الحوادث الناجمة عن القيادة أثناء النعاس. نحن نتفهم مخاطر القيادة أثناء التعب، ومهمتنا هي تزويد السائقين بأداة تساعدهم على البقاء في حالة تأهب وأمان على الطريق.',
          'Our Mission':'مهمتنا',
          'At SleepGuard, our mission is to save lives by reducing the number of accidents caused by drowsy driving. We aim to achieve this by developing innovative technologies that detect signs of fatigue and provide timely alerts to drivers, allowing them to take necessary precautions and avoid accidents.':
          '  مهمتنا هي إنقاذ الأرواح عن طريق تقليل عدد الحوادث الناجمة عن القيادة أثناء النعاس. ونحن نهدف إلى تحقيق ذلك من خلال تطوير تقنيات مبتكرة تكتشف علامات التعب وتوفر تنبيهات في الوقت المناسب للسائقين، مما يسمح لهم باتخاذ الاحتياطات اللازمة وتجنب وقوع الحوادث.',
          'Meet Our Team':'فريق العمل',
          // ignore: equal_keys_in_map
          'Help Center':'مساعده',
          'Overview':'نبذة عن تطبيقنا',
          'Welcome to our Sleeping Drive Detection app help center Our app helps detect drowsiness while driving to prevent accidents and promote road safety.':'مرحبًا بك في مركز المساعدة الخاص بتطبيقنا يساعد تطبيقنا على اكتشاف النعاس أثناء القيادة لمنع وقوع الحوادث وتعزيز السلامة على الطرق', 
          'Features':'سمات التطبيق',
          '• Real-time monitoring of driver\'s eyelid movements.\n'
                  '• Audio and visual alerts when drowsiness is detected.\n'
                  '• Customizable settings for sensitivity and alert preferences.':'• مراقبة حركات جفن السائق في الوقت الحقيقي.\n'
                  '• تنبيهات صوتية ومرئية عند اكتشاف النعاس.\n'
                  '• إعدادات قابلة للتخصيص لتفضيلات الحساسية والتنبيه.',
          'How to Use':'كيفية الاستخدام',
          '1. Open the app and place your device securely in the car.\n'
                  '2. Start driving.\n'
                  '3. Pay attention to audio and visual alerts if drowsiness is detected.':'1. افتح التطبيق ثم ضع جهازك بأمان في السيارة.\n'
                  '2. ابدأ القيادة.\n'
                  '3. انتبه إلى التنبيهات الصوتية والمرئية في حالة اكتشاف النعاس.',
                  'Troubleshooting':'استكشاف الاخطاء واصلاحها',
                  '• If alerts are not working, ensure that your device '
                  'is positioned correctly and has a clear view of your face.\n'
                  '• Check that the app has permission to access your device\'s camera and microphone.':'• إذا لم تعمل التنبيهات، فتأكد من سلامة جهازك'
                  'تم وضعه بشكل صحيح ويتمتع برؤية واضحة لوجهك.\n'
                  '• تأكد من أن التطبيق لديه إذن للوصول إلى الكاميرا والميكروفون بجهازك.',
          'Safety Tips':'نصائح للسلامه',
          '• Get enough rest before driving, and take regular breaks on long trips.\n'
                  '• Avoid driving if you feel tired or drowsy.\n'
                  '• Listen to your body and recognize warning signs of fatigue.':'• احصل على قسط كافٍ من الراحة قبل القيادة، وخذ فترات راحة منتظمة في الرحلات الطويلة.\n'
                  '• تجنب القيادة إذا كنت تشعر بالتعب أو النعاس.\n'
                  '• استمع إلى جسدك وتعرف على العلامات التحذيرية للإرهاق.',
                  'FAQs':'الأسئلة الشائعة',
                  'Q: How accurate is the drowsiness detection?\nA: The accuracy of detection may vary based on individual factors and driving conditions.\n':'س: ما مدى دقة اكتشاف النعاس؟\n ج: قد تختلف دقة الكشف بناءً على عوامل فردية وظروف القيادة.\n',
                  'We value your feedback! If you have any questions, suggestions, or issues \n regarding the app, please feel free to contact us at srivesupport@example.com.':'نحن نقدر ملاحظاتك! إذا كانت لديك أية أسئلة أو اقتراحات أو مشكلات تتعلق بالتطبيق، فلا تتردد في الاتصال بنا على srivesupport@gmail.com.',
                  'Feedback and Support':'الملاحظات والمساعدة',
                  'Terms of Service':'شروط الخدمة',
                  'Read our Terms of Service for information about the use of our app and your rights and responsibilities.':"اقرأ شروط الخدمة الخاصة بنا للحصول على معلومات حول استخدام تطبيقنا وحقوقك ومسؤولياتك.",
                  'About':'عن التطبيق'

                  



        },
        "en": {
          "Mind Awake": 'Mind Awake',
          "Eyes On The Road": "Eyes On The Road",
          "Create an account": "create an account ",
          "Email": "Email",
          "username": "username",
          "password": "password",
          "Confirm password": "Confirm password ",
          "Emergency contact": "Emergency Contact",
          "Sign up": "Sign Up",
          'Already have an account? ': 'Already have an account? ',
          "Get Started": "Get Started",
          'Log in': 'Log in',
          'Welcome Back': 'Welcome Back',
          'Username': 'Username',
          "username is required": "username is required",
          "password is required": "password is required",
          'Forgot passwored?': '?Forgot passwored',
          'Do not have an account?': '?Do not have an account',
          ' Sign up !': 'Sign up !',
          'Edit ': 'Edit ',
          'Profile': 'Profile',
          '    Check Password': '    Check Password',
          'Enter new password': 'Enter new password',
          'Enter old password': 'Enter old password',
          'Save': 'Save',
          'Please enter your Email ': 'Please enter your Email ',
          'Set Password': 'Set Password',
          "Password": "Password",
          'Reset Password': 'Reset Password',
          "Email is required": "Email is required",
          "Passwords don't match": "Passwords don't match",
          "Emergency contact is required": "Emergency contact is required",
          'Please Try Again': 'Please Try Again',
          'Wrong username or password': 'Wrong username or password',
          'Failed to update user data': 'Failed to update user data',
          'Wrong Password': 'Wrong Password',
          'Unexpected error occurred':'Unexpected error occurred',
          'Error updating user data':'Error updating user data',
          'Failed to change password':'Failed to change password',
          'Passwords do not match.':'Passwords do not match.',
          'Email is not registered.':'Email is not registered.',
          'My Profile':'My Profile',
          'About Us':'About Us',
          'Help Center':'Help Center',
          'Change Language':'Change Language',
          'English':'English',
          'Privacy and Security':'Privacy and Security',
          'Log out':'Log out',
          'Camera Page':'Camera Page',
          'Camera':'Camera',
          'Notification':'Notification',
          'Location':'Location',
          'Allowed':'Allowed',
          'Not Allowed':'Not Allowed',
          'About Us Page':'About Us Page',
          'Our app, SleepGuard, is a revolutionary solution designed to prevent accidents caused by drowsy driving. We understand the dangers of driving while fatigued, and our mission is to provide drivers with a tool that helps them stay alert and safe on the road.':'Our app, SleepGuard, is a revolutionary solution designed to prevent accidents caused by drowsy driving. We understand the dangers of driving while fatigued, and our mission is to provide drivers with a tool that helps them stay alert and safe on the road.',
          'Our Mission':'Our Mission',
          'At SleepGuard, our mission is to save lives by reducing the number of accidents caused by drowsy driving. We aim to achieve this by developing innovative technologies that detect signs of fatigue and provide timely alerts to drivers, allowing them to take necessary precautions and avoid accidents.':'At SleepGuard, our mission is to save lives by reducing the number of accidents caused by drowsy driving. We aim to achieve this by developing innovative technologies that detect signs of fatigue and provide timely alerts to drivers, allowing them to take necessary precautions and avoid accidents.',
          'Meet Our Team':'Meet Our Team',
          // ignore: equal_keys_in_map
          'Help Center':'Help Center',
          'Overview':'Overview',
          'Welcome to our Sleeping Drive Detection app help center Our app helps detect drowsiness while driving to prevent accidents and promote road safety.':'Welcome to our Sleeping Drive Detection app help center. Our app helps detect drowsiness while driving to prevent accidents and promote road safety.',
          'Features':'Features',
          '• Real-time monitoring of driver\'s eyelid movements.\n'
                  '• Audio and visual alerts when drowsiness is detected.\n'
                  '• Customizable settings for sensitivity and alert preferences.':'• Real-time monitoring of driver\'s eyelid movements.\n'
                  '• Audio and visual alerts when drowsiness is detected.\n'
                  '• Customizable settings for sensitivity and alert preferences.',
          'How to Use':'How to Use',
          '1. Open the app and place your device securely in the car.\n'
                  '2. Start driving.\n'
                  '3. Pay attention to audio and visual alerts if drowsiness is detected.':'1. Open the app and place your device securely in the car.\n'
                  '2. Start driving.\n'
                  '3. Pay attention to audio and visual alerts if drowsiness is detected.',
                  'Troubleshooting':'Troubleshooting',
                  '• If alerts are not working, ensure that your device '
                  'is positioned correctly and has a clear view of your face.\n'
                  '• Check that the app has permission to access your device\'s camera and microphone.':'• If alerts are not working, ensure that your device '
                  'is positioned correctly and has a clear view of your face.\n'
                  '• Check that the app has permission to access your device\'s camera and microphone.',
                  'Safety Tips':'Safety Tips',
                  '• Get enough rest before driving, and take regular breaks on long trips.\n'
                  '• Avoid driving if you feel tired or drowsy.\n'
                  '• Listen to your body and recognize warning signs of fatigue.':'• Get enough rest before driving, and take regular breaks on long trips.\n'
                  '• Avoid driving if you feel tired or drowsy.\n'
                  '• Listen to your body and recognize warning signs of fatigue.',
                  'FAQs':'FAQs',
                  'Q: How accurate is the drowsiness detection?\nA: The accuracy of detection may vary based on individual factors and driving conditions.\n':'Q: How accurate is the drowsiness detection?\nA: The accuracy of detection may vary based on individual factors and driving conditions.\n',
                  'We value your feedback! If you have any questions, suggestions, or issues \n regarding the app, please feel free to contact us at srivesupport@example.com.':'We value your feedback! If you have any questions, suggestions, or issues \n regarding the app, please feel free to contact us at srivesupport@example.com.',
                  'Feedback and Support':'Feedback and Support',
                  'Terms of Service':'Terms of Service',
                  'Read our Terms of Service for information about the use of our app and your rights and responsibilities.':'Read our Terms of Service for information about the use of our app and your rights and responsibilities.',
                  'About Our App':'About Our App',
                  'About':'About'

        },
      };
}
