import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_constants.dart';
import 'package:zacatrusa/core/optional.dart';
import 'package:zacatrusa/game_board/application/browser/browser_notifier.dart';
import 'package:zacatrusa/game_board/application/browser/browser_state.dart';
import 'package:zacatrusa/game_board/presentation/core/widgets/outlined_input_field.dart';
import 'package:zacatrusa/game_board/presentation/core/widgets/voice_to_speech_button.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/url/filters/zacatrus_query_filter.dart';

class GamesBrowseSliverAppBar extends ConsumerStatefulWidget {
  const GamesBrowseSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<GamesBrowseSliverAppBar> createState() =>
      _GamesBrowseSliverAppBarState();
}

class _GamesBrowseSliverAppBarState
    extends ConsumerState<GamesBrowseSliverAppBar>
    with SingleTickerProviderStateMixin {
  late final TextEditingController textController;
  bool isSearching = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isSearching?  SliverAppBar(
      backgroundColor: isSearching ? Colors.white : null,
      title: isSearching
          ? OutlinedInputField(
              autocorrect: false,
              textStyle: TextStyle(color: Colors.white),
              textInputAction: TextInputAction.search,
              controller: textController,
              onSubmit: _onSubmit,
              suffixIconWhenNoText: (Platform.isAndroid || Platform.isIOS)
                  ? VoiceToSpeechButton(
                      onWordHeard: (textHeard, isFinished) {
                        if (isFinished) {
                          _onSubmit(textHeard);
                        }
                        textController.value = TextEditingValue(
                          text: textHeard,
                          selection:
                              TextSelection.collapsed(offset: textHeard.length),
                        );
                      },
                    )
                  : null,
            )
          : const Text(appName),
      floating: true,
      actions: [
        if (!isSearching)
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
              icon: const Icon(Icons.search)),
        IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
              // showDialog(
              // context: context,
              // builder: (context) {
              //   return const BrowsePageFilters();
              // });
            },
            icon: const Icon(Icons.home)),
        IconButton(
            onPressed: () {
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
              // showDialog(
              // context: context,
              // builder: (context) {
              //   return const BrowsePageFilters();
              // });
            },
            icon: const Icon(Icons.filter_list))
      ],
    ) : SliverAppBar(
      backgroundColor: isSearching ? Colors.white : null,
      title: isSearching
          ? OutlinedInputField(
              autocorrect: false,
              textStyle: TextStyle(color: Colors.white),
              textInputAction: TextInputAction.search,
              controller: textController,
              onSubmit: _onSubmit,
              suffixIconWhenNoText: (Platform.isAndroid || Platform.isIOS)
                  ? VoiceToSpeechButton(
                      onWordHeard: (textHeard, isFinished) {
                        if (isFinished) {
                          _onSubmit(textHeard);
                        }
                        textController.value = TextEditingValue(
                          text: textHeard,
                          selection:
                              TextSelection.collapsed(offset: textHeard.length),
                        );
                      },
                    )
                  : null,
            )
          : const Text(appName),
      floating: true,
      actions: [
        if (!isSearching)
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
              icon: const Icon(Icons.search)),
        IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
              // showDialog(
              // context: context,
              // builder: (context) {
              //   return const BrowsePageFilters();
              // });
            },
            icon: const Icon(Icons.home)),
        IconButton(
            onPressed: () {
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
              // showDialog(
              // context: context,
              // builder: (context) {
              //   return const BrowsePageFilters();
              // });
            },
            icon: const Icon(Icons.filter_list))
      ],
    );
  }

  void _onSubmit(String text) {
    final BrowserNotifier broswerNotifier =
        ref.read(browserNotifierProvider.notifier);
    final BrowserState broswerState = ref.read(browserNotifierProvider);
    broswerNotifier.changeFilters(broswerState.urlComposer
        .copyWith(query: Optional.value(ZacatrusQueryFilter(value: text))));
  }
}
