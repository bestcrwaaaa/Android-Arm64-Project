# AssemblyHello - Android приложение на чистом ARM64 ассемблере

## Описание проекта

Данный проект демонстрирует создание Android приложения, где основная логика
реализована исключительно на языке ассемблера для архитектуры ARM64 (AArch64).

Приложение выводит на экран сообщение **"Hello from assembly!"**, где строка
создаётся и возвращается из нативного ассемблерного кода через интерфейс JNI.

## Структура проекта

```
AssemblyHello/
├── app/
│   ├── src/
│   │   └── main/
│   │       ├── cpp/
│   │       │   ├── CMakeLists.txt      # Конфигурация сборки CMake
│   │       │   └── native-lib.S        # ARM64 ассемблерный код
│   │       ├── java/
│   │       │   └── com/example/assemblyhello/
│   │       │       └── MainActivity.kt # Activity с загрузкой нативной библиотеки
│   │       ├── res/
│   │       │   ├── layout/activity_main.xml
│   │       │   ├── values/strings.xml, colors.xml, themes.xml
│   │       │   └── mipmap-*/
│   │       └── AndroidManifest.xml
│   ├── build.gradle
│   └── proguard-rules.pro
├── build.gradle
├── settings.gradle
├── gradle.properties
├── local.properties
└── gradlew
```

## Технические детали

### Ассемблерный код (native-lib.S)

Файл содержит реализацию JNI-функции на чистом ARM64 ассемблере:

- **Функция**: `Java_com_example_assemblyhello_MainActivity_stringFromJNI`
- **Регистры**: Следует соглашению вызовов AAPCS64
- **Стек**: Сохраняет frame pointer и link register
- **JNI**: Вызывает `NewStringUTF` через таблицу функций JNI

### Сборка

Проект использует:
- **CMake** с поддержкой языка ASM для компиляции ассемблера
- **Android NDK** для кросс-компиляции под Android
- **Gradle** для автоматизации сборки

### Требования

- Android Studio Arctic Fox или новее
- Android NDK версии 25 или новее
- Android SDK с API level 21+
- Устройство или эмулятор с поддержкой arm64-v8a

## Компиляция и запуск

1. Откройте проект в Android Studio
2. Настройте путь к Android SDK в файле `local.properties`
3. Подключите ARM64 устройство или запустите эмулятор
4. Выполните сборку и запуск проекта

## Как это работает

1. **MainActivity.kt** загружает нативную библиотеку `libassemblyhello.so`
2. Вызывается нативный метод `stringFromJNI()`
3. ARM64 ассемблерный код получает управление
4. Код вызывает JNI функцию `NewStringUTF` для создания Java String
5. Строка "Hello from assembly!" возвращается в Java код
6. TextView отображает полученную строку

## Лицензия

Проект распространяется как учебный пример для изучения разработки
нативных Android приложений на языке ассемблера.
