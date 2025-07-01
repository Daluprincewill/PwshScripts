Add-Type -AssemblyName System.Windows.Forms

$FormObject = [System.Windows.Forms.Form]
$LabelObject = [System.Windows.Forms.Label]
$ButtonObject=[System.Windows.Forms.Button]


$HelloWorldForm= New-Object $FormObject
$HelloWorldForm.ClientSize = '500,300'
$HelloWorldForm.Text ='Hello World - Tutorial'
$HelloWorldForm.Backcolor = '#ffffff'

$Lbltitle=New-Object $LabelObject
$Lbltitle.Text = 'Mi Bombooclatt, who dat?'
$Lbltitle.AutoSize =$true
$Lbltitle.Font = 'gothic black,12,style=bold'
$Lbltitle.ForeColor='brown'
$Lbltitle.Location= New-Object System.Drawing.Point (150,110)

$btnHello=New-Object $ButtonObject 
$btnHello.Text= 'Say Hello'
$btnHello.AutoSize=$true
$btnHello.Font='verdana,14'


$btnHello.Location=New-Object System.Drawing.Point (205,170)

$HelloWorldForm.Controls.AddRange(@($Lbltitle, $btnHello))

##Logic Sections/Functions 

Function SayHello {
    if($Lbltitle.Text -eq ''){
        $Lbltitle.Text='yo, Wagwan brethren?'
    }else{
        $Lbltitle.Text=''}
}

##Add the functions to the form

$btnHello.Add_Click({SayHello})

#displays the form
$HelloWorldForm.ShowDialog()

#cleans up the form
$HelloWorldForm.Dispose()