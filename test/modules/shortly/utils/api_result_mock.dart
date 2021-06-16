const String successResult = '''
{
    "ok": true,
    "result": {
        "code": "kq5546",
        "short_link": "shrtco.de/kq5546",
        "full_short_link": "https://shrtco.de/kq5546",
        "short_link2": "9qr.de/kq5546",
        "full_short_link2": "https://9qr.de/kq5546",
        "short_link3": "shiny.link/kq5546",
        "full_short_link3": "https://shiny.link/kq5546",
        "share_link": "shrtco.de/share/kq5546",
        "full_share_link": "https://shrtco.de/share/kq5546",
        "original_link": "https://flutter.dev/docs/get-started/install/macos"
    }
}
''';

const String errorResult = '''
{
    "ok": false,
    "error_code": 2,
    "error": "This is not a valid URL, for more infos see shrtco.de/docs"
}
''';
