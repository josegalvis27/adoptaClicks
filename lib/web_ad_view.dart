// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;


/// Función para registrar el anuncio (solo se usa en web)
void registerPropellerAdsView() {
  // Registrar el widget HTML con script PropellerAds
  ui_web.platformViewRegistry.registerViewFactory(
    'propeller-ads-banner',
    (int viewId) {
      final element = html.DivElement();
      element.setInnerHtml(
        '''
        <!-- Reemplaza esta URL por la de tu script PropellerAds -->
        <script async data-cfasync="false" src="https://example.propelcdn.com/tag.js?z=1234567"></script>
        ''',
        treeSanitizer: html.NodeTreeSanitizer.trusted,
      );
      return element;
    },
  );
}
