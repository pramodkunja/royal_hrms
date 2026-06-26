import 'package:flutter/material.dart';

class EmailTemplateMobileLayout extends StatelessWidget {
  const EmailTemplateMobileLayout({
    super.key,
    required this.header,
    required this.formKey,
    required this.formContent,
    required this.previewPanel,
    required this.tagsWidget,
    required this.footer,
    required this.screenHeight,
  });

  final Widget header;
  final GlobalKey<FormState> formKey;
  final Widget formContent;
  final Widget previewPanel;
  final Widget tagsWidget;
  final Widget footer;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: screenHeight,
      child: Column(
        children: [
          header,
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    formContent,
                    const SizedBox(height: 24),
                    previewPanel,
                    const SizedBox(height: 24),
                    tagsWidget,
                  ],
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          footer,
        ],
      ),
    );
  }
}

class EmailTemplateDesktopLayout extends StatelessWidget {
  const EmailTemplateDesktopLayout({
    super.key,
    required this.header,
    required this.formKey,
    required this.formContent,
    required this.previewPanel,
    required this.tagsWidget,
    required this.footer,
    required this.borderColor,
  });

  final Widget header;
  final GlobalKey<FormState> formKey;
  final Widget formContent;
  final Widget previewPanel;
  final Widget tagsWidget;
  final Widget footer;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1180, maxHeight: 780),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          const Divider(height: 1),
          Expanded(
            child: Form(
              key: formKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: formContent,
                    ),
                  ),
                  VerticalDivider(width: 1, color: borderColor),
                  Expanded(flex: 5, child: previewPanel),
                  VerticalDivider(width: 1, color: borderColor),
                  SizedBox(width: 200, child: tagsWidget),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          footer,
        ],
      ),
    );
  }
}
