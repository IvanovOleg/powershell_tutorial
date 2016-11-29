# Работа с файловой системой

#
# 4.1 Работа с файловой системой
#

pwd # отобразит полный путь к текущей директории
(pwd).Path # "C:\Users\oleg.ivanov" чтобы получить только путь в виде строки

# работает только в скрипте, на тот случай запускаете скрипт находясь в другой папке
$currentDirectory = $MyInvocation.MyCommand.Definition | split-path -parent
$currentDirectory

Get-ChildItem # отобразит список файлов и папок в текущей директории (gci, ls, dir синонимы)
Get-ChildItem -Path "c:\" # отобразит элементы по указанному пути
Get-ChildItem -Path "c:\" -Force # отобразит элементы по указанному пути включая скрытые файлы
Get-ChildItem -Recurse # отобразит список всех файлов и папок в текущей директории включая вложенные
Get-ChildItem -Path "d:\*.txt" -Force # отобразить список файлов с рамширением *.txt

# все исполняемые файлы старше 2014-04-01
Get-ChildItem -Path "C:\Program Files" -Recurse -Include *.exe | Where-Object {($_.LastWriteTime -gt "2014-04-01")} 

Copy-Item "d:\test.txt" "d:\test1.txt" # копирует элемент, первым задается путь к элементу, затем путь назначения
Copy-Item "d:\files\*" "d:\Backups\" # скопировать содержимое директории в другую директорию (без рекурсии)
Copy-Item "d:\files\*" "d:\Backups\" -Recurse # скопировать содержимое директории в другую директорию (c рекурсией)

New-Item "C:\Users\oleg.ivanov\file.txt" -ItemType File # Создать новый пустой файл
New-Item "C:\Users\oleg.ivanov\directory" -ItemType Directory # Создать новую директорию
New-Item "C:\Users\oleg.ivanov\file.txt" -ItemType File -Force # Создать новый пустой файл (перезаписать если существует)

Remove-Item "C:\Users\oleg.ivanov\file.txt" # удалит элемент по указанному пути (безвозвратно, не перемещает в корзину)
Remove-Item "C:\Users\oleg.ivanov\directory" -Force # удалит элемент по указанному пути (-Force для принудительного удаления не пустой папки)
Remove-Item "d:\test\*" -Include *.txt -Exclude *test* # удалит все текстовые файлы в папке, кроме тех, в названии которых есть "test"

Rename-Item "d:\test.txt" "test5.txt" # переименует указанный объект

#
# 4.2 Работа с содержимым файлов
#

Get-Content "D:\questions.txt" # получить содержимое файла в массив, каждую строку как отдельный элемент
(Get-Content "D:\questions.txt") -join "`n" # преобразовать содержимое файла в строку

Set-Content D:\newitemtest.txt "This is the test content" # перезапишет содержимое файла
Add-Content D:\newitemtest.txt "This is the best content" # добавит строку в конец файла
Get-ChildItem > D:\newitemtest.txt # перенаправит результат выполнения комманды в файл (перезапишет)
Get-ChildItem >> D:\newitemtest.txt # перенаправит результат выполнения комманды в файл (добавит в конец файла)

Get-ChildItem | ConvertTo-Html # преобразовать результат комманды в html код
Get-ChildItem | ConvertTo-Xml
Get-ChildItem | ConvertTo-Csv
Get-ChildItem | ConvertTo-Json -Depth 5 # преобразовать результат комманды в json (-Depth указывает на глубину объекта)

$data = @{
    "first" = @{
        "second" = @{
            "third" = @{
                "fourth" = "test"
            }
        }
    }
} | ConvertTo-Json -Depth 5

#
# 4.3 Работа с xml
#

[xml]$config = Get-Content .\config.xml # загрузить содержимое файла как xml
$config.xml.Section.BEName # отобразить содержимое элемента
$config.xml.Section.BEName | Where { $_.Status -eq 1 } # отобразить элементы, с полем "Status" равным 1

# Домашнее задание

# http://www.osp.ru/winitpro/2013/10/13037712/
