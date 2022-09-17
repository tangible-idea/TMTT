
import 'package:flutter/material.dart';
import 'package:tmtt/pages.dart';
import 'package:tmtt/src/util/my_navigator.dart';

// In a real application this would probably be some kind of database interface.
const List<Article> articles = [
  Article(
    title: 'work in IT field 🇰🇷🇩🇪🇹🇭, freelance software developer. #softwaredevelopers.',
    slug: 'tangibleidea',
  ),
  Article(
    title: '먹자훈킴 | 먹스타, 맞팔 환영 👊, #전국맛집 #지역별맛집 #전국여행, 전국 맛집 어디든 달려갑니다.',
    slug: 'hunkim_food',
  ),
  Article(
    title: 'Test instagram account.',
    slug: 'test',
  ),
];


class Path {
  const Path(this.pattern, this.builder);

  /// A RegEx string for route matching.
  final String pattern;

  /// The builder for the associated pattern route. The first argument is the
  /// [BuildContext] and the second argument is a RegEx match if it is
  /// included inside of the pattern.
  final Widget Function(BuildContext, String) builder;
}

class RouteConfiguration {
  /// List of [Path] to for route matching. When a named route is pushed with
  /// [Navigator.pushNamed], the route name is matched with the [Path.pattern]
  /// in the list below. As soon as there is a match, the associated builder
  /// will be returned. This means that the paths higher up in the list will
  /// take priority.
  static List<Path> paths = [
    Path(
      r'^' r'/([\w-]+)$',
          (context, match) => Article.getArticlePage(match),
    ),
    Path(
      r'^' + OverviewPage.route,
          (context, match) => OverviewPage(),
    ),
  ];

  /// The route generator callback used when the app is navigated to a named
  /// route. Set it on the [MaterialApp.onGenerateRoute] or
  /// [WidgetsApp.onGenerateRoute] to make use of the [paths] for route
  /// matching.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      final regExpPattern = RegExp(path.pattern);

      if (regExpPattern.hasMatch(settings.name!)) {
        final firstMatch = regExpPattern.firstMatch(settings.name!);
        final match = (firstMatch?.groupCount == 1) ? firstMatch?.group(1) : null;
        return MaterialPageRoute<void>(
          builder: (context) => path.builder(context, match!),
          settings: settings,
        );
      }
    }

    // If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
    return null;
  }
}


class Article {
  const Article({required this.title, required this.slug});

  final String title;
  final String slug;

  static Widget getArticlePage(String slug) {
    for (Article article in articles) {
      if (article.slug == slug) {
        return ArticlePage(article: article);
      }
    }
    return UnknownArticle();
  }
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key, required this.article}) : super(key: key);

  //static const String baseRoute = '/article';
  static String Function(String slug) routeFromSlug =
      (String slug) => slug;

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(article.title),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}


class UnknownArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unknown article'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Unknown article'),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class OverviewPage extends StatelessWidget {
  static const String route = '/overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overview Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (Article article in articles)
              TextButton(
                onPressed: () {
                  MyNav.pushNamed(
                      pageName: '${PageName.dynamicUserPage}/${article.slug}'
                  );
                  // Navigator.of(context).pushNamed(
                  //   ArticlePage.routeFromSlug(article.slug),
                  // );
                },
                child: Text(article.title),
              ),
            TextButton(
              onPressed: () {
                // Navigate back to the home screen by popping the current route
                // off the stack.
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}
