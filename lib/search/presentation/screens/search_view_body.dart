import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/search/presentation/screens/widgets/search_bar_items.dart';
import 'package:movie_app/search/presentation/screens/widgets/search_results.dart';

import '../../../core/global/resources/font_manager.dart';
import '../../../core/global/resources/strings_manger.dart';
import '../../../core/global/resources/styles_manager.dart';
import '../../../core/global/resources/values_manager.dart';
import '../controller/history_bloc.dart';
import '../controller/history_events.dart';
import '../controller/search_bloc.dart';
import '../controller/search_events.dart';
import '../controller/search_state.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  SearchViewBodyState createState() => SearchViewBodyState();
}

class SearchViewBodyState extends State<SearchViewBody> {
  final TextEditingController _controller = TextEditingController();
  bool _showNoDataMessage = false;
  String _lastQuery = '';
  final FocusNode _focusNode = FocusNode();
  int _selectedSearchType = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final query = _controller.text;
    if (query.isEmpty) {
      context.read<SearchBloc>().add(ClearSearchResults());
      _startLoadingTimeout();
    } else {
      if (query != _lastQuery) {
        _lastQuery = query;

        _performSearch(query);
      }
    }
  }

  void _performSearch(String query) {
    if (_selectedSearchType == 0) {
      context.read<SearchBloc>().add(SearchMoviesQueryChanged(query: query));
    }
  }

  void onSearchTypeChanged(int newIndex) {
    setState(() {
      _controller.clear();
      _selectedSearchType = newIndex;
    });
    if (_lastQuery.isNotEmpty) {
      _lastQuery = '';
      _performSearch(_lastQuery);
    }
  }

  void _clearSearchWithUnfocus() {
    _controller.clear();
    _focusNode.unfocus();
    context.read<SearchBloc>().add(ClearSearchResults());
  }

  void _startLoadingTimeout() {
    final currentQuery = _lastQuery;

    setState(() {
      _showNoDataMessage = false;
    });

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && _lastQuery == currentQuery && currentQuery.isNotEmpty) {
        final state = context.read<SearchBloc>().state;
        if (state is SearchLoading) {
          setState(() {
            _showNoDataMessage = true;
          });
        } else if (state is SearchMoviesSuccess && state.results.isEmpty) {
          setState(() {
            _showNoDataMessage = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBarItems(
            controller: _controller,
            clearSearch: _clearSearchWithUnfocus,
            focusNode: _focusNode,
            onSubmitted: (String query) {
              context.read<HistoryBloc>().add(AddHistoryEntry(query));
            },
          ),
          const SizedBox(height: AppSize.s8),
          const Divider(
            height: AppSize.s1,
            thickness: AppSize.s1,
          ),
          Expanded(
            child: _showNoDataMessage
                ? Center(
                    child: Text(
                      AppString.noResultsFound,
                      style: getMediumStyle(fontSize: FontSize.s16),
                    ),
                  )
                : const SearchResults(),
          ),
        ],
      ),
    );
  }
}
