# 這是一個 PowerShell 腳本的範例
# 它可以用來在重灌電腦後下載並依序安裝一些常用的應用程式、相關執行環境和依賴
# 這個腳本需要 PowerShell 7.4.0-preview.4 或更新的版本才能執行
# 這個腳本也需要設定執行原則為 RemoteSigned 或 Unrestricted 才能執行
# 請自行修改或增加需要安裝的應用程式和相關參數

# 定義一個函數來下載並安裝應用程式
function Install-App {
    param (
        # 應用程式的名稱
        [string]$Name,
        # 應用程式的下載網址
        [string]$Url,
        # 應用程式的安裝參數
        [string]$Arguments
    )

    # 在命令列中顯示正在下載的訊息
    Write-Host "Downloading $Name from $Url"

    # 使用 Invoke-WebRequest 命令來下載應用程式到暫存資料夾中
    $TempFile = Join-Path -Path $env:TEMP -ChildPath "$Name.exe"
    Invoke-WebRequest -Uri $Url -OutFile $TempFile

    # 在命令列中顯示正在安裝的訊息
    Write-Host "Installing $Name with arguments $Arguments"

    # 使用 Start-Process 命令來執行應用程式的安裝程式，並傳入安裝參數
    Start-Process -FilePath $TempFile -ArgumentList $Arguments -Wait

    # 在命令列中顯示已完成安裝的訊息
    Write-Host "$Name has been installed successfully"
}

# 下載並安裝 Google Chrome 瀏覽器，使用 /silent 參數來靜默安裝
Install-App -Name "Google Chrome" -Url "https://dl.google.com/chrome/install/ChromeStandaloneSetup.exe" -Arguments "/silent"

# 下載並安裝 Adobe Acrobat Reader DC，使用 /sAll 參數來靜默安裝
Install-App -Name "Adobe Acrobat Reader DC" -Url "https://ardownload2.adobe.com/pub/adobe/reader/win/AcrobatDC/2100720091/AcroRdrDC2100720091_en_US.exe" -Arguments "/sAll"

# 下載並安裝 Microsoft Visual Studio Code，使用 /VERYSILENT 參數來靜默安裝
Install-App -Name "Microsoft Visual Studio Code" -Url "https://aka.ms/win32-x64-user-stable" -Arguments "/VERYSILENT"

# 下載並安裝 Python 3.10.0，使用 /quiet 參數來靜默安裝，並加入 /passive 參數來顯示進度列
Install-App -Name "Python 3.10.0" -Url "https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe" -Arguments "/quiet /passive"

# 下載並安裝 Node.js 16.11.1 LTS，使用 /quiet 參數來靜默安裝，並加入 /tasks=install-npm 參數來安裝 npm
Install-App -Name "Node.js 16.11.1 LTS" -Url "https://nodejs.org/dist/v16.11.1/node-v16.11.1-x64.msi" -Arguments "/quiet /tasks=install-npm"

# 下載並安裝 Git 2.33.1，使用 /VERYSILENT 參數來靜默安裝，並加入 /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh" 參數來選擇安裝的元件
Install-App -Name "Git 2.33.1" -Url "https://github.com/git-for-windows/git/releases/download/v2.33.1.windows.1/Git-2.33.1-64-bit.exe" -Arguments "/VERYSILENT /COMPONENTS=`"icons,ext\reg\shellhere,assoc,assoc_sh`""
