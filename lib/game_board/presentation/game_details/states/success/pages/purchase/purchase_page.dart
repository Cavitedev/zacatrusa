import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../constants/app_margins_and_sizes.dart';
import '../../../../../../zacatrus/domain/details_page/game_overview_details.dart';
import '../../../../../../zacatrus/domain/details_page/zacatrus_details_page_data.dart';
import '../../../../../core/widgets/game_overview/price.dart';
import '../../../../../core/widgets/game_overview/star_bars_indicator.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({required this.data, Key? key}) : super(key: key);

  final ZacatrusDetailsPageData data;

  @override
  Widget build(BuildContext context) {
    final GameOverviewDetails overview = data.gameOverview;
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(innerElementsPadding),
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        overview.name,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.w300),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (overview.stars != null)
                        StarsBarIndicator(stars: overview.stars!),
                      if (overview.price != null)
                        PriceText(price: overview.price!)
                    ],
                  ),
                  Column(
                    children: [
                      if (overview.available != null)
                        Text(
                          overview.available!,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ElevatedButton(
                          onPressed: () {
                            launch(
                              overview.link,
                            );
                          },
                          child: const Text(
                            "Página del producto",
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
          if (data.gameDescription != null)
            SelectableText(data.gameDescription!)
        ],
      ),
    );
  }
}
