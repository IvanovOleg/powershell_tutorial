<#

Invoke-Pester -Script @{
    Path = './lesson5.tests.ps1'
    Parameters = @{ 
        email = "oleg.ivanov@globallogic.com"
        password = (ConvertTo-SecureString "qwerty" -AsPlainText -Force)
    }
}

#>

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'

# Загрузка контекста (функций) из скрипта

. "$here\$sut" -execution $false -password (ConvertTo-SecureString "qwerty" -AsPlainText -Force)

Describe "Powershell Authentication" { # групповое разделение секций
    Context "Testing a powershell credential creation mechanism" { 
        It "Azure RM authentication confirmed" {
            $result = CreatePowershellCredential -username "oleg" -password $password
            $result.UserName | Should Be "oleg"
        }
    }
}

Describe "REST API tests" {
    Context "Testing a REST API (GET) method" { # логическое разделение секций
        $result = GetFakeResource
        It "A fake resource should contain 'et suscipit'" { # проверка первого условия
            $result.body | Should BeLike "*et suscipit*"
        }
        It "A fake resource should contain 'oleg'" { # проверка второго условия
            $result.body | Should BeLike "*oleg*"
        }
    }

    Context "Testing a REST API (POST) method" {
        $result = SetFakeResource
        It "A fake resource title should be equal to 'foo'" {
            $result.data.title | Should Be "foo"
        }
        It "A fake resource id should be equal to '101'" {
            $result.id | Should Be "101"
        }
    }
}

# Домашнее задание

# https://github.com/pester/Pester
