import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/item_helper.dart';
import 'package:inventario_cea_va/models/item.dart';
import 'package:inventario_cea_va/presentation/pages/inventario_page/widgets/item_content.dart';
import 'package:inventario_cea_va/presentation/providers/item_provider.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:line_icons/line_icons.dart';
import 'widgets/expanded_theme.dart';

class InventarioPage extends ConsumerWidget {
  InventarioPage({Key? key}) : super(key: key);
  final TextEditingController _tfBuscarItemController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final listaItems = ref.watch(listaItemsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(LineIcons.listUl),
        title: const Text('Inventario'),
        actions: [
          AnimSearchBar(
            helpText: 'Buscar...',
            animationDurationInMilli: 500,
            color: AppTheme.secondaryColor,
            textFieldColor: AppTheme.secondaryColor,
            width: size.width * .55,
            rtl: true,
            textController: _tfBuscarItemController,
            onSuffixTap: () => _tfBuscarItemController.clear(),
            onSubmitted: (String value) async {
              ItemHelper helper = ItemHelper();
              List<Item> itemsFiltrados = await helper.getItemsByName(value);
              ref.read(listaItemsProvider.notifier).update((state) => itemsFiltrados);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ExpandedTileList.builder(
                itemCount: listaItems.length,
                maxOpened: 3,
                itemBuilder: (context, index, controller) {
                  Item item = listaItems[index];
                  return ExpandedTile(
                    expansionDuration: const Duration(milliseconds: 500),
                    expansionAnimationCurve: Curves.easeInOut,
                    title: Text(
                      item.nombre,
                      style: GoogleFonts.lilitaOne(
                        color: AppTheme.secondaryColor,
                        fontSize: 18,
                      ),
                    ),
                    content: ItemContent(item),
                    controller: controller,
                    theme: expandedThemeTile,
                  );
                },
              ),
            ),
            const Text('Texto Visible')
          ],
        ),
      ),
    );
  }
}
