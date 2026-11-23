// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){ WidgetsFlutterBinding.ensureInitialized(); SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); runApp(const MillionaireApp()); }

const gold=Color(0xFFFFD56A), goldDark=Color(0xFFB98224), navy=Color(0xFF06132F), panel=Color(0xFF102B59), blue=Color(0xFF174A91);
const prizes=[100,200,300,500,1000,2000,4000,8000,16000,32000,64000,125000,250000,500000,1000000];
class Q { final String q; final List<String> a; final int c; const Q(this.q,this.a,this.c); }
const mediumQuestions=[
Q('ما هي عاصمة سوريا؟',['حلب','دمشق','حمص','اللاذقية'],1),
Q('كم عدد ألوان قوس قزح التقليدية؟',['5','6','7','8'],2),
Q('ما هو الكوكب المعروف بالكوكب الأحمر؟',['الزهرة','المريخ','المشتري','عطارد'],1),
Q('ما هو أكبر محيط على الأرض؟',['الأطلسي','الهندي','المتجمد الشمالي','الهادئ'],3),
Q('كم ضلعاً للمثلث؟',['2','3','4','5'],1),
Q('من كتب مسرحية روميو وجولييت؟',['تشارلز ديكنز','ويليام شكسبير','تولستوي','فيكتور هوغو'],1),
Q('ما العنصر الكيميائي الذي رمزه O؟',['الذهب','الأكسجين','الحديد','الهيدروجين'],1),
Q('في أي قارة تقع البرازيل؟',['آسيا','أفريقيا','أمريكا الجنوبية','أوروبا'],2),
Q('ما وحدة قياس شدة التيار الكهربائي؟',['الفولت','الأمبير','الواط','الأوم'],1),
Q('ما اسم العملية التي تصنع بها النباتات غذاءها؟',['التبخر','التنفس','البناء الضوئي','التكاثف'],2),
Q('من العالم المرتبط بقانون الجاذبية الكونية؟',['نيوتن','أينشتاين','غاليليو','فاراداي'],0),
Q('ما المضيق الذي يفصل بين آسيا وأمريكا الشمالية؟',['جبل طارق','البوسفور','بيرينغ','هرمز'],2),
Q('ما أعمق نقطة معروفة في محيطات العالم؟',['خندق ماريانا','خندق بورتوريكو','خندق جاوة','خندق اليابان'],0),
Q('أي عالم وضع المعادلات الأساسية للكهرومغناطيسية؟',['ماكسويل','مندليف','باستور','كبلر'],0),
Q('ما العدد الأولي الوحيد الزوجي؟',['0','1','2','4'],2),
];
const easyQuestions=[
Q('ما لون السماء في يوم صافٍ؟',['أزرق','أخضر','أحمر','أسود'],0),
Q('كم عدد أيام الأسبوع؟',['5','6','7','8'],2),
Q('أي حيوان يُلقب بملك الغابة؟',['الفيل','الأسد','الحصان','الأرنب'],1),
Q('كم عيناً لدى الإنسان عادةً؟',['1','2','3','4'],1),
Q('ما اسم صغير القط؟',['جرو','مهر','هريرة','عجل'],2),
Q('أي فاكهة لونها أصفر غالباً؟',['الموز','الفراولة','العنب الأسود','التوت'],0),
Q('في أي فصل تتساقط أوراق كثير من الأشجار؟',['الصيف','الربيع','الخريف','الشتاء'],2),
Q('كم دقيقة في الساعة؟',['30','45','60','90'],2),
Q('أي وسيلة نقل تطير في السماء؟',['السفينة','الطائرة','الدراجة','القطار'],1),
Q('ما عاصمة سوريا؟',['دمشق','حلب','حمص','طرطوس'],0),
Q('أي حاسة نستخدمها لسماع الأصوات؟',['البصر','الشم','السمع','اللمس'],2),
Q('ما الحيوان الذي يعطينا الحليب؟',['البقرة','النمر','الثعلب','الذئب'],0),
Q('كم عدد أصابع اليد الواحدة؟',['4','5','6','10'],1),
Q('ما الكوكب الذي نعيش عليه؟',['المريخ','الأرض','زحل','الزهرة'],1),
Q('ما النجم الذي يضيء لنا نهاراً؟',['القمر','الشمس','الشعرى','القطب'],1),
];
const hardQuestions=[
Q('ما عاصمة كازاخستان الحالية؟',['ألماتي','أستانا','طشقند','بيشكيك'],1),
Q('ما العنصر الكيميائي الذي عدده الذري 74؟',['التنغستن','الرينيوم','الأوزميوم','التنتالوم'],0),
Q('في أي عام انتهت حرب المئة عام؟',['1453','1492','1415','1517'],0),
Q('من صاحب كتاب «المقدمة»؟',['ابن رشد','ابن خلدون','الفارابي','المسعودي'],1),
Q('ما أكبر أقمار كوكب زحل؟',['أوروبا','غانيميد','تيتان','إنسيلادوس'],2),
Q('ما وحدة قياس المقاومة الكهربائية؟',['الفولت','الأوم','الأمبير','الكولوم'],1),
Q('أي مضيق يصل البحر الأسود ببحر مرمرة؟',['الدردنيل','هرمز','البوسفور','جبل طارق'],2),
Q('من رسم لوحة «مدرسة أثينا»؟',['رافائيل','دافنشي','ميكيلانجيلو','كارافاجيو'],0),
Q('ما الاسم اللاتيني لعنصر الصوديوم في بعض اللغات ورمزه Na؟',['Natrium','Kalium','Argentum','Ferrum'],0),
Q('أي دولة تضم إقليم ترانسلفانيا التاريخي؟',['بلغاريا','رومانيا','المجر','صربيا'],1),
Q('من العالم الذي صاغ مبدأ عدم اليقين؟',['نيلز بور','فيرنر هايزنبرغ','ماكس بلانك','إرفين شرودنغر'],1),
Q('ما أعمق بحيرة في العالم؟',['فيكتوريا','بايكال','سوبيريور','تنغانيقا'],1),
Q('ما اسم المعاهدة التي أنهت حرب الثلاثين عاماً عام 1648؟',['أوترخت','وستفاليا','فرساي','فيينا'],1),
Q('أي رياضي ارتبط بثابت أفوجادرو؟',['أميديو أفوجادرو','جون دالتون','روبرت بويل','أنطوان لافوازييه'],0),
Q('ما اسم أقدم ملحمة أدبية معروفة؟',['الإلياذة','جلجامش','الأوديسة','الإنيادة'],1),
];
const kidsQuestions=[
Q('أي حيوان يقول «مواء»؟',['الكلب','القطة','البقرة','الحصان'],1),
Q('كم عجلة للسيارة العادية؟',['2','3','4','6'],2),
Q('ما لون الموز الناضج غالباً؟',['أزرق','أصفر','بنفسجي','أحمر'],1),
Q('أي طائر لا يستطيع الطيران ويعيش في المناطق الباردة؟',['النسر','البطريق','العصفور','الحمامة'],1),
Q('ماذا نشرب عندما نشعر بالعطش؟',['الرمل','الماء','الزيت','العصير فقط'],1),
Q('كم عدد أرجل العنكبوت؟',['4','6','8','10'],2),
Q('أي كوكب يُعرف بالكوكب الأحمر؟',['الأرض','المريخ','المشتري','نبتون'],1),
Q('ماذا تعطينا النحلة؟',['الحليب','العسل','القطن','الخبز'],1),
Q('أي عضو نستخدمه للتفكير؟',['القلب','الدماغ','المعدة','الركبة'],1),
Q('ما اسم صغير الكلب؟',['جرو','مهر','حمل','كتكوت'],0),
Q('أي من هذه وسائل المحافظة على نظافة الأسنان؟',['تنظيفها بالفرشاة','تركها دون تنظيف','أكل الحلوى دائماً','عدم شرب الماء'],0),
Q('ما الفصل الذي تتفتح فيه أزهار كثيرة؟',['الشتاء','الخريف','الربيع','الصيف'],2),
Q('أي حيوان يُسمى سفينة الصحراء؟',['الحصان','الجمل','الغزال','الدب'],1),
Q('كم عدد ألوان إشارة المرور الأساسية؟',['2','3','4','5'],1),
Q('ما الذي تحتاجه النباتات لتنمو؟',['الماء والضوء','الحجارة فقط','الدخان','البلاستيك'],0),
];
const questionSets={
 'سهل':easyQuestions,
 'متوسط':mediumQuestions,
 'صعب':hardQuestions,
 'الأطفال':kidsQuestions,
};
class MillionaireApp extends StatelessWidget { const MillionaireApp({super.key}); @override Widget build(BuildContext c)=>MaterialApp(title:'المليونير السوري',debugShowCheckedModeBanner:false,theme:ThemeData.dark(useMaterial3:true).copyWith(scaffoldBackgroundColor:navy,colorScheme:const ColorScheme.dark(primary:gold,secondary:gold,surface:panel)),home:const Game()); }

