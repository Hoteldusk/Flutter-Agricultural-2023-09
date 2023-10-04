import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_info.dart';

const sampleURL =
    "https://www.kamis.or.kr/service/price/xml.do?action=dailySalesList&p_cert_key=$apiKey&p_cert_id=$apiId&p_returntype=json";

class KamisOpenAPI {
  static Future<dynamic> loadAPI() async {
    dynamic response;

    try {
      response = await http.get(Uri.parse(sampleURL));
    } catch (e) {
      debugPrint("http 요청오류: $e");
    }

    if (response != null) {
      // debugPrint(response.body); // 또는 원하는 응답 데이터 처리
      var result = jsonDecode(response.body);

      return result; // 응답 반환
    }

    return null; // 에러 처리 또는 응답이 없을 때 null 반환
  }
}
