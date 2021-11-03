import 'package:get/get.dart';

class LocalString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        //ENGLISH
        'english_US': {
          'homepage': 'How can we help you?',
          'action1': 'Request Consultation',
          'action2': 'Request Medical Assistance',
          'action3': 'View Queue',
          'action4': 'See All',
          //dialog1
          'dialog1': 'Is the consultation for you?',
          'dialogsub1':
              'If the consultation is for you please select YES. If not, please select NO',
          'dialogbtn1': 'YES',
          'dialogbtn01': 'NO',
          //ConsFormY
          'consform': 'Where are you experiencing discomfort?',
          'consform1': 'What type of consultation?',
          'consformi': 'Follow-up',
          'consformii': 'New Consultation',
          'consform2': 'Patient’s Information',
          'consform3': 'Age',
          'consform4': 'Next',
          //ConsForm
          'consform5': 'Where are you experiencing discomfort?',
          'consform6': 'What type of consultation?',
          'consformsub1': 'Follow-up',
          'consformsub2': 'New Consultation',
          'consform7': 'Patient’s Information',
          'consform8': 'First Name',
          'consform9': 'Last Name',
          'consform10': 'Age',
          'consform11': 'Next',
          //ConsForm2
          'consform12': 'Almost there!',
          'consform13': 'Tell us more about the discomfort',
          'consform14': 'Consult Now',
          'consform15': 'Next',
          //consform3
          'consform16': 'Upload past prescription or laboratory results',
          'consform17':
              'Select and upload images to support your follow-up consultation',
          'consform18': 'Upload here',
          'consform19': 'Consult Now',
          //Dialog4
          'dialog4': 'You have successfully requested a consultation!',
          'dialogsub4':
              'Your priority number is C024. Please check the queue and wait for your turn. Thank you',
          'dialogbtn4': 'Got it',
          //Medical Asssistance
          'medicalasssistance':
              'This service provides Medical Assistance to patient/s who are diagnosed and need medical treatment either an out-patient or confined in any government or districts hospitals in Davao del Norte and National Government Hospitals. The amount to be availed is based on the assessment of the assessing staff. Medical supplies and supplements/vitamins are not included/ allowed in the assistance. Client may avail once every month or 30 days from date of the last assistance.',
          'ma1': 'REQUIREMENTS',
          'ma2':
              'Valid ID of claimant with address at Davao del Norte and/or Barangay Certification in absence of Valid ID',

          'ma3':
              'Doctor’s Prescription with complete name, signature and license number',
          'ma4': 'WHERE TO SECURE',
          'ma5':
              'Client himself /herself and/or Barangay where the client resides',

          'ma6':
              'Any National Government and District Hospitals of Davao del Norte such as: DRMC, SPMC, 3 District Hospitals (Kapalong Zone, Samal Zone and Carmen Zone), CHO, MHO, PHO and PGH',
          'ma7': 'Schedule',
          'ma8': 'Morning',
          'ma9': 'Afternoon',
          'ma10': 'Avail Medical Assistance',
          //Dialog2
          'dialog2': 'Is the medical assistance request for you?',
          'dialogsub2':
              'If the assistance is for you please select YES. If not, please select NO',
          'dialogbtn2': 'YES',
          'dialogbtn02': 'NO',
          //Details to fill(yes)
          'details': 'Patients Information',
          'details1': 'Address',
          'details2': 'Age',
          'details3': 'Select Gender',
          'details4': 'Select Type',
          'details5': 'Next',
          //MA Form
          'maform ': 'Patients Information',
          'maform1': 'First Name',
          'maform2': 'Last Name',
          'maform3': 'Address',
          'maform4': 'Age',
          'maform5': 'Select Gender',
          'maform6': 'Select Type',
          'maform7':
              'Upload a valid ID or barangay certificates of the patient',
          'maform8': 'Upload here',
          'maform9': 'Next',
          //MA Form 2
          'maform10': 'Upload prescription',
          'maform11':
              'Please upload a valid prescription issued not more than a month',
          'maform12': 'Upload here',
          'maform13': 'Request Assistance',
          //Dialog 5
          'dialog5': 'You have successfully requested MA!',
          'dialogsub5':
              'Your priority number is MA24 Please check the queue and wait for your turn. Thank you',
          'dialogbtn5': 'Got it',
          //Profile
          'profile': 'Status',
          'profile1': 'Click here to get verified',
          'profile2': 'Change Password',
          //Verification
          'verification': 'To Verify Your Account',
          'verifi1':
              'For those who do not own any valid ID, please provide barangay certificate as an alternative.',
          'verifi2': 'Upload Valid ID or Brgy. Certificate',
          'verifi3': 'Upload Valid ID or Brgy. Certificate with selfie',
          'verifi4': 'Upload Here',
          'verifi5': 'Submit',
          //Dialog 6
          'dialog6': 'Verification request sent',
          'dialogsub6': 'We will verify your account 24hrs. Thank you',
          'dialogbtn6': 'Got it!',
          //Dialog 3 No Queue
          'dialog3': 'Sorry you have no queue',
          'dialogsub3':
              'You need to request consultation or medical assistance to be in a queue.',
          'dialogbtn3': 'Okay',
          //SelectQueueScreen
          'slctQS': 'Select to view your queue',
          'btnq1': 'CONSULTATION',
          'btnq2': 'PSWD MA',
          //Queue
          'queue1': 'YOUR  QUEUE NUMBER',
          'queue2': 'SERVING NOW',
          'queue3': 'More info',
          'queue4': '27 PEOPLE WAITING',
          //Has Queue-MA
          'maqueue1': 'YOUR  QUEUE NUMBER',
          'maqueue2': 'SERVING NOW',
          'maqueue3': 'More info',
          'maqueue4': '27 PEOPLE WAITING',
          //QueueInfo
          'queue6': 'Number',
          'queue7': 'Queue number',
          'queue8': 'Previous',
          'queue9': 'Next',
          //Cons History
          'conshistory': 'Consultation History',
          'cons1': 'Month',
          'cons2': 'Day',
          //Cons History Info
          'conshistory1': 'Consultation Info',
          'cons3': 'Patient',
          'cons4': 'Age of Patient',
          'cons5': 'Date Requested',
          'cons6': 'Consultation Started',
          'cons7': 'Consultation Ended',
          //Live Chat Info
          'livechat': 'Consultation Info',
          'chat1': 'Patient',
          'chat2': 'Age of Patient',
          'chat3': 'Date Requested',
          'chat4': 'Consultation Started',
          //MA History
          'mahistory': 'Medical Assistance History',
          'mah1': 'Month',
          'mah2': 'Day',
          //MA History Info
          'mahistory1': 'Patient Information',
          'mah3': 'Patient Name',
          'mah4': 'Patient Age',
          'mah5': 'Address',
          'mah6': 'Gender',
          'mah7': 'Patient Type',
          'mah8': 'MA Request Information',
          'mah9': 'Received by',
          'mah10': 'Pharmacy',
          'mah11': 'Medecine Worth',
          'mah12': 'Date Requested',
          'mah13': 'Date MA Claimed',
          'mah14': 'See attached Photos'
        },

        //TAGALOG
        'tagalog_ph': {
          'homepage': 'Paano namin kayo matutulungan?',
          'action1': 'Humiling ng konsulta',
          'action2': 'Humiling ng Tulong Medikal',
          'action3': 'Tignan ang  Queue',
          'action4': 'Tignan lahat',
          //dialog1
          'dialog1': 'Ang konsulta ba ay para sa iyo?',
          'dialogsub1':
              ' Kung ang konsulta ay para sa iyo, mangyaring, pumili ng Oo. Kung hindi, mangyaring piliin ang HINDI',
          'dialogbtn1': 'OO',
          'dialogbtn01': 'HINDI',
          //consformY
          'consform': 'Saan ka nakakaranas ng ibang pakiramdam?',
          'consform1': 'Anong uri ng konsulta?',
          'consformi': 'Magfollow-up',
          'consformii': 'Bagong Konsulta',
          'consform2': 'Impormasyon ng pasyente',
          'consform3': 'Edad',
          'consform4': 'Susunod',
          //consform
          'consform5': 'Saan ka nakakaranas ng ibang pakiramdam?',
          'consform6': 'Anong uri ng konsulta?',
          'consformsub1': 'Magfollow-up',
          'consformsub2': 'Bagong Konsulta',
          'consform7': 'Impormasyon ng Pasyente',
          'consform8': 'Unang Pangalan',
          'consform9': 'Apelyedo',
          'consform10': 'Edad',
          'consform11': 'Susunod',
          //consform2
          'consform12': 'Malapit na!',
          'consform13': 'Sabihin sa amin ang higit pa tungkol sa dinadamdam',
          'consform14': 'Kumunsulta Ngayon',
          'consform15': 'Susunod',
          //consform3
          'consform16':
              'Mag-upload ng nakaraang mga resulta sa reseta o laboratoryo',
          'consform17':
              'Pumili at mag-upload ng mga imahe upang suportahan ang iyong pag-follow-up na konsulta',
          'consform18': 'Upload dito',
          'consform19': 'Kumunsulta Ngayon',
          //Dialog4
          'dialog4': 'Matagumpay kang humiling ng konsultasyon!',
          'dialogsub4':
              'Ang iyong priority number ay C024. Mangyaring suriin ang queue at maghintay para sa iyong oras. Salamat',
          'dialogbtn4': 'Nakuha ko',
          //Medical Asssistance
          'medicalasssistance':
              'Ang serbisyong ito ay nagbibigay ng karagdagang tulong Medikal sa mga pasyente na na-diagnosed at nangangailangan ng lunas medikal, ito man ay pasyente na nasa labas ng ospital o pasyenteng nasa ospital mismo, nasa pam-publiko o distritong ospital na sakop ng Davao del Norte at National Government Hospital. Ang karagdagang tulong na makukuha ay batay sa pag-aanalisa ayon sa mga taong naatasan. Ang mga medikal na suplay, suplemento at bitamina ay hindi kasama o kabilang sa tulong. Isang beses bawat buwan o tatlumpong araw (30 days) mula sa petsa ng huling pagtanggap ng tulong.',
          'ma1': 'KINAKAILANGAN',
          'ma2':
              'Valid ID ng naghahabol na may address sa Davao del Norte at / o Barangay Certification na walang Valid ID',
          'ma3':
              'Reseta ng Doktor na may kumpletong pangalan, lagda at numero ng lisensya',
          'm4': 'SAAN KUMUHA',
          'ma5':
              'Ang kliyente mismo at / o ang Barangay kung saan nakatira ang kliyente',
          'ma6':
              'Anumang Pambansang Pamahalaan at Distrito na Ospital ng Davao del Norte tulad ng: DRMC, SPMC, 3 Distrito na Mga Ospital (Kapalong Zone, Samal Zone at Carmen Zone), CHO, MHO, PHO at PGH',
          'ma7': 'Iskedyul',
          'ma8': 'Umaga',
          'ma9': 'Hapon',
          'ma10': 'Kumuha ng Tulong Medikal',
          //Dialog2
          'dialog2': 'Ang kahilingan ba sa tulong medikal para sa iyo?',
          'dialogsub2':
              'Kung ang tulong ay para sa iyo mangyaring pumili ng OO. Kung hindi, mangyaring piliin ang HINDI',
          'dialogbtn2': 'OO',
          'dialogbtn02': 'HINDI',
          //Details to fill(yes)
          'details': 'Impormasyon ng pasyente',
          'details1': 'Address',
          'details2': 'Edad',
          'details3': 'Kasarian',
          'details4': 'Piliin ang uri',
          'details5': 'Susunod',
          //MA Form
          'maform ': 'Impormasyon ng pasyente',
          'maform1': 'Unang Pangalan',
          'maform2': 'Apelyedo',
          'maform3': 'Address',
          'maform4': 'Edad',
          'maform5': 'Kasarian',
          'maform6': 'Piliin ang uri',
          'maform7':
              'Mag-upload ng wastong ID o mga sertipiko ng barangay ng pasyente',
          'maform8': 'Upload dito',
          'maform9': 'Susunod',
          //MA Form 2
          'maform10': 'Mag-upload ng reseta',
          'maform11':
              'Mangyaring mag-upload ng wastong reseta na inisyu hindi hihigit sa isang buwan',
          'maform12': 'Upload dito',
          'maform13': 'Humiling ng Tulong',
          //Dialog 5
          'dialog5': 'Matagumpay kang humiling ng MA!',
          'dialogsub5':
              'Ang iyong priority number ay MA24. Mangyaring suriin ang queue at maghintay para sa iyong oras. Salamat',
          'dialogbtn5': 'Nakuha ko',
          //Profile
          'profile': 'Status',
          'profile1': 'I-click ito upang ma-verify',
          'profile2': 'Palitang ang Password',
          //Verification
          'verification': 'Upang Mapatunayan ang Iyong Account',
          'verifi1':
              'Para sa mga walang pagmamay-ari ng anumang wastong ID, mangyaring magbigay ng sertipiko ng barangay bilang kahalili.',
          'verifi2': 'Mag-upload ng Valid ID o sa Brgy. Sertipiko',
          'verifi3':
              'Mag-upload ng Valid ID o sa Brgy. Sertipiko at may selfie',
          'verifi4': 'Upload dito',
          'verifi5': 'Ipasa',
          //Dialog 6
          'dialog6': 'Ipinadala ang kahilingan sa pag-verify',
          'dialogsub6':
              'Aming iverify ang iyong account sa loob ng 24oras. Salamat',
          'dialogbtn6': 'Nakuha ko',
          //Dialog 3 No Queue,
          'dialog3': 'Paumanhin wala kang queue',
          'dialogsub3':
              'Kailangan mong humiling ng konsulta o tulong medikal upang makasama sa queue ',
          'dialogbtn3': 'Okay',
          //SelectQueueScreen
          'slctQS': 'Pumili upang tingnan ang iyong queue',
          'btnq1': 'KONSULTASYON',
          'btnq2': 'PSWD MA',
          //Has Queue-Cons
          'queue1': 'Iyong numero ng QUEUE (YOUR  QUEUE NUMBER)',
          'queue2': 'SERVING NOW',
          'queue3': 'Karagdagang impormasyon',
          'queue4': '27 taong naghihintay',
          //Has Queue-MA
          'maqueue1': 'Iyong numero ng QUEUE (YOUR  QUEUE NUMBER)',
          'maqueue2': 'SERVING NOW',
          'maqueue3': 'Karagdagang impormasyon',
          'maqueue4': 'taong naghihintay',
          //QueueInfo
          'queue6': 'No.',
          'queue7': 'Queue No.',
          'queue8': 'Ibalik',
          'queue9': 'sunod',
          //Cons History
          'conshistory': 'Consultation History',
          'cons1': 'Buwan',
          'cons2': 'Araw',
          //Cons History Info
          'conshistory1': 'Impormasyon ng Konsultasyon',
          'cons3': 'Pasyente',
          'cons4': 'Edad ng Pasyente',
          'cons5': 'Kailan humiling',
          'cons6': 'Nagsimula ang Konsulta',
          'cons7': 'Natapos ang Konsulta',
          //Live Chat Info
          'livechat': 'Impormasyon ng Konsultasyon',
          'chat1': 'Pasyente',
          'chat2': 'Edad ng Pasyente',
          'chat3': 'Kailan humiling',
          'chat4': 'Nagsimula ang Konsulta',
          //MA History
          'mahistory': 'Medical Assistance History',
          'mah1': 'Buwan',
          'mah2': 'Araw',
          //MA History Info
          'mahistory1': 'Impormasyon ng Pasyente',
          'mah3': 'Pangalan ng Pasysente',
          'mah4': 'Edad ng Pasyente',
          'mah5': 'Address',
          'mah6': 'Kasarian',
          'mah7': 'Pumili  ng uri',
          'mah8': 'Impormasyon sa Humiling ng MA',
          'mah9': 'Natanggap ni',
          'mah10': 'Parmasya',
          'mah11': 'Nagkakahalaga ang gamot',
          'mah12': 'Kailan humiling',
          'mah13': 'Kailan kinuha ang MA',
          'mah14': 'Tingnan ang kalakip na Mga Larawan'
        },

        //BISAYA
        'bisaya_ph': {
          'homepage': 'Unsa man amo matabang nimo?',
          'action1': 'Mangayog konsulta',
          'action2': 'Mag-request ug tabang medikal',
          'action3': 'Tan-awon ang queue',
          'action4': 'Tan-awon tanan',
          //dialog1
          'dialog1': 'Para nimu ang konsulta?',
          'dialogsub1':
              'Kung para nimu palihug pilia ang OO. Kung dili, palihug pilia ang DILI.',
          'dialogbtn1': 'OO',
          'dialogbtn01': 'DILI',
          //consformY
          'consform': 'Asa dapit sa kalawasan nimu ang laeng ginabati?',
          'consform1': 'Unsa nga konsulta imu kinahanglan?',
          'consformi': 'Magpafollow-up',
          'consformii': 'Bag-o nga Konsulta',
          'consform2': 'Impormasyon sa pasyente',
          'consform3': 'Edad',
          'consform4': 'Sunod',
          //consform
          'consform5': 'Asa dapit sa kalawasan nimu ang laeng ginabati?',
          'consform6': 'Unsa nga konsulta imu kinahanglan?',
          'consformsub1': 'Magpafollow-up',
          'consformsub2': 'Bag-o nga Konsulta',
          'consform7': 'Impormasyon sa pasyente',
          'consform8': 'Unang Pangalan',
          'consform9': 'Apelyido',
          'consform10': 'Edad',
          'consform11': 'Sunod',
          //consform2
          'consform12': 'Hapit na!',
          'consform13': 'Isulti pa diri ang laeng ginabati nimu',
          'consform14': 'Magpa konsulta na',
          'consform15': 'Sunod',
          //consform3
          'consform16':
              'I-upload diria ang niaging reseta o resulta sa laboratory',
          'consform17':
              'Magpili ug mag upload ug mga imahe para mu supporta sa imung gpa follow up na konsulta',
          'consform18': 'I-upload diri',
          'consform19': 'Magpa konsulta na',
          //Dialog4
          'dialog4': 'Malampuson ka nga nagkuhag konsulta!',
          'dialogsub4':
              'Ang imung priority number kay CO24. Palihug ko tan-aw sa queue ug hulat kung kanus-a ang imuhang turno.',
          'dialogbtn4': 'Okay',
          //Medical Asssistance
          'medicalasssistance':
              'Kini nga serbisyo naghatag ug dugang tabang medikal alang sa mga pasyente nga nadayagnos sa sakit ug nanginahanglag atimang medikal kung ang pasyente naa sa gawas sa ospital o naa mismo sa sulod sa pasilidad sa ospital nga kabahin sa Davao del Norte ug National Government Hospital. Ang benepisyo nga makuha gibatay sa analisiya sa mga taong nag-analisiya.  Ang mga gamit medikal, suplemento ug bitamina maoy walay labot o walay apil sa dugang hinabang. Ang benepesyaryo makadawat lang ug dugang tabang ka-isa kada bulan o trayntay diyas (30 days) gikan sa petsa sa pagdawat sa maong tabang.',
          'ma1': 'KINAHANGLAN',
          'ma2':
              'Valid ID nga ang address kay taga Davao del Norte at/o Barangay Certificate sa walay mga valid ID',
          'ma3':
              'Reseta sa Doktor nga naay pangalan, pirma ug numero ng lisensya',
          'ma4': 'ASA MAG-KUHA',
          'ma5':
              'Ang kliyente mismo at/o sa Barangay kung asa nag puyo ang kliyente',
          'ma6':
              'Sa mga public hospital sa Davao del Norte pareha anang sa: DRMC, SPMC, 3 Distrito na Mga Ospital (Kapalong Zone, Samal Zone at Carmen Zone), CHO, MHO, PHO at PGH',
          'ma7': 'Iskedyul',
          'ma8': 'Buntag',
          'ma9': 'Udto',
          'ma10': 'Magkuha ug Tabang Medikal',
          //Dialog2
          'dialog2': 'Ang pagkuha bag tabang medikal ay para nimu?',
          'dialogsub2':
              'Kung para nimu palihug pilia ang OO. Kung dili, palihug pilia ang DILI',
          'dialogbtn2': 'OO',
          'dialogbtn02': 'DILI',
          //Details to fill(yes)
          'details': 'Patients Information',
          'details1': 'Address',
          'details2': 'Edad',
          'details3': 'Kasarian',
          'details4': 'Piliin ang uri',
          'details5': 'Sunod',
          //MA Form
          'maform ': 'Impormasyon sa pasyente',
          'maform1': 'Unang Pangalan',
          'maform2': 'Apelyido',
          'maform3': 'Address',
          'maform4': 'Edad',
          'maform5': 'Kasarian',
          'maform6': 'Piliin ang uri',
          'maform7':
              'Palihug i-upload ang tama na ID ug mga certificate sa barangay  sa pasyente',
          'maform8': 'I-upload diri',
          'maform9': 'Sunod',
          //MA Form2
          'maform10': 'I-upload ang reseta',
          'maform11':
              'Palihug i-upload ang tama na reseta na gihatag sa dili lampas sa isa kabuwan',
          'maform12': 'I-upload diri',
          'maform13': 'Pagpangayo og Tabang',
          //Dialog 5
          'dialog5': 'Malampuson ka nga nagkuhag MA!',
          'dialogsub5':
              'Ang imung priority number kay MA24.. Palihug ko tan-aw sa queue ug hulat kung kanus-a ang imuhang turno. Salamat',
          'dialogbtn5': 'Okay',
          //Profile
          'profile': 'Status',
          'profile1': 'Pag-klik dinhi aron mapamatud-an imuhang account',
          'profile2': 'Bag-oha ang imung password',
          //Verification
          'verification': 'Aron mapanghimatuud ang imong Account',
          'verifi1':
              'Alang sa mga wala’y tag-iya sa bisan unsang balidong ID, palihug paghatag sertipiko sa barangay ingon usa ka kapilian.',
          'verifi2': 'Mag-upload ug Valid ID o Sertipikasyon gikan sa barangay',
          'verifi3':
              'Mag-upload ug Valid ID o Sertipikasyon gkan sa barangay ug picture nimu',
          'verifi4': 'Iupload diri',
          'verifi5': 'Ipasa',
          //Dialog 6
          'dialog6': 'Magpadala ug panghimatuud (verification)',
          'dialogsub6': 'I-verify namo ang imong account sa 24 oras. Salamat',
          'dialogbtn6': 'Okay',
          //Dialog 3 No Queue,
          'dialog3': 'Pasensya wala kay queue',
          'dialogsub3':
              'Kinahanglan nimo nga pangayoon ang usa ka konsulta o tabang medikal aron maapil sa queue',
          'dialogbtn3': 'Okay',
          //SelectQueueScreen
          'slctQS': 'Pagpili aron tan-awon ang imong queue',
          'btnq1': 'KONSULTASYON',
          'btnq2': 'PSWD MA',
          //Has Queue-Cons
          'queue1': 'YOUR  QUEUE NUMBER',
          'queue2': 'SERVING NOW',
          'queue3': 'Dungag na impormasyon',
          'queue4': '27 katao ang naghulat',
          //Has Queue-MA
          'maqueue1': 'YOUR  QUEUE NUMBER',
          'maqueue2': 'SERVING NOW',
          'maqueue3': 'Dungag na impormasyon',
          'maqueue4': '27 katao ang naghulat',
          //QueueInfo
          'queue6': 'No',
          'queue7': 'Queue No.',
          'queue8': 'Balik',
          'queue9': 'Sunod',
          //Cons History
          'conshistory': 'Consultation History',
          'cons1': 'Bulan',
          'cons2': 'Adlaw',
          //Cons History Info
          'conshistory1': 'Impormasyon sa konsulta',
          'cons3': 'Pasyente',
          'cons4': 'Edad sa Pasyente',
          'cons5': 'Kanus-a nangayo',
          'cons6': 'Kanus-a nag sugod ang konsulta',
          'cons7': 'Kanus-a nahuman ang konsulta',
          //Live Chat Info
          'livechat': 'Impormasyon sa konsulta',
          'chat1': 'Pasyente',
          'chat2': 'Edad sa Pasyente',
          'chat3': 'Kanus-a nangayo',
          'chat4': 'Kanus-a nag sugod ang konsulta',
          //MA History
          'mahistory': 'Medical Assistance History',
          'mah1': 'Bulan',
          'mah2': 'Adlaw',
          //MA History Info
          'mahistory1': 'Impormasyon sa Pasyente',
          'mah3': 'Pangalan sa Pasyente',
          'mah4': 'Edad sa Pasyente',
          'mah5': 'Address',
          'mah6': 'Kasarian',
          'mah7': 'Pilia ang uri nimu',
          'mah8': 'Impormasyon sa pagkuha ug MA',
          'mah9': 'Nadawat ni',
          'mah10': 'Botika',
          'mah11': 'Tagpila ang tambal?',
          'mah12': 'Kanus-a nangayo',
          'mah13': 'Kanus-a gikuha ang MA',
          'mah14': 'Tan-awa ang gilakip nga mga Litrato'
        }
      };
}