Add-Type -AssemblyName System.Windows.Forms

$FormObject=[System.Windows.Forms.Form]
$LabelObject=[System.Windows.Forms.Label]
$ComboBoxObject=[System.Windows.Forms.ComboBox]

$DefaultFont = 'Verdana,12'

##Set up base form
$AppForm=New-Object $FormObject
$AppForm.ClientSize= '500,300'
$Appform.Text='Chidalu_Service Inspector'
$AppForm.BackColor='white'
$AppForm.Font=$DefaultFont

##Builing the GUI
$LblService=New-Object $LabelObject
$LblService.Text='Services :'
$LblService.AutoSize=$true
$LblService.Location=New-Object System.Drawing.Point(20,20)


$LblForName=New-Object $LabelObject
$LblForName.Text='Service Friendly Name :'
$LblForName.AutoSize=$true
$LblForName.Location=New-Object System.Drawing.Point(20,80)

$LblName=New-Object $LabelObject
$LblName.Text=''
$LblName.AutoSize=$true
$LblName.Location=New-Object System.Drawing.Point(250,80)

$LblForStatus=New-Object $LabelObject
$LblForStatus.Text='Status :'
$LblForStatus.AutoSize=$true
$LblForstatus.Location=New-Object System.Drawing.Point(20,100)

$Lblstatus=New-Object $LabelObject
$Lblstatus.Text=''
$Lblstatus.AutoSize=$true
$Lblstatus.Location=New-Object System.Drawing.Point(250,100)

##ddl -drop down list for combobox
$ddlservice=New-Object $ComboBoxObject
$ddlservice.Width='300'
$ddlservice.Text='Pick a damn service, Bitch Ass Nigga'
$ddlservice.Font='Verdana,9'
$ddlservice.Location=New-Object System.Drawing.Point (120,20)

#Load the services in the combobox
Get-Service | foreach {$ddlservice.Items.add($_.Name)}

##Add  some Functions to the Form

function GetServiceDetails{
    $serviceName=$ddlservice.SelectedItem
    $details=Get-Service -Name $serviceName | select *
    $LblName.Text=$details.name
    $Lblstatus.Text=$details.status

    if($details.status -eq 'Running'){
        $Lblstatus.ForeColor='green'
    }else{$Lblstatus.ForeColor='Red'}
} 

##Add Functions to the controls

$ddlservice.Add_SelectedIndexChanged({GetServiceDetails})




##Add objects onto the form
$AppForm.Controls.AddRange(@($LblService,$ddlservice,$LblName,$LblForName,$LblForStatus,$Lblstatus))

##make sure that the form pops up
$AppForm.ShowDialog()

##garbage collection
$AppForm.Dispose()