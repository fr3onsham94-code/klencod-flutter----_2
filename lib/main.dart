// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){ WidgetsFlutterBinding.ensureInitialized(); SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); runApp(const MillionaireApp()); }

const gold=Color(0xFFFFD56A), goldDark=Color(0xFFB98224), navy=Color(0xFF06132F), panel=Color(0xFF102B59), blue=Color(0xFF174A91);
const prizes=[100,200,300,500,1000,2000,4000,8000,16000,32000,64000,125000,250000,500000,1000000];
class Q { final String q; final List<String> a; final int c; const Q(this.q,this.a,this.c); }
const qs=[
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
class MillionaireApp extends StatelessWidget { const MillionaireApp({super.key}); @override Widget build(BuildContext c)=>MaterialApp(title:'المليونير السوري',debugShowCheckedModeBanner:false,theme:ThemeData.dark(useMaterial3:true).copyWith(scaffoldBackgroundColor:navy,colorScheme:const ColorScheme.dark(primary:gold,secondary:gold,surface:panel)),home:const Game()); }

class Game extends StatefulWidget { const Game({super.key}); @override State<Game> createState()=>_GameState(); }
class _GameState extends State<Game> with SingleTickerProviderStateMixin {
 int n=0,seconds=30,safe=0; int? selected,hidden,hiddenSecond; bool locked=false,over=false,fifty=false,audience=false,friend=false,won=false; Timer? timer; late final pulse=AnimationController(vsync:this,duration:const Duration(milliseconds:900))..repeat(reverse:true);
 @override void initState(){super.initState();startClock();}
 @override void dispose(){timer?.cancel();pulse.dispose();super.dispose();}
 void startClock(){timer?.cancel();seconds=30;timer=Timer.periodic(const Duration(seconds:1),(t){if(!mounted||locked||over){t.cancel();return;}setState(()=>seconds--);if(seconds<=0){t.cancel();finish(false);}});}
 String money(int v)=>v.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'),(m)=>m[1]!+',');
 void choose(int i){if(locked||over||(hidden==i || hiddenSecond==i))return;setState(()=>selected=i);HapticFeedback.selectionClick();}
 Future<void> confirm() async {if(selected==null||locked)return;timer?.cancel();setState(()=>locked=true);await Future.delayed(const Duration(milliseconds:850));if(!mounted)return;if(selected==qs[n].c){if(n==4||n==9)safe=prizes[n];if(n==14){finish(true);return;}setState(()=>n++);selected=null;hidden=null;hiddenSecond=null;locked=false;startClock();}else{finish(false);}}
 void finish(bool win){timer?.cancel();setState((){over=true;won=win;locked=true;});showDialog(context:context,barrierDismissible:false,builder:(d)=>AlertDialog(backgroundColor:panel,title:Text(win?'مبروك! ربحت المليون':'انتهت المسابقة'),content:Text(win?'أصبحت مليونيراً سورياً!':'الجائزة المضمونة: '+money(safe)),actions:[FilledButton(onPressed:(){Navigator.pop(d);restart();},child:const Text('العب من جديد'))]));}
 void cashOut(){timer?.cancel();setState((){over=true;locked=true;won=false;});showDialog(context:context,barrierDismissible:false,builder:(d)=>AlertDialog(backgroundColor:panel,title:const Text('انسحبت من المسابقة'),content:Text('مبروك! ربحت الجائزة المضمونة: '+money(n>0?prizes[n-1]:0)),actions:[FilledButton(onPressed:(){Navigator.pop(d);restart();},child:const Text('العب من جديد'))]));}
 void restart(){setState((){n=0;selected=null;hidden=null;hiddenSecond=null;safe=0;locked=false;over=false;fifty=false;audience=false;friend=false;won=false;});startClock();}
 void useFifty(){if(fifty||locked)return;final wrong=List.generate(4,(i)=>i).where((i)=>i!=qs[n].c).toList()..shuffle();setState((){fifty=true;hidden=wrong.take(2).first; hiddenSecond=wrong[1];});}
 void useAudience(){if(audience||locked)return;setState(()=>audience=true);final r=math.Random();final vals=List<int>.filled(4,0);final correct=65+r.nextInt(16);final wrong=[for(var i=0;i<4;i++) if(i!=qs[n].c)i]..shuffle();final remaining=100-correct;final first= r.nextInt(remaining+1);final second=r.nextInt(remaining-first+1);vals[qs[n].c]=correct;vals[wrong[0]]=first;vals[wrong[1]]=second;vals[wrong[2]]=remaining-first-second;showDialog(context:context,builder:(d)=>AlertDialog(backgroundColor:panel,title:const Text('تصويت الجمهور'),content:Column(mainAxisSize:MainAxisSize.min,children:List.generate(4,(i)=>Padding(padding:const EdgeInsets.all(5),child:Row(children:[Text(String.fromCharCode(65+i)),const SizedBox(width:8),Expanded(child:LinearProgressIndicator(value:vals[i]/100,minHeight:10,color:gold,backgroundColor:navy)),Text(' '+vals[i].toString()+'%')])))),actions:[TextButton(onPressed:()=>Navigator.pop(d),child:const Text('إغلاق'))]));}
 void useFriend(){if(friend||locked)return;setState(()=>friend=true);final c=qs[n].c;final g=math.Random().nextInt(100)<78?c:(c+1+math.Random().nextInt(3))%4;showDialog(context:context,builder:(d)=>AlertDialog(backgroundColor:panel,title:const Text('الاتصال بصديق'),content:Text('أعتقد أن الإجابة هي '+String.fromCharCode(65+g)+' — '+qs[n].a[g]),actions:[TextButton(onPressed:()=>Navigator.pop(d),child:const Text('شكراً'))]));}
 Color answerColor(int i){if(locked&&i==qs[n].c)return Colors.green.shade800;if(locked&&selected==i)return Colors.red.shade900;if(selected==i)return const Color(0xFF8C611D);return const Color(0xFF12366E);}
 @override
 Widget build(BuildContext context) {
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
                         content: const Text('15 سؤالاً متدرجاً، 30 ثانية لكل سؤال، وثلاث وسائل مساعدة. يمكنك الانسحاب في أي وقت.'),
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
               const Text('طريقك إلى المليون', style: TextStyle(color: gold, fontWeight: FontWeight.bold)),
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
