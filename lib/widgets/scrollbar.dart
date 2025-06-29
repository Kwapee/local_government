//import 'package:employer_self_service/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:local_government_app/utils/colors.dart';
// Note: 'package:flutter/cupertino.dart' was unused and removed.

const double _kScrollbarThickness = 12.0;
const Radius _kScrollbarRadius = Radius.circular(20.0); // Use const for radius too
const EdgeInsets _kScrollbarPadding = EdgeInsets.only(
  top: 15.0,
  right: 15.0,
  bottom: 5.0,
  left: 5.0,
);

class MyScrollbar extends StatefulWidget {
  /// The widget below this widget in the tree.
  ///
  /// The scrollable widget should be built by this builder.
  /// It is provided with the `ScrollController` that is handled by this
  /// `MyScrollbar` state.
  final ScrollableWidgetBuilder builder;

  /// An optional ScrollController to use.
  ///
  /// If not provided, a ScrollController will be created internally.
  final ScrollController? scrollController;

  /// Creates a custom scrollbar that wraps a scrollable widget.
  const MyScrollbar({
    super.key, // Use super.key for modern Flutter
    this.scrollController,
    required this.builder, // Use required keyword
  });

  @override
  State<MyScrollbar> createState() => _MyScrollbarState();
}

class _MyScrollbarState extends State<MyScrollbar> {
  ScrollbarPainter? _scrollbarPainter;
  ScrollController? _effectiveScrollController;
  bool _controllerWasCreatedInternally = false;

  // Listener attached to the scroll controller
  void _scrollListener() {
    // The painter is a ChangeNotifier, so updating it is enough.
    // The CustomPaint widget listens to it and repaints automatically.
    if (_scrollbarPainter != null && _effectiveScrollController!.hasClients) {
      _updateScrollbarPainter(_effectiveScrollController!.position);
    }
  }

  @override
  void initState() {
    super.initState();
    // Determine the scroll controller to use
    if (widget.scrollController == null) {
      _effectiveScrollController = ScrollController();
      _controllerWasCreatedInternally = true;
    } else {
      _effectiveScrollController = widget.scrollController;
      _controllerWasCreatedInternally = false;
    }
    // Add listener for scroll updates
    _effectiveScrollController?.addListener(_scrollListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Create or update the painter when dependencies change (like Theme or Directionality)
    _rebuildPainter();
  }

  void _rebuildPainter() {
    // Dispose the old painter explicitly if it exists
    _scrollbarPainter?.dispose();

    _scrollbarPainter = ScrollbarPainter(
      color: ColorPack.red, // Your custom color
      textDirection: Directionality.of(context),
      thickness: _kScrollbarThickness,
      radius: _kScrollbarRadius,
      // Keeps the scrollbar always visible (no fade-out animation)
      fadeoutOpacityAnimation: const AlwaysStoppedAnimation<double>(1.0),
      padding: _kScrollbarPadding, // Your custom padding
      // Optional: mainAxisMargin, crossAxisMargin if needed
    );

    // Update the painter with the current scroll metrics if possible
    // This handles the initial state before any scrolling occurs
    if (_effectiveScrollController != null && _effectiveScrollController!.hasClients) {
       // Defer the update slightly if the position isn't ready immediately after rebuild
       // although usually hasClients check is sufficient
      WidgetsBinding.instance.addPostFrameCallback((_) {
         if (mounted && _effectiveScrollController!.hasClients) {
           _updateScrollbarPainter(_effectiveScrollController!.position);
         }
      });
    } else {
      // If no clients yet, update with zero metrics to initialize painter state
       _updateScrollbarPainter(FixedScrollMetrics(
         minScrollExtent: 0,
         maxScrollExtent: 0,
         pixels: 0,
         viewportDimension: 0,
         axisDirection: AxisDirection.down, devicePixelRatio: 0, // or appropriate default
       ));
    }
  }

  // Helper to update the painter's state
  void _updateScrollbarPainter(ScrollMetrics metrics) {
    _scrollbarPainter?.update(
      metrics,
      metrics.axisDirection,
    );
    // No setState needed here because ScrollbarPainter is a ChangeNotifier
    // and CustomPaint listens to it.
  }

  @override
  void didUpdateWidget(MyScrollbar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if the provided scroll controller changed
    if (widget.scrollController != oldWidget.scrollController) {
      // Remove listener from the old controller
      _effectiveScrollController?.removeListener(_scrollListener);

      // Dispose the internally created controller if it's no longer needed
      if (_controllerWasCreatedInternally) {
        _effectiveScrollController?.dispose();
        _controllerWasCreatedInternally = false; // Reset flag
      }

      // Update to the new controller
      if (widget.scrollController == null) {
        // Create a new internal controller if the new one is null
        _effectiveScrollController = ScrollController();
        _controllerWasCreatedInternally = true;
      } else {
        // Use the provided external controller
        _effectiveScrollController = widget.scrollController;
        _controllerWasCreatedInternally = false;
      }

      // Add listener to the new controller
      _effectiveScrollController?.addListener(_scrollListener);

      // Update painter with new controller's position (if available)
      if (_effectiveScrollController!.hasClients) {
        _updateScrollbarPainter(_effectiveScrollController!.position);
      }
    }
    // Note: If scrollbar styling properties (color, thickness, etc.) were
    // passed as widget parameters, you would check for changes here
    // and call _rebuildPainter() if they changed. Since they are constant
    // in this example, we don't need that check.
  }

  @override
  void dispose() {
    // Remove the listener
    _effectiveScrollController?.removeListener(_scrollListener);
    // Dispose the painter
    _scrollbarPainter?.dispose();
    // Dispose the controller ONLY if it was created internally
    if (_controllerWasCreatedInternally) {
      _effectiveScrollController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use CustomPaint to draw the scrollbar
    return CustomPaint(
      // The painter listens to the ScrollController via _scrollListener
      painter: _scrollbarPainter,
      // The child widget is built using the builder function, passing the
      // scroll controller.
      child: widget.builder(context, _effectiveScrollController!),
    );
  }
}