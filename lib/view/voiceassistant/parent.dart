import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'collapsed.dart';
import 'floating.dart';

Widget bottomPanel() {
  return SlidingUpPanel(
    backdropColor: Colors.white,
    renderPanelSheet: false,
    panel: floatingPanel(),
    collapsed: floatingCollapsed(),
  );
}
