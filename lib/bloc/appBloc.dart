import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/models/service.dart';
import 'package:kib/models/service_responce.dart';
import 'package:kib/network.dart';
import 'package:kib/states/service_state.dart';

import 'package:rxdart/rxdart.dart';

class AppBloc extends BaseBloc with Network {
  ServicesPopulated servicesPopulated = ServicesPopulated([]);

  final _servicesController = BehaviorSubject<ServicesState>();
  final _maineServicesController = BehaviorSubject<ServiceResponce>();
  final _selectedServiceController = BehaviorSubject<Service>();
  final _subServicesController = BehaviorSubject<ServiceResponce>();
  AppBloc();
  Stream<Service> get selectedServiceStream =>
      _selectedServiceController.stream;
  Stream<ServicesState> get servicesStream => _servicesController.stream;
  Stream<ServiceResponce> get mainServicesStream =>
      _maineServicesController.stream;
  Stream<ServiceResponce> get subServicesStream =>
      _subServicesController.stream;

  changeService(service) {
    _selectedServiceController.sink.add(service);
  }

  Future mainServices() {
    return getServices().then((response) {
      print(response);
      _maineServicesController.sink.add(response);
    }).catchError((e) {
      print(e);
      _maineServicesController.sink.addError(e);
    });
  }

  services(id) {
    _servicesController.addStream(fetchServicesFromNetwork(id));
  }

  Future subServices(id) {
    return getServiceProducts(id).then((response) {
      print(response);
      _subServicesController.sink.add(response);
    }).catchError((e) {
      print(e);
      _subServicesController.sink.addError(e);
    });
  }

  Stream<ServicesState> fetchServicesFromNetwork(id) async* {
    yield ServicesLoading();
    try {
      final result = await getServiceProducts(id);
      if (result.data.isEmpty) {
        yield ServicesEmpty();
      } else {
        yield servicesPopulated.update(newServices: result.data);
      }
    } catch (e) {
      print('error $e');
      yield ServicesError(e.toString());
    }
  }

  @override
  void dispose() {
    _servicesController.close();
    _subServicesController.close();
    _maineServicesController.close();
    _selectedServiceController.close();
  }
}
