import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:timezone/timezone.dart' as tz;
import '../models/medication_models.dart';

class MedicationReportService {
  const MedicationReportService();

  Future<File> exportCsv(
    List<MedicationDoseRecordLocal> records, {
    required Map<String, String> medicationNames,
  }) async {
    final rows = <String>[
      'medication,scheduled_at,recorded_at,taken_at,timezone,outcome,quantity,unit,corrected,note',
    ];
    for (final record in records) {
      rows.add(
        [
          _csv(medicationNames[record.medicationClientId] ?? 'Medication'),
          record.scheduledAt?.toUtc().toIso8601String() ?? '',
          record.recordedAt.toUtc().toIso8601String(),
          record.takenAt?.toUtc().toIso8601String() ?? '',
          _csv(record.timezone),
          record.outcome.name,
          record.doseQuantity,
          _csv(record.doseUnit),
          record.corrected,
          _csv(record.note ?? ''),
        ].join(','),
      );
    }
    final file = await _file('csv');
    return file.writeAsString(rows.join('\n'));
  }

  Future<File> exportPdf(
    List<MedicationDoseRecordLocal> records, {
    required Map<String, String> medicationNames,
  }) async {
    final document = pw.Document();
    document.addPage(
      pw.MultiPage(
        build: (_) => [
          pw.Text(
            'Qarr Track Medication Report',
            style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            'Generated ${DateFormat.yMMMd().add_jm().format(DateTime.now())}',
          ),
          pw.SizedBox(height: 18),
          pw.Text(
            'This report contains recorded dose outcomes. Unrecorded expected doses are not counted. Times are shown in the recorded schedule timezone.',
          ),
          pw.SizedBox(height: 16),
          pw.TableHelper.fromTextArray(
            headers: const [
              'Medication',
              'Scheduled',
              'Outcome',
              'Dose',
              'Taken / recorded',
              'Notes',
            ],
            data: records
                .map(
                  (record) => [
                    medicationNames[record.medicationClientId] ?? 'Medication',
                    record.scheduledAt == null
                        ? 'PRN'
                        : DateFormat('yyyy-MM-dd HH:mm').format(
                            tz.TZDateTime.from(
                              record.scheduledAt!,
                              tz.getLocation(record.timezone),
                            ),
                          ),
                    '${record.outcome.name}${record.corrected ? ' (corrected)' : ''}',
                    '${record.doseQuantity} ${record.doseUnit}',
                    DateFormat('yyyy-MM-dd HH:mm').format(
                          tz.TZDateTime.from(
                            record.takenAt ?? record.recordedAt,
                            tz.getLocation(record.timezone),
                          ),
                        ) +
                        '\n${record.timezone}',
                    record.note ?? '',
                  ],
                )
                .toList(),
          ),
        ],
      ),
    );
    final file = await _file('pdf');
    await file.writeAsBytes(await document.save());
    return file;
  }

  Future<File> _file(String extension) async {
    final root = await getApplicationDocumentsDirectory();
    final directory = Directory('${root.path}/medication_exports');
    await directory.create(recursive: true);
    return File(
      '${directory.path}/qarrtrack-medication-report-${DateFormat('yyyyMMdd-HHmmss').format(DateTime.now())}.$extension',
    );
  }

  String _csv(String value) {
    final safe = RegExp(r'^[=+\-@\t\r]').hasMatch(value) ? "'$value" : value;
    return '"${safe.replaceAll('"', '""')}"';
  }
}
