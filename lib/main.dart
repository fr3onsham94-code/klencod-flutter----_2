// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){ WidgetsFlutterBinding.ensureInitialized(); SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]); runApp(const MillionaireApp()); }

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
const String presentersImageBase64 = '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';

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
 Widget presenterScene() => ClipRRect(
   borderRadius: BorderRadius.circular(12),
   child: Stack(
     children: [
       Image.memory(base64Decode(presentersImageBase64), width: double.infinity, height: 150, fit: BoxFit.cover),
       Positioned(
         left: 0, right: 0, bottom: 0,
         child: Container(
           padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
           color: navy.withOpacity(.82),
           child: const Text('مقدّما المليونير السوري', textAlign: TextAlign.center,
             style: TextStyle(color: gold, fontWeight: FontWeight.w900)),
         ),
       ),
     ],
   ),
 );
 void finish(bool win){timer?.cancel();setState((){over=true;won=win;locked=true;});showDialog(context:context,barrierDismissible:false,builder:(d)=>AlertDialog(backgroundColor:panel,title:Text(win?'مبروك! ربحت المليون':'انتهت المسابقة'),content:SingleChildScrollView(child:Column(mainAxisSize:MainAxisSize.min,children:[presenterScene(),const SizedBox(height:12),Text(win?'أصبحت مليونيراً سورياً!':'الجائزة المضمونة: '+money(safe)),const SizedBox(height:12),prizeCheck(win?1000000:safe)])),actions:[FilledButton(onPressed:(){Navigator.pop(d);restart();},child:const Text('العب من جديد'))]));}
 void cashOut(){if(over)return;timer?.cancel();setState((){over=true;locked=true;won=false;});showDialog(context:context,barrierDismissible:false,builder:(d)=>AlertDialog(backgroundColor:panel,title:const Text('انسحبت من المسابقة'),content:SingleChildScrollView(child:Column(mainAxisSize:MainAxisSize.min,children:[presenterScene(),const SizedBox(height:12),Text('مبروك! ربحت الجائزة المضمونة: '+money(safe)),const SizedBox(height:12),prizeCheck(safe)])),actions:[FilledButton(onPressed:(){Navigator.pop(d);restart();},child:const Text('العب من جديد'))]));}
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
              const SizedBox(height: 18),
              TextField(
                controller: nameController,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'اكتب اسم اللاعب',
                  filled: true,
                  fillColor: panel,
                  prefixIcon: const Icon(Icons.person, color: gold),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: goldDark)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: gold, width: 2)),
                ),
              ),
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

 Widget studioBanner(double h)=>ClipRRect(borderRadius:BorderRadius.circular(16),child:SizedBox(height:h,width:double.infinity,child:Stack(fit:StackFit.expand,children:[
 Image.memory(base64Decode(presentersImageBase64),fit:BoxFit.cover),
 DecoratedBox(decoration:BoxDecoration(gradient:LinearGradient(begin:Alignment.topCenter,end:Alignment.bottomCenter,colors:[Colors.transparent,navy.withOpacity(.9)]))),
 Positioned(right:12,left:12,bottom:8,child:Column(crossAxisAlignment:CrossAxisAlignment.end,children:[
 const Text('المليونير السوري',style:TextStyle(color:gold,fontSize:19,fontWeight:FontWeight.w900)),
 Text('مع $playerName  •  نمط $selectedMode',style:const TextStyle(color:Colors.white,fontWeight:FontWeight.w600))]))])));
 Widget timerBadge(double z)=>Container(width:z,height:z,alignment:Alignment.center,decoration:BoxDecoration(shape:BoxShape.circle,
 gradient:const RadialGradient(colors:[Color(0xFF173F76),navy]),border:Border.all(color:seconds<=8?Colors.redAccent:gold,width:3),
 boxShadow:const [BoxShadow(color:Color(0x557F5A1D),blurRadius:12)]),
 child:Text('$seconds',style:TextStyle(color:seconds<=8?Colors.redAccent:gold,fontWeight:FontWeight.w900,fontSize:z*.38)));
 Widget prizeRail({bool compact=false})=>Container(width:compact?108:null,padding:const EdgeInsets.all(7),
 decoration:BoxDecoration(color:const Color(0xCC081A38),borderRadius:BorderRadius.circular(13),border:Border.all(color:goldDark)),
 child:Column(mainAxisSize:MainAxisSize.min,children:[const Text('سُلّم الجوائز',style:TextStyle(color:gold,fontWeight:FontWeight.w900,fontSize:12)),
 ...List.generate(prizes.length,(i){final k=prizes.length-1-i;final active=k==n,safePoint=k==4||k==9;
 return Container(margin:const EdgeInsets.symmetric(vertical:1),padding:const EdgeInsets.symmetric(horizontal:4,vertical:2),
 decoration:BoxDecoration(color:active?gold.withOpacity(.2):Colors.transparent,borderRadius:BorderRadius.circular(4),border:active?Border.all(color:gold):null),
 child:Row(children:[if(safePoint)const Icon(Icons.shield_moon,color:gold,size:10),Expanded(child:Text(money(prizes[k]),textAlign:TextAlign.end,
 style:TextStyle(color:active||safePoint?gold:Colors.white54,fontWeight:active||safePoint?FontWeight.w900:FontWeight.normal,fontSize:compact?9:11)))]));})]));
 Widget questionCard({bool compact=false})=>Container(padding:EdgeInsets.all(compact?10:14),
 decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF1B4787),Color(0xFF091B3B)]),borderRadius:BorderRadius.circular(17),
 border:Border.all(color:goldDark,width:1.5),boxShadow:const [BoxShadow(color:Color(0x55000000),blurRadius:12,offset:Offset(0,4))]),
 child:Column(children:[Text('السؤال \${n+1} من 15',style:const TextStyle(color:gold,fontWeight:FontWeight.w900)),const SizedBox(height:6),
 Text(qs[n].q,textAlign:TextAlign.center,style:TextStyle(color:Colors.white,fontSize:compact?16:19,fontWeight:FontWeight.w800))]));
 Widget answerButton(int i,{bool compact=false})=>InkWell(borderRadius:BorderRadius.circular(12),onTap:()=>choose(i),
 child:AnimatedContainer(duration:const Duration(milliseconds:180),padding:EdgeInsets.symmetric(horizontal:10,vertical:compact?6:10),
 decoration:BoxDecoration(gradient:LinearGradient(colors:[(hidden==i||hiddenSecond==i)?navy:answerColor(i),const Color(0xFF071A37)]),
 borderRadius:BorderRadius.circular(12),border:Border.all(color:selected==i?gold:goldDark,width:selected==i?2:1)),
 child:Row(children:[CircleAvatar(radius:compact?12:15,backgroundColor:gold.withOpacity(.16),child:Text(String.fromCharCode(65+i),
 style:TextStyle(color:gold,fontWeight:FontWeight.w900,fontSize:compact?11:13))),const SizedBox(width:10),
 Expanded(child:Text((hidden==i||hiddenSecond==i)?'':qs[n].a[i],textAlign:TextAlign.center,
 style:TextStyle(color:Colors.white,fontSize:compact?13:15,fontWeight:FontWeight.w600))),const SizedBox(width:8)])));
 Widget lifelines({bool vertical=false})=>vertical?Column(children:[life('50:50',fifty,useFifty),life('الجمهور',audience,useAudience),life('صديق',friend,useFriend)])
 :Row(children:[Expanded(child:life('50:50',fifty,useFifty)),const SizedBox(width:6),Expanded(child:life('الجمهور',audience,useAudience)),
 const SizedBox(width:6),Expanded(child:life('صديق',friend,useFriend))]);
 Widget actionsRow({bool compact=false})=>Row(children:[
 Expanded(child:OutlinedButton.icon(onPressed:cashOut,icon:const Icon(Icons.flag_outlined,size:18),label:const Text('انسحاب'),
 style:OutlinedButton.styleFrom(foregroundColor:gold,side:const BorderSide(color:goldDark),padding:EdgeInsets.symmetric(vertical:compact?6:10)))),
 const SizedBox(width:8),Expanded(flex:2,child:FilledButton.icon(onPressed:selected==null||locked?null:confirm,icon:const Icon(Icons.check_circle_outline,size:18),
 label:const Text('تأكيد الإجابة'),style:FilledButton.styleFrom(backgroundColor:goldDark,foregroundColor:Colors.white,padding:EdgeInsets.symmetric(vertical:compact?6:10))))]);
 @override Widget build(BuildContext context){
 if(!started)return modeSelection();
 return Scaffold(body:SafeArea(child:LayoutBuilder(builder:(context,c){final landscape=c.maxWidth>c.maxHeight;
 return Stack(children:[Positioned.fill(child:CustomPaint(painter:StagePainter())),
 if(landscape)Padding(padding:const EdgeInsets.all(9),child:Row(children:[
 SizedBox(width:112,child:Column(children:[timerBadge(56),const SizedBox(height:9),Expanded(child:lifelines(vertical:true))])),
 const SizedBox(width:8),Expanded(child:Column(children:[SizedBox(height:82,child:studioBanner(82)),
 Align(alignment:Alignment.centerRight,child:Text('اللاعب: $playerName',style:const TextStyle(color:gold,fontSize:12,fontWeight:FontWeight.bold))),
 questionCard(compact:true),const SizedBox(height:5),
 Expanded(child:Column(children:List.generate(4,(i)=>Expanded(child:Padding(padding:const EdgeInsets.only(bottom:4),child:answerButton(i,compact:true)))))),
 actionsRow(compact:true)])),const SizedBox(width:8),SizedBox(width:108,child:prizeRail(compact:true))]))
 else Padding(padding:const EdgeInsets.fromLTRB(11,7,11,8),child:Column(children:[
 studioBanner(112),Row(children:[Expanded(child:Text('اللاعب: $playerName  •  $selectedMode',style:const TextStyle(color:gold,fontSize:12,fontWeight:FontWeight.w800))),
 timerBadge(46),IconButton(onPressed:()=>showRules(context),icon:const Icon(Icons.help_outline,color:gold))]),
 lifelines(),const SizedBox(height:6),questionCard(),const SizedBox(height:7),
 Expanded(child:Column(children:List.generate(4,(i)=>Expanded(child:Padding(padding:const EdgeInsets.only(bottom:6),child:answerButton(i)))))),
 Row(children:[const Text('سُلّم الجوائز',style:TextStyle(color:gold,fontSize:11,fontWeight:FontWeight.bold)),const SizedBox(width:8),
 Expanded(child:Text(prizes.map(money).join('  •  '),maxLines:1,overflow:TextOverflow.fade,softWrap:false,style:const TextStyle(color:Colors.white54,fontSize:9))),
 IconButton(constraints:const BoxConstraints.tightFor(width:28,height:26),padding:EdgeInsets.zero,
 onPressed:()=>showDialog(context:context,builder:(d)=>AlertDialog(backgroundColor:panel,title:const Text('سُلّم الجوائز'),
 content:SizedBox(width:double.maxFinite,height:360,child:prizeRail()),actions:[TextButton(onPressed:()=>Navigator.pop(d),child:const Text('إغلاق'))])),
 icon:const Icon(Icons.list_alt,color:gold,size:19))]),actionsRow()]))]);})));
 }
 void showRules(BuildContext context)=>showDialog(context:context,builder:(d)=>AlertDialog(backgroundColor:panel,title:const Text('قواعد اللعبة'),
 content:Text('النمط: $selectedMode. 15 سؤالاً متدرجاً، 30 ثانية لكل سؤال، وثلاث وسائل مساعدة. يمكنك الانسحاب في أي وقت.'),
 actions:[TextButton(onPressed:()=>Navigator.pop(d),child:const Text('حسناً'))]));
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
