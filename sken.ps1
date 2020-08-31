<#

Objective was converting appeared scans(jpegs) from printer to tif.

#>


Add-Type -AssemblyName System.Windows.Forms

$path='C:\path\to\folder\'


#using regex to parse jpgs with name in form scan or sken with numbers after it
$jpgs = get-childitem $path -recurse | where {$_.Extension -match "jpg"} | Where ({$_.Name -match '^scan\d+' -or $_.Name -match '^sken\d+'})

Start-Sleep -s 5 #wait 5 seconds if any jpgs appear from printer...

#in jpgs2 we parse jpgs files again
$jpgs2 = get-childitem $path -recurse | where {$_.Extension -match "jpg"} | Where ({$_.Name -match '^scan\d+' -or $_.Name -match '^sken\d+'})


if($jpgs2.count -eq $jpgs.count){    #here we compare count of jpgs and jpgs2 and if its equal we convert jpeg files
foreach($jpg in $jpgs){

	$filepath = "$($path)\$($jpg.Name)"


	$picture = [System.Drawing.Bitmap]($filepath)
	$picture.Save("$path\$($jpg.BaseName).tif",'TIFF')
	$picture.Dispose()

}

#deleting the old jpegs
$jpgs | Remove-item -force

 
}
