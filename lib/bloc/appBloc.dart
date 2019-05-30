import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/models/service.dart';
import 'package:kib/models/service_responce.dart';
import 'package:kib/network.dart';
import 'package:kib/states/gallery_state.dart';
import 'package:kib/states/news_state.dart';
import 'package:kib/states/service_state.dart';

import 'package:rxdart/rxdart.dart';

class AppBloc extends BaseBloc with Network {
  ServicesPopulated servicesPopulated = ServicesPopulated([]);
  ServicesPopulated insurancesPopulated = ServicesPopulated([]);
  GalleryPopulated galleriesPopulated = GalleryPopulated([]);
  NewsPopulated newsPopulated = NewsPopulated([]);

  final _servicesController = BehaviorSubject<ServicesState>();
  final _productsController = BehaviorSubject<ServicesState>();
  final _insurancesController = BehaviorSubject<ServiceResponce>();
  final _gallriesController = BehaviorSubject<GalleryState>();
  final _newsController = BehaviorSubject<NewsState>();
  final _maineServicesController = BehaviorSubject<ServiceResponce>();
  final _selectedServiceController = BehaviorSubject<Service>();
  final _subServicesController = BehaviorSubject<ServiceResponce>();

  AppBloc();

  Stream<Service> get selectedServiceStream =>
      _selectedServiceController.stream;
  Stream<ServicesState> get servicesStream => _servicesController.stream;
  Stream<ServicesState> get productsStream => _productsController.stream;
  Stream<ServiceResponce> get insurancesStream => _insurancesController.stream;
  Stream<NewsState> get newsStream => _newsController.stream;
  Stream<GalleryState> get galleryStream => _gallriesController.stream;
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

  Future mainProducts() {
    return getInsurances().then((response) {
      print(response);
      _insurancesController.sink.add(response);
    }).catchError((e) {
      print(e);
      _insurancesController.sink.addError(e);
    });
  }

  services(id) {
    _servicesController.addStream(fetchServicesFromNetwork(id));
  }

  products(id) {
    _productsController.addStream(fetchProductsFromNetwork(id));
  }

  galleries() {
    _gallriesController.addStream(fetchGalleriesFromNetwork());
  }

  news() {
    _newsController.addStream(fetchNewsFromNetwork());
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

  Stream<ServicesState> fetchProductsFromNetwork(id) async* {
    yield ServicesLoading();
    try {
      final result = await getInsuranceProducts(id);
      if (result.data.isEmpty) {
        yield ServicesEmpty();
      } else {
        yield insurancesPopulated.update(newServices: result.data);
      }
    } catch (e) {
      print('error $e');
      yield ServicesError(e.toString());
    }
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

  Stream<GalleryState> fetchGalleriesFromNetwork() async* {
    yield GalleryLoading();
    try {
      final result = await getGalleries();
      if (result.data.isEmpty) {
        yield GalleryEmpty();
      } else {
        yield galleriesPopulated.update(newGalleries: result.data);
      }
    } catch (e) {
      print('error $e');
      yield GalleryError(e.toString());
    }
  }

  Stream<NewsState> fetchNewsFromNetwork() async* {
    yield NewsLoading();
    try {
      final result = await getNews();
      if (result.data.isEmpty) {
        yield NewsEmpty();
      } else {
        yield newsPopulated.update(newNews: result.data);
      }
    } catch (e) {
      print('error $e');
      yield NewsError(e.toString());
    }
  }

  @override
  void dispose() {
    _servicesController.close();
    _subServicesController.close();
    _maineServicesController.close();
    _selectedServiceController.close();
    _gallriesController.close();
    _insurancesController.close();
  }
}
