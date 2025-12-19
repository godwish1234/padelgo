import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:padelgo/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BaseAgreement extends StatefulWidget {
  final String url;
  final ScrollController? controller;

  const BaseAgreement({super.key, required this.url, this.controller});

  @override
  State<BaseAgreement> createState() => _BaseAgreementState();
}

class _BaseAgreementState extends State<BaseAgreement> {
  final _controller = ScrollController();
  String htmlData = "";
  bool isLoading = true;
  bool useWebView = false;
  bool webViewFailed = false;
  Timer? _loadingTimeout;

  late WebViewController webController;

  @override
  void dispose() {
    _controller.dispose();
    _loadingTimeout?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.url.isNotEmpty) {
      webController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {},
            onPageStarted: (String url) {},
            onPageFinished: (String url) {
              _loadingTimeout?.cancel();

              Timer(const Duration(seconds: 3), () {
                if (mounted && useWebView && !webViewFailed) {
                  _checkWebViewContent();
                }
              });

              setState(() {
                isLoading = false;
              });
            },
            onWebResourceError: (WebResourceError error) {
              setState(() {
                webViewFailed = true;
                useWebView = false;
                isLoading = false;
                htmlData =
                    '<p style="padding: 20px; font-size: 16px; color: #333;">Unable to load agreement content using WebView. Please contact support if this issue persists.</p>';
              });
            },
          ),
        );

      fetchHtml();
    } else {
      if (kDebugMode) {
        print('BaseAgreement - URL is empty, not fetching HTML');
      }
    }
  }

  @override
  void didUpdateWidget(covariant BaseAgreement oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.url != widget.url && widget.url.isNotEmpty) {
      webController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {},
            onPageStarted: (String url) {},
            onPageFinished: (String url) {
              _loadingTimeout?.cancel();

              Timer(const Duration(seconds: 3), () {
                if (mounted && useWebView && !webViewFailed) {
                  _checkWebViewContent();
                }
              });

              setState(() {
                isLoading = false;
              });
            },
            onWebResourceError: (WebResourceError error) {
              setState(() {
                webViewFailed = true;
                useWebView = false;
                isLoading = false;
                htmlData =
                    '<p style="padding: 20px; font-size: 16px; color: #333;">Unable to load agreement content using WebView. Please contact support if this issue persists.</p>';
              });
            },
          ),
        );
      fetchHtml();
    }
  }

  Future<void> fetchHtml() async {
    String secureUrl = widget.url.trim();
    // if (widget.url.startsWith('http://')) {
    //   secureUrl = widget.url.replaceFirst('http://', 'https://');
    // }

    try {
      final response = await http.get(Uri.parse(secureUrl));
      if (response.statusCode == 200) {
        // final isSPA = response.body.contains('<div id="app"></div>') ||
        //     response.body.contains('id="app"') ||
        //     (response.body.contains('<script') &&
        //         extractBody(response.body).trim().length < 100);

        // if (isSPA) {
        setState(() {
          useWebView = true;
          isLoading = true;
          htmlData = response.body;
        });

        try {
          webController.loadRequest(Uri.parse(secureUrl));

          _loadingTimeout = Timer(const Duration(seconds: 10), () {
            if (mounted && isLoading && useWebView) {
              setState(() {
                webViewFailed = true;
                useWebView = false;
                isLoading = false;
                htmlData =
                    '<div style="padding: 20px;"><h3>Agreement Content</h3><p>The content took too long to load. Please try again or contact support.</p><p>Direct link: <a href="$secureUrl" target="_blank">$secureUrl</a></p></div>';
              });
            }
          });
        } catch (e) {
          setState(() {
            webViewFailed = true;
            useWebView = false;
            isLoading = false;
            htmlData =
                '<div style="padding: 20px;"><h3>Agreement Content</h3><p>The loan agreement content is available at: <a href="$secureUrl" target="_blank">$secureUrl</a></p><p>Please contact support for assistance accessing the agreement terms.</p></div>';
          });
        }
      } else {
        // Use Html widget for static content
        setState(() {
          htmlData = response.body;
          useWebView = false;
          isLoading = false;
        });
      }
      // } else {
      //   if (secureUrl != widget.url && response.statusCode == 404) {
      //     await _fetchHttpFallback();
      //   } else {
      //     setState(() {
      //       htmlData = "<p>Gagal memuat data</p>";
      //       useWebView = false;
      //       isLoading = false;
      //     });
      //   }
      // }
    } catch (e) {
      if (secureUrl != widget.url) {
        await _fetchHttpFallback();
      } else {
        setState(() {
          htmlData = "<p>Error: $e</p>";
          useWebView = false;
          isLoading = false;
        });
      }
    }
  }

  Future<void> _checkWebViewContent() async {
    try {
      final result = await webController.runJavaScriptReturningResult(
          "document.body.innerText.trim().length > 0 ? document.body.innerText.trim() : 'EMPTY'");

      final contentText = result.toString().toLowerCase();
      final hasValidContent = contentText.contains('perjanjian') ||
          contentText.contains('agreement') ||
          contentText.contains('contract') ||
          contentText.contains('pinjam') ||
          contentText.length > 100;

      if (result.toString().contains('EMPTY') ||
          result.toString().length < 20 ||
          (!hasValidContent &&
              (contentText.contains('error') ||
                  contentText.contains('network')))) {
        await _fetchAgreementContentDirectly();
      } else {
        if (kDebugMode) {
          print(
              'BaseAgreement - WebView content loaded successfully, keeping WebView display');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(
            'BaseAgreement - Keeping WebView display despite content check error');
      }
    }
  }

  Future<void> _fetchAgreementContentDirectly() async {
    final uri = Uri.parse(widget.url);
    final token = uri.queryParameters['token'];

    if (token != null) {
      try {
        const apiUrl =
            'https://sta.openapi.uangme.com/finmart/internal/agreement/detail';
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: '{"token": "$token"}',
        );

        if (response.statusCode == 200) {
          try {
            final data = json.decode(response.body);
            String agreementContent = '';

            if (data['data'] != null && data['data']['content'] != null) {
              agreementContent = data['data']['content'];
            } else if (data['content'] != null) {
              agreementContent = data['content'];
            } else if (data['agreement'] != null) {
              agreementContent = data['agreement'];
            } else {
              agreementContent = response.body;
            }

            setState(() {
              webViewFailed = true;
              useWebView = false;
              htmlData = '<div style="padding: 20px;">$agreementContent</div>';
            });

            if (kDebugMode) {
              print(
                  'BaseAgreement - Successfully loaded content from direct API');
            }
            return;
          } catch (e) {
            if (kDebugMode) {
              print('BaseAgreement - Error parsing API response: $e');
            }
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('BaseAgreement - Error with direct API call: $e');
        }
      }
    }

    // Final fallback - show a helpful message
    setState(() {
      webViewFailed = true;
      useWebView = false;
      htmlData = '''
        <div style="padding: 20px; font-family: Arial, sans-serif;">
          <h3 style="color: #333; margin-bottom: 16px;">Loan Agreement</h3>
          <p style="color: #666; line-height: 1.5; margin-bottom: 16px;">
            The loan agreement content could not be loaded due to security restrictions. 
            This is typically caused by mixed content policies on secure connections.
          </p>
          <p style="color: #666; line-height: 1.5; margin-bottom: 16px;">
            <strong>What you can do:</strong>
          </p>
          <ul style="color: #666; line-height: 1.5; margin-bottom: 16px;">
            <li>Contact our support team for assistance</li>
            <li>Request the agreement document via email</li>
            <li>Visit our office for a physical copy</li>
          </ul>
          <p style="color: #999; font-size: 12px;">
            Direct link: <a href="${widget.url}" target="_blank" style="color: #007bff;">${widget.url}</a>
          </p>
        </div>
      ''';
    });
  }

  Future<void> _fetchHttpFallback() async {
    try {
      final response = await http.get(Uri.parse(widget.url));
      if (response.statusCode == 200) {
        setState(() {
          htmlData =
              '<div style="padding: 20px;"><h3>Agreement Content</h3><p>Content loaded from: ${widget.url}</p><div>${response.body}</div></div>';
          useWebView = false;
          isLoading = false;
        });
      } else {
        setState(() {
          htmlData =
              "<p>Failed to load content from both HTTPS and HTTP sources</p>";
          useWebView = false;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        htmlData =
            '<div style="padding: 20px;"><h3>Agreement Content</h3><p>Unable to load agreement content. The content is available at: <a href="${widget.url}" target="_blank">${widget.url}</a></p><p>Please contact support for assistance.</p></div>';
        useWebView = false;
        isLoading = false;
      });
    }
  }

  String extractBody(String html) {
    final bodyRegExp =
        RegExp(r"<body[^>]*>([\s\S]*)<\/body>", caseSensitive: false);
    final match = bodyRegExp.firstMatch(html);
    final extractedContent = match != null ? match.group(1)! : html;

    if (extractedContent.trim().isEmpty ||
        extractedContent.trim().length < 10) {
      return html;
    }

    return extractedContent;
  }

  String extractStyle(String html) {
    final styleRegExp =
        RegExp(r"<style[^>]*>([\s\S]*?)<\/style>", caseSensitive: false);
    final match = styleRegExp.firstMatch(html);
    return match != null ? match.group(1)! : "";
  }

  Map<String, Style> parseCss(String css) {
    final Map<String, Style> styles = {};

    final ruleRegExp = RegExp(r'([^{]+)\{([^}]+)\}');
    for (final match in ruleRegExp.allMatches(css)) {
      final selector = match.group(1)!.trim();
      final declarations = match.group(2)!;

      final Map<String, String> props = {};
      for (final decl in declarations.split(";")) {
        if (decl.trim().isEmpty) continue;
        final parts = decl.split(":");
        if (parts.length == 2) {
          props[parts[0].trim()] = parts[1].trim();
        }
      }

      Style style = Style();
      if (props.containsKey("color")) {
        if (props["color"] == "white") {
          style = style.copyWith(color: Colors.white);
        }
        if (props["color"] == "black") {
          style = style.copyWith(color: Colors.black);
        }
      }
      if (props.containsKey("background-color")) {
        if (props["background-color"] == "black") {
          style = style.copyWith(backgroundColor: Colors.black);
        }
        if (props["background-color"] == "white") {
          style = style.copyWith(backgroundColor: Colors.white);
        }
      }
      if (props.containsKey("font-size")) {
        final size = double.tryParse(props["font-size"]!.replaceAll("px", ""));
        if (size != null) style = style.copyWith(fontSize: FontSize(size));
      }

      styles[selector] = style;
    }

    return styles;
  }

  @override
  Widget build(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: BaseColors.grey500, borderRadius: BorderRadius.circular(16)),
      child: widget.url.isNotEmpty
          ? isLoading
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text(
                          'Loading agreement...',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: WebViewWidget(controller: webController),
                  ),
                )
          : const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Agreement content is not available at the moment.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ));
}
