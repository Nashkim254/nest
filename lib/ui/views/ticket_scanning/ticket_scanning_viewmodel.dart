import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/event_service.dart';

class TicketScanningViewModel extends BaseViewModel {
  final eventService = locator<EventService>();
  // Camera controller
  MobileScannerController? _cameraController;
  MobileScannerController get cameraController => _cameraController!;

  // Permission state
  bool _hasPermission = false;
  bool get hasPermission => _hasPermission;

  // Scanner state
  bool _isPaused = false;
  bool _isFlashOn = false;
  bool _isValidating = false;
  bool _showScanResult = false;

  bool get isPaused => _isPaused;
  bool get isFlashOn => _isFlashOn;
  bool get isValidating => _isValidating;
  bool get showScanResult => _showScanResult;

  // Scan statistics
  int _scannedCount = 0;
  int _validCount = 0;

  int get scannedCount => _scannedCount;
  int get validCount => _validCount;

  // Current event context
  String _eventName = '';
  int? _eventId;

  String get eventName => _eventName;

  // Last scan result
  ScanResult? _lastScanResult;
  ScanResult? get lastScanResult => _lastScanResult;

  // Instruction text
  String get instructionText {
    if (_isPaused) return 'Scanning paused - Tap resume to continue';
    if (_isValidating) return 'Validating ticket...';
    return 'Position QR code within the frame to scan';
  }

  // Scan history
  final List<ScanHistoryItem> _scanHistory = [];
  List<ScanHistoryItem> get scanHistory => List.unmodifiable(_scanHistory);

  // Initialize the scanner
  Future<void> initialize({String? eventName, int? eventId}) async {
    setBusy(true);

    try {
      _eventName = eventName ?? '';
      _eventId = eventId;

      await _requestCameraPermission();

      if (_hasPermission) {
        _initializeCamera();
      }
    } catch (e) {
      setError('Failed to initialize scanner: ${e.toString()}');
    } finally {
      setBusy(false);
    }
  }

