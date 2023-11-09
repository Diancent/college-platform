import 'package:college_platform_mobile/widgets/home_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SectionFollowUp extends StatelessWidget {
  const SectionFollowUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Слідкуйте за ХПФК далі",
          style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(30, 26, 82, 1),
          ),
        ),
        const Divider(
          color: Color.fromRGBO(224, 225, 235, 1),
          height: 30,
          thickness: 1.8,
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeItem(
              title: "TikTok",
              secondTitle: "",
              icon: SvgPicture.asset(
                "assets/icons/tiktok.svg",
                colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(30, 26, 82, 1), BlendMode.srcIn),
              ),
              onPressed: () {},
            ),
            HomeItem(
              title: "Instagram",
              secondTitle: "",
              icon: SvgPicture.asset(
                "assets/icons/instagram.svg",
                colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(30, 26, 82, 1), BlendMode.srcIn),
              ),
              onPressed: () {},
            ),
            HomeItem(
              title: "Facebook",
              secondTitle: "",
              icon: const Icon(
                Icons.facebook,
                size: 35,
                color: Color.fromRGBO(30, 26, 82, 1),
              ),
              onPressed: () {},
              // onPressed: _launchURLFB(),
            ),
            HomeItem(
                title: "Сайт",
                secondTitle: "ХПК",
                icon: SvgPicture.asset(
                  "assets/icons/internet.svg",
                ),
                onPressed: _launchURL),
          ],
        ),
      ],
    );
  }

  _launchURLFB() async {
    const url = 'https://www.facebook.com/hpknulp/?locale=ru_RU';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL() async {
    const url = 'https://hpk.edu.ua';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
