// Copyright (c) 2021, Christian Betancourt
// https://github.com/criistian14
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_document_scanner/flutter_document_scanner.dart';
import 'package:flutter_document_scanner/src/bloc/app/app_bloc.dart';
import 'package:flutter_document_scanner/src/bloc/app/app_event.dart';
import 'package:flutter_document_scanner/src/bloc/crop/crop_bloc.dart';
import 'package:flutter_document_scanner/src/bloc/crop/crop_event.dart';
import 'package:flutter_document_scanner/src/bloc/crop/crop_state.dart';
import 'package:flutter_document_scanner/src/ui/widgets/app_bar_crop_photo.dart';
import 'package:flutter_document_scanner/src/ui/widgets/mask_crop.dart';
import 'package:flutter_document_scanner/src/utils/border_crop_area_painter.dart';
import 'package:flutter_document_scanner/src/utils/dot_utils.dart';
import 'package:flutter_document_scanner/src/utils/image_utils.dart';

/// Page to crop a photo
class CropPhotoDocumentPage extends StatefulWidget {
  const CropPhotoDocumentPage({
    super.key,
    required this.cropPhotoDocumentStyle,
  });

  final CropPhotoDocumentStyle cropPhotoDocumentStyle;

  @override
  State<CropPhotoDocumentPage> createState() => _CropPhotoDocumentPageState();
}

