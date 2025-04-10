# JokeGenerator App

![Swift](https://img.shields.io/badge/Swift-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg)

Простое приложение для iOS, которое показывает случайные шутки с вопросами и ответами. Написано на Swift с использованием UIKit.

---

## Особенности

- Показ случайных шуток с вопросами и ответами.
- Кол-во шуток: 9.
- Возможность обновить шутку для просмотра новой.
- Простой и интуитивно понятный интерфейс.
- Показывает ответ на шутку через UIAlertController с кнопкой "OK".
- Использование AlertPresenter для улучшения организации кода и обработки алертов.
- Модульная архитектура с использованием фабрики для генерации случайных вопросов (QuestionFactory).

---

## Использование

- Нажмите на кнопку "Show Punchline", чтобы увидеть ответ на шутку.
- Нажмите на кнопку "Refresh", чтобы получить новую случайную шутку.

---

## Структура проекта

- **ViewController.swift**: Основной контроллер, управляющий интерфейсом и логикой приложения. Обработчик нажатий на кнопки и обновление данных.
- **AlertPresenter.swift**: Класс для управления созданием и отображением алертов с ответами на шутки.
- **QuestionFactory.swift**: Фабрика для генерации случайных вопросов и ответов, используется для предоставления новых шуток.
- **Main.storyboard**: Интерфейс приложения, созданный с помощью Interface Builder.
- **AlertModel.swift**: Модель данных для алерта, включающая заголовок, сообщение, текст кнопки и завершение действий при нажатии.

---

## Примечания

- Для обновления шутки используется случайный выбор вопроса и ответа.
- Вся логика отображения алертов вынесена в отдельный класс AlertPresenter для соблюдения принципов SOLID и лучшей организации кода.
