import 'package:credit_card/credit_card_model.dart';
import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:password_manager/controller/DataStatus.dart';
import 'package:password_manager/db/model/cards_model.dart';
import 'package:password_manager/db/model/credit_card_model.dart';
import 'package:password_manager/db/store.dart';
import 'package:password_manager/ui/shared/snack_bar_helper.dart';
import 'package:password_manager/ext/ext.dart';

@lazySingleton
class CardController extends GetxController {
  final Store _store;

  CardController(this._store);

  var cache = List<CardsModel>();

  var cardModelStatus = DataStatus<List<CardsModel>>(null, DataState.INIT).obs;

  void getAllData({force = false}) async {
    if (!force && cache.isNotEmpty) {
      cardModelStatus.update((val) {
        val.data = cache;
        val.state = DataState.LOADED;
      });
    }

    var cats = await _store.getCards();
    var models = cats.docs.map((e) {
      return CardsModel.fromMap(e.data());
    }).toList();

    //save a cahce
    cache = models;

    //now update
    cardModelStatus.update((val) {
      val.data = models;
      val.state = DataState.LOADED;
    });
  }

  Future<bool> addCard(MyCreditCardModel card) async {
    final Encrypter encrypter = Get.find(tag: "ENCRYPT");
    var model = CardsModel(
      cardNumber: card.cardNumber.encrypt(encrypter),
      name: card.cardHolderName,
      cvc: card.cvvCode.encrypt(encrypter),
      expDate: card.expiryDate,
      createdDate: DateTime.now(),
      updatedDate: DateTime.now(),
    );
    var res = await _store.addCard(model);
    if (res) {
      //update list
      getAllData(force: true);
    } else {
      SnackBarHelper.showError("Something went wrong, please try again");
    }

    //return response, so that we can close the ui
    // from ui class
    // maybe user can close the ui,
    // so it will better to handle from ui
    return res;
  }

  Future<bool> updateCard(MyCreditCardModel card, String uuid) async {
    final Encrypter encrypter = Get.find(tag: "ENCRYPT");
    var model = CardsModel(
      cardNumber: card.cardNumber.encrypt(encrypter),
      name: card.cardHolderName,
      cvc: card.cvvCode.encrypt(encrypter),
      expDate: card.expiryDate,
      createdDate: DateTime.now(),
      updatedDate: DateTime.now(),
      uuid: uuid,
    );
    var res = await _store.addCard(model, update: true);
    if (res) {
      //update list
      getAllData(force: true);
    } else {
      SnackBarHelper.showError("Something went wrong, please try again");
    }

    //return response, so that we can close the ui
    // from ui class
    // maybe user can close the ui,
    // so it will better to handle from ui
    return res;
  }

  Future<bool> deleteCard(String uuid) async {
    var res = await _store.deleteCard(uuid);
    if (res) {
      //update list
      getAllData(force: true);
    } else {
      SnackBarHelper.showError("Something went wrong, please try again");
    }

    //return response, so that we can close the ui
    // from ui class
    // maybe user can close the ui,
    // so it will better to handle from ui
    return res;
  }
}
