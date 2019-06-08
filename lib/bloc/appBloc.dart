import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/dataStore/dataStore.dart';
import 'package:kib/models/city_response.dart';
import 'package:kib/models/service.dart';
import 'package:kib/models/service_responce.dart';
import 'package:kib/models/user.dart';
import 'package:kib/network.dart';
import 'package:kib/states/gallery_state.dart';
import 'package:kib/states/news_state.dart';
import 'package:kib/states/service_state.dart';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc extends BaseBloc with Network {
  final SharedPreferences _prefs;
  DataStore _dataStore;

  AppBloc(this._prefs) {
    _dataStore = DataStore();
  }
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

  changeService(service) {
    _selectedServiceController.sink.add(service);
  }

  changeInsurance(product) {
    _selectedInsuranceController.sink.add(product);
  }

  mainServices() {
    _maineServicesController.addStream(fetchMainServicesFromNetwork());
  }

  mainProducts() {
    _insurancesController.addStream(fetchMainProductsFromNetwork());
  }

  // Future mainProducts() {
  //   startLoading;
  //   return getInsurances().then((response) {
  //     stopLoading;
  //     print(response);
  //     _insurancesController.sink.add(response);
  //   }).catchError((e) {
  //     print(e);
  //     stopLoading;
  //     _insurancesController.sink.addError(e);
  //   });
  // }

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
    startLoading;
    return getServiceProducts(id).then((response) {
      print(response);
      stopLoading;
      _subServicesController.sink.add(response);
    }).catchError((e) {
      stopLoading;
      print(e);
      _subServicesController.sink.addError(e);
    });
  }

  Stream<ServicesState> fetchMainProductsFromNetwork() async* {
    yield ServicesLoading();
    startLoading;
    try {
      final result = await getInsurances();
      stopLoading;
      if (result.data.isEmpty) {
        yield ServicesEmpty();
      } else {
        yield mainProductsPopulated.update(newServices: result.data);
      }
    } catch (e) {
      stopLoading;
      print('error $e');
      yield ServicesError(e.toString());
    }
  }

  Stream<ServicesState> fetchMainServicesFromNetwork() async* {
    yield ServicesLoading();
    startLoading;
    try {
      final result = await getServices();
      stopLoading;
      if (result.data.isEmpty) {
        yield ServicesEmpty();
      } else {
        yield mainServicesPopulated.update(newServices: result.data);
      }
    } catch (e) {
      stopLoading;
      print('error $e');
      yield ServicesError(e.toString());
    }
  }

  Stream<ServicesState> fetchProductsFromNetwork(id) async* {
    yield ServicesLoading();
    startLoading;
    try {
      final result = await getInsuranceProducts(id);
      stopLoading;
      if (result.data.isEmpty) {
        yield ServicesEmpty();
      } else {
        yield insurancesPopulated.update(newServices: result.data);
      }
    } catch (e) {
      stopLoading;
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
    yield GalleryLoading();
    startLoading;
    try {
      final result = await getGalleries();
      stopLoading;
      if (result.data.isEmpty) {
        yield GalleryEmpty();
      } else {
        yield galleriesPopulated.update(newGalleries: result.data);
      }
    } catch (e) {
      stopLoading;
      print('error $e');
      yield GalleryError(e.toString());
    }
  }

  Stream<NewsState> fetchNewsFromNetwork() async* {
    yield NewsLoading();
    startLoading;
    try {
      final result = await getNews();
      stopLoading;
      if (result.data.isEmpty) {
        yield NewsEmpty();
      } else {
        yield newsPopulated.update(newNews: result.data);
      }
    } catch (e) {
      stopLoading;
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
    _citiesController.close();
    _selectedInsuranceController.close();
    _loadingController.close();
  }
}
