import 'package:flutter/widgets.dart';

extension BoxConverter on Widget {
  SliverToBoxAdapter toBoxAdapter() {
    return SliverToBoxAdapter(
      child: this,
    );
  }
}