class _CropPhotoDocumentPageState extends State<CropPhotoDocumentPage> {
  late Future<Rect> _marginFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final image = context.read<AppBloc>().state.pictureInitial;
    if (image != null) {
      _marginFuture = _calculateImageMargins(image, context);
    }
  }

  Future<Rect> _calculateImageMargins(File image, BuildContext context) async {
    final decodedImage = await decodeImageFromList(image.readAsBytesSync());
    final imageWidth = decodedImage.width.toDouble();
    final imageHeight = decodedImage.height.toDouble();

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height - 50;

    final imageAspectRatio = imageWidth / imageHeight;
    final screenAspectRatio = screenWidth / screenHeight;

    double displayedWidth, displayedHeight;
    if (imageAspectRatio > screenAspectRatio) {
      displayedWidth = screenWidth - 20;
      displayedHeight = screenWidth / imageAspectRatio;
    } else {
      displayedHeight = screenHeight - 20;
      displayedWidth = screenHeight * imageAspectRatio;
    }

    double horizontalMargin = (screenWidth - displayedWidth) / 2;
    double verticalMargin = 20 + (screenHeight - displayedHeight) / 2;

    return Rect.fromLTRB(horizontalMargin, verticalMargin, horizontalMargin, verticalMargin);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => _onPop(context),
      child: BlocSelector<AppBloc, AppState, File?>(
        selector: (state) => state.pictureInitial,
        builder: (context, imageFile) {
          if (imageFile == null) {
            return const Center(child: Text('NO IMAGE'));
          }

          return FutureBuilder<Rect>(
            future: _marginFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final margins = snapshot.data!;
              return BlocProvider(
                create: (context) => CropBloc(
                  dotUtils: DotUtils(minDistanceDots: widget.cropPhotoDocumentStyle.minDistanceDots),
                  imageUtils: ImageUtils(),
                )..add(
                    CropAreaInitialized(
                      areaInitial: context.read<AppBloc>().state.contourInitial,
                      defaultAreaInitial: widget.cropPhotoDocumentStyle.defaultAreaInitial,
                      image: imageFile,
                      screenSize: screenSize,
                      positionImage: margins,
                      /*positionImage: Rect.fromLTRB(
                      widget.cropPhotoDocumentStyle.left,
                      widget.cropPhotoDocumentStyle.top,
                      widget.cropPhotoDocumentStyle.right,
                      widget.cropPhotoDocumentStyle.bottom,
                    ),*/
                    ),
                  ),
                child: _CropView(
                  cropPhotoDocumentStyle: widget.cropPhotoDocumentStyle,
                  image: imageFile,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<bool> _onPop(BuildContext context) async {
    await context.read<DocumentScannerController>().changePage(AppPages.takePhoto);
    return false;
  }
}

class _CropView extends StatefulWidget {
  const _CropView({
    required this.cropPhotoDocumentStyle,
    required this.image,
    Key? key,
  }) : super(key: key);

  final CropPhotoDocumentStyle cropPhotoDocumentStyle;
  final File image;

  @override
  State<_CropView> createState() => _CropViewState();
}

class _CropViewState extends State<_CropView> {
  double? computedTop, computedBottom, computedLeft, computedRight;

  @override
  void initState() {
    super.initState();
    _calculateImageMargins();
  }

  void _calculateImageMargins() async {
    final decodedImage = await decodeImageFromList(widget.image.readAsBytesSync());
    final imageWidth = decodedImage.width.toDouble();
    final imageHeight = decodedImage.height.toDouble();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = MediaQuery.of(context).size;
      final screenWidth = screenSize.width;
      final screenHeight = screenSize.height - 50;

      final imageAspectRatio = imageWidth / imageHeight;
      final screenAspectRatio = screenWidth / screenHeight;

      double displayedWidth, displayedHeight;
      if (imageAspectRatio > screenAspectRatio) {
        // Image is wider relative to screen
        displayedWidth = screenWidth - 20;
        displayedHeight = screenWidth / imageAspectRatio;
      } else {
        // Image is taller relative to screen
        displayedHeight = screenHeight - 20;
        displayedWidth = screenHeight * imageAspectRatio;
      }

      double horizontalMargin = (screenWidth - displayedWidth) / 2;
      double verticalMargin = (screenHeight - displayedHeight) / 2;

      setState(() {
        computedTop = verticalMargin;
        computedBottom = verticalMargin;
        computedLeft = horizontalMargin;
        computedRight = horizontalMargin;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (computedTop == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<AppBloc, AppState>(
          listenWhen: (previous, current) => current.statusCropPhoto != previous.statusCropPhoto,
          listener: (context, state) {
            if (state.statusCropPhoto == AppStatus.loading) {
              context.read<CropBloc>().add(CropPhotoByAreaCropped(widget.image));
            }
          },
        ),
        BlocListener<CropBloc, CropState>(
          listenWhen: (previous, current) => current.imageCropped != previous.imageCropped,
          listener: (context, state) {
            if (state.imageCropped != null) {
              context.read<AppBloc>().add(
                    AppLoadCroppedPhoto(
                      image: state.imageCropped!,
                      area: state.areaParsed!,
                    ),
                  );
            }
          },
        ),
      ],
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: computedTop,
            bottom: computedBottom,
            left: computedLeft,
            right: computedRight,
            /* top: widget.cropPhotoDocumentStyle.top,
            bottom: widget.cropPhotoDocumentStyle.bottom,
            left: widget.cropPhotoDocumentStyle.left,
            right: widget.cropPhotoDocumentStyle.right,*/
            child: Stack(
              fit: StackFit.expand,
              children: [
                // * Photo
                Positioned.fill(
                  child: Image.file(
                    widget.image,
                    fit: BoxFit.fill,
                  ),
                ),

                // * Mask
                BlocSelector<CropBloc, CropState, Area>(
                  selector: (state) => state.area,
                  builder: (context, state) {
                    return MaskCrop(
                      area: state,
                      cropPhotoDocumentStyle: widget.cropPhotoDocumentStyle,
                    );
                  },
                ),

                // * Border Mask
                BlocSelector<CropBloc, CropState, Area>(
                  selector: (state) => state.area,
                  builder: (context, state) {
                    return CustomPaint(
                      painter: BorderCropAreaPainter(
                        area: state,
                        colorBorderArea: widget.cropPhotoDocumentStyle.colorBorderArea,
                        widthBorderArea: widget.cropPhotoDocumentStyle.widthBorderArea,
                      ),
                      child: const SizedBox.expand(),
                    );
                  },
                ),

                // * Dot - All
                BlocSelector<CropBloc, CropState, Area>(
                  selector: (state) => state.area,
                  builder: (context, state) {
                    return GestureDetector(
                      onPanUpdate: (details) {
                        context.read<CropBloc>().add(
                              CropDotMoved(
                                deltaX: details.delta.dx,
                                deltaY: details.delta.dy,
                                dotPosition: DotPosition.all,
                              ),
                            );
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: state.topLeft.x + state.topRight.x,
                        height: state.topLeft.y + state.topRight.y,
                      ),
                    );
                  },
                ),

                // * Dot - Top Left
                BlocSelector<CropBloc, CropState, Point>(
                  selector: (state) => state.area.topLeft,
                  builder: (context, state) {
                    return Positioned(
                      left: state.x - (widget.cropPhotoDocumentStyle.dotSize / 2),
                      top: state.y - (widget.cropPhotoDocumentStyle.dotSize / 2),
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          context.read<CropBloc>().add(
                                CropDotMoved(
                                  deltaX: details.delta.dx,
                                  deltaY: details.delta.dy,
                                  dotPosition: DotPosition.topLeft,
                                ),
                              );
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: widget.cropPhotoDocumentStyle.dotSize,
                          height: widget.cropPhotoDocumentStyle.dotSize,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                widget.cropPhotoDocumentStyle.dotRadius,
                              ),
                              child: Container(
                                width: widget.cropPhotoDocumentStyle.dotSize - (2 * 2),
                                height: widget.cropPhotoDocumentStyle.dotSize - (2 * 2),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // * Dot - Top Right
                BlocSelector<CropBloc, CropState, Point>(
                  selector: (state) => state.area.topRight,
                  builder: (context, state) {
                    return Positioned(
                      left: state.x - (widget.cropPhotoDocumentStyle.dotSize / 2),
                      top: state.y - (widget.cropPhotoDocumentStyle.dotSize / 2),
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          context.read<CropBloc>().add(
                                CropDotMoved(
                                  deltaX: details.delta.dx,
                                  deltaY: details.delta.dy,
                                  dotPosition: DotPosition.topRight,
                                ),
                              );
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: widget.cropPhotoDocumentStyle.dotSize,
                          height: widget.cropPhotoDocumentStyle.dotSize,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                widget.cropPhotoDocumentStyle.dotRadius,
                              ),
                              child: Container(
                                width: widget.cropPhotoDocumentStyle.dotSize - (2 * 2),
                                height: widget.cropPhotoDocumentStyle.dotSize - (2 * 2),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // * Dot - Bottom Left
                BlocSelector<CropBloc, CropState, Point>(
                  selector: (state) => state.area.bottomLeft,
                  builder: (context, state) {
                    return Positioned(
                      left: state.x - (widget.cropPhotoDocumentStyle.dotSize / 2),
                      top: state.y - (widget.cropPhotoDocumentStyle.dotSize / 2),
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          context.read<CropBloc>().add(
                                CropDotMoved(
                                  deltaX: details.delta.dx,
                                  deltaY: details.delta.dy,
                                  dotPosition: DotPosition.bottomLeft,
                                ),
                              );
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: widget.cropPhotoDocumentStyle.dotSize,
                          height: widget.cropPhotoDocumentStyle.dotSize,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                widget.cropPhotoDocumentStyle.dotRadius,
                              ),
                              child: Container(
                                width: widget.cropPhotoDocumentStyle.dotSize - (2 * 2),
                                height: widget.cropPhotoDocumentStyle.dotSize - (2 * 2),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // * Dot - Bottom Right
                BlocSelector<CropBloc, CropState, Point>(
                  selector: (state) => state.area.bottomRight,
                  builder: (context, state) {
                    return Positioned(
                      left: state.x - (widget.cropPhotoDocumentStyle.dotSize / 2),
                      top: state.y - (widget.cropPhotoDocumentStyle.dotSize / 2),
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          context.read<CropBloc>().add(
                                CropDotMoved(
                                  deltaX: details.delta.dx,
                                  deltaY: details.delta.dy,
                                  dotPosition: DotPosition.bottomRight,
                                ),
                              );
                        },
                        child: Container(
                          color: Colors.transparent,
                          width: widget.cropPhotoDocumentStyle.dotSize,
                          height: widget.cropPhotoDocumentStyle.dotSize,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                widget.cropPhotoDocumentStyle.dotRadius,
                              ),
                              child: Container(
                                width: widget.cropPhotoDocumentStyle.dotSize - (2 * 2),
                                height: widget.cropPhotoDocumentStyle.dotSize - (2 * 2),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // * Default App Bar
          AppBarCropPhoto(
            cropPhotoDocumentStyle: widget.cropPhotoDocumentStyle,
          ),

          // * children
          if (widget.cropPhotoDocumentStyle.children != null) ...widget.cropPhotoDocumentStyle.children!,
        ],
      ),
    );
  }
}
