// ticket_scanning_view.dart
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'ticket_scanning_viewmodel.dart';

class TicketScanningView extends StackedView<TicketScanningViewModel> {
  const TicketScanningView({super.key});

  @override
  Widget builder(
      BuildContext context,
      TicketScanningViewModel viewModel,
      Widget? child,
      ) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          'Scan Ticket',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: viewModel.toggleFlash,
            icon: Icon(
              viewModel.isFlashOn ? Icons.flash_on : Icons.flash_off,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: viewModel.switchCamera,
            icon: const Icon(
              Icons.cameraswitch,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera Scanner
          if (viewModel.hasPermission)
            MobileScanner(
              controller: viewModel.cameraController,
              onDetect: viewModel.onQRCodeDetected,
            )
          else
            _buildPermissionDeniedView(viewModel),

          // Top Instructions
          _buildInstructions(viewModel),

          // Bottom Action Buttons
          _buildBottomActions(context, viewModel),

          // Scan Result Overlay
          if (viewModel.showScanResult)
            _buildScanResultOverlay(context, viewModel),

          // Loading Overlay
          if (viewModel.isValidating)
            _buildLoadingOverlay(),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Container(
      decoration: ShapeDecoration(
        shape: QrScannerOverlayShape(
          borderColor: const Color(0xFFFF6B35),
          borderRadius: 12,
          borderLength: 30,
          borderWidth: 4,
          cutOutSize: 250,
        ),
      ),
    );
  }

  Widget _buildInstructions(TicketScanningViewModel viewModel) {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.qr_code_scanner,
              color: Color(0xFFFF6B35),
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.instructionText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            if (viewModel.eventName.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'Event: ${viewModel.eventName}',
                style: const TextStyle(
                  color: Color(0xFFFF6B35),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, TicketScanningViewModel viewModel) {
    return Positioned(
      bottom: 40,
      left: 20,
      right: 20,
      child: Column(
        children: [
          // Scan Count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Scanned: ${viewModel.scannedCount} | Valid: ${viewModel.validCount}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: Icons.history,
                label: 'History',
                onTap: viewModel.showScanHistory,
              ),
              _buildActionButton(
                icon: Icons.pause,
                label: viewModel.isPaused ? 'Resume' : 'Pause',
                onTap: viewModel.togglePause,
                color: viewModel.isPaused ? Colors.green : Colors.orange,
              ),
              _buildActionButton(
                icon: Icons.fiber_manual_record_sharp,
                label: 'Manual',
                onTap: () => viewModel.showManualEntry(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: (color ?? const Color(0xFFFF6B35)).withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color ?? const Color(0xFFFF6B35),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color ?? const Color(0xFFFF6B35),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color ?? const Color(0xFFFF6B35),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanResultOverlay(BuildContext context, TicketScanningViewModel viewModel) {
    return Container(
      color: Colors.black.withOpacity(0.8),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                viewModel.lastScanResult?.isValid == true
                    ? Icons.check_circle
                    : Icons.error,
                color: viewModel.lastScanResult?.isValid == true
                    ? Colors.green
                    : Colors.red,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                viewModel.lastScanResult?.isValid == true
                    ? 'Valid Ticket'
                    : 'Invalid Ticket',
                style: TextStyle(
                  color: viewModel.lastScanResult?.isValid == true
                      ? Colors.green
                      : Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              if (viewModel.lastScanResult != null) ...[
                Text(
                  viewModel.lastScanResult!.message,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (viewModel.lastScanResult!.ticketInfo != null) ...[
                  const SizedBox(height: 16),
                  _buildTicketInfo(viewModel.lastScanResult!.ticketInfo!),
                ],
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: viewModel.hideScanResult,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF6B35),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Continue Scanning'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketInfo(TicketInfo ticketInfo) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _buildInfoRow('Ticket ID', ticketInfo.ticketId),
          _buildInfoRow('Holder', ticketInfo.holderName),
          _buildInfoRow('Type', ticketInfo.ticketType),
          if (ticketInfo.seatNumber != null)
            _buildInfoRow('Seat', ticketInfo.seatNumber!),
          _buildInfoRow('Event', ticketInfo.eventName),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Color(0xFFFF6B35),
              strokeWidth: 3,
            ),
            SizedBox(height: 16),
            Text(
              'Validating ticket...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionDeniedView(TicketScanningViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white54,
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Camera Permission Required',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please grant camera permission to scan QR codes',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: viewModel.requestCameraPermission,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B35),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Grant Permission'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onViewModelReady(TicketScanningViewModel viewModel) {
    viewModel.initialize();
  }

  @override
  TicketScanningViewModel viewModelBuilder(BuildContext context) =>
      TicketScanningViewModel();

  @override
  void onDispose(TicketScanningViewModel viewModel) {
    viewModel.dispose();
    super.onDispose(viewModel);
  }
}

// Custom overlay shape for QR scanner
class QrScannerOverlayShape extends ShapeBorder {
  const QrScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderWidth = 2.0,
    this.borderRadius = 0,
    this.borderLength = 40,
    this.cutOutSize = 250,
  });

  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path()..addRect(rect);
    Path centerPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: rect.center,
            width: cutOutSize,
            height: cutOutSize,
          ),
          Radius.circular(borderRadius),
        ),
      );
    return Path.combine(PathOperation.difference, path, centerPath);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final center = rect.center;
    final cutOutRect = Rect.fromCenter(
      center: center,
      width: cutOutSize,
      height: cutOutSize,
    );

    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    // Draw corner brackets
    _drawCornerBracket(canvas, paint, cutOutRect.topLeft, true, true);
    _drawCornerBracket(canvas, paint, cutOutRect.topRight, false, true);
    _drawCornerBracket(canvas, paint, cutOutRect.bottomLeft, true, false);
    _drawCornerBracket(canvas, paint, cutOutRect.bottomRight, false, false);
  }

  void _drawCornerBracket(Canvas canvas, Paint paint, Offset corner,
      bool isLeft, bool isTop) {
    final path = Path();

    if (isLeft && isTop) {
      path.moveTo(corner.dx, corner.dy + borderLength);
      path.lineTo(corner.dx, corner.dy + borderRadius);
      path.arcToPoint(
        Offset(corner.dx + borderRadius, corner.dy),
        radius: Radius.circular(borderRadius),
      );
      path.lineTo(corner.dx + borderLength, corner.dy);
    } else if (!isLeft && isTop) {
      path.moveTo(corner.dx - borderLength, corner.dy);
      path.lineTo(corner.dx - borderRadius, corner.dy);
      path.arcToPoint(
        Offset(corner.dx, corner.dy + borderRadius),
        radius: Radius.circular(borderRadius),
      );
      path.lineTo(corner.dx, corner.dy + borderLength);
    } else if (isLeft && !isTop) {
      path.moveTo(corner.dx, corner.dy - borderLength);
      path.lineTo(corner.dx, corner.dy - borderRadius);
      path.arcToPoint(
        Offset(corner.dx + borderRadius, corner.dy),
        radius: Radius.circular(borderRadius),
      );
      path.lineTo(corner.dx + borderLength, corner.dy);
    } else {
      path.moveTo(corner.dx - borderLength, corner.dy);
      path.lineTo(corner.dx - borderRadius, corner.dy);
      path.arcToPoint(
        Offset(corner.dx, corner.dy - borderRadius),
        radius: Radius.circular(borderRadius),
      );
      path.lineTo(corner.dx, corner.dy - borderLength);
    }

    canvas.drawPath(path, paint);
  }

  @override
  ShapeBorder scale(double t) => QrScannerOverlayShape(
    borderColor: borderColor,
    borderWidth: borderWidth,
    borderRadius: borderRadius,
    borderLength: borderLength,
    cutOutSize: cutOutSize,
  );
}