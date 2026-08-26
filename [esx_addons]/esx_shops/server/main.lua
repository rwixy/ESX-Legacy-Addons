---Handles purchase requests from clients
<<<<<<< HEAD
ESX.RegisterServerCallback('esx_shops:purchaseItems', function(source, cb, purchaseData, zone)
=======
xLib.callback.registerCompat('esx_shops:purchaseItems', function(source, cb, purchaseData, zone)
>>>>>>> upstream-1142/1.14.2
	ProcessPurchase(source, purchaseData, zone, cb)
end)
