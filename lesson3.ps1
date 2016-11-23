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

$single = '`ttest' # "`ttest" специальные символы игнорируются
$double = "`ttest" # "    test" специальные символы обрабатываются

$number = "4" # string
[int]$number # 4 int

$str = "Hello World!"
$str.ToUpper() # "HELLO WORLD!"
$str.ToLower() # "hello world!"

$str.Contains("ello") # True проверяет есть ли в строке вхождение шаблона
$str.Replace(" ", "-") # "Hello-World!" заменяет один элемент строки на другой
$str.Substring(3) # "lo World!" убирает первых n символов из строки
$str.Substring(3,2) # "lo" второй параметр указывает на то, сколько символов взять после отрезанных первым параметром
"   trim   ".Trim() # "trim" уберает пробелы с начала и с конца
