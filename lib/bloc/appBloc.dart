import 'dart:ui';

import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/dataStore/dataStore.dart';
import 'package:kib/models/about_response.dart';
import 'package:kib/models/city_response.dart';
import 'package:kib/models/service.dart';
import 'package:kib/models/service_responce.dart';
import 'package:kib/models/user.dart';
import 'package:kib/network.dart';
import 'package:kib/states/gallery_state.dart';
import 'package:kib/states/news_state.dart';
import 'package:kib/states/service_state.dart';

import 'package:rxdart/rxdart.dart';

class AppBloc extends BaseBloc with Network {
  // final DataStore _dataStore;

  bool gettingServices = false;
  bool gettingSubServices = false;
  bool gettingProducts = false;
  bool gettingSubProducts = false;
  bool gettingGalleries = false;
  bool gettingNews = false;
  // AppBloc(this._dataStore);
  final _loadingController = BehaviorSubject<bool>();
  get startLoading => _loadingController.sink.add(true);
  get stopLoading => _loadingController.sink.add(false);
  Stream<bool> get loadingStream => _loadingController.stream;

  Function(User) get saveUser => DataStore().setUser;
  Function(String) get saveToken => DataStore().setUserToken;
  String get token => DataStore().userToken;
  User get me => DataStore().getUser();
  bool get isUserLoggedIn => DataStore().isUserLoggedIn;

  ServicesPopulated servicesPopulated = ServicesPopulated([]);
  ServicesPopulated mainServicesPopulated = ServicesPopulated([]);
  ServicesPopulated mainProductsPopulated = ServicesPopulated([]);
  ServicesPopulated insurancesPopulated = ServicesPopulated([]);
  GalleryPopulated galleriesPopulated = GalleryPopulated([]);
  NewsPopulated newsPopulated = NewsPopulated([]);

  final _localeController = BehaviorSubject<Locale>();
  final _servicesController = BehaviorSubject<ServicesState>();
  final _productsController = BehaviorSubject<ServicesState>();
  final _insurancesController = BehaviorSubject<ServicesState>();
  final _gallriesController = BehaviorSubject<GalleryState>();
  final _newsController = BehaviorSubject<NewsState>();
  final _maineServicesController = BehaviorSubject<ServicesState>();
  final _selectedServiceController = BehaviorSubject<Service>();
  final _selectedInsuranceController = BehaviorSubject<Service>();
  final _subServicesController = BehaviorSubject<ServiceResponce>();
  final _citiesController = BehaviorSubject<CityResponce>();
  final _aboutController = BehaviorSubject<AboutResponce>();

  Stream<Locale> get selectedLocaleStream => _localeController.stream;
  Stream<Service> get selectedServiceStream =>
      _selectedServiceController.stream;
  Stream<Service> get selectedProductStream =>
      _selectedInsuranceController.stream;
  Stream<ServicesState> get servicesStream => _servicesController.stream;
  Stream<ServicesState> get productsStream => _productsController.stream;
  Stream<ServicesState> get insurancesStream => _insurancesController.stream;
  Stream<NewsState> get newsStream => _newsController.stream;
  Stream<GalleryState> get galleryStream => _gallriesController.stream;
  Stream<ServicesState> get mainServicesStream =>
      _maineServicesController.stream;
  Stream<ServiceResponce> get subServicesStream =>
      _subServicesController.stream;

  Stream<CityResponce> get citiesStream => _citiesController.stream;
  Stream<AboutResponce> get aboutStream => _aboutController.stream;

  changeService(service) {
    _selectedServiceController.sink.add(service);
  }

  changeInsurance(product) {
    _selectedInsuranceController.sink.add(product);
  }

  changeLocale(locale) {
    _localeController.sink.add(locale);
    DataStore().setLocale(locale);
  }

  fetchLocale() {
    var locale = DataStore().getLocale();
    if (locale != null) {
      changeLocale(locale);
    }
  }

  Future mainServices() {
    if (!gettingServices) {
      return _maineServicesController.addStream(fetchMainServicesFromNetwork());
    }
  }

  mainProducts() {
    if (!gettingProducts) {
      _insurancesController.addStream(fetchMainProductsFromNetwork());
    }
  }

  Future citis() {
    startLoading;
    return getCities().then((response) {
      print(response);
      stopLoading;
      _citiesController.sink.add(response);
    }).catchError((e) {
      print(e);
      stopLoading;
      _citiesController.sink.addError(e);
    });
  }

