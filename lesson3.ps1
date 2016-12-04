# 3. Работа с популярными типами данных

#
# 3.1 Работа с числами
#

$a = 35.5
$a.GetType() # тип double
[int]$a # 36 тип int, [int] - акселератор, происходит автоматическое округление
$a -as [int] # 36
$a # 35.5 сама переменная $a остается типа double

$b = 1 # int
$c = 3.2 # double
$d = $b + $c # 4.2
$d.GetType() # double
$b.ToString() # "1" преобразование в string
[math] | Get-Member -Static # список доступных математических методов
[math]::Pow(3,2) # 9 три во второй степени

# + - * /

#
# 3.2 Операторы присваивания
#

$a = 5
$b = 10

$a += $b # 15 $a = $a + $b
$a -= $b # 5 $a = $a - $b
$a *= $b # $a = $a * $b
$a /= $b # $a = $a / $b
$a++ # $a = $a + 1
$a-- # $a = $a - 1

#
# 3.3 Работа со строками
#

$str1 = "Hel"
$str2 = "lo"
$str1 + $str2 # "Hello"

$domain = "google.com"
$url = "https://${domain}/mail" # "https://google.com/mail"
$url = "https://${script:domain}/mail" # "https://google.com/mail"

# Разница между двойной и одинарной кавычкой

$single = '`ttest' # "`ttest" специальные символы игнорируются
$double = "`ttest" # "    test" специальные символы обрабатываются

$number = "4" # string
[int]$number # 4 int

$str = "Hello World!"
$str.ToUpper() # "HELLO WORLD!"
$str.ToLower() # "hello world!"
$str.Length # 12 подсчитать количество символов в строке
$str.Contains("ello") # True проверяет есть ли в строке вхождение шаблона
$str.Replace(" ", "-") # "Hello-World!" заменяет все вхождение в строке одного элемента на другой
$str.Substring(3) # "lo World!" убирает первых n символов из строки
$str.Substring(3,2) # "lo" второй параметр указывает на то, сколько символов взять после отрезанных первым параметром
"   trim   ".Trim() # "trim" уберает пробелы с начала и с конца

#
# 3.3 Работа с массивами
#

[array]$a = 1,2,3,4,5 # структура данных в виде набора элементов, которые расположены в последовательности
$a = @(1, 2, 3, 4, 5) # все элементы имеют свой порядковый номер (индекс) начиная с 0
$a.GetType() # тип массив System.Array
$a[0] # 1 получить элемент массива можно зная его индекс
$a[-1] # 5 первый элемент с конца
$a[0] = 35 # изменить определенный элемент

$a.Length # 5 посчитать количество элементов в массиве
$a -join '' # "12345" соберет массив в строку, в ковычках указывается разделитель
$a -contains 2 # True проверяет есть ли такой элемент в массиве
$a -notcontains 2 # False проверяет отсутствует ли элемент в массиве

foreach ($item in $a) { # при помощи цикла можно выполнить определенное действие с каждым элементом массива
    Write-Output $item
}

$a | Where-Object { Write-Output $_ } # тоже самое при помощи конвеера, $_ - текущий элемент массива

# 1
# 2
# 3
# 4
# 5

$a += 6 # добавит новый элемент со значением 6 в конец массива
$a # 123456
$domains = @(
    "google.com"
    "ukr.net"
)

(Get-Process).ProcessName # вывод только содержимого одной колонки

#
# 3.4 Работа с хэшами
#

[hashtable]$h = @{ "name" = "Oleg" } # хеш содержит пары ключ-значение, в некоторых языках программирования называется словарем (Dictionary)
$h = @{
    "name" = "Oleg"
    "email" = "oleg.ivanov@globallogic.com"
}
$h.name # "Oleg" получить значение по ключу
$h.name = "Test" # изменить значение ключа

"My name is $($h['name'])" # "My name is Oleg" как вставить в строку значение из хэша

#
# 3.5 Работа с датой
#

$date = Get-Date # 24 ноября 2016 г. 21:47:06
$date.GetType() # DateTime тип
$date = Get-Date -f "yyyymmdd" # 20164724 можно использовать различные способы форматирования
$date.GetType() # String после формата превращаяется в строку
$sasTokenExpirity = Get-Date (Get-date).AddYears(10).ToUniversalTime() -Format "yyyy-MM-ddTHH:mm:ssZ" # нужно указать время действия токена
$sasTokenExpirity = Get-Date (Get-date).AddHours(10).ToUniversalTime() -Format "yyyy-MM-ddTHH:mm:ssZ" # нужно указать время действия токена

# Домашнее задание

# https://www.sysadmins.lv/blog-ru/powershell-massivy-chast-1-sozdanie-massivov.aspx
# http://www.vam.in.ua/index.php/it/25-ms-powershell/163-powershell-one-dimensional-arrays.html
# http://windowsnotes.ru/powershell-2/formaty-vremeni-i-daty-v-powershell/
