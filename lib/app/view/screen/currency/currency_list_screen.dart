import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mymoneyorganizer/app/core/common/model/read/currency_model.dart';
import 'package:mymoneyorganizer/app/eventbus/eventbus_core.dart';
import 'package:mymoneyorganizer/app/eventbus/events/base/currency_changed.dart';
import 'package:mymoneyorganizer/app/lib/localization/utils.dart';
import 'package:mymoneyorganizer/app/view/common/app_bar/app_bar_builder.dart';
import 'package:mymoneyorganizer/app/view/common/drawer/app_drawer_builder.dart';
import 'package:mymoneyorganizer/app/view/common/util/color_utils.dart';
import 'package:mymoneyorganizer/app/view/common/util/generated_confirm_text_4_deleted.dart';
import 'package:mymoneyorganizer/app/view/screen/currency/currency_detail_screen.dart';
import 'package:mymoneyorganizer/app/viewmodel/currency/currency_list.dart';

enum MenuItem { edit, delete, setAsDefault }

//TODO make Stateless and split into screen and list (see account)
class CurrencyListScreen extends StatefulWidget {
  static const String routeName = '/currencyList';

  final ScrollController _scrollController = ScrollController();

  CurrencyListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

// ==================================================================

class _State extends State<CurrencyListScreen> with TickerProviderStateMixin {
  final List<CurrencyListReadModel> currencyList = [];
  final CurrencyListViewModel viewModel = CurrencyListViewModelBuilder.build();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  bool _visibleDelButton = false;
  bool _selectMode = false;

  late AnimationController _animationController;
  late AnimationController _animationControllerFab;
  late Animation<double> _animationBtnMenu;

  @override
  void initState() {
    super.initState();
    // =========================
    viewModel.event.listen((CurrencyListNotification event) => _viewModelEventDispatch(event));
    EventBusCore.getInstance().events.listen((event) {
      if (event is CurrencyChangedEvent) {
        viewModel.load();
      }
    });
    viewModel.load();
    // =========================
    _animationController = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _animationControllerFab = AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _animationBtnMenu = CurvedAnimation(
      curve: Curves.linear,
      parent: _animationController,
    );
    _animationController.forward();
    _animationControllerFab.forward();
  }

  @override
  void dispose() {
    viewModel.dispose();
    _animationController.dispose();
    _animationControllerFab.dispose();
    super.dispose();
  }