  void _initializeCamera() {
    _cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
    );
  }

  // Permission handling
  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    _hasPermission = status == PermissionStatus.granted;
    notifyListeners();
  }

  Future<void> requestCameraPermission() async {
    await _requestCameraPermission();
    if (_hasPermission) {
      _initializeCamera();
    }
  }

  // Camera controls
  Future<void> toggleFlash() async {
    if (_cameraController == null) return;

    try {
      await _cameraController!.toggleTorch();
      _isFlashOn = !_isFlashOn;
      notifyListeners();
    } catch (e) {
      _showError('Failed to toggle flash');
    }
  }

  Future<void> switchCamera() async {
    if (_cameraController == null) return;

    try {
      await _cameraController!.switchCamera();
      notifyListeners();
    } catch (e) {
      _showError('Failed to switch camera');
    }
  }

  // Scanning controls
  void togglePause() {
    if (_cameraController == null) return;

    if (_isPaused) {
      _cameraController!.start();
      _isPaused = false;
    } else {
      _cameraController!.stop();
      _isPaused = true;
    }

    notifyListeners();
  }

  // QR Code detection
  Future<void> onQRCodeDetected(BarcodeCapture capture) async {
    if (_isPaused || _isValidating || capture.barcodes.isEmpty) return;

    final barcode = capture.barcodes.first;
    final qrData = barcode.rawValue;

    if (qrData == null || qrData.isEmpty) return;

    // Pause scanning during validation
    _isPaused = true;
    _isValidating = true;
    notifyListeners();

    try {
      // Validate the ticket
      final result = await eventService.validateTicket(
        qrData: qrData,
        eventId: _eventId,
      );

      // Update statistics
      _scannedCount++;
      if (result.isValid) {
        _validCount++;
      }

      // Add to history
      _scanHistory.insert(
          0,
          ScanHistoryItem(
            qrData: qrData,
            result: result,
            timestamp: DateTime.now(),
          ));

      // Store result and show overlay
      _lastScanResult = result;
      _showScanResult = true;

      // Provide haptic feedback
      if (result.isValid) {
        HapticFeedback.lightImpact();
      } else {
        HapticFeedback.vibrate();
      }

      notifyListeners();
    } catch (e) {
      _showError('Failed to validate ticket: ${e.toString()}');
    } finally {
      _isValidating = false;
      notifyListeners();
    }
  }

  // Result handling
  void hideScanResult() {
    _showScanResult = false;
    _isPaused = false;
    _cameraController?.start();
    notifyListeners();
  }

  // Manual entry
  Future<void> showManualEntry(BuildContext context) async {
    final controller = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        title: const Text(
          'Manual Ticket Entry',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Enter ticket ID or QR code data',
            hintStyle: TextStyle(color: Colors.white54),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF6B35)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFF6B35)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
            ),
            child: const Text('Validate'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      await _validateManualEntry(result);
    }
  }

  Future<void> _validateManualEntry(String ticketData) async {
    _isValidating = true;
    notifyListeners();

    try {
      final result = await eventService.validateTicket(
        qrData: ticketData,
        eventId: _eventId,
      );

      _scannedCount++;
      if (result.isValid) {
        _validCount++;
      }

      _scanHistory.insert(
          0,
          ScanHistoryItem(
            qrData: ticketData,
            result: result,
            timestamp: DateTime.now(),
            isManual: true,
          ));

      _lastScanResult = result;
      _showScanResult = true;

      notifyListeners();
    } catch (e) {
      _showError('Failed to validate ticket: ${e.toString()}');
    } finally {
      _isValidating = false;
      notifyListeners();
    }
  }

  // History management
  void showScanHistory() {
    // This would typically navigate to a history screen
    // For now, we'll just log the count
    _showInfo('Scanned ${_scanHistory.length} tickets total');
  }

  Future<void> loadScanHistoryFromApi() async {
    if (_eventId == null) return;

    try {
      setBusy(true);
      final history = await eventService.getTicketScanHistory(eventId: _eventId!);
      _scanHistory.clear();
      _scanHistory.addAll(history);
      
      // Update statistics from loaded history
      _scannedCount = history.length;
      _validCount = history.where((item) => item.result.isValid).length;
      
      notifyListeners();
    } catch (e) {
      _showError('Failed to load scan history: ${e.toString()}');
    } finally {
      setBusy(false);
    }
  }

  // Batch validation for multiple tickets
  Future<void> validateMultipleTickets(List<String> qrDataList) async {
    if (qrDataList.isEmpty) return;

    setBusy(true);
    try {
      final results = await eventService.validateMultipleTickets(
        qrDataList: qrDataList,
        eventId: _eventId,
      );

      // Update statistics and history
      for (int i = 0; i < results.length; i++) {
        final result = results[i];
        final qrData = qrDataList[i];
        
        _scannedCount++;
        if (result.isValid) {
          _validCount++;
        }

        _scanHistory.insert(
          0,
          ScanHistoryItem(
            qrData: qrData,
            result: result,
            timestamp: DateTime.now(),
            isManual: true,
          ),
        );
      }

      notifyListeners();

      final validCount = results.where((r) => r.isValid).length;
      _showInfo('Validated ${results.length} tickets: ${validCount} valid, ${results.length - validCount} invalid');

    } catch (e) {
      _showError('Batch validation failed: ${e.toString()}');
    } finally {
      setBusy(false);
    }
  }

  // Export scan history
  Future<String> exportScanHistory() async {
    try {
      final buffer = StringBuffer();
      buffer.writeln('Event: $_eventName');
      buffer.writeln('Export Date: ${DateTime.now().toIso8601String()}');
      buffer.writeln('Total Scanned: $_scannedCount');
      buffer.writeln('Valid Tickets: $_validCount');
      buffer.writeln('Invalid Tickets: ${_scannedCount - _validCount}');
      buffer.writeln('---');
      buffer.writeln('QR Data,Status,Message,Timestamp,Entry Type');
      
      for (final item in _scanHistory) {
        buffer.writeln(
          '${item.qrData},'
          '${item.result.isValid ? 'VALID' : 'INVALID'},'
          '"${item.result.message}",'
          '${item.timestamp.toIso8601String()},'
          '${item.isManual ? 'MANUAL' : 'SCANNED'}'
        );
      }
      
      return buffer.toString();
    } catch (e) {
      _showError('Failed to export scan history: ${e.toString()}');
      return '';
    }
  }

  // Clear scan history
  void clearScanHistory() {
    _scanHistory.clear();
    _scannedCount = 0;
    _validCount = 0;
    notifyListeners();
  }

  // Get validation statistics
  Map<String, dynamic> getValidationStats() {
    final invalidCount = _scannedCount - _validCount;
    final validPercentage = _scannedCount > 0 ? (_validCount / _scannedCount * 100) : 0;
    
    return {
      'total_scanned': _scannedCount,
      'valid_tickets': _validCount,
      'invalid_tickets': invalidCount,
      'valid_percentage': validPercentage,
      'scan_history_count': _scanHistory.length,
    };
  }

  // Helper methods
  void _showError(String message) {
    setError(message);
    HapticFeedback.vibrate();
  }

  void _showInfo(String message) {
    // You can implement a snackbar or toast here
    debugPrint('Info: $message');
  }

  // Cleanup
  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}

// Data models
class ScanResult {
  final bool isValid;
  final String message;
  final TicketInfo? ticketInfo;
  final String? errorCode;

  ScanResult({
    required this.isValid,
    required this.message,
    this.ticketInfo,
    this.errorCode,
  });
}

class TicketInfo {
  final String ticketId;
  final String holderName;
  final String ticketType;
  final String eventName;
  final String? seatNumber;
  final DateTime? scanTime;
  final bool isFirstScan;

  TicketInfo({
    required this.ticketId,
    required this.holderName,
    required this.ticketType,
    required this.eventName,
    this.seatNumber,
    this.scanTime,
    this.isFirstScan = true,
  });
}

class ScanHistoryItem {
  final String qrData;
  final ScanResult result;
  final DateTime timestamp;
  final bool isManual;

  ScanHistoryItem({
    required this.qrData,
    required this.result,
    required this.timestamp,
    this.isManual = false,
  });
}
