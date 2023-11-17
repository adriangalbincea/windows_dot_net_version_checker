# Function MsgBox

Function msgbox{

	Param(
	[Parameter(Mandatory=$True)][Alias('M')][String]$Msg,
	[Parameter(Mandatory=$False)][Alias('T')][String]$Title = ".Net Version Checker",
	[Parameter(Mandatory=$False)][Alias('OC')][Switch]$Ok,
	[Parameter(Mandatory=$False)][Alias('OCI')][Switch]$AbortRetryIgnore,
	[Parameter(Mandatory=$False)][Alias('YNC')][Switch]$YesNoCancel,
	[Parameter(Mandatory=$False)][Alias('YN')][Switch]$YesNo,
	[Parameter(Mandatory=$False)][Alias('RC')][Switch]$RetryCancel,
	[Parameter(Mandatory=$False)][Alias('C')][Switch]$Critical,
	[Parameter(Mandatory=$False)][Alias('Q')][Switch]$Question,
	[Parameter(Mandatory=$False)][Alias('W')][Switch]$Warning,
	[Parameter(Mandatory=$False)][Alias('I')][Switch]$Informational,
    [Parameter(Mandatory=$False)][Alias('TM')][Switch]$TopMost)

	#Set Message Box Style
	IF($OkCancel){$Type = 1}
	Elseif($AbortRetryIgnore){$Type = 2}
	Elseif($YesNoCancel){$Type = 3}
	Elseif($YesNo){$Type = 4}
	Elseif($RetryCancel){$Type = 5}
	Else{$Type = 0}
	
	#Set Message box Icon
	If($Critical){$Icon = 16}
	ElseIf($Question){$Icon = 32}
	Elseif($Warning){$Icon = 48}
	Elseif($Informational){$Icon = 64}
	Else { $Icon = 0 }
	
	#Loads the WinForm Assembly, Out-Null hides the message while loading.
	[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
	
	If ($TopMost)
	{
		#Creates a Form to use as a parent
		$FrmMain = New-Object 'System.Windows.Forms.Form'
		$FrmMain.TopMost = $true
		
		#Display the message with input
		$Answer = [System.Windows.Forms.MessageBox]::Show($FrmMain, $MSG, $TITLE, $Type, $Icon)
		
		#Dispose of parent form
		$FrmMain.Close()
		$FrmMain.Dispose()
	}
	Else
	{
		#Display the message with input
		$Answer = [System.Windows.Forms.MessageBox]::Show($MSG , $TITLE, $Type, $Icon)			
	}
	
	#Return Answer
	Return $Answer
}

# Checking .Net Version against the Registry

$version = $null
$release = Get-ItemProperty -Path 'HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' -Name Release | Select-Object -ExpandProperty Release
if ($release -eq 533320) { $version = '4.8.1 or later'}
elseif ($release -eq 533325) {$version = '4.8.1 or later'}
elseif ($release -eq 528040) {$version = '4.8'}
elseif ($release -eq 528449) {$version = '4.8'}
elseif ($release -eq 528372) {$version = '4.8'}
elseif ($release -eq 528049) {$version = '4.8'}
elseif ($release -eq 461808) {$version = '4.7.2'}
elseif ($release -eq 461814) {$version = '4.7.2'}
elseif ($release -eq 461308) {$version = '4.7.1'}
elseif ($release -eq 461310) {$version = '4.7.1'}
elseif ($release -eq 460798) {$version = '4.7'}
elseif ($release -eq 460805) {$version = '4.7'}
elseif ($release -eq 394802) {$version = '4.6.2'}
elseif ($release -eq 394806) {$version = '4.6.2'}
elseif ($release -eq 394254) {$version = '4.6.1'}
elseif ($release -eq 394271) {$version = '4.6.1'}
elseif ($release -eq 393295) {$version = '4.6'}
elseif ($release -eq 393297) {$version = '4.6'}
elseif ($release -eq 379893) {$version = '4.5.2'}
elseif ($release -eq 378675) {$version = '4.5.1'}
elseif ($release -eq 378758) {$version = '4.5.1'}
elseif ($release -eq 378389) {$version = '4.5'}

# Output in a message box

if ($version) {
    msgbox -Informational ".NET Version: $version"
} else {
    msgbox -Informational ".NET Version 4.5 or later is not detected."
}