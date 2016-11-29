# Урок №2: Переменные, типы данных, условия, циклы

#
# 2.1 Переменные
#

# Способы задания переменных 

$m = "Hello World!"
[int]$ml = 4 # распространенные типы данных: datetime, string, char, double, int, boolean
[System.Int32]$ml = 4
$ml = "Mark" # выдаст ошибку несоответствия типа данных
${Mark Long} = 35 # чтобы задать переменную с пробелом в названии, потенциальный источник проблем

Set-Variable serverIP -option ReadOnly # создать (изменить статус) переменную только для чтения
Set-Variable serverIP -option none -force # отменить режим только для чтения
Set-Variable serverIP -option Constant -value "127.0.0.1" # константа отличается от только для чтения тем, что не позволяет себя удалить

# Позволяет задать параметры новой переменной: description, read-only, constants, scope, public or private
New-Variable -Name counter -Visibility private

# Удаление переменной

Remove-Variable serverIP -force # -force позволяет принудительно удалить переменную только для чтения

# Область действия (scope) переменной

# Global - действует в пределах сессии powershell

$global:test = "test"

# Local - дейстует в пределах текущей области действия. Локальная область действия может быть глобальной либо любой другой областью действия

$local:test = "test"

# Script - дествует в пределах выполнения скрипта

$script:scr = "Script"

# Private - не видна за пределами текущей обасти действия

# Environment variables - переменные окружения Windows

Get-ChildItem Env: # отобразить переменные окружения

$Env:Path

$env:TestVariable = "This is a test environment variable." # будет существовать только в текущей сессии powershell
[Environment]::SetEnvironmentVariable("TestVariable", "Test value.", "User") # постоянная (User, Machine, Process)

Remove-Item Env:\TestVariable # удаление переменной окружения
[Environment]::SetEnvironmentVariable("TestVariable",$null,"User")

$global:length = 100
$lenght = 10

function GeneratePassword {
    param([int]$length)
    $assembly = Add-Type -AssemblyName System.Web
    $password = [System.Web.Security.Membership]::GeneratePassword($script:length,2) #  будет взято 10, а не 100
    return $password
}

$result = (GeneratePassword)
$result

$password # будет пустой поскольку задана внутри функции (private)

# Получить значение переменной

$m

# Чтобы получить доступные объекту методы и свойства

$m | Get-Member
$m | Get-Member -membertype properties # отобразит только свойства

# Powershell может изменять тип переменной динамически, но только если тип переменной не задан явно и переменная не только для чтения

$a = 4
$a | Get-Member # выдаст System.int32
$a = "Test"
$a | Get-Member # выдаст System.String

#
# 2.2 Типы данных
#

# Самые популярные типы данных

[int]$i = 5 # integer, целые числа
[double]$d = 25.56 # double, дробные
[string]$s = "String" # string, строки
[array]$a = 1,2,3,4,5 # массив
[array]$a = @(1,2,3,4,5) # массив
[hashtable]$h = @{"name" = "Oleg"; "email" = "oleg.ivanov@globallogic.com"} # хэш (словарь)
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
-eq   # равно Equal to (=)
-lt   # меньше Less than (<)
-gt   # больше Greater than (>)
-ge   # больше либо равно Greater than or equal to (>=)
-le   # меньше либо равно Less than or equal to (<=)
-ne   # не равно Not equal to (!=)

-ieq  # сравнение строк (не учитывает регистр) for strings, case insensitive (default)
-ceq  # сравнение строе (с учетом регистра) for strings, case sensitive

-not  # логическое "нет" logical Not
!     # логическое "нет" logical Not
-and  # логическое "и" And
-or   # логическое "или" Or
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

if (условие) {Команда} # шаблон записи проверки выполнения условия

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
For Each-Object # обработать коллекцию объектов Loops through a collection of objects
For             # выполнять комманду определенное количество раз Executes a specific number of times
While           # выполнять комманду пока условие соблюдается Executes as long as a condition remains true; test the condition first
Do While        # выполнять комманду пока условие соблюдается (выполняется первый раз без проверки, в любом случае) Executes once,
                # then tests the condition then repeats as long as a condition remains true
Do Until        # выполнять до тех пор пока Executes once and repeats until a condition is true
#>

$a = 5,6,7,8,9 # массив array
$a = "Mark","Bob","Jane" # массив array

$a | ForEach {Write-Host $_} # выдаст все элементы массива, каждый на отдельной строке

# $_ - это текущий объект в цикле, выдаст только те сервисы, в имени которых присутствует "MS"

Get-Service | Where-Object {$_.DisplayName -Match "MS"}

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

# Домашнее задание (дополнительная информация)

# https://habrahabr.ru/post/242445/