  Future aboutus() {
    startLoading;
    return getAbout().then((response) {
      print(response);
      stopLoading;
      _aboutController.sink.add(response);
    }).catchError((e) {
      print(e);
      stopLoading;
      _aboutController.sink.addError(e);
    });
  }

  services(id) {
    if (!gettingSubServices) {
      _servicesController.addStream(fetchServicesFromNetwork(id));
    }
  }

  products(id) {
    if (!gettingSubProducts) {
      _productsController.addStream(fetchProductsFromNetwork(id));
    }
  }

  galleries() {
    if (!gettingGalleries) {
      _gallriesController.addStream(fetchGalleriesFromNetwork());
    }
  }

  Future news() {
    if (!gettingNews) {
      return _newsController.addStream(fetchNewsFromNetwork());
    }
  }

  Future subServices(id) {
    gettingSubServices = true;
    startLoading;
    return getServiceProducts(id).then((response) {
      gettingSubServices = false;
      print(response);
      stopLoading;
      _subServicesController.sink.add(response);
    }).catchError((e) {
      gettingSubServices = false;
      stopLoading;
      print(e);
      _subServicesController.sink.addError(e);
    });
  }

  Stream<ServicesState> fetchMainProductsFromNetwork() async* {
    gettingProducts = true;
    yield ServicesLoading();
    startLoading;
    try {
      final result = await getInsurances();
      gettingProducts = false;
      stopLoading;
      if (result.data.isEmpty) {
        yield ServicesEmpty();
      } else {
        yield mainProductsPopulated.update(newServices: result.data);
      }
    } catch (e) {
      gettingProducts = false;
      stopLoading;
      print('error $e');
      yield ServicesError(e.toString());
    }
  }

  Stream<ServicesState> fetchMainServicesFromNetwork() async* {
    gettingServices = true;
    yield ServicesLoading();
    startLoading;
    try {
      final result = await getServices();
      gettingServices = false;
      stopLoading;
      if (result.data.isEmpty) {
        yield ServicesEmpty();
      } else {
        yield mainServicesPopulated.update(newServices: result.data);
      }
    } catch (e) {
      gettingServices = false;
      stopLoading;
      print('error $e');
      yield ServicesError(e.toString());
    }
  }

  Stream<ServicesState> fetchProductsFromNetwork(id) async* {
    gettingSubProducts = true;
    yield ServicesLoading();
    startLoading;
    try {
      final result = await getInsuranceProducts(id);
      stopLoading;
      gettingSubProducts = false;
      if (result.data.isEmpty) {
        yield ServicesEmpty();
      } else {
        yield insurancesPopulated.update(newServices: result.data);
      }
    } catch (e) {
      stopLoading;
      gettingSubProducts = false;
      print('error $e');
      yield ServicesError(e.toString());
    }
  }

  Stream<ServicesState> fetchServicesFromNetwork(id) async* {
    yield ServicesLoading();
    startLoading;
    try {
      final result = await getServiceProducts(id);
      stopLoading;
      if (result.data.isEmpty) {
        yield ServicesEmpty();
      } else {
        yield servicesPopulated.update(newServices: result.data);
      }
    } catch (e) {
      stopLoading;
      print('error $e');
      yield ServicesError(e.toString());
    }
  }

  Stream<GalleryState> fetchGalleriesFromNetwork() async* {
    gettingGalleries = true;
    yield GalleryLoading();
    startLoading;
    try {
      final result = await getGalleries();
      gettingGalleries = false;
      stopLoading;
      if (result.data.isEmpty) {
        yield GalleryEmpty();
      } else {
        yield galleriesPopulated.update(newGalleries: result.data);
      }
    } catch (e) {
      stopLoading;
      gettingGalleries = false;
      print('error $e');
      yield GalleryError(e.toString());
    }
  }

  Stream<NewsState> fetchNewsFromNetwork() async* {
    gettingNews = true;
    yield NewsLoading();
    startLoading;
    try {
      final result = await getNews();
      gettingNews = false;
      stopLoading;
      if (result.data.isEmpty) {
        yield NewsEmpty();
      } else {
        yield newsPopulated.update(newNews: result.data);
      }
    } catch (e) {
      gettingNews = false;
      stopLoading;
      print('error $e');
      yield NewsError(e.toString());
    }
  }

  @override
  void dispose() {
    _localeController.close();
    _servicesController.close();
    _subServicesController.close();
    _maineServicesController.close();
    _selectedServiceController.close();
    _gallriesController.close();
    _insurancesController.close();
    _citiesController.close();
    _selectedInsuranceController.close();
    _loadingController.close();
  }
}
