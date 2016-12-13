<#

Здесь может находиться описание работы скрипта

#>

param(
    [Parameter(Mandatory=$false)]
    [string]
    $firstName = "Oleg",

    [Parameter(Mandatory=$false)]
    [string]
    $lastName = "Ivanov",

    [Parameter(Mandatory=$false)]
    [string]
    $email,

    [Parameter(Mandatory=$true)]
    [securestring]
    $password,

    [Parameter(Mandatory=$false)]
    [bool]
    $execution = $true
)

#
# Variables
#

$user = @{
    "firstname" = $firstName
    "lastname" = $lastname
    "email" = $email
}

$connectionParameters = @(
    "server=127.0.0.1",
    "username=${firstname}",
    "password=${password}"
)

$Env:yourPassword = "qwerty" # имитируем наличие пееменной окружения
$connectionString = $connectionParameters -join ';' # объеденим элементы массива в строку
$newPassword = ConvertTo-SecureString $Env:yourPassword -AsPlainText -Force # поместим пароль в строку в зашифрованом виде
$externalip = ((Invoke-WebRequest http://myexternalip.com/raw).Content).trim() # получить внешний ip с помошью веб-запроса

#
# Functions
#

function CreatePowershellCredential {
    param([string]$username, [securestring]$password)
    $powershellCredential = New-Object -TypeName pscredential -ArgumentList $username, $password
    return $powershellCredential
}

function DecodeSecureString {
    $byteString = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($script:psCredential.password)
    $plaintextPassword = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($byteString)
    return $plaintextPassword
}

function DeleteFile ($path) {
    Remove-Item -Path $path -ErrorAction SilentlyContinue # проигнорирует ошибку если файл не существует
    Write-Output "The ${path} file has been deleted"
}

function GetFakeResource {
    $uri = "http://jsonplaceholder.typicode.com/posts/1"
    $header = @{
        "Content-Type" = "application/json"
    }
    $result = Invoke-RestMethod -Uri $uri -Method "GET" -Headers $header
    return $result
}

function SetFakeResource {
    $uri = "http://jsonplaceholder.typicode.com/posts"
    $header = @{
        "Content-Type" = "application/json"
    }
    $body = @{
        "data" = @{
            "title" = "foo"
            "body" = "bar"
            "userId" = 1
        }
    } | ConvertTo-Json
    $result = Invoke-RestMethod -Uri $uri -Method "POST" -Headers $header -Body $body
    return $result
}

#
# Execution
#

if ($execution) {
    $Env:yourPassword
    $connectionString
    $newPassword

    # -foreground позволяет выделить текст другим цветом
    Write-Host "`n[ Creating a powershell credential ]`n" -foreground "green"
    $psCredential = CreatePowershellCredential -username $firstName -password $newPassword
    $psCredential.GetType()
    $psCredential

    Write-Host "`n[ Decoding a secure string ]`n" -foreground "green"
    $decodedPassword = (DecodeSecureString)
    $decodedPassword

    Write-Host "`n[ Deleting a file ]`n" -foreground "green"
    DeleteFile -path ".\delete.me"

    Write-Host "`n[ Getting a fake resource using a REST API call ]`n" -foreground "green"
    $response = (GetFakeResource)
    $response

    Write-Host "`n[ Creating a fake resource using a REST API call ]`n" -foreground "green"
    $response = (SetFakeResource)
    $response
}

# Домашнее задание

# http://jsonplaceholder.typicode.com/
# https://github.com/PoshCode/PowerShellPracticeAndStyle
# https://en.wikipedia.org/wiki/Don't_repeat_yourself