class Game extends StatefulWidget { const Game({super.key}); @override State<Game> createState()=>_GameState(); }
class _GameState extends State<Game> with SingleTickerProviderStateMixin {
 int n=0,seconds=30,safe=0; int? selected,hidden,hiddenSecond; bool locked=false,over=false,fifty=false,audience=false,friend=false,won=false,started=false; String selectedMode='متوسط'; String playerName=''; final TextEditingController nameController=TextEditingController(); Timer? timer;
 List<Q> get questions => questionSets[selectedMode]!;
 List<Q> get qs => questions; late final pulse=AnimationController(vsync:this,duration:const Duration(milliseconds:900))..repeat(reverse:true);
 @override void initState(){super.initState();}
 @override void dispose(){timer?.cancel();nameController.dispose();pulse.dispose();super.dispose();}
 void startClock(){timer?.cancel();seconds=30;timer=Timer.periodic(const Duration(seconds:1),(t){if(!mounted||locked||over){t.cancel();return;}setState(()=>seconds--);if(seconds<=0){t.cancel();finish(false);}});}
 String money(int v)=>v.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'),(m)=>m[1]!+',');
 String amountInWords(int v){
   const words=<int,String>{100:'مئة',200:'مئتا',300:'ثلاثمئة',500:'خمسمئة',1000:'ألف',2000:'ألفان',4000:'أربعة آلاف',8000:'ثمانية آلاف',16000:'ستة عشر ألفاً',32000:'اثنان وثلاثون ألفاً',64000:'أربعة وستون ألفاً',125000:'مئة وخمسة وعشرون ألفاً',250000:'مئتان وخمسون ألفاً',500000:'خمسمئة ألف',1000000:'مليون'};
   return '${words[v]??v.toString()} من نقاط الجائزة';
 }
 Widget prizeCheck(int amount)=>Container(
   width:double.infinity,padding:const EdgeInsets.all(16),
   decoration:BoxDecoration(color:const Color(0xFFF8F1DA),borderRadius:BorderRadius.circular(14),border:Border.all(color:goldDark,width:2)),
   child:Column(mainAxisSize:MainAxisSize.min,children:[
     const Icon(Icons.workspace_premium,color:goldDark,size:38),
     const Text('شيك جائزة — المليونير السوري',textAlign:TextAlign.center,style:TextStyle(color:navy,fontWeight:FontWeight.w900,fontSize:17)),
     const Divider(color:goldDark),
     Text('يُمنح إلى: ${playerName.isEmpty?'اللاعب':playerName}',textAlign:TextAlign.center,style:const TextStyle(color:navy,fontWeight:FontWeight.bold,fontSize:16)),
     const SizedBox(height:10),
     Text(money(amount),style:const TextStyle(color:Color(0xFF9A6A16),fontWeight:FontWeight.w900,fontSize:28)),
     Text(amountInWords(amount),textAlign:TextAlign.center,style:const TextStyle(color:navy,fontSize:14)),
     const SizedBox(height:8),
     const Text('مع أطيب التهاني والفوز المستحق',style:TextStyle(color:navy,fontStyle:FontStyle.italic)),
     const Divider(color:goldDark),
     const Text('إدارة المسابقة',style:TextStyle(color:navy,fontWeight:FontWeight.bold))
   ])
 );
 void choose(int i){if(locked||over||(hidden==i || hiddenSecond==i))return;setState(()=>selected=i);HapticFeedback.selectionClick();}
 Future<void> confirm() async {if(selected==null||locked)return;timer?.cancel();setState(()=>locked=true);await Future.delayed(const Duration(milliseconds:850));if(!mounted)return;if(selected==questions[n].c){if(n==4||n==9)safe=prizes[n];if(n==14){finish(true);return;}setState(()=>n++);selected=null;hidden=null;hiddenSecond=null;locked=false;startClock();}else{finish(false);}}
 void finish(bool win){timer?.cancel();setState((){over=true;won=win;locked=true;});showDialog(context:context,barrierDismissible:false,builder:(d)=>AlertDialog(backgroundColor:panel,title:Text(win?'مبروك! ربحت المليون':'انتهت المسابقة'),content:Column(mainAxisSize:MainAxisSize.min,children:[Text(win?'أصبحت مليونيراً سورياً!':'الجائزة المضمونة: '+money(safe)),const SizedBox(height:12),prizeCheck(win?1000000:safe)]),actions:[FilledButton(onPressed:(){Navigator.pop(d);restart();},child:const Text('العب من جديد'))]));}
 void cashOut(){if(over)return;timer?.cancel();setState((){over=true;locked=true;won=false;});showDialog(context:context,barrierDismissible:false,builder:(d)=>AlertDialog(backgroundColor:panel,title:const Text('انسحبت من المسابقة'),content:Column(mainAxisSize:MainAxisSize.min,children:[Text('مبروك! ربحت الجائزة المضمونة: '+money(safe)),const SizedBox(height:12),prizeCheck(safe)]),actions:[FilledButton(onPressed:(){Navigator.pop(d);restart();},child:const Text('العب من جديد'))]));}
 void restart(){timer?.cancel();setState((){n=0;selected=null;hidden=null;hiddenSecond=null;safe=0;locked=false;over=false;fifty=false;audience=false;friend=false;won=false;started=false;});}
 void startGame(String mode){final entered=nameController.text.trim();if(entered.isEmpty){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('اكتب اسم اللاعب أولاً')));return;}setState((){playerName=entered;selectedMode=mode;n=0;selected=null;hidden=null;hiddenSecond=null;safe=0;locked=false;over=false;fifty=false;audience=false;friend=false;won=false;started=true;});startClock();}
 Widget modeSelection() {
    final modes = <(String, String, IconData)>[
      ('سهل', 'بداية ممتعة وأسئلة مباشرة', Icons.sentiment_satisfied_alt),
      ('متوسط', 'معلومات عامة وتحدٍ متوازن', Icons.lightbulb_outline),
      ('صعب', 'اختبر معلوماتك بأقوى الأسئلة', Icons.workspace_premium),
      ('الأطفال', 'أسئلة لطيفة وممتعة للصغار', Icons.child_care),
    ];
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Positioned.fill(child: CustomPaint(painter: StagePainter())),
          Center(child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.stars_rounded, color: gold, size: 54),
              const SizedBox(height: 8),
              const Text('المليونير السوري', style: TextStyle(color: gold, fontSize: 27, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              const Text('اختر مستوى التحدي', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              ...modes.map((m) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => startGame(m.$1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF1B4787), Color(0xFF091B3B)]),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: goldDark, width: 1.4),
                    ),
                    child: Row(children: [
                      Icon(m.$3, color: gold, size: 31),
                      const SizedBox(width: 15),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(m.$1, style: const TextStyle(color: gold, fontSize: 19, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 4),
                        Text(m.$2, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                      ])),
                      const Icon(Icons.arrow_back_ios_new, color: gold, size: 18),
                    ]),
                  ),
                ),
              )),
              const SizedBox(height: 10),
              const Text('15 سؤالاً • ثلاث وسائل مساعدة • الجائزة الكبرى مليون', textAlign: TextAlign.center, style: TextStyle(color: Colors.white54, fontSize: 12)),
            ]),
          )),
        ]),
      ),
    );
  }

  void useFifty() {
    if (fifty || locked) return;
    final wrong = List<int>.generate(4, (i) => i).where((i) => i != qs[n].c).toList()..shuffle();
    setState(() { fifty = true; hidden = wrong[0]; hiddenSecond = wrong[1]; });
  }

  void useAudience() {
    if (audience || locked) return;
    setState(() => audience = true);
    final random = math.Random();
    final vals = List<int>.filled(4, 0);
    final correct = 65 + random.nextInt(16);
    final wrong = <int>[for (var i = 0; i < 4; i++) if (i != qs[n].c) i]..shuffle();
    final remaining = 100 - correct;
    final first = random.nextInt(remaining + 1);
    final second = random.nextInt(remaining - first + 1);
    vals[qs[n].c] = correct;
    vals[wrong[0]] = first;
    vals[wrong[1]] = second;
    vals[wrong[2]] = remaining - first - second;
    showDialog(context: context, builder: (d) => AlertDialog(
      backgroundColor: panel,
      title: const Text('تصويت الجمهور'),
      content: Column(mainAxisSize: MainAxisSize.min, children: List.generate(4, (i) => Padding(
        padding: const EdgeInsets.all(5),
        child: Row(children: [
          Text(String.fromCharCode(65 + i)),
          const SizedBox(width: 8),
          Expanded(child: LinearProgressIndicator(value: vals[i] / 100, minHeight: 10, color: gold, backgroundColor: navy)),
          Text(' ${vals[i]}%'),
        ]),
      ))),
      actions: [TextButton(onPressed: () => Navigator.pop(d), child: const Text('إغلاق'))],
    ));
  }

  void useFriend() {
    if (friend || locked) return;
    setState(() => friend = true);
    final correct = qs[n].c;
    final guess = math.Random().nextInt(100) < 78 ? correct : (correct + 1 + math.Random().nextInt(3)) % 4;
    showDialog(context: context, builder: (d) => AlertDialog(
      backgroundColor: panel,
      title: const Text('الاتصال بصديق'),
      content: Text('أعتقد أن الإجابة هي ${String.fromCharCode(65 + guess)} — ${qs[n].a[guess]}'),
      actions: [TextButton(onPressed: () => Navigator.pop(d), child: const Text('شكراً'))],
    ));
  }

  Color answerColor(int i) {
    if (locked && i == qs[n].c) return Colors.green.shade800;
    if (locked && selected == i) return Colors.red.shade900;
    if (selected == i) return const Color(0xFF8C611D);
    return const Color(0xFF12366E);
  }

