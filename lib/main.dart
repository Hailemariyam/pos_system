// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart'; // Import HydratedBloc
// import 'package:pos_sales_app/bloc/cartcubit.dart';
// import 'package:pos_sales_app/models/product_model.dart';
// import 'package:pos_sales_app/presentation/pages/home_page.dart';
// import 'package:pos_sales_app/presentation/product_list.dart';
// import 'package:pos_sales_app/services/product_service.dart';
// import 'package:path_provider/path_provider.dart'; // Import path_provider for storage location

// void main() async {
//   // Initialize Hive and the required services
// await Hive.initFlutter();

// Hive.registerAdapter(ProductAdapter());
// await Hive.openBox<Product>('productBox');
// await ProductService.loadProducts(); // Load initial products from JSON

//   // Initialize HydratedStorage before using any HydratedBloc
//   final storage = await HydratedStorage.build(
//     storageDirectory: await getApplicationDocumentsDirectory(),
//   );

//   // Ensure that HydratedBloc is available to your app
//   runApp(MyApp(storage: storage));
// }

// class MyApp extends StatelessWidget {
//   final HydratedStorage storage;

//   const MyApp({Key? key, required this.storage}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CartCubit(),
//       child: MaterialApp(
//         title: 'POS System',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         // Use HomePage as the starting point for the app (responsive navigation)
//         home: HomePage(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:pos_sales_app/bloc/cartcubit.dart';
import 'package:pos_sales_app/models/product_model.dart';
import 'package:pos_sales_app/presentation/cashier_dashboard.dart';
import 'package:pos_sales_app/presentation/pages/home_page.dart';
import 'package:pos_sales_app/presentation/product_list.dart';
import 'package:pos_sales_app/presentation/screens/login.dart';
import 'package:pos_sales_app/services/product_service.dart';

import 'bloc/cubit_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize HydratedStorage
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBloc.storage = storage;

  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('productBox');
  await ProductService.loadProducts();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (_) => NavigationCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (_) => CartCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'POS Sales App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          breakpoints: [
            ResponsiveBreakpoint.resize(350, name: MOBILE),
            ResponsiveBreakpoint.resize(600, name: TABLET),
            ResponsiveBreakpoint.resize(800, name: DESKTOP),
          ],
          defaultScale: true,
          background: Container(color: Colors.white),
        ),
        home: CashierDashboard(),
        routes: {
          '/sales': (context) => ProductListScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(child: Text('404 - Page Not Found')),
            ),
          );
        },
      ),
    );
  }
}
