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
    $password
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



#
# Execution
#

$Env:yourPassword
$connectionString
$newPassword

Write-Host "`n[ Creating a powershell credential ]`n" -foreground "green"
$psCredential = CreatePowershellCredential -username $firstName -password $newPassword
$psCredential.GetType()

Write-Host "`n[ Decoding a secure string ]`n" -foreground "green"
$decodedPassword = (DecodeSecureString)
$decodedPassword

Write-Host "`n[ Deleting a file ]`n" -foreground "green"
DeleteFile -path ".\delete.me"
