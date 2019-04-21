## FInding images

$loc = (Get-AzLocation | OGV -passthru).location  #first set a location

#View the templates available
$publisher=(Get-AzVMImagePublisher -Location $loc |OGV -passthru).publishername  #check all the publishers available

$offer=(Get-AzVMImageOffer -Location $loc -PublisherName $publisher|OGV -passthru).offer  #look for offers for a publisher

$sku=(Get-AzVMImageSku -Location $loc -PublisherName $publisher -Offer $offer | OGV -passthru).skus  #view SKUs for an offer

Get-AzVMImage -Location $loc -PublisherName $publisher -Offer $offer -Skus $sku |ogv #pick one!
