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

import 'filters/browse_page_filters.dart';

class GamesBrowseSliverAppBar extends ConsumerStatefulWidget {
  const GamesBrowseSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<GamesBrowseSliverAppBar> createState() =>
      _GamesBrowseSliverAppBarState();
}

class _GamesBrowseSliverAppBarState
    extends ConsumerState<GamesBrowseSliverAppBar> {
  late final TextEditingController textController;
  bool isSearching = false;
  late FocusNode controllerFocus;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    controllerFocus = FocusNode();
  }

  @override
  void dispose() {
    textController.dispose();
    controllerFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isSearching ? _searchingAppBar() : _defaultSearchBar(context);
  }

  SliverAppBar _defaultSearchBar(BuildContext context) {
    return SliverAppBar(
      title: GestureDetector(
        onTap: () {
          _changeIsSearchingState(true);
        },
        child:
            Text(textController.text.isEmpty ? appName : textController.text),
      ),
      floating: true,
      actions: [
        IconButton(
            onPressed: () {
              _changeIsSearchingState(true);
            },
            icon: const Icon(
              Icons.search,
              semanticLabel: "Buscar por nombre",
            )),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const BrowsePageFilters();
                  });
            },
            icon: const Icon(
              Icons.filter_list,
              semanticLabel: "Filtrar",
            ))
      ],
    );
  }

  SliverAppBar _searchingAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      floating: true,
      iconTheme: const IconThemeData(color: Colors.black),
      leading: IconButton(
        onPressed: () {
          _changeIsSearchingState(false);
        },
        icon: const Icon(
          Icons.arrow_back,
          semanticLabel: "Volver a barra normal",
        ),
      ),
      title: OutlinedInputField(
        autocorrect: false,
        textInputAction: TextInputAction.search,
        controller: textController,
        onSubmit: _onSubmit,
        focusNode: controllerFocus,
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
      ),
    );
  }

  void _changeIsSearchingState(bool isSearching) {
    setState(() {
      this.isSearching = isSearching;
      if (isSearching) {
        controllerFocus.requestFocus();
      } else {
        controllerFocus.unfocus();
      }
    });
  }

  void _onSubmit(String text) {
    final BrowserNotifier broswerNotifier =
        ref.read(browserNotifierProvider.notifier);
    final BrowserState broswerState = ref.read(browserNotifierProvider);
    broswerNotifier.changeFilters(broswerState.urlComposer
        .copyWith(query: Optional.value(ZacatrusQueryFilter(value: text))));
  }
}
