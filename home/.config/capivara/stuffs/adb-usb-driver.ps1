#
# PowerShell Script for download and config platform-tools as Environment Variable.
#
# Also install Google USB Driver.
#
$TMP = "C:\.tmp"

$PLATFORM_TOOLS_SOURCE = "https://dl.google.com/android/repository/platform-tools_r33.0.2-windows.zip"
$PLATFORM_TOOLS_PATH = "c:\.tmp\platform-tools.zip"

$GOOGLE_USB_DRIVER_SOURCE = "https://dl.google.com/android/repository/usb_driver_r13-windows.zip"
$GOOGLE_USB_DRIVER_PATH = "c:\.tmp\usb_driver.zip"

mkdir $TMP

# Download and extract platform-tools
Invoke-WebRequest -Uri $PLATFORM_TOOLS_SOURCE -OutFile $PLATFORM_TOOLS_PATH
Expand-Archive -LiteralPath $PLATFORM_TOOLS_PATH -DestinationPath "c:\"

# Add it to Environment Variable path
$Env:Path += ";C:\platform-tools"

# Download and extract Google USB Drivers
Invoke-WebRequest -Uri $GOOGLE_USB_DRIVER_SOURCE -OutFile $GOOGLE_USB_DRIVER_PATH
Expand-Archive -LiteralPath $GOOGLE_USB_DRIVER_PATH -DestinationPath "c:\"

Get-ChildItem "C:\usb_driver\" -Recurse -Filter "*.inf" | 
ForEach-Object { PNPUtil.exe /add-driver $_.FullName /install }

Remove-Item $TMP -Recurse