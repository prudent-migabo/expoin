import 'package:expoin/models/models.dart';
import 'package:expoin/providers/providers.dart';
import 'package:expoin/repository/repositories.dart';
import 'package:expoin/screens/home_screen/components/components.dart';
import 'package:expoin/screens/screens.dart';
import 'package:expoin/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/utils.dart';

class HomeComponents extends StatelessWidget {
  const HomeComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uri youtube_url =
        Uri.parse("https://www.youtube.com/channel/UCBZdE8LkkGK2kcNpOPlJU9w");
    final Uri facebook_url =
        Uri.parse("https://www.facebook.com/profile.php?id=100083265342696");
    final Uri whatsapp_url = Uri.parse("https://wa.me/message/X4KA5THVWWRMO1");
    final Uri telegram_url = Uri.parse("https://t.me/mespieces");
    var width = MediaQuery.of(context).size.width;
    final primary = Theme.of(context).colorScheme.primary;
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 30,
          ),
        ),
        const SliverToBoxAdapter(
          child: AdvertisingContainer(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 25,
          ),
        ),
        const SliverToBoxAdapter(
          child: CryptoAvailableListView(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 1.5,
          children: [
            HomeMenu(
              color: const Color(0xfffff0b4),
              icon: const Icon(FontAwesomeIcons.rightLeft),
              text: 'Transactions',
              onPressed: () {
                Navigator.pushNamed(context, TransactionScreen.routeName);
              },
            ),
            HomeMenu(
              color: const Color(0xffdffdb3),
              icon: const Icon(FontAwesomeIcons.bagShopping),
              text: 'Services',
              onPressed: () {},
            ),
            HomeMenu(
              color: const Color(0xffb6e2ff),
              icon: const Icon(FontAwesomeIcons.calculator),
              text: 'Calculatrice',
              onPressed: () {
                Navigator.pushNamed(context, CalculatorScreen.routeName);
              },
            ),
            HomeMenu(
              color: const Color(0xfffdbbbc),
              icon: const Icon(FontAwesomeIcons.clockRotateLeft),
              text: 'Historiques',
              onPressed: () {
                Navigator.pushNamed(context, HistoricScreen.routeName);
              },
            ),
            HomeMenu(
              color: const Color(0xfffec67c),
              icon: const Icon(FontAwesomeIcons.circleInfo),
              text: 'Informations',
              onPressed: () {},
            ),
            HomeMenu(
              color: const Color(0xffc1ffd8),
              icon: const Icon(FontAwesomeIcons.spinner),
              text: 'A venir',
              onPressed: () {},
            ),
          ],
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 25,
          ),
        ),
        SliverToBoxAdapter(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: ()=>_launchUrl(facebook_url),
              child: const Image(
                  image: AssetImage(Assets.facebookLogo), width: 35, height: 35),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: ()=>_launchUrl(telegram_url),
                child: Image(image: AssetImage(Assets.telegramLogo), width: 35, height: 30)),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: ()=>_launchUrl(youtube_url),
                child: Image(image: AssetImage(Assets.youtubeLogo), width: 35, height: 35)),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: ()=>_launchUrl(whatsapp_url),
              child: const Image(
                  image: AssetImage(Assets.whatsappLogo), width: 35, height: 35),
            ),
          ],
        )),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_url';
    }
  }
}
