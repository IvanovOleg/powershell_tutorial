# Урок №1: Командлеты

#
# 1.1 Запуск Powershell
#

# <WIN> + R, в открывшимся окне написать powershell
# кнопка поиск на панели быстрого запуска + powershell
# Для запуска от имени администратора (правой кнопкой по ярлыку и выбрать "запуск от имени администратора") или:

Start-Process Powershell -verb runas

# Для просмотра текущей версии powershell

$PSVersionTable

# По-умолчанию запуск powershell скриптов заблокирован, для разблокировки необходимо изменить политику запуска:

Get-ExecutionPolicy
Set-ExecutionPolicy RemoteSigned

# Для удаленного выполнения Powershell команд необходимо включить соответствующую функцию на удаленном ПК (включена по-умолчанию)
# в Windows Server

Enable-PSRemoting

# Пользовательские настройки Powershell могут находиться в профиле пользователя, который загружается в момент запуска powershell

$Profile

#
# 1.2 Командлеты
#

# <действие>-<объект> -Parameter <аргумент>

# Для проверки существования пути

Test-Path $Profile

# Для создания нового профиля воспользуемся командлетом New-Item

New-Item -path $Profile -type file -force

# Создадим файл и директорию в текущей

New-Item -path .\test_file.txt -type file
New-Item -path .\test_directory -type directory

# В профиль можно добавить команды, которые будут выполняться каждый раз при открытии powershell

notepad $Profile
Clear-Host # CTRL + L
Write-Host "`t `t `t Attention!"
Write-Host "`t `t use this pc carefully!"
Write-Host " "
Write-Host " "
Write-Output "Test output"
Write-Error "Error"

# Для получения списка процессов или информации о конкретном процессе

Get-Process
Get-Process -name "*host"

# Для запуска процесса используем Start-Process, для остановки - Stop-Process

Start-Process notepad
Stop-Process notepad

# Для получения справки по командлету

Get-Help
Get-Help Get-Process

# Мультистраничный вариант справки

Get-Process -?

# Для получения примера использования командлета из справки

Get-Help Start-Process -examples

# Для получения детальной справки

Get-Help Start-Process -detailed
Get-Help Start-Process -full

# Для отображения справки в отдельном окне

Get-Help Start-Process -ShowWindow
Get-Help Start-Process -online

# Для обновления справочных материалов (запускать в режиме администратора)

Update-Help

# Для получения списка командлетов

Get-Command
Get-Command | more # вывод постранично

# To format the output of the cmlets you can use Format

Get-Process | Format-Wide -column 1 # отобразит содержимое в одной колонке
Get-Process | Format-Table # отобразить в виде таблицы (по-умолчанию для Get-Process)
Get-Process -name powershell | Format-Table -property Company,Name,Id,Path -AutoSize # вывод только нужных колонок с подстройкой под размер окна


# 1.3 | Конвеер, канал (pipe) перенаправляет вывод одной команды на вход другой

Get-ChildItem | Sort-Object # отсортирует результат по алфавиту

# Домашнее задание (дополнительная информация)

# https://habrahabr.ru/company/netwrix/blog/158943/
# http://info-comp.ru/sisadminst/546-windows-powershell-basics.html
