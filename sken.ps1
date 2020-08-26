<#

Objective was converting appeared scans(jpegs) from printer to tif.

#>


[Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')

net use H: \\path\to\folder
cd H:\
$cesta = pwd | Select -expandproperty path

$jpgs = get-childitem H:\ -recurse | where {$_.Extension -match "jpg"} | Where ({$_.Name -match '^scan\d+' -or $_.Name -match '^sken\d+'})

Start-Sleep -s 5

$jpgs2 = get-childitem H:\ -recurse | where {$_.Extension -match "jpg"} | Where ({$_.Name -match '^scan\d+' -or $_.Name -match '^sken\d+'})

if($jpgs2.count -eq $jpgs.count){
foreach($jpg in $jpgs){

	$filepath = "$($cesta)\$($jpg.Name)"


	$picture = [System.Drawing.Bitmap]($filepath)
	$picture.Save("H:\$($jpg.BaseName).tif",'TIFF')
	$picture.Dispose()

}


cd C:\


#deleting the old jpegs
$jpgs | Remove-item -force

#net use H: /delete 
}

else{
cd C:
#net use H: /delete
}