@override
 Widget build(BuildContext context) {
   if(!started)return modeSelection();
   return Scaffold(
     body: SafeArea(
       child: Stack(
         children: [
           Positioned.fill(child: CustomPaint(painter: StagePainter())),
           Column(
             children: [
               Padding(
                 padding: const EdgeInsets.fromLTRB(14, 2, 8, 0),
                 child: Row(
                   children: [
                     const Icon(Icons.stars, color: gold),
                     const SizedBox(width: 8),
                     const Expanded(child: Text('المليونير السوري', style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 18))),
                     IconButton(
                       onPressed: () => showDialog(context: context, builder: (d) => AlertDialog(
                         backgroundColor: panel,
                         title: const Text('سُلّم الجوائز'),
                         content: SizedBox(width: double.maxFinite, height: 360, child: ListView.builder(
                           reverse: true,
                           itemCount: prizes.length,
                           itemBuilder: (c, i) => ListTile(
                             dense: true,
                             title: Text((i + 1).toString() + '. ' + money(prizes[i]), textAlign: TextAlign.end,
                               style: TextStyle(color: i == n ? gold : (i == 4 || i == 9 ? gold : Colors.white70))),
                           ),
                         )),
                         actions: [TextButton(onPressed: () => Navigator.pop(d), child: const Text('إغلاق'))],
                       )),
                       icon: const Icon(Icons.military_tech, color: gold),
                     ),
                     IconButton(
                       onPressed: () => showDialog(context: context, builder: (d) => AlertDialog(
                         backgroundColor: panel,
                         title: const Text('قواعد اللعبة'),
                         content: Text('النمط: $selectedMode. 15 سؤالاً متدرجاً، 30 ثانية لكل سؤال، وثلاث وسائل مساعدة. يمكنك الانسحاب في أي وقت.'),
                         actions: [TextButton(onPressed: () => Navigator.pop(d), child: const Text('حسناً'))],
                       )),
                       icon: const Icon(Icons.help_outline, color: gold),
                     ),
                   ],
                 ),
               ),
               const SizedBox(height: 2),
               AnimatedBuilder(
                 animation: pulse,
                 builder: (c, w) => Transform.scale(scale: 1 + pulse.value * .025, child: w),
                 child: Container(
                   width: 62, height: 62,
                   decoration: const BoxDecoration(shape: BoxShape.circle,
                     gradient: RadialGradient(colors: [Color(0xFFFFE9B0), Color(0xFFB98224)]),
                     boxShadow: [BoxShadow(color: Color(0x667F5A1D), blurRadius: 18)]),
                   child: const Icon(Icons.workspace_premium, color: navy, size: 40),
                 ),
               ),
               Text('اللاعب: $playerName  •  طريقك إلى المليون • نمط $selectedMode', textAlign:TextAlign.center, style: const TextStyle(color: gold, fontWeight: FontWeight.bold)),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                 child: Row(children: [
                   life('50:50', fifty, useFifty),
                   const SizedBox(width: 7),
                   life('الجمهور', audience, useAudience),
                   const SizedBox(width: 7),
                   life('صديق', friend, useFriend),
                 ]),
               ),
               Container(
                 width: 54, height: 54, alignment: Alignment.center,
                 decoration: BoxDecoration(shape: BoxShape.circle, color: panel,
                   border: Border.all(color: seconds <= 8 ? Colors.red : gold, width: 3)),
                 child: Text(seconds.toString(), style: TextStyle(color: seconds <= 8 ? Colors.red : gold, fontWeight: FontWeight.w900, fontSize: 23)),
               ),
               const SizedBox(height: 9),
               Container(
                 margin: const EdgeInsets.symmetric(horizontal: 14),
                 padding: const EdgeInsets.all(14),
                 decoration: BoxDecoration(
                   gradient: const LinearGradient(colors: [Color(0xFF1B4787), Color(0xFF091B3B)]),
                   borderRadius: BorderRadius.circular(17), border: Border.all(color: goldDark, width: 1.4)),
                 child: Column(children: [
                   Text('السؤال ' + (n + 1).toString() + ' من 15', style: const TextStyle(color: gold, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 8),
                   Text(qs[n].q, textAlign: TextAlign.center,
                     style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold)),
                 ]),
               ),
               const SizedBox(height: 10),
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 14),
                   child: Column(
                     children: List.generate(4, (i) => Expanded(
                       child: Padding(
                         padding: const EdgeInsets.only(bottom: 7),
                         child: InkWell(
                           borderRadius: BorderRadius.circular(14),
                           onTap: () => choose(i),
                           child: AnimatedContainer(
                             duration: const Duration(milliseconds: 180),
                             width: double.infinity,
                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                             decoration: BoxDecoration(
                               color: (hidden == i || hiddenSecond == i) ? Colors.transparent : answerColor(i),
                               borderRadius: BorderRadius.circular(14),
                               border: Border.all(color: selected == i ? gold : goldDark, width: selected == i ? 2 : 1)),
                             child: Row(children: [
                               CircleAvatar(radius: 15, backgroundColor: gold.withOpacity(.15),
                                 child: Text(String.fromCharCode(65 + i), style: const TextStyle(color: gold, fontWeight: FontWeight.bold))),
                               const SizedBox(width: 12),
                               Expanded(child: Text((hidden == i || hiddenSecond == i) ? '' : qs[n].a[i],
                                 textAlign: TextAlign.center,
                                 style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600))),
                               const SizedBox(width: 27),
                             ]),
                           ),
                         ),
                       ),
                     )),
                   ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
                 child: Row(children: [
                   Expanded(child: OutlinedButton.icon(
                     onPressed: cashOut,
                     icon: const Icon(Icons.flag_outlined),
                     label: const Text('انسحاب'),
                     style: OutlinedButton.styleFrom(foregroundColor: gold, side: const BorderSide(color: goldDark), padding: const EdgeInsets.symmetric(vertical: 12)),
                   )),
                   const SizedBox(width: 10),
                   Expanded(flex: 2, child: FilledButton.icon(
                     onPressed: selected == null || locked ? null : confirm,
                     icon: const Icon(Icons.check_circle_outline),
                     label: const Text('تأكيد الإجابة'),
                     style: FilledButton.styleFrom(backgroundColor: goldDark, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 12)),
                   )),
                 ]),
               ),
             ],
           ),
         ],
       ),
     ),
   );
 }

 Widget life(String text, bool used, VoidCallback action) => Expanded(
   child: OutlinedButton(
     onPressed: used || locked ? null : action,
     style: OutlinedButton.styleFrom(foregroundColor: used ? Colors.white30 : gold,
       side: BorderSide(color: used ? Colors.white12 : goldDark),
       padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4)),
     child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
   ),
 );
}
class StagePainter extends CustomPainter { @override void paint(Canvas canvas,Size size){final p=Paint()..shader=const LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[Color(0xFF12356C),Color(0xFF06132F),Color(0xFF020817)]).createShader(Offset.zero&size);canvas.drawRect(Offset.zero&size,p);p..shader=null..style=PaintingStyle.stroke..strokeWidth=1..color=gold.withOpacity(.08);for(var i=0;i<5;i++){final x=size.width*(.1+i*.2);canvas.drawLine(Offset(size.width/2,0),Offset(x,size.height*.45),p);}p..style=PaintingStyle.fill..color=Colors.black.withOpacity(.6);canvas.drawOval(Rect.fromCenter(center:Offset(size.width/2,size.height),width:size.width*1.4,height:size.height*.2),p);} @override bool shouldRepaint(covariant CustomPainter oldDelegate)=>false; }
