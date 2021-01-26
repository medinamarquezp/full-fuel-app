import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:toast/toast.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/button_loading_widget.dart';
import 'package:fullfuel_app/src/widgets/safe_scaffold_widget.dart';
import 'package:fullfuel_app/src/widgets/form_field_container_widget.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';
import 'package:fullfuel_app/src/repositories/db/favourites_db_repo.dart';
import 'package:fullfuel_app/src/repositories/remote/subscriptions_remote_repo.dart';

class NotificationsForm extends StatefulWidget {
  const NotificationsForm({Key key}) : super(key: key);

  @override
  _NotificationsFormState createState() => _NotificationsFormState();
}

class _NotificationsFormState extends State<NotificationsForm> {
  final notificationsBox = Hive.box('notifications');
  final favouritesBox = Hive.box<FuelstationListEntity>('favourites');
  int _selectedFuelStation;
  int _editingSelectedFuelStation;
  String _selectedFuelType;
  String _editingSelectedFuelType;
  String _pageTitle = "Nueva notificación";
  String _actionButtonLabel = "Guardar notificación";
  List<Map<String, dynamic>> _fuelStationList = [];

  @override
  void initState() {
    super.initState();
    _getFuelStations();
  }

  void _getFuelStations() {
    FavouritesDBRepo favouritesRepo = FavouritesDBRepo(favouritesBox);
    final favourites = favouritesRepo.getList().toList();
    for (var fuelstation in favourites) {
      var item = {
        'value': fuelstation.fuelstationID.toString(),
        'label': fuelstation.name,
        'textStyle': TextStyle(fontSize: 16, color: FullfuelColors.primary)
      };
      _fuelStationList.add(item);
    }
  }

  Future<void> _saveData(AnimationController controller) async {
    final subscriptionRepo = new SubscriptionsRemoteRepo();
    if (_selectedFuelStation == _editingSelectedFuelStation &&
        _selectedFuelType == _editingSelectedFuelType) {
      Toast.show("No se han detectado cambios", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else if (_editingSelectedFuelStation == null &&
        _editingSelectedFuelType == null) {
      controller.forward();
      await subscriptionRepo.subscribe(
          fuelstationID: _selectedFuelStation, fuelType: _selectedFuelType);
      await notificationsBox.put(_selectedFuelStation, _selectedFuelType);
      controller.reset();
      Toast.show("Cambios realizados correctamente", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      Navigator.of(context).pop();
    } else {
      controller.forward();
      await subscriptionRepo.unsubscribe(
          fuelstationID: _editingSelectedFuelStation,
          fuelType: _editingSelectedFuelType);
      await notificationsBox.delete(_editingSelectedFuelStation);
      await subscriptionRepo.subscribe(
          fuelstationID: _selectedFuelStation, fuelType: _selectedFuelType);
      await notificationsBox.put(_selectedFuelStation, _selectedFuelType);
      controller.reset();
      Toast.show("Cambios realizados correctamente", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null && arguments['isCreating'] == false) {
      _editingSelectedFuelStation = arguments['selectedFuelStation'];
      _editingSelectedFuelType = arguments['selectedFuelType'];
      _selectedFuelStation = _editingSelectedFuelStation;
      _selectedFuelType = _editingSelectedFuelType;
      _pageTitle = "Editar notificación";
      _actionButtonLabel = "Editar notificación";
      arguments['isCreating'] = true;
    }

    return SafeScaffoldWidget(
      pageTitle: _pageTitle,
      page: _configPage(),
      pageIndex: 2,
    );
  }

  Column _configPage() {
    return Column(
      children: [
        _fuelStations(),
        _fuelTypes(),
        ButtonLoadingWidget(
          label: _actionButtonLabel,
          fn: _saveData,
        ),
      ],
    );
  }

  FormFieldContainerWidget _fuelStations() {
    final label = "Avísame cuando la gasolinera";
    final widget = SelectFormField(
      type: SelectFormFieldType.dropdown, // or can be dialog
      items: _fuelStationList,
      decoration: InputDecoration(
        hintText: 'Selecciona una gasolinera',
        hintStyle: TextStyle(color: FullfuelColors.primary),
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: FullfuelColors.secondary,
        ),
        border: InputBorder.none,
      ),
      initialValue: _selectedFuelStation.toString(),
      onChanged: (val) => {
        setState(() {
          _selectedFuelStation = int.parse(val);
        })
      },
      style: TextStyle(color: FullfuelColors.primary),
    );

    return FormFieldContainerWidget(label: label, widget: widget);
  }

  final List<Map<String, dynamic>> _fuelTypesList = [
    {
      'value': 'g95',
      'label': 'Gasolina 95',
      'textStyle': TextStyle(fontSize: 16, color: FullfuelColors.primary)
    },
    {
      'value': 'g98',
      'label': 'Gasolina 98',
      'textStyle': TextStyle(fontSize: 16, color: FullfuelColors.primary)
    },
    {
      'value': 'gasoil',
      'label': 'Gasoil',
      'textStyle': TextStyle(fontSize: 16, color: FullfuelColors.primary)
    },
  ];

  FormFieldContainerWidget _fuelTypes() {
    final label = "Baje el precio del combustible";
    final widget = SelectFormField(
      type: SelectFormFieldType.dropdown, // or can be dialog
      items: _fuelTypesList,
      decoration: InputDecoration(
        hintText: 'Selecciona un tipo de combustible',
        hintStyle: TextStyle(color: FullfuelColors.primary),
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: FullfuelColors.secondary,
        ),
        border: InputBorder.none,
      ),
      initialValue: _selectedFuelType,
      onChanged: (val) => {
        setState(() {
          _selectedFuelType = val;
        })
      },
      style: TextStyle(color: FullfuelColors.primary),
    );

    return FormFieldContainerWidget(label: label, widget: widget);
  }
}
