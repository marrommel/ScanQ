package com.christian.flutterDocumentScanner

import io.flutter.plugin.common.MethodChannel
import org.opencv.core.*
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc


class OpenCVPlugin {
    companion object {
        fun findContourPhoto(
            result: MethodChannel.Result,
            byteData: ByteArray,
            minContourArea: Double
        ) {
            try {
                val src = Imgcodecs.imdecode(MatOfByte(*byteData), Imgcodecs.IMREAD_UNCHANGED)

                val documentContour = findBiggestContour(src, minContourArea)

                // TODO: Use for when to use real time transmission
                // Scalar -> RGB(235, 228, 44)
                // Imgproc.drawContours(src, listOf(documentContour), -1, Scalar(44.0, 228.0, 235.0), 10)

                // Instantiating an empty MatOfByte class
                val matOfByte = MatOfByte()

                // Converting the Mat object to MatOfByte
                Imgcodecs.imencode(".jpg", src, matOfByte)
                val byteArray: ByteArray = matOfByte.toArray()


                val points = mutableListOf<Map<String, Any>>()

                if (documentContour != null) {
                    points.add(
                        mapOf(
                            "x" to documentContour.toList()[0].x,
                            "y" to documentContour.toList()[0].y
                        )
                    )
                    points.add(
                        mapOf(
                            "x" to documentContour.toList()[3].x,
                            "y" to documentContour.toList()[3].y
                        )
                    )
                    points.add(
                        mapOf(
                            "x" to documentContour.toList()[2].x,
                            "y" to documentContour.toList()[2].y
                        )
                    )
                    points.add(
                        mapOf(
                            "x" to documentContour.toList()[1].x,
                            "y" to documentContour.toList()[1].y
                        )
                    )
                }

                val resultEnd = mapOf(
                    "height" to src.height(),
                    "width" to src.width(),
                    "points" to points,
                    "image" to byteArray
                )

                result.success(resultEnd)

            } catch (e: java.lang.Exception) {
                result.error("FlutterDocumentScanner-Error", "Android: " + e.message, e)
            }
        }

        private fun findBiggestContour(src: Mat, minContourArea: Double): MatOfPoint? {
            // Converting to RGB from BGR
            val dstColor = Mat()
            Imgproc.cvtColor(src, dstColor, Imgproc.COLOR_BGR2RGB)

            // Converting to gray
            Imgproc.cvtColor(dstColor, dstColor, Imgproc.COLOR_BGR2GRAY)

            // Applying blur and threshold
            val dstBilateral = Mat()
            Imgproc.bilateralFilter(dstColor, dstBilateral, 9, 75.0, 75.0, Core.BORDER_DEFAULT)
            Imgproc.adaptiveThreshold(
                dstBilateral,
                dstBilateral,
                255.0,
                Imgproc.ADAPTIVE_THRESH_GAUSSIAN_C,
                Imgproc.THRESH_BINARY,
                115,
                4.0
            )

            // Median blur replace center pixel by median of pixels under kernel
            val dstBlur = Mat()
            Imgproc.GaussianBlur(dstBilateral, dstBlur, Size(5.0, 5.0), 0.0)
            Imgproc.medianBlur(dstBlur, dstBlur, 11)


            val dstBorder = Mat()
            Core.copyMakeBorder(dstBlur, dstBorder, 5, 5, 5, 5, Core.BORDER_CONSTANT)


            val dstCanny = Mat()
            Imgproc.Canny(dstBorder, dstCanny, 75.0, 200.0)

            // Close gaps between edges (double page clouse => rectangle kernel)
            val dstEnd = Mat()
            Imgproc.morphologyEx(
                dstCanny,
                dstEnd,
                Imgproc.MORPH_CLOSE,
                Mat.ones(intArrayOf(5, 11), CvType.CV_32F)
            )


            // Getting contours
            val contours = mutableListOf<MatOfPoint>()
            val hierarchy = Mat()
            Imgproc.findContours(
                dstEnd,
                contours,
                hierarchy,
                Imgproc.RETR_TREE,
                Imgproc.CHAIN_APPROX_SIMPLE
            )
            hierarchy.release()

            // Finding the biggest rectangle otherwise return original corners
            val height = dstEnd.height()
            val width = dstEnd.width()
            val maxContourArea = (width - 10) * (height - 10)

            var maxArea = 0.0
            var documentContour = MatOfPoint()

            for (contour in contours) {
                val contour2f = MatOfPoint2f()
                contour.convertTo(contour2f, CvType.CV_32FC2)
                val perimeter = Imgproc.arcLength(contour2f, true)

                val approx2f = MatOfPoint2f()
                Imgproc.approxPolyDP(contour2f, approx2f, 0.03 * perimeter, true)

                // Page has 4 corners and it is convex
                val approx = MatOfPoint()
                approx2f.convertTo(approx, CvType.CV_32S)
                val isContour = Imgproc.isContourConvex(approx)
                val isLessCurrentArea = Imgproc.contourArea(approx) > maxArea
                val isLessMaxArea = maxArea < maxContourArea

                if (approx.total()
                        .toInt() == 4 && isContour && isLessCurrentArea && isLessMaxArea
                ) {
                    maxArea = Imgproc.contourArea(approx)
                    documentContour = approx
                }
            }

            if (Imgproc.contourArea(documentContour) < minContourArea) {
                return null
            }

            return documentContour
        }


        fun adjustingPerspective(
            byteData: ByteArray,
            points: List<Map<String, Any>>,
            result: MethodChannel.Result
        ) {
            try {
                val src = Imgcodecs.imdecode(MatOfByte(*byteData), Imgcodecs.IMREAD_UNCHANGED)
                val documentContour = MatOfPoint(
                    Point("${points[0]["x"]}".toDouble(), "${points[0]["y"]}".toDouble()),
                    Point("${points[1]["x"]}".toDouble(), "${points[1]["y"]}".toDouble()),
                    Point("${points[2]["x"]}".toDouble(), "${points[2]["y"]}".toDouble()),
                    Point("${points[3]["x"]}".toDouble(), "${points[3]["y"]}".toDouble())
                )

                val imgWithPerspective = warpPerspective(src, documentContour)

                // Instantiating an empty MatOfByte class
                val matOfByte = MatOfByte()

                // Converting the Mat object to MatOfByte
                Imgcodecs.imencode(".jpg", imgWithPerspective, matOfByte)
                val byteArray: ByteArray = matOfByte.toArray()

                result.success(byteArray)

            } catch (e: java.lang.Exception) {
                result.error("FlutterDocumentScanner-Error", "Android: " + e.message, e)
            }
        }

        /*private fun warpPerspective(src: Mat, documentContour: MatOfPoint): Mat {
            val srcContour = MatOfPoint2f(
                Point(0.0, 0.0),
                Point((src.width() - 1).toDouble(), 0.0),
                Point((src.width() - 1).toDouble(), (src.height() - 1).toDouble()),
                Point(0.0, (src.height() - 1).toDouble())
            )

            val dstContour = MatOfPoint2f(
                documentContour.toList()[0],
                documentContour.toList()[1],
                documentContour.toList()[2],
                documentContour.toList()[3]
            )
            val warpMat = Imgproc.getPerspectiveTransform(dstContour, srcContour)

            val dstWarPerspective = Mat()
            Imgproc.warpPerspective(src, dstWarPerspective, warpMat, src.size())

            return dstWarPerspective
        }*/

        private fun warpPerspective(src: Mat, documentContour: MatOfPoint): Mat {
            val contourPoints = documentContour.toList()

            // Step 1: Sort points to get top-left, top-right, bottom-right, bottom-left
            val sortedPoints = contourPoints.sortedWith(compareBy({ it.y }, { it.x })) // Sort by Y, then X

            val topPoints = sortedPoints.take(2).sortedBy { it.x }
            val bottomPoints = sortedPoints.takeLast(2).sortedBy { it.x }

            val topLeft = topPoints[0]
            val topRight = topPoints[1]
            val bottomLeft = bottomPoints[0]
            val bottomRight = bottomPoints[1]

            // Step 2: Compute width and height of the new image
            val widthA = Math.hypot((bottomRight.x - bottomLeft.x), (bottomRight.y - bottomLeft.y))
            val widthB = Math.hypot((topRight.x - topLeft.x), (topRight.y - topLeft.y))
            val maxWidth = Math.max(widthA, widthB).toInt()

            val heightA = Math.hypot((topRight.x - bottomRight.x), (topRight.y - bottomRight.y))
            val heightB = Math.hypot((topLeft.x - bottomLeft.x), (topLeft.y - bottomLeft.y))
            val maxHeight = Math.max(heightA, heightB).toInt()

            // Step 3: Define destination rectangle
            val destination = MatOfPoint2f(
                Point(0.0, 0.0),
                Point(maxWidth.toDouble(), 0.0),
                Point(maxWidth.toDouble(), maxHeight.toDouble()),
                Point(0.0, maxHeight.toDouble())
            )

            // Step 4: Create transform matrix and apply warp
            val source = MatOfPoint2f(topLeft, topRight, bottomRight, bottomLeft)
            val warpMat = Imgproc.getPerspectiveTransform(source, destination)

            val dst = Mat()
            Imgproc.warpPerspective(src, dst, warpMat, Size(maxWidth.toDouble(), maxHeight.toDouble()))

            return dst
        }


        fun applyFilter(result: MethodChannel.Result, byteData: ByteArray, filter: Int) {
            try {
                val filterType: FilterType = when (filter) {
                    1 -> FilterType.Natural
                    2 -> FilterType.Gray
                    3 -> FilterType.Eco

                    else -> FilterType.Natural
                }
                val src = Imgcodecs.imdecode(MatOfByte(*byteData), Imgcodecs.IMREAD_UNCHANGED)

                var dstEnd = Mat()

                when (filterType) {
                    FilterType.Natural -> dstEnd = src

                    FilterType.Gray -> Imgproc.cvtColor(src, dstEnd, Imgproc.COLOR_BGR2GRAY)

                    FilterType.Eco -> {
                        val dstColor = Mat()
                        Imgproc.cvtColor(src, dstColor, Imgproc.COLOR_BGR2GRAY)

                        val dstGaussian = Mat()
                        Imgproc.GaussianBlur(dstColor, dstGaussian, Size(3.0, 3.0), 0.0)

                        val dstThreshold = Mat()
                        Imgproc.adaptiveThreshold(
                            dstGaussian,
                            dstThreshold,
                            255.0,
                            Imgproc.ADAPTIVE_THRESH_GAUSSIAN_C,
                            Imgproc.THRESH_BINARY,
                            7,
                            2.0
                        )

                        Imgproc.medianBlur(dstThreshold, dstEnd, 3)
                    }
                }


                // Instantiating an empty MatOfByte class
                val matOfByte = MatOfByte()

                // Converting the Mat object to MatOfByte
                Imgcodecs.imencode(".jpg", dstEnd, matOfByte)
                val byteArray: ByteArray = matOfByte.toArray()

                result.success(byteArray)

            } catch (e: java.lang.Exception) {
                result.error("FlutterDocumentScanner-Error", "Android: " + e.message, e)
            }
        }
    }

    private enum class FilterType {
        Natural,
        Gray,
        Eco,
    }
}
