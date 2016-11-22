# Урок №2: Переменные, типы данных, условия, циклы

#
# 2.1 Переменные
#

# Способы задания переменных 

$m = "Hello World!"
[int]$ml = 4 # Распространенные типы данных: datetime, string, char, double, int, boolean
[System.Int32]$ml = 4
$ml = "Mark" # Выдаст ошибку несоответствия типа данных
${Mark Long} = 35 # чтобы задать переменную с пробелом в названии

Set-Variable serverIP -option ReadOnly # создать (изменить статус) переменную только для чтения
Set-Variable serverIP -option none -force # отменить режим только для чтения
Set-Variable serverIP -option Constant -value "127.0.0.1" # константа отличается от только для чтения тем, что не позволяет себя удалить
New-Variable -Name counter -Visibility private # позволяет задать параметры новой переменной: description, read-only, constants, scope, public or private

# Удаление переменной

Remove-Variable serverIP -force # -force позволяет принудительно удалить переменную только для чтения

# Область действия (scope) переменной

$global:test = "test"   # Global - действует в пределах сессии powershell
                        # Local - дейстует в пределах текущей области действия. Локальная обоасть действия может быть глобальной либо любой другой области действия
$script:scr = "Script"  # Script - дествует в пределах выполнения скрипта
# Private - не видна за пределами текущей обасти действия
$Env:Path # Environment variables - переменные окружения Windows

$global:length = 100
$lenght = 10

function GeneratePassword {
    param([int]$length)
    $assembly = Add-Type -AssemblyName System.Web
    $password = [System.Web.Security.Membership]::GeneratePassword($script:length,2)
    return $password
}

$password # будет пустой

# Получить значение переменной

$m

# Чтобы получить доступные объекту методы и свойства

$m | Get-Member
$m | Get-Member -membertype properties # отобразит только свойства

# Powershell может изменять тип переменной динамически, но только если тип переменной не задан явно и это не только для чтения

$a = 4
$a | Get-Member # Выдаст System.int32
$a = "Test"
$a | Get-Member # Выдаст System.String

#
# 2.2 Типы данных
#

# Самые популярные типы данных

[int]$i = 5 # Integer, целые числа
[double]$d = 25.56 # Double, дробные
[string]$s = "String" # String, строки
[array]$a = 1,2,3,4,5 # массив
[array]$a = @(1,2,3,4,5) # массив
[hashtable]$h = @{"name" = "Oleg"; "email" = "oleg.ivanov@globallogic.com"} # Хэш (словарь)
[datetime]$dt = Get-Date # дата
[bool]$bl = $true # логические

# Как посмотреть тип данных у переменной
$datatype = 1,2,3,4,5
$datatype.GetType() # отобразит тип данных (Base.Type Array)

# Добавление классов из .NET

$assembly = Add-Type -AssemblyName System.Web
$password = [System.Web.Security.Membership]::GeneratePassword(10,2)

[Reflection.Assembly]::LoadFile("c:\work\MLClass.dll") # Загрузить методы из библиотеки
$ml = New-Object MLClass.Messages
$ml.SendMsg()

#
# 2.3 Условные операторы
#

<#
-eq   # Равно Equal to (=)
-lt   # Меньше Less than (<)
-gt   # Больше Greater than (>)
-ge   # Больше либо равно Greater than or equal to (>=)
-le   # Меньше либо равно Less than or equal to (<=)
-ne   # Не равно Not equal to (!=)

-ieq  # Стравнение строк (не учитывает регистр) for strings, case insensitive (default)
-ceq  # Сравнение строе (с учетом регистра) for strings, case sensitive

-not  # Логическое нет logical Not
!     # Логическое нет logical Not
-and  # И And
-or   # Или Or
#>

$a = 6
$b = 6
$a -eq $b # вернет True
($a -eq 15) -or ($b -eq 15) # сложное условие

$c = "abc"
$d = "ABC"

$c -eq $d # True
$c -ieq $d # True
$c -ceq $d # False

# Оператор if

if (условие) {Команда} # Шаблон записи проверки выполнения условия

if ($a -eq $b) {
    Write-Host "Equal"
} elseif ($a -lt $b) {
    Write-Host "Less"
}
else {
    Write-Host "Greater"
}

#
# 2.4 Циклы (Loops) - последовательность повторяющихся действий
#

<#
For Each-Object # Обработать коллекцию объектов Loops through a collection of objects
For             # Выполнить комманду определенное количество раз Executes a specific number of times
While           # Выполнять комманду пока условие соблюдается Executes as long as a condition remains true; test the condition first
Do While        # Выполнять комманду пока условие соблюдается (выполняется первый раз без проверки, в любом случае) Executes once, then tests the condition then repeats as long as a condition remains true
Do Until        # Выполнять до тех пор пока Executes once and repeats until a condition is true
#>

$a = 5,6,7,8,9 # collection
$a = "Mark","Bob","Jane" # collection

$a | ForEach {Write-Host $_}
Get-Service | Where-Object {$_.DisplayName -Match "MS"} # $_ - это текущий объект в цикле

foreach ($item in $a) {
    Write-Host $item
}

for ($a = 1; $a -le 5; $a++) {
    Write-Host $a
}

$f = 1
while ($f -le 5) {
    Write-Host $f
    $f++
}

# do while

$g = 1

do {
    Write-Host $g
    $g++
} while ($g -lt 5)

# do until
do {
    Write-Host $g
    $g++
} until ($g -gt 5)
