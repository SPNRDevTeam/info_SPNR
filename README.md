# info_SPNR
## <a href="https://github.com/users/krasnov-la/projects/4/views/1?layout=board">Ссылка на таск менеджер</a>

##  Директория SPNR_Web
Сам сайт и бэкенд. Необходим ASP.NET 7.0.
Запуск:
```
dotnet restore
dotnet ef database update
dotnet run
```

Возможные проблемы при запуске: необходим dotnet-ef (dotnet tool install --global dotnet-ef), отсутствует PostgreSQL.

## Директория SPNR_Mobile
Мобильное приложение. Необходим Flutter.
Запуск:
```
flutter run
```
Или запуск через дебаг.