  // =====================================================

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: _scaffoldState,
        drawer: AppDrawerBuilder.buildAppDrawer(),
        appBar: AppBarBuilder.buildAppBar(
          context: context,
          title: Text(t('currency.list.title')),
          //scrollController: widget._scrollController,
          leading: _buildAppBarLeading(context),
          action: [_buildAppBarActionContainer()],
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: _handleScrollNotify,
          child: ListView.builder(
            controller: widget._scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: currencyList.length,
            itemBuilder: (context, index) => _buildItem(index: index),
          ),
        ),
        floatingActionButton: ScaleTransition(
          scale: _animationControllerFab,
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyDetailScreen()));
            },
          ),
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

  /* =========================AppBar=================================== */

  Widget? _buildAppBarLeading(BuildContext context) {
    //if (!_selectMode) return null;
    return GestureDetector(
      child: Material(
        color: Theme.of(context).primaryColor,
        type: MaterialType.circle,
        child: Center(
          child: AnimatedIcon(
            icon: AnimatedIcons.arrow_menu,
            progress: _animationBtnMenu,
          ),
        ),
      ),
      onTap: () => {
        _selectMode ? _setSelectMode(false) : _scaffoldState.currentState?.openDrawer(),
      },
    );
  }

  AnimatedContainer _buildAppBarActionContainer() {
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
      width: _visibleDelButton ? 48 : 0,
      child: AnimatedOpacity(
        opacity: _visibleDelButton ? 1 : 0,
        duration: kThemeAnimationDuration,
        child: IconButton(
          icon: const Icon(Icons.delete_rounded),
          onPressed: () {
            List<String> idLst = [];
            for (var element in currencyList) {
              if (element.selected) {
                idLst.add(element.id);
              }
            }
            _deleteElements(idLst);
          },
        ),
      ),
    );
  }

  /* =========================Item===================================== */
  Widget _buildItem({required int index}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildSelectedCheckbox(index: index),
        Expanded(
          child: _buildItemContent(index: index),
        ),
      ],
    );
  }

  Widget _buildItemContent({required int index}) {
    ThemeData _theme = Theme.of(context);
    CardTheme _cardTheme = CardTheme.of(context);
    bool isNotDefault = !currencyList[index].isDefault;
    return Padding(
      padding: const EdgeInsets.all(3),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: currencyList[index].selected
              ? ColorUtils.similarColor(bg: _theme.cardColor, c1: Colors.blue.shade100, c2: Colors.blueGrey.shade900)
              : _theme.cardColor,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            currencyList[index].selected
                ? BoxShadow(color: _cardTheme.shadowColor ?? _theme.shadowColor, blurRadius: 3, spreadRadius: 2, offset: const Offset(2, 3))
                : BoxShadow(color: _cardTheme.shadowColor ?? _theme.shadowColor, blurRadius: 0, spreadRadius: 0, offset: const Offset(0, 0))
          ],
        ),
        duration: kThemeAnimationDuration,
        child: Material(
          type: MaterialType.transparency,
          child: Ink(
            child: InkWell(
              onTap: () => _itemOnTap(index),
              onLongPress: () => _itemOnLongPress(index),
              child: Row(
                children: [
                  _buildAvatar(index: index),
                  _buildVerticalDivider(),
                  _buildNameSection(index: index),
                  const Spacer(flex: 1),
                  _buildPopUpButton(isNotDefault, index),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar({required int index}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CircleAvatar(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              currencyList[index].symbol,
              style: const TextStyle(fontSize: 48),
            ),
          ),
        ),
        backgroundColor: Color(currencyList[index].avatarColor),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    //TODO
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        color: Colors.grey.shade300,
        width: 1,
        height: 45,
      ),
    );
  }

  Widget _buildNameSection({required int index}) {
    //TODO
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currencyList[index].name,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.left,
          ),
          Text(
            currencyList[index].id,
            style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildPopUpButton(bool isNotDefault, int index) {
    return AnimatedOpacity(
      opacity: _selectMode ? 0 : 1,
      duration: kThemeAnimationDuration,
      child: PopupMenuButton(
        itemBuilder: (context) => <PopupMenuEntry<MenuItem>>[
          if (isNotDefault)
            PopupMenuItem<MenuItem>(
              value: MenuItem.setAsDefault,
              child: Text(t('currency.list.menu.set_default')),
              enabled: isNotDefault,
            ),
          if (isNotDefault)
            const PopupMenuDivider(
              height: 2,
            ),
          PopupMenuItem<MenuItem>(
            value: MenuItem.edit,
            child: Text(t('currency.list.menu.edit')),
          ),
          const PopupMenuDivider(
            height: 2,
          ),
          PopupMenuItem<MenuItem>(
            value: MenuItem.delete,
            child: Text(t('currency.list.menu.delete')),
          ),
        ],
        onSelected: (MenuItem result) => _contextMenuDispatch(result, index),
        enabled: !_selectMode,
      ),
    );
  }

  // if selectedMode
  Widget _buildSelectedCheckbox({required int index}) {
    return AnimatedSize(
      duration: kThemeAnimationDuration,
      //vsync: this,
      child: Column(
        children: [
          SizedBox(
            width: _selectMode ? 28 : 0,
            height: 28,
            child: AnimatedOpacity(
              opacity: _selectMode ? 1 : 0,
              duration: kThemeAnimationDuration,
              child: Checkbox(
                value: currencyList[index].selected,
                shape: const CircleBorder(),
                onChanged: (value) {
                  setState(() {
                    currencyList[index].selected = value!;
                    _visibleDelButton = currencyList.any((element) => element.selected);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* =============================logic============================== */
  //BackButton
  Future<bool> _onWillPop() async {
    bool _returnFlag = false;
    if (_selectMode) {
      _setSelectMode(false);
    } else {
      _returnFlag = true;
    }
    return _returnFlag;
  }

  void _setSelectMode(bool mode) {
    if (_selectMode == mode) return;
    setState(() {
      _selectMode = mode;
      if (_selectMode) {
        _animationController.reverse();
        _visibleDelButton = true;
      } else {
        _animationController.forward();
        _visibleDelButton = false;
        for (var element in currencyList) {
          element.selected = false;
        }
      }
    });
  }

  //Show/hide FAB
  bool _handleScrollNotify(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _animationControllerFab.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _animationControllerFab.reverse();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  //Listener change currency list
  void _viewModelEventDispatch(CurrencyListNotification event) {
    if (event is ResultCurrencyListNotification) {
      return setState(() {
        currencyList.clear();
        currencyList.addAll(event.currencyList!);
      });
    }
  }

  //Context menu:
  void _contextMenuDispatch(MenuItem item, int index) {
    if (item == MenuItem.edit) {
      _openElement(index);
    }
    if (item == MenuItem.delete) {
      _deleteElements([currencyList[index].id]);
    }
    if (item == MenuItem.setAsDefault) {
      _setAsDefault(index);
    }
  }

  //element(s) action
  void _setAsDefault(int index) {
    viewModel.setAsDefault(currencyList[index].id);
  }

  void _openElement(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CurrencyDetailScreen(currencyId: currencyList[index].id),
      ),
    );
  }

  void _deleteElements(List<String> listId) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        //title: Text(S.of(context).confirm),
        content: Text(buildTextToConfirmDelete(confirmData: listId, what: t('currency.name'))),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'cancel'),
            child: Text(t('common.button.cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'ok'),
            child: Text(t('common.button.ok')),
          ),
        ],
      ),
    ).then((value) {
      if (value != null) {
        if (value == 'ok') {
          viewModel.delete(listId);
          _setSelectMode(false);
        }
      }
    });
  }

  //list action
  void _itemOnTap(int index) {
    if (_selectMode) {
      setState(() {
        currencyList[index].selected = !currencyList[index].selected;
        _visibleDelButton = currencyList.any((element) => element.selected);
      });
    } else {
      _openElement(index);
    }
  }

  void _itemOnLongPress(int index) {
    currencyList[index].selected = true;
    _setSelectMode(true);
  }
}
