import 'dart:convert';

import 'package:curious_if/app/services/client/client_service.dart';

import '../../../core/core.dart';
import '../model/get_report.dart';
import '../model/report_comment.dart';
import '../model/report_post.dart';

abstract class IReportsRepository {
  Future<String> reportPost(ReportPost report, String token);
  Future<List<GetReport>> getReports(String token);
  Future<String> reportComment(ReportComment report, String token);
  Future<String> acceptReport(String idReport, String token);
  Future<String> deleteReport(String idReport, String token);
  void dispose();
}

class ReportsRepository implements IReportsRepository {
  final ClientService _datasource;
  final String server = UtilsConst.server;

  ReportsRepository({required ClientService datasource})
      : _datasource = datasource;

  @override
  Future<String> reportPost(ReportPost report, String token) async {
    try {
      String response = await _datasource.post(
        Uri.parse("${server}api/reports/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          "postId": report.postId,
          "content": report.content,
          "type": report.type
        }),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GetReport>> getReports(String token) async {
    try {
      String response = await _datasource.get(
        Uri.parse("${server}api/reports/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      List<GetReport> getReports = GetReport.fromJsonList(response);
      return getReports;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> reportComment(ReportComment report, String token) async {
    try {
      String response = await _datasource.post(
        Uri.parse("${server}api/reports/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          "postId": report.postId,
          "commentId": report.commentId,
          "content": report.content,
          "type": report.type
        }),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> acceptReport(String idReport, String token) async {
    try {
      String response = await _datasource.delete(
        Uri.parse("${server}api/reports/accept/$idReport"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteReport(String idReport, String token) async {
    try {
      String response = await _datasource.delete(
        Uri.parse("${server}api/reports/dismiss/$idReport"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _datasource.dispose();
  }
}
