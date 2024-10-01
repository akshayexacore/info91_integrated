import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:visibility_detector/visibility_detector.dart';

class GroupedList<T, E> extends StatefulWidget {
  const GroupedList({
    super.key,
    required this.elements,
    required this.groupBy,
    this.groupHeaderBuilder,
    required this.indexedItemBuilder,
    this.groupComparator,
    this.controller,
  });

  final List<T> elements;

  final E Function(T element) groupBy;

  final Widget Function(int index)? groupHeaderBuilder;

  final Widget Function(BuildContext context, int index) indexedItemBuilder;

  final int Function(E value1, E value2)? groupComparator;

  final ScrollController? controller;

  @override
  State<GroupedList> createState() => _GroupedListState<T, E>();
}

class _GroupedListState<T, E> extends State<GroupedList<T, E>> {
  late final ScrollController _controller;

  final StreamController<int> _streamController = StreamController<int>();

  bool showFloatingHeader = false;

  Timer? _timer;

  double _floatingHeaderHeight = 0;

  @override
  void initState() {
    _controller = widget.controller ?? ScrollController();
    _controller.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  void _scrollListener() {
    if (!showFloatingHeader) {
      setState(() {
        showFloatingHeader = true; // Show the widget
      });
    }
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = Timer(const Duration(seconds: 3), () {
      if (showFloatingHeader) {
        setState(() {
          showFloatingHeader = false; // Hide the widget after 3 seconds
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          controller: _controller,
          itemBuilder: (context, index) {
            return Column(
              children: [
                _buildHeader(index),
                widget.indexedItemBuilder(context, index),
              ],
            );
          },
          itemCount: widget.elements.length,
          reverse: true,
        ),
        AnimatedPositioned(
          left: 0,
          right: 0,
          top: showFloatingHeader ? 0 : -_floatingHeaderHeight,
          duration: const Duration(milliseconds: 300),
          child: StreamBuilder<int>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return LayoutBuilder(builder: (context, constraints) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _floatingHeaderHeight = context.size?.height ?? 0;
                    });
                    return widget.groupHeaderBuilder!(snapshot.data!);
                  });
                }
                return const SizedBox();
              }),
        ),
      ],
    );
  }

  Widget _buildHeader(int index) {
    if (index < widget.elements.length - 1 &&
        widget.groupHeaderBuilder != null) {
      final cur = widget.elements[index];
      final next = widget.elements[index + 1];
      if (widget.groupComparator!(widget.groupBy(cur), widget.groupBy(next)) >
          0) {
        return VisibilityDetector(
            key: Key('groupHeaderBuilder$index'),
            onVisibilityChanged: (visibilityInfo) {
              _onVisibilityChanged(visibilityInfo, index);
            },
            child: widget.groupHeaderBuilder!(index));
      }
    }
    return const SizedBox();
  }

  void _onVisibilityChanged(VisibilityInfo info, int index) {
    double visiblePercentage = info.visibleFraction;
    if (visiblePercentage > .50 &&
        index < widget.elements.length &&
        _controller.position.userScrollDirection == ScrollDirection.reverse) {
      _streamController.add(index + 1);
    }
    if (visiblePercentage < .50 &&
        index > 0 &&
        _controller.position.userScrollDirection == ScrollDirection.forward) {
      _streamController.add(index - 1);
    }
  }
}
