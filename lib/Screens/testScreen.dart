//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:todo/cubit/cubit.dart';
// import 'package:todo/cubit/states.dart';
//
// class Tests extends StatelessWidget {
//   const Tests({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//           BlocProvider(
//             create: (BuildContext context) { return CounterCubit(); },
//             child: BlocConsumer<CounterCubit,CounterStates >(
//               listener: (context, state) {},
//               builder: (context,state){return Scaffold(
//                 body: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       MaterialButton(
//                           onPressed: () {
//                             CounterCubit.get(context).plus();
//                           },
//                           child: const Text('Plus')),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text("${CounterCubit.get(context).counter}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 50),),
//                       ),
//                       MaterialButton(
//                         onPressed: (){
//
//                           CounterCubit.get(context).minus();
//
//                         },
//                         child: const Text('Minus'),)
//                     ],
//                   ),
//                 ),
//
//               );},
//             ),
//           );
//   }
// }
//
// class Models extends ChangeNotifier{
//   String? name;
//   getname(){
//       name = "My name is Ahmed";
//       notifyListeners() ;
//       }
//
//
//
// }
