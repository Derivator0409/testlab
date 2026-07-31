# TestLab — Flutter demo app tesztelési célra

Egy szándékosan sokféle, tesztelhető elemet tartalmazó Flutter alkalmazás.
Kézi QA-hoz, widget/integration teszt gyakorláshoz vagy automatizált
teszteléshez (pl. Appium, Maestro) is jól használható.

## Funkciók (mind tesztelhető)

| Képernyő      | Mit tesztelhetsz vele                                       |
|---------------|-------------------------------------------------------------|
| Bejelentkezés | Űrlap-validáció, hibaüzenetek, aszinkron submit, navigáció  |
| Számláló      | Állapotkezelés, gombnyomás, nullázás                        |
| Teendők       | Lista, hozzáadás, kipipálás, törlés (swipe)                 |
| Adatok        | Aszinkron betöltés: loading / siker / hiba állapotok        |
| Beállítások   | Switch, Slider, Dropdown, állapot megőrzése                 |

## Widget kulcsok (Key-ek) automatizáláshoz

Minden fontos interaktív elemnek van `Key`-e, pl.:
`email_field`, `password_field`, `login_button`, `counter_value`,
`increment`, `decrement`, `reset`, `todo_input`, `add_todo`,
`todo_checkbox_$i`, `load_data`, `load_error`, `loading`, `data_list`,
`switch_notifications`, `switch_dark`, `volume_slider`,
`language_dropdown`, `bottom_nav`, `logout_button`.

## Indítás

```bash
# 1. Projekt inicializálása a platform-mappákhoz (android/ios/web)
flutter create .

# 2. Függőségek
flutter pub get

# 3. Futtatás
flutter run
```

> A `flutter create .` a meglévő `lib/` és tesztfájlokat nem írja felül,
> csak a hiányzó platform-mappákat generálja.

## Tesztek futtatása

```bash
# Unit + widget tesztek
flutter test

# Integration teszt (emulátoron / eszközön)
flutter test integration_test/app_test.dart
```

## Bejelentkezési adatok

Bármilyen **érvényes email formátum** + **legalább 6 karakteres jelszó**.
Nincs valódi backend, minden lokálisan, determinisztikusan fut.
