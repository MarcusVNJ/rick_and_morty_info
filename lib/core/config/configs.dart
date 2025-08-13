import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class Configs {

  static Map<dynamic, dynamic>? _config;

  static Future<void> load() async {

    final String content = await rootBundle.loadString('assets/config/settings.yaml');

    _config = loadYaml(content);
  }

  static Map get(String key) {
    if (_config == null) {
      throw Exception(
          "As configurações não foram carregadas! Chame AppSettings.load() antes.");
    }
    if (!_config!.containsKey(key)) {
      throw Exception("A chave de configuração '$key' não foi encontrada.");
    }
    return _config![key];
  }

  static Map get apiInfo {
    return get('rick_and_morty_api');
  }

}