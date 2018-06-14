//-------------------------JB-Car's-2------------------//
//---------------------------V2.0.2--------------------//
//------------------------by-Horsemeat-----------------//
#include <a_samp>
#include <ysi\y_ini>
#include <streamer>
#include <sscanf2>
#include <zcmd>
#include <ini_quicky>
#include <progress>
#include <IsPlayerLAdmin>
#define FILTERSCRIPT
#define RED 0xFF0000ff
#define DARKBLUE 0x0000FFff
#define LIGHTBLUE 0x00E1FFff
#define GREEN 0x22D451ff
#define YELLOW 0xEAFF00ff
#define BLUEGREEN 0xA5C9B0ff
#define PINK 0xFF00CCff
#define WHITE 0xFFFFFFff
#define GREY 0x969696ff
#define PURPLE 0xC2A2DAAA
#define ORANGE 0xFF9100ff
#define REPAIRSHOPCOLOR 0xB87FE3ff
#define REFINERYSELLCOST 10
#define MAX_REFINERYS 20
#define MAX_OILPUMPS 15
#define MAX_GASSTATIONS 50
#define MAX_GASPUMPS 8
#define MAX_DMVS 5
#define MAX_REPAIRSHOPS 10
#define MAX_EMPLOYEES 20
#define MAX_BLOCKS 100
#define DISTANCELABEL 25.0
#define PRECENTAGEOFFPAYMENT 0.13
#define MAX_OILSTORAGE 5000.0
#define MAX_GASPERPUMP 1000.0
#define MAX_DEALERSHIPS 100
#define MAX_DISPOSERS 5
#define FACTORYMARKUPPRECENT 1.25
#define MAX_FACTORIES 20
#define COSTOFGASFROMREFINERY 5
#define COSTOFGASFROMDELIVERYTRUCK 6
#define MAX_SLOTS 24
#define FACTORYMAXORDERSATONCE 12//Would not change if I were you since listbox goes only up to around 10
#define REFINERYMENU 50
#define REFINERYMENUSTATEMENT "Deposit cash\nWithdraw Cash\nCheck balance\nProductionstate\nSellstate"
#define ADDCASHINPUT 51
#define TAKECASHINPUT 52
#define REMOVECASHINPUT 53
#define REFINERYBACK&CANCEL 54
#define REFINERYONOFF 55
#define REFINERYSELLSTATE 56
#define GASSTATIONMENUSTATEMENT "Deposit cash\nWithdraw Cash\nBuy Gas\nGas Station Name\nGas Station Gas Cost\nCancel Buy gas\nView current gas purchase"
#define GASSTATIONMENU 57
#define ADDCASHGASSTATION 58
#define REMOVECASHGASSTATION 59
#define GASSTATIONBACK&CANCEL 60
#define GASSTATIONCHANGEAMMOUNTQ 61
#define GASSTATIONCHANGEAMMOUNT 62
#define GASSTATIONNAMEINPUT 63
#define CANCEL 64
#define GASSTATIONSELECTION 65
#define BUYGAS 66
#define LISTCARS 67
#define CUSTOM 68
#define AIRPLANES 69
#define HELICOPTERS 70
#define BIKES 71
#define CONVERTIBLES 72
#define INDUSTRIAL 73
#define LOWRIDERS 74
#define OFFROAD 75
#define SERVICEVEHICLES 76
#define SALOONS 77
#define SPORTSCARS 78
#define STATIONWAGONS 79
#define BOATS 80
#define OTHERS 81
#define OTHERSCANTSELL 82
#define INDUSTRIALP1 83
#define INDUSTRIALP2 84
#define SERIVCEVEHICLESPOLICE 85
#define SERIVCEVEHICLESAMBULANCE 86
#define SERVICEVEHICLESTRANSPORTATION 87
#define SALOONSP1 88
#define SALOONSP2 89
#define SPORTSCARSP1 90
#define SPORTSCARSP2 91
#define OTHERSP1 92
#define OTHERSP2 93
#define OTHERSP3 94
#define OTHERSP4 95
#define GASSTATIONGASCOST 96
#define SELECTGASSTATION 97
#define REFINERYPAYBACK 98
#define DEALERSHIPMENU 99
#define DEALERSHIPMENUSTATEMENT "Deposit cash\nWithdraw cash\nDealership name\nbuycar\nview current buying car"
#define DEALERSHIPDEPOSIT 100
#define DEALERSHIPWITHDRAW 101
#define DEALERSHIPNAME 102
#define DEALERSHIPBACK&CANCEL 103
#define CARBUYMENU 104
#define FACTORYMENU 105
#define FACTORYMENUSTATEMENT "Deposit cash\nWithdraw cash\nSell car to dealership\nproductionstate\nview current vehicle in production"
#define FACTORYDEPOSIT 106
#define FACTORYWITHDRAW 107
#define FACTORYBACK&CANCEL 108
#define DEALERSHIPBUYCAR 109
#define DEALERSHIPCANCELBUYCAR 110
#define FACTORYSELLTODEALERSHIP 111
#define FACTORYPRODUCTIONSTATE 112
#define FACTORYCURRENTPRODUCTION 113
#define DEALERSHIPAPROVE 114
#define FACTORYDELIVERY 115
#define DISPOSERMENU 116
#define REPAIRSHOPBUYLOCK 117
#define VEHICLEMAKEPRICE 118
#define COLORSELECTION1 119
#define COLORSELECTION2 120
#define COLORSELECTIONSTATEMENT "Input Manualy\nBlack\nRed\nBlue\nGreen\nPurple\nYellow\nPink\nWhite\nGrey\nRandom"
#define COLORSELECTIONINPUT1 121
#define COLORSELECTIONINPUT2 122
#define VEHICLEMAKEPRICECONFIRM 123
#define VEHICLEREMOVECONFIRM 124
#define VEHICLEREPAIRSHOPADD 125
#define VEHICLEREPAIRSHOPREMOVE 126
#define MODCAR 127
//------------------files---------------//
new mainfilename[] = "JBcars/maindata.ini";
new restrictedcarsfilename[] = "JBcars/restrictedcars.ini";
new carfilename[] = "JBcars/cardata.ini";
//new grouplogfilename[] = "JBcars/logdata.ini";//#4
new playerdatafilename[] = "JBcars/playerdata.ini";
//------------------Gasstationdata------------
new gasstationstate[MAX_GASSTATIONS];
new gasstationownedstate[MAX_GASSTATIONS];
new gasstationownername[MAX_GASSTATIONS][MAX_PLAYER_NAME];
new Float:gasstationx[MAX_GASSTATIONS];
new Float:gasstationy[MAX_GASSTATIONS];
new Float:gasstationz[MAX_GASSTATIONS];
new Text3D:gasstationlabel[MAX_GASSTATIONS];
new gasstationcost[MAX_GASSTATIONS];
new gasstationcash[MAX_GASSTATIONS];
new gasstationgascost[MAX_GASSTATIONS];
new gasstationbuygascost[MAX_GASSTATIONS];
new gasstationneedgasstate[MAX_GASSTATIONS];
new Float:ammountofgasneeded[MAX_GASSTATIONS];
new Float:gasstationtotalcapacity[MAX_GASSTATIONS];
new gasstationname[MAX_GASSTATIONS][128];
new gasstationbeingdeliveredto[MAX_GASSTATIONS];//Don't Save
//-------------------Gasstationpumpdata-----------
new gaspumpstate[MAX_GASPUMPS][MAX_GASSTATIONS];
new Float:gaspumpx[MAX_GASPUMPS][MAX_GASSTATIONS];
new Float:gaspumpy[MAX_GASPUMPS][MAX_GASSTATIONS];
new Float:gaspumpz[MAX_GASPUMPS][MAX_GASSTATIONS];
new Float:gaspumpxrot[MAX_GASPUMPS][MAX_GASSTATIONS];
new Float:gaspumpyrot[MAX_GASPUMPS][MAX_GASSTATIONS];
new Float:gaspumpzrot[MAX_GASPUMPS][MAX_GASSTATIONS];
new gaspumpobject[MAX_GASPUMPS][MAX_GASSTATIONS];
new gaspumpobjectid[MAX_GASPUMPS][MAX_GASSTATIONS];
new Text3D:gaspumplabel[MAX_GASPUMPS][MAX_GASSTATIONS];
new gaspumpcurrentsaleammount[MAX_GASPUMPS][MAX_GASSTATIONS];
new Float:gaspumpcurrentfuelammount[MAX_GASPUMPS][MAX_GASSTATIONS];
new gaspumpusegestate[MAX_GASPUMPS][MAX_GASSTATIONS];
new gaspumpuser[MAX_PLAYER_NAME][MAX_GASPUMPS][MAX_GASSTATIONS];
new refueltimer[MAX_PLAYERS];
new Float:gaspumpgas[MAX_GASPUMPS][MAX_GASSTATIONS];
//------------------refinerydata--------
new refinerystate[MAX_REFINERYS];
new refineryownedstate[MAX_REFINERYS];
new refineryownername[MAX_REFINERYS][MAX_PLAYER_NAME];
new Float:refineryx[MAX_REFINERYS];
new Float:refineryy[MAX_REFINERYS];
new Float:refineryz[MAX_REFINERYS];
new Text3D:refinerylabel[MAX_REFINERYS];
new refineryproductionstate[MAX_REFINERYS];
new refinerycost[MAX_REFINERYS];
new refinerycash[MAX_REFINERYS];
//new Float:refinerydebt[MAX_REFINERYS];#4
new refinerysellstate[MAX_REFINERYS];
new refinerytrailerstate[MAX_REFINERYS];
new Float:refinerytrailerx[MAX_REFINERYS];
new Float:refinerytrailery[MAX_REFINERYS];
new Float:refinerytrailerz[MAX_REFINERYS];
new Float:refinerytrailerrot[MAX_REFINERYS];
new refineryblocked[MAX_REFINERYS];//don't Save
//----------------------oilpumpdata----------------
new oilpumpstate[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilpumpx[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilpumpy[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilpumpz[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilpumpxrot[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilpumpyrot[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilpumpzrot[MAX_OILPUMPS][MAX_REFINERYS];
new oilpumpobject[MAX_OILPUMPS][MAX_REFINERYS];
new oilpumpobjectid[MAX_OILPUMPS][MAX_REFINERYS];
new Text3D:oilpumplabel[MAX_OILPUMPS][MAX_REFINERYS];
//--------------gloabal contorl vars------------------
new costofoilpumps;
new costofoilstorage;
new Float:oilpumpedpersec;
new costofgaspump;
//new Float:powercost;#4
new vehiclebuildamountincrease;
//--------------------oilstoragevarabiles--------------
new Text3D:oilstoragelabel[MAX_OILPUMPS][MAX_REFINERYS];
new oilstorageobject[MAX_OILPUMPS][MAX_REFINERYS];
new oilstorageobjectid[MAX_OILPUMPS][MAX_REFINERYS];
new oilstoragestate[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilstoragex[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilstoragey[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilstoragez[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilstoragexrot[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilstorageyrot[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilstoragezrot[MAX_OILPUMPS][MAX_REFINERYS];
new Float:oilstoragefuel[MAX_OILPUMPS][MAX_REFINERYS];
new oilstoragefull[MAX_OILPUMPS][MAX_REFINERYS];
//--------------------buid type-----------------------------
new buildtype[MAX_PLAYERS];//0 = nothing 1 = moveoilpump = 2 moveoilstorage = 3 movegaspump = 4
new editobjrefinery[MAX_PLAYERS];
new editobjextra[MAX_PLAYERS];
new editobjgasstation[MAX_PLAYERS];
new editobjdealership[MAX_PLAYERS];
new editobjblock[MAX_PLAYERS];
new edittrailerposstate[MAX_PLAYERS];
new edittrailertrailer[MAX_PLAYERS];
new editobjfactory[MAX_PLAYERS];
new editobjrepairshop[MAX_PLAYERS];
new admineditingstate[MAX_PLAYERS];
new admineditingreason[MAX_PLAYERS][64];
new Float:oldx[MAX_PLAYERS],Float:oldy[MAX_PLAYERS],Float:oldz[MAX_PLAYERS],Float:oldxrot[MAX_PLAYERS],Float:oldyrot[MAX_PLAYERS],Float:oldzrot[MAX_PLAYERS];
//------------------timers------------------
new refineryproductiontimer[MAX_REFINERYS];
//-------------------buyingfuel---------------
new deliveryid[MAX_PLAYERS];
new deliveryrefineryid[MAX_PLAYERS];
new deliverystate[MAX_PLAYERS];
new deliverydropoffstate[MAX_PLAYERS];
new deliverytrailer[MAX_PLAYERS];
new deliverycountdownstate[MAX_PLAYERS];
new deliverycountdowncount[MAX_PLAYERS];
new deliverycountdowntimer[MAX_PLAYERS];
new deliverytruck[MAX_PLAYERS];
new Float:deliveryfuel[MAX_PLAYERS];
//----------------delivers-cars--------
new deliveryfactoryid[MAX_PLAYERS];
new deliverycarsamount[MAX_PLAYERS];
new deliverymodelid[MAX_PLAYERS];
new deliverydealershipid[MAX_PLAYERS];
//------------------globalvars------------
new choicemarked[14][MAX_PLAYERS];
new playerbeinginvited[MAX_PLAYERS];
new playerbeinginvitedto[MAX_PLAYERS][256];
new playerbeinginvitedadmin[MAX_PLAYERS];
new Text:scriptlabel;
new restrictcar[612];
new Text:getbackin;
new Text:textrepaircar;
new Text:texttotaledcar;
new Text:textaddinglock;
//new paycheckcount[MAX_PLAYERS];#4
new totaledvehicle[MAX_VEHICLES];
new Text:textlocked[MAX_VEHICLES];
new playerbeingsoldto[MAX_PLAYERS];//playerbeingsoldto = 1 gasstation, playerbeingsoldto = 2 refineryid, playerbeingsoldto = 3 dealershipid
new itembeingsold[MAX_PLAYERS];
new priceforitembeingsold[MAX_PLAYERS];
new sellplayer[MAX_PLAYERS];
new Float:fuel[MAX_VEHICLES];
new Float:totaldistence[MAX_VEHICLES];
new fueluseingtimer[MAX_VEHICLES];
new fueluseingcount[MAX_VEHICLES];
new vehiclemanufactureingcoststate;
new carspawn;
new addvstate[MAX_PLAYERS];// addvstate1 = addvtodealership addvstate2 = carspawn addvstate3 = restrictcar addvstate4 = setmanufactureingprice addvstate5 = dealershipbuying
new choicecolor1[MAX_PLAYERS];
new choicecolor2[MAX_PLAYERS];
new choiceid[MAX_PLAYERS];
new choicecost[MAX_PLAYERS];
new choicemodelid[MAX_PLAYERS];
//new choicestring[MAX_PLAYERS][256];//#4
new pagecount[MAX_PLAYERS];
new lastplayerinvehicle[MAX_VEHICLES];
new playerlastvehicle[MAX_PLAYERS];
new playerrefueling[MAX_PLAYERS];
new gasstationgasroundcount[MAX_PLAYERS];
new vNames[212][64] = {
        "Landstalker", "Bravura", "Buffalo", "Linerunner", "Pereniel", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
        "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Mr Whoopee", "BF Injection",
        "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
        "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
        "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider",
        "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR3 50", "Walton", "Regina",
        "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood",
        "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick", "Boxville-1", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B",
        "Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropdust", "Stunt", "Tanker", "RoadTrain",
        "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck",
        "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent", "Bullet", "Clover",
        "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster A",
        "Monster B", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito", "Freight", "Trailer",
        "Kart", "Mower", "Duneride", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "Newsvan", "Tug", "Trailer A", "Emperor",
        "Wayfarer", "Euros", "Hotdog", "Club", "Trailer B", "Trailer C", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car (LSPD)", "Police Car (SFPD)",
        "Police Car (LVPD)", "Police Ranger", "Picador", "S.W.A.T. Van", "Alpha", "Phoenix", "GlendaleBusted", "SadlerBusted", "Luggage Trailer A", "Luggage Trailer B",
        "Stair Trailer", "Boxville-2", "Farm Plow", "Utility Trailer"
};
new vehiclemanufactureingcost[212] =
{
	15999,4999,17234,36999,5534,9999,106432,76545,41340,18999,
	5999,21999,4999,6000,10056,19865,46755,102323,7865,5123,
	9874,11984,5987,9056,2300,200132,9874,57432,57432,19999,
	45643,88754,1092321,12343,3450,7000,6021,99754,7874,7653,
	7564,100,12300,45675,9654,5675,14900,25400,999,100,
	3454,23999,23400,17954,45654,11984,8543,200,6534,6000,
	31999,999,199,1000,100,100,2999,3999,1100,25400,13999,
	1399,19320,50,1850,2850,18955,20232,3999,5534,17869,
	5,6785,5434,46753,1600,3200,24000,24000,4986,6785,
	4299,5340,12900,3000,3343,6423,24000,5674,7856,5875,
	100,3000,3000,2850,4986,22895,7859,18900,5,5,
	68500,21000,21000,34999,32999,5687,4850,4950,199999,1114923,
	2999,2850,2350,21343,8654,5454,5643,32984,6139,234,
	345,16954,8954,5876,8999,9543,750000,750000,45600,4985,
	24500,2999,3500,45423,3590,5643,5643,120000,2999,7850,
	6550,5550,76000,11985,9853,12343,12343,13498,16999,11764,
	9785,8985,38000,100,6777,5010,3850,1799,100,100,450,
	60,39000,3345,4895,4989,5300000,29850,17999,13499,1799,
	6000,2345,3450,5460,1750,14995,8650,9850,100,2230,
	7600000,18500,100,21850,9874,9874,10875,11874,7850,45670,
	16700,17899,100,100,100,100,100,7856,100,100
};
//-------------------gagedata---------------------------
new Text:gagespeedlabels[11];
new Text:gagecenterpoint;
new Text:gagespeed[MAX_VEHICLES];
new Text:gagefuel[MAX_VEHICLES];
new Text:gagehealth;
new Text:gagepoint[4][210];
new Text:gagedistance[MAX_VEHICLES];
new Bar:barhealth[MAX_VEHICLES];
new Bar:barfuel[MAX_VEHICLES];
new gagetimer[MAX_PLAYERS];
new gagelastspeed[MAX_VEHICLES];
new gageenabled[MAX_PLAYERS] = 1;//Save
//---------------delearshipdata-----------------------------
new dealershipstate[MAX_DEALERSHIPS];
new dealershipname[MAX_DEALERSHIPS][128];
new Float:dealershipx[MAX_DEALERSHIPS];
new Float:dealershipy[MAX_DEALERSHIPS];
new Float:dealershipz[MAX_DEALERSHIPS];
new Text3D:dealershiplabel[MAX_DEALERSHIPS];
new dealershipownedstate[MAX_DEALERSHIPS];
new dealershipownername[MAX_DEALERSHIPS][MAX_PLAYER_NAME];
new dealershipcost[MAX_DEALERSHIPS];
new dealershipcash[MAX_DEALERSHIPS];
new requeststock[212][MAX_DEALERSHIPS];
new requeststockstate[212][MAX_DEALERSHIPS];//if state = 1//requester state = 2//factory accept and will manufacture vehicle
new dealershipordercash[MAX_DEALERSHIPS];
//----------------CarData-----------------------------------
new jbcarid[MAX_VEHICLES];//don't Save
new carstate[MAX_VEHICLES];
new cartype[MAX_VEHICLES];
new Float:carfuel[MAX_VEHICLES];
new Float:carx[MAX_VEHICLES];
new Float:cary[MAX_VEHICLES];
new Float:carz[MAX_VEHICLES];
new Float:carrot[MAX_VEHICLES];
new car[MAX_VEHICLES];//don't save
new carcolor1[MAX_VEHICLES];
new carcolor2[MAX_VEHICLES];
new carcost[MAX_VEHICLES];
new Text3D:carlabel[MAX_VEHICLES];//don't save
new carmodelid[MAX_VEHICLES];
new cardealershipid[MAX_VEHICLES];
new carownername[MAX_VEHICLES][MAX_PLAYER_NAME];
new carstock[MAX_VEHICLES];
new carlocktype[MAX_VEHICLES];//lock = 0// nolock //I-lock = 1//E-Lock lock = 2
new carlock[MAX_VEHICLES];
new carmodslot[14][MAX_VEHICLES];
new Float:cartotaldistence[MAX_VEHICLES];
//----------------factory-------------------------------------------
new factorystate[MAX_FACTORIES];
new Float:factoryx[MAX_FACTORIES];
new Float:factoryy[MAX_FACTORIES];
new Float:factoryz[MAX_FACTORIES];
new factoryownername[MAX_FACTORIES][MAX_PLAYER_NAME];
new Text3D:factorylabel[MAX_FACTORIES];//Don't Save
new factoryownedstate[MAX_FACTORIES];
new factorycost[MAX_FACTORIES];
new factorycash[MAX_FACTORIES];
new factorytimer[MAX_FACTORIES];//Don't Save
new factoryproductionstate[MAX_FACTORIES];
new factorydealershipid[FACTORYMAXORDERSATONCE][MAX_FACTORIES];
new factorydealerstock[FACTORYMAXORDERSATONCE][MAX_FACTORIES];
new factorydealerstockmodelid[FACTORYMAXORDERSATONCE][MAX_FACTORIES];
new factorystockstate[FACTORYMAXORDERSATONCE][MAX_FACTORIES];
new factorystock[FACTORYMAXORDERSATONCE][MAX_FACTORIES];
new factoryordercost[FACTORYMAXORDERSATONCE][MAX_FACTORIES];
new factorystockcurrent[FACTORYMAXORDERSATONCE][MAX_FACTORIES];
new factorydeliverying[FACTORYMAXORDERSATONCE][MAX_FACTORIES];//Don't Save
//-------------------------Request-slots------------------------------
new gasstationrequestslotstate[MAX_SLOTS];
new gasstationrequestslot[MAX_SLOTS];
new dealershiprequestslotstate[MAX_SLOTS];
new dealershiprequestslot[2][MAX_SLOTS];
//-------------------------Dispose-Car--------------------------------
new disposecarstate[MAX_DISPOSERS];
new Float:disposecarx[MAX_DISPOSERS];
new Float:disposecary[MAX_DISPOSERS];
new Float:disposecarz[MAX_DISPOSERS];
new Text3D:disposelabel[MAX_DISPOSERS];//don't save
/*/------------------------DMV---------------------------------//#4
new dmvstate[MAX_DMVS];
new Float:dmvx[MAX_DMVS];
new Float:dmvy[MAX_DMVS];
new Float:dmvz[MAX_DMVS];
new Text3D:dmvlabel[MAX_DMVS];*/
//------------------------RepairShop---------------------------//#4
new repairshopstate[MAX_REPAIRSHOPS];
new repairshoppickup[MAX_REPAIRSHOPS];//new //don't save
new Float:repairshopx[MAX_REPAIRSHOPS];
new Float:repairshopy[MAX_REPAIRSHOPS];
new Float:repairshopz[MAX_REPAIRSHOPS];
new Float:repairshopxrot[MAX_REPAIRSHOPS];//new
new Float:repairshopyrot[MAX_REPAIRSHOPS];//new
new Float:repairshopzrot[MAX_REPAIRSHOPS];//new
new repairshopobjectid[MAX_REPAIRSHOPS];//don't remove
new repairshopcost[MAX_REPAIRSHOPS];//don't remove
new repairshopelockcost[MAX_REPAIRSHOPS];//don't remove
new repairshopslockcost[MAX_REPAIRSHOPS];//don't remove
new repairshop[MAX_REPAIRSHOPS];//don't save
new Text3D:repairshoplabel[MAX_REPAIRSHOPS];//don't save*/
//----------------------------------------------------------------
//new freq[MAX_PLAYERS];//Saved
/*/-----------------------Repairshop group-------------------------//#4
new repairshopgroup[MAX_PLAYERS];//Saved
new repairshopgrouplogcount;
new repairshopgroupcash;
new repairshoppaycheck;*/
//-----------------------Blocks----------------------
new spikestate[MAX_BLOCKS];
new Float:spikex[MAX_BLOCKS];
new Float:spikey[MAX_BLOCKS];
new Float:spikez[MAX_BLOCKS];
new Float:spikexrot[MAX_BLOCKS];
new Float:spikeyrot[MAX_BLOCKS];
new Float:spikezrot[MAX_BLOCKS];
new roadblockstate[MAX_BLOCKS];
new Float:roadblockx[MAX_BLOCKS];
new Float:roadblocky[MAX_BLOCKS];
new Float:roadblockz[MAX_BLOCKS];
new Float:roadblockxrot[MAX_BLOCKS];
new Float:roadblockyrot[MAX_BLOCKS];
new Float:roadblockzrot[MAX_BLOCKS];
new barrelstate[MAX_BLOCKS];
new Float:barrelx[MAX_BLOCKS];
new Float:barrely[MAX_BLOCKS];
new Float:barrelz[MAX_BLOCKS];
new Float:barrelxrot[MAX_BLOCKS];
new Float:barrelyrot[MAX_BLOCKS];
new Float:barrelzrot[MAX_BLOCKS];
new spike[MAX_BLOCKS];//Don't Save
new roadblockobject[MAX_BLOCKS];//Don't Save
new barrelobject[MAX_BLOCKS];//Don't Save
new placeingblocks[MAX_PLAYERS];

/*_______________________________________________________________________________________________________________________________________________________________
*/

forward RefineryOilProduction(refineryid);
forward LoadRestrictedCarData(name[],value[]);
forward RefineryPickup(playerid,refineryid);
forward IsTrailerAttached();
forward DeliveryCountDown(playerid);
forward Float:TakeGasOutOfRefinery(playerid,refineryid,Float:ammountofgas);
forward Float:TotalOil(refineryid);
forward CarStart(playerid,vehicleid);
forward FuelUseing(vehicleid);
forward GageChange(playerid,vehicleid);
forward Refuel(playerid,vehicleid,gasstationid,gaspumpid);
forward Float:TotalGasInGasStation(gasstationid);
forward Float:DivideFuel(refineryid, Float:fuelammount);
forward InputAdminSystem(playerid,level);
forward LoadCarData(name[],value[]);
forward BuyTimer(playerid);
forward OnVehicleDeathDelay(vehicleid);
forward LoadMainDataFromFile(name[],value[]);
forward VehicleProduction(factoryid);
forward PlayerAcceptCar();
forward RepairCar(playerid,vehicleid);
forward AddLock(playerid,carid,type);
forward VehicleTotaled();
forward RemovePlayerFromCar(playerid);
forward PutPlayerInVehicleDelay(playerid,vehicleid,seat);
forward PayCheck(playerid);
forward InviteCancel(playerid);
forward Float:GetVehicleSpeedAsFloat(vehicleid);
native IsValidVehicle(vehicleid);
public InputAdminSystem(playerid,level)//Input your custom admin system in here if blank comment it
{
	if(IsPlayerAdminLevel(playerid,level))//Example
	{
	    return true;
	}
	else
	{
	    return false;
	}
}
public InviteCancel(playerid)
{
	if((playerbeinginvited[playerid])==1)
	{
		new string[256];
		SendClientMessage(playerid,RED,"Invite expired");
		format(string,sizeof(string),"%s did not accept your request",GetPlayerNameReturn(playerid));
		SendClientMessage(playerbeinginvitedadmin[playerid],RED,string);
		format(playerbeinginvitedto[playerid],sizeof(playerbeinginvitedto),"");
		playerbeinginvitedadmin[playerid] = 0;
		playerbeinginvited[playerid] = 0;
	}
	return 1;
}
/*public PayCheck(playerid)//#4
{
    new str[256],name[MAX_PLAYER_NAME];
    GetPlayerName(playerid,name,sizeof(name));
	if((paycheckcount[playerid])==60)
	{
	    if((repairshopgroup[playerid])==1)
	    {
  			if((repairshopgroupcash) >= repairshoppaycheck)
			{
				format(str,sizeof(str),"You have recived your repairshop check for $%i",repairshoppaycheck);
				GivePlayerMoney(playerid,repairshoppaycheck);
				repairshopgroupcash = repairshopgroupcash - repairshoppaycheck;
			}
			else
			{
				format(str,sizeof(str),"%s can't be payed becuse there is only $%i in the depository",name,repairshopgroupcash);
				SaveRepairshopLog(str);
				for(new i;i < MAX_PLAYERS;i++)
				{
				    if(IsPlayerConnected(i))
				    {
						if((repairshopgroup[i])==1)
						{
						    SendClientMessage(i,REPAIRSHOPCOLOR,str);
						}
				    }
				}
				SendClientMessage(playerid,RED,"Look like the repairshop can't pay you try to work out a deal with them over /groupr if not mabey it is time to quit");
			}
	    }
	}
	else
	{
	    paycheckcount[playerid]++;
	}
	new INI:filedata = INI_Open(playerdatafilename);
	format(str,sizeof(str),"paycheckcount[%s]",name);
	INI_WriteInt(filedata,str,paycheckcount[playerid]);
	SaveRepairshopGroupData(filedata);
	INI_Close(filedata);
	return 1;
}*/
public PutPlayerInVehicleDelay(playerid,vehicleid,seat)
{
    PutPlayerInVehicle(playerid,vehicleid,seat);
	return 1;
}
public AddLock(playerid,carid,type)
{
	if((type)==1)
	{
		carlocktype[carid] = 1;
	    carlock[carid] = 0;
	    SendClientMessage(playerid,LIGHTBLUE,"You have bought a s lock");
	    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);//Repair sound
	    TogglePlayerControllable(playerid,true);
	    TextDrawHideForPlayer(playerid,textaddinglock);
	    SaveQuickCarData(carid);
	}
	else if((type)==2)
	{
 		carlocktype[carid] = 2;
        carlock[carid] = 0;
        SendClientMessage(playerid,LIGHTBLUE,"You have bought a e lock");
   	    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);//Repair sound
	    TogglePlayerControllable(playerid,true);
	    TextDrawHideForPlayer(playerid,textaddinglock);
        SaveQuickCarData(carid);
	}
	return 1;
}
public RepairCar(playerid,vehicleid)
{
    RepairVehicle(vehicleid);
    TextDrawHideForPlayer(playerid,textrepaircar);
    SendClientMessage(playerid,-1,"You have repaired your car");
    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);//Repair sound
    TogglePlayerControllable(playerid,true);
	return 1;
}
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	new carid = jbcarid[vehicleid];
	if((carstate[carid])==1)
	{
		carcolor1[jbcarid[vehicleid]] = color1;
		carcolor2[jbcarid[vehicleid]] = color2;
	}
	else if((carstate[carid])==2||(carstate[carid])==3)
	{
	    SendClientMessage(playerid,RED,"You can't respary dealership cars use /setvehiclecolor");
	}
	/*else if((carstate[carid])==4)//#4
	{
	    SendClientMessage(playerid,RED,"You can't respary repairshop cars use /setvehiclecolor");
	}*/
	return 1;
}
public OnEnterExitModShop(playerid, enterexit, interiorid)
{
    if(enterexit == 0) // If enterexit is 0, this means they are exiting
    {
		new vehicleid = GetPlayerVehicleID(playerid);
		new carid = jbcarid[vehicleid];
		if((carstate[carid])==1)
		{
			if((cartype[carid])==1||(cartype[carid])==3)
			if((cartype[carid])==1||(cartype[carid])==3)
			{
			    for(new count;count < 14;count++)
			    {
			    	carmodslot[count][carid] = GetVehicleComponentInSlot(car[carid], count);
				}
				SaveQuickCarData(carid);
			}
		}
    }
    return 1;
}
public VehicleProduction(factoryid)
{
	if((factoryproductionstate[factoryid])==1)
	{
		for(new count;count < FACTORYMAXORDERSATONCE;count++)
		{
			if((factorystockstate[count][factoryid])==1)
			{
			    if((factorydealerstock[count][factoryid])!=0)
			    {
	                factorystockcurrent[count][factoryid] = factorystockcurrent[count][factoryid] + vehiclebuildamountincrease;
	                if((factorystockcurrent[count][factoryid]) >= VehicleManufactureingPrice(factorydealerstockmodelid[count][factoryid]))
	                {
						factorydealerstock[count][factoryid] = factorydealerstock[count][factoryid] - 1;
						factorystock[count][factoryid] = factorystock[count][factoryid] + 1;
						factorycash[factoryid] = factorycash[factoryid] - VehicleManufactureingPrice(factorydealerstockmodelid[count][factoryid]);
						if((factorycash[factoryid]) < 0)
						{
						    factoryproductionstate[factoryid] = 0;
						}
						factorystockcurrent[count][factoryid] = 0;
						if((factorydealerstock[count][factoryid])==0)
						{
						    factorystockstate[count][factoryid] = 2;
	                        requeststockstate[factorydealerstockmodelid[count][factoryid]- 400][factorydealershipid[count][factoryid]- 400] = 4;
	                        SaveQuickFactoryData(factoryid);
						}
	                }
				}
				else
				{
				    factorystockstate[count][factoryid] = 2;
        			requeststockstate[factorydealerstockmodelid[count][factoryid]- 400][factorydealershipid[count][factoryid]- 400] = 4;
        			SaveQuickFactoryData(factoryid);
				}
			}
		}
	}
	else
	{
	    KillTimer(factorytimer[factoryid]);
	}
	return 1;
}
public OnVehicleDeathDelay(vehicleid)//Working
{
	printf("Vehicle death on vehicleid = %i carid = %i",vehicleid,jbcarid[vehicleid]);
	if((carstate[jbcarid[vehicleid]])==1)
	{
	    if((cartype[jbcarid[vehicleid]])==1)
	    {
	        new carid = jbcarid[vehicleid];
            RefreshCar(carid);
			for(new i;i < MAX_PLAYERS;i++)
			{
			    if(IsPlayerConnected(i))
			    {
					new string[256];
					if(strcmp(GetPlayerNameReturn(i),carownername[carid],false,MAX_PLAYER_NAME)==0)
					{
						format(string,sizeof(string),"Your %i:%s vehicledID:%i has respawned",vehicleid,GetVehicleName(vehicleid),jbcarid[vehicleid]);
						SendClientMessage(i,-1,string);
					    break;
					}
			    }
			}
	    }
	    /*else if((cartype[jbcarid[vehicleid]])==4)/#4
	    {
	    	new carid = jbcarid[vehicleid];
			RefreshCar(carid);
			for(new i;i < MAX_PLAYERS;i++)
			{
			    if(IsPlayerConnected(i))
			    {
			        if((repairshopgroup[i])==1)
			        {
			            new string[256];
			            format(string,sizeof(string),"repairshop vehicle ID:%i modelid-%i:%s for repairshopid:%i has been respawned",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),cardealershipid[carid]);
			            SendClientMessage(i,REPAIRSHOPCOLOR,string);
			        }
			    }
			}
	    }*/
	    else if((cartype[jbcarid[vehicleid]])==2||(cartype[jbcarid[vehicleid]])==3)
	    {
	        new string[256];
		    new carid = jbcarid[vehicleid];
		    Delete3DTextLabel(carlabel[carid]);
            RefreshCar(carid);
			format(string,sizeof(string),"%i:Dealership vehicle\nThis vehicle cost $%i\n%s",cardealershipid[carid],carcost[carid],CarStock(carid));
			carlabel[carid] = Create3DTextLabel(string,YELLOW,carx[carid],cary[carid],carz[carid],DISTANCELABEL,0,0);
		    Attach3DTextLabelToVehicle(carlabel[carid],car[carid],0,0,0);
		    SaveQuickCarData(carid);
		}
	}
	else
	{
	    DestroyVehicle(vehicleid);
		fuel[vehicleid] = 100.0;
	}
	return 1;
}
public OnVehicleDeath(vehicleid, killerid)
{
    new playerid = lastplayerinvehicle[vehicleid];
	if((deliverystate[playerid])==1)
	{
	    if((deliverydropoffstate[playerid])==1)
	    {
			deliveryid[playerid] = 0;
	  		GivePlayerMoney(playerid,-gasstationbuygascost[deliveryid[playerid]]);
	        DestroyVehicle(deliverytrailer[playerid]);
	     	DisablePlayerCheckpoint(playerid);
	        KillTimer(deliverycountdowntimer[playerid]);
	        gasstationneedgasstate[deliveryid[playerid]] = 1;
	        GasStationAddSlot(deliveryid[playerid]);
	        deliveryfuel[playerid] = 0;
	        deliverystate[playerid] = 0;
	        deliverydropoffstate[playerid] = 0;
	        gasstationbeingdeliveredto[deliveryid[playerid]] = 0;
		}
		else if((deliverydropoffstate[playerid])==2)
		{
     		factorystockstate[deliveryid[playerid]][deliveryfactoryid[playerid]] = 2;
     		new INI:mainfile = INI_Open(mainfilename);
			SaveFactoryData(mainfile,deliveryfactoryid[playerid]);
			UpdateDealershipLabels(deliverydealershipid[playerid]);
			SaveDealershipData(mainfile,deliverydealershipid[playerid]);
			INI_Close(mainfile);
			deliverydealershipid[playerid] = 0;
     		deliveryid[playerid] = 0;
     		deliverytruck[playerid] = 0;
            deliverycarsamount[playerid] = 0;
            deliverymodelid[playerid] = 0;
            deliverydropoffstate[playerid] = 0;
		}
	}
	SetTimerEx("OnVehicleDeathDelay",3500,false,"i",vehicleid);
	return 1;
}
public BuyTimer(playerid)
{
    playerbeingsoldto[playerid] = 0;
    itembeingsold[playerid] = 0;
	priceforitembeingsold[playerid] = 0;
	sellplayer[playerid] = 0;
	return 1;
}
public Refuel(playerid,vehicleid,gasstationid,gaspumpid)
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	if((playerrefueling[playerid])==1)
	{
		if((engine)==0)
		{
		    if((fuel[vehicleid])<100.0)
		    {
		        if((gaspumpgas[gaspumpid][gasstationid])>0)
		        {
					if(IsPlayerInVehicle(playerid,vehicleid))
					{
						gaspumpgas[gaspumpid][gasstationid] = gaspumpgas[gaspumpid][gasstationid] - 0.125;
				        fuel[vehicleid] = fuel[vehicleid] + 0.125;
						gaspumpcurrentfuelammount[gaspumpid][gasstationid] = gaspumpcurrentfuelammount[gaspumpid][gasstationid] + 0.125;
		    			if((gasstationgasroundcount[playerid])==8)
					    {
					        gaspumpcurrentsaleammount[gaspumpid][gasstationid] = gaspumpcurrentsaleammount[gaspumpid][gasstationid] + gasstationgascost[gasstationid];
					        gasstationgasroundcount[playerid] = 0;
					        new money = GetPlayerMoney(playerid);
							new salenext = gaspumpcurrentsaleammount[gaspumpid][gasstationid] + gasstationgascost[gasstationid] + gasstationgascost[gasstationid];
							if((cartype[jbcarid[vehicleid]])!=4)//#4
							{
								if((salenext) > money)
								{
								    SendClientMessage(playerid,RED,"You are out of cash");
								    playerrefueling[playerid] = 0;
								}
							}
							/*else if((cartype[jbcarid[vehicleid]])==4)//#4
							{
								if((salenext) > repairshopgroupcash)
								{
								    SendClientMessage(playerid,RED,"The group is out of cash /gdontate to dontate some cash");
								    playerrefueling[playerid] = 0;
								}
							}*/
					    }
					    UpdateGasStationLabels(gasstationid);
						gasstationgasroundcount[playerid] ++;
					}
					else
					{
					    playerrefueling[playerid] = 0;
					}
				}
				else
				{
				    playerrefueling[playerid] = 0;
				}
		    }
		    else
		    {
		        /*if((gasstationgasroundcount[playerid])>0)
		        {
		            gaspumpcurrentsaleammount[gaspumpid][gasstationid] = gaspumpcurrentsaleammount[gaspumpid][gasstationid] + gasstationgascost[gasstationid];
		        }*/
		        fuel[vehicleid] = 100.0;
        		/*gaspumpusegestate[gaspumpid][gasstationid] = 0;//check
				playerrefueling[playerid] = 0;
		        UpdateGasStationLabels(gasstationid);
		        new string[256];
		        format(string,sizeof(string),"You have refueled your vehicle for $%i",gaspumpcurrentsaleammount[gaspumpid][gasstationid]);
				SendClientMessage(playerid, LIGHTBLUE, string);
				if((cartype[jbcarid[vehicleid]])== 4)//#4
				{
					SendClientMessage(playerid,REPAIRSHOPCOLOR,"Repair shop group has paid for it");
					repairshopgroupcash = repairshopgroupcash - gaspumpcurrentsaleammount[gaspumpid][gasstationid];
				}
				else
				{
					GivePlayerMoney(playerid,-gaspumpcurrentsaleammount[gaspumpid][gasstationid]);
				//}
				gasstationcash[gasstationid] = gasstationcash[gasstationid] + gaspumpcurrentsaleammount[gaspumpid][gasstationid];
				KillTimer(refueltimer[playerid]);
				new INI:mainfile = INI_Open(mainfilename);
    			SaveGasStationData(mainfile,gasstationid);
		        SaveGasPumpData(mainfile,gaspumpid,gasstationid);
		        INI_Close(mainfile);*/
				playerrefueling[playerid] = 0;
		    }
		}
		else
		{
      		playerrefueling[playerid] = 0;
		}
	}
	else
	{
 		if((gasstationgasroundcount[playerid])>0)
   		{
     		gaspumpcurrentsaleammount[gaspumpid][gasstationid] = gaspumpcurrentsaleammount[gaspumpid][gasstationid] + gasstationgascost[gasstationid];
       	}
		gaspumpusegestate[gaspumpid][gasstationid] = 0;
		playerrefueling[playerid] = 0;
        UpdateGasStationLabels(gasstationid);
        new string[256];
        format(string,sizeof(string),"You have refueled your vehicle for $%i",gaspumpcurrentsaleammount[gaspumpid][gasstationid]);
		SendClientMessage(playerid, LIGHTBLUE, string);
		/*if((cartype[jbcarid[vehicleid]])== 4)//#4
		{
			SendClientMessage(playerid,REPAIRSHOPCOLOR,"Repair shop group has paid for it");
			repairshopgroupcash = repairshopgroupcash - gaspumpcurrentsaleammount[gaspumpid][gasstationid];
		}
		else
		{*/
			GivePlayerMoney(playerid,-gaspumpcurrentsaleammount[gaspumpid][gasstationid]);
		//}
		if((carstate[jbcarid[vehicleid]])==1)
		{
		    carfuel[jbcarid[vehicleid]] = fuel[vehicleid];
			SaveQuickCarData(jbcarid[vehicleid]);
		}
		gasstationcash[gasstationid] = gasstationcash[gasstationid] + gaspumpcurrentsaleammount[gaspumpid][gasstationid];
		KillTimer(refueltimer[playerid]);
        new INI:mainfile = INI_Open(mainfilename);
  		SaveGasStationData(mainfile,gasstationid);
        SaveGasPumpData(mainfile,gaspumpid,gasstationid);
        INI_Close(mainfile);
	}
	return 1;
}
public OnPlayerConnect(playerid)
{
    Connect(playerid);
	return 1;
}
public GageChange(playerid,vehicleid)
{
	if(!IsPlayerInAnyVehicle(playerid))
	{
        GageOff(playerid,playerlastvehicle[playerid]);
        return 1;
	}
	new string[256];
	for(new count; count < 4;count++)
	{
    	TextDrawHideForPlayer(playerid,gagepoint[count][gagelastspeed[vehicleid]]);
	}
	SetProgressBarValue(barfuel[vehicleid],fuel[vehicleid]);
	UpdateProgressBar(barfuel[vehicleid],playerid);
	new Float:health;
	GetVehicleHealth(vehicleid,health);
    SetProgressBarValue(barhealth[vehicleid],health);
    UpdateProgressBar(barhealth[vehicleid],playerid);
	new speed = GetVehicleSpeed(vehicleid);
    new editspeed = RoundSpeed(speed);
    gagelastspeed[vehicleid] = editspeed;
    format(string,sizeof(string),"Speed: %i KM/H",speed);
	TextDrawSetString(gagespeed[vehicleid],string);
	format(string,sizeof(string),"Fuel: %i",floatround(fuel[vehicleid]));
	TextDrawSetString(gagefuel[vehicleid],string);
	format(string,sizeof(string),"Distence: %i KM",floatround(totaldistence[vehicleid]));
	TextDrawSetString(gagedistance[vehicleid],string);
	for(new count; count < 4;count++)
	{
	    TextDrawShowForPlayer(playerid,gagepoint[count][editspeed]);
	}
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
	{
	    if((deliverystate[playerid])==1)
	    {
			TextDrawShowForPlayer(playerid, getbackin);
	    }
	}
    else if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)
    {
        if((deliverystate[playerid])==1)
        {
        	TextDrawHideForPlayer(playerid,getbackin);
        }
        new vehicleid = GetPlayerVehicleID(playerid);
        playerlastvehicle[playerid] = vehicleid;
        lastplayerinvehicle[vehicleid] = playerid;
        if((gageenabled[playerid])==1)
        {
			GageOn(playerid,playerlastvehicle[playerid]);
		}
  		if((carstate[jbcarid[vehicleid]])==1)
    	{
    	    if((cartype[jbcarid[vehicleid]])==1)
    	    {
				new string[256];
				if(strcmp(GetPlayerNameReturn(playerid),carownername[jbcarid[vehicleid]],false,MAX_PLAYER_NAME)==0)
				{
				    SendClientMessage(playerid,-1,"You have entered your vehicle");
				}
				else
				{
					if((carlock[jbcarid[vehicleid]])==1)
					{
	    				if((carlocktype[jbcarid[vehicleid]])==2)
					    {
	    					format(string,sizeof(string),"You have been ejected from %s's vehicle",carownername[jbcarid[vehicleid]]);
				    		SendClientMessage(playerid,RED,string);
				    		RemovePlayerFromCar(playerid);
							return 1;
					    }
					}
				    format(string,sizeof(string),"You have entered %s's vehicle",carownername[jbcarid[vehicleid]]);
				    SendClientMessage(playerid,-1,string);
				}
    	    }
    	    else if((cartype[jbcarid[vehicleid]])==2||(cartype[jbcarid[vehicleid]])==3)
    	    {
				ShowPlayerDialog(playerid,CARBUYMENU,DIALOG_STYLE_MSGBOX,"Buy Car","Do you want to buy this car?","Yes","No");
			}
			/*else if((cartype[jbcarid[vehicleid]])==4)//#4
			{
				if((repairshopgroup[playerid])==1)
				{
				    SendClientMessage(playerid,REPAIRSHOPCOLOR,"You have entered a repairshop vehicle");
				}
				else
				{
				    SendClientMessage(playerid,RED,"You have to be in the repairshop group inorder to drive this vehicle");
				    RemovePlayerFromCar(playerid);
				}
			}*/
		}
    }
	return 1;
}
public FuelUseing(vehicleid)//Working
{
	new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	if((engine)==1)
	{
	    fueluseingcount[vehicleid] ++;
	    new Float:speed = GetVehicleSpeedAsFloat(vehicleid);
	    totaldistence[vehicleid] = totaldistence[vehicleid] + ((speed / 60) / 60);
    	new Float:cfuel = speed / 2000.0;
		fuel[vehicleid] = fuel[vehicleid] - cfuel;
	    if((fueluseingcount[vehicleid])==60)
	    {
	        fueluseingcount[vehicleid] =0;
			fuel[vehicleid] = fuel[vehicleid] - 0.75;
		}
		if((carstate[jbcarid[vehicleid]])==1)
		{
		    carfuel[jbcarid[vehicleid]] = fuel[vehicleid];
		    cartotaldistence[jbcarid[vehicleid]] = totaldistence[vehicleid];
		}
		if((fuel[vehicleid])<=0)
		{
		    new Float:x,Float:y,Float:z,playerinveh = 0,playerid;
		    new string[256];
		    GetVehiclePos(vehicleid,x,y,z);
		    for(new i;i < MAX_PLAYERS;i++)
		    {
				if(IsPlayerConnected(i))
				{
                    if(IsPlayerInVehicle(i,vehicleid))
                    {
                        new playerstate = GetPlayerState(i);
                        if(playerstate == PLAYER_STATE_DRIVER)
                        {
	                        playerinveh = 1;
	                        playerid = i;
	                        break;
						}
                    }
				}
		    }
		    if((playerinveh)==1)
		    {
		        format(string,sizeof(string),"%s's vehicle has shut off. The Vehicle is out of gas",GetPlayerNameReturn(playerid));
                SendLocalMessage(playerid,PURPLE,string);
			}
			else
			{
			    format(string,sizeof(string),"One of the vehicle near you has shut off. The vehicle has run out of gas");
			    SendLocalMessageEx(x,y,z,PURPLE,string);
			}
		    SetVehicleParamsEx(vehicleid,false,lights,alarm,doors,bonnet,boot,objective);
		}
	}
	else
	{
	    KillTimer(fueluseingtimer[vehicleid]);
	}
	return 1;
}
public CarStart(playerid,vehicleid)//Working
{
    new engine,lights,alarm,doors,bonnet,boot,objective;
	GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
	if((fuel[vehicleid]) > 0)
	{
		if((totaledvehicle[vehicleid])==0)
		{
		    new string[256];
			SetVehicleParamsEx(vehicleid,true,lights,alarm,doors,bonnet,boot,objective);
			SendClientMessage(playerid, -1, "You have started your car");
			format(string,sizeof(string),"%s successfully turn on vehicle",GetPlayerNameReturn(playerid));
			SendLocalMessage(playerid,PURPLE,string);
			fueluseingtimer[vehicleid] = SetTimerEx("FuelUseing",1000,true,"i",vehicleid);
		}
		else
		{
	  		SetVehicleParamsEx(vehicleid,false,lights,alarm,doors,bonnet,boot,objective);
	        SendClientMessage(playerid, RED, "Your Car failed to start *totaled*");
			new string[256];
			format(string,sizeof(string),"%s fails to turn on the vehicle. The vehicle is totaled",GetPlayerNameReturn(playerid));
			SendLocalMessage(playerid,PURPLE,string);
		}
	}
	else
	{
        SetVehicleParamsEx(vehicleid,false,lights,alarm,doors,bonnet,boot,objective);
        SendClientMessage(playerid, RED, "Your Car failed to start *no fuel*");
		new string[256];
		format(string,sizeof(string),"%s fails to turn on the vehicle. There is no fuel in the vehicle",GetPlayerNameReturn(playerid));
		SendLocalMessage(playerid,PURPLE,string);
	}
	return 1;
}
public DeliveryCountDown(playerid)
{
	if((deliverycountdownstate[playerid])==1)
	{
	    new str[128];
	    deliverycountdowncount[playerid] = deliverycountdowncount[playerid] - 1;
	    format(str,sizeof(str),"you have %i seconds to get the trailer back hookedup",deliverycountdowncount[playerid]);
	    SendClientMessage(playerid,LIGHTBLUE,str);
	    if((deliverycountdowncount[playerid])==0)
	    {
	        GivePlayerMoney(playerid,-gasstationbuygascost[deliveryid[playerid]]);
	        format(str,sizeof(str),"Your trailer was destroyed you had to pay $%i for the loss",gasstationbuygascost[deliveryid[playerid]]);
	        SendClientMessage(playerid,RED,str);
	        TextDrawHideForPlayer(playerid,getbackin);
	        DestroyVehicle(deliverytrailer[playerid]);
         	DisablePlayerCheckpoint(playerid);
	        KillTimer(deliverycountdowntimer[playerid]);
	        gasstationneedgasstate[deliveryid[playerid]] = 1;
	        GasStationAddSlot(deliveryid[playerid]);
	        deliveryfuel[playerid] = 0;
	        deliverystate[playerid] = 0;
	        deliverydropoffstate[playerid] = 0;
            gasstationbeingdeliveredto[deliveryid[playerid]] = 0;
	    }
	}
	else if((deliverycountdownstate[playerid])==0)
	{
	    deliverycountdowncount[playerid] = 30;
	    KillTimer(deliverycountdowntimer[playerid]);
	}
	return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
	if((deliverydropoffstate[playerid])==1)
	{
	    if(IsPlayerInRangeOfPoint(playerid,8.0,gasstationx[deliveryid[playerid]],gasstationy[deliveryid[playerid]],gasstationz[deliveryid[playerid]]))
	    {
	        if(IsPlayerInVehicle(playerid,deliverytruck[playerid]))
	        {
		        new numofgaspumps,string[256];
				for(new count;count < MAX_GASPUMPS;count++)
				{
				    if((gaspumpstate[count][deliveryid[playerid]])==1)
				    {
				        numofgaspumps++;
				    }
				}
				new INI:mainfile = INI_Open(mainfilename);
				new Float:gasforeach = deliveryfuel[playerid] / numofgaspumps;
				for(new count;count < MAX_GASPUMPS;count++)
				{
				    if((gaspumpstate[count][deliveryid[playerid]])==1)
				    {
				        gaspumpgas[count][deliveryid[playerid]] = gaspumpgas[count][deliveryid[playerid]] + gasforeach;
						CheckIfGasIsAtMax(count,deliveryid[playerid]);
				        SaveGasPumpData(mainfile,count,deliveryid[playerid]);
				        break;
				    }
				}
				new truckerpayment = floatround(gasstationbuygascost[deliveryid[playerid]] * PRECENTAGEOFFPAYMENT);
	   			format(string,sizeof(string),"You have deliver %fL of fuel you made $%i",deliveryfuel[playerid],truckerpayment);
	            SendClientMessage(playerid, LIGHTBLUE, string);
				GivePlayerMoney(playerid,truckerpayment);
				DestroyVehicle(deliverytrailer[playerid]);
	 			UpdateGasStationLabels(deliveryid[playerid]);
	            DisablePlayerCheckpoint(playerid);
	            gasstationneedgasstate[deliveryid[playerid]] = 0;
	            ammountofgasneeded[deliveryid[playerid]] = 0;
				gasstationbeingdeliveredto[deliveryid[playerid]] = 0;
				SaveGasStationData(mainfile,deliveryid[playerid]);
				INI_Close(mainfile);
	            deliverystate[playerid] = 0;
	            deliverydropoffstate[playerid] = 0;
	            deliveryid[playerid] = 0;
	            deliveryrefineryid[playerid] = 0;
	            deliverycountdownstate[playerid] = 0;
	            deliverycountdowncount[playerid] = 30;
	            deliveryfuel[playerid] = 0;
	            TextDrawHideForPlayer(playerid,getbackin);
			 }
			 else
			 {
			    SendClientMessage(playerid,RED,"You have to be in your truck inorder to deliver gas");
			 }
	    }
	    else
	    {
	        SendClientMessage(playerid,RED,"Nice try, please drive to the right check point");
	        SetPlayerCheckpoint(playerid,gasstationx[deliveryid[playerid]],gasstationy[deliveryid[playerid]],gasstationz[deliveryid[playerid]],8.0);
	    }
	}
	else if((deliverydropoffstate[playerid])==2)
	{
	    if(IsPlayerInRangeOfPoint(playerid,8.0,dealershipx[deliverydealershipid[playerid]],dealershipy[deliverydealershipid[playerid]],dealershipz[deliverydealershipid[playerid]]))
	    {
	        if(IsPlayerInVehicle(playerid,deliverytruck[playerid]))
	        {
				new string[256];
		        DisablePlayerCheckpoint(playerid);
				for(new count = 1;count < MAX_VEHICLES;count++)
				{
					if((cardealershipid[count])==deliverydealershipid[playerid])
					{
					    if((carmodelid[count])==deliverymodelid[playerid])
					    {
					        carstock[count] = carstock[count] + factorystock[deliveryid[playerid]][deliveryfactoryid[playerid]];
					        SaveQuickCarData(count);
					        UpdateCarLabel(count);
							break;
					    }
					}
				}
				new truckerpayment = floatround(factoryordercost[deliveryid[playerid]][deliveryfactoryid[playerid]] * PRECENTAGEOFFPAYMENT,floatround_round);
				factorycash[deliveryfactoryid[playerid]] = factorycash[deliveryfactoryid[playerid]] - truckerpayment;
				GivePlayerMoney(playerid,truckerpayment);
				format(string,sizeof(string),"You have delivered %i %s(s). You have recived $%i",factorystock[deliveryid[playerid]][deliveryfactoryid[playerid]],GetVehicleName(factorydealerstockmodelid[deliveryid[playerid]][deliveryfactoryid[playerid]]),truckerpayment);
				factorydeliverying[deliveryid[playerid]][deliveryfactoryid[playerid]] = 0;
				requeststock[deliverymodelid[playerid] - 400][deliverydealershipid[playerid]] = 0;
				requeststockstate[deliverymodelid[playerid] - 400][deliverydealershipid[playerid]] = 1;
				factorydealershipid[deliveryid[playerid]][deliveryfactoryid[playerid]] = 0;
				factorydealerstock[deliveryid[playerid]][deliveryfactoryid[playerid]] = 0;
				factorydealerstockmodelid[deliveryid[playerid]][deliveryfactoryid[playerid]] = 0;
				factorystockstate[deliveryid[playerid]][deliveryfactoryid[playerid]] = 0;
				factorystock[deliveryid[playerid]][deliveryfactoryid[playerid]] = 0;
				factoryordercost[deliveryid[playerid]][deliveryfactoryid[playerid]] = 0;
				factorystockcurrent[deliveryid[playerid]][deliveryfactoryid[playerid]] = 0;
				new INI:mainfile = INI_Open(mainfilename);
				SaveFactoryData(mainfile,deliveryfactoryid[playerid]);
				UpdateDealershipLabels(deliverydealershipid[playerid]);
				SaveDealershipData(mainfile,deliverydealershipid[playerid]);
				INI_Close(mainfile);
				deliveryfactoryid[playerid] = 0;
				deliverystate[playerid] = 0;
				deliverydealershipid[playerid] = 0;
	     		deliveryid[playerid] = 0;
	     		deliverytruck[playerid] = 0;
	            deliverycarsamount[playerid] = 0;
	            deliverymodelid[playerid] = 0;
	            deliverydropoffstate[playerid] = 0;
	            TextDrawHideForPlayer(playerid,getbackin);
	            SendClientMessage(playerid, LIGHTBLUE,string);
			}
			else
			{
			    SendClientMessage(playerid,RED,"You have to be in you truck inorder to deliver cars");
			}
	    }
	    else
	    {
	        SendClientMessage(playerid,RED,"Nice try, please drive to the right check point");
	        SetPlayerCheckpoint(playerid,dealershipx[deliveryfactoryid[playerid]],dealershipy[deliveryfactoryid[playerid]],dealershipz[deliveryfactoryid[playerid]],8.0);
	    }
	}
	return 1;
}
public IsTrailerAttached()
{
	for(new playerid;playerid < MAX_PLAYERS;playerid++)
	{
	    if(IsPlayerConnected(playerid))
	    {
   			if((deliverystate[playerid])==1&&(deliverydropoffstate[playerid])==0)
			{
		        if(IsVehicleAttachedToTrailer(deliverytruck[playerid],deliverytrailer[playerid]))
		        {
		            deliverydropoffstate[playerid] = 1;
		            refineryblocked[deliveryrefineryid[playerid]] = 0;
					SendClientMessage(playerid, LIGHTBLUE, "Now drive the truck to the checkpoint");
					SetPlayerCheckpoint(playerid,gasstationx[deliveryid[playerid]],gasstationy[deliveryid[playerid]],gasstationz[deliveryid[playerid]],8.0);
		        }
			}
			if((deliverystate[playerid])==1&&(deliverydropoffstate[playerid])==1)
			{
			    if(IsVehicleAttachedToTrailer(deliverytruck[playerid],deliverytrailer[playerid]))
			    {
			        if((deliverycountdownstate[playerid])==1)
			        {
						deliverycountdownstate[playerid] = 0;
					}
			    }
			    else
			    {
			        if((deliverycountdownstate[playerid])==0)
			        {
				        deliverycountdownstate[playerid] = 1;
			     		SendClientMessage(playerid,RED, "Trailer detached, please reatach");
						deliverycountdowntimer[playerid] = SetTimerEx("DeliveryCountDown",1000,true,"i",playerid);
					}
			    }
			}
		}
	}
	return 1;
}
public OnPlayerDisconnect(playerid)
{
	/*if((repairshopgroup[playerid]) == 1)//#4
	{
	    repairshopgroup[playerid] = 0;
	}*/
 	if((deliverystate[playerid])==1)
	{
	    if((deliverydropoffstate[playerid])==1)
	    {
			deliveryid[playerid] = 0;
	  		GivePlayerMoney(playerid,-gasstationbuygascost[deliveryid[playerid]]);
	        DestroyVehicle(deliverytrailer[playerid]);
	     	DisablePlayerCheckpoint(playerid);
	        KillTimer(deliverycountdowntimer[playerid]);
	        gasstationneedgasstate[deliveryid[playerid]] = 1;
	        GasStationAddSlot(deliveryid[playerid]);
	        deliveryfuel[playerid] = 0;
	        deliverystate[playerid] = 0;
	        deliverydropoffstate[playerid] = 0;
	        gasstationbeingdeliveredto[deliveryid[playerid]] = 0;
		}
		else if((deliverydropoffstate[playerid])==2)
		{
     		factorystockstate[deliveryid[playerid]][deliveryfactoryid[playerid]] = 2;
     		new INI:mainfile = INI_Open(mainfilename);
			SaveFactoryData(mainfile,deliveryfactoryid[playerid]);
			UpdateDealershipLabels(deliverydealershipid[playerid]);
			SaveDealershipData(mainfile,deliverydealershipid[playerid]);
			INI_Close(mainfile);
			deliverydealershipid[playerid] = 0;
     		deliveryid[playerid] = 0;
     		deliverytruck[playerid] = 0;
            deliverycarsamount[playerid] = 0;
            deliverymodelid[playerid] = 0;
            deliverydropoffstate[playerid] = 0;
		}
	}
	return 1;
}
public RefineryPickup(playerid,refineryid)
{
	if((edittrailerposstate[playerid])==1)
	{
	    edittrailerposstate[playerid] = 0;
	    SendClientMessage(playerid, RED, "AUTO no");
	    DestroyVehicle(edittrailertrailer[playerid]);
	    refinerytrailerx[refineryid] = 0;
		refinerytrailery[refineryid] = 0;
		refinerytrailerz[refineryid] = 0;
		refinerytrailerrot[refineryid] = 0;
		refinerytrailerstate[refineryid] = 0;
		SaveQuickRefineryData(refineryid);
	}
	else if((edittrailerposstate[playerid])==2)
	{
	    edittrailerposstate[playerid] = 0;
	    DestroyVehicle(edittrailertrailer[playerid]);
		refinerytrailerstate[refineryid] = 1;
		SaveQuickRefineryData(refineryid);
	}
	else if((edittrailerposstate[playerid])==3)
	{
	    edittrailerposstate[playerid] = 0;
	    DestroyVehicle(edittrailertrailer[playerid]);
	    refinerytrailerx[refineryid] = 0;
		refinerytrailery[refineryid] = 0;
		refinerytrailerz[refineryid] = 0;
		refinerytrailerrot[refineryid] = 0;
		refinerytrailerstate[refineryid] = 0;
		SaveQuickRefineryData(refineryid);
	}
	return 1;
}
public RefineryOilProduction(refineryid)
{
	new once;
	if((refineryproductionstate[refineryid])==1)
	{
	    new numofoilpumps,numofoilstorage,Float:totaloilpumpedpersec,Float:totalnumofstorageoil;
	    for(new oilpumpid;oilpumpid < MAX_OILPUMPS;oilpumpid++)
	    {
	        if((oilpumpstate[oilpumpid][refineryid])==1)
	        {
	            numofoilpumps++;
	        }
	    }
	    for(new oilstorageid;oilstorageid < MAX_OILPUMPS;oilstorageid++)
	    {
	        if((oilstoragestate[oilstorageid][refineryid])==1)
	        {
	            if((oilstoragefull[oilstorageid][refineryid])==0)
	            {
	            	numofoilstorage++;
				}
	        }
	    }
	    if((numofoilstorage)==0)
	    {
	        refineryproductionstate[refineryid]=2;
	        return 1;
	    }
        //refinerydebt[refineryid] = refinerydebt[refineryid] + (numofoilpumps * powercost);//#4
	    totaloilpumpedpersec = oilpumpedpersec * numofoilpumps;
		totalnumofstorageoil = totaloilpumpedpersec / numofoilstorage;
		new string[256];
		for(new count;count < MAX_OILPUMPS;count++)
		{
		    if((oilstoragestate[count][refineryid])==1)
		    {
		        new Float:check = oilstoragefuel[count][refineryid] + totalnumofstorageoil;
		        if((check)<=MAX_OILSTORAGE)
		        {
		            oilstoragefuel[count][refineryid] = oilstoragefuel[count][refineryid] + totalnumofstorageoil;
		            format(string,sizeof(string),"ID:%i-%i\n This fuelstorage is owned by %s\nThere is currently %fL out of %f fuel in hear\ncurrentstate:%s",count,refineryid,refineryownername[refineryid],oilstoragefuel[count][refineryid],MAX_OILSTORAGE,RefineryProductionState(refineryid));
					Update3DTextLabelText(oilstoragelabel[count][refineryid],YELLOW,string);
		        }
		        else
		        {
					check = check - MAX_OILSTORAGE;
					oilstoragefuel[count][refineryid] = oilstoragefuel[count][refineryid] + (totalnumofstorageoil - check);
					new done;
 					for(new count2;count2 < MAX_OILPUMPS;count2++)
					{
					    if((oilstoragestate[count2][refineryid])==1)
					    {
					        new Float:check2 = oilstoragefuel[count][refineryid] + check;
					        if((check2)<=MAX_OILSTORAGE)
					        {
					            oilstoragefuel[count2][refineryid] = oilstoragefuel[count2][refineryid] + check;
    		           			format(string,sizeof(string),"ID:%i-%i\n This fuelstorage is owned by %s\nThere is currently %fL out of %f fuel in hear\ncurrentstate:%s",count2,refineryid,refineryownername[refineryid],oilstoragefuel[count2][refineryid],MAX_OILSTORAGE,RefineryProductionState(refineryid));
								Update3DTextLabelText(oilstoragelabel[count2][refineryid],YELLOW,string);
					            done = 1;
					            break;
					        }
					    }
					}
					if((done)==1)
					{
					    continue;
					}
					else
					{
                        refineryproductionstate[refineryid] = 2;
					}
		        }
		    }
		}
		format(string,sizeof(string),"Refinery:%i\nRefinery state:%s\n%s\nthere is a total of %f fuel",refineryid,RefineryProductionState(refineryid),RefineryOwner(refineryid),TotalOil(refineryid));
		Update3DTextLabelText(refinerylabel[refineryid],YELLOW,string);
	}
	if((once)==1)
	{
		return 1;
	}
	else if((refineryproductionstate[refineryid])==2)
	{
        for(new count;count < MAX_OILPUMPS;count++)
		{
		    if((gaspumpstate[count][refineryid])==1)
		    {
		        if((oilstoragefuel[count][refineryid]) < MAX_OILSTORAGE)
		        {
		            refineryproductionstate[refineryid] = 1;
		            UpdateRefineryLabels(refineryid);
		        }
		    }
		}
	}
	else if((refineryproductionstate[refineryid])==0)
	{
	    KillTimer(refineryproductiontimer[refineryid]);
	}
	return 1;
}
public LoadRestrictedCarData(name[],value[])
{
	new str[128];
	for(new count;count < 612;count++)
	{
	    format(str,sizeof(str),"%i",count);
		INI_Int(str,restrictcar[count]);
	}
	INI_Int("carspawn",carspawn);
	for(new count;count < 212;count++)
	{
	    format(str,sizeof(str),"vehiclemanufactureingcost[%i]",count);
	    INI_Int(str,vehiclemanufactureingcost[count]);
	}
	return 1;
}
public VehicleTotaled()
{
	for(new count;count < MAX_VEHICLES;count++)
	{
	    if(IsValidVehicle(count))
	    {
	        new Float:health,playerid,playerinvehicle,string[256];
            GetVehicleHealth(count,health);
            if((health) <= 350.0)
            {
                SetVehicleHealth(count,350.0);
                totaledvehicle[count] = 1;
                new engine,lights,alarm,doors,bonnet,boot,objective;
				GetVehicleParamsEx(count,engine,lights,alarm,doors,bonnet,boot,objective);
				if((engine) == -1)
				{
				    engine = 0;
				}
                for(new i;i < MAX_PLAYERS;i++)
                {
                    if(IsPlayerConnected(i))
                    {
	                	if(IsPlayerInVehicle(i,count))
	                	{
	                	    new playerstate = GetPlayerState(i);
	                	    if(playerstate == PLAYER_STATE_DRIVER)
	                	    {
	                	        playerid = i;
	                	        playerinvehicle = 1;
	                	        if((gageenabled[i])==1)
	                	        {
									TextDrawShowForPlayer(i,texttotaledcar);
	                	        }
	                	        break;
	                	    }
	                	}
					}
				}
				if((engine)==1)
				{
				    engine = 0;
                    if((playerinvehicle)==1)
					{
						format(string,sizeof(string),"%s's vehicle has shut off, This vehicle has been totaled",GetPlayerNameReturn(playerid));
						SendLocalMessage(playerid,PURPLE,string);
					}
					else
					{
                        format(string,sizeof(string),"a %i:%s near you has shut off, This vehicle has been totaled",GetVehicleModel(count),GetVehicleName(GetVehicleModel(count)));
                        new Float:x,Float:y,Float:z;
                        GetVehiclePos(count,x,y,z);
                        SendLocalMessageEx(x,y,z,PURPLE,string);
					}
				}
				SetVehicleParamsEx(count,engine,lights,alarm,doors,bonnet,boot,objective);
            }
            else
            {
                if((totaledvehicle[count])==1)
                {
                    for(new i;i < MAX_PLAYERS;i++)
	                {
	                    if(IsPlayerConnected(i))
	                    {
		                	if(IsPlayerInVehicle(i,count))
		                	{
		                	    new playerstate = GetPlayerState(i);
		                	    if(playerstate == PLAYER_STATE_DRIVER)
		                	    {
		                	        if((gageenabled[i])==1)
		                	        {
										TextDrawHideForPlayer(i,texttotaledcar);
		                	        }
		                	        break;
		                	    }
		                	}
						}
					}
					totaledvehicle[count] = 0;
                }
            }
	    }
	}
	return 1;
}
public OnFilterScriptInit()
{
	print("-------------------------JB-Car's-2------------------");
	print("---------------------------V2.0.2--------------------");
	print("------------------------by-Horsemeat-----------------");
	SendClientMessageToAll(LIGHTBLUE, "-------------------------JB-Car's-2------------------");
	SendClientMessageToAll(LIGHTBLUE, "---------------------------V2.0.2--------------------");
	SendClientMessageToAll(LIGHTBLUE, "------------------------by-Horsemeat-----------------");
	//repairshopgrouplogcount = QINI_Int(grouplogfilename,"repairshopgrouplogcount");
	for(new count;count < MAX_VEHICLES;count++)
	{
	    fuel[count] = 100.0;
	}
	vehiclemanufactureingcoststate = QINI_Int(restrictedcarsfilename,"vehiclemanufactureingcoststate");
	if((vehiclemanufactureingcoststate)==0)
	{
	    vehiclemanufactureingcoststate = 1;
		SaveManufactureingcostData();
	}
    LoadMainfileData();
    INI_ParseFile(restrictedcarsfilename,"LoadRestrictedCarData",false,false);
    CreateGages();
    ManualVehicleEngineAndLights();
    LoadMainCarData();
    
    //Create Textdraws
	
    textrepaircar = TextDrawCreate(420.000000, 279.000000, "Repairing Car...");
	TextDrawBackgroundColor(textrepaircar, 255);
	TextDrawFont(textrepaircar, 3);
	TextDrawLetterSize(textrepaircar, 0.839999, 2.299999);
	TextDrawColor(textrepaircar, -1);
	TextDrawSetOutline(textrepaircar, 0);
	TextDrawSetProportional(textrepaircar, 1);
	TextDrawSetShadow(textrepaircar, 1);
	
	textaddinglock = TextDrawCreate(445.000000, 257.000000, "Adding Lock...");
	TextDrawBackgroundColor(textaddinglock, 255);
	TextDrawFont(textaddinglock, 3);
	TextDrawLetterSize(textaddinglock, 0.839999, 2.299998);
	TextDrawColor(textaddinglock, -1);
	TextDrawSetOutline(textaddinglock, 0);
	TextDrawSetProportional(textaddinglock, 1);
	TextDrawSetShadow(textaddinglock, 1);
	
	texttotaledcar = TextDrawCreate(502.000000, 381.000000, "Totaled");
	TextDrawBackgroundColor(texttotaledcar, 255);
	TextDrawFont(texttotaledcar, 0);
	TextDrawLetterSize(texttotaledcar, 0.839999, 2.299998);
	TextDrawColor(texttotaledcar, -16776961);
	TextDrawSetOutline(texttotaledcar, 1);
	TextDrawSetProportional(texttotaledcar, 1);
    
	getbackin = TextDrawCreate(228.000000, 384.000000, "Get Back in your truck");
	TextDrawBackgroundColor(getbackin, 255);
	TextDrawFont(getbackin, 1);
	TextDrawLetterSize(getbackin, 0.500000, 1.500000);
	TextDrawColor(getbackin, -1);
	TextDrawSetOutline(getbackin, 0);
	TextDrawSetProportional(getbackin, 1);
	TextDrawSetShadow(getbackin, 1);
	
	scriptlabel = TextDrawCreate(519.000000, 5.000000, "JBcars2.0.2");
	TextDrawBackgroundColor(scriptlabel, 255);
	TextDrawFont(scriptlabel, 1);
	TextDrawLetterSize(scriptlabel, 0.450000, 1.000000);
	TextDrawColor(scriptlabel, -1);
	TextDrawSetOutline(scriptlabel, 0);
	TextDrawSetProportional(scriptlabel, 1);
	TextDrawSetShadow(scriptlabel, 1);
	//End of text draws
	for(new i;i < MAX_PLAYERS;i++)
	{
	    deliverycountdowncount[i] = 30;
		if(IsPlayerConnected(i))
		{
			Connect(i);
			if(IsPlayerInAnyVehicle(i))
			{
				new playerstate = GetPlayerState(i);
				if(playerstate == PLAYER_STATE_DRIVER)
				{

				    new vehicleid = GetPlayerVehicleID(i);
				    playerlastvehicle[i] = vehicleid;
				    lastplayerinvehicle[vehicleid] = i;
				    if((gageenabled[i])==1)
					{
				        GageOn(i,vehicleid);
				    }
				}
			}
		}
	}
	for(new count;count < MAX_VEHICLES;count++)
	{
		if(IsValidVehicle(count))
		{
		    new engine,lights,alarm,doors,bonnet,boot,objective;
			GetVehicleParamsEx(count,engine,lights,alarm,doors,bonnet,boot,objective);
			if((engine)==-1)
			{
				engine = 0;
			}
			if((engine)==1)
			{
			    fueluseingtimer[count] = SetTimerEx("FuelUseing",1000,true,"i",count);
			}
		}
	}
    SetTimer("IsTrailerAttached",1000,true);
    SetTimer("VehicleTotaled",1000,true);
    if((vehiclebuildamountincrease)==0)
    {
        vehiclebuildamountincrease = 150;
        new INI:filedata = INI_Open(mainfilename);
		INI_WriteInt(filedata,"vehiclebuildamountincrease",vehiclebuildamountincrease);
		INI_Close(filedata);
    }
    if((costofgaspump)==0)
    {
        costofgaspump = 15000;
		new INI:filedata = INI_Open(mainfilename);
		INI_WriteInt(filedata,"costofgaspump",costofgaspump);
		INI_Close(filedata);
    }
    if((oilpumpedpersec)==0)
    {
        oilpumpedpersec = 0.0134561;
        new INI:filedata = INI_Open(mainfilename);
        INI_WriteFloat(filedata,"oilpumpedpersec",oilpumpedpersec,6);
        INI_Close(filedata);
    }
	if((costofoilpumps)==0)
	{
	    costofoilpumps = 20000;
	    new INI:filedata = INI_Open(mainfilename);
		INI_WriteInt(filedata,"costofoilpumps",costofoilpumps);
		INI_Close(filedata);
	}
	if((costofoilstorage)==0)
	{
	    costofoilstorage = 20000;
		new INI:filedata = INI_Open(mainfilename);
		INI_WriteInt(filedata,"costofoilstorage",costofoilstorage);
		INI_Close(filedata);
	}
	/*if((powercost)==0)//#4
	{
	    powercost = 0.07;
	    new INI:filedata = INI_Open(mainfilename);
	    INI_WriteFloat(filedata, "powercost", powercost,6);
	    INI_Close(filedata);
	}*/
	/*if((repairshoppaycheck)==0)//#4
	{
	    repairshoppaycheck = 10000;
	    new INI:filedata = INI_Open(mainfilename);
	    INI_WriteInt(filedata,"repairshoppaycheck",repairshoppaycheck);
	    INI_Close(filedata);
	}*/
	print("--------------------------Loaded---------------------");
	SendClientMessageToAll(LIGHTBLUE, "--------------------------Loaded---------------------");
	return 1;
}
public OnFilterScriptExit()
{
    print("-------------------------JB-Car's-2------------------");
	print("---------------------------V2.0.2--------------------");
	print("------------------------by-Horsemeat-----------------");
	SendClientMessageToAll(LIGHTBLUE, "-------------------------JB-Car's-2------------------");
	SendClientMessageToAll(LIGHTBLUE, "---------------------------V2.0.2--------------------");
	SendClientMessageToAll(LIGHTBLUE, "------------------------by-Horsemeat-----------------");
	for(new i;i < MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        if((deliverystate[i])==1)
	        {
				TextDrawHideForPlayer(i,getbackin);
	        }
			if(IsPlayerInAnyVehicle(i))
			{
			    GageOff(i,playerlastvehicle[i]);
			}
	    }
	}
	TextDrawHideForAll(scriptlabel);
	TextDrawDestroy(scriptlabel);
	SaveAllData();
	print("---------------------------Saved--------------------");
	SendClientMessageToAll(LIGHTBLUE,"---------------------------Saved--------------------");
	RemoveAllObjects();
	print("--------------------------Unloaded-------------------");
	SendClientMessageToAll(LIGHTBLUE, "--------------------------UnLoaded-------------------");
	return 1;
}
public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{ 
	if((buildtype[playerid])==8)//barrels
	{
	    new count = editobjblock[playerid];
	    if(response == EDIT_RESPONSE_UPDATE)
	    {
	        MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
	    }
	    else if(response == EDIT_RESPONSE_FINAL)
	    {
	        MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
	        barrelx[count] = x;
	        barrely[count] = y;
	        barrelz[count] = z;
	        barrelxrot[count] = rx;
	        barrelyrot[count] = ry;
	        barrelzrot[count] = rz;
  			oldx[playerid] = 0;
			oldy[playerid] = 0;
			oldz[playerid] = 0;
			oldxrot[playerid] = 0;
			oldyrot[playerid] = 0;
			oldzrot[playerid] = 0;
	        SaveQuickBarrelData(count);
			SendClientMessage(playerid,LIGHTBLUE,"You have moved a barrel");
	        return 1;
	    }
	    else if(response == EDIT_RESPONSE_CANCEL)
	    {
	        MoveDynamicObject(objectid,oldx[playerid],oldy[playerid],oldz[playerid],10.0,oldxrot[playerid],oldyrot[playerid],oldzrot[playerid]);
			barrelx[count] = oldx[playerid];
			barrely[count] = oldy[playerid];
			barrelz[count] = oldz[playerid];
			barrelxrot[count] = oldxrot[playerid];
			barrelyrot[count] = oldyrot[playerid];
			barrelzrot[count] = oldzrot[playerid];
			oldx[playerid] = 0;
			oldy[playerid] = 0;
			oldz[playerid] = 0;
			oldxrot[playerid] = 0;
			oldyrot[playerid] = 0;
			oldzrot[playerid] = 0;
			SaveQuickBarrelData(count);
			SendClientMessage(playerid,RED,"You have canceled moveing a barrel");
	        return 1;
	    }
	}
	else if((buildtype[playerid])==7)//roadblocks
	{
	    new count = editobjblock[playerid];
	    if(response == EDIT_RESPONSE_UPDATE)
	    {
	        MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
	    }
	    else if(response == EDIT_RESPONSE_FINAL)
	    {
	        MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
			roadblockx[count] = x;
			roadblocky[count] = y;
			roadblockz[count] = z;
			roadblockxrot[count] = rx;
			roadblockyrot[count] = ry;
			roadblockzrot[count] = rz;
			oldx[playerid] = 0;
			oldy[playerid] = 0;
			oldz[playerid] = 0;
			oldxrot[playerid] = 0;
			oldyrot[playerid] = 0;
			oldzrot[playerid] = 0;
	        SaveQuickRoadblockData(count);
			SendClientMessage(playerid,LIGHTBLUE,"You have moved a roadblock");
	        return 1;
	    }
	    else if(response == EDIT_RESPONSE_CANCEL)
	    {
	        MoveDynamicObject(objectid,oldx[playerid],oldy[playerid],oldz[playerid],10.0,oldxrot[playerid],oldyrot[playerid],oldzrot[playerid]);
	        roadblockx[count] = oldx[playerid];
	        roadblocky[count] = oldy[playerid];
	        roadblockz[count] = oldz[playerid];
	        roadblockxrot[count] = oldxrot[playerid];
	        roadblockyrot[count] = oldyrot[playerid];
	        roadblockzrot[count] = oldzrot[playerid];
  			oldx[playerid] = 0;
			oldy[playerid] = 0;
			oldz[playerid] = 0;
			oldxrot[playerid] = 0;
			oldyrot[playerid] = 0;
			oldzrot[playerid] = 0;
	        SaveQuickRoadblockData(count);
			SendClientMessage(playerid,RED,"You have canceled moveing a roadblock");
	        return 1;
	    }
	}
	else if((buildtype[playerid])==6)//spikes
	{
		new count = editobjblock[playerid];
 		if(response == EDIT_RESPONSE_UPDATE)
	    {
	        MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
	    }
	    else if(response == EDIT_RESPONSE_FINAL)
	    {
	        MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
  			spikex[count] = x;
			spikey[count] = y;
			spikez[count] = z;
			spikexrot[count] = rx;
			spikeyrot[count] = ry;
			spikezrot[count] = rz;
  			oldx[playerid] = 0;
			oldy[playerid] = 0;
			oldz[playerid] = 0;
			oldxrot[playerid] = 0;
			oldyrot[playerid] = 0;
			oldzrot[playerid] = 0;
			SaveQuickSpikeData(count);
			SendClientMessage(playerid,LIGHTBLUE,"You have moved a spike");
	        return 1;
	    }
	    else if(response == EDIT_RESPONSE_CANCEL)
	    {
	        MoveDynamicObject(objectid,oldx[playerid],oldy[playerid],oldz[playerid],10.0,oldxrot[playerid],oldyrot[playerid],oldzrot[playerid]);
	        spikex[count] = oldx[playerid];
	        spikey[count] = oldy[playerid];
	        spikez[count] = oldz[playerid];
			spikexrot[count] = oldxrot[playerid];
			spikeyrot[count] = oldyrot[playerid];
			spikezrot[count] = oldzrot[playerid];
  			oldx[playerid] = 0;
			oldy[playerid] = 0;
			oldz[playerid] = 0;
			oldxrot[playerid] = 0;
			oldyrot[playerid] = 0;
			oldzrot[playerid] = 0;
			SaveQuickSpikeData(count);
			SendClientMessage(playerid,RED,"You have canceled moving a spike");
	        return 1;
	    }
	}
	else if((buildtype[playerid])==5)//repairgarage
	{
	    new str[256];
	    if(response == EDIT_RESPONSE_UPDATE)
	    {
	        MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
	        Delete3DTextLabel(repairshoplabel[editobjrepairshop[playerid]]);
			format(str,sizeof(str),"%i:repairgarage\n/repaircar to repair your car /buylock to buy a lock\nit cost $%i to repair your car & E-$%iS-$%i to buy a lock",editobjrepairshop[playerid],repairshopcost[editobjrepairshop[playerid]],repairshopelockcost[editobjrepairshop[playerid]],repairshopslockcost[editobjrepairshop[playerid]]);
			repairshoplabel[editobjrepairshop[playerid]] = Create3DTextLabel(str,YELLOW,x,y,z - 1.5,DISTANCELABEL,0,0);
	    }
	    else if(response == EDIT_RESPONSE_FINAL)
	    {
	        Delete3DTextLabel(repairshoplabel[editobjrepairshop[playerid]]);
  			repairshopx[editobjrepairshop[playerid]] = x;
			repairshopy[editobjrepairshop[playerid]] = y;
			repairshopz[editobjrepairshop[playerid]] = z - 1.5;
			repairshopxrot[editobjrepairshop[playerid]] = rx;
			repairshopyrot[editobjrepairshop[playerid]] = ry;
			repairshopzrot[editobjrepairshop[playerid]] = rz;
			MoveDynamicObject(objectid,repairshopx[editobjrepairshop[playerid]],repairshopy[editobjrepairshop[playerid]],repairshopz[editobjrepairshop[playerid]] + 1.5,10.0,repairshopxrot[editobjrepairshop[playerid]],repairshopyrot[editobjrepairshop[playerid]],repairshopzrot[editobjrepairshop[playerid]]);
			format(str,sizeof(str),"%i:repairgarage\n/repaircar to repair your car /buylock to buy a lock\nit cost $%i to repair your car & E-$%iS-$%i to buy a lock",editobjrepairshop[playerid],repairshopcost[editobjrepairshop[playerid]],repairshopelockcost[editobjrepairshop[playerid]],repairshopslockcost[editobjrepairshop[playerid]]);
			repairshoplabel[editobjrepairshop[playerid]] = Create3DTextLabel(str,YELLOW,repairshopx[editobjrepairshop[playerid]],repairshopy[editobjrepairshop[playerid]],repairshopz[editobjrepairshop[playerid]],DISTANCELABEL,0,0);
			oldx[playerid] = 0;
			oldy[playerid] = 0;
			oldz[playerid] = 0;
			oldxrot[playerid] = 0;
			oldyrot[playerid] = 0;
			oldzrot[playerid] = 0;
			SaveQuickRepairShopData(editobjrepairshop[playerid]);
			buildtype[playerid] = 0;
			repairshoppickup[editobjrepairshop[playerid]] = CreatePickup(1239,23,repairshopx[editobjrepairshop[playerid]],repairshopy[editobjrepairshop[playerid]],repairshopz[editobjrepairshop[playerid]],-1);
			return 1;
	    }
	    else if(response == EDIT_RESPONSE_CANCEL)
	    {
     		MoveDynamicObject(objectid,oldx[playerid],oldy[playerid],oldz[playerid],10.0,oldxrot[playerid],oldyrot[playerid],oldzrot[playerid]);
	        Delete3DTextLabel(repairshoplabel[editobjrepairshop[playerid]]);
			format(str,sizeof(str),"%i:repairgarage\n/repaircar to repair your car /buylock to buy a lock\nit cost $%i to repair your car & E-$%iS-$%i to buy a lock",editobjrepairshop[playerid],repairshopcost[editobjrepairshop[playerid]],repairshopelockcost[editobjrepairshop[playerid]],repairshopslockcost[editobjrepairshop[playerid]]);
			repairshoplabel[editobjrepairshop[playerid]] = Create3DTextLabel(str,YELLOW,repairshopx[editobjrepairshop[playerid]],repairshopy[editobjrepairshop[playerid]],repairshopz[editobjrepairshop[playerid]],DISTANCELABEL,0,0);
			repairshopx[editobjrepairshop[playerid]] = oldx[playerid];
			repairshopy[editobjrepairshop[playerid]] = oldy[playerid];
			repairshopz[editobjrepairshop[playerid]] = oldz[playerid];
			repairshopxrot[editobjrepairshop[playerid]] = oldxrot[playerid];
			repairshopyrot[editobjrepairshop[playerid]] = oldyrot[playerid];
			repairshopzrot[editobjrepairshop[playerid]] = oldzrot[playerid];
			oldx[playerid] = 0;
			oldy[playerid] = 0;
			oldz[playerid] = 0;
			oldxrot[playerid] = 0;
			oldyrot[playerid] = 0;
			oldzrot[playerid] = 0;
			SaveQuickRepairShopData(editobjrepairshop[playerid]);
			buildtype[playerid] = 0;
			repairshoppickup[editobjrepairshop[playerid]] = CreatePickup(1239,23,repairshopx[editobjrepairshop[playerid]],repairshopy[editobjrepairshop[playerid]],repairshopz[editobjrepairshop[playerid]],-1);
			return 1;
	    }
	}
	else if((buildtype[playerid])==4)//gaspump
	{
		//editobjgasstation[playerid]
	 	//editobjextra[playerid]
	    new string[256];
	    if(response == EDIT_RESPONSE_UPDATE)
	    {
			MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
			Delete3DTextLabel(gaspumplabel[editobjextra[playerid]][editobjgasstation[playerid]]);
			format(string,sizeof(string),"gaspump:%i-%i\n%s\ncurrentfuel:%f our of %f\n%s",editobjextra[playerid],editobjgasstation[playerid],CurrentReful(editobjextra[playerid],editobjgasstation[playerid]),gaspumpgas[editobjextra[playerid]][editobjgasstation[playerid]],MAX_GASPERPUMP,GasPumpUsage(editobjextra[playerid],editobjgasstation[playerid]));
			gaspumplabel[editobjextra[playerid]][editobjgasstation[playerid]] = Create3DTextLabel(string,YELLOW,x,y,z,DISTANCELABEL,0,0);
	    }
	    else if(response == EDIT_RESPONSE_FINAL)
	    {
	    	MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
			Delete3DTextLabel(gaspumplabel[editobjextra[playerid]][editobjgasstation[playerid]]);
			format(string,sizeof(string),"gaspump:%i-%i\n%s\ncurrentfuel:%f our of %f\n%s",editobjextra[playerid],editobjgasstation[playerid],CurrentReful(editobjextra[playerid],editobjgasstation[playerid]),gaspumpgas[editobjextra[playerid]][editobjgasstation[playerid]],MAX_GASPERPUMP,GasPumpUsage(editobjextra[playerid],editobjgasstation[playerid]));
			gaspumplabel[editobjextra[playerid]][editobjgasstation[playerid]] = Create3DTextLabel(string,YELLOW,x,y,z,DISTANCELABEL,0,0);
			gaspumpx[editobjextra[playerid]][editobjgasstation[playerid]] = x;
			gaspumpy[editobjextra[playerid]][editobjgasstation[playerid]] = y;
			gaspumpz[editobjextra[playerid]][editobjgasstation[playerid]] = z;
			gaspumpxrot[editobjextra[playerid]][editobjgasstation[playerid]] = rx;
			gaspumpyrot[editobjextra[playerid]][editobjgasstation[playerid]] = ry;
			gaspumpzrot[editobjextra[playerid]][editobjgasstation[playerid]] = rz;
			oldx[playerid] = 0;
			oldy[playerid] = 0;
			oldz[playerid] = 0;
			oldxrot[playerid] = 0;
			oldyrot[playerid] = 0;
			oldzrot[playerid] = 0;
			SaveQuickGasPumpData(editobjextra[playerid],editobjgasstation[playerid]);
			if((admineditingstate[playerid])==1)
			{
   				admineditingstate[playerid] = 0;
				format(string,sizeof(string),"[ADMIN:%s] has moved gaspump. [ID:%i-%i] owner:%s Reason[%s]",GetPlayerNameReturn(playerid),editobjextra[playerid],editobjgasstation[playerid],gasstationownername[editobjgasstation[playerid]],admineditingreason[playerid]);
				SendClientMessageToAll(PINK,string);
			}
			SendClientMessage(playerid, LIGHTBLUE,"You have moved a gaspump");
			buildtype[playerid] = 0;
			return 1;
	    }
	    else if(response == EDIT_RESPONSE_CANCEL)
	    {
			gaspumpx[editobjextra[playerid]][editobjgasstation[playerid]] = oldx[playerid];
			gaspumpy[editobjextra[playerid]][editobjgasstation[playerid]] = oldy[playerid];
			gaspumpz[editobjextra[playerid]][editobjgasstation[playerid]] = oldz[playerid];
			gaspumpxrot[editobjextra[playerid]][editobjgasstation[playerid]] = oldxrot[playerid];
			gaspumpyrot[editobjextra[playerid]][editobjgasstation[playerid]] = oldyrot[playerid];
			gaspumpzrot[editobjextra[playerid]][editobjgasstation[playerid]] = oldzrot[playerid];
			oldx[playerid] = 0;
			oldy[playerid] = 0;
			oldz[playerid] = 0;
			oldxrot[playerid] = 0;
			oldyrot[playerid] = 0;
			oldzrot[playerid] = 0;
			MoveDynamicObject(objectid,gaspumpx[editobjextra[playerid]][editobjgasstation[playerid]],gaspumpy[editobjextra[playerid]][editobjgasstation[playerid]],gaspumpz[editobjextra[playerid]][editobjgasstation[playerid]],10.0,gaspumpxrot[editobjextra[playerid]][editobjgasstation[playerid]],gaspumpyrot[editobjextra[playerid]][editobjgasstation[playerid]],gaspumpzrot[editobjextra[playerid]][editobjgasstation[playerid]]);
			Delete3DTextLabel(gaspumplabel[editobjextra[playerid]][editobjgasstation[playerid]]);
   			format(string,sizeof(string),"gaspump:%i-%i\n%s\ncurrentfuel:%f our of %f\n%s",editobjextra[playerid],editobjgasstation[playerid],CurrentReful(editobjextra[playerid],editobjgasstation[playerid]),gaspumpgas[editobjextra[playerid]][editobjgasstation[playerid]],MAX_GASPERPUMP,GasPumpUsage(editobjextra[playerid],editobjgasstation[playerid]));
			gaspumplabel[editobjextra[playerid]][editobjgasstation[playerid]] = Create3DTextLabel(string,YELLOW,gaspumpx[editobjextra[playerid]][editobjgasstation[playerid]],gaspumpy[editobjextra[playerid]][editobjgasstation[playerid]],gaspumpz[editobjextra[playerid]][editobjgasstation[playerid]],DISTANCELABEL,0,0);
			SendClientMessage(playerid, LIGHTBLUE, "you have canceled moveing the gaspump");
			SaveQuickGasPumpData(editobjextra[playerid],editobjgasstation[playerid]);
			buildtype[playerid] = 0;
			return 1;
	    }
	}
	else if((buildtype[playerid])==1)//moveoilpump
	{
	    new string[256];
	    if(response == EDIT_RESPONSE_UPDATE)
	    {
	        MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
	        Delete3DTextLabel(oilpumplabel[editobjextra[playerid]][editobjrefinery[playerid]]);
     		format(string,sizeof(string),"OilpumpID:%i-%i,owner:%s,state:%s",editobjextra[playerid],editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],RefineryProductionState(editobjrefinery[playerid]));
            oilpumplabel[editobjextra[playerid]][editobjrefinery[playerid]] = Create3DTextLabel(string,YELLOW,x,y,z,DISTANCELABEL,0,0);
	    }
	    else if(response == EDIT_RESPONSE_FINAL)
	    {
	        MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
	        buildtype[playerid] = 0;
	        if(IsOilPumpNotNearOilPump(editobjextra[playerid],editobjrefinery[playerid]))
	        {
		        oldx[playerid] = 0;
		        oldy[playerid] = 0;
		        oldz[playerid] = 0;
		        oldxrot[playerid] = 0;
		        oldyrot[playerid] = 0;
		        oldzrot[playerid] = 0;
				oilpumpx[editobjextra[playerid]][editobjrefinery[playerid]] = x;
				oilpumpy[editobjextra[playerid]][editobjrefinery[playerid]] = y;
				oilpumpz[editobjextra[playerid]][editobjrefinery[playerid]] = z;
				oilpumpxrot[editobjextra[playerid]][editobjrefinery[playerid]] = rx;
				oilpumpyrot[editobjextra[playerid]][editobjrefinery[playerid]] = ry;
				oilpumpzrot[editobjextra[playerid]][editobjrefinery[playerid]] = rz;
    			Delete3DTextLabel(oilpumplabel[editobjextra[playerid]][editobjrefinery[playerid]]);
     			format(string,sizeof(string),"OilpumpID:%i-%i,owner:%s,state:%s",editobjextra[playerid],editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],RefineryProductionState(editobjrefinery[playerid]));
            	oilpumplabel[editobjextra[playerid]][editobjrefinery[playerid]] = Create3DTextLabel(string,YELLOW,oilpumpx[editobjextra[playerid]][editobjrefinery[playerid]],oilpumpy[editobjextra[playerid]][editobjrefinery[playerid]],oilpumpz[editobjextra[playerid]][editobjrefinery[playerid]],DISTANCELABEL,0,0);
	            SaveQuickOilPumpData(editobjextra[playerid],editobjrefinery[playerid]);
	            SendClientMessage(playerid,LIGHTBLUE,"You have moved the oilpump");
	            if((admineditingstate[playerid])==1)
				{
				    admineditingstate[playerid] = 0;
					format(string,sizeof(string),"[ADMIN:%s] has moved oil pump. [ID:%i-%i] owner:%s Reason[%s]",GetPlayerNameReturn(playerid),editobjextra[playerid],editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],admineditingreason[playerid]);
					SendClientMessageToAll(PINK,string);
				}
			}
			else
			{
			    MoveDynamicObject(objectid,oldx[playerid],oldy[playerid],oldz[playerid],oldxrot[playerid],oldyrot[playerid],oldzrot[playerid]);
   				oilpumpx[editobjextra[playerid]][editobjrefinery[playerid]] = oldx[playerid];
				oilpumpy[editobjextra[playerid]][editobjrefinery[playerid]] = oldy[playerid];
				oilpumpz[editobjextra[playerid]][editobjrefinery[playerid]] = oldz[playerid];
				oilpumpxrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldxrot[playerid];
				oilpumpyrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldyrot[playerid];
				oilpumpzrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldzrot[playerid];
				Delete3DTextLabel(oilpumplabel[editobjextra[playerid]][editobjrefinery[playerid]]);
     			format(string,sizeof(string),"OilpumpID:%i-%i,owner:%s,state:%s",editobjextra[playerid],editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],RefineryProductionState(editobjrefinery[playerid]));
            	oilpumplabel[editobjextra[playerid]][editobjrefinery[playerid]] = Create3DTextLabel(string,YELLOW,oilpumpx[editobjextra[playerid]][editobjrefinery[playerid]],oilpumpy[editobjextra[playerid]][editobjrefinery[playerid]],oilpumpz[editobjextra[playerid]][editobjrefinery[playerid]],DISTANCELABEL,0,0);
			    oldx[playerid] = 0;
		        oldy[playerid] = 0;
		        oldz[playerid] = 0;
		        oldxrot[playerid] = 0;
		        oldyrot[playerid] = 0;
		        oldzrot[playerid] = 0;
	            SaveQuickOilPumpData(editobjextra[playerid],editobjrefinery[playerid]);
	            SendClientMessage(playerid, RED, "this oil pump is to close to another oil pump");
			}
			buildtype[playerid] = 0;
			return 1;
	    }
     	else if(response == EDIT_RESPONSE_CANCEL)
	    {
	        MoveDynamicObject(objectid,oldx[playerid],oldy[playerid],oldz[playerid],oldxrot[playerid],oldyrot[playerid],oldzrot[playerid]);
			buildtype[playerid] = 0;
			oilpumpx[editobjextra[playerid]][editobjrefinery[playerid]] = oldx[playerid];
			oilpumpy[editobjextra[playerid]][editobjrefinery[playerid]] = oldy[playerid];
			oilpumpz[editobjextra[playerid]][editobjrefinery[playerid]] = oldz[playerid];
			oilpumpxrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldxrot[playerid];
			oilpumpyrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldyrot[playerid];
			oilpumpzrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldzrot[playerid];
			Delete3DTextLabel(oilpumplabel[editobjextra[playerid]][editobjrefinery[playerid]]);
     		format(string,sizeof(string),"OilpumpID:%i-%i,owner:%s,state:%s",editobjextra[playerid],editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],RefineryProductionState(editobjrefinery[playerid]));
            oilpumplabel[editobjextra[playerid]][editobjrefinery[playerid]] = Create3DTextLabel(string,YELLOW,oilpumpx[editobjextra[playerid]][editobjrefinery[playerid]],oilpumpy[editobjextra[playerid]][editobjrefinery[playerid]],oilpumpz[editobjextra[playerid]][editobjrefinery[playerid]],DISTANCELABEL,0,0);
	        oldx[playerid] = 0;
	        oldy[playerid] = 0;
	        oldz[playerid] = 0;
	        oldxrot[playerid] = 0;
	        oldyrot[playerid] = 0;
	        oldzrot[playerid] = 0;
			SaveQuickOilPumpData(editobjextra[playerid],editobjrefinery[playerid]);
			buildtype[playerid] = 0;
			return 1;
	    }
	}
	else if((buildtype[playerid])==2)//moveoilstorage
	{
		new string[256];
		if(response == EDIT_RESPONSE_UPDATE)
	    {
            MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
            Delete3DTextLabel(oilstoragelabel[editobjextra[playerid]][editobjrefinery[playerid]]);
            format(string,sizeof(string),"ID:%i-%i\n This fuelstorage is owned by %s\nThere is currently %fL out of %f fuel in hear\ncurrentstate:%s",editobjextra[playerid],editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],oilstoragefuel[editobjextra[playerid]][editobjrefinery[playerid]],MAX_OILSTORAGE,RefineryProductionState(editobjrefinery[playerid]));
			oilstoragelabel[editobjextra[playerid]][editobjrefinery[playerid]] = Create3DTextLabel(string,YELLOW,x,y,z,DISTANCELABEL,0,0);
	    }
	    else if(response == EDIT_RESPONSE_FINAL)
	    {
            MoveDynamicObject(objectid,x,y,z,10.0,rx,ry,rz);
            buildtype[playerid] = 0;
            if(IsOilStorageNearRefinery(editobjextra[playerid],editobjrefinery[playerid]))
            {
                if(IsOilStorageNotNearOilStorage(editobjextra[playerid],editobjrefinery[playerid]))
                {
		            oilstoragex[editobjextra[playerid]][editobjrefinery[playerid]] = x;
		            oilstoragey[editobjextra[playerid]][editobjrefinery[playerid]] = y;
		            oilstoragez[editobjextra[playerid]][editobjrefinery[playerid]] = z;
		            oilstoragexrot[editobjextra[playerid]][editobjrefinery[playerid]] = rx;
		            oilstorageyrot[editobjextra[playerid]][editobjrefinery[playerid]] = ry;
		            oilstoragezrot[editobjextra[playerid]][editobjrefinery[playerid]] = rz;
		   	        oldx[playerid] = 0;
			        oldy[playerid] = 0;
			        oldz[playerid] = 0;
			        oldxrot[playerid] = 0;
			        oldyrot[playerid] = 0;
			        oldzrot[playerid] = 0;
           			Delete3DTextLabel(oilstoragelabel[editobjextra[playerid]][editobjrefinery[playerid]]);
		            format(string,sizeof(string),"ID:%i-%i\n This fuelstorage is owned by %s\nThere is currently %fL out of %f fuel in hear\ncurrentstate:%s",editobjextra[playerid],editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],oilstoragefuel[editobjextra[playerid]][editobjrefinery[playerid]],MAX_OILSTORAGE,RefineryProductionState(editobjrefinery[playerid]));
					oilstoragelabel[editobjextra[playerid]][editobjrefinery[playerid]] = Create3DTextLabel(string,YELLOW,oilstoragex[editobjextra[playerid]][editobjrefinery[playerid]],oilstoragey[editobjextra[playerid]][editobjrefinery[playerid]],oilstoragez[editobjextra[playerid]][editobjrefinery[playerid]],DISTANCELABEL,0,0);
		            SaveQuickOilStorageData(editobjextra[playerid],editobjrefinery[playerid]);
					if((admineditingstate[playerid])==1)
					{
						admineditingstate[playerid] = 0;
						format(string,sizeof(string),"[ADMIN:%s] has move refinery storage. [id:%i-%i] owener:%s Reason[%s]",GetPlayerNameReturn(playerid),editobjextra[playerid],editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],admineditingreason[playerid]);
	    				SendClientMessageToAll(PINK,string);
					}
				}
				else
				{
					MoveDynamicObject(objectid,oldx[playerid],oldy[playerid],oldz[playerid],oldxrot[playerid],oldyrot[playerid],oldzrot[playerid]);
	      			oilstoragex[editobjextra[playerid]][editobjrefinery[playerid]] = oldx[playerid];
		            oilstoragey[editobjextra[playerid]][editobjrefinery[playerid]] = oldy[playerid];
		            oilstoragez[editobjextra[playerid]][editobjrefinery[playerid]] = oldz[playerid];
		            oilstoragexrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldxrot[playerid];
		            oilstorageyrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldyrot[playerid];
		            oilstoragezrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldzrot[playerid];
		            Delete3DTextLabel(oilstoragelabel[editobjextra[playerid]][editobjrefinery[playerid]]);
            		format(string,sizeof(string),"ID:%i-%i\n This fuelstorage is owned by %s\nThere is currently %fL out of %f fuel in hear\ncurrentstate:%s",editobjextra[playerid],editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],oilstoragefuel[editobjextra[playerid]][editobjrefinery[playerid]],MAX_OILSTORAGE,RefineryProductionState(editobjrefinery[playerid]));
					oilstoragelabel[editobjextra[playerid]][editobjrefinery[playerid]] = Create3DTextLabel(string,YELLOW,oilstoragex[editobjextra[playerid]][editobjrefinery[playerid]],oilstoragey[editobjextra[playerid]][editobjrefinery[playerid]],oilstoragez[editobjextra[playerid]][editobjrefinery[playerid]],DISTANCELABEL,0,0);
				    oldx[playerid] = 0;
			        oldy[playerid] = 0;
			        oldz[playerid] = 0;
			        oldxrot[playerid] = 0;
			        oldyrot[playerid] = 0;
			        oldzrot[playerid] = 0;
			        SaveQuickOilStorageData(editobjextra[playerid],editobjrefinery[playerid]);
			        SendClientMessage(playerid, RED, "This oil storage is to close to another oil storage");
				}
			}
			else
			{
			    MoveDynamicObject(objectid,oldx[playerid],oldy[playerid],oldz[playerid],oldxrot[playerid],oldyrot[playerid],oldzrot[playerid]);
      			oilstoragex[editobjextra[playerid]][editobjrefinery[playerid]] = oldx[playerid];
	            oilstoragey[editobjextra[playerid]][editobjrefinery[playerid]] = oldy[playerid];
	            oilstoragez[editobjextra[playerid]][editobjrefinery[playerid]] = oldz[playerid];
	            oilstoragexrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldxrot[playerid];
	            oilstorageyrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldyrot[playerid];
	            oilstoragezrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldzrot[playerid];
	            Delete3DTextLabel(oilstoragelabel[editobjextra[playerid]][editobjrefinery[playerid]]);
            	format(string,sizeof(string),"ID:%i-%i\n This fuelstorage is owned by %s\nThere is currently %fL out of %f fuel in hear\ncurrentstate:%s",editobjextra[playerid],editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],oilstoragefuel[editobjextra[playerid]][editobjrefinery[playerid]],MAX_OILSTORAGE,RefineryProductionState(editobjrefinery[playerid]));
				oilstoragelabel[editobjextra[playerid]][editobjrefinery[playerid]] = Create3DTextLabel(string,YELLOW,oilstoragex[editobjextra[playerid]][editobjrefinery[playerid]],oilstoragey[editobjextra[playerid]][editobjrefinery[playerid]],oilstoragez[editobjextra[playerid]][editobjrefinery[playerid]],DISTANCELABEL,0,0);
			    oldx[playerid] = 0;
		        oldy[playerid] = 0;
		        oldz[playerid] = 0;
		        oldxrot[playerid] = 0;
		        oldyrot[playerid] = 0;
		        oldzrot[playerid] = 0;
		        SaveQuickOilStorageData(editobjextra[playerid],editobjrefinery[playerid]);
		        SendClientMessage(playerid,RED,"you have move the oil storage to far away from the refinery");
			}
			buildtype[playerid] = 0;
			return 1;
	    }
     	else if(response == EDIT_RESPONSE_CANCEL)
	    {
     		MoveDynamicObject(objectid,oldx[playerid],oldy[playerid],oldz[playerid],oldxrot[playerid],oldyrot[playerid],oldzrot[playerid]);
	        buildtype[playerid] = 0;
         	oilstoragex[editobjextra[playerid]][editobjrefinery[playerid]] = oldx[playerid];
            oilstoragey[editobjextra[playerid]][editobjrefinery[playerid]] = oldy[playerid];
            oilstoragez[editobjextra[playerid]][editobjrefinery[playerid]] = oldz[playerid];
            oilstoragexrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldxrot[playerid];
            oilstorageyrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldyrot[playerid];
            oilstoragezrot[editobjextra[playerid]][editobjrefinery[playerid]] = oldzrot[playerid];
            Delete3DTextLabel(oilstoragelabel[editobjextra[playerid]][editobjrefinery[playerid]]);
            format(string,sizeof(string),"ID:%i-%i\n This fuelstorage is owned by %s\nThere is currently %fL out of %f fuel in hear\ncurrentstate:%s",editobjextra[playerid],editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],oilstoragefuel[editobjextra[playerid]][editobjrefinery[playerid]],MAX_OILSTORAGE,RefineryProductionState(editobjrefinery[playerid]));
			oilstoragelabel[editobjextra[playerid]][editobjrefinery[playerid]] = Create3DTextLabel(string,YELLOW,oilstoragex[editobjextra[playerid]][editobjrefinery[playerid]],oilstoragey[editobjextra[playerid]][editobjrefinery[playerid]],oilstoragez[editobjextra[playerid]][editobjrefinery[playerid]],DISTANCELABEL,0,0);
	        oldx[playerid] = 0;
	        oldy[playerid] = 0;
	        oldz[playerid] = 0;
	        oldxrot[playerid] = 0;
	        oldyrot[playerid] = 0;
	        oldzrot[playerid] = 0;
	        SaveQuickOilStorageData(editobjextra[playerid],editobjrefinery[playerid]);
	        buildtype[playerid] = 0;
	        return 1;
	    }
	}
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	/*if(dialogid == VEHICLEREPAIRSHOPADD)//#4
	{
	    if(response)
	    {
	        new string[256];
			new carid = choicemodelid[playerid];
	        cartype[carid] = 4;
			if((carlocktype[carid])==1)
			{
			    if((carlock[carid])==1)
			    {
			        new engine,lights,alarm,doors,bonnet,boot,objective;
					GetVehicleParamsEx(car[carid],engine,lights,alarm,doors,bonnet,boot,objective);
					SetVehicleParamsEx(car[carid],engine,lights,alarm,false,bonnet,boot,objective);
			    }
			}
			carlocktype[carid] = 0;
			SaveQuickCarData(carid);
			format(string,sizeof(string),"%s has added a ID:%i - modelid %i:%s to repairshopid:%i[Reason:%s]",carownername[carid],carid,carmodelid[car[carid]],GetVehicleName(carmodelid[carid]),cardealershipid[carid],choicestring[playerid]);
			SaveRepairshopLog(string);
			for(new i;i < MAX_PLAYERS;i++)
			{
			    if(IsPlayerConnected(i))
			    {
			        if((repairshopgroup[i])==1)
			        {
						SendClientMessage(i,REPAIRSHOPCOLOR,string);
					}
				}
			}
	    }
	    else
	    {
	        cardealershipid[choicemodelid[playerid]] = 0;
	        SendClientMessage(playerid,RED,"You have canceled adding a vehicle");
	    }
	}
	else*/ if(dialogid == MODCAR)
	{
	    if(response)
	    {
	        new vehicleid = choiceid[playerid];//Connected with previous statement
	        new carid = jbcarid[vehicleid];//Gets the carid based on the vehicleid
	        if((carstate[carid])==1)//Checks if the car is a personal vehicle
	        {
	            new countpass = 0;
				for(new count;count < 14;count++)
				{
				    if((choicemarked[count][playerid])==1)
					{
						if((countpass)==listitem)
						{
						    Park(playerid,car[carid],carid);
						    RemoveVehicleComponent(choiceid[playerid],carmodslot[count][carid]);
						    RefreshCar(carid);
						    carmodslot[count][carid] = GetVehicleComponentInSlot(vehicleid, count);
						    SaveQuickCarData(carid);
							ShowPlayerDialog(playerid,CANCEL,DIALOG_STYLE_MSGBOX,"Removed","You have removed a mod from your vehicle","Close","Close");
							/*if((cartype[carid])==4)//#4
							{
							    new string[256],name[MAX_PLAYER_NAME];
							    GetPlayerName(playerid,name,sizeof(name));
							    format(string,sizeof(string),"%s has remove mod modslot:%i from car ID:%i modelid %i:%s",name,count,carid,carmodelid[carid],GetVehicleName(carmodelid[carid]));
							    SaveRepairshopLog(string);
								for(new i;i < MAX_PLAYERS;i++)
								{
									if(IsPlayerConnected(i))
									{
										if((repairshopgroup[i])==1)
										{
										    SendClientMessage(i,REPAIRSHOPCOLOR,string);
										}
									}
								}
							}*/
						    return 1;
						}
						else
						{
                            countpass++;
						}
					}
				}
			}
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "Request Canceled");
		}
	}
	/*else if(dialogid == VEHICLEREPAIRSHOPREMOVE)//#4
	{
		if(response)
	    {
	        new name[MAX_PLAYER_NAME];
			new string[256];
			new carid = choicemodelid[playerid];
			GetPlayerName(playerid,name,sizeof(name));
			cartype[carid] = 1;
			format(string,sizeof(string),"%s has remove a ID:%i- modelid %i:%sfrom repairshopid:%i. %s is the donator of the vehicle[Reason:%s]",name,carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),cardealershipid[carid],carownername[carid],choicestring[playerid]);
            SaveRepairshopLog(string);
			format(carownername[carid],sizeof(carownername),"%s",name);
			cardealershipid[carid] = 0;
			for(new i;i < MAX_PLAYERS;i++)
			{
			    if(IsPlayerConnected(i))
			    {
			        if((repairshopgroup[i])==1)
			        {
						SendClientMessage(i,REPAIRSHOPCOLOR,string);
					}
				}
			}
	    }
	    else
	    {

	    }
	}*/
	else if(dialogid == VEHICLEREMOVECONFIRM)
	{
	    if(response)
	    {
	        SendClientMessage(playerid,RED,"You have delete your car");
	        fuel[car[choicemodelid[playerid]]] = 100.0;
  			DestroyVehicle(car[choicemodelid[playerid]]);
			DeleteCarData(choicemodelid[playerid]);
	    }
	    else
	    {
	        SendClientMessage(playerid,RED,"You have canceled you request");
	    }
	}
	else if(dialogid == COLORSELECTIONINPUT2)
	{
	    if(response)
	    {
	        if(IsNumeric(inputtext))
			{
			    new color = strval(inputtext);
                if((color) <= 255&&(color) >= 0)
                {
                    choicecolor2[playerid] = color;
                    ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
                }
                else
                {
                	ShowPlayerDialog(playerid,COLORSELECTIONINPUT2,DIALOG_STYLE_INPUT,"Color2 Input","ERROR:the colorids are between 0 and 255, Please insert color 2 colorid","Ok","Back");
                }
			}
			else
			{
			    ShowPlayerDialog(playerid,COLORSELECTIONINPUT2,DIALOG_STYLE_INPUT,"Color2 Input","ERROR:you did not insert a number, Please insert color 2 colorid","Ok","Back");
			}
	    }
	    else
	    {
            ShowPlayerDialog(playerid,COLORSELECTION2,DIALOG_STYLE_LIST,"Color 2",COLORSELECTIONSTATEMENT,"Ok","Back");
	    }
	    return 1;
	}
	else if(dialogid == COLORSELECTIONINPUT1)
	{
	    if(response)
	    {
	        if(IsNumeric(inputtext))
			{
			    new color = strval(inputtext);
                if((color) <= 255&&(color) >= 0)
                {
                    choicecolor1[playerid] = color;
                    ShowPlayerDialog(playerid,COLORSELECTION2,DIALOG_STYLE_LIST,"Color 2",COLORSELECTIONSTATEMENT,"Ok","Back");
                }
                else
                {
                	ShowPlayerDialog(playerid,COLORSELECTIONINPUT1,DIALOG_STYLE_INPUT,"Color1 Input","ERROR:the colorids are between 0 and 255, Please insert color 1 colorid","Ok","Back");
                }
			}
			else
			{
			    ShowPlayerDialog(playerid,COLORSELECTIONINPUT1,DIALOG_STYLE_INPUT,"Color1 Input","ERROR:you did not insert a number, Please insert color 1 colorid","Ok","Back");
			}
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,COLORSELECTION1,DIALOG_STYLE_LIST,"Color 1",COLORSELECTIONSTATEMENT,"Ok","Close");
	    }
	    return 1;
	}
	else if(dialogid == COLORSELECTION1)
	{
	    if(response)
	    {
			if(listitem == 0)
			{
   				ShowPlayerDialog(playerid,COLORSELECTIONINPUT1,DIALOG_STYLE_INPUT,"Color1 Input","Please insert color 1 colorid","Ok","Back");
   				return 1;
			}
			else if(listitem == 1)
			{
		    	choicecolor1[playerid] = 127;
	  		}
	 		else if(listitem == 2)
			{
				choicecolor1[playerid] = 175;
	   		}
			else if(listitem == 3)
			{
				choicecolor1[playerid] = 166;
	   		}
			else if(listitem == 4)
			{
				choicecolor1[playerid] = 229;
			}
			else if(listitem == 5)
			{
				choicecolor1[playerid] = 157;
			}
			else if(listitem == 6)
	  		{
	    		choicecolor1[playerid] = 142;
	      	}
	       	else if(listitem == 7)
	        {
				choicecolor1[playerid] = 136;
	  		}
			else if(listitem == 8)
			{
				choicecolor1[playerid] = 1;
	   		}
	   		else if(listitem == 9)
	     	{
				choicecolor1[playerid] = 71;
			}
			else if(listitem == 10)
			{
			    choicecolor1[playerid] = random(255);
			}
			ShowPlayerDialog(playerid,COLORSELECTION2,DIALOG_STYLE_LIST,"Color 2",COLORSELECTIONSTATEMENT,"Ok","Back");
	    }
	    else
		{
		    SendClientMessage(playerid,RED,"Dialog boxes closed");
		}
	    return 1;
	}
	else if(dialogid == COLORSELECTION2)
	{
	    if(response)
	    {
	    	if(listitem == 0)
			{
   				ShowPlayerDialog(playerid,COLORSELECTIONINPUT2,DIALOG_STYLE_INPUT,"Color2 Input","Please insert color 2 colorid","Ok","Back");
   				return 1;
			}
			else if(listitem == 1)
			{
		    	choicecolor2[playerid] = 127;
	  		}
	 		else if(listitem == 2)
			{
				choicecolor2[playerid] = 175;
	   		}
			else if(listitem == 3)
			{
				choicecolor2[playerid] = 166;
	   		}
			else if(listitem == 4)
			{
				choicecolor2[playerid] = 229;
			}
			else if(listitem == 5)
			{
				choicecolor2[playerid] = 157;
			}
			else if(listitem == 6)
	  		{
	    		choicecolor2[playerid] = 142;
	      	}
	       	else if(listitem == 7)
	        {
				choicecolor2[playerid] = 136;
	  		}
			else if(listitem == 8)
			{
				choicecolor2[playerid] = 1;
	   		}
	   		else if(listitem == 9)
	     	{
				choicecolor2[playerid] = 71;
			}
			else if(listitem == 10)
			{
			    choicecolor2[playerid] = random(255);
			}
	        ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,COLORSELECTION1,DIALOG_STYLE_LIST,"Color 1",COLORSELECTIONSTATEMENT,"Ok","Close");
	    }
	    return 1;
	}
	else if(dialogid == VEHICLEMAKEPRICECONFIRM)
	{
	    if(response)
	    {
	        new string[256];
	        vehiclemanufactureingcost[choiceid[playerid] - 400] = choicecost[playerid];
	        format(string,sizeof(string),"[ADMIN:%s]Has changed the price of the vehicle manufacturing cost for a %i:%s from $%i to $%i",GetPlayerNameReturn(playerid),choiceid[playerid],GetVehicleName(choiceid[playerid]),vehiclemanufactureingcost[choiceid[playerid] - 400],VehicleSoldCost(choiceid[playerid]));
		    SendClientMessageToAll(PINK,string);
		    SaveManufactureingcostData();
	   		addvstate[playerid] = 0;
		   	choicecolor1[playerid] = 0;
			choicecolor2[playerid] = 0;
	    }
		else
		{
		    new string[256];
	 		format(string,sizeof(string),"Please enter how much you want the %s to cost it currently costs $%i to manufacture and $%i after manufacturing",GetVehicleName(choiceid[playerid]),vehiclemanufactureingcost[choiceid[playerid] - 400],VehicleSoldCost(choiceid[playerid]));
    		ShowPlayerDialog(playerid,VEHICLEMAKEPRICE,DIALOG_STYLE_INPUT,"Vehicle Cost",string,"Ok","Cancel");
		}
	}
	else if(dialogid == VEHICLEMAKEPRICE)
	{
	    if(response)
	    {
	        if(IsNumeric(inputtext))
	        {
	            new string[256];
	            choicecost[playerid] = strval(inputtext);
	            new temp = floatround(choicecost[playerid] * FACTORYMARKUPPRECENT,floatround_round);
	            format(string,sizeof(string),"If you make the vehicle manufactureing price for the (%i:%s) from $%i to $%i the vehicle actual cost after manufactureing would be $%i. \nAre you sure you wish to make this change?",choiceid[playerid],GetVehicleName(choiceid[playerid]),vehiclemanufactureingcost[choiceid[playerid] - 400],choicecost[playerid],temp);
				ShowPlayerDialog(playerid,VEHICLEMAKEPRICECONFIRM,DIALOG_STYLE_MSGBOX,"Confirm",string,"Yes","No");
			}
			else
			{
			    new string[256];
		 		format(string,sizeof(string),"ERROR:you did not enter a number, Please enter how much you want the %s to cost it currently costs $%i to manufacture and $%i after manufacturing",GetVehicleName(choiceid[playerid]),vehiclemanufactureingcost[choiceid[playerid] - 400],VehicleSoldCost(choiceid[playerid]));
	    		ShowPlayerDialog(playerid,VEHICLEMAKEPRICE,DIALOG_STYLE_INPUT,"Vehicle Cost",string,"Ok","Cancel");
			}
	    }
	    else
	    {
	        SendClientMessage(playerid,RED,"You have closed the dialog boxes");
	    }
	    return 1;
	}
	else if(dialogid == REPAIRSHOPBUYLOCK)
	{
	    if(response)
	    {
	        new vehicleid = GetPlayerVehicleID(playerid);
	        new carid = jbcarid[vehicleid];
	        if((carstate[carid])==1)
	        {
	            if((cartype[carid])==1)
	            {
					if(strcmp(GetPlayerNameReturn(playerid),carownername[carid],false,MAX_PLAYER_NAME)==0)
					{
					    new money = GetPlayerMoney(playerid);
				        if(listitem == 0)
				        {
				            if((money)>= repairshopslockcost[editobjrepairshop[playerid]])
				            {
				                if((carlocktype[carid]) != 1)
				                {
					                GivePlayerMoney(playerid,-repairshopslockcost[editobjrepairshop[playerid]]);
                                    TogglePlayerControllable(playerid,false);
                                    TextDrawShowForPlayer(playerid, textaddinglock);
				                    SetTimerEx("AddLock",1000,false,"iii",playerid,carid,1);
				                    SaveQuickRepairShopData(editobjrepairshop[playerid]);
								}
								else
								{
								    SendClientMessage(playerid,RED,"You already have this lock");
								}
							}
							else
							{
							    SendClientMessage(playerid,RED,"You don't have enought cash for this lock");
							}
				        }
				        else if(listitem == 1)
				        {
				            if((money)>= repairshopelockcost[editobjrepairshop[playerid]])
				            {
				                if((carlocktype[carid]) != 2)
				                {
					                GivePlayerMoney(playerid,-repairshopelockcost[editobjrepairshop[playerid]]);
					                TogglePlayerControllable(playerid,false);
					                TextDrawShowForPlayer(playerid, textaddinglock);
				                    SetTimerEx("AddLock",1000,false,"iii",playerid,carid,2);
		                			SaveQuickRepairShopData(editobjrepairshop[playerid]);
								}
								else
								{
								    SendClientMessage(playerid,RED,"You already have this lock");
								}
							}
							else
							{
							    SendClientMessage(playerid,RED,"You don't have enought cash for this lock");
							}
				        }
				        
					}
					else
					{
					    SendClientMessage(playerid,RED,"You don't own this car");
					}
				}
				else
				{
				    SendClientMessage(playerid,RED,"This is not a personal vehicle, You can't buy a lock");
				}
			}
			else
			{
			    SendClientMessage(playerid,RED,"This is not a jbcar");
			}
	    }
	    else
	    {
			editobjrepairshop[playerid] = 0;
			SendClientMessage(playerid,RED,"You have closed the dialog boxes");
	    }
	    return 1;
	}
	else if(dialogid == DISPOSERMENU)
	{
	    if(response)
	    {
     		new carid = choiceid[playerid];
	        choiceid[playerid] = 0;
	        new cost = VehicleManufactureingPrice(carmodelid[carid]);
         	cost = cost / 4;
			new string[256];
			format(string,sizeof(string),"You have sold your %s for $%i",GetVehicleName(carmodelid[carid]),cost);
			GivePlayerMoney(playerid,cost);
			SendClientMessage(playerid,LIGHTBLUE,string);
			DestroyVehicle(car[carid]);
			DeleteCarData(carid);
	    }
	    else
	    {
	        choiceid[playerid] = 0;
	        SendClientMessage(playerid,RED,"You have caneled disposeing your vehicle");
	    }
	    return 1;
	}
	else if(dialogid == FACTORYDELIVERY)
	{
	    if(response)
	    {
	        new factorycount;
	        for(new count;count < FACTORYMAXORDERSATONCE;count++)
			{
			    if((factorystockstate[count][deliveryfactoryid[playerid]])==2)
			    {
			        if((factorydeliverying[count][deliveryfactoryid[playerid]]) == 0)
			        {
				        if((factorycount)==listitem)
				        {
				            deliveryid[playerid] = count;
				            deliverycarsamount[playerid] = factorystock[count][deliveryfactoryid[playerid]];
				            deliverymodelid[playerid] = factorydealerstockmodelid[count][deliveryfactoryid[playerid]];
				            deliverytruck[playerid] = GetPlayerVehicleID(playerid);
				            deliverydropoffstate[playerid] = 2;
				            deliverystate[playerid] = 1;
				            deliverydealershipid[playerid] = factorydealershipid[count][deliveryfactoryid[playerid]];
				            factorydeliverying[count][deliveryfactoryid[playerid]] = 1;
				            SendClientMessage(playerid,LIGHTBLUE,"Now drive to the checkpoint");
				            SetPlayerCheckpoint(playerid,dealershipx[deliverydealershipid[playerid]],dealershipy[deliverydealershipid[playerid]],dealershipz[deliverydealershipid[playerid]],8.0);
				            return 1;
				        }
				        else
				        {
				        	factorycount++;
						}
					}
			    }
			}
	    }
	    else
	    {
	        deliverystate[playerid] = 0;
	        deliveryfactoryid[playerid] = 0;
	        SendClientMessage(playerid,RED,"You have closed the dialog boxes");
	    }
		return 1;
	}
	else if(dialogid == DEALERSHIPAPROVE)
	{
		if(response)
		{
			if(IsNumeric(inputtext))
			{
			    new price = strval(inputtext);
				for(new count = 1;count < MAX_VEHICLES;count++)
			    {
			        if((carstate[count])==0)
			        {
			            new string[256];
	                    carstate[count] = 1;
			            cartype[count] = 2;
				    	GetPlayerPos(playerid,carx[count],cary[count],carz[count]);
				    	cary[count] = cary[count];
				    	carz[count] = carz[count] + 2.5;
			    		GetPlayerFacingAngle(playerid,carrot[count]);
			    		carcolor1[count] = choicecolor1[playerid];
			    		carcolor2[count] = choicecolor2[playerid];
			    		carmodelid[count] = choicemodelid[playerid];
						cardealershipid[count] = choiceid[playerid];
						car[count] = CreateVehicle(carmodelid[count],carx[count],cary[count],carz[count],carrot[count],carcolor1[count],carcolor2[count],-1);
						jbcarid[car[count]] = count;
						fuel[car[count]] = 100.0;
						carfuel[count] = 100.0;
						carcost[count] = price;
						dealershipcash[choiceid[playerid]] = dealershipcash[choiceid[playerid]] - VehicleSoldCost(carmodelid[count]);
						requeststockstate[carmodelid[count] - 400][cardealershipid[count]] = 1;
						format(carownername[count],sizeof(carownername),"none");
						format(string,sizeof(string),"%i:Dealership vehicle\nThis vehicle cost $%i\n%s",cardealershipid[count],carcost[count],CarStock(count));
						carlabel[count] = Create3DTextLabel(string,YELLOW,carx[count],cary[count],carz[count],DISTANCELABEL,0,0);
						Attach3DTextLabelToVehicle(carlabel[count],car[count],0,0,0);
						SaveQuickCarData(count);
						SaveQuickDealershipData(cardealershipid[count]);
         				PutPlayerInVehicle(playerid,car[count],0);
						return 1;
			        }
			    }
			}
			else
			{
			    new string[256];
				format(string,sizeof(string),"Error you did not enter a number, this vehicle will cost $%i from the factory. Please enter how mutch you are going to sell it for",VehicleSoldCost(choicemodelid[playerid]));
			    ShowPlayerDialog(playerid,DEALERSHIPAPROVE,DIALOG_STYLE_INPUT,"How mutch?",string,"Ok","Cancel");
			}
		}
		else
		{
			SendClientMessage(playerid, RED, "You have cancel buying a vehicle");
		}
		return 1;
	}
	else if(dialogid == FACTORYPRODUCTIONSTATE)
	{
	    if(response)
	    {
	        if((factoryproductionstate[editobjfactory[playerid]])==0)
	        {
		        if((factorycash[editobjfactory[playerid]]) >= 0)
		        {
					factoryproductionstate[editobjfactory[playerid]] = 1;
					factorytimer[editobjfactory[playerid]] = SetTimerEx("VehicleProduction",15000,true,"i",editobjfactory[playerid]);
					UpdateFactoryLabel(editobjfactory[playerid]);
		            SaveQuickFactoryData(editobjfactory[playerid]);
					ShowPlayerDialog(playerid,FACTORYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Factory Menu","You have enabled production in you factory","Back","Close");
				}
				else
				{
				    ShowPlayerDialog(playerid,FACTORYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Factory Menu","The cash has in the factory safe has to be $0 or more inorder for the factory to work","Back","Close");
				}
			}
			else
			{
			    ShowPlayerDialog(playerid,FACTORYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Factory Menu","The faction is already produceing vehicles","Back","Close");
			}
	    }
	    else
	    {
	        if((factoryproductionstate[editobjfactory[playerid]])==1)
	        {
		        factoryproductionstate[editobjfactory[playerid]] = 0;
		        UpdateFactoryLabel(editobjfactory[playerid]);
		        SaveQuickFactoryData(editobjfactory[playerid]);
		        ShowPlayerDialog(playerid,FACTORYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Factory Menu","You have disabled production in you factory","Back","Close");
			}
			else
			{
				ShowPlayerDialog(playerid,FACTORYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Factory Menu","The factory is already not produceing any vehicles","Back","Close");
			}
	    }
	    return 1;
	}
	else if(dialogid == DEALERSHIPBUYCAR)
	{
	    if(response)
	    {
			if(IsNumeric(inputtext))
			{
				new total = strval(inputtext) * VehicleSoldCost(choicemodelid[playerid]);
				if((total) <= dealershipcash[choiceid[playerid]])
				{
				    new string[256];
        			requeststockstate[choicemodelid[playerid] - 400][choiceid[playerid]] = 2;
                	requeststock[choicemodelid[playerid]- 400][choiceid[playerid]] = strval(inputtext);
                    dealershipordercash[choiceid[playerid]] = dealershipordercash[choiceid[playerid]] + total;
                    dealershipcash[choiceid[playerid]] = dealershipcash[choiceid[playerid]] - total;
	                SaveQuickDealershipData(choiceid[playerid]);
	                DealershipAddSlot(choiceid[playerid],choicemodelid[playerid] -400);
	                format(string,sizeof(string),"You have placed an order for %i car(s), You have made a $%i deposit, please wait for you order to be accept by a factory",requeststock[choicemodelid[playerid] - 400][choiceid[playerid]],total);
	                ShowPlayerDialog(playerid,DEALERSHIPBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Placed Order",string,"Back","Close");
				}
				else
				{
				    requeststock[choicemodelid[playerid] - 400][choiceid[playerid]] = 0;
				    requeststockstate[choicemodelid[playerid] - 400][choiceid[playerid]] = 1;
				    ShowPlayerDialog(playerid,DEALERSHIPBUYCAR,DIALOG_STYLE_INPUT,"Ammount","ERROR you don't have enought cash, Please enter how many cars you want","Ok","Close");
				}
			}
			else
			{
			    ShowPlayerDialog(playerid,DEALERSHIPBUYCAR,DIALOG_STYLE_INPUT,"Ammount","ERROR you did not enter a number, Please enter how many cars you want","Ok","Close");
			}
	    }
	    else
	    {
     		SendClientMessage(playerid, RED, "dialog boxes have been close");
	    }
	    return 1;
	}
	else if(dialogid == FACTORYMENU)
	{
		if(response)
		{
		    if(listitem == 0)
		    {
		        new str[256];
		        format(str,sizeof(str),"Car Factory Balance:%i",factorycash[editobjfactory[playerid]]);
		        ShowPlayerDialog(playerid,FACTORYDEPOSIT,DIALOG_STYLE_INPUT,str,"Please enter how mutch you want to deposit","Ok","Back");
			}
			else if(listitem == 1)
			{
  				new str[256];
		        format(str,sizeof(str),"Car Factory Balance:%i",factorycash[editobjfactory[playerid]]);
		        ShowPlayerDialog(playerid,FACTORYWITHDRAW,DIALOG_STYLE_INPUT,str,"Please enter how mutch you want to withdraw","Ok","Back");
			}
			else if(listitem == 2)
			{
				new str[1024],tmpstr[1024],requeststatecount;
    			OrganizeDealershipRequestSlot();
		        for(new count;count < MAX_SLOTS -12;count++)
				{
				    if((dealershiprequestslotstate[count])==1)
				    {
					    requeststatecount++;
						if(isnull(str))
						{
						    format(str,sizeof(str),"%s:%i %s(s)",dealershipname[dealershiprequestslot[1][count]],requeststock[dealershiprequestslot[0][count]][dealershiprequestslot[1][count]],GetVehicleName(dealershiprequestslot[0][count] + 400));
						}
						else
						{
						    format(tmpstr,sizeof(tmpstr),"%s\n%s:%i %s(s)",str,dealershipname[dealershiprequestslot[1][count]],requeststock[dealershiprequestslot[0][count]][dealershiprequestslot[1][count]],GetVehicleName(dealershiprequestslot[0][count] + 400));
						    format(str,sizeof(str),"%s",tmpstr);
						}
					}
				}
				if((requeststatecount)==0)
				{
				    ShowPlayerDialog(playerid,FACTORYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Factory Menu","No dealership needs cars right now","Back","Close");
				}
				else
				{
					ShowPlayerDialog(playerid,FACTORYSELLTODEALERSHIP,DIALOG_STYLE_LIST,"Dealership Being sold to",str,"Ok","Back");
				}
			}
			else if(listitem == 3)
			{
			    ShowPlayerDialog(playerid,FACTORYPRODUCTIONSTATE,DIALOG_STYLE_MSGBOX,"Production state","Do you want the factory to produce cars?","Yes","No");
			}
			else if(listitem == 4)
			{
				new string[1024],tmpstr[1024],listitemcount;
			    for(new count;count < FACTORYMAXORDERSATONCE;count++)
			    {
			        if((factorystockstate[count][editobjfactory[playerid]])!=0)
			        {
			            if((listitemcount) == 12)
			            {
			                break;
			            }
			            if(isnull(string))
			            {
			                format(string,sizeof(string),"%s:%i %s(s)",dealershipname[factorydealershipid[count][editobjfactory[playerid]]],factorydealerstock[count][editobjfactory[playerid]],GetVehicleName(factorydealerstockmodelid[count][editobjfactory[playerid]]));
			            }
			            else
			            {
			                format(tmpstr,sizeof(tmpstr),"%s",string);
							format(string,sizeof(string),"%s\n%s:%i %s(s)",string,dealershipname[factorydealershipid[count][editobjfactory[playerid]]],factorydealerstock[count][editobjfactory[playerid]],GetVehicleName(factorydealerstockmodelid[count][editobjfactory[playerid]]));
						}
			            listitemcount++;
			        }
			    }
			    if((listitemcount) > 0)
			    {
					ShowPlayerDialog(playerid,FACTORYCURRENTPRODUCTION,DIALOG_STYLE_LIST,"Currently Manufactureing",string,"Ok","Back");
				}
				else
				{
				    ShowPlayerDialog(playerid,FACTORYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Factory Menu","Your factory is not currently makeing any cars","Back","Close");
				}
			}
		}
		else
		{
		    editobjfactory[playerid] = 0;
		    SendClientMessage(playerid, RED, "Closed factory menu");
		}
		return 1;
	}
	else if(dialogid == FACTORYCURRENTPRODUCTION)
	{
	    if(response)
	    {
	        new listitemcount;
			for(new count;count < FACTORYMAXORDERSATONCE;count++)
		    {
		        if((factorystockstate[count][editobjfactory[playerid]])==1||(factorystockstate[count][editobjfactory[playerid]])==2)
		        {
		            if((listitemcount)==listitem)
		            {
		                new str[256];
		                new precentage = CurrentProcductionPercent(count,editobjfactory[playerid]);
		                format(str,sizeof(str),"%i:%s %i %s(s)to go.Current proudction %i%% current made %i Orderstate = %s",factorydealershipid[count][editobjfactory[playerid]],dealershipname[factorydealershipid[count][editobjfactory[playerid]]],factorydealerstock[count][editobjfactory[playerid]],GetVehicleName(factorydealerstockmodelid[count][editobjfactory[playerid]]),precentage,factorystock[count][editobjfactory[playerid]],FactoryOrderState(count,editobjfactory[playerid]));
		                ShowPlayerDialog(playerid,FACTORYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Current Order",str,"Back","Close");
		                return 1;
		            }
					else
					{
					    listitemcount++;
					}
		        }
			}
	    }
	    else
	    {
	     	ShowPlayerDialog(playerid,FACTORYMENU,DIALOG_STYLE_LIST,"Factory Menu",FACTORYMENUSTATEMENT,"Ok","Close");
	    }
	    return 1;
	}
	else if(dialogid == FACTORYSELLTODEALERSHIP)
	{
	    if(response)
	    {
			new requeststockcount,string[256];
			for(new count;count < MAX_SLOTS -12;count++)
			{
			    if((dealershiprequestslotstate[count])==1)
			    {
				    if((listitem)==requeststockcount)
				    {
				        for(new count2;count2 < FACTORYMAXORDERSATONCE;count2++)
				        {
							if((factorystockstate[count2][editobjfactory[playerid]])==0)
							{
		        				new modelid = dealershiprequestslot[0][count];
			                	new dealershipid = dealershiprequestslot[1][count];
						    	requeststockstate[modelid][dealershipid] = 3;
							    factoryordercost[count2][editobjfactory[playerid]] = requeststock[modelid][dealershipid] * VehicleSoldCost(modelid + 400);
							    dealershipordercash[dealershipid] = dealershipordercash[dealershipid] - factoryordercost[count2][editobjfactory[playerid]];
							    factorycash[editobjfactory[playerid]] = factorycash[editobjfactory[playerid]] + factoryordercost[count2][editobjfactory[playerid]];
							    factorystockstate[count2][editobjfactory[playerid]] = 1;//state
							    factorydealershipid[count2][editobjfactory[playerid]] = dealershipid;//dealershipid
								factorydealerstockmodelid[count2][editobjfactory[playerid]] = modelid + 400;//carmodelid
					            factorydealerstock[count2][editobjfactory[playerid]] = requeststock[modelid][dealershipid];//ammountneededtostock
					            new INI:mainfile = INI_Open(mainfilename);
					            SaveDealershipData(mainfile,dealershipid);
					            DealershipRemoveSlot(dealershipid,modelid);
								SaveFactoryData(mainfile,editobjfactory[playerid]);
								INI_Close(mainfile);
								format(string,sizeof(string),"You have approved %s's request for %i %s(s). You have recived $%i for the order",dealershipname[dealershipid],factorydealerstock[count2][editobjfactory[playerid]],GetVehicleName(factorydealerstockmodelid[count2][editobjfactory[playerid]]),factoryordercost[count2][editobjfactory[playerid]]);
								ShowPlayerDialog(playerid,FACTORYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Order approved",string,"Back","Close");
								return 1;
							}
						}
						SendClientMessage(playerid,RED,"You don't have anymore room to manufacutre another vehicle");
						return 1;
				    }
				    else
				    {
				        requeststockcount++;
				    }
				}
			}
            return 1;
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,FACTORYMENU,DIALOG_STYLE_LIST,"Factory Menu",FACTORYMENUSTATEMENT,"Ok","Close");
	    }
	    return 1;
	}
	else if(dialogid == FACTORYBACK&CANCEL)
	{
	    if(response)
	    {
	        ShowPlayerDialog(playerid,FACTORYMENU,DIALOG_STYLE_LIST,"Factory Menu",FACTORYMENUSTATEMENT,"Ok","Close");
	    }
	    else
	    {
	        SendClientMessage(playerid,RED,"Dialog boxes closed");
	    }
	    return 1;
	}
	else if(dialogid == FACTORYWITHDRAW)
	{
	    if(response)
	    {
			if(IsNumeric(inputtext))
			{
				new cash = strval(inputtext);
				if((cash) <= factorycash[editobjfactory[playerid]])
				{
				    new string[256];
				    factorycash[editobjfactory[playerid]] = factorycash[editobjfactory[playerid]] - cash;
					GivePlayerMoney(playerid,cash);
					format(string,sizeof(string),"You withdrew $%i leaveing $%i in your account",cash,factorycash[editobjfactory[playerid]]);
					SaveQuickFactoryData(editobjfactory[playerid]);
					ShowPlayerDialog(playerid,FACTORYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Factory Withdraw",string,"Back","Close");
				}
				else
				{
					new str[256];
			        format(str,sizeof(str),"Car Factory Balance:%i",factorycost[editobjfactory[playerid]]);
			        ShowPlayerDialog(playerid,FACTORYWITHDRAW,DIALOG_STYLE_INPUT,str,"ERROR you can't withdraw more cash then in your business, please enter how mutch you want to withdraw","Ok","Back");
				}
			}
			else
			{
				new str[256];
		        format(str,sizeof(str),"Car Factory Balance:%i",factorycost[editobjfactory[playerid]]);
		        ShowPlayerDialog(playerid,FACTORYWITHDRAW,DIALOG_STYLE_INPUT,str,"ERROR you did not enter a number, please enter how mutch you want to withdraw","Ok","Back");
			}
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,FACTORYMENU,DIALOG_STYLE_LIST,"Factory Menu",FACTORYMENUSTATEMENT,"Ok","Close");
	    }
		return 1;
	}
	else if(dialogid == FACTORYDEPOSIT)
	{
	    if(response)
	    {
	    	if(IsNumeric(inputtext))
			{
			    new cash = strval(inputtext);
			    new playercash = GetPlayerMoney(playerid);
			    if((playercash) >= cash)
				{
				    new string[256];
				    factorycash[editobjfactory[playerid]] = factorycash[editobjfactory[playerid]] + cash;
				    GivePlayerMoney(playerid,-cash);
				    format(string,sizeof(string),"you deposited $%i totaling $%i in your account",cash,factorycash[editobjfactory[playerid]]);
				    SaveQuickFactoryData(editobjfactory[playerid]);
				    ShowPlayerDialog(playerid,FACTORYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Factory Deposit",string,"Back","Close");

				}
				else
				{
	                new str[256];
			        format(str,sizeof(str),"Car Factory Balance:%i",factorycash[editobjfactory[playerid]]);
			        ShowPlayerDialog(playerid,FACTORYDEPOSIT,DIALOG_STYLE_INPUT,str,"ERROR you don't have enought cash, please enter how mutch you want to deposit","Ok","Back");
				}
			}
			else
			{
				new str[256];
		        format(str,sizeof(str),"Car Factory Balance:%i",factorycash[editobjfactory[playerid]]);
		        ShowPlayerDialog(playerid,FACTORYDEPOSIT,DIALOG_STYLE_INPUT,str,"ERROR you did not enter a number, please enter how mutch you want to deposit","Ok","Back");
			}
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,FACTORYMENU,DIALOG_STYLE_LIST,"Factory Menu",FACTORYMENUSTATEMENT,"Ok","Close");
	    }
	    return 1;
	}
	else if(dialogid == CARBUYMENU)
	{
	    if(response)
	    {
			new vehicleid = GetPlayerVehicleID(playerid);
			new carid = jbcarid[vehicleid];
			new money = GetPlayerMoney(playerid);
			if((money) >= carcost[carid])
			{
			    if((cartype[carid])==2)
			    {
				    if((carstock[carid]) > 0)
				    {
				        carstock[carid] = carstock[carid] - 1;
					    for(new count = 1;count < MAX_VEHICLES;count++)
					    {
					        if((carstate[count])==0)
					        {
					            carstate[count] = 1;
					            cartype[count] = 1;
					            carfuel[count] = 100.0;
					            carx[count] = dealershipx[cardealershipid[carid]];
					            cary[count] = dealershipy[cardealershipid[carid]];
					            carz[count] = dealershipz[cardealershipid[carid]] + 2.5;
					            carrot[count] = carrot[carid];
					            carcolor1[count] = carcolor1[carid];
					            carcolor2[count] = carcolor2[carid];
								carcost[count] = carcost[carid];
								carmodelid[count] = carmodelid[carid];
								cardealershipid[count] = -1;
								format(carownername[count],sizeof(carownername),"%s",GetPlayerNameReturn(playerid));
								carstock[count] = 0;
								car[count] = CreateVehicle(carmodelid[count],carx[count],cary[count],carz[count],carrot[count],carcolor1[count],carcolor2[count],-1);
								fuel[car[count]] = carfuel[count];
								jbcarid[car[count]] = count;
								UpdateCarLabel(carid);
								GivePlayerMoney(playerid,-carcost[carid]);
								dealershipcash[cardealershipid[carid]] = dealershipcash[cardealershipid[carid]] + carcost[carid];
								SendClientMessage(playerid,LIGHTBLUE,"You have purchased a new car");
								RemovePlayerFromCar(playerid);
                                SetTimerEx("PutPlayerInVehicleDelay",500,false,"iii",playerid,car[count],0);
                                new INI:carfile = INI_Open(carfilename);
								SaveCarData(carfile,count);//Saves new car data
								SaveCarData(carfile,carid);//Saves old car data
								INI_Close(carfile);
								SaveQuickDealershipData(cardealershipid[carid]);//Saves dealership data
								return 1;
					        }
					    }
					}
					else
					{
						SendClientMessage(playerid,RED,"This dealership vehicle is out of stock");
		   				SendClientMessage(playerid,RED,"You have been ejected");
				        RemovePlayerFromCar(playerid);
					}
				}
				else if((cartype[carid])==3)
				{
					GivePlayerMoney(playerid,-carcost[carid]);
					dealershipcash[cardealershipid[carid]] = dealershipcash[cardealershipid[carid]] + carcost[carid];
					GetPlayerName(playerid,carownername[carid],sizeof(carownername));
					cartype[carid] = 1;
					cardealershipid[carid] = -1;
					Delete3DTextLabel(carlabel[carid]);
					SaveQuickCarData(carid);
					SaveQuickDealershipData(cardealershipid[carid]);
					SendClientMessage(playerid,LIGHTBLUE,"You have bought a used car");
				}
			}
			else
			{
				SendClientMessage(playerid,RED,"You don't have enought cash for this car");
   				SendClientMessage(playerid,RED,"You have been ejected");
		        RemovePlayerFromCar(playerid);
			}
	    }
	    else
	    {
	    	new vehicleid = GetPlayerVehicleID(playerid);
			new carid = jbcarid[vehicleid];
			if(strcmp(GetPlayerNameReturn(playerid),dealershipownername[cardealershipid[carid]],false,sizeof(dealershipownername))==0)
			{
				SendClientMessage(playerid, YELLOW, "This car belong to your dealership");
			}
			else
			{
		        SendClientMessage(playerid,RED,"You have been ejected");
		        RemovePlayerFromCar(playerid);
			}
	    }
	    return 1;
	}
	else if(dialogid == DEALERSHIPMENU)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
				new str[128];
				format(str,sizeof(str),"Dealership balance:$%i",dealershipcash[editobjdealership[playerid]]);
				ShowPlayerDialog(playerid,DEALERSHIPDEPOSIT,DIALOG_STYLE_INPUT,str,"Please enter how mutch you want to deposit","Ok","Back");
	        }
	        else if(listitem == 1)
	        {
	            new str[128];
	            format(str,sizeof(str),"Dealership balance:$%i",dealershipcash[editobjdealership[playerid]]);
	            ShowPlayerDialog(playerid,DEALERSHIPWITHDRAW,DIALOG_STYLE_INPUT,str,"Please enter how mutch you want to withdraw","Ok","Back");
	        }
	        else if(listitem == 2)
	        {
	            ShowPlayerDialog(playerid,DEALERSHIPNAME,DIALOG_STYLE_INPUT,"Dealership name","Please enter your dealership name","Ok","Back");
	        }
	        else if(listitem == 3)
	        {
	            addvstate[playerid] = 5;
		   		choicecolor1[playerid] = 0;
				choicecolor2[playerid] = 0;
				choiceid[playerid] = editobjdealership[playerid];
				ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
	        }
			else if(listitem == 4)
			{
			    new str[1024],tmpstr[1024],listitemcount;
			    pagecount[playerid] = 0;
				for(new count;count < 212;count++)
				{
					if((requeststockstate[count][editobjdealership[playerid]])==2||(requeststockstate[count][editobjdealership[playerid]])==3||(requeststockstate[count][editobjdealership[playerid]])==4)
					{
					    if((listitemcount)==10)
					    {
					        break;
					    }
						if(isnull(str))
						{
						    format(str,sizeof(str),"carmodel:%s. %s",GetVehicleName(count + 400),DealershipCarState(requeststockstate[count][editobjdealership[playerid]]));
						}
						else
						{
							format(tmpstr,sizeof(tmpstr),"%s\ncarmodel:%s. %s",str,GetVehicleName(count+400),DealershipCarState(requeststockstate[count][editobjdealership[playerid]]));
							format(str,sizeof(str),"%s",tmpstr);
						}
						listitemcount++;
					}
				}
				if((listitemcount)==0)
				{
					ShowPlayerDialog(playerid,DEALERSHIPBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Dealershipmenu","You currently don't have any orders for vehicles","Back","Close");
				}
				else
				{
					ShowPlayerDialog(playerid,DEALERSHIPCANCELBUYCAR,DIALOG_STYLE_LIST,"Please select a car",str,"Cancel Order","Back");
				}
			}
	    }
	    else
	    {
	        SendClientMessage(playerid,RED,"dialog boxes closed");
	    }
	    return 1;
	}
	else if(dialogid == DEALERSHIPCANCELBUYCAR)
	{
	    if(response)
	    {
	        new listitemcount = 0,string[256];
    		for(new count;count < 212;count++)
			{
				if((requeststockstate[count][editobjdealership[playerid]])==2||(requeststockstate[count][editobjdealership[playerid]])==3||(requeststockstate[count][editobjdealership[playerid]])==4)
				{
				    if((listitemcount)==listitem)
				    {
				        if((requeststockstate[count][editobjdealership[playerid]])==2)
				        {
					        new total = requeststock[count][editobjdealership[playerid]] * VehicleSoldCost(count + 400);
					        format(string,sizeof(string),"You have canceled purchaseing %i %s(s), your $%i is back in your dealership",requeststock[count][editobjdealership[playerid]],GetVehicleName(count + 400),total);
					        dealershipordercash[editobjdealership[playerid]] = dealershipordercash[editobjdealership[playerid]] - total;
					        dealershipcash[editobjdealership[playerid]] = dealershipcash[editobjdealership[playerid]] + total;
		    				requeststockstate[count][editobjdealership[playerid]] = 1;
							requeststock[count][editobjdealership[playerid]] = 0;
							DealershipRemoveSlot(editobjdealership[playerid],count);
							SaveQuickDealershipData(editobjdealership[playerid]);
							ShowPlayerDialog(playerid,DEALERSHIPBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Canceled",string,"Back","Close");
					        return 1;
						}
						else
						{
						    if((requeststockstate[count][editobjdealership[playerid]])==3)
						    {
						    	return ShowPlayerDialog(playerid,DEALERSHIPBACK&CANCEL,DIALOG_STYLE_MSGBOX,"To Late","This car is already in manufactureing you can't return it now","Back","Close");
							}
							else if((requeststockstate[count][editobjdealership[playerid]])==4)
							{
							    return ShowPlayerDialog(playerid,DEALERSHIPBACK&CANCEL,DIALOG_STYLE_MSGBOX,"To Late","This vehicle has been manufactured and is ready to be delivered to your dealership","Back","Close");
							}
						}
				    }
				    else
				    {
						listitemcount++;
					}
				}
			}
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,DEALERSHIPMENU,DIALOG_STYLE_LIST,"Dealership menu",DEALERSHIPMENUSTATEMENT,"Ok","Close");
	    }
		return 1;
	}
	else if(dialogid == DEALERSHIPDEPOSIT)
	{
	    if(response)
	    {
	        if(IsNumeric(inputtext))
	        {
				new amount = strval(inputtext);
				GivePlayerMoney(playerid,-amount);
				dealershipcash[editobjdealership[playerid]] = dealershipcash[editobjdealership[playerid]] + amount;
				SaveQuickDealershipData(editobjdealership[playerid]);
				ShowPlayerDialog(playerid,DEALERSHIPBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Deposit","You have deposit cash in the dealership safe","Back","Close");
	        }
	        else
	        {
	            new str[128];
				format(str,sizeof(str),"Dealership balance:$%i",dealershipcash[editobjdealership[playerid]]);
				ShowPlayerDialog(playerid,DEALERSHIPDEPOSIT,DIALOG_STYLE_INPUT,str,"ERROR not number, please enter how mutch you want to deposit","Ok","Back");
	        }
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,DEALERSHIPMENU,DIALOG_STYLE_LIST,"Dealership menu",DEALERSHIPMENUSTATEMENT,"Ok","Close");
	    }
	    return 1;
	}
	else if(dialogid == DEALERSHIPWITHDRAW)
	{
	    if(response)
	    {
	    	if(IsNumeric(inputtext))
	        {
				new amount = strval(inputtext);
				if((amount) <= dealershipcash[editobjdealership[playerid]])
				{
				    dealershipcash[editobjdealership[playerid]] = dealershipcash[editobjdealership[playerid]] - amount;
					GivePlayerMoney(playerid,amount);
				    SaveQuickDealershipData(editobjdealership[playerid]);
				    ShowPlayerDialog(playerid,DEALERSHIPBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Withdraw","You have withdraw cash in the dealership safe","Back","Close");
				}
				else
				{
					new str[128];
		            format(str,sizeof(str),"Dealership balance:$%i",dealershipcash[editobjdealership[playerid]]);
		            ShowPlayerDialog(playerid,DEALERSHIPWITHDRAW,DIALOG_STYLE_INPUT,str,"ERROR You don't have that mutch in the dealership, please enter how mutch you want to withdraw","Ok","Back");
				}
	        }
	        else
	        {
	            new str[128];
	            format(str,sizeof(str),"Dealership balance:$%i",dealershipcash[editobjdealership[playerid]]);
	            ShowPlayerDialog(playerid,DEALERSHIPWITHDRAW,DIALOG_STYLE_INPUT,str,"ERROR not number, please enter how mutch you want to withdraw","Ok","Back");
	        }
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,DEALERSHIPMENU,DIALOG_STYLE_LIST,"Dealership menu",DEALERSHIPMENUSTATEMENT,"Ok","Close");
	    }
	    return 1;
	}
	else if(dialogid == DEALERSHIPNAME)
	{
	    if(response)
	    {
	        if(!isnull(inputtext))
	        {
				format(dealershipname[editobjdealership[playerid]],sizeof(dealershipname),"%s",inputtext);
				UpdateDealershipLabels(editobjdealership[playerid]);
				SaveQuickDealershipData(editobjdealership[playerid]);
				ShowPlayerDialog(playerid,DEALERSHIPBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Dealershipname","You have changed the name of your dealership","Back","Close");
			}
			else
			{
                ShowPlayerDialog(playerid,DEALERSHIPNAME,DIALOG_STYLE_INPUT,"Dealership name","ERROR blank, please enter your dealership name","Ok","Back");
			}
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,DEALERSHIPMENU,DIALOG_STYLE_LIST,"Dealership menu",DEALERSHIPMENUSTATEMENT,"Ok","Close");
	    }
	    return 1;
	}
	else if(dialogid == DEALERSHIPBACK&CANCEL)
	{
	    if(response)
	    {
	        ShowPlayerDialog(playerid,DEALERSHIPMENU,DIALOG_STYLE_LIST,"Dealership menu",DEALERSHIPMENUSTATEMENT,"Ok","Close");
	    }
	    else
	    {
	        SendClientMessage(playerid,RED,"Dialogid boxes closed");
	    }
	    return 1;
	}
	/*else if(dialogid == REFINERYPAYBACK)//#4
	{
	    if(response)
	    {
			new roundcash = floatround(refinerydebt[editobjrefinery[playerid]]);
			if((refinerycash[editobjrefinery[playerid]]) >= roundcash)
			{
				new string[256];
				format(string,sizeof(string),"you paid the electric bill it cost you $%f you have $%i still left",refinerydebt,refinerycash);
				refinerydebt[editobjrefinery[playerid]] = 0;
				refinerycash[editobjrefinery[playerid]] = refinerycash[editobjrefinery[playerid]] - roundcash;
				SaveQuickRefineryData(editobjrefinery[playerid]);
				SendClientMessage(playerid, LIGHTBLUE,string);
			}
			else
			{
			    SendClientMessage(playerid, RED, "you don't have enought cash to pay it back");
			}
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,REFINERYMENU,DIALOG_STYLE_LIST,"Refinery menu",REFINERYMENUSTATEMENT,"Ok","Close");
	    }
	    return 1;
	}*/
	else if(dialogid == SELECTGASSTATION)
	{
	    if(response)
	    {
	        new count = gasstationrequestslot[listitem];
		    if(IsThereEnoughFuel(count,deliveryrefineryid[playerid]))
		    {
			    deliverystate[playerid] = 1;
			    deliverytruck[playerid] = GetPlayerVehicleID(playerid);
				deliveryid[playerid] = count;
				new Float:dfuel = DivideFuel(deliveryrefineryid[playerid],ammountofgasneeded[count]);
				for(new count2 = 0;count2 < MAX_OILPUMPS;count2++)
				{
				    if((oilstoragestate[count2][deliveryrefineryid[playerid]])==1)
				    {
						oilstoragefuel[count2][deliveryrefineryid[playerid]] = oilstoragefuel[count2][deliveryrefineryid[playerid]] - dfuel;
					}
				}
				deliveryfuel[playerid] = ammountofgasneeded[count];
                new gaspayment = floatround(gasstationbuygascost[deliveryid[playerid]] * PRECENTAGEOFFPAYMENT);
				gaspayment = gasstationbuygascost[deliveryid[playerid]] - gaspayment;
				refinerycash[deliveryrefineryid[playerid]] = refinerycash[deliveryrefineryid[playerid]] + gaspayment;
				refineryblocked[deliveryrefineryid[playerid]] = 1;
				UpdateRefineryLabels(deliveryrefineryid[playerid]);
				SaveQuickRefineryData(deliveryrefineryid[playerid]);
				gasstationbeingdeliveredto[deliveryid[playerid]] = 1;
				gasstationneedgasstate[deliveryid[playerid]] = 0;
                GasStationRemoveSlot(deliveryid[playerid]);
				deliverytrailer[playerid] = CreateVehicle(584,refinerytrailerx[deliveryrefineryid[playerid]],refinerytrailery[deliveryrefineryid[playerid]],refinerytrailerz[deliveryrefineryid[playerid]],refinerytrailerrot[deliveryrefineryid[playerid]],1,1,-1);
				SendClientMessage(playerid, LIGHTBLUE, "hook up the truck to the trailer");
			}
			else
			{
			    SendClientMessage(playerid, RED, "The refinery does not have enough gas for the gasstation you selected");
			}
	    }
	    else
	    {
			SendClientMessage(playerid, RED, "Dialog boxes closed");
	    }
		return 1;
	}
	else if(dialogid == GASSTATIONGASCOST)
	{
	    if(response)
	    {
	        if(IsNumeric(inputtext))
	        {
	            new cost = strval(inputtext);
	            new string[256];
	            format(string,sizeof(string),"You change the cost of the gas at your gasstation from $%i per L to $%i per L",gasstationgascost[editobjgasstation[playerid]],cost);
	            SendClientMessage(playerid, LIGHTBLUE, string);
	            gasstationgascost[editobjgasstation[playerid]] = cost;
	            SaveQuickGasStationData(editobjgasstation[playerid]);
	            UpdateGasStationLabels(editobjgasstation[playerid]);
	        }
	        else
	        {
  			    new str[256];
			    format(str,sizeof(str),"SalePrice:$%i",gasstationgascost[editobjgasstation[playerid]]);
			    ShowPlayerDialog(playerid,GASSTATIONGASCOST,DIALOG_STYLE_INPUT,str,"ERROR you did not enter a number. Please enter how mutch you want gas to cost per liter","Ok","Back");
	        }
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,GASSTATIONMENU,DIALOG_STYLE_LIST,"Gas station menu",GASSTATIONMENUSTATEMENT,"Ok","Cancel");
	    }
	    return 1;
	}
	else if(dialogid == LISTCARS)
	{
        if(response)
		{
		    new string[1024];
		    if(listitem == 0)
			{
			    ShowPlayerDialog(playerid,CUSTOM,DIALOG_STYLE_INPUT,"Cars","please enter the id of the car you would like to input","Ok","Back");
			}
			else if(listitem ==1)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",GetVehicleName(460),GetVehicleName(476),GetVehicleName(511),GetVehicleName(512),GetVehicleName(513),GetVehicleName(519),GetVehicleName(520),GetVehicleName(553),GetVehicleName(577),GetVehicleName(592),GetVehicleName(593));
			    ShowPlayerDialog(playerid,AIRPLANES,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==2)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",GetVehicleName(548),GetVehicleName(425),GetVehicleName(417),GetVehicleName(487),GetVehicleName(488),GetVehicleName(497),GetVehicleName(563),GetVehicleName(447),GetVehicleName(469));
                ShowPlayerDialog(playerid,HELICOPTERS,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==3)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",GetVehicleName(509),GetVehicleName(481),GetVehicleName(510),GetVehicleName(462),GetVehicleName(448),GetVehicleName(581),GetVehicleName(522),GetVehicleName(461),GetVehicleName(521),GetVehicleName(523),GetVehicleName(463),GetVehicleName(586),GetVehicleName(468),GetVehicleName(471));
                ShowPlayerDialog(playerid,BIKES,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==4)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s",GetVehicleName(480),GetVehicleName(533),GetVehicleName(439),GetVehicleName(555));
                ShowPlayerDialog(playerid,CONVERTIBLES,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==5)
			{
			    ShowPlayerDialog(playerid,INDUSTRIAL,DIALOG_STYLE_LIST,"Cars","page1\npage2","Ok","Back");
			}
			else if(listitem ==6)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",GetVehicleName(536),GetVehicleName(575),GetVehicleName(534),GetVehicleName(567),GetVehicleName(535),GetVehicleName(566),GetVehicleName(576),GetVehicleName(412));
                ShowPlayerDialog(playerid,LOWRIDERS,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==7)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",GetVehicleName(568),GetVehicleName(424),GetVehicleName(578),GetVehicleName(579),GetVehicleName(400),GetVehicleName(500),GetVehicleName(444),GetVehicleName(556),GetVehicleName(557),GetVehicleName(470),GetVehicleName(489),GetVehicleName(505),GetVehicleName(495));
                ShowPlayerDialog(playerid,OFFROAD,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==8)
			{
                ShowPlayerDialog(playerid,SERVICEVEHICLES,DIALOG_STYLE_LIST,"Cars","Police/military\nfire/ambulance\nTransportation","Ok","Back");
			}
			else if(listitem ==9)
			{

                ShowPlayerDialog(playerid,SALOONS,DIALOG_STYLE_LIST,"Cars","page1\npage2","Ok","Back");
			}
			else if(listitem ==10)
			{
                ShowPlayerDialog(playerid,SPORTSCARS,DIALOG_STYLE_LIST,"Cars","page1\npage2","Ok","Back");
			}
			else if(listitem ==11)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s",GetVehicleName(418),GetVehicleName(404),GetVehicleName(479),GetVehicleName(458),GetVehicleName(561));
                ShowPlayerDialog(playerid,STATIONWAGONS,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==12)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",GetVehicleName(472),GetVehicleName(473),GetVehicleName(493),GetVehicleName(595),GetVehicleName(484),GetVehicleName(430),GetVehicleName(453),GetVehicleName(452),GetVehicleName(446),GetVehicleName(454));
                ShowPlayerDialog(playerid,BOATS,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==13)
			{
                ShowPlayerDialog(playerid,OTHERS,DIALOG_STYLE_LIST,"Cars","page1\npage2\npage3\npage4","Ok","Back");
			}
		}
		else
		{
			SendClientMessage(playerid,RED,"Dialog box closed");
		}
		return 1;
	}
	else if(dialogid == CUSTOM)
	{
		if(response)
		{
            new id = strval(inputtext);
			AddCar(playerid,id);
		}
		else
		{
		    ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == AIRPLANES)
	{
		if(response)
		{
            //460 476 511 512 513 519 520 553 577 592 593
            if(listitem == 0)
            {
                AddCar(playerid,460);
            }
			else if(listitem ==1)
			{
			    AddCar(playerid,476);
			}
			else if(listitem ==2)
			{
                AddCar(playerid,511);
			}
			else if(listitem ==3)
			{
                AddCar(playerid,512);
			}
			else if(listitem ==4)
			{
                AddCar(playerid,513);
			}
			else if(listitem ==5)
			{
                AddCar(playerid,519);
			}
			else if(listitem ==6)
			{
                AddCar(playerid,520);
			}
			else if(listitem ==7)
			{
                AddCar(playerid,553);
			}
			else if(listitem ==8)
			{
                AddCar(playerid,577);
			}
			else if(listitem ==9)
			{
                AddCar(playerid,592);
			}
			else if(listitem ==10)
			{
                AddCar(playerid,593);
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == HELICOPTERS)
	{
		if(response)
		{
            //548 425 417 487 488 497 563 447 469
            if(listitem ==0)
			{
                AddCar(playerid,548);
			}
			else if(listitem ==1)
			{
                 AddCar(playerid,425);
			}
			else if(listitem ==2)
			{
                AddCar(playerid,417);
			}
			else if(listitem ==3)
			{
                AddCar(playerid,487);
			}
			else if(listitem ==4)
			{
                AddCar(playerid,488);
			}
			else if(listitem ==5)
			{
                AddCar(playerid,497);
			}
			else if(listitem ==6)
			{
                AddCar(playerid,563);
			}
			else if(listitem ==7)
			{
                AddCar(playerid,447);
			}
			else if(listitem ==8)
			{
                AddCar(playerid,469);
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == BIKES)
	{//fix this entire part
		if(response)
		{
            //509 481 510 462 448 581 522 461 521 523 463 586 468 471
            if(listitem == 0)
            {
				AddCar(playerid,509);
            }
            else if(listitem == 1)
            {
                AddCar(playerid,481);
            }
            else if(listitem == 2)
            {
                AddCar(playerid,510);
            }
            else if(listitem == 3)
            {
                AddCar(playerid,462);
            }
            else if(listitem == 4)
            {
                AddCar(playerid,448);
            }
            else if(listitem == 5)
            {
                AddCar(playerid,581);
            }
            else if(listitem == 6)
            {
                AddCar(playerid,522);
            }
            else if(listitem == 7)
            {
                AddCar(playerid,461);
            }
            else if(listitem == 8)
            {
                AddCar(playerid,521);
            }
            else if(listitem == 9)
            {
                AddCar(playerid,523);
            }
            else if(listitem == 10)
            {
                AddCar(playerid,463);
            }
            else if(listitem == 11)
            {
                AddCar(playerid,586);
            }
            else if(listitem == 12)
            {
                AddCar(playerid,468);
            }
            else if(listitem == 13)
            {
                AddCar(playerid,471);
            }
		}
		else
		{
		    ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == CONVERTIBLES)
	{
        if(response)
		{
			// 480 533 439 555
			if(listitem ==0)
			{
				AddCar(playerid,480);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,533);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,439);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,555);
			}
		}
		else
		{
			ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == INDUSTRIAL)
	{
		if(response)
		{
		    new string [1024];
            if(listitem == 0)
			{
				format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage",GetVehicleName(499),GetVehicleName(422),GetVehicleName(482),GetVehicleName(498),GetVehicleName(609),GetVehicleName(524),GetVehicleName(578),GetVehicleName(455),GetVehicleName(403),GetVehicleName(414),GetVehicleName(582),GetVehicleName(443),GetVehicleName(514));
				ShowPlayerDialog(playerid,INDUSTRIALP1,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem == 1)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nbackpage",GetVehicleName(515),GetVehicleName(440),GetVehicleName(543),GetVehicleName(605),GetVehicleName(459),GetVehicleName(531),GetVehicleName(408),GetVehicleName(552),GetVehicleName(478),GetVehicleName(456),GetVehicleName(554),GetVehicleName(600),GetVehicleName(413));
		        ShowPlayerDialog(playerid,INDUSTRIALP2,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
		    }
		}
		else
		{
            ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == INDUSTRIALP1)
	{
	    if(response)
		{
		    new string[1024];
			//499 422 482 498 609 524 578 455 403 414 582 443 514 nextpage
			if(listitem ==0)
			{
   				AddCar(playerid,499);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,422);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,482);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,498);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,609);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,524);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,578);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,455);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,403);
			}
			else if(listitem ==9)
			{
				AddCar(playerid,414);
			}
			else if(listitem ==10)
			{
				AddCar(playerid,582);
			}
			else if(listitem ==11)
			{
				AddCar(playerid,443);
			}
			else if(listitem ==12)
			{
				AddCar(playerid,514);
			}
			else if(listitem ==13)
			{
   				format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nbackpage",GetVehicleName(515),GetVehicleName(440),GetVehicleName(543),GetVehicleName(605),GetVehicleName(459),GetVehicleName(531),GetVehicleName(408),GetVehicleName(552),GetVehicleName(478),GetVehicleName(456),GetVehicleName(554),GetVehicleName(600),GetVehicleName(413));
		        ShowPlayerDialog(playerid,INDUSTRIALP2,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
	    	ShowPlayerDialog(playerid,INDUSTRIAL,DIALOG_STYLE_LIST,"Cars","page1\npage2","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == INDUSTRIALP2)
	{
	    if(response)
		{
		    new string[1024];
            //515 440 543 605 459 531 408 552 478 456 554 600 413 backpage
			if(listitem ==0)
			{
				AddCar(playerid,515);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,440);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,543);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,605);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,459);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,531);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,408);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,552);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,478);
			}
			else if(listitem ==9)
			{
				AddCar(playerid,456);
			}
			else if(listitem ==10)
			{
				AddCar(playerid,554);
			}
			else if(listitem ==11)
			{
				AddCar(playerid,600);
			}
			else if(listitem ==12)
			{
				AddCar(playerid,413);
			}
			else if(listitem ==13)
			{
				format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage",GetVehicleName(499),GetVehicleName(422),GetVehicleName(482),GetVehicleName(498),GetVehicleName(609),GetVehicleName(524),GetVehicleName(578),GetVehicleName(455),GetVehicleName(403),GetVehicleName(414),GetVehicleName(582),GetVehicleName(443),GetVehicleName(514));
				ShowPlayerDialog(playerid,INDUSTRIALP1,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
	    	ShowPlayerDialog(playerid,INDUSTRIAL,DIALOG_STYLE_LIST,"Cars","page1\npage2","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == LOWRIDERS)
	{
		if(response)
		{
            //536 575 534 567 535 566 576 412
			if(listitem ==0)
			{
				AddCar(playerid,536);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,575);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,534);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,567);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,535);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,566);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,576);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,412);
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == OFFROAD)
	{
		if(response)
		{
            //568 424 578 579 400 500 444 556 557 470 489 505 495
			if(listitem ==0)
			{
				AddCar(playerid,468);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,424);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,578);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,579);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,400);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,500);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,444);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,556);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,557);
			}
			else if(listitem ==9)
			{
				AddCar(playerid,470);
			}
			else if(listitem ==10)
			{
				AddCar(playerid,489);
			}
			else if(listitem ==11)
			{
				AddCar(playerid,505);
			}
			else if(listitem ==12)
			{
				AddCar(playerid,495);
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == SERVICEVEHICLES)
	{
		if(response)
		{
		    new string[1024];
			if(listitem == 0)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage",GetVehicleName(433),GetVehicleName(523),GetVehicleName(427),GetVehicleName(490),GetVehicleName(528),GetVehicleName(596),GetVehicleName(598),GetVehicleName(597),GetVehicleName(599),GetVehicleName(432),GetVehicleName(601));//police & milatray
				ShowPlayerDialog(playerid,SERIVCEVEHICLESPOLICE,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==1)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\nnextpage\nbackpage",GetVehicleName(416),GetVehicleName(407),GetVehicleName(544));//ambulance & fire
				ShowPlayerDialog(playerid,SERIVCEVEHICLESAMBULANCE,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==2)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\nbackpage",GetVehicleName(431),GetVehicleName(438),GetVehicleName(437),GetVehicleName(420));//Transportation
				ShowPlayerDialog(playerid,SERVICEVEHICLESTRANSPORTATION,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == SERIVCEVEHICLESPOLICE)
	{
	    if(response)
		{
		    new string[1024];
            //433 523 427 490 528 596 598 597 599 432 601 nextpage
            if(listitem ==0)
			{
				AddCar(playerid,433);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,523);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,427);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,490);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,528);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,596);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,598);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,597);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,599);
			}
			else if(listitem ==9)
			{
				AddCar(playerid,432);
			}
			else if(listitem ==10)
			{
				AddCar(playerid,601);
			}
			else if(listitem ==11)
			{
   				format(string,sizeof(string),"%s\n%s\n%s\nnextpage\nbackpage",GetVehicleName(416),GetVehicleName(407),GetVehicleName(544));//ambulance & fire
				ShowPlayerDialog(playerid,SERIVCEVEHICLESAMBULANCE,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,SERVICEVEHICLES,DIALOG_STYLE_LIST,"Cars","Police/military\nfire/ambulance\nTransportation","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == SERIVCEVEHICLESAMBULANCE)
	{
	    if(response)
		{
		    new string[1024];
            //416 407 544 nextpage backpage
            if(listitem ==0)
			{
				AddCar(playerid,416);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,407);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,544);
			}
			else if(listitem ==3)
			{
   				format(string,sizeof(string),"%s\n%s\n%s\n%s\nbackpage",GetVehicleName(431),GetVehicleName(438),GetVehicleName(437),GetVehicleName(420));//Transportation
				ShowPlayerDialog(playerid,SERVICEVEHICLESTRANSPORTATION,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==4)
			{
   				format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage",GetVehicleName(433),GetVehicleName(523),GetVehicleName(427),GetVehicleName(490),GetVehicleName(528),GetVehicleName(596),GetVehicleName(598),GetVehicleName(597),GetVehicleName(599),GetVehicleName(432),GetVehicleName(601));//police & milatray
				ShowPlayerDialog(playerid,SERIVCEVEHICLESPOLICE,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,SERVICEVEHICLES,DIALOG_STYLE_LIST,"Cars","Police/military\nfire/ambulance\nTransportation","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == SERVICEVEHICLESTRANSPORTATION)
	{
	    if(response)
		{
			new string[1024];
            //431 438 437 420  backpage
            if(listitem ==0)
			{
				AddCar(playerid,431);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,438);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,437);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,420);
			}
			else if(listitem ==4)
			{
   				format(string,sizeof(string),"%s\n%s\n%s\nnextpage\nbackpage",GetVehicleName(416),GetVehicleName(407),GetVehicleName(544));//ambulance & fire
				ShowPlayerDialog(playerid,SERIVCEVEHICLESAMBULANCE,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
			ShowPlayerDialog(playerid,SERVICEVEHICLES,DIALOG_STYLE_LIST,"Cars","Police/military\nfire/ambulance\nTransportation","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == SALOONS)
	{
		if(response)
		{
		    new string[1024];
			if(listitem == 0)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage",GetVehicleName(445),GetVehicleName(504),GetVehicleName(401),GetVehicleName(518),GetVehicleName(527),GetVehicleName(542),GetVehicleName(507),GetVehicleName(562),GetVehicleName(585),GetVehicleName(419),GetVehicleName(526),GetVehicleName(604),GetVehicleName(446),GetVehicleName(492),GetVehicleName(474),GetVehicleName(546),GetVehicleName(517));
                ShowPlayerDialog(playerid,SALOONSP1,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==1)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nbackpage",GetVehicleName(410),GetVehicleName(551),GetVehicleName(516),GetVehicleName(467),GetVehicleName(426),GetVehicleName(436),GetVehicleName(547),GetVehicleName(405),GetVehicleName(580),GetVehicleName(560),GetVehicleName(550),GetVehicleName(549),GetVehicleName(540),GetVehicleName(491),GetVehicleName(529),GetVehicleName(421));
			    ShowPlayerDialog(playerid,SALOONSP2,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == SALOONSP1)
	{
        if(response)
		{
		    new string[1024];
            //445 504 401 518 527 542 507 562 585 419 526 604 446 492 474 546 517 nextpage
            if(listitem ==0)
			{
				AddCar(playerid,445);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,504);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,401);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,518);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,527);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,542);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,507);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,562);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,585);
			}
			else if(listitem ==9)
			{
				AddCar(playerid,419);
			}
			else if(listitem ==10)
			{
				AddCar(playerid,526);
			}
			else if(listitem ==11)
			{
				AddCar(playerid,604);
			}
			else if(listitem ==12)
			{
				AddCar(playerid,446);
			}
			else if(listitem ==13)
			{
				AddCar(playerid,492);
			}
			else if(listitem ==14)
			{
				AddCar(playerid,474);
			}
			else if(listitem ==15)
			{
				AddCar(playerid,546);
			}
            else if(listitem ==16)
			{
				AddCar(playerid,517);
			}
			else if(listitem ==17)
			{
   				format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nbackpage",GetVehicleName(410),GetVehicleName(551),GetVehicleName(516),GetVehicleName(467),GetVehicleName(426),GetVehicleName(436),GetVehicleName(547),GetVehicleName(405),GetVehicleName(580),GetVehicleName(560),GetVehicleName(550),GetVehicleName(549),GetVehicleName(540),GetVehicleName(491),GetVehicleName(529),GetVehicleName(421));
			    ShowPlayerDialog(playerid,SALOONSP2,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,SALOONS,DIALOG_STYLE_LIST,"Cars","page1\npage2","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == SALOONSP2)
	{
		if(response)
		{
			new string[1024];
            //410 551 516 467 426 436 547 405 580 560 550 549 540 491 529 421 backpage
            if(listitem ==0)
			{
				AddCar(playerid,410);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,551);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,516);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,467);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,426);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,436);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,547);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,405);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,580);
			}
			else if(listitem ==9)
			{
				AddCar(playerid,560);
			}
			else if(listitem ==10)
			{
				AddCar(playerid,550);
			}
			else if(listitem ==11)
			{
				AddCar(playerid,549);
			}
			else if(listitem ==12)
			{
				AddCar(playerid,540);
			}
			else if(listitem ==13)
			{
				AddCar(playerid,491);
			}
			else if(listitem ==14)
			{
				AddCar(playerid,529);
			}
			else if(listitem ==15)
			{
				AddCar(playerid,421);
			}
            else if(listitem ==16)
			{
   				format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage",GetVehicleName(445),GetVehicleName(504),GetVehicleName(401),GetVehicleName(518),GetVehicleName(527),GetVehicleName(542),GetVehicleName(507),GetVehicleName(562),GetVehicleName(585),GetVehicleName(419),GetVehicleName(526),GetVehicleName(604),GetVehicleName(446),GetVehicleName(492),GetVehicleName(474),GetVehicleName(546),GetVehicleName(517));
                ShowPlayerDialog(playerid,SALOONSP1,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
            ShowPlayerDialog(playerid,SALOONS,DIALOG_STYLE_LIST,"Cars","page1\npage2","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == SPORTSCARS)
	{
		if(response)
		{
		    new string [1024];
			if(listitem == 0)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage",GetVehicleName(602),GetVehicleName(429),GetVehicleName(496),GetVehicleName(402),GetVehicleName(541),GetVehicleName(415),GetVehicleName(589),GetVehicleName(587),GetVehicleName(565),GetVehicleName(494));
				ShowPlayerDialog(playerid,SPORTSCARSP1,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==1)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nbackpage",GetVehicleName(502),GetVehicleName(503),GetVehicleName(411),GetVehicleName(559),GetVehicleName(603),GetVehicleName(475),GetVehicleName(506),GetVehicleName(451),GetVehicleName(558),GetVehicleName(477));
			    ShowPlayerDialog(playerid,SPORTSCARSP2,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == SPORTSCARSP1)
	{
		if(response)
		{
		    new string[1024];
		    //602 429 496 402 541 415 589 587 565 494 nextpage
		    if(listitem ==0)
			{
				AddCar(playerid,602);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,429);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,496);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,402);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,541);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,415);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,589);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,587);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,565);
			}
			else if(listitem ==9)
			{
				AddCar(playerid,494);
			}
			else if(listitem ==10)
			{
   				format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nbackpage",GetVehicleName(502),GetVehicleName(503),GetVehicleName(411),GetVehicleName(559),GetVehicleName(603),GetVehicleName(475),GetVehicleName(506),GetVehicleName(451),GetVehicleName(558),GetVehicleName(477));
			    ShowPlayerDialog(playerid,SPORTSCARSP2,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,SPORTSCARS,DIALOG_STYLE_LIST,"Cars","page1\npage2","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == SPORTSCARSP2)
	{
		if(response)
		{
		    new string[1024];
            //502 503 411 559 603 475 506 451 558 477 backpage
            if(listitem ==0)
			{
				AddCar(playerid,502);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,503);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,411);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,559);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,603);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,475);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,506);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,451);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,558);
			}
			else if(listitem ==9)
			{
				AddCar(playerid,477);
			}
			else if(listitem ==10)
			{
   				format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage",GetVehicleName(602),GetVehicleName(429),GetVehicleName(496),GetVehicleName(402),GetVehicleName(541),GetVehicleName(415),GetVehicleName(589),GetVehicleName(587),GetVehicleName(565),GetVehicleName(494));
				ShowPlayerDialog(playerid,SPORTSCARSP1,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,SPORTSCARS,DIALOG_STYLE_LIST,"Cars","page1\npage2","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == STATIONWAGONS)
	{
		if(response)
		{
            //418 404 479 458 561
            if(listitem ==0)
			{
				AddCar(playerid,418);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,404);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,479);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,458);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,561);
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == BOATS)
	{
		if(response)
		{
            //472 473 493 595 484 430 453 452 446 454
            if(listitem ==0)
			{
				AddCar(playerid,472);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,473);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,493);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,595);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,484);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,430);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,453);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,452);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,446);
			}
			else if(listitem ==9)
			{
				AddCar(playerid,454);
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == OTHERS)
	{
		if(response)
		{
		    new string[1024];
			if(listitem == 0)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage",GetVehicleName(508),GetVehicleName(525),GetVehicleName(530),GetVehicleName(532),GetVehicleName(545),GetVehicleName(571),GetVehicleName(572),GetVehicleName(583),GetVehicleName(574),GetVehicleName(588));
			    ShowPlayerDialog(playerid,OTHERSP1,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==2)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage\nbackpage",GetVehicleName(406),GetVehicleName(409),GetVehicleName(423),GetVehicleName(428),GetVehicleName(434),GetVehicleName(442),GetVehicleName(457),GetVehicleName(483),GetVehicleName(485),GetVehicleName(486));
			    ShowPlayerDialog(playerid,OTHERSP2,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==3)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage\nbackpage",GetVehicleName(569),GetVehicleName(570),GetVehicleName(584),GetVehicleName(590),GetVehicleName(591),GetVehicleName(594),GetVehicleName(606),GetVehicleName(607),GetVehicleName(608),GetVehicleName(610),GetVehicleName(611));
			    ShowPlayerDialog(playerid,OTHERSP3,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==4)
			{
			    format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage\nbackpage",GetVehicleName(435),GetVehicleName(441),GetVehicleName(449),GetVehicleName(450),GetVehicleName(464),GetVehicleName(465),GetVehicleName(501),GetVehicleName(537),GetVehicleName(538),GetVehicleName(539),GetVehicleName(564));
			    ShowPlayerDialog(playerid,OTHERSP4,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
      		ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		return 1;
	}
	else if(dialogid == OTHERSP1)
	{
	    if(response)
		{
		    new string[1024];
		    //508 525 530 532 545 571 572 583 574 588 nextpage
		    if(listitem ==0)
			{
				AddCar(playerid,508);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,525);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,530);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,532);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,545);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,571);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,572);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,583);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,574);
			}
			else if(listitem ==9)
			{
				AddCar(playerid,588);
			}
			else if(listitem ==10)
			{
			    format(string,sizeof(string), "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage\nbackpage",GetVehicleName(406),GetVehicleName(409),GetVehicleName(423),GetVehicleName(428),GetVehicleName(434),GetVehicleName(442),GetVehicleName(457),GetVehicleName(483),GetVehicleName(485),GetVehicleName(486));
			    ShowPlayerDialog(playerid,OTHERSP2,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,OTHERS,DIALOG_STYLE_LIST,"Cars","page1\npage2\npage3\npage4","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == OTHERSP2)
	{
        if(response)
		{
			new string[1024];
            //406 409 423 428 434 442 457 483 485 486 nextpage backpage
            if(listitem ==0)
			{
				AddCar(playerid,406);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,409);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,423);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,428);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,434);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,442);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,457);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,483);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,485);
			}
			else if(listitem ==9)
			{
    			AddCar(playerid,486);
			}
			else if(listitem ==10)
			{
   				format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage\nbackpage",GetVehicleName(569),GetVehicleName(570),GetVehicleName(584),GetVehicleName(590),GetVehicleName(591),GetVehicleName(594),GetVehicleName(606),GetVehicleName(607),GetVehicleName(608),GetVehicleName(610),GetVehicleName(611));
			    ShowPlayerDialog(playerid,OTHERSP3,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==11)
			{
   				format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage",GetVehicleName(508),GetVehicleName(525),GetVehicleName(530),GetVehicleName(532),GetVehicleName(545),GetVehicleName(571),GetVehicleName(572),GetVehicleName(583),GetVehicleName(574),GetVehicleName(588));
			    ShowPlayerDialog(playerid,OTHERSP1,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,OTHERS,DIALOG_STYLE_LIST,"Cars","page1\npage2\npage3\npage4","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == OTHERSP3)
	{
	    if(response)
		{
		    new string[1024];
		    //569 570 584 590 591 594 606 607 608 610 611 nextpage backpage
   			if(listitem ==0)
			{
				AddCar(playerid,569);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,570);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,584);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,590);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,591);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,594);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,606);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,607);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,608);
			}
			else if(listitem ==9)
			{
				AddCar(playerid,610);
			}
			else if(listitem ==10)
			{
				AddCar(playerid,611);
			}
			else if(listitem ==11)
			{
				format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage\nbackpage",GetVehicleName(435),GetVehicleName(441),GetVehicleName(449),GetVehicleName(450),GetVehicleName(464),GetVehicleName(465),GetVehicleName(501),GetVehicleName(537),GetVehicleName(538),GetVehicleName(539),GetVehicleName(564));
		    	ShowPlayerDialog(playerid,OTHERSP4,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
			else if(listitem ==12)
			{
				format(string,sizeof(string), "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage\nbackpage",GetVehicleName(406),GetVehicleName(409),GetVehicleName(423),GetVehicleName(428),GetVehicleName(434),GetVehicleName(442),GetVehicleName(457),GetVehicleName(483),GetVehicleName(485),GetVehicleName(486));
		    	ShowPlayerDialog(playerid,OTHERSP2,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,OTHERS,DIALOG_STYLE_LIST,"Cars","page1\npage2\npage3\npage4","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == OTHERSP4)
	{
	    if(response)
		{
		    new string[1024];
            //435 441 449 450 464 465 501 537 538 539 564 backpage
            if(listitem ==0)
			{
				AddCar(playerid,435);
			}
			else if(listitem ==1)
			{
				AddCar(playerid,441);
			}
			else if(listitem ==2)
			{
				AddCar(playerid,449);
			}
			else if(listitem ==3)
			{
				AddCar(playerid,450);
			}
			else if(listitem ==4)
			{
				AddCar(playerid,464);
			}
			else if(listitem ==5)
			{
				AddCar(playerid,465);
			}
			else if(listitem ==6)
			{
				AddCar(playerid,501);
			}
			else if(listitem ==7)
			{
				AddCar(playerid,537);
			}
			else if(listitem ==8)
			{
				AddCar(playerid,538);
			}
			else if(listitem ==9)
			{
				AddCar(playerid,539);
			}
			else if(listitem ==10)
			{
				AddCar(playerid,564);
			}
			else if(listitem ==11)
			{
				format(string,sizeof(string),"%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\nnextpage\nbackpage",GetVehicleName(569),GetVehicleName(570),GetVehicleName(584),GetVehicleName(590),GetVehicleName(591),GetVehicleName(594),GetVehicleName(606),GetVehicleName(607),GetVehicleName(608),GetVehicleName(610),GetVehicleName(611));
		    	ShowPlayerDialog(playerid,OTHERSP3,DIALOG_STYLE_LIST,"Cars",string,"Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,OTHERS,DIALOG_STYLE_LIST,"Cars","page1\npage2\npage3\npage4","Ok","Back");
		}
		return 1;
	}
	else if(dialogid == OTHERSCANTSELL)
	{
	    if(response)
		{
            ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
		}
		else
		{
			SendClientMessage(playerid, RED, "request canceled");
			addvstate[playerid] = 0;
   			choicecolor1[playerid] = 0;
			choicecolor2[playerid] = 0;
			choiceid[playerid] = 0;
		}
		return 1;
	}
	else if(dialogid == GASSTATIONNAMEINPUT)
	{
	    if(response)
	    {
	        new string[256];
			format(gasstationname[editobjgasstation[playerid]],sizeof(gasstationname),"%s",inputtext);
			format(string,sizeof(string),"%s\ngasstationID:%i\n%s\nyou have %f gas",gasstationname[editobjgasstation[playerid]],editobjgasstation[playerid],GasStationOwner(editobjgasstation[playerid]),TotalGasInGasStation(editobjgasstation[playerid]));
			Update3DTextLabelText(gasstationlabel[editobjgasstation[playerid]],YELLOW,string);
			SaveQuickGasStationData(editobjgasstation[playerid]);
			ShowPlayerDialog(playerid,GASSTATIONBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Name changed","You have change the name of your gas station","Back","Close");
	    }
	    else
	    {
	    	ShowPlayerDialog(playerid,GASSTATIONMENU,DIALOG_STYLE_LIST,"Gas station menu",GASSTATIONMENUSTATEMENT,"Ok","Cancel");
	    }
	    return 1;
	}
	else if(dialogid == GASSTATIONBACK&CANCEL)
	{
	    if(response)
	    {
	        ShowPlayerDialog(playerid,GASSTATIONMENU,DIALOG_STYLE_LIST,"Gas station menu",GASSTATIONMENUSTATEMENT,"Ok","Cancel");
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "Dialog boxes closed");
	    }
	    return 1;
	}
	else if(dialogid == REMOVECASHGASSTATION)
	{
 		if(response)
	    {
            if(IsNumeric(inputtext))
            {
                new input = strval(inputtext);
                if((gasstationcash[editobjgasstation[playerid]])>=input)
                {
                    new string[256];
                    gasstationcash[editobjgasstation[playerid]] = gasstationcash[editobjgasstation[playerid]] - input;
                    GivePlayerMoney(playerid,input);
					SaveQuickGasStationData(editobjgasstation[playerid]);
					format(string,sizeof(string),"you have withdrawed $%i you now have $%i in you gasstation safe",input,gasstationcash[editobjgasstation[playerid]]);
					SendClientMessage(playerid, LIGHTBLUE,string);
                }
                else
                {
	  		        new str[256];
			        format(str,sizeof(str),"Withdraw-Cash:$%i",gasstationcash[editobjgasstation[playerid]]);
			        ShowPlayerDialog(playerid,REMOVECASHGASSTATION,DIALOG_STYLE_INPUT,str,"ERROR this gasstation does not have this mutch gas, Please enter how mutch cash you want to take out","Ok","Back");
                }
            }
            else
            {
  		        new str[256];
		        format(str,sizeof(str),"Withdraw-Cash:$%i",gasstationcash[editobjgasstation[playerid]]);
		        ShowPlayerDialog(playerid,REMOVECASHGASSTATION,DIALOG_STYLE_INPUT,str,"ERROR not valid number, Please enter how mutch cash you want to take out","Ok","Back");
            }
	    }
	    else
	    {
            ShowPlayerDialog(playerid,GASSTATIONMENU,DIALOG_STYLE_LIST,"Gas station menu",GASSTATIONMENUSTATEMENT,"Ok","Cancel");
	    }
	    return 1;
	}
	else if(dialogid == ADDCASHGASSTATION)
	{
	    if(response)
	    {
            if(IsNumeric(inputtext))
            {
                new input = strval(inputtext);
				new cash = GetPlayerMoney(playerid);
				if((cash)>=input)
				{
				    new string[256];
					GivePlayerMoney(playerid,-input);
					gasstationcash[editobjgasstation[playerid]] = gasstationcash[editobjgasstation[playerid]] + input;
					format(string,sizeof(string),"you have deposit $%i you have $%i in your gasstation safe",input,gasstationcash[editobjgasstation[playerid]]);
					SaveQuickGasStationData(editobjgasstation[playerid]);
					SendClientMessage(playerid, LIGHTBLUE,string);
				}
				else
				{
 					new str[256];
		        	format(str,sizeof(str),"Deposit-Cash:$%i",gasstationcash[editobjgasstation[playerid]]);
				    ShowPlayerDialog(playerid,ADDCASHGASSTATION,DIALOG_STYLE_INPUT,str,"ERROR You don't have that mutch cash, Please enter how mutch cash you would like to deposit","Ok","Back");
				}
            }
            else
            {
    			new str[256];
		        format(str,sizeof(str),"Deposit-Cash:$%i",gasstationcash[editobjgasstation[playerid]]);
                ShowPlayerDialog(playerid,ADDCASHGASSTATION,DIALOG_STYLE_INPUT,str,"ERROR not a valid number, Please enter how mutch cash you would like to deposit","Ok","Back");
            }
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,GASSTATIONMENU,DIALOG_STYLE_LIST,"Gas station menu",GASSTATIONMENUSTATEMENT,"Ok","Cancel");
	    }
	    return 1;
	}
	else if(dialogid == BUYGAS)
	{
	    if(response)
	    {
		  	ammountofgasneeded[editobjgasstation[playerid]] = floatstr(inputtext);
			GasStationCapacity(editobjgasstation[playerid]);
			new Float:tgas = gasstationtotalcapacity[editobjgasstation[playerid]] - TotalGasInGasStation(editobjgasstation[playerid]);
			if((ammountofgasneeded[editobjgasstation[playerid]]) <= tgas)
			{
			    gasstationbuygascost[editobjgasstation[playerid]] = REFINERYSELLCOST * floatround(ammountofgasneeded[editobjgasstation[playerid]]);
			    new truckerpayment = floatround(gasstationbuygascost[editobjgasstation[playerid]] * PRECENTAGEOFFPAYMENT);
			    gasstationbuygascost[editobjgasstation[playerid]] = gasstationbuygascost[editobjgasstation[playerid]] + truckerpayment;
				if((gasstationbuygascost[editobjgasstation[playerid]]) <= gasstationcash[editobjgasstation[playerid]])
				{
				    gasstationcash[editobjgasstation[playerid]] = gasstationcash[editobjgasstation[playerid]] - gasstationbuygascost[editobjgasstation[playerid]];
				    gasstationneedgasstate[editobjgasstation[playerid]] = 1;
				    GasStationAddSlot(editobjgasstation[playerid]);
					new str[256];
					format(str,sizeof(str),"You have bought %fL for $%i you can view this information in the menu or you can cancel your order",ammountofgasneeded[editobjgasstation[playerid]],gasstationbuygascost[editobjgasstation[playerid]]);
					SendClientMessage(playerid,LIGHTBLUE,str);
					SaveQuickGasStationData(editobjgasstation[playerid]);
				}
				else
				{
					new str[256];
				    format(str,sizeof(str),"You want to buy %f ammount of gas, you only has $%i in you gasstation safe you need $%i. Please enter how mutch gas you want to buy",ammountofgasneeded[editobjgasstation[playerid]],gasstationcash[editobjgasstation[playerid]],gasstationbuygascost[editobjgasstation[playerid]]);
					ammountofgasneeded[editobjgasstation[playerid]] = 0;
				    gasstationneedgasstate[editobjgasstation[playerid]] = 0;
				    GasStationRemoveSlot(editobjgasstation[playerid]);
				    SaveQuickGasStationData(editobjgasstation[playerid]);
				    ShowPlayerDialog(playerid,BUYGAS,DIALOG_STYLE_INPUT,"Buy Gas",str,"Ok","Back");
				}
			}
			else
			{
			    new str[256];
			    format(str,sizeof(str),"You want to buy %f ammount of gas, you only have %f capacity left. Please enter how mutch gas you want to buy",ammountofgasneeded[editobjgasstation[playerid]],tgas);
				ammountofgasneeded[editobjgasstation[playerid]] = 0;
			    gasstationneedgasstate[editobjgasstation[playerid]] = 0;
			    GasStationRemoveSlot(editobjgasstation[playerid]);
			    SaveQuickGasStationData(editobjgasstation[playerid]);
			    ShowPlayerDialog(playerid,BUYGAS,DIALOG_STYLE_INPUT,"Buy Gas",str,"Ok","Back");
			}
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,GASSTATIONMENU,DIALOG_STYLE_LIST,"Gas station menu",GASSTATIONMENUSTATEMENT,"Ok","Cancel");
	    }
	    return 1;
	}
	else if(dialogid == GASSTATIONMENU)
	{
	    if(response)
		{
		    if(listitem == 0)
		    {
		        new str[256];
		        format(str,sizeof(str),"Deposit-Cash:$%i",gasstationcash[editobjgasstation[playerid]]);
                ShowPlayerDialog(playerid,ADDCASHGASSTATION,DIALOG_STYLE_INPUT,str,"Please enter how mutch cash you would like to deposit","Ok","Back");
		    }
		    else if(listitem == 1)
		    {
		        if((gasstationneedgasstate[editobjgasstation[playerid]])==1)
		        {
					gasstationneedgasstate[editobjgasstation[playerid]] = 0;
					ammountofgasneeded[editobjgasstation[playerid]] = 0;
					GasStationRemoveSlot(editobjgasstation[playerid]);
					SaveQuickGasStationData(editobjgasstation[playerid]);
		        	new str[256];
			        format(str,sizeof(str),"Withdraw-Cash:$%i",gasstationcash[editobjgasstation[playerid]]);
			        ShowPlayerDialog(playerid,REMOVECASHGASSTATION,DIALOG_STYLE_INPUT,str,"!NOTE your gas purchase has been cancel becuse you have removed gas from your gasstation, Please enter how mutch cash you want to take out","Ok","Back");
		        }
		        else
		        {
			        new str[256];
			        format(str,sizeof(str),"Withdraw-Cash:$%i",gasstationcash[editobjgasstation[playerid]]);
			        ShowPlayerDialog(playerid,REMOVECASHGASSTATION,DIALOG_STYLE_INPUT,str,"Please enter how mutch cash you want to take out","Ok","Back");
				}
		    }
		    else if(listitem == 2)
		    {
		        if((gasstationneedgasstate[editobjgasstation[playerid]])==0)
		        {
		            ShowPlayerDialog(playerid,BUYGAS,DIALOG_STYLE_INPUT,"Buy Gas","Please enter how mutch gas you want to buy","Ok","Back");
		        }
		        else
		        {
		            ShowPlayerDialog(playerid,GASSTATIONBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Order Error","You can't order more gas you already have an order you can cancel it","Back","Close");
		        }
      		}
			else if(listitem == 3)
			{
		       	new str[256];
		       	format(str,sizeof(str),"Current name:%s",gasstationname[editobjgasstation[playerid]]);
				ShowPlayerDialog(playerid,GASSTATIONNAMEINPUT,DIALOG_STYLE_INPUT,str,"please enter a new name for your gasstation","Ok","Back");
			}
			else if(listitem == 4)
			{
			    new str[256];
			    format(str,sizeof(str),"SalePrice:$%i",gasstationgascost[editobjgasstation[playerid]]);
			    ShowPlayerDialog(playerid,GASSTATIONGASCOST,DIALOG_STYLE_INPUT,str,"Please enter how mutch you want gas to cost per liter","Ok","Back");
			}
			else if(listitem == 5)
			{
				if((gasstationneedgasstate[editobjgasstation[playerid]])==1)
		        {
				    new str[256];
				    new truckerpayment = floatround(gasstationbuygascost[editobjgasstation[playerid]] * PRECENTAGEOFFPAYMENT);
				    gasstationbuygascost[editobjgasstation[playerid]] = gasstationbuygascost[editobjgasstation[playerid]] - truckerpayment;
				    format(str,sizeof(str),"you have canceled buying gas and recived a full refund $%i for %fL",gasstationbuygascost[editobjgasstation[playerid]],ammountofgasneeded[editobjgasstation[playerid]]);
					gasstationneedgasstate[editobjgasstation[playerid]] = 0;
					ammountofgasneeded[editobjgasstation[playerid]] = 0.0;
					gasstationcash[editobjgasstation[playerid]] = gasstationcash[editobjgasstation[playerid]] - gasstationbuygascost[editobjgasstation[playerid]];
					gasstationbuygascost[editobjgasstation[playerid]] = 0;
					GasStationRemoveSlot(editobjgasstation[playerid]);
					SaveQuickGasStationData(editobjgasstation[playerid]);
					ShowPlayerDialog(playerid,GASSTATIONBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Cancel",str,"Back","Close");
				}
				else
				{
				    ShowPlayerDialog(playerid,GASSTATIONBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Cancel","ERROR You don't have any gas orders to cancel","Back","Close");
				}
			}
			else if(listitem == 6)
			{
				new str[256];
				if((gasstationneedgasstate[editobjgasstation[playerid]])==1)
				{
					format(str,sizeof(str),"You currently has an order for %fL of gas for $%i",ammountofgasneeded[editobjgasstation[playerid]],gasstationbuygascost[editobjgasstation[playerid]]);
				}
				else
				{
				    format(str,sizeof(str),"You Currently don't have an order for gas");
				}
				ShowPlayerDialog(playerid,GASSTATIONBACK&CANCEL,DIALOG_STYLE_MSGBOX,"CurrentPurchase",str,"Back","Close");
			}
		}
		else
		{
		    SendClientMessage(playerid, RED, "Dialog boxes closed");
		}
		return 1;
	}
	else if(dialogid == REFINERYSELLSTATE)
	{
	    if(response)
	    {
	        if((refinerysellstate[editobjrefinery[playerid]])==0)
	        {
	        	if((refinerytrailerstate[editobjrefinery[playerid]])==0)
			    {
			    	return ShowPlayerDialog(playerid,REFINERYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"ERROR","There is no trailer position attached to your current refinery please contact and admin","Close","Back");
        		}
	            refinerysellstate[editobjrefinery[playerid]] = 1;
	            SaveQuickRefineryData(editobjrefinery[playerid]);
	            editobjrefinery[playerid] = 0;
	            SendClientMessage(playerid,LIGHTBLUE,"You have enabled selling");
	        }
	        else
	        {
	            ShowPlayerDialog(playerid,REFINERYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Error","the refinery is already selling gas","Back","Close");
	        }
	    }
	    else
	    {
	        if((refinerysellstate[editobjrefinery[playerid]])==1)
	        {
         		refinerysellstate[editobjrefinery[playerid]] = 0;
         		SaveQuickRefineryData(editobjrefinery[playerid]);
         		editobjrefinery[playerid] = 0;
         		SendClientMessage(playerid,RED,"You have disabled selling");
	        }
	        else
	        {
	            ShowPlayerDialog(playerid,REFINERYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Error","the refinery is already not selling gas","Back","Close");
	        }
	    }
	    return 1;
	}
	else if(dialogid == REFINERYONOFF)
	{
	    if(response)
    	{
			if((refineryproductionstate[editobjrefinery[playerid]])==0)
			{
			    if(IsThereAnyOilPumps(editobjrefinery[playerid]))
			    {
				    refineryproductionstate[editobjrefinery[playerid]] = 1;
				    for(new count;count < MAX_OILPUMPS;count++)
				    {
				        if((oilstoragestate[count][editobjrefinery[playerid]])==1)
				        {
	  						new string[256];
							format(string,sizeof(string),"ID:%i-%i\n This fuelstorage is owned by %s\nThere is currently %fL out of %f fuel in hear\ncurrentstate:%s",count,editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],oilstoragefuel[count][editobjrefinery[playerid]],MAX_OILSTORAGE,RefineryProductionState(editobjrefinery[playerid]));
							Update3DTextLabelText(oilstoragelabel[count][editobjrefinery[playerid]],YELLOW,string);
				        }
				        if((oilpumpstate[count][editobjrefinery[playerid]])==1)
				        {
	   		    			new string[256];
							format(string,sizeof(string),"OilpumpID:%i-%i,owner:%s,state:%s",count,editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],RefineryProductionState(editobjrefinery[playerid]));
							Update3DTextLabelText(oilpumplabel[count][editobjrefinery[playerid]],YELLOW,string);
				        }
				    }
				    new string[256];
					format(string,sizeof(string),"Refinery:%i\nRefinery state:%s\n%s\nthere is a total of %f fuel",editobjrefinery[playerid],RefineryProductionState(editobjrefinery[playerid]),RefineryOwner(editobjrefinery[playerid]),TotalOil(editobjrefinery[playerid]));
					Update3DTextLabelText(refinerylabel[editobjrefinery[playerid]],YELLOW,string);
				    refineryproductiontimer[editobjrefinery[playerid]] = SetTimerEx("RefineryOilProduction",1000,true,"i",editobjrefinery[playerid]);
				    editobjrefinery[playerid] = 0;
				    SaveQuickRefineryData(editobjrefinery[playerid]);
				}
				else
				{
				    ShowPlayerDialog(playerid,REFINERYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"There is a problem","You have no oil pumps you can't pump oil","Back","Close");
				}
			}
			else
			{
				ShowPlayerDialog(playerid,REFINERYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Error","the refinery is alread produceing oil","Back","Close");
			}
	    }
	    else
	    {
			if((refineryproductionstate[editobjrefinery[playerid]])!=0)
			{
			    for(new count;count < MAX_OILPUMPS;count++)
			    {
			    	refineryproductionstate[editobjrefinery[playerid]] = 0;
			    	editobjrefinery[playerid] = 0;
					if((oilstoragestate[count][editobjrefinery[playerid]])==1)
				    {
	  					new string[256];
						format(string,sizeof(string),"ID:%i-%i\n This fuelstorage is owned by %s\nThere is currently %fL out of %f fuel in hear\ncurrentstate:%s",count,editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],oilstoragefuel[count][editobjrefinery[playerid]],MAX_OILSTORAGE,RefineryProductionState(editobjrefinery[playerid]));
						Update3DTextLabelText(oilstoragelabel[count][editobjrefinery[playerid]],YELLOW,string);
      				}
				    if((oilpumpstate[count][editobjrefinery[playerid]])==1)
					{
	   		    		new string[256];
						format(string,sizeof(string),"OilpumpID:%i-%i,owner:%s,state:%s",count,editobjrefinery[playerid],refineryownername[editobjrefinery[playerid]],RefineryProductionState(editobjrefinery[playerid]));
						Update3DTextLabelText(oilpumplabel[count][editobjrefinery[playerid]],YELLOW,string);
				    }
    			}
				new string[256];
				format(string,sizeof(string),"Refinery:%i\nRefinery state:%s\n%s\nthere is a total of %f fuel",editobjrefinery[playerid],RefineryProductionState(editobjrefinery[playerid]),RefineryOwner(editobjrefinery[playerid]),TotalOil(editobjrefinery[playerid]));
				Update3DTextLabelText(refinerylabel[editobjrefinery[playerid]],YELLOW,string);
                SaveQuickRefineryData(editobjrefinery[playerid]);
			}
			else
			{
			    ShowPlayerDialog(playerid,REFINERYBACK &CANCEL,DIALOG_STYLE_MSGBOX,"Error","the refinery has alread stoped produceing oil","Back","Close");
			}
	    }
	    return 1;
	}
	else if(dialogid == REFINERYBACK&CANCEL)
	{
	    if(response)
	    {
	        ShowPlayerDialog(playerid,REFINERYMENU,DIALOG_STYLE_LIST,"Refinery menu",REFINERYMENUSTATEMENT,"Ok","Close");
	    }
	    else
	    {
	        editobjrefinery[playerid] = 0;
	        SendClientMessage(playerid, RED, "You have closed the dialog boxes");
	    }
		return 1;
	}
	else if(dialogid == REFINERYMENU)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
				new string[256];
				format(string,sizeof(string),"Depositcash:currentcash:%i",refinerycash[editobjrefinery[playerid]]);
	            ShowPlayerDialog(playerid,ADDCASHINPUT,DIALOG_STYLE_INPUT,string,"please enter how mutch cash you want to deposit","Ok","Back");
	        }
			if(listitem == 1)
			{
				new string[256];
				format(string,sizeof(string),"Withdraw:currentcash:%i",refinerycash[editobjrefinery[playerid]]);
			    ShowPlayerDialog(playerid,TAKECASHINPUT,DIALOG_STYLE_INPUT,string,"please enter how mutch cash you want to take out","Ok","Back");
			}
			if(listitem == 2)
			{
			    new string[256];
			    format(string,sizeof(string),"you currently have %i in your refinery deposit",refinerycash[editobjrefinery[playerid]]);
				ShowPlayerDialog(playerid,REFINERYBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Currentcash",string,"Back","Close");
			}
			if(listitem == 3)
			{
			    ShowPlayerDialog(playerid,REFINERYONOFF,DIALOG_STYLE_MSGBOX,"OilProductionState","Would you like to turn off or on the production","On","Off");
			}
			if(listitem == 4)
			{
			    ShowPlayerDialog(playerid,REFINERYSELLSTATE,DIALOG_STYLE_MSGBOX,"OilSellState","Would you like to turn off or on the selling of selling","On","Off");
			}
			/*if(listitem == 5)//#4
			{
			    new str[128];
			    format(str,sizeof(str),"Balance:$%f",refinerydebt[editobjrefinery[playerid]]);
			    ShowPlayerDialog(playerid,REFINERYPAYBACK,DIALOG_STYLE_MSGBOX,str,"Would you like to pay it back","Yes","No");
			}*/
	    }
	    else
	    {
	        editobjrefinery[playerid] = 0;
	        SendClientMessage(playerid, RED, "You have close the dialog box");
	    }
	    return 1;
	}
	else if(dialogid == TAKECASHINPUT)
	{
	    if(response)
	    {
	        if(IsNumeric(inputtext))
            {
                new ammount = strval(inputtext);
                new string[128];
                if((ammount)<=refinerycash[editobjrefinery[playerid]])
                {
                    GivePlayerMoney(playerid,ammount);
                    refinerycash[editobjrefinery[playerid]] = refinerycash[editobjrefinery[playerid]] - ammount;
                    format(string,sizeof(string),"you took out $%i from your refinery deposit,you now have $%i in your refinery deposit",ammount,refinerycash[editobjrefinery[playerid]]);
					SendClientMessage(playerid, LIGHTBLUE, string);
                    SaveQuickRefineryData(editobjrefinery[playerid]);
                    editobjrefinery[playerid] = 0;
                }
                else
                {
                    ShowPlayerDialog(playerid,TAKECASHINPUT,DIALOG_STYLE_INPUT,"Error:Input","!You enter a number to high , please enter how mutch cash you want to take out","Ok","Back");
                }
            }
            else
            {
                ShowPlayerDialog(playerid,TAKECASHINPUT,DIALOG_STYLE_INPUT,"Error:Input","!you did not enter a valid number, please enter how mutch cash you want to take out","Ok","Back");
            }
	    }
	    else
	    {
            ShowPlayerDialog(playerid,REFINERYMENU,DIALOG_STYLE_LIST,"Refinery menu",REFINERYMENUSTATEMENT,"Ok","Close");
	    }
	    return 1;
	}
	else if(dialogid == ADDCASHINPUT)
	{
		if(response)
		{
            if(IsNumeric(inputtext))
            {
				new value = strval(inputtext);
				new money = GetPlayerMoney(playerid);
				new string[128];
				if((money)>=value)
				{
				    GivePlayerMoney(playerid,-value);
				    refinerycash[editobjrefinery[playerid]] = refinerycash[editobjrefinery[playerid]] + value;
				    format(string,sizeof(string),"you deposit $%i in you refinery deposit, you now have $%i in your deposit",value,refinerycash[editobjrefinery[playerid]]);
				    SaveQuickRefineryData(editobjrefinery[playerid]);
				    SendClientMessage(playerid, LIGHTBLUE,string);
				    editobjrefinery[playerid] = 0;
				}
				else
				{
				    ShowPlayerDialog(playerid,ADDCASHINPUT,DIALOG_STYLE_INPUT,"Error:Input","!You have selected a to high ammount of cash, please enter how mutch cash you want to deposit","Ok","Back");
				}
            }
            else
			{
			    ShowPlayerDialog(playerid,ADDCASHINPUT,DIALOG_STYLE_INPUT,"Error:Input","!You did not enter a number, please enter how mutch cash you want to deposit","Ok","Back");
			}
		}
		else
		{
		    ShowPlayerDialog(playerid,REFINERYMENU,DIALOG_STYLE_LIST,"Refinery menu",REFINERYMENUSTATEMENT,"Ok","Close");
		}
		return 1;
	}
	return 0;
}
//****************************************Of**Command**Help*****************************************
CMD:jbcarhelp(playerid, params[])//Working
{
	SendClientMessage(playerid, LIGHTBLUE, "/repairshophelp/factoryhelp/purchasehelp/dealershiphelp/carhelp");
	SendClientMessage(playerid, LIGHTBLUE, "/gasstationhelp/refineryhelp/disposerhelp/blockhelp");
	//:/grouphelp & /dmvhelp was remove //#4
	return 1;
}
CMD:blockhelp(playerid, params[])//Working
{
	SendClientMessage(playerid,LIGHTBLUE,"-----------------------/jbcarshelp to display the main menu--------------------------------");
	SendClientMessage(playerid,LIGHTBLUE,"/placespike/destroyspike/movespike/checkspike/placeroadblock/destroyroadblock/checkroadblock");
	SendClientMessage(playerid,LIGHTBLUE,"/placebarrel/destroybarrel/movebarrel/checkbarrel");
    if(IsPlayerAdmince(playerid, 1))
    {
        SendClientMessage(playerid, PINK, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Admin Commands~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        SendClientMessage(playerid, PINK, "/allowplaceingblocks/unallowplaceingblocks");
    }
	return 1;
}
/*CMD:dmvhelp(playerid, params[])//#4
{
	SendClientMessage(playerid,LIGHTBLUE,"-----------------------/jbcarshelp to display the main menu--------------------------------");
    if(IsPlayerAdmince(playerid, 1))
    {
        SendClientMessage(playerid, PINK,"/createdmv/deletedmv");
    }
    else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}*/
CMD:disposerhelp(playerid, params[])//Working
{
	SendClientMessage(playerid,LIGHTBLUE,"-----------------------/jbcarshelp to display the main menu--------------------------------");
	if(IsPlayerAdmince(playerid, 1))
    {
        SendClientMessage(playerid, PINK,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Admin Commands~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        SendClientMessage(playerid, PINK,"/createvehicledisposer/deletevehicledisposer");
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:repairshophelp(playerid, params[])//Working
{
	SendClientMessage(playerid,LIGHTBLUE,"-----------------------/jbcarshelp to display the main menu--------------------------------");
	if(IsPlayerAdmince(playerid, 1))
    {
        SendClientMessage(playerid, PINK,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Admin Commands~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        SendClientMessage(playerid, PINK, "Repairshop -- /createrepairgarage/deleterepairgarage/gotorepairshop/repaircar/setvehiclerepaircost");
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:factoryhelp(playerid, params[])//Working
{
	SendClientMessage(playerid,LIGHTBLUE,"-----------------------/jbcarshelp to display the main menu--------------------------------");
    SendClientMessage(playerid, LIGHTBLUE, "factory -- /buyfactory/sellfactory/factorymenu/delivercars/sellmyfactoryto");
    if(IsPlayerAdmince(playerid, 1))
    {
        SendClientMessage(playerid, PINK,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Admin Commands~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        SendClientMessage(playerid, PINK,"/createfactory/deletefactory/gotofactory/movefactory");
	}
	return 1;
}
CMD:purchasehelp(playerid, params[])//Working
{
	SendClientMessage(playerid,LIGHTBLUE,"-----------------------/jbcarshelp to display the main menu--------------------------------");
    SendClientMessage(playerid, LIGHTBLUE, "Purchase -- /sellmygasstationto/sellmyrefineryto/sellmydealershipto/sellmycar");
    SendClientMessage(playerid, LIGHTBLUE, "/acceptdealership/acceptgasstation/acceptrefinery/buycar");
    if(IsPlayerAdmince(playerid, 1))
    {
        SendClientMessage(playerid, PINK,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Admin Commands~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	}
	return 1;
}
CMD:dealershiphelp(playerid, params[])//Working
{
	SendClientMessage(playerid,LIGHTBLUE,"-----------------------/jbcarshelp to display the main menu--------------------------------");
    SendClientMessage(playerid, LIGHTBLUE, "Dealership -- /buydealership/selldealership/dealershipmenu/addcar/removecar/cancelcardelivery/addmycarto/disposecar");
    if(IsPlayerAdmince(playerid, 1))
    {
        SendClientMessage(playerid, PINK,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Admin Commands~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        SendClientMessage(playerid, PINK,"/createdealership/deletedealership/movedealership/gotodealership");
	}
	return 1;
}
CMD:carhelp(playerid, params[])//Working
{
	SendClientMessage(playerid,LIGHTBLUE,"-----------------------/jbcarshelp to display the main menu--------------------------------");
    SendClientMessage(playerid, LIGHTBLUE, "CarHelp -- /engine/lights/hood/trunk/car/carnum/speedo/refuel/park/vcheck/setvehiclecolor/setvehicleprice/removemod");
    if(IsPlayerAdmince(playerid, 1))
    {
        SendClientMessage(playerid, PINK,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Admin Commands~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        SendClientMessage(playerid, PINK,"/restrictcar/gotocar/carspawn/putincar/setfuel/setvehiclemakeprice/setvehiclebuildspeed");
        SendClientMessage(playerid, PINK, "/resetallcars/setvehicleelockprice/setvehicleslockprice");
	}
	return 1;
}
CMD:gasstationhelp(playerid, params[])//Working
{
	SendClientMessage(playerid,LIGHTBLUE,"-----------------------/jbcarshelp to display the main menu--------------------------------");
    SendClientMessage(playerid, LIGHTBLUE, "GasStation -- /buygasstation/buygaspump/sellgaspump/sellgasstation/movegaspump/sellmygasstationto");
    if(IsPlayerAdmince(playerid, 1))
    {
        SendClientMessage(playerid, PINK,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Admin Commands~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        SendClientMessage(playerid, PINK,"/destroygasstation/creategasstation/setcostofgaspump/admingaspumpmove/movegasstation/gotogasstation");
	}
	return 1;
}
CMD:refineryhelp(playerid, params[])//Working
{
	SendClientMessage(playerid,LIGHTBLUE,"-----------------------/jbcarshelp to display the main menu--------------------------------");
	SendClientMessage(playerid, LIGHTBLUE, "refinery -- /buyoilpump/selloilpump/buyoilstorage/selloilstorage/buyrefinery/sellrefinery/moveoilstorage/moveoilpump/sellmyrefinery");
	SendClientMessage(playerid, LIGHTBLUE, "/refinerymenu/deliverfuel/cancelfueldelivery/buylock/moverepairgarage/viewvehiclecost/removecarfrom");
	if(IsPlayerAdmince(playerid, 1))
    {
        SendClientMessage(playerid, PINK,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Admin Commands~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        SendClientMessage(playerid, PINK,"/createrefinery/deleterefinery/setoilpumpbuildcost/setoilstoragebuildcost/adminoilstoragemove/adminoilpumpmove/setoilpumpedpersec");
        SendClientMessage(playerid, PINK,"/createrefinerypickup/moverefinery/gotorefinery");// /setpowercost has been remove /#4
	}
	return 1;
}
/*CMD:grouphelp(playerid, params[])//#4
{
	SendClientMessage(playerid,LIGHTBLUE,"-----------------------/jbcarshelp to display the main menu--------------------------------");
    SendClientMessage(playerid, LIGHTBLUE, "/groupfreq/groupr/gdonate/gtake/gbalance/acceptinvite/viewlogenterys");
    if(IsPlayerAdmince(playerid, 1))
    {
        SendClientMessage(playerid, PINK,"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Admin Commands~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        SendClientMessage(playerid, PINK,"/uninvite/invite/setgrouppaycheck/removelogentry");
	}
	return 1;
}*/
//**************************************End**Of**Command**Help**************************************
CMD:allowplaceingblocks(playerid, params[])//Working
{
    if(IsPlayerAdmince(playerid, 3))
	{
		new id,string[256];
		if(sscanf(params,"u",id)) return SendClientMessage(playerid,RED, "SYNTAX /allowplaceingblocks [id]");
		if((placeingblocks[id])==0)
		{
			format(string,sizeof(string),"[ADMIN:%s] has allowed %s to add roadblocks spikes and other blocking things",GetPlayerNameReturn(playerid),GetPlayerNameReturn(id));
        	placeingblocks[id] = 1;
        	SendClientMessageToAll(PINK,string);
        	new INI:filedata = INI_Open(playerdatafilename);
        	format(string,sizeof(string),"placeingblocks[%s]",GetPlayerNameReturn(id));
        	INI_WriteInt(filedata,string,placeingblocks[playerid]);
        	INI_Close(filedata);
		}
		else
		{
		    SendClientMessage(playerid,RED,"This player already can add blocks");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:unallowplaceingblocks(playerid, params[])//Working
{
    if(IsPlayerAdmince(playerid, 3))
	{
		new id,string[256];
		if(sscanf(params,"u",id)) return SendClientMessage(playerid,RED, "SYNTAX /unallowplaceingblocks [id]");
		if((placeingblocks[id])==1)
		{
			format(string,sizeof(string),"[ADMIN:%s] has allowed %s to add roadblocks spikes and other blocking things",GetPlayerNameReturn(playerid),GetPlayerNameReturn(id));
        	placeingblocks[id] = 0;
        	SendClientMessageToAll(PINK,string);
        	new INI:filedata = INI_Open(playerdatafilename);
        	format(string,sizeof(string),"placeingblocks[%s]",GetPlayerNameReturn(id));
        	INI_WriteInt(filedata,string,placeingblocks[playerid]);
        	INI_Close(filedata);
		}
		else
		{
		    SendClientMessage(playerid,RED,"This player already can't add blocks");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:placespike(playerid, params[])//Working
{
	if((placeingblocks[playerid])==1)
	{
		for(new count;count < MAX_BLOCKS;count++)
		{
		    if((spikestate[count])==0)
		    {
				spikestate[count] = 1;
				GetPlayerPos(playerid,spikex[count],spikey[count],spikez[count]);
                GetPlayerFacingAngle(playerid,spikezrot[count]);
		        spike[count] = CreateStrip(spikex[count],spikey[count],spikez[count],spikezrot[count]);
				new string[256];
				format(string,sizeof(string),"You have placed spikes down ID:%i",count);
				SendClientMessage(playerid,LIGHTBLUE,string);
				SaveQuickSpikeData(count);
		        return 1;
		    }
		}
		SendClientMessage(playerid,RED,"There are currently is no more room for spikes");
	}
	else
	{
	    SendClientMessage(playerid,RED,"You are not allowed to use this command");
	}
	return 1;
}
CMD:placeroadblock(playerid, params[])//Working
{
	if((placeingblocks[playerid])==1)
	{
		for(new count;count < MAX_BLOCKS;count++)
		{
		    if((roadblockstate[count])==0)
		    {
				if(!IsPlayerInAnyVehicle(playerid))
				{
					roadblockstate[count] = 1;
					GetPlayerPos(playerid,roadblockx[count],roadblocky[count],roadblockz[count]);
					roadblockobject[count] = CreateDynamicObject(981,roadblockx[count],roadblocky[count],roadblockz[count],roadblockxrot[count],roadblockyrot[count],roadblockzrot[count],-1,-1,-1,200.0,300.0);
					SetPlayerPos(playerid,roadblockx[count],roadblocky[count],roadblockz[count] + 5.0);//Fix
					SaveQuickRoadblockData(count);
					new string[256];
					format(string,sizeof(string),"You have placed roadblock ID:%i",count);
					SendClientMessage(playerid,LIGHTBLUE,string);
					return 1;
				}
				else
				{
					SendClientMessage(playerid,RED,"You can't be in a vehicle well placeing a road block");
				}
		    }
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You are not allowed to use this command");
	}
	return 1;
}
CMD:placebarrel(playerid, params[])//Working
{
	if((placeingblocks[playerid])==1)
	{
		for(new count;count < MAX_BLOCKS;count++)
		{
		    if((barrelstate[count])==0)
		    {
		        barrelstate[count] = 1;
		        GetPlayerPos(playerid,barrelx[count],barrely[count],barrelz[count]);
		        barrelz[count] = barrelz[count] - 1.070326;
		        barrelobject[count] = CreateDynamicObject(1237,barrelx[count],barrely[count],barrelz[count],barrelxrot[count],barrelyrot[count],barrelzrot[count],-1,-1,-1,200.0,300.0);
				SaveQuickBarrelData(count);
				new string[256];
				format(string,sizeof(string),"You have placed barrel ID:%i",count);
				SendClientMessage(playerid,LIGHTBLUE,string);
				return 1;
		    }
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You are not allowed to use this command");
	}
	return 1;
}
CMD:checkspike(playerid, params[])//Working
{
    if((placeingblocks[playerid])==1)
	{
		for(new count;count < MAX_BLOCKS;count++)
		{
		    if((spikestate[count])==1)
		    {
				if(IsPlayerInRangeOfPoint(playerid,8.0,spikex[count],spikey[count],spikez[count]))
				{
				    new string[256];
				    format(string,sizeof(string),"You are next to spike id %i",count);
				    SendClientMessage(playerid,LIGHTBLUE,string);
				}
		    }
		}
 	}
	else
	{
	    SendClientMessage(playerid,RED,"You are not allowed to use this command");
	}
	return 1;
}
CMD:checkroadblock(playerid, params[])//working
{
    if((placeingblocks[playerid])==1)
	{
	    for(new count;count < MAX_BLOCKS;count++)
		{
		    if((roadblockstate[count])==1)
		    {
				if(IsPlayerInRangeOfPoint(playerid,8.0,roadblockx[count],roadblocky[count],roadblockz[count]))
				{
				    new string[256];
				    format(string,sizeof(string),"You are next to roadblock id %i",count);
				    SendClientMessage(playerid,LIGHTBLUE,string);
				}
		    }
		}
    }
	else
	{
	    SendClientMessage(playerid,RED,"You are not allowed to use this command");
	}
	return 1;
}
CMD:checkbarrel(playerid, params[])//Working
{
    if((placeingblocks[playerid])==1)
	{
	    for(new count;count < MAX_BLOCKS;count++)
		{
		    if((barrelstate[count])==1)
		    {
				if(IsPlayerInRangeOfPoint(playerid,8.0,barrelx[count],barrely[count],barrelz[count]))
				{
				    new string[256];
				    format(string,sizeof(string),"You are next to barrel id %i",count);
				    SendClientMessage(playerid,LIGHTBLUE,string);
				}
		    }
		}
    }
	else
	{
	    SendClientMessage(playerid,RED,"You are not allowed to use this command");
	}
	return 1;
}
CMD:movespike(playerid, params[])//Working
{
    if((placeingblocks[playerid])==1)
	{
		new id;
		if(sscanf(params,"i",id)) return SendClientMessage(playerid,RED,"SYNTAX /movespike [spikeid]");
		editobjblock[playerid] = id;
	    buildtype[playerid] = 6;
	    oldx[playerid] = spikex[id];
	    oldy[playerid] = spikey[id];
	    oldz[playerid] = spikez[id];
	    oldxrot[playerid] = spikexrot[id];
	    oldyrot[playerid] = spikeyrot[id];
	    oldzrot[playerid] = spikezrot[id];
	    EditStrip(playerid,id);
	}
	else
	{
	    SendClientMessage(playerid,RED,"You are not allowed to use this command");
	}
	return 1;
}
CMD:moveroadblock(playerid, params[])//Working
{
    if((placeingblocks[playerid])==1)
	{
		new id;
		if(sscanf(params,"i",id)) return SendClientMessage(playerid,RED,"SYNTAX /moveroadblock [roadblockid]");
		editobjblock[playerid] = id;
        buildtype[playerid] = 7;
   	    oldx[playerid] = roadblockx[id];
	    oldy[playerid] = roadblocky[id];
	    oldz[playerid] = roadblockz[id];
	    oldxrot[playerid] = roadblockxrot[id];
	    oldyrot[playerid] = roadblockyrot[id];
	    oldzrot[playerid] = roadblockzrot[id];
	    EditDynamicObject(playerid,roadblockobject[id]);
	}
	else
	{
	    SendClientMessage(playerid,RED,"You are not allowed to use this command");
	}
	return 1;
}
CMD:movebarrel(playerid, params[])//Working
{
    if((placeingblocks[playerid])==1)
	{
		new id;
		if(sscanf(params,"i",id)) return SendClientMessage(playerid,RED,"SYNTAX /movebarrel [barrelid]");
		editobjblock[playerid] = id;
        buildtype[playerid] = 8;
        oldx[playerid] = barrelx[id];
	    oldy[playerid] = barrely[id];
	    oldz[playerid] = barrelz[id];
	    oldxrot[playerid] = barrelxrot[id];
	    oldyrot[playerid] = barrelyrot[id];
	    oldzrot[playerid] = barrelzrot[id];
	    EditDynamicObject(playerid,barrelobject[id]);
	}
	else
	{
	    SendClientMessage(playerid,RED,"You are not allowed to use this command");
	}
	return 1;
}
CMD:destroyspike(playerid, params[])//Working
{
    if((placeingblocks[playerid])==1)
	{
	    new id;
	    if(sscanf(params,"i",id)) return SendClientMessage(playerid,RED,"SYNTAX /destroyspikes [spikeid]");
	    if((spikestate[id])==1)
	    {
   			DeleteStrip(spike[id]);
   			DeleteSpikeData(id);
			SendClientMessage(playerid,LIGHTBLUE,"You have destroyed a spike");
		}
		else
		{
		    SendClientMessage(playerid,RED,"This spike does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You are not allowed to use this command");
	}
	return 1;
}
CMD:destroyroadblock(playerid, params[])//Working
{
	if((placeingblocks[playerid])==1)
	{
        new id;
	    if(sscanf(params,"i",id)) return SendClientMessage(playerid,RED,"SYNTAX /destroyroadblocks [roadblockid]");
	    if((roadblockstate[id])==1)
	    {
	        DestroyDynamicObject(roadblockobject[id]);
	        DeleteRoadblockData(id);
	        SendClientMessage(playerid,LIGHTBLUE,"You have destoryed a roadblock");
	    }
	    else
	    {
	        SendClientMessage(playerid,RED,"This roadblock does not exist");
	    }
	}
	else
	{
	    SendClientMessage(playerid,RED,"You are not allowed to use this command");
	}

	return 1;
}
CMD:destroybarrel(playerid, params[])//Working
{
    if((placeingblocks[playerid])==1)
	{
        new id;
	    if(sscanf(params,"i",id)) return SendClientMessage(playerid,RED,"SYNTAX /destroybarrels [barrelid]");
	    if((barrelstate[id])==1)
	    {
			DestroyDynamicObject(barrelobject[id]);
			DeleteBarrelData(id);
			SendClientMessage(playerid,LIGHTBLUE,"You have destroyed a barrel");
	    }
	    else
	    {
	        SendClientMessage(playerid,RED,"This barrel does not exist");
	    }
	}
	else
	{
	    SendClientMessage(playerid,RED,"You are not allowed to use this command");
	}
	return 1;
}
CMD:resetallcars(playerid, params[])//working
{
	if(IsPlayerAdmince(playerid, 3))
	{
	    for(new count;count < MAX_VEHICLES;count++)
	    {
	        if((carstate[count])==1)
	        {
				for(new i;i < MAX_PLAYERS;i++)
				{
				    if(IsPlayerConnected(i))
				    {
						if(IsPlayerInVehicle(i,count))
						{
							continue;
						}
					}
				}
				CallLocalFunction("OnVehicleDeathDelay", "i" ,car[count]);
	        }
	    }
		SendClientMessage(playerid,RED,"You respawned all the cars");
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
//Remove
/*:viewlogenterys(playerid, params[])//#4
{
	new choice[64],id,string[256],str[256],loadedstring[256];
	if(sscanf(params,"s["#64"]i",choice,id)) return SendClientMessage(playerid,RED, "SYNTAX /viewlogenterys [repairshop/] [id]");
	if(strcmp(choice,"repairshop",true,sizeof(choice))==0)
	{
	    if((repairshopgroup[playerid])==1)
	    {
	        if((repairshopgrouplogcount) <=id)
	        {
	            new temp = 0;
	            temp = id - 5;
	            if((temp) > 0)
	            {
		            format(str,sizeof(str),"repairshopgrouplog[%i]",temp);
					format(loadedstring,sizeof(loadedstring),"%s",QINI_String(grouplogfilename,str));
					if(!isnull(loadedstring))
					{
						format(string,sizeof(string),"repairshopgrouplog[%i]-%s",id - 5,loadedstring);
						SendClientMessage(playerid, LIGHTBLUE, string);
					}
				}
				temp = id - 4;
				if((temp) > 0)
				{
	    			format(str,sizeof(str),"repairshopgrouplog[%i]",temp);
	    			format(loadedstring,sizeof(loadedstring),"%s",QINI_String(grouplogfilename,str));
                    if(!isnull(loadedstring))
                    {
	     				format(string,sizeof(string),"repairshopgrouplog[%i]-%s",id - 4,loadedstring);
						SendClientMessage(playerid, LIGHTBLUE, string);
					}
				}
				temp = id - 3;
				if((temp) > 0)
				{
	 				format(str,sizeof(str),"repairshopgrouplog[%i]",id - 3);
	 				format(loadedstring,sizeof(loadedstring),"%s",QINI_String(grouplogfilename,str));
                    if(!isnull(loadedstring))
                    {
						format(string,sizeof(string),"repairshopgrouplog[%i]-%s",id - 3,loadedstring);
						SendClientMessage(playerid, LIGHTBLUE, string);
					}
				}
				temp = id - 2;
				if((temp) > 0)
				{
	 				format(str,sizeof(str),"repairshopgrouplog[%i]",id - 2);
	 				format(loadedstring,sizeof(loadedstring),"%s",QINI_String(grouplogfilename,str));
	 				if(!isnull(loadedstring))
	 				{
						format(string,sizeof(string),"repairshopgrouplog[%i]-%s",id - 2,loadedstring);
						SendClientMessage(playerid, LIGHTBLUE, string);
					}
				}
				temp = id - 1;
				if((temp) > 0)
				{
	 				format(str,sizeof(str),"repairshopgrouplog[%i]",id - 1);
	 				format(loadedstring,sizeof(loadedstring),"%s",QINI_String(grouplogfilename,str));
	 				if(!isnull(loadedstring))
	 				{
						format(string,sizeof(string),"repairshopgrouplog[%i]-%s",id - 1,loadedstring);
						SendClientMessage(playerid, LIGHTBLUE, string);
					}
				}
				format(str,sizeof(str),"repairshopgrouplog[%i]",id);
				format(loadedstring,sizeof(loadedstring),"%s",QINI_String(grouplogfilename,str));
				if(!isnull(loadedstring))
				{
					format(string,sizeof(string),"repairshopgrouplog[%i]-%s",id,loadedstring);
					SendClientMessage(playerid, LIGHTBLUE, string);
				}
				temp = id + 1;
				if((repairshopgrouplogcount) <= temp)
				{
	    			format(str,sizeof(str),"repairshopgrouplog[%i]",id + 1);
	    			format(loadedstring,sizeof(loadedstring),"%s",QINI_String(grouplogfilename,str));
	    			if(!isnull(loadedstring))
	    			{
						format(string,sizeof(string),"repairshopgrouplog[%i]-%s",id + 1,loadedstring);
						SendClientMessage(playerid, LIGHTBLUE, string);
					}
				}
				temp = id + 2;
				if((repairshopgrouplogcount) <= temp)
				{
					format(str,sizeof(str),"repairshopgrouplog[%i]",id + 2);
					format(loadedstring,sizeof(loadedstring),"%s",QINI_String(grouplogfilename,str));
					if(!isnull(loadedstring))
					{
						format(string,sizeof(string),"repairshopgrouplog[%i]-%s",id + 2,loadedstring);
						SendClientMessage(playerid, LIGHTBLUE, string);
					}
				}
				temp = id + 3;
                if((repairshopgrouplogcount) <= temp)
                {
					format(str,sizeof(str),"repairshopgrouplog[%i]",id + 3);
					format(loadedstring,sizeof(loadedstring),"%s",QINI_String(grouplogfilename,str));
					if(!isnull(loadedstring))
					{
						format(string,sizeof(string),"repairshopgrouplog[%i]-%s",id + 3,loadedstring);
						SendClientMessage(playerid, LIGHTBLUE, string);
					}
                }
                temp = id + 4;
                if((repairshopgrouplogcount) <= temp)
                {
	    			format(str,sizeof(str),"repairshopgrouplog[%i]",id + 4);
	    			format(loadedstring,sizeof(loadedstring),"%s",QINI_String(grouplogfilename,str));
	    			if(!isnull(loadedstring))
	    			{
						format(string,sizeof(string),"repairshopgrouplog[%i]-%s",id + 4,loadedstring);
						SendClientMessage(playerid, LIGHTBLUE, string);
					}
				}
				temp = id + 5;
				if((repairshopgrouplogcount) <= temp)
				{
	    			format(str,sizeof(str),"repairshopgrouplog[%i]",id + 5);
	    			format(loadedstring,sizeof(loadedstring),"%s",QINI_String(grouplogfilename,str));
	    			if(!isnull(loadedstring))
	    			{
						format(string,sizeof(string),"repairshopgrouplog[%i]-%s",id + 5,loadedstring);
						SendClientMessage(playerid, LIGHTBLUE, string);
					}
				}
			}
			else
			{
			    SendClientMessage(playerid,RED, "There is not that many entries in the log");
			}
		}
		else
		{
		    SendClientMessage(playerid,RED,"You have to be in the repairshop group");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED, "SYNTAX /viewlogenterys [repairshop/] [id]");
	}
	return 1;
}
CMD:removelogentry(playerid, params[])//#4
{
	if(IsPlayerAdmince(playerid,5))
	{
		new choice[64],id,reason[64],string[256];
		if(sscanf(params,"s["#64"]is["#64"]",choice,id)) return SendClientMessage(playerid,RED,"SYNTAX /removelogentry [repairshop] [entryid] [reason]");
		if(strcmp(choice,"repairshop",true,sizeof(choice))==0)
		{
			format(string,sizeof(string),"[ADMIN:%s] has removed entery id:%i from the repairshop group[Reason:%s]",GetPlayerNameReturn(playerid),id,reason);
        	RemoveRepairshopLogEntry(id);
		}
		else
		{
		    SendClientMessage(playerid,RED,"SYNTAX /removelogentry [repairshop] [entryid] [reason]");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be an admin inorder to use this command");
	}
	return 1;
}
CMD:setgrouppaycheck(playerid, params[])//#4
{
	if(IsPlayerAdmince(playerid,5))
	{
		new choice[64],string[256],amount,name[MAX_PLAYER_NAME];
		if(sscanf(params,"s["#64"]i",choice,amount)) return SendClientMessage(playerid,RED,"SYNTAX /setgrouppaycheck [repairshopid/] [amount]");
		GetPlayerName(playerid,name,sizeof(name));
		if(strcmp(choice,"repairshop",true,sizeof(choice))==0)
		{
			if((repairshopgroup[playerid])==1)
			{
				format(string,sizeof(string),"[ADMIN:%s] has set the paycheck price from $%i to $%i an hour",repairshoppaycheck,amount);
                repairshoppaycheck = amount;
                SaveQuickRepairshopGroupData();
                SaveRepairshopLog(string);
                for(new i;i < MAX_PLAYERS;i++)
                {
                    if(IsPlayerConnected(i))
                    {
                        if((repairshopgroup[i])==1)
                        {
                            SendClientMessage(i,REPAIRSHOPCOLOR,string);
                        }
                    }
                }
			}
			else
			{
			    SendClientMessage(playerid,RED,"You have to be in the repairshop group inorder to set the paycheck");
			}
		}
		else
		{
	        SendClientMessage(playerid,RED,"SYNTAX /setgrouppaycheck [repairshopid/] [amount]");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:gbalance(playerid, params[])//#4
{
	new choice[64],string[256];
	if(sscanf(params,"s["#64"]",choice)) return SendClientMessage(playerid,RED,"SYNTAX /gbalance [repairshop/]");
	if(strcmp(choice,"repairshop",true,sizeof(choice))==0)
	{
	    if((repairshopgroup[playerid])==1)
	    {
			format(string,sizeof(string),"The repairshop currently has $%i",repairshopgroupcash);
			SendClientMessage(playerid,REPAIRSHOPCOLOR,string);
		}
		else
		{
		    SendClientMessage(playerid,RED,"You have to be in the repairshop group inorder to use this command");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"SYNTAX /gbalance [repairshop/]");
	}
	return 1;
}
CMD:gtake(playerid, params[])//#4
{
	new choice[64],amount,string[256],reason[64];
	if(sscanf(params,"s["#64"]is["#64"]",choice,amount,reason)) return SendClientMessage(playerid,RED,"SYNTAX /gtake [repairshop/] [amount] [reason]");
	if(strcmp(choice,"repairshop",true,sizeof(choice))==0)
	{
	    if((repairshopgroup[playerid])==1)
	    {
			new money = GetPlayerMoney(playerid);
			if((repairshopgroupcash) <= money)
			{
			    new name[MAX_PLAYER_NAME];
			    GetPlayerName(playerid,name,sizeof(name));
				repairshopgroupcash = repairshopgroupcash - amount;
				format(string,sizeof(string),"%s has taken $%i from the department makeing a total balance of $%i[Reason:%s]",name,amount,repairshopgroupcash,reason);
				GivePlayerMoney(playerid,amount);
				SaveRepairshopLog(string);
				SaveQuickRepairshopGroupData();
				for(new i;i < MAX_PLAYERS;i++)
				{
				    if(IsPlayerConnected(i))
				    {
						if((repairshopgroup[playerid])==1)
						{
						    SendClientMessage(i,REPAIRSHOPCOLOR,string);
						}
				    }
				}
			}
			else
			{
			    SendClientMessage(playerid,RED,"You don't have this much cash");
			}
		}
		else
		{
		    SendClientMessage(playerid,RED,"You have to be in the repairshop group inorder to use this command");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"SYNTAX /gtake [repairshop/] [amount] [reason]");
	}
	return 1;
}
CMD:gdonate(playerid, params[])//#4
{
	new choice[64],amount,string[256],reason[64];
	if(sscanf(params,"s["#64"]is["#64"]",choice,amount,reason)) return SendClientMessage(playerid,RED,"SYNTAX /gdontate [repairshop/] [amount] [reason]");
	if(strcmp(choice,"repairshop",true,sizeof(choice))==0)
	{
	    if((repairshopgroup[playerid])==1)
	    {
			new money = GetPlayerMoney(playerid);
			if((amount) <= money)
			{
			    new name[MAX_PLAYER_NAME];
			    GetPlayerName(playerid,name,sizeof(name));
				repairshopgroupcash = repairshopgroupcash + amount;
				format(string,sizeof(string),"%s has dontated $%i to the department makeing a total balance of $%i[Reason:%s]",name,amount,repairshopgroupcash,reason);
				GivePlayerMoney(playerid,-amount);
				SaveRepairshopLog(string);
				SaveQuickRepairshopGroupData();
				for(new i;i < MAX_PLAYERS;i++)
				{
				    if(IsPlayerConnected(i))
				    {
						if((repairshopgroup[playerid])==1)
						{
						    SendClientMessage(i,REPAIRSHOPCOLOR,string);
						}
				    }
				}
			}
			else
			{
			    SendClientMessage(playerid,RED,"You don't have this much cash");
			}
		}
		else
		{
		    SendClientMessage(playerid,RED,"You have to be in the repairshop group inorder to use this command");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"SYNTAX /gdontate [repairshop/] [amount] [reason]");
	}
	return 1;
}*/
CMD:removemod(playerid, params[])//working
{
	new vehicleid = GetPlayerVehicleID(playerid);
	new string[128],str[128],addstring[128];
	if((carstate[jbcarid[vehicleid]])== 1)
	{
	    new carid = jbcarid[vehicleid];
	    if((cartype[carid])==1)
	    {
			if(strcmp(carownername[carid],GetPlayerNameReturn(playerid),false,MAX_PLAYER_NAME)!=0) return SendClientMessage(playerid,RED,"You have to be the owner of this car inorder to remove mods");
	    }
	    else if((cartype[carid])==2||(cartype[carid])==3)
	    {
			if(strcmp(dealershipownername[cardealershipid[carid]],GetPlayerNameReturn(playerid),false,MAX_PLAYER_NAME)!=0) return SendClientMessage(playerid,RED, "You have to be the owner of the dealership inorder to remove mods from this vehicle");
	    }
	    /*else if((cartype[carid])==4)//#4
		{
		    if((repairshopgroup[playerid])!=1) return SendClientMessage(playerid,RED,"You have to be in the repairshop group inorder to remove mods");
		}*/
		choiceid[playerid] = vehicleid;
		for(new count;count < 14;count++)
		{
		    choicemarked[count][playerid] = 0;
		    carmodslot[count][carid] = GetVehicleComponentInSlot(car[carid],count);
			if((carmodslot[count][carid])!= 0)
			{
				format(string,sizeof(string),"%s",GetModName(carmodslot[count][carid]));
				choicemarked[count][playerid] = 1;
				if(isnull(str))
				{
					format(str,sizeof(str),"%s",string);
				}
				else
				{
					format(addstring,sizeof(addstring),"%s\n%s",str,string);
					format(str,sizeof(str),"%s",addstring);
				}
			}
		}
		if(isnull(str))
		{
		    ShowPlayerDialog(playerid,CANCEL,DIALOG_STYLE_MSGBOX,"No Mods","This vehicle has no mods","Close","Close");
		}
		else
		{
			ShowPlayerDialog(playerid,MODCAR,DIALOG_STYLE_LIST,"Pick a mod to remove",str,"Ok","Close");
		}
	}
	return 1;
}
CMD:putincar(playerid, params[])//Fix
{
	if(IsPlayerAdmince(playerid,1))
	{
		new choice[64],vid,string[256],id,seat,reason[64];
		if(sscanf(params,"us["#64"]iis["#64"]",id,choice,vid,seat,reason))
		{
			return SendClientMessage(playerid,RED,"SYNTAX /putincar [playerid] [vehicleid/carid] [vid] [seat] [reason]");
		}
		if(strcmp(choice,"vehicleid",true,sizeof(choice))==0)
		{
			if(IsValidVehicle(vid))
			{
				if(IsPlayerInVehicle(playerid,vid))
				{
	                RemovePlayerFromCar(playerid);
				}
				format(string,sizeof(string),"[ADMIN:%s] Has put %s into a %i:%s in seat %i[Reason:%s]",GetPlayerNameReturn(playerid),GetPlayerNameReturn(id),GetVehicleModel(vid),GetVehicleName(vid), seat,reason);
	   			playerlastvehicle[playerid] = id;
			    lastplayerinvehicle[id] = playerid;
				SendClientMessage(playerid,PINK,string);
	            SendClientMessage(id,PINK,string);
				PutPlayerInVehicle(id,vid,seat);
			}
			return 1;
		}
		else if(strcmp(choice,"carid",true,sizeof(choice))==0)
		{
			new carid = vid;
			if((carstate[carid])==1)
			{
				if(IsPlayerInVehicle(playerid,vid))
				{
				    RemovePlayerFromCar(playerid);
				}
			    PutPlayerInVehicle(id,jbcarid[carid],seat);
			    format(string,sizeof(string),"[ADMIN:%s] Has put %s into a %i:%s in seat %i[Reason:%s]",GetPlayerNameReturn(playerid),GetPlayerNameReturn(id),GetVehicleModel(vid),GetVehicleName(vid), seat,reason);
			    playerlastvehicle[playerid] = car[carid];
			    lastplayerinvehicle[car[carid]] = playerid;
				SendClientMessage(playerid,PINK,string);
            	SendClientMessage(id,PINK,string);
  			}
			else
			{
			    SendClientMessage(playerid,RED,"This vehicle does not exist");
			}
			return 1;
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be an admin inorder to use this command");
	}
	return 1;
}
CMD:gotocar(playerid,params[])//Working
{
	if(IsPlayerAdmince(playerid,1))
	{
		new choice[64],id,string[256];
		if(sscanf(params,"s["#64"]i",choice,id))
		{
			return SendClientMessage(playerid,RED,"SYNTAX /gotocar [vehicleid/carid/name_{name}/type_modelid] [id]");
		}
		if(strcmp(choice,"vehicleid",true,sizeof(choice))==0)
		{
		    new Float:x,Float:y,Float:z;
			GetVehiclePos(id,x,y,z);
			if(IsPlayerInAnyVehicle(playerid))
			{
				new playerstate = GetPlayerState(playerid);
				if(playerstate == PLAYER_STATE_DRIVER)
				{
				    new vehicleid = GetPlayerVehicleID(playerid);
				    if((vehicleid) != id)
				    {
						SetVehiclePos(vehicleid,x,y,z);
						new carid = jbcarid[id];
						if((carstate[carid])==1)
						{
                            new Float:health;
                            GetVehicleHealth(car[carid],health);
                            if((cartype[carid])==1)
						    {
								format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Carowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),carownername[carid],carfuel[carid],health);
								SendClientMessage(playerid,PINK,string);
							}
							else if((cartype[carid])==2||(cartype[carid])==3)
							{
								format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Dealerowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],carfuel[carid],health);
								SendClientMessage(playerid,PINK,string);
							}
							else if((cartype[carid])==4)//#4
							{
				   				format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Repairshopvehicle:%i fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],cardealershipid[carid],carfuel[carid],health);
								SendClientMessage(playerid,PINK,string);
							}
							if((carstate[jbcarid[vehicleid]])==1)
							{
								format(string,sizeof(string),"You have teleport to vehicle ID:%i CarID:%i with vehicle ID:%i CarID:%i",id,carid,vehicleid,jbcarid[vehicleid]);
							}
							else
							{
							    format(string,sizeof(string),"You have teleport to vehicle ID:%i CarID:%i with vehicle ID:%i",id,carid,vehicleid);
							}
						}
						else
						{
					    	if((carstate[jbcarid[vehicleid]])==1)
							{
								format(string,sizeof(string),"You have teleport to vehicle ID:%i with vehicle ID:%i CarID:%i",id,vehicleid,jbcarid[vehicleid]);
							}
							else
							{
							    format(string,sizeof(string),"You have teleport to vehicle ID:%i with vehicle ID:%i",id,vehicleid);
							}
						}
						SendClientMessage(playerid,PINK,string);
					}
					else
					{
					    SendClientMessage(playerid,RED,"You can't teleport to the car you are in");
					}
				}
				else
				{
				    SendClientMessage(playerid,RED,"You have to be the driver inorder to go to another car");
				}
			}
			else
			{
			    SetPlayerPos(playerid,x,y,z);
			    if((carstate[jbcarid[id]])==1)
				{
				    new carid = jbcarid[id];
	       			new Float:health;
	                GetVehicleHealth(car[carid],health);
	                if((cartype[carid])==1)
				    {
						format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Carowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),carownername[carid],carfuel[carid],health);
						SendClientMessage(playerid,PINK,string);
					}
					else if((cartype[carid])==2||(cartype[carid])==3)
					{
						format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Dealerowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],carfuel[carid],health);
						SendClientMessage(playerid,PINK,string);
					}
					else if((cartype[carid])==4)//#4
					{
		   				format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Repairshopvehicle:%i fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],cardealershipid[carid],carfuel[carid],health);
						SendClientMessage(playerid,PINK,string);
					}
     				format(string,sizeof(string),"You have teleport to vehicle ID:%i CarID:%i",id,carid);
				}
				else
				{
				    format(string,sizeof(string),"You have teleport to vehicle ID:%i",id);
				}
				SendClientMessage(playerid,PINK,string);
			}
		}
		else if(strcmp(choice,"carid",true,sizeof(choice))==0)
		{
			new carid = id;
			if((carstate[carid])==1)
			{
				new Float:x,Float:y,Float:z;
				GetVehiclePos(car[carid],x,y,z);
				if(IsPlayerInAnyVehicle(playerid))
				{
					new playerstate = GetPlayerState(playerid);
					if(playerstate == PLAYER_STATE_DRIVER)
					{
						new vehicleid = GetPlayerVehicleID(playerid);
						if((car[carid]) != vehicleid)
						{
						    SetVehiclePos(vehicleid,x,y,z);
                            new Float:health;
                            GetVehicleHealth(car[carid],health);
                            if((cartype[carid])==1)
						    {
								format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Carowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),carownername[carid],carfuel[carid],health);
								SendClientMessage(playerid,PINK,string);
							}
							else if((cartype[carid])==2||(cartype[carid])==3)
							{
								format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Dealerowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],carfuel[carid],health);
								SendClientMessage(playerid,PINK,string);
							}
							else if((cartype[carid])==4)//#4
							{
				   				format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Repairshopvehicle:%i fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],cardealershipid[carid],carfuel[carid],health);
								SendClientMessage(playerid,PINK,string);
							}
							if((carstate[jbcarid[vehicleid]])==1)
							{
								format(string,sizeof(string),"You have teleport to vehicle ID:%i CarID:%i with vehicle ID:%i CarID:%i",car[carid],carid,vehicleid,jbcarid[vehicleid]);
							}
							else
							{
							    format(string,sizeof(string),"You have teleport to vehicle ID:%i CarID:%i with vehicle ID:%i",car[carid],carid,vehicleid);
							}
							SendClientMessage(playerid,PINK,string);
						}
						else
						{
						    SendClientMessage(playerid,RED,"You can't teleport to a car you are already in");
						}
					}
					else
					{
					    SendClientMessage(playerid,RED,"You can't teleport to a car you are in one");
					}
				}
				else
				{
				    SetPlayerPos(playerid,x,y,z);
                    new Float:health;
                    GetVehicleHealth(car[carid],health);
                    if((cartype[carid])==1)
				    {
						format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Carowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),carownername[carid],carfuel[carid],health);
						SendClientMessage(playerid,PINK,string);
					}
					else if((cartype[carid])==2||(cartype[carid])==3)
					{
						format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Dealerowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],carfuel[carid],health);
						SendClientMessage(playerid,PINK,string);
					}
					else if((cartype[carid])==4)//#4
					{
		   				format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Repairshopvehicle:%i fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],cardealershipid[carid],carfuel[carid],health);
						SendClientMessage(playerid,PINK,string);
					}
    				format(string,sizeof(string),"You have teleport to vehicle ID:%i CarID:%i",car[carid],carid);
                    SendClientMessage(playerid,PINK,string);
				}
  			}
			else
			{
			    SendClientMessage(playerid,RED,"This carid does not exist");
			}
		}
		else if(strfind(choice,"name",true,0)!= -1)
		{
			new name[MAX_PLAYER_NAME],idcount = 1;
			format(name,sizeof(name),"%s",ReadParamsEx(choice));
			if(isnull(name))
			{
				return SendClientMessage(playerid,RED,"You have entered an invalid name");
			}
			if((id)< 1)
			{
			    return SendClientMessage(playerid,RED,"The id has to be greater the 1");
			}
			for(new count;count < MAX_VEHICLES;count++)
			{
			    if((carstate[count])==1)
			    {
					if((cartype[count])==1)
					{
						if(strcmp(name,carownername[count],false,sizeof(name))==0)
						{
						    if((id)==idcount)
						    {
								new carid = count;
								new Float:x,Float:y,Float:z;
								GetVehiclePos(car[carid],x,y,z);
								if(IsPlayerInAnyVehicle(playerid))
								{
									new playerstate = GetPlayerState(playerid);
									if(playerstate == PLAYER_STATE_DRIVER)
									{
										new vehicleid = GetPlayerVehicleID(playerid);
										if((car[carid]) != vehicleid)
										{
										    SetVehiclePos(vehicleid,x,y,z);
				                            new Float:health;
				                            GetVehicleHealth(car[carid],health);
				                            if((cartype[carid])==1)
										    {
												format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Carowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),carownername[carid],carfuel[carid],health);
											}
											else if((cartype[carid])==2||(cartype[carid])==3)
											{
												format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Dealerowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],carfuel[carid],health);
											}
											else if((cartype[carid])==4)//#4
											{
								   				format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Repairshopvehicle:%i fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],cardealershipid[carid],carfuel[carid],health);
											}
											SendClientMessage(playerid,PINK,string);
											if((carstate[jbcarid[vehicleid]])==1)
											{
												format(string,sizeof(string),"You have teleport to vehicle ID:%i CarID:%i with vehicle ID:%i CarID:%i useing %s's %ith vehicle",car[carid],carid,vehicleid,jbcarid[vehicleid],name,id);
											}
											else
											{
											    format(string,sizeof(string),"You have teleport to vehicle ID:%i CarID:%i with vehicle ID:%i useing %s's %ith vehicle",car[carid],carid,vehicleid,name,id);
											}
											SendClientMessage(playerid,PINK,string);
										}
										else
										{
										    SendClientMessage(playerid,RED,"You can't teleport to a car you are already in");
										}
									}
									else
									{
									    SendClientMessage(playerid,RED,"You can't teleport to a car you are in one");
									}
								}
								else
								{
								    SetPlayerPos(playerid,x,y,z);
				                    new Float:health;
				                    GetVehicleHealth(car[carid],health);
				                    if((cartype[carid])==1)
								    {
										format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Carowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),carownername[carid],carfuel[carid],health);
									}
									else if((cartype[carid])==2||(cartype[carid])==3)
									{
										format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Dealerowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],carfuel[carid],health);
									}
									else if((cartype[carid])==4)//#4
									{
						   				format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Repairshopvehicle:%i fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],cardealershipid[carid],carfuel[carid],health);
									}
									SendClientMessage(playerid,PINK,string);
									format(string,sizeof(string),"You have teleport to vehicle ID:%i CarID:%i useing %s's %ith vehicle",car[carid],carid,name,id);
									SendClientMessage(playerid,PINK,string);
								}
								return 1;
						    }
						    else
						    {
						        idcount++;
						    }
						}
					}
			    }
			}
			format(string,sizeof(string),"%s does not have a %ith car",name,id);
			SendClientMessage(playerid,RED,string);
		}
		else if(strfind(choice,"type",true,0)!= -1)
		{
		    new idcount = 0;//check
			new modelid = strval(ReadParamsEx(choice));
			if((id)< 1)
			{
			    return SendClientMessage(playerid,RED,"The id has to be greater the 1");
			}
			if((modelid) >= 400&&(modelid) <= 612)
			{
				for(new count;count < MAX_VEHICLES;count++)
				{
					if(IsValidVehicle(count))
					{
						if((GetVehicleModel(count))==modelid)
						{
						    if((id)==idcount)
						    {
						        new Float:x,Float:y,Float:z;
						        GetVehiclePos(count,x,y,z);
	                            if(IsPlayerInAnyVehicle(playerid))
								{
									new playerstate = GetPlayerState(playerid);
									if(playerstate == PLAYER_STATE_DRIVER)
									{
										new vehicleid = GetPlayerVehicleID(playerid);
										if((count) != vehicleid)
										{
										    SetVehiclePos(vehicleid,x,y,z);
										    new carid = jbcarid[count];
										    if((carstate[carid])==1)
										    {
											    new Float:health;
					                            GetVehicleHealth(car[carid],health);
											    if((cartype[carid])==1)
											    {
													format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Carowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),carownername[carid],carfuel[carid],health);
												}
												else if((cartype[carid])==2||(cartype[carid])==3)
												{
													format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Dealerowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],carfuel[carid],health);
												}
												else if((cartype[carid])==4)//#4
												{
									   				format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Repairshopvehicle:%i fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],cardealershipid[carid],carfuel[carid],health);
												}
												SendClientMessage(playerid,PINK,string);
												if((carstate[jbcarid[vehicleid]])==1)
												{
													format(string,sizeof(string),"You have teleport to vehicle ID:%i CarID:%i with vehicle ID:%i CarID:%i useing the %ith instence of %i:%s",car[carid],carid,vehicleid,jbcarid[vehicleid],id,modelid,GetVehicleName(modelid));
												}
												else
												{
												    format(string,sizeof(string),"You have teleport to vehicle ID:%i CarID:%i with vehicle ID:%i useing modelid the %ith instence of %i:%s",car[carid],carid,vehicleid,id,modelid,GetVehicleName(modelid));
												}
												SendClientMessage(playerid,PINK,string);
											}
											else
											{
											    if((carstate[jbcarid[vehicleid]])==1)
												{
													format(string,sizeof(string),"You have teleport to vehicle ID:%i with vehicle ID:%i CarID:%i useing the %ith instence of %i:%s",count,vehicleid,jbcarid[vehicleid],id,modelid,GetVehicleName(modelid));
												}
												else
												{
												    format(string,sizeof(string),"You have teleport to vehicle ID:%i with vehicle ID:%i useing modelid the %ith instence of %i:%s",count,vehicleid,id,modelid,GetVehicleName(modelid));
												}
												SendClientMessage(playerid,PINK,string);
											}
										}
										else
										{
										    SendClientMessage(playerid,RED,"You can't teleport to the vehicle you are in");
										}
									}
									else
									{
									    SendClientMessage(playerid,RED,"You have to be the driver inorder to teleport");
									}
								}
								else
								{
								    SetPlayerPos(playerid,x,y,z);
								    new carid = jbcarid[count];
								    if((carstate[carid])==1)
							    	{
									    new Float:health;
			                            GetVehicleHealth(car[carid],health);
									    if((cartype[carid])==1)
									    {
											format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Carowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),carownername[carid],carfuel[carid],health);
										}
										else if((cartype[carid])==2||(cartype[carid])==3)
										{
											format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Dealerowername:%s fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],carfuel[carid],health);
										}
										else if((cartype[carid])==4)//#4
										{
							   				format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Repairshopvehicle:%i fuel:%f health:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],cardealershipid[carid],carfuel[carid],health);
										}
										SendClientMessage(playerid,PINK,string);
										format(string,sizeof(string),"You have teleport to vehicle ID:%i CarID:%i useing the %ith instence of %i:%s",car[carid],carid,id,modelid,GetVehicleName(modelid));
										SendClientMessage(playerid,PINK,string);
									}
									else
									{
									    format(string,sizeof(string),"You have teleport to vehicle ID:%i useing the %ith instence of %i:%s",count,id,modelid,GetVehicleName(modelid));
										SendClientMessage(playerid,PINK,string);
									}
								}
						        return 1;
						    }
						    else
						    {
						        idcount++;
						    }
						}
					}
				}
				format(string,sizeof(string),"there is only currently %i models avalible of %i:%s, You selected %i",idcount,modelid,GetVehicleName(modelid),id);
				SendClientMessage(playerid,RED,string);
			}
			else
			{
			    SendClientMessage(playerid,RED,"you have to enter a number between 400 and 612");
			    SendClientMessage(playerid,RED,"SYNTAX /gotocar [vehicleid/carid/name_{name}/type_modelid] [id]");
			}
		}
		else
		{
		    SendClientMessage(playerid,RED,"SYNTAX /gotocar [vehicleid/carid/name_{name}/type_modelid] [id]");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
//Remove//#4
/*CMD:groupfreq(playerid,params[])//Working
{
	new choice[64],string[256],name[MAX_PLAYER_NAME];
	if(sscanf(params,"s["#64"]",choice))
	{
	    SendClientMessage(playerid,RED,"choice:repairshop");
	    SendClientMessage(playerid,RED,"SYNTAX /groupfreq [choice]");
	    return 1;
	}
	GetPlayerName(playerid,name,sizeof(name));
	if(strcmp(choice,"repairshop",true,sizeof(choice))==0)
	{
	    if((repairshopgroup[playerid])==1)
	    {
		    freq[playerid] = 1;
			SendClientMessage(playerid,REPAIRSHOPCOLOR,"You have switch to the repairshop frequency");
			new INI:filedata = INI_Open(playerdatafilename);
			format(string,sizeof(string),"freq[%s]",name);
			INI_WriteInt(filedata,string,freq[playerid]);
			INI_Close(filedata);
		}
		else
		{
		    SendClientMessage(playerid,RED,"You have to be in the repairshop group inorder to switch to this frequency");
		}
	}
	else
	{
 		SendClientMessage(playerid,RED,"choice:repairshop");
	    SendClientMessage(playerid,RED,"SYNTAX /groupfreq [choice]");
	}
	return 1;
}
CMD:groupr(playerid,params[])//#4
{
	new string[256],input[256];
	if(sscanf(params,"s["#256"]",input))
	{
	    return SendClientMessage(playerid,RED,"SYNTAX /groupr [text]");
	}
	if((freq[playerid])==1)
	{
		new name[MAX_PLAYER_NAME];
		GetPlayerName(playerid,name,sizeof(name));
		format(string,sizeof(string),"%s(Repairshop): %s",name,input);
		for(new i;i < MAX_PLAYERS;i++)
		{
		    if(IsPlayerConnected(i))
		    {
		        if((repairshopgroup[i])==1)
		        {
					SendClientMessage(i,REPAIRSHOPCOLOR,string);
		        }
			}
		}
	}
	else
	{
		SendClientMessage(playerid,RED,"You have to set a frequency for your group radio /groupfreq");
	}
	return 1;
}*/
CMD:viewvehiclecost(playerid,params[])
{
    addvstate[playerid] = 6;
	choicecolor1[playerid] = 0;
	choicecolor2[playerid] = 0;
	choiceid[playerid] = 0;
	ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
	return 1;
}
//remove
/*CMD:uninvite(playerid, params[])//#4
{
	if(IsPlayerAdmince(playerid,4))
	{
	    new id,string[256],name[MAX_PLAYER_NAME],adminname[MAX_PLAYER_NAME],choice[64],reason[64];
	    if(sscanf(params,"s["#64"]is["#64"]",choice,id,reason))
		{
			return SendClientMessage(playerid,RED,"SYNTAX /uninvite [repairshop/] [ID] [reason]");
		}
		if(strcmp(choice,"repairshop",true,sizeof(choice))==0)
		{
			if(IsPlayerConnected(id))
			{
		        if((repairshopgroup[id])==1)
			    {
					repairshopgroup[id] = 0;
					GetPlayerName(id,name,sizeof(name));
					new INI:filedata = INI_Open(playerdatafilename);
					format(string,sizeof(string),"repairshopgroup[%s]",name);
					INI_WriteInt(filedata,string,repairshopgroup[id]);
					if((freq[id]) == 1)
					{
					    freq[id] = 0;
					    format(string,sizeof(string),"freq[%s]",name);
					    INI_WriteInt(filedata,string,freq[id]);
					    SendClientMessage(playerid,RED,"Your frequency has been changed");
					}
					INI_Close(filedata);
					GetPlayerName(playerid,adminname,sizeof(adminname));
					format(string,sizeof(string),"[ADMIN:%s]Has uninvited %s to repairshop group[Reason:%s]",adminname,name,reason);
					SaveRepairshopLog(string);
					for(new i;i < MAX_PLAYERS;i++)
					{
					    if(IsPlayerConnected(i))
					    {
					        if((repairshopgroup[i])==1||(i)==id)
					        {
					            SendClientMessage(i,REPAIRSHOPCOLOR,string);
					        }
					    }
					}
					SendClientMessage(id,REPAIRSHOPCOLOR,"You have been uninvited to the repairshop group");
			    }
			    else
			    {
			        SendClientMessage(playerid,RED,"This player is not invited to the repairshop /invite to invite him");
			    }
	  		}
			else
			{
			    SendClientMessage(playerid,RED,"This player is not online");
			}
		}
		else
		{
            SendClientMessage(playerid,RED,"SYNTAX /uninvite [repairshop/] [ID] [reason]");
		}
	}
	else
	{
		SendClientMessage(playerid,RED,"you have to be admin inorder to uninvite someone to a repairshop");
	}
	return 1;
}
CMD:acceptinvite(playerid, params[])//#4
{
    if((playerbeinginvited[playerid])==1)
    {
        new name[MAX_PLAYER_NAME],adminname[MAX_PLAYER_NAME],string[256];
        if(strcmp(playerbeinginvitedto[playerid],"repairshop",true,sizeof(playerbeinginvitedto))==0)
        {
        	repairshopgroup[playerid] = 1;
        	playerbeinginvited[playerid] = 0;
            GetPlayerName(playerid,name,sizeof(name));
            GetPlayerName(playerbeinginvitedadmin[playerid],adminname,sizeof(adminname));
			new INI:filedata = INI_Open(playerdatafilename);
			format(string,sizeof(string),"repairshopgroup[%s]",name);
			INI_WriteInt(filedata,string,repairshopgroup[playerid]);
			INI_Close(filedata);
			format(string,sizeof(string),"[ADMIN:%s]Has invited %s to repairshop group",adminname,name);
			SaveRepairshopLog(string);
			for(new i;i < MAX_PLAYERS;i++)
			{
			    if(IsPlayerConnected(i))
			    {
			        if((repairshopgroup[i])==1)
			        {
			            SendClientMessage(i,REPAIRSHOPCOLOR,string);
			        }
			    }
			}
        }
    }
    else
    {
        SendClientMessage(playerid,RED,"No one has invited you to anything");
    }
	return 1;
}
CMD:invite(playerid, params[])//#4
{
	if(IsPlayerAdmince(playerid,4))
	{
	    new id,string[256],name[MAX_PLAYER_NAME],choice[64];
	    if(sscanf(params,"s["#64"]u",choice,id))
		{
			return SendClientMessage(playerid,RED,"SYNTAX /invite [repairshop/] [ID]");
		}
		if(strcmp(choice,"repairshop",true,sizeof(choice))==0)
		{
			if(IsPlayerConnected(id))
			{
			    if((repairshopgroup[id])==0)
			    {
			        if((playerbeinginvited[playerid])==0)
			        {
			            playerbeinginvitedadmin[id] = playerid;
			            GetPlayerName(id,name,sizeof(name));
			            playerbeinginvited[id] = 1;
						format(playerbeinginvitedto[playerid],sizeof(playerbeinginvitedto),"repairshop");
						format(string,sizeof(string),"You have sent a invite to %s",name);
						SendClientMessage(playerid,REPAIRSHOPCOLOR,string);
						SendClientMessage(id,REPAIRSHOPCOLOR,"You have been invited to the repairshop group /acceptinvite inorder to accept it");
						SetTimerEx("InviteCancel",30000,false,"i",id);
					}
					else
					{
					    SendClientMessage(playerid,RED,"This person is being invited to a group right now");
					}
			    }
			    else
			    {
			        SendClientMessage(playerid,RED,"This player is already invited to the repairshop /invite to uninvite him");
			    }
			}
			else
			{
			    SendClientMessage(playerid,RED,"This player is not online");
			}
		}
		else
		{
		    SendClientMessage(playerid,RED,"SYNTAX /invite [repairshop/] [ID]");
		}
	}
	else
	{
		SendClientMessage(playerid,RED,"you have to be admin inorder to invite someone to a repairshop");
	}
	return 1;
}*/
CMD:setvehicleelockprice(playerid,params[])//working
{//add
    if(IsPlayerAdmince(playerid,3))
	{
	    new amount,repairshopid,string[256];
		if(sscanf(params,"ii",repairshopid,amount))
		{
		    return SendClientMessage(playerid,RED,"SYNTAX /setvehicleelockprice [repairshopid] [amount]");
		}
		if((amount) > 0&&(amount) <= 5000000)
		{
		    format(string,sizeof(string),"[ADMIN:%s]Has set a new E-Lock price for repairshopid:%i from $%i to $%i",GetPlayerNameReturn(playerid),repairshopid,repairshopelockcost[repairshopid],amount);
			repairshopelockcost[repairshopid] = amount;
			UpdateRepairShopLabel(repairshopid);
			SaveQuickRepairShopData(repairshopid);
			SendClientMessage(playerid,PINK,string);
		}
		else
		{
			SendClientMessage(playerid,RED,"The price range is $1 to $5,000,000");
		}
 	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:setvehicleslockprice(playerid,params[])//working
{//add
	if(IsPlayerAdmince(playerid,3))
	{
	    new amount,repairshopid,string[256];
		if(sscanf(params,"ii",repairshopid,amount))
		{
		    return SendClientMessage(playerid,RED,"SYNTAX /setvehicleslockprice [repairshopid] [amount]");
		}
		if((amount) > 0&&(amount) <= 1000000)
		{
		    format(string,sizeof(string),"[ADMIN:%s]Has set the S-Lock price for repairshopid:%i from $%i to $%i",GetPlayerNameReturn(playerid),repairshopid,repairshopslockcost[repairshopid],amount);
			repairshopslockcost[repairshopid] = amount;
			UpdateRepairShopLabel(repairshopid);
			SaveQuickRepairShopData(repairshopid);
			SendClientMessage(playerid,PINK,string);
		}
		else
		{
			SendClientMessage(playerid,RED,"The price range is $1 to $1,000,000");
		}
 	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:setvehiclerepaircost(playerid,params[])//Working
{
	if(IsPlayerAdmince(playerid,3))
	{
	    new amount,repairshopid,string[256];
		if(sscanf(params,"ii",repairshopid,amount))
		{
		    return SendClientMessage(playerid,RED,"SYNTAX /setvehiclerepaircost [repairshopid] [amount]");
		}
		if((amount) > 0&&(amount) <= 100000)
		{
		    format(string,sizeof(string),"[ADMIN:%s]Has set a new repair cost for repairshopid:%i from $%i to $%i",GetPlayerNameReturn(playerid),repairshopid,repairshopcost[repairshopid],amount);
			repairshopcost[repairshopid] = amount;
			UpdateRepairShopLabel(repairshopid);
			SaveQuickRepairShopData(repairshopid);
			SendClientMessage(playerid,PINK,string);
		}
		else
		{
			new str[256];
			format(str,sizeof(str),"vehicle repaircost $%i",repairshopcost[editobjrepairshop[playerid]]);
			SendClientMessage(playerid,RED,"The price range is $1 to $100,000 to repair you vehicle");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:gotorepairshop(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,1))
	{
		new repairshopid;
		if(sscanf(params,"i",repairshopid))
		{
		    return SendClientMessage(playerid,RED,"SYNTAX /gotorepairshop [repairshopid]");
		}
		if((repairshopstate[repairshopid])==1)
		{
		    if(IsPlayerInAnyVehicle(playerid))
		    {
		        new playerstate = GetPlayerState(playerid);
		        if(playerstate == PLAYER_STATE_DRIVER)
		        {
		            new vehicleid = GetPlayerVehicleID(playerid);
		            SetVehiclePos(vehicleid,repairshopx[repairshopid],repairshopy[repairshopid],repairshopz[repairshopid]);
		            SendClientMessage(playerid,LIGHTBLUE,"You have teleport to a repairshop");
		        }
		        else
		        {
		            SendClientMessage(playerid,RED,"You have to be the driver inorder to teleport");
		        }
		    }
		    else
		    {
		        SetPlayerPos(playerid,repairshopx[repairshopid],repairshopy[repairshopid],repairshopz[repairshopid]);
		        SendClientMessage(playerid,LIGHTBLUE,"You have teleport to a repairshop");
		    }
		}
		else
		{
		    SendClientMessage(playerid,RED,"This repairshop does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be an admin inorder to go to a repairshop");
	}
	return 1;
}
CMD:buylock(playerid, params[])//Working
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new playerstate = GetPlayerState(playerid);
		if(playerstate == PLAYER_STATE_DRIVER)
		{
		    for(new count;count < MAX_REPAIRSHOPS;count++)
		    {
		        if((repairshopstate[count])==1)
		        {
					if(IsPlayerInRangeOfPoint(playerid,2.5,repairshopx[count],repairshopy[count],repairshopz[count]))
				    {
				        editobjrepairshop[playerid] = count;
				        ShowPlayerDialog(playerid,REPAIRSHOPBUYLOCK,DIALOG_STYLE_LIST,"Select a lock","S-lock\nE-lock","Ok","Close");
				        return 1;
				    }
		        }
		    }
		}
		else
		{
		    SendClientMessage(playerid,RED,"You have to be the driver inorder to buy a lock");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be in a vehicle inorder to buy a lock");
	}
	return 1;
}
CMD:repaircar(playerid, params[])//Working
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new playerstate = GetPlayerState(playerid);
		if(playerstate == PLAYER_STATE_DRIVER)
		{
		    new vehicleid = GetPlayerVehicleID(playerid);
			for(new count;count < MAX_REPAIRSHOPS;count++)
			{
			    if((repairshopstate[count])==1)
				{
				    if(IsPlayerInRangeOfPoint(playerid,2.5,repairshopx[count],repairshopy[count],repairshopz[count]))
				    {
				        new money = GetPlayerMoney(playerid);
				        if((money) >= repairshopcost[count])
				        {
				            GivePlayerMoney(playerid,-repairshopcost[count]);
				            TextDrawShowForPlayer(playerid,textrepaircar);
	                        TogglePlayerControllable(playerid,false);
	                        SaveQuickRepairShopData(count);
	                        SetTimerEx("RepairCar",8000,false,"ii",playerid,vehicleid);
						}
						else
						{
						    SendClientMessage(playerid,RED,"You don't have enought money to repair your car");
						}
                        return 1;
				    }
				}
			}
			SendClientMessage(playerid,RED,"You are not near a repaircar point");
		}
		else
		{
		    SendClientMessage(playerid,RED,"You have to be the driver inorder to repair a car");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You are not in a vehicle");
	}
	return 1;
}
CMD:moverepairgarage(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,3))
	{
		new repairshopid;
		if(sscanf(params,"i",repairshopid))
		{
			return SendClientMessage(playerid,RED,"SYNTAX /moverepairgarage [repairshopid]");
		}
		if((repairshopstate[repairshopid])==1)
		{
			SendClientMessage(playerid,LIGHTBLUE,"You are now moveing an object");
			oldx[playerid] = repairshopx[repairshopid];
			oldy[playerid] = repairshopy[repairshopid];
			oldz[playerid] = repairshopz[repairshopid];
			oldxrot[playerid] = repairshopxrot[repairshopid];
			oldyrot[playerid] = repairshopyrot[repairshopid];
			oldzrot[playerid] = repairshopzrot[repairshopid];
			editobjrepairshop[playerid] = repairshopid;
			buildtype[playerid] = 5;
			DestroyPickup(repairshoppickup[repairshopid]);
			EditDynamicObject(playerid,repairshop[repairshopid]);
		}
		else
		{
		    SendClientMessage(playerid,RED,"This repairshop does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:deleterepairgarage(playerid,params[])//Working
{
	if(IsPlayerAdmince(playerid,3))
	{
		new repairshopid;
		if(sscanf(params,"i",repairshopid))
		{
		    return SendClientMessage(playerid,RED,"SYNTAX /deleterepairgarage [repairshopid]");
		}
		if((repairshopstate[repairshopid])==1)
		{
			repairshopstate[repairshopid] = 0;
	        DestroyDynamicObject(repairshop[repairshopid]);
	        Delete3DTextLabel(repairshoplabel[repairshopid]);
	        DestroyPickup(repairshoppickup[repairshopid]);
	        DeleteRepairShopData(repairshopid);
	        SendClientMessage(playerid,RED,"You have delete your repairgarage");
		}
		else
		{
		    SendClientMessage(playerid,RED,"This repair shop does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:createrepairgarage(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,3))
	{
		new choice[64],string[256];
		if(sscanf(params,"s["#64"]",choice))
		{
		    return SendClientMessage(playerid,RED,"SYNTAX /addrepairgarage [yes/no] if you want the object");
		}
		for(new count;count < MAX_REPAIRSHOPS;count++)
		{
			if((repairshopstate[count])==0)
			{
		        if(strcmp(choice,"yes",true,sizeof(choice))==0)
		        {
					repairshopobjectid[count] = 17950;//pay n spray object
		        }
		        else if(strcmp(choice,"no",true,sizeof(choice))==0)
		        {
		           repairshopobjectid[count] = 19300; //blank object id 19300
		        }
		        else
		        {
		            SendClientMessage(playerid,RED,"You did not enter yes or no for the object");
		            SendClientMessage(playerid,RED,"SYNTAX /addrepairgarage [yes/no] if you want the object");
					return 1;
		        }
		        repairshopstate[count] = 1;
    			repairshopcost[count] = 2500;
       			repairshopslockcost[count] = 25000;
		        repairshopelockcost[count] = 50000;
				GetPlayerPos(playerid,repairshopx[count],repairshopy[count],repairshopz[count]);
				repairshop[count] = CreateDynamicObject(repairshopobjectid[count],repairshopx[count],repairshopy[count],repairshopz[count] + 1.5,repairshopxrot[count],repairshopyrot[count],repairshopzrot[count],-1,-1,-1,300.0);
				format(string,sizeof(string),"%i:repairgarage\n/repaircar to repair your car /buylock to buy a lock\nit cost $%i to repair your car & E-$%iS-$%i to buy a lock",count,repairshopcost[count],repairshopelockcost[count],repairshopslockcost[count]);
	            repairshoplabel[count] = Create3DTextLabel(string,YELLOW,repairshopx[count],repairshopy[count],repairshopz[count],DISTANCELABEL,0,0);
	            repairshoppickup[count] = CreatePickup(1239,23,repairshopx[count],repairshopy[count],repairshopz[count],-1);
	            SendClientMessage(playerid,RED,"You have added a garage to your repair shop");
	            SaveQuickRepairShopData(count);
				return 1;
			}
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
//remove
/*CMD:createdmv(playerid,params[])
{
	if(IsPlayerAdmince(playerid,4))
	{
		for(new count;count < MAX_DMVS;count++)
		{
		    if((dmvstate[count])==0)
		    {
		        new string[256];
		        dmvstate[count] = 1;
		        GetPlayerPos(playerid,dmvx[count],dmvy[count],dmvz[count]);
		        format(string,sizeof(string),"%i:department of motor vehicles",count);
		        dmvlabel[count] = Create3DTextLabel(string,YELLOW,dmvx[count],dmvy[count],dmvz[count],DISTANCELABEL,0,0);
				SendClientMessage(playerid,LIGHTBLUE,"You have create a dmv");
				SaveQuickDmvData(count);
				return 1;
		    }
		}
		SendClientMessage(playerid,RED,"There are no more slots for anymore dmvs");
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:deletedmv(playerid, params[])
{
	if(IsPlayerAdmince(playerid,4))
	{
		new dmvid;
		if(sscanf(params,"i",dmvid))
		{
		    return SendClientMessage(playerid,RED,"SYNTAX /deletedmv [dmvid]");
		}
		if((dmvstate[dmvid])==1)
		{
		    Delete3DTextLabel(dmvlabel[dmvid]);
			DeleteDmvData(dmvid);
			SendClientMessage(playerid,RED,"You have delete a dmv");
		}
		else
		{
		    SendClientMessage(playerid,RED,"This dmv does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}*/

CMD:disposecar(playerid, params[])//Working
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new playerstate = GetPlayerState(playerid);
		if(playerstate == PLAYER_STATE_DRIVER)
		{
		    for(new count;count < MAX_DISPOSERS;count++)
		    {
		        if((disposecarstate[count])==1)
		        {
		            if(IsPlayerInRangeOfPoint(playerid,3.5,disposecarx[count],disposecary[count],disposecarz[count]))
					{
					    new vehicleid = GetPlayerVehicleID(playerid);
						new carid = jbcarid[vehicleid];
						if((carstate[carid])==1)
						{
						    if((cartype[carid])==1)
						    {
						        new string[256];
						        if(strcmp(GetPlayerNameReturn(playerid),carownername[carid],false,MAX_PLAYER_NAME)==0)
						        {
						            new cost = VehicleManufactureingPrice(carmodelid[carid]);
						            cost = cost / 4;
						            choiceid[playerid] = carid;
						            format(string,sizeof(string),"Your %s is salvagable at $%i. Are you sure you want to dispose your car?",GetVehicleName(carmodelid[carid]),cost);
									ShowPlayerDialog(playerid,DISPOSERMENU,DIALOG_STYLE_MSGBOX,"Dispose Car",string,"Yes","No");
									return 1;
						        }
						        else
						        {
						            SendClientMessage(playerid,RED,"You can't dispose a car that you don't own");
						        }
						    }
						    else
						    {
						        SendClientMessage(playerid,RED,"You can't dispose a car that is not ownable");
						    }
						}
						else
						{
						    SendClientMessage(playerid,RED,"You can't dispose this car");
						}
						return 1;
					}
				}
			}
			SendClientMessage(playerid,RED,"You are not near a vehicle disposer");
		}
		else
		{
		    SendClientMessage(playerid,RED,"You have to be the driver inorder to use this car");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be in a car inorder to dispose it");
	}
	return 1;
}
CMD:createvehicledisposer(playerid, params[])//Working
{
    if(IsPlayerAdmince(playerid,4))
	{
		for(new count;count < MAX_DISPOSERS;count++)
		{
		    if((disposecarstate[count])==0)
		    {
		        new string[256];
		        disposecarstate[count] = 1;
				GetPlayerPos(playerid,disposecarx[count],disposecary[count],disposecarz[count]);
				format(string,sizeof(string),"%i:VehicleDisposer point\nTo dispose of your car type in /disposecar.\nYou will get 1/4 of the vehicles value",count);
				disposelabel[count] = Create3DTextLabel(string,YELLOW,disposecarx[count],disposecary[count],disposecarz[count],DISTANCELABEL,0,0);
				SendClientMessage(playerid,LIGHTBLUE,"You have create a vehicle disposer");
				SaveQuickDisposerData(count);
		        return 1;
		    }
		}
		SendClientMessage(playerid,RED,"You can't build anymore disposers");
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be an admin inorder to use this command");
	}
	return 1;
}
CMD:deletevehicledisposer(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,4))
	{
		new disposerid;
		if(sscanf(params,"i",disposerid))
		{
		    return SendClientMessage(playerid,RED,"SYNTAX /deletevehicledisposer [disposerid]");
		}
		if((disposecarstate[disposerid])==1)
		{
			Delete3DTextLabel(disposelabel[disposerid]);
			DeleteDisposerData(disposerid);
			SendClientMessage(playerid,RED,"You have delete the vehicle disposer");
		}
		else
		{
		    SendClientMessage(playerid,RED,"This cardisposer does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be an admin inorder to use this command");
	}
	return 1;
}
//remove
/*
CMD:removecarfromgroup(playerid, params[])//Working
{
	new choice[64],reason[64];
	if(sscanf(params,"s["#64"]s["#64"]",choice,reason))
	{
	    SendClientMessage(playerid,RED, "choice:repairshop");
	    SendClientMessage(playerid,RED, "SYNTAX /removecarfromgroup [choice] [reason]");
	    return 1;
	}
	if(strcmp(choice,"repairshop",true,sizeof(choice))==0)//#4
	{
	    if((repairshopgroup[playerid])==1)
	    {
			if(IsPlayerInAnyVehicle(playerid))
			{
			    new vehicleid = GetPlayerVehicleID(playerid);
				new carid = jbcarid[vehicleid];
				if((carstate[carid])==1)
				{
				    if((cartype[carid])==4)
				    {
						choicemodelid[playerid] = carid;
						format(choicestring[playerid],sizeof(choicestring),"%s",reason);
						ShowPlayerDialog(playerid,VEHICLEREPAIRSHOPREMOVE,DIALOG_STYLE_MSGBOX,"Remove car","Make sure you ask before removeing a vehicle or you might get terminated","Confirm","Close");
				    }
				    else
				    {
				        SendClientMessage(playerid,RED,"You can only remove a repairshop vehicle");
				    }
				}
				else
				{
				    SendClientMessage(playerid,RED,"You can't use this vehicle");
				}
			}
			else
			{
			    SendClientMessage(playerid,RED,"You have to be in a vehicle inorder to use this command");
			}
		}
		else
		{
			SendClientMessage(playerid,RED, "You have to be part of the repair group inorder to use this command");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED, "choice:repairshop");
	    SendClientMessage(playerid,RED, "SYNTAX /removecarfromgroup [choice]");
	}
	return 1;
}*/
CMD:addmycarto(playerid, params[])//Working
{
	new id,price,choice[64],input[64];
	if(sscanf(params,"s["#64"]is["#64"]",choice,id,input))
	{
	    SendClientMessage(playerid,RED,"Type:dealership");
		SendClientMessage(playerid,RED,"SYNTAX /addmycarto [type] [id(dealership/repairshop_<reason>)] [price/reason]");
		return 1;
	}
	/*if(strfind(choice,"repairshop",true,0)==0)//remove
	{
	    if((repairshopgroup[playerid])==1)
	    {
		    new repairshopid = id;
	        if((repairshopstate[repairshopid])==1)
	        {
	            new vehicleid = GetPlayerVehicleID(playerid);
	            new carid = jbcarid[vehicleid];
		        if((carstate[carid])==1)
		        {
		            if((cartype[carid])==1)
		            {
		                new name[MAX_PLAYER_NAME];
		                GetPlayerName(playerid,name,sizeof(name));
		                if(strcmp(name,carownername[carid],false,sizeof(name))==0)
		                {
		                    choicemodelid[playerid] = carid;
		                    cardealershipid[carid] = repairshopid;
		                    format(choicestring[playerid],sizeof(choicestring),"%s",input);
		                    ShowPlayerDialog(playerid,VEHICLEREPAIRSHOPADD,DIALOG_STYLE_MSGBOX,"Confirmation","!are you sure you wish to add this vehicle to the repairshop. Tip Make sure you ask before adding or you might get in trouble","Confirm","Close");
						}
						else
						{
							SendClientMessage(playerid,RED,"This vehicle is not owned by you");
						}
					}
					else
					{
					    SendClientMessage(playerid,RED,"You can't use this vehicle");
					}
				}
				else
				{
				    SendClientMessage(playerid,RED,"You can't use this vehicle");
				}
		    }
		    else
			{
			    SendClientMessage(playerid,RED,"this repairshop does not exist");
			}
		}
		else
		{
		    SendClientMessage(playerid,RED,"You have to be part of the repairshop group inorder to use this command");
		}
	}*/
	if(strcmp(choice,"dealership",true,sizeof(choice))==0)
	{
		price = strval(input);
	    new dealershipid = id;
		if(IsPlayerInAnyVehicle(playerid))
		{
			new playerstate = GetPlayerState(playerid);
			if(playerstate == PLAYER_STATE_DRIVER)
			{
			    if((dealershipstate[dealershipid])==1)
			    {
			        if((dealershipownedstate[dealershipid])==1)
			        {
			        	new name[MAX_PLAYER_NAME],string[256];
				        GetPlayerName(playerid,name,sizeof(name));
				        if(strcmp(dealershipownername[dealershipid],name,false,sizeof(name))==0)
				        {
							new vehicleid = GetPlayerVehicleID(playerid);
							new carid = jbcarid[vehicleid];
							if((carstate[carid])==1)
							{
							    if((cartype[carid])==1)
								{
							        if(strcmp(name,carownername[carid],false,sizeof(name))==0)
									{
							            format(carownername[carid],sizeof(carownername),"none");
							            cartype[carid] = 3;
							            carstock[carid] = 0;
							            cardealershipid[carid] = dealershipid;
							            carcost[carid] = price;
	                                    Park(playerid,vehicleid,carid);
	               						format(string,sizeof(string),"%i:Dealership vehicle\nThis vehicle cost $%i\n%s",cardealershipid[carid],carcost[carid],CarStock(carid));
										carlabel[carid] = Create3DTextLabel(string,YELLOW,carx[carid],cary[carid],carz[carid],DISTANCELABEL,0,0);
										Attach3DTextLabelToVehicle(carlabel[carid],car[carid],0,0,0);
										SendClientMessage(playerid,LIGHTBLUE,"You have added your car to your dealership");
							        }
									else
									{
									    SendClientMessage(playerid,RED,"You have to be the owner of this car inorder to add it to your dealership");
									}
							    }
							    else
							    {
							        SendClientMessage(playerid,RED,"You can only add personal vehicle to a dealership");
								}
							}
							else
							{
							    SendClientMessage(playerid,RED,"You can't use this car");
							}
						}
						else
						{
						    SendClientMessage(playerid,RED,"You have to be the owner of the dealership inorder to add the car in");
						}
					}
					else
					{
					    SendClientMessage(playerid,RED,"This dealership is not owned by anyone");
					}
				}
				else
				{
				    SendClientMessage(playerid,RED,"This dealership does not exist");
				}
			}
			else
			{
			    SendClientMessage(playerid,RED,"You have to be the driver inorder to use this command");
			}
		}
		else
		{
		    SendClientMessage(playerid,RED,"You have to be in a vehicle inorder to use this command");
		}
	}
	else
	{
 		SendClientMessage(playerid,RED,"Type:repairshop,dealership");
		SendClientMessage(playerid,RED,"SYNTAX /addmycarto [type] [id(dealership/repairshop)] (if needed [price])");
	}
	return 1;
}
CMD:buycar(playerid, params[])//Working
{//check
    if((playerbeingsoldto[playerid])==5)
	{
		new playercash = GetPlayerMoney(playerid);
		new string[256];
		if((playercash)>=priceforitembeingsold[playerid])
		{
		    if((carstate[itembeingsold[playerid]])==1)
		    {
			    GivePlayerMoney(playerid,-priceforitembeingsold[playerid]);
			    GivePlayerMoney(sellplayer[playerid],priceforitembeingsold[playerid]);
			    format(string,sizeof(string),"You bought %s's car",carownername[itembeingsold[playerid]]);
				GetPlayerName(playerid,carownername[itembeingsold[playerid]],sizeof(carownername));
				SendClientMessage(playerid,LIGHTBLUE,string);
				format(string,sizeof(string),"You have sold %s your car",carownername[itembeingsold[playerid]]);
				SendClientMessage(sellplayer[playerid], LIGHTBLUE, string);
				RemovePlayerFromCar(sellplayer[playerid]);
				SaveQuickCarData(itembeingsold[playerid]);
				itembeingsold[playerid] = 0;
				priceforitembeingsold[playerid] = 0;
				sellplayer[playerid] = 0;
				playerbeingsoldto[playerid] = 0;
			}
			else
			{
			    SendClientMessage(playerid,RED,"This car does not exist");
			}
		}
		else
		{
		    SendClientMessage(playerid,RED,"You don't have enough cash to buy this car");
		}
	}
	else
	{
		SendClientMessage(playerid, RED, "No one is selling a car to you");
	}
	return 1;
}
CMD:sellmycar(playerid, params[])//Working
{//check
	new amount,id,string[256];
    if(sscanf(params,"ui",id,amount))
    {
        return SendClientMessage(playerid,RED,"SYNTAX /sellmycar [playerid] [cost]");
    }
	if(IsPlayerInAnyVehicle(playerid))
	{
		new playerstate = GetPlayerState(playerid);
		if(playerstate == PLAYER_STATE_DRIVER)
		{
		    new vehicleid = GetPlayerVehicleID(playerid);
		    new carid = jbcarid[vehicleid];
		    if((playerbeingsoldto[id])==0)
		    {
			    if((carstate[carid])==1)
			    {
			        if((cartype[carid])==1)
			        {
			            new Float:X, Float:Y, Float:Z;
	    				GetPlayerPos(playerid, X,Y,Z);
			            if(IsPlayerInRangeOfPoint(id,5.5,X,Y,Z))
			        	{
				            if(strcmp(carownername[carid],GetPlayerNameReturn(playerid),false,MAX_PLAYER_NAME)==0)
							{
							    playerbeingsoldto[id] = 5;
							    itembeingsold[id] = carid;
							    sellplayer[id] = playerid;
							    priceforitembeingsold[id] = amount;
								new othername[MAX_PLAYER_NAME];
								GetPlayerName(id,othername,sizeof(othername));
								Park(playerid,vehicleid,carid);
								format(string,sizeof(string),"You have offer %s your %s for $%i",othername,GetVehicleName(carmodelid[carid]),amount);
								SendClientMessage(playerid,LIGHTBLUE,string);
								format(string,sizeof(string),"%s has offered you a %s for $%i. /buycar to accept",othername,GetVehicleName(carmodelid[carid]),amount);
								SendClientMessage(id,LIGHTBLUE,string);
                                SetTimerEx("BuyTimer",60000,false,"i",id);
							}
				            else
				            {
				                SendClientMessage(playerid,RED,"You have to be the owner of the car inorder to sell it");
				            }
						}
						else
						{
						    SendClientMessage(playerid,RED,"You have to be near the player inorder to sell it");
						}
					}
					else
					{
					    SendClientMessage(playerid,RED,"You have to be in a car you can own inorder to sell it");
					}
				}
				else
				{
				    SendClientMessage(playerid,RED,"Some has offer this player an objects already");
				}
			}
		}
		else
		{
			SendClientMessage(playerid,RED,"You have to be the driver inorder to sell this vehicle");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be in a car inorder to sell it");
	}
	return 1;
}
CMD:vcheck(playerid, params[])//Working
{//check
	new string[256];
	new carid = GetClosestPointToPlayer(playerid,8.0,carstate,carx,cary,carz,sizeof(carstate));
	if((carid) != -1)
	{
		if((cartype[carid])==1)
		{
			format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Carowername:%s--Cartype:%i--carfuel:%f--carcolor1:%i--carcolor2:%i--cartotaldistance:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),carownername[carid],cartype[carid],carfuel[carid]);
			SendClientMessage(playerid,-1,string);
			format(string,sizeof(string),"CarX:%f--CarY:%f--CarZ:%f--CarR:%f--carcost:%i--cardealershipid:%i--carlocktype:%i,carlock:%i",carx[carid],cary[carid],carz[carid],carrot[carid],carcost[carid],cardealershipid[carid],carlocktype[carid],carlock[carid]);
			SendClientMessage(playerid,-1,string);
		}
		else if((cartype[carid])==2||(cartype[carid])==3)
		{
			format(string,sizeof(string),"CarID:%i--CarName:%i:%s--Dealerowername:%s--Cartype:%i--carfuel:%f--carcolor1:%i--carcolor2:%i--cartotaldistance:%f",carid,carmodelid[carid],GetVehicleName(carmodelid[carid]),dealershipownername[cardealershipid[carid]],cartype[carid],carfuel[carid]);
			SendClientMessage(playerid,-1,string);
			format(string,sizeof(string),"CarX:%f--CarY:%f--CarZ:%f--CarR:%f--carcost:%i--cardealershipid:%i--carlocktype:%i,carlock:%i--carstock:%i",carx[carid],cary[carid],carz[carid],carrot[carid],carcost[carid],cardealershipid[carid],carlocktype[carid],carlock[carid],carstock[carid]);
			SendClientMessage(playerid,-1,string);
		}
		/*else if((cartype[carid])==4)//#4
		{
			//fill
		}*/
	}
	else
	{
		SendClientMessage(playerid,RED,"You are not near any vehicles");
	}
	return 1;
}
CMD:vlock(playerid,params[])//Working
{
	new carid;
	if(IsPlayerInAnyVehicle(playerid))
	{
		if((carstate[jbcarid[GetPlayerVehicleID(playerid)]]) == 0) return SendClientMessage(playerid,RED,"You can't Lock This car");
		carid = jbcarid[GetPlayerVehicleID(playerid)];
	}
	else
	{
		carid = GetClosestPointToPlayer(playerid,8.0,carstate,carx,cary,carz,sizeof(carstate));
		if(carid == -1) return SendClientMessage(playerid,RED,"You are not near a lockable vehicle");		
	}
	new vehicleid = car[carid];
	if((cartype[carid])==1)
	{
		if(strcmp(GetPlayerNameReturn(playerid),carownername[carid],false,MAX_PLAYER_NAME)==0)
		{
			if((carlocktype[carid])==1)
			{
				new engine,lights,alarm,doors,bonnet,boot,objective;
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				if((carlock[carid])==0)
				{
					doors = 1;
					carlock[carid] = 1;
					SendClientMessage(playerid,LIGHTBLUE,"You have locked your car");
					CheckLockState(playerid,vehicleid);
				}
				else
				{
					doors = 0;
					carlock[carid] = 0;
					SendClientMessage(playerid,LIGHTBLUE,"You have unlocked your car");
					CheckLockState(playerid,vehicleid);
				}
				SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
				SaveQuickCarData(carid);
			}
			else if((carlocktype[carid])==2)
			{
				if((carlock[carid])==0)
				{
					carlock[carid] = 1;
					SendClientMessage(playerid,LIGHTBLUE,"You have locked your car");
					CheckLockState(playerid,vehicleid);
				}
				else
				{
					carlock[carid] = 0;
					SendClientMessage(playerid,LIGHTBLUE,"You have unlocked your car");
					CheckLockState(playerid,vehicleid);
				}
				SaveQuickCarData(carid);
			}
			else
			{
				SendClientMessage(playerid,RED,"There is not lock on this car");
			}
		}
		else
		{
			SendClientMessage(playerid,RED,"this is not your car");
		}
	}
	else if((cartype[carid])==3||(cartype[carid])==2)
	{
		if(strcmp(dealershipownername[cardealershipid[carid]],GetPlayerNameReturn(playerid),false,MAX_PLAYER_NAME)==0)
		{
			new engine,lights,alarm,doors,bonnet,boot,objective;
			GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			if((carlock[carid])==1)
			{
				SendClientMessage(playerid,LIGHTBLUE,"You have unlocked The dealership car");
				doors = 0;
				carlock[carid] = 0;
				CheckLockState(playerid,vehicleid);
				UpdateCarLabel(carid);
			}
			else
			{
				SendClientMessage(playerid,LIGHTBLUE,"You have locked The dealership car");
				doors = 1;
				carlock[carid] = 1;
				CheckLockState(playerid,vehicleid);
				UpdateCarLabel(carid);
			}
			SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			SaveQuickCarData(carid);
		}
		else
		{
			SendClientMessage(playerid,RED,"You have to be the owner of this dealership inorder to lock the car");
		}
	}
	else
	{
		SendClientMessage(playerid,RED,"You can't lock this car");
	}
	return 1;
}
CMD:setvehiclecolor(playerid, params[])//Working
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new color1s[64],color2s[64],color1,color2;
		if(sscanf(params,"s["#64"]s["#64"]",color1s,color2s))
		{
			SendClientMessage(playerid,RED,"SYNTAX [color1][color2]");
			SendClientMessage(playerid, RED, "Colors:Black,Red,Blue,Green,Purple,Yellow,Pink,White,Grey,Random");
			SendClientMessage(playerid, RED, "You can also use number ID's");
			return 1;
		}
		if(strcmp(color1s,"black",true,64)==0)
		{
	    	color1 = 127;
  		}
 		else if(strcmp(color1s,"red",true,64)==0)
		{
			color1 = 175;
   		}
		else if(strcmp(color1s,"blue",true,64)==0)
		{
			color1 = 166;
   		}
		else if(strcmp(color1s,"green",true,64)==0)
		{
			color1 = 229;
		}
		else if(strcmp(color1s,"purple",true,64)==0)
		{
			color1 = 157;
		}
		else if(strcmp(color1s,"yellow",true,64)==0)
  		{
    		color1 = 142;
      	}
       	else if(strcmp(color1s,"pink",true,64)==0)
        {
			color1 = 136;
  		}
		else if(strcmp(color1s,"white",true,64)==0)
		{
			color1 = 1;
   		}
   		else if(strcmp(color1s,"grey",true,64)==0)
     	{
			color1 = 71;
		}
		else if(strcmp(color1s,"Random",true,64)==0)
		{
            color1 = random(255);
			format(color1s,sizeof(color1s),"none");
		}
  		else
		{
		    if(strcmp(color1s,"none",false,64)==0)
		    {

		    }
		    else
			{
				color1 = strval(color1s);
			}
			if((color1) <= 255)
			{
				if((color1) ==0)
				{
				    SendClientMessage(playerid, RED, "instead of entering 0 please enter Black");
				    SendClientMessage(playerid, RED, "Colors:Black,Red,Blue,Green,Purple,Yellow,Pink,White,Grey,Random");
					SendClientMessage(playerid, RED, "You can also use number ID's");
				    return 1;
				}
			}
			else
			{
    			SendClientMessage(playerid, RED, "Color1 is greater the 255, there are only 255 color ids");
				return 1;
			}
		}
		if(strcmp(color2s,"black",true,64)==0)
		{
	    	color2 = 127;
  		}
  		else if(strcmp(color2s,"red",true,64)==0)
    	{
			color2 = 175;
		}
	 	else if(strcmp(color2s,"blue",true,64)==0)
		{
        	color2 = 166;
		}
  		else if(strcmp(color2s,"green",true,64)==0)
    	{
     		color2 = 229;
       	}
        else if(strcmp(color2s,"purple",true,64)==0)
        {
			color2 = 157;
   		}
     	else if(strcmp(color2s,"yellow",true,64)==0)
      	{
       		color2 = 142;
       	}
        else if(strcmp(color2s,"pink",true,64)==0)
        {
			color2 = 136;
   		}
     	else if(strcmp(color2s,"white",true,64)==0)
      	{
       		color2 = 1;
       	}
        else if(strcmp(color2s,"grey",true,64)==0)
        {
        	color2 = 71;
        }
 		else if(strcmp(color2s,"Random",true,64)==0)
		{
            color2 = random(255);
            format(color2s,sizeof(color2s),"none");
		}
        else
        {
		    if(strcmp(color2s,"none",true,64)==0)
		    {

		    }
		    else
			{
				color2 = strval(color2s);
			}
			if((color2) <= 255)
			{
				if((color2) ==0)
				{
				    SendClientMessage(playerid, RED, "instead of entering 0 please enter Black");
				    SendClientMessage(playerid, RED, "Colors:Black,Red,Blue,Green,Purple,Yellow,Pink,White,Grey,Random");
					SendClientMessage(playerid, RED, "You can also use number ID's");
				    return 1;
				}
			}
			else
			{
    			SendClientMessage(playerid, RED, "Color2 is greater the 255, there are only 255 color ids");
				return 1;
			}
		}
	    new vehicleid = GetPlayerVehicleID(playerid);
		new carid = jbcarid[vehicleid];
		if((carstate[carid])==1)
		{
		    if((cartype[carid])==2||(cartype[carid])==3)
		    {
		        if(strcmp(dealershipownername[cardealershipid[carid]],GetPlayerNameReturn(playerid),false,MAX_PLAYER_NAME)==0)
		        {
					carcolor1[carid] = color1;
					carcolor2[carid] = color2;
      				ChangeVehicleColor(vehicleid,carcolor1[carid],carcolor2[carid]);
		        	SendClientMessage(playerid,LIGHTBLUE,"You have change the colour of the vehicle");
					SaveQuickCarData(carid);
		        }
		        else
		        {
		            SendClientMessage(playerid,RED,"You have to be the owner of this vehicle to edit the colour");
		        }
		    }
		    /*else if((cartype[carid])==4)//#4
        	{
        	    if((repairshopgroup[playerid])==1)
        	    {
        	        new string[256],name[MAX_PLAYER_NAME];
 					carcolor1[carid] = color1;
					carcolor2[carid] = color2;
      				ChangeVehicleColor(vehicleid,carcolor1[carid],carcolor2[carid]);
		        	SendClientMessage(playerid,LIGHTBLUE,"You have change the colour of the vehicle");
					SaveQuickCarData(carid);
			        GetPlayerName(playerid,name,sizeof(name));
			        format(string,sizeof(string),"%s has changed the vehicle colour for the ID:%i modelid- %i:%s",name,carid,carmodelid[carid],GetVehicleName(carmodelid[carid]));
					SaveRepairshopLog(string);
					for(new i;i < MAX_PLAYERS;i++)
					{
					    if(IsPlayerConnected(i))
					    {
					        SendClientMessage(i,REPAIRSHOPCOLOR,string);
					    }
					}
				}
				else
				{
				    SendClientMessage(playerid,RED,"You have to be in a repairshop group inorder to change the colour");
				}
        	}*/
		    else
		    {
		        if(IsPlayerAdmince(playerid,1))
			    {
                    carcolor1[carid] = color1;
					carcolor2[carid] = color2;
      				ChangeVehicleColor(vehicleid,carcolor1[carid],carcolor2[carid]);
		        	SendClientMessage(playerid,LIGHTBLUE,"You have change the colour of the vehicle");
		        	SaveQuickCarData(carid);
			    }
			    else
			    {
					SendClientMessage(playerid,RED,"You have to be admin or the dealershipowner inorder to use this command");
			    }
		    }
		}
		else
		{
		    if(IsPlayerAdmince(playerid,1))
		    {
		        ChangeVehicleColor(vehicleid,color1,color2);
	        	SendClientMessage(playerid,LIGHTBLUE,"You have change the colour of the vehicle");
		    }
		    else
		    {
				SendClientMessage(playerid,RED,"You have to be admin or the dealershipowner inorder to use this command");
		    }
		}
	}
	else
	{
		SendClientMessage(playerid,RED,"You have to be in a vehicle inorder to use this command");
	}
	return 1;
}
CMD:delivercars(playerid, params[])
{//Check
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new vehicleid = GetPlayerVehicleID(playerid);
	    new modelid = GetVehicleModel(vehicleid);
	    new string[1024],addstr[1024],factorycount;
	    if((modelid)==443)
		{
		    new playerstate = GetPlayerState(playerid);
		    if(playerstate == PLAYER_STATE_DRIVER)
		    {
				if((deliverystate[playerid])==0)
				{
					for(new count;count < MAX_FACTORIES;count++)
					{
					    if((factorystate[count])==1)
						{
							if(IsPlayerInRangeOfPoint(playerid,8.0,factoryx[count],factoryy[count],factoryz[count]))
							{
							    if((factoryownedstate[count])==1)
							    {
									for(new count2;count2 < FACTORYMAXORDERSATONCE;count2++)
									{
									    if((factorystockstate[count2][count])==2)
									    {
									        if((factorydeliverying[count2][count])==0)
									        {
										        factorycount++;
												if(isnull(string))
												{
												    format(string,sizeof(string),"%s:%i %s(s)",dealershipname[factorydealershipid[count2][count]],factorystock[count2][count],GetVehicleName(factorydealerstockmodelid[count2][count]));
												}
												else
												{
													format(addstr,sizeof(addstr),"%s\n%s:%i %s(s)",string,dealershipname[factorydealershipid[count2][count]],factorystock[count2][count],GetVehicleName(factorydealerstockmodelid[count2][count]));
													format(string,sizeof(string),"%s",addstr);
												}
											}
									    }
									}
									if((factorycount)>0)
									{
										deliverystate[playerid] = 1;
										deliveryfactoryid[playerid] = count;
									    ShowPlayerDialog(playerid,FACTORYDELIVERY,DIALOG_STYLE_LIST,"Deliver Cars",string,"Select","Close");
									}
									else
									{
                                        ShowPlayerDialog(playerid,CANCEL,DIALOG_STYLE_MSGBOX,"Deliver Cars","This factory has no cars compleatly manufactured","Close","Close");
									}
							    }
							    else
							    {
							        SendClientMessage(playerid,RED,"This factory is not owned by anyone");
							    }
							    return 1;
							}
						}
					}
				}
				else
				{
				    SendClientMessage(playerid,RED,"You are already on a delivery");
				}
			}
			else
			{
			    SendClientMessage(playerid,RED,"You have to be driveing the truck inorder to deliver cars");
			}
		}
		else
		{
		    SendClientMessage(playerid,RED,"You have to be in the 'Packer' truck inorder to deliver cars");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be in a vehicle inorder to use this command");
	}
	return 1;
}
CMD:movefactory(playerid, params[])//Working
{
	new factoryid,reason[64],str[256],name[MAX_PLAYER_NAME];
	if(sscanf(params,"is["#64"]",factoryid,reason))
	{
	    return SendClientMessage(playerid,RED,"/movefactory [factoryid] [reason]");
	}
    if(IsPlayerAdmince(playerid,3))
    {
        if((factorystate[factoryid])==1)
		{
		    GetPlayerName(playerid,name,sizeof(name));
		    if((factoryownedstate[factoryid])==1)
		    {
		        if(!IsPlayerAdmince(playerid,4))
    			{
					return SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
    			}
    			format(str,sizeof(str),"[ADMIN:%s] has moved factory [ID:%i][ownername:%s][Reason:%s]",name,factoryid,factoryownername[factoryid],reason);
		    }
		    else
		    {
		        format(str,sizeof(str),"[ADMIN:%s] has moved factory [ID:%i][ownername:%s][Reason:%s]",name,factoryid,factoryownername[factoryid],reason);
		    }
		    GetPlayerPos(playerid,factoryx[factoryid],factoryy[factoryid],factoryz[factoryid]);
		    SendClientMessage(playerid,PINK,"You have moved the factory");
		    SendClientMessageToAll(PINK,str);
		    SaveQuickFactoryData(factoryid);
		    Delete3DTextLabel(factorylabel[factoryid]);
		    format(str,sizeof(str),"Factory id:%i\n%s\nfactoryproductionstate:%s",factoryid,FactoryOwnedState(factoryid),FactoryProductionState(factoryid));
      		factorylabel[factoryid] = Create3DTextLabel(str,YELLOW,factoryx[factoryid],factoryy[factoryid],factoryz[factoryid],DISTANCELABEL,0,0);
		}
		else
		{
		    SendClientMessage(playerid,RED,"This factory does not exist");
		}
    }
    else
    {
        SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
    }
	return 1;
}
CMD:movegasstation(playerid, params[])//Working
{
	new gasstationid,reason[64],str[256],name[MAX_PLAYER_NAME];
	if(sscanf(params, "is["#64"]",gasstationid,reason))
	{
	    return SendClientMessage(playerid, RED, "/movegasstation [gasstationid] [reason]");
	}
	if(IsPlayerAdmince(playerid,3))
    {
        if((gasstationstate[gasstationid])==1)
        {
            GetPlayerName(playerid,name,sizeof(name));
            if((gasstationownedstate[gasstationid])==1)
            {
				if(!IsPlayerAdmince(playerid,4))
				{
				    return SendClientMessage(playerid, RED, "You have to be an admin inorder to use this command");
				}
				format(str,sizeof(str),"[ADMIN:%s] has moved gasstation [ID:%i][ownername:%s][Reason:%s]",name,gasstationid,gasstationownername[gasstationid],reason);
			}
			else
			{
			    format(str,sizeof(str),"[ADMIN:%s] has moved gasstation [ID:%i][Reason:%s]",name,gasstationid,reason);
			}
			GetPlayerPos(playerid,gasstationx[gasstationid],gasstationy[gasstationid],gasstationz[gasstationid]);
			SendClientMessage(playerid, RED, "You have moved the gasstation");
			SendClientMessageToAll(PINK,str);
			SaveQuickGasStationData(gasstationid);
			Delete3DTextLabel(gasstationlabel[gasstationid]);
   			format(str,sizeof(str),"%s\ngasstationID:%i\n%s\nyou have %f gas",gasstationname[gasstationid],gasstationid,GasStationOwner(gasstationid),TotalGasInGasStation(gasstationid));
	        gasstationlabel[gasstationid] = Create3DTextLabel(str,YELLOW,gasstationx[gasstationid],gasstationy[gasstationid],gasstationz[gasstationid],DISTANCELABEL,0,0);
        }
        else
        {
            SendClientMessage(playerid, RED, "This gasstation does not exist");
        }
    }
    else
    {
        SendClientMessage(playerid, RED, "You have to be admin inorder to use this command");
    }
	return 1;
}
CMD:moverefinery(playerid, params[])//Working
{
	new refineryid,reason[64],str[256],name[MAX_PLAYER_NAME];
	if(sscanf(params,"is["#64"]",refineryid,reason))
	{
	    return SendClientMessage(playerid,RED,"/moverefinery [refineryid] [reason]");
	}
    if(IsPlayerAdmince(playerid,3))
    {
        if((refinerystate[refineryid])==1)
        {
            GetPlayerName(playerid,name,sizeof(name));
            if((refineryownedstate[refineryid])==1)
            {
                if(!IsPlayerAdmince(playerid,4))
                {
					return SendClientMessage(playerid, RED, "You have to be admin inorder to use this");
                }
                format(str,sizeof(str),"[ADMIN:%s] has moved refinery [ID:%i][ownername:%s][Reason:%s]",name,refineryid,refineryownername[refineryid],reason);
            }
            else
            {
                format(str,sizeof(str),"[ADMIN:%s] has moved refinery [ID:%i][Reason:%s]",name,refineryid,reason);
			}
            GetPlayerPos(playerid,refineryx[refineryid],refineryy[refineryid],refineryz[refineryid]);
            SendClientMessage(playerid,LIGHTBLUE,"You have move the refinery");
			SendClientMessageToAll(PINK,str);
            SaveQuickRefineryData(refineryid);
            Delete3DTextLabel(refinerylabel[refineryid]);
			format(str,sizeof(str),"Refinery:%i\nRefinery state:%s\n%s\nthere is a total of %f fuel",refineryid,RefineryProductionState(refineryid),RefineryOwner(refineryid),TotalOil(refineryid));
			refinerylabel[refineryid] = Create3DTextLabel(str,YELLOW,refineryx[refineryid],refineryy[refineryid],refineryz[refineryid],DISTANCELABEL,0,0);
        }
        else
        {
            SendClientMessage(playerid, RED, "This refinery does not exist");
        }
    }
    else
    {
        SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
    }
	return 1;
}
CMD:movedealership(playerid, params[])//Working
{
	new dealershipid,reason[64],string[256],name[MAX_PLAYER_NAME];
	if(sscanf(params, "is["#64"]", dealershipid,reason))
	{
	    return SendClientMessage(playerid,RED,"SYNTAX /movedealership [dealershipid] [reason]");
	}
	if(IsPlayerAdmince(playerid,3))
	{
		if((dealershipstate[dealershipid])==1)
		{
		    GetPlayerName(playerid,name,sizeof(name));
			if((dealershipownedstate[dealershipid])==1)
			{
			    if(!IsPlayerAdmince(playerid, 4))
			    {
			    	return SendClientMessage(playerid,RED,"you have to be a higher level admin inorder to use this command");
			    }
			    format(string,sizeof(string),"[ADMIN:%s] has moved dealership [ID:%i][ownername:%s][Reason:%s]",name,dealershipid,dealershipownername[dealershipid],reason);
			}
			else
			{
			    format(string,sizeof(string),"[ADMIN:%s] has moved dealership [ID:%i][Reason:%s]",name,dealershipid,reason);
			}
			GetPlayerPos(playerid,dealershipx[dealershipid],dealershipy[dealershipid],dealershipz[dealershipid]);
			SendClientMessage(playerid,LIGHTBLUE,"You have moved the dealership");
			SendClientMessageToAll(PINK,string);
			SaveQuickDealershipData(dealershipid);
			Delete3DTextLabel(dealershiplabel[dealershipid]);
  			format(string,sizeof(string),"%s\ndealership:%i\n%s",dealershipname[dealershipid],dealershipid,DealershipOwner(dealershipid));
	        dealershiplabel[dealershipid] = Create3DTextLabel(string,YELLOW,dealershipx[dealershipid],dealershipy[dealershipid],dealershipz[dealershipid],DISTANCELABEL,0,0);
		}
		else
		{
		    SendClientMessage(playerid,RED,"this dealership does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:setvehiclebuildspeed(playerid, params[])//Working
{//check
	if(IsPlayerAdmince(playerid,5))
	{
		new index;
		if(sscanf(params,"i",index))
		{
		    SendClientMessage(playerid, RED, "SYNTAX /setvehiclebuildspeed [vehicle price increase amount]");
		    SendClientMessage(playerid, ORANGE, "!Note vehicle build base on there price the price will increase ever so ofter till it hits its compleated price");
		    return 1;
		}
		if((index) > 0)
		{
		    new string[256];
		    format(string,sizeof(string),"[ADMIN:%s]has set the vehicle build speed amount from %i to %i",GetPlayerNameReturn(playerid),vehiclebuildamountincrease,index);
            vehiclebuildamountincrease = index;
            new INI:filedata = INI_Open(mainfilename);
			INI_WriteInt(filedata,"vehiclebuildamountincrease",vehiclebuildamountincrease);
			INI_Close(filedata);
			SendClientMessageToAll(PINK,string);
		}
		else
		{
		    SendClientMessage(playerid, RED, "You can't make vehicle build speed less then 0");
		}
	}
	else
	{
		SendClientMessage(playerid, RED, "You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:removecar(playerid, params[])//Working
{//check
    new vehicleid,string[256],name[MAX_PLAYER_NAME];
	if(IsPlayerInAnyVehicle(playerid))
	{
 		new playerstate = GetPlayerState(playerid);
		if(playerstate != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, RED, "You have to be in the driver seat inorder to remove this vehicle");
		vehicleid = GetPlayerVehicleID(playerid);
	}
	else
	{
		if(sscanf(params,"i",vehicleid)) return SendClientMessage(playerid, RED, "SYNTAX /removecar [vehicleid]");
	}
	new carid = jbcarid[vehicleid];
	if((carstate[carid])==1)
	{
	    GetPlayerName(playerid,name,sizeof(name));
	    if((cartype[carid])==3)
	    {
    		SendClientMessage(playerid,RED,"You can't remove a used car");
	    }
	    else if((cartype[carid])==2)
	    {
			if(strcmp(name,dealershipownername[cardealershipid[carid]],false,sizeof(name))==0||IsPlayerAdmince(playerid,4))
			{
				if((carstock[carid]) > 0)
				{
				    SendClientMessage(playerid,RED,"All cars in your stock have to be sold inorder to remove it");
				    return 1;
				}
			    if((requeststockstate[carmodelid[carid ] - 400][cardealershipid[carid]])==2)
			    {
				    new totalcarscash = (VehicleManufactureingPrice(carmodelid[carid]) * requeststock[carmodelid[carid] - 400][cardealershipid[carid]]) / 2;
				    format(string,sizeof(string),"You also canceled your request for %i car(s) for $%i",requeststock[carmodelid[carid] - 400][cardealershipid[carid]],totalcarscash);
				    requeststock[carmodelid[carid] - 400][cardealershipid[carid]] = 0;
				    SendClientMessage(playerid,RED,string);
				    dealershipordercash[cardealershipid[carid]] = dealershipordercash[cardealershipid[carid]] - totalcarscash;
				    dealershipcash[cardealershipid[carid]] = dealershipcash[cardealershipid[carid]] + totalcarscash;
				}
				else if((requeststockstate[carmodelid[carid] - 400][cardealershipid[carid]])==3)
				{
					SendClientMessage(playerid, RED, "The factory is current produceing this vehicle you can't delete it");
					return 1;
				}
				else if((requeststockstate[carmodelid[carid]-400][cardealershipid[carid]])==4)
				{
				    SendClientMessage(playerid, RED, "The factory has you vehicle ready to go, You can delete it");
				    return 1;
				}
	   			new halfprice = VehicleManufactureingPrice(carmodelid[carid]);
				dealershipcash[cardealershipid[carid]] = dealershipcash[cardealershipid[carid]] + halfprice;
				format(string,sizeof(string),"You have remove the cars for $%i",halfprice);
				SendClientMessage(playerid, LIGHTBLUE,string);
	 			requeststock[carmodelid[carid] - 400][cardealershipid[carid]] = 0;
	    		requeststockstate[carmodelid[carid] - 400][cardealershipid[carid]] = 0;
				SaveQuickDealershipData(cardealershipid[carid]);
				fuel[car[carid]] = 100.0;
				DestroyVehicle(car[carid]);
				Delete3DTextLabel(carlabel[carid]);
				DeleteCarData(carid);
			}
			else
			{
			    SendClientMessage(playerid,RED,"You have to be the owner of the dealership or admin inorder to remove this vehicle");
			}
	    }
	    else if((cartype[carid])==1)
	    {
	        if(strcmp(name,carownername[carid],false,sizeof(name))==0)
	        {
                choicemodelid[playerid] = carid;
				ShowPlayerDialog(playerid,VEHICLEREMOVECONFIRM,DIALOG_STYLE_MSGBOX,"Remove Car","Are you sure you wish to remove your car? Once you remove it you can't get it back.","Yes","No");
	        }
	        else
			{
			    SendClientMessage(playerid,RED,"You are not the owner of this car");
			}
	    }
	    else
	    {
	        SendClientMessage(playerid,RED,"You Can't remove this car");
	    }
	}
	else
	{
	    if(IsPlayerAdmince(playerid,2))
	    {
			fuel[vehicleid] = 100.0;
	    	DestroyVehicle(vehicleid);
			SendClientMessage(playerid, RED, "You have destroyed the car");
		}
		else
		{
		    SendClientMessage(playerid, RED, "You have to be admin inorder to remove a car that is not a jbcar");
		}
	}
	return 1;
}
CMD:setvehicleprice(playerid, params[])//Working
{
	new price;
	if(sscanf(params,"i",price))
	{
		return SendClientMessage(playerid, RED, "SYNTAX /setvehicleprice [price]");
	}
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new playerstate = GetPlayerState(playerid);
	    if(playerstate == PLAYER_STATE_DRIVER)
	    {
	        new vehicleid = GetPlayerVehicleID(playerid);
	        new carid = jbcarid[vehicleid];
	        new string[256];
	        if((carstate[carid])==1)
	        {
	            if((cartype[carid])==2||(cartype[carid])==3)
	            {
					if(strcmp(GetPlayerNameReturn(playerid),dealershipownername[cardealershipid[carid]],false,MAX_PLAYER_NAME)==0)
					{
					    format(string,sizeof(string),"You change the price of the %s from $%i to $%i",GetVehicleName(carmodelid[carid]),carcost[carid],price);
					    carcost[carid] = price;
					    SendClientMessage(playerid,LIGHTBLUE,string);
					    UpdateCarLabel(carid);
					    SaveQuickCarData(carid);
					}
					else
					{
					    SendClientMessage(playerid, RED, "This car is not part of your dealership");
					}
	            }
	            else
	            {
	                SendClientMessage(playerid, RED, "You can't change the price of this car");
	            }
	        }
	        else
	        {
	            SendClientMessage(playerid, RED, "You can't change the price of this car");
	        }
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "You have to be in the driver seat inorder to set the price of the vehicle");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be in a vehicle inorder to set the vehicle price");
	}
	return 1;
}
CMD:gotofactory(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,1))
	{
		new index,string[256];
		if(sscanf(params,"i",index))
		{
		    return SendClientMessage(playerid, RED, "SYNTAX /gotofactory [factoryid]");
		}
	    if((factorystate[index])==1)
	    {
			if(IsPlayerInAnyVehicle(playerid))
			{
				new playerstate = GetPlayerState(playerid);
				if(playerstate == PLAYER_STATE_DRIVER)
				{
					new vehicleid = GetPlayerVehicleID(playerid);
					SetVehiclePos(vehicleid,factoryx[index],factoryy[index],factoryz[index]);
					format(string,sizeof(string),"You have teleported to factory:%i",index);
					SendClientMessage(playerid, LIGHTBLUE,string);
				}
				else
				{
				    SendClientMessage(playerid, RED, "You have to be the driver inorder to teleport with a vehicle");
				}
			}
			else
			{
				SetPlayerPos(playerid,factoryx[index],factoryy[index],factoryz[index]);
				format(string,sizeof(string),"You have teleported to factory:%i",index);
				SendClientMessage(playerid, LIGHTBLUE,string);
			}
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "This factory does not exist");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be an admin inorder to use this command");
	}
	return 1;
}
CMD:factorymenu(playerid, params[])//Working
{
	for(new count;count < MAX_FACTORIES;count++)
	{
	    if((factorystate[count])==1)
	    {
	        if(IsPlayerInRangeOfPoint(playerid,8,factoryx[count],factoryy[count],factoryz[count]))
	        {
	            if((factoryownedstate[count])==1)
	            {
	                if(strcmp(GetPlayerNameReturn(playerid),factoryownername[count],false,MAX_PLAYER_NAME)==0)
	                {
	                    editobjfactory[playerid] = count;
						ShowPlayerDialog(playerid,FACTORYMENU,DIALOG_STYLE_LIST,"Factory Menu",FACTORYMENUSTATEMENT,"Ok","Close");
	                }
	                else
	                {
						SendClientMessage(playerid, RED, "this is not your factory");
	                }
	            }
	            else
	            {
	                SendClientMessage(playerid, RED, "This factory is not owned by anyone");
	            }
	            return 1;
	        }
		}
	}
	return 1;
}
CMD:createfactory(playerid, params[])//Working
{
	new price;
	if(sscanf(params,"i",price))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /createcarfactory [cost]");
	}
	if(IsPlayerAdmince(playerid, 3))
	{
	    for(new count;count < MAX_FACTORIES;count++)
	    {
	        if((factorystate[count])==0)
	        {
	            new string[256];
	            factorystate[count] = 1;
	            factorycost[count] = price;
	            GetPlayerPos(playerid,factoryx[count],factoryy[count],factoryz[count]);
	            format(string,sizeof(string),"Factory id:%i\n%s\nfactoryproductionstate:%s",count,FactoryOwnedState(count),FactoryProductionState(count));
	            factorylabel[count] = Create3DTextLabel(string,YELLOW,factoryx[count],factoryy[count],factoryz[count],DISTANCELABEL,0,0);
	            SaveQuickFactoryData(count);
				SendClientMessage(playerid, LIGHTBLUE, "You have create a car factory");
				return 1;
	        }
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be an admin inorder to add a dealership");
	}
	return 1;
}
CMD:deletefactory(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid, 3))
	{
		new factoryid;
		if(sscanf(params,"i",factoryid))
		{
		    return SendClientMessage(playerid, RED, "SYNTAX /deletecarfactory [factoryid]");
		}
		if((factorystate[factoryid])==1)
		{
		    if((factoryownedstate[factoryid])==0)
		    {
				Delete3DTextLabel(factorylabel[factoryid]);
				DeleteFactoryData(factoryid);
				SendClientMessage(playerid,RED,"You delete a factory");
		    }
		    else
		    {
		        SendClientMessage(playerid, RED, "This factory is owned by someone you can't delete it");
		    }
		}
		else
		{
		    SendClientMessage(playerid, RED, "This factory does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be an admin inorder to delete a dealership");
	}
	return 1;
}
CMD:buyfactory(playerid, params[])//Working
{
	for(new count;count < MAX_FACTORIES;count++)
	{
		if((factorystate[count])==1)
		{
		    if(IsPlayerInRangeOfPoint(playerid,5.0,factoryx[count],factoryy[count],factoryz[count]))
		    {
			    if((factoryownedstate[count])==0)
				{
					new money = GetPlayerMoney(playerid),string[256];
					if((factorycost[count]) <= money)
					{
					    GivePlayerMoney(playerid,-factorycost[count]);
					    factoryownedstate[count] = 1;
						GetPlayerName(playerid,factoryownername[count],sizeof(factoryownername));
						format(string,sizeof(string),"you paid $%i for factoryID:%i",factorycost[count],count);
						SendClientMessage(playerid,LIGHTBLUE,string);
						UpdateFactoryLabel(count);
						SaveQuickFactoryData(count);
					}
					else
					{
					    SendClientMessage(playerid, RED, "You don't have enought cash to buy this factory");
					}
				}
				else
				{
				    SendClientMessage(playerid, RED, "You can't buy a factory that has already been bought");
				}
				return 1;
			}
		}
	}
	return 1;
}
CMD:sellfactory(playerid, params[])//Working
{
	new factoryid;
	if(sscanf(params,"i",factoryid))
	{
		return SendClientMessage(playerid, RED, "SYNTAX /sellfactroy [factoryid]");
	}
	if((factorystate[factoryid])==1)
	{
	    if((factoryownedstate[factoryid])==1)
	    {
	        new string[256];
	        if(strcmp(GetPlayerNameReturn(playerid),factoryownername[factoryid],false,MAX_PLAYER_NAME)==0)
	        {
				for(new count;count < FACTORYMAXORDERSATONCE;count++)
				{
				    if((factorystockstate[count][factoryid])==1||(factorystockstate[count][factoryid])==2)
				    {
				        SendClientMessage(playerid,RED,"You can't sell the factory with vehicle in production");
				        return 1;
				    }
				}
				GivePlayerMoney(playerid,factorycost[factoryid] / 2);
				format(string,sizeof(string),"You have sold your factory for half the price ($%i)",factorycost[factoryid]);
				SendClientMessage(playerid, LIGHTBLUE, string);
				if((factorycash[factoryid]) > 0)
				{
					format(string,sizeof(string),"You have left $%i in your safe that has been added to your account",factorycash[factoryid]);
				    GivePlayerMoney(playerid,factorycash[factoryid]);
				    SendClientMessage(playerid,LIGHTBLUE,string);
				}
				factoryownedstate[factoryid] = 0;
				factorycash[factoryid] = 0;
				factoryproductionstate[factoryid] = 0;
				format(factoryownername[factoryid],sizeof(factoryownername),"");
				UpdateFactoryLabel(factoryid);
				SaveQuickFactoryData(factoryid);
	        }
	        else
	        {
	            SendClientMessage(playerid, RED, "This factory is not owned by you");
	        }
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "This factory is not owned by anyone");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "This factory does not exist");
	}
	return 1;
}
CMD:park(playerid, params[])//Working
{
	new vehicleid = GetPlayerVehicleID(playerid);
	new carid = jbcarid[vehicleid];
	if((carstate[carid])==1)
	{
		new name[MAX_PLAYER_NAME];
		GetPlayerName(playerid,name,sizeof(name));
		if((cartype[carid])==2||(cartype[carid])==3)
		{
			if(strcmp(name,dealershipownername[cardealershipid[carid]],false,sizeof(dealershipownername))==0)
			{
			    Park(playerid,vehicleid,carid);
			}
			else
			{
			    SendClientMessage(playerid, RED, "You Can't Park This Car, You don't own this dealership");
			}
		}
		else if((cartype[carid])==1)
		{
		    if(strcmp(name,carownername[carid],false,sizeof(name))==0)
		    {
		        Park(playerid,vehicleid,carid);
		    }
		    else
		    {
		        SendClientMessage(playerid, RED, "You can't park this car, You don't own it");
		    }
		}
		/*else if((cartype[carid])==4)//#4
		{
		    if((repairshopgroup[playerid])==1)
		    {
		        Park(playerid,vehicleid,carid);
		    }
		    else
		    {
		        SendClientMessage(playerid,RED,"You have to be part of the repairshop inorder to park this vehicle");
		    }
		}*/
	}
	else
	{
	    SendClientMessage(playerid, RED, "You Can't Park This Car");
	}
	return 1;
}
CMD:acceptfactory(playerid, params[])
{//check
    if((playerbeingsoldto[playerid])==4)
	{
		new playercash = GetPlayerMoney(playerid);
		new string[256];
		if((playercash)>=priceforitembeingsold[playerid])
		{
		    GivePlayerMoney(playerid,-priceforitembeingsold[playerid]);
		    GivePlayerMoney(sellplayer[playerid],priceforitembeingsold[playerid]);
		    if((factorycash[itembeingsold[playerid]]) > 0)
		    {
		    	GivePlayerMoney(playerid,factorycash[itembeingsold[playerid]]);
		        format(string,sizeof(string),"You left $%i in the factory safe",factorycash[itembeingsold[playerid]]);
				SendClientMessage(sellplayer[playerid],LIGHTBLUE,string);
		        factorycash[itembeingsold[playerid]] = 0;
		    }
		    format(string,sizeof(string),"You bought %s's factory",factoryownername[itembeingsold[playerid]]);
			GetPlayerName(playerid,factoryownername[itembeingsold[playerid]],sizeof(factoryownername));
			UpdateFactoryLabel(itembeingsold[playerid]);
			SendClientMessage(playerid,LIGHTBLUE,string);
			format(string,sizeof(string),"You have sold %s you dealership",factoryownername[itembeingsold[playerid]]);
			SendClientMessage(sellplayer[playerid], LIGHTBLUE, string);
            SaveQuickFactoryData(itembeingsold[playerid]);
			itembeingsold[playerid] = 0;
			priceforitembeingsold[playerid] = 0;
			sellplayer[playerid] = 0;
			playerbeingsoldto[playerid] = 0;
		}
		else
		{
		    SendClientMessage(playerid,RED,"You don't have enough cash to buy this factory");
		}
	}
	else
	{
		SendClientMessage(playerid, RED, "No one is selling a factory to you");
	}
	return 1;
}
CMD:acceptdealership(playerid, params[])//Working
{
    if((playerbeingsoldto[playerid])==3)
	{
		new playercash = GetPlayerMoney(playerid);
		new string[256];
		if((playercash)>=priceforitembeingsold[playerid])
		{
		    GivePlayerMoney(playerid,-priceforitembeingsold[playerid]);
		    GivePlayerMoney(sellplayer[playerid],priceforitembeingsold[playerid]);
		    if((dealershipcash[itembeingsold[playerid]]) > 0)
		    {
		    	GivePlayerMoney(playerid,dealershipcash[itembeingsold[playerid]]);
		        format(string,sizeof(string),"You left $%i in the dealership safe",dealershipcash[itembeingsold[playerid]]);
				SendClientMessage(sellplayer[playerid],LIGHTBLUE,string);
		        dealershipcash[itembeingsold[playerid]] = 0;
		    }
		    format(string,sizeof(string),"You bought %s's dealership",gasstationownername[itembeingsold[playerid]]);
			GetPlayerName(playerid,dealershipownername[itembeingsold[playerid]],sizeof(dealershipownername));
			format(dealershipname[itembeingsold[playerid]],sizeof(dealershipname),"%s's gasstation",dealershipownername[itembeingsold[playerid]]);
			UpdateDealershipLabels(itembeingsold[playerid]);
			SendClientMessage(playerid,LIGHTBLUE,string);
			format(string,sizeof(string),"You have sold %s you dealership",dealershipownername[itembeingsold[playerid]]);
			SendClientMessage(sellplayer[playerid], LIGHTBLUE, string);
			SaveQuickDealershipData(itembeingsold[playerid]);
			itembeingsold[playerid] = 0;
			priceforitembeingsold[playerid] = 0;
			sellplayer[playerid] = 0;
			playerbeingsoldto[playerid] = 0;
		}
		else
		{
		    SendClientMessage(playerid,RED,"You don't have enough cash to buy this gasstation");
		}
	}
	else
	{
		SendClientMessage(playerid, RED, "No one is selling a dealership to you");
	}
	return 1;
}
CMD:acceptgasstation(playerid, params[])//Working
{
	if((playerbeingsoldto[playerid])==1)
	{
		new playercash = GetPlayerMoney(playerid);
		new string[256];
		if((playercash)>=priceforitembeingsold[playerid])
		{
		    GivePlayerMoney(playerid,-priceforitembeingsold[playerid]);
		    GivePlayerMoney(sellplayer[playerid],priceforitembeingsold[playerid]);
		    if((gasstationcash[itembeingsold[playerid]]) >0)
		    {
		        GivePlayerMoney(playerid,gasstationcash[itembeingsold[playerid]]);
		        format(string,sizeof(string),"You left $%i in the gasstation safe",gasstationcash[itembeingsold[playerid]]);
				SendClientMessage(sellplayer[playerid],LIGHTBLUE,string);
		        gasstationcash[itembeingsold[playerid]] = 0;
		    }
		    format(string,sizeof(string),"You bought %s's gasstation",gasstationownername[itembeingsold[playerid]]);
			GetPlayerName(playerid,gasstationownername[itembeingsold[playerid]],sizeof(gasstationownername));
			format(gasstationname[itembeingsold[playerid]],sizeof(gasstationname),"%s's gasstation",gasstationownername[itembeingsold[playerid]]);
			UpdateGasStationLabels(itembeingsold[playerid]);
			SendClientMessage(playerid,LIGHTBLUE,string);
			format(string,sizeof(string),"You have sold %s you gasstation",gasstationownername[itembeingsold[playerid]]);
			SendClientMessage(sellplayer[playerid], LIGHTBLUE, string);
			SaveQuickGasStationData(itembeingsold[playerid]);
			itembeingsold[playerid] = 0;
			priceforitembeingsold[playerid] = 0;
			sellplayer[playerid] = 0;
			playerbeingsoldto[playerid] = 0;
		}
		else
		{
		    SendClientMessage(playerid,RED,"You don't have enough cash to buy this gasstation");
		}
	}
	else
	{
		SendClientMessage(playerid, RED, "No one is selling a gasstation to you");
	}
	return 1;
}
CMD:acceptrefinery(playerid, params[])
{//Check
	if((playerbeingsoldto[playerid])==2)
	{
	    new playercash = GetPlayerMoney(playerid);
	    new string[256];
	    if((playercash) >= priceforitembeingsold[playerid])
	    {
	        GivePlayerMoney(playerid,-priceforitembeingsold[playerid]);
			GivePlayerMoney(sellplayer[playerid],priceforitembeingsold[playerid]);
			if((refinerycash[itembeingsold[playerid]]) > 0)
			{
			    GivePlayerMoney(playerid,refinerycash[itembeingsold[playerid]]);
			    format(string,sizeof(string),"You left $%i in the refinery safe",refinerycash[itembeingsold[playerid]]);
			    SendClientMessage(sellplayer[playerid], LIGHTBLUE, string);
			    refinerycash[itembeingsold[playerid]] = 0;
			}
			format(string,sizeof(string),"You bought %s's refinery",refineryownername[itembeingsold[playerid]]);
			GetPlayerName(playerid,refineryownername[itembeingsold[playerid]],sizeof(gasstationownername));
			UpdateRefineryLabels(itembeingsold[playerid]);
			SendClientMessage(playerid,LIGHTBLUE,string);
			format(string,sizeof(string),"You have sold %s your refinery",gasstationownername[itembeingsold[playerid]]);
			SendClientMessage(sellplayer[playerid], LIGHTBLUE, string);
			SaveQuickRefineryData(itembeingsold[playerid]);
			itembeingsold[playerid] = 0;
			priceforitembeingsold[playerid] = 0;
			sellplayer[playerid] = 0;
			playerbeingsoldto[playerid] = 0;
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "You don't have enough cash to buy this refinery");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "No one is selling a refinery to you");
	}
	return 1;
}
CMD:sellmyfactoryto(playerid, params[])
{//Check
	new price,id,factoryid;
	if(sscanf(params,"uii",id,factoryid,price))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /sellmyfactoryto [playerid] [factoryid] [price]");
	}
	if((factorystate[factoryid])==1)
	{
	    if((factoryownedstate[factoryid])==1)
	    {
	        if((playerbeingsoldto[id])==0)
	        {
	            new name[MAX_PLAYER_NAME],string[256];
	            GetPlayerName(playerid,name,sizeof(name));
				if(strcmp(name,factoryownername[factoryid],false,sizeof(factoryownername))==0)
				{
    				playerbeingsoldto[id] = 4;
			        itembeingsold[id] = factoryid;
					priceforitembeingsold[id] = price;
					sellplayer[id] = playerid;
					format(string,sizeof(string),"%s has offer you his dealership for $%i ID:%i. /acceptfactory",name,price,factoryid);
					SendClientMessage(id, LIGHTBLUE, string);
					format(string,sizeof(string),"You have offered %s your factory for $%i",GetPlayerNameReturn(id),price);
					SendClientMessage(playerid, LIGHTBLUE, string);
			        SetTimerEx("BuyTimer",60000,false,"i",id);
				}
	        }
	        else
	        {
	            SendClientMessage(playerid, RED, "Some one already offer this person to sell a gasstation or refinery or dealership or factory");
	        }
	    }
	    else
	    {
			SendClientMessage(playerid, RED, "This factory is not owned by anyone");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "This factory does not exist");
	}
	return 1;
}
CMD:sellmydealershipto(playerid, params[])//Working
{
	new price,id,dealershipid;
	if(sscanf(params,"uii",id,dealershipid,price))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /sellmydealershipto [playerid] [dealershipid] [price]");
	}
	if((dealershipstate[dealershipid])==1)
	{
	    if((dealershipownedstate[dealershipid])==1)
	    {
	        if((playerbeingsoldto[id])==0)
	        {
	            new name[MAX_PLAYER_NAME],string[256];
	            GetPlayerName(playerid,name,sizeof(name));
				if(strcmp(name,dealershipownername[dealershipid],false,sizeof(dealershipownername))==0)
				{
    				playerbeingsoldto[id] = 3;
			        itembeingsold[id] = dealershipid;
					priceforitembeingsold[id] = price;
					sellplayer[id] = playerid;
					format(string,sizeof(string),"%s has offer you his dealership for $%i ID:%i. /acceptdealership",name,price,dealershipid);
					SendClientMessage(id, LIGHTBLUE, string);
					format(string,sizeof(string),"You have offered %s your dealership for $%i",GetPlayerNameReturn(id),price);
					SendClientMessage(playerid, LIGHTBLUE, string);
			        SetTimerEx("BuyTimer",60000,false,"i",id);
				}
	        }
	        else
	        {
	            SendClientMessage(playerid, RED, "Some one already offer this person to sell a gasstation or refinery or dealership or factory");
	        }
	    }
	    else
	    {
			SendClientMessage(playerid, RED, "This dealership is not owned by anyone");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "This dealership does not exist");
	}
	return 1;
}
CMD:sellmygasstationto(playerid, params[])//Working
{
	new price,id,gasstationid;
	if(sscanf(params,"uii",id,gasstationid,price))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /sellmygasstationto [playerid] [gasstationid] [price]");
	}
	if((gasstationstate[gasstationid])==1)
	{
	    if((gasstationownedstate[gasstationid])==1)
	    {
	        if((playerbeingsoldto[id])==0)
	        {
		        new name[MAX_PLAYER_NAME],string[256];
		        GetPlayerName(playerid,name,sizeof(name));
		        if(strcmp(name,gasstationownername[gasstationid],false,sizeof(gasstationownername))==0)
		        {
			        playerbeingsoldto[id] = 1;
			        itembeingsold[id] = gasstationid;
					priceforitembeingsold[id] = price;
					sellplayer[id] = playerid;
					format(string,sizeof(string),"%s has offer you his gasstation for $%i ID:%i. /acceptgasstation",name,price,gasstationid);
					SendClientMessage(id, LIGHTBLUE, string);
					format(string,sizeof(string),"You have offered %s your gasstation for $%i",GetPlayerNameReturn(id),price);
					SendClientMessage(playerid, LIGHTBLUE, string);
			        SetTimerEx("BuyTimer",60000,false,"i",id);
				}
				else
				{
				    SendClientMessage(playerid, RED, "This is not your gasstation");
				}
			}
			else
			{
			    SendClientMessage(playerid, RED, "Some one already offer this person to sell a gasstation or refinery or dealership or factory");
			}
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "this gasstation is not owned by anyone");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "This gasstation does not exist");
	}
	return 1;
}
CMD:sellmyrefineryto(playerid, params[])
{//Check
	new price,id,refineryid;
	if(sscanf(params,"uii",id,refineryid,price))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /sellmyrefineryto [id] [refineryid] [price]");
	}
	if((refinerystate[refineryid])==1)
	{
	    if((refineryownedstate[refineryid])==1)
	    {
	        if((playerbeingsoldto[id])==0)
	        {
		        new name[MAX_PLAYER_NAME],string[256];
		        GetPlayerName(playerid,name,sizeof(name));
		        if(strcmp(name,refineryownername[refineryid],false,sizeof(name))==0)
		        {
		            playerbeingsoldto[id] = 2;
		        	itembeingsold[id] = refineryid;
					priceforitembeingsold[id] = price;
					sellplayer[id] = playerid;
					format(string,sizeof(string),"%s has offer you his refinery for $%i ID:%i. /acceptrefinery",name,price,refineryid);
					SendClientMessage(id, LIGHTBLUE, string);
					format(string,sizeof(string),"You have offered %s your refinery for $%i",GetPlayerNameReturn(id),price);
					SendClientMessage(playerid, LIGHTBLUE, string);
					SetTimerEx("BuyTimer",60000,false,"i",id);
		        }
		        else
		        {
		            SendClientMessage(playerid, RED, "This is not your refinery");
		        }
			}
			else
			{
			    SendClientMessage(playerid, RED, "Some one already offer this person to sell a gasstation or refinery or dealership or factory");
			}
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "This refinery is not owned by anyone");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "This refinery does not exist");
	}
	return 1;
}
CMD:setvehiclemakeprice(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,4))
	{
		addvstate[playerid] = 4;
		choicecolor1[playerid] = 0;
		choicecolor2[playerid] = 0;
		choiceid[playerid] = 0;
		ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:addcar(playerid,params[])//Working
{
	new dealershipid;
 	if(sscanf(params,"i",dealershipid))
	{
		return SendClientMessage(playerid,RED,"SYNTAX /addcar [dealershipid]");
	}
	if((dealershipstate[dealershipid])==1)
	{
		if(strcmp(GetPlayerNameReturn(playerid),dealershipownername[dealershipid],false,MAX_PLAYER_NAME)==0)
		{
			addvstate[playerid] = 1;
			choicecolor1[playerid] = 0;
			choicecolor2[playerid] = 0;
			choiceid[playerid] = dealershipid;
			ShowPlayerDialog(playerid,COLORSELECTION1,DIALOG_STYLE_LIST,"Color 1",COLORSELECTIONSTATEMENT,"Ok","Close");
		}
		else
		{
		    SendClientMessage(playerid, RED, "This is not you dealership");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"This dealership does not exist");
	}
	return 1;
}
CMD:dealershipmenu(playerid,params[])//Working
{
	for(new count;count < MAX_DEALERSHIPS;count++)
	{
	    if((dealershipstate[count])==1)
	    {
         	if((dealershipownedstate[count])==1)
	        {
				if(IsPlayerInRangeOfPoint(playerid,8.0,dealershipx[count],dealershipy[count],dealershipz[count]))
				{
					if(strcmp(dealershipownername[count],GetPlayerNameReturn(playerid),false,MAX_PLAYER_NAME)==0)
					{
					    editobjdealership[playerid] = count;
					    ShowPlayerDialog(playerid,DEALERSHIPMENU,DIALOG_STYLE_LIST,"Dealership menu",DEALERSHIPMENUSTATEMENT,"Ok","Close");
					}
					else
					{
					    SendClientMessage(playerid,RED,"this is not your dealership");
					}
					return 1;
				}
         	}
	    }
	}
	return 1;
}
CMD:cancelcardelivery(playerid, params[])
{//check
	if((deliverystate[playerid])==1)
	{
		if((deliverydropoffstate[playerid])==2)
		{
			factorydeliverying[deliveryid[playerid]][deliveryfactoryid[playerid]] = 0;
			UpdateDealershipLabels(deliverydealershipid[playerid]);
			SaveQuickDealershipData(deliverydealershipid[playerid]);
			deliverydealershipid[playerid] = 0;
			deliveryid[playerid] = 0;
			deliverytruck[playerid] = 0;
		    deliverycarsamount[playerid] = 0;
		    deliverymodelid[playerid] = 0;
		    deliverydropoffstate[playerid] = 0;
		    SendClientMessage(playerid,RED,"You have cancel your delivery");
		    DisablePlayerCheckpoint(playerid);
		    
		}
		else
		{
			SendClientMessage(playerid, RED, "You can't cancel your delivery right now");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You are not on this delivery");
	}
	return 1;
}
CMD:cancelfueldelivery(playerid, params[])//Working
{//check
	if((deliverystate[playerid])==1)
	{
	    if((deliverydropoffstate[playerid])==1)
		{
		    new string[256];
		    GivePlayerMoney(playerid,-gasstationbuygascost[deliveryid[playerid]]);
		    format(string,sizeof(string),"you canceled the delivery, It cost you $%i for not delivering",gasstationbuygascost[deliveryid[playerid]]);
		    SendClientMessage(playerid, RED, string);
			gasstationbeingdeliveredto[deliveryid[playerid]] = 0;
			GasStationAddSlot(deliveryid[playerid]);
		    deliverystate[playerid] = 0;
		    deliverytruck[playerid] = 0;
		    deliveryid[playerid] = 0;
		    deliveryfuel[playerid] = 0;
		    DestroyVehicle(deliverytrailer[playerid]);
		    deliverydropoffstate[playerid] = 0;
	        DisablePlayerCheckpoint(playerid);
		}
		else
		{
			SendClientMessage(playerid, RED, "You can't cancel your delivery right now");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You are not on a delivery");
	}
	return 1;
}
/*//remove
CMD:setpowercost(playerid, params[])//#4
{
	if(IsPlayerAdmince(playerid, 5))
	{
		new Float:input;
		if(sscanf(params,"f",input))
		{
		    return SendClientMessage(playerid, RED, "SYNTAX /setpowercost [cost]");
		}
		if((input) < 1.0 &&(input) > 0.0)
		{
		    new string[256];
		    format(string,sizeof(string),"You set the cost of power from $%f to $%f",powercost,input);
			powercost = input;
			new INI:filedata = INI_Open(mainfilename);
			INI_WriteFloat(filedata,"powercost",powercost,6);
			INI_Close(filedata);
			SendClientMessage(playerid, PINK, string);
		}
		else
		{
      		SendClientMessage(playerid, RED, "the power cost have to be less then $1 and more then 0");
		}
	}
	else
	{
		SendClientMessage(playerid, RED, "You have to an admin inorder to use this command");
	}
	return 1;
}*/
CMD:deliverfuel(playerid, params[])//Working
{//check
	if(IsPlayerInAnyVehicle(playerid))
	{
		new playerstate = GetPlayerState(playerid);
		if(playerstate == PLAYER_STATE_DRIVER)
		{
			if(IsVehicleTruck(GetPlayerVehicleID(playerid)))
			{
			    if((deliverystate[playerid])==0)
			    {
					for(new count;count < MAX_REFINERYS;count++)
					{
						if((refinerystate[count])==1)
						{
						    if(IsPlayerInRangeOfPoint(playerid,8.0,refineryx[count],refineryy[count],refineryz[count]))
							{
							    if((refineryownedstate[count])==1)
							    {
							        if((refinerytrailerstate[count])==1)
							        {
								        if((refinerysellstate[count])==1)
								        {
								            if((refineryblocked[count])==0)
								            {
									            new string[1024],addstr[1024],gasstationcount;
									            OrganizeGasStationRequestSlot();
									            for(new count2;count2 < MAX_SLOTS - 12;count2++)
									            {
									                if((gasstationrequestslotstate[count2])==1)
													{
									                    gasstationcount++;
									                    if(isnull(string))
														{
                                                            format(string,sizeof(string),"GasStationid:%i:%f",gasstationrequestslot[count2],ammountofgasneeded[gasstationrequestslot[count2]]);
														}
														else
														{
										    				format(addstr,sizeof(addstr),"%s",string);
															format(string,sizeof(string),"%s\nGasStationid:%i:%f",addstr,gasstationrequestslot[count2],ammountofgasneeded[gasstationrequestslot[count2]]);
														}
									                }
									            }
												if(gasstationcount == 0)
												{
													ShowPlayerDialog(playerid,CANCEL,DIALOG_STYLE_MSGBOX,"No gas needed","No gas station needs gas","Close","Close");
												}
												else
												{
						                            deliveryrefineryid[playerid] = count;
													ShowPlayerDialog(playerid,SELECTGASSTATION,DIALOG_STYLE_LIST,"Select a Gasstation",string,"Ok","Cancel");
												}
											}
											else
											{
											    SendClientMessage(playerid,RED,"There is currently a trailer blocking the exit of the refinery");
											}
								        }
								        else
								        {
								            SendClientMessage(playerid,RED,"This refinery is not currently sell fuel");
								        }
									}
									else
									{
									    SendClientMessage(playerid, RED, "Please contact and admin, The trailer position is not set");
									}
							    }
							    else
							    {
							        SendClientMessage(playerid, RED, "This refinery is not owned by anyone");
							    }
							    return 1;
							}
						}
					}
				}
				else
				{
					SendClientMessage(playerid, RED, "You are already on a delivery");
				}
			}
			else
			{
			    SendClientMessage(playerid, RED, "You have to be driveing a truck inorder to deliver fuel");
			}
		}
		else
		{
			SendClientMessage(playerid, RED, "You are not the driver of the vehicle");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You are not in a vehicle");
	}
	return 1;
}
CMD:gotodealership(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid, 1))
	{
		new index;
		if(sscanf(params,"i",index))
		{
		    return SendClientMessage(playerid, RED, "SYNTAX /gotodealership [dealershipid]");
		}
		if((dealershipstate[index])==1)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
			    new playerstate = GetPlayerState(playerid);
			    if(playerstate == PLAYER_STATE_DRIVER)
			    {
					new vehicleid = GetPlayerVehicleID(playerid);
					SetVehiclePos(vehicleid,dealershipx[index],dealershipy[index],dealershipz[index]);
					new string[256];
					format(string,sizeof(string),"You have teleported to dealership %i",index);
					SendClientMessage(playerid, LIGHTBLUE, string);
			    }
			    else
			    {
			        SendClientMessage(playerid, RED, "You have to be the driver inorder to teleport to a dealership");
			    }
			}
			else
			{
			    SetPlayerPos(playerid,dealershipx[index],dealershipy[index],dealershipz[index]);
			    new string[256];
				format(string,sizeof(string),"You have teleported to dealership %i",index);
				SendClientMessage(playerid, LIGHTBLUE, string);
			}
		}
		else
		{
		    SendClientMessage(playerid, RED, "this dealership does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:setfuel(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid, 1))
	{
		new index,Float:ammount;
		if(IsPlayerInAnyVehicle(playerid))
		{
			index = GetPlayerVehicleID(playerid);
			if(sscanf(params,"f",ammount))
			{
				SendClientMessage(playerid, RED, "NOT IN VEHICLE:SYNTAX /setfuel [vehicleid] [ammount]");
	  			SendClientMessage(playerid, RED, "IN VEHICLE:SYNTAX /setfuel [ammount]");
	  			return 1;
			}
		}
		else
		{
			if(sscanf(params,"if",index,ammount))
			{
	  			SendClientMessage(playerid, RED, "NOT IN VEHICLE:SYNTAX /setfuel [vehicleid] [ammount]");
	  			SendClientMessage(playerid, RED, "IN VEHICLE:SYNTAX /setfuel [ammount]");
	  			return 1;
			}
		}
		if((ammount)<=100&&(ammount)>=0)
		{
		    new string[256];
		    format(string,sizeof(string),"You have set the fuel from %fL to %fL",fuel[index],ammount);
		    fuel[index] = ammount;
		    SendClientMessage(playerid, LIGHTBLUE,string);
		}
		else
		{
		    SendClientMessage(playerid, RED, "the number you enter is out of range");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:refuel(playerid, params[])
{//check
	if(IsPlayerInAnyVehicle(playerid))
	{
		new playerstate = GetPlayerState(playerid);
		if(playerstate == PLAYER_STATE_DRIVER)
		{
		    if((playerrefueling[playerid])==0)
		    {
				for(new count;count < MAX_GASSTATIONS;count++)
				{
					if((gasstationstate[count])==1)
					{
						if((gasstationownedstate[count])==1)
						{
							for(new count2;count2 < MAX_GASPUMPS;count2++)
							{
							    if((gaspumpstate[count2][count])==1)
							    {
							        if(IsPlayerInRangeOfPoint(playerid,8.0,gaspumpx[count2][count],gaspumpy[count2][count],gaspumpz[count2][count]))
							        {
										new money = GetPlayerMoney(playerid);
										new vehicleid = GetPlayerVehicleID(playerid);
										if((money) > gasstationgascost[count]/*||(cartype[jbcarid[vehicleid]])==4*/)//#4
										{
										    /*if((cartype[jbcarid[vehicleid]])==4)
										    {
										        if((repairshopgroupcash) < gasstationgascost[count])
										        {
										            return SendClientMessage(playerid,RED,"The repairshop group does not have any cash");
										        }
										    }*/
								            if((gaspumpgas[count2][count]) > 0.0)
								            {
											    new engine,lights,alarm,doors,bonnet,boot,objective;
											    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
											    if((engine)==-1)
											    {
											        engine = 0;
											    }
											    if((engine)==0)
											    {
													GetPlayerName(playerid,gaspumpuser[count2][count],sizeof(gaspumpuser));
				                                    gaspumpusegestate[count2][count] = 1;
				                                    gaspumpcurrentfuelammount[count2][count] = 0;
				                                    gaspumpcurrentsaleammount[count2][count] = 0;
				                                    playerrefueling[playerid] = 1;
				                                    UpdateGasStationLabels(count);
				                                    refueltimer[playerid] = SetTimerEx("Refuel",125,true,"iiii",playerid,vehicleid,count,count2);
				                                    SendClientMessage(playerid,LIGHTBLUE,"You are now refueling the vehicle");
												}
												else
												{
												    SendClientMessage(playerid, RED, "You have to turn off the engine before refueling");
												}
											}
											else
											{
											    SendClientMessage(playerid, RED, "This pump does not have enought gas");
											}
										}
										else
										{
										    SendClientMessage(playerid,RED,"You have no money to refuel your car");
										}
										return 1;
									}
							    }
							}
     					}
						else
						{
	    					SendClientMessage(playerid, RED, "this gas station is not owned by anyone");
						}
					}
				}
				SendClientMessage(playerid, RED, "You have to near a fuel pump to refuel your vehicle");
			}
			else
			{
                playerrefueling[playerid] = 0;
			}
		}
		else
		{
		    SendClientMessage(playerid, RED, "You have to be the driver inorder to refuel");
		}
	}
	else
	{
		SendClientMessage(playerid, RED, "you have to be in a car to refuel");
	}
	return 1;
}
CMD:restrictcar(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid, 5))
	{
		addvstate[playerid] = 3;
        ShowPlayerDialog(playerid,LISTCARS,DIALOG_STYLE_LIST,"Cars","Input Manualy\nAirplane\nHelicopters\nBikes\nconvertibles\nindustrial\nLowriders\nOffroad\nService Vehicles\nSaloons\nSportscars\nStationwagons\nBoats\nOthers","Ok","Close");
	}
	else
	{
	    SendClientMessage(playerid, RED, "you have to be admin inorder to use this command");
	}
	return 1;
}
CMD:selldealership(playerid, params[])//Working
{
	new dealershipid,string[256];
	if(sscanf(params,"i",dealershipid))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /selldealership [dealershipid]");
	}
	if((dealershipstate[dealershipid])==1)
	{
	    if((dealershipownedstate[dealershipid])==1)
	    {
	        for(new count;count < 212;count++)
	        {
	            if((requeststockstate[count][dealershipid])==3)
	            {
	                SendClientMessage(playerid, RED, "You can't sell your dealership when you have a factory makeing you cars");
	                return 1;
	            }
	            else if((requeststockstate[count][dealershipid])==4)
	            {
	                SendClientMessage(playerid,RED,"You can sell your dealership when a factory has your new cars");
	            }
	            else if((requeststockstate[count][dealershipid])==2)
	            {
				    new totalcarscash = (VehicleManufactureingPrice(carmodelid[count]) * requeststock[carmodelid[count] - 400][dealershipid]) / 2;
				    format(string,sizeof(string),"You also canceled your request for %i car(s) for $%i",requeststock[carmodelid[count] - 400][dealershipid],totalcarscash);
					SendClientMessage(playerid,RED,string);
					requeststock[carmodelid[count] - 400][dealershipid] = 0;
				    dealershipordercash[dealershipid] = dealershipordercash[dealershipid] - totalcarscash;
				    dealershipcash[dealershipid] = dealershipcash[dealershipid] + totalcarscash;
	            }
	        }
	        for(new count = 1;count < MAX_VEHICLES;count++)
	        {
	            if((carstate[count])==1)
	            {
	                if((cardealershipid[count])==dealershipid)
	                {
		                if((cartype[count])==3)
		                {
		                    SendClientMessage(playerid,RED,"You can't sell you dealership when you have a used car in it");
		                    return 1;
		                }
		                else if((cartype[count])==2)
		                {
							if((cardealershipid[count])==dealershipid)
							{
							    new halfprice = VehicleManufactureingPrice(carmodelid[count]);
								if((carstock[count]) > 0)
								{
								    SendClientMessage(playerid,RED,"You can't sell your dealership. Some cars still have stock");
								    return 1;
								}
								dealershipcash[dealershipid] = dealershipcash[dealershipid] + halfprice;
								format(string,sizeof(string),"Cars has been sold for $%i",halfprice);
								DestroyVehicle(car[count]);
								Delete3DTextLabel(carlabel[count]);
								DeleteCarData(count);
								SendClientMessage(playerid, LIGHTBLUE,string);
							}
		                }
					}
	            }
	        }
	        if((dealershipcash[dealershipid]) > 0)
	        {
				GivePlayerMoney(playerid,dealershipcash[dealershipid]);
				format(string,sizeof(string),"There was $%i left in the dealership safe it's now in your pocket",dealershipcash[dealershipid]);
				dealershipcash[dealershipid] = 0;
				SendClientMessage(playerid,LIGHTBLUE,string);
	        }
	        dealershipownedstate[dealershipid] = 0;
			format(dealershipownername[dealershipid],sizeof(dealershipownername),"");
			format(dealershipname[dealershipid],sizeof(dealershipname),"Not owned Dearship");
			new cash = dealershipcost[dealershipid] / 2;
			GivePlayerMoney(playerid, cash);
			UpdateDealershipLabels(dealershipid);
			format(string,sizeof(string),"you sold dealership:%i. You paid $%i for it and sold it for $%i",dealershipid,dealershipcost[dealershipid],cash);
			SendClientMessage(playerid, LIGHTBLUE, string);
			SaveQuickDealershipData(dealershipid);
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "This dealership is not owned by anyone");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "this dealership does not exist");
	}
	return 1;
}
CMD:buydealership(playerid, params[])//Working
{
	for(new count;count < MAX_DEALERSHIPS;count++)
	{
	    if((dealershipstate[count])==1)
		{
		    if(IsPlayerInRangeOfPoint(playerid,4.0,dealershipx[count],dealershipy[count],dealershipz[count]))
		    {
		        if((dealershipownedstate[count])==0)
		        {
					new cash = GetPlayerMoney(playerid);
					if((dealershipcost[count])<=cash)
					{
					    new string[256];
					    format(dealershipownername[count],sizeof(dealershipownername),"%s",GetPlayerNameReturn(playerid));
					    format(dealershipname[count],sizeof(dealershipname),"%s's dealership",dealershipownername[count]);
					    dealershipownedstate[count] =1;
					    UpdateDealershipLabels(count);
					    format(string,sizeof(string),"you bought dealership:%i. you paid $%i",count,dealershipcost[count]);
					    SendClientMessage(playerid, LIGHTBLUE,string);
					    GivePlayerMoney(playerid,-dealershipcost[count]);
					    SaveQuickDealershipData(count);
					}
					else
					{
					    SendClientMessage(playerid, RED, "you don't have enought cash to buy this dealership");
					}
		        }
		        else
		        {
		            SendClientMessage(playerid, RED, "This dealership is already owned by someone");
		        }
				return 1;
		    }
		}
	}
	SendClientMessage(playerid, RED, "You are not near a refinery");
	return 1;
}
CMD:deletedealership(playerid, params[])//Working
{
	new dealershipid;
	if(sscanf(params,"i",dealershipid))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /deletedealership [dealershipid]");
	}
	if((dealershipstate[dealershipid])==1)
	{
	    if((dealershipownedstate[dealershipid])==1)
	    {
	        return SendClientMessage(playerid, RED, "This dealership is owned buy someone");
	    }
		Delete3DTextLabel(dealershiplabel[dealershipid]);
		dealershipstate[dealershipid] = 0;
		DeleteDealerShipData(dealershipid);
		new string[256];
		format(string,sizeof(string),"you have delete dealership:%i",dealershipid);
		SendClientMessage(playerid, RED, string);
	}
	else
	{
	    SendClientMessage(playerid, RED, "This dealer ship does not exist");
	}
	return 1;
}
CMD:createdealership(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,3))
	{
		new cost;
		if(sscanf(params,"i",cost))
		{
		    return SendClientMessage(playerid, RED, "SYNTAX /createdealership [dealershipcost]");
		}
	    for(new count;count < MAX_DEALERSHIPS;count++)
	    {
	        if((dealershipstate[count])==0)
	        {
	            new string[256];
	            dealershipstate[count] = 1;
	            GetPlayerPos(playerid,dealershipx[count],dealershipy[count],dealershipz[count]);
	            dealershipcost[count] = cost;
	            format(string,sizeof(string),"you have created dealership %i",count);
	            format(dealershipname[count],sizeof(dealershipname),"Not owned gas station");
	            SendClientMessage(playerid, LIGHTBLUE, string);
	            SaveQuickDealershipData(count);
	            format(string,sizeof(string),"%s\ndealership:%i\n%s",dealershipname[count],count,DealershipOwner(count));
	            dealershiplabel[count] = Create3DTextLabel(string,YELLOW,dealershipx[count],dealershipy[count],dealershipz[count],DISTANCELABEL,0,0);
	            return 1;
	        }
	    }
	    SendClientMessage(playerid, RED, "There are no more dealerships slots");
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:carspawn(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid, 2))
	{
		if((carspawn)==0)
		{
		    carspawn = 1;
			new string[256];
			format(string,sizeof(string),"[ADMIN:%s] has enabled car spawn",GetPlayerNameReturn(playerid));
			SendClientMessageToAll(PINK,string);
			new INI:filedata = INI_Open(restrictedcarsfilename);
			INI_WriteInt(filedata,"carspawn",carspawn);
			INI_Close(filedata);
		}
		else if((carspawn)==1)
		{
		    carspawn = 0;
		    new string[256];
			format(string,sizeof(string),"[ADMIN:%s] has Disabled car spawn",GetPlayerNameReturn(playerid));
			SendClientMessageToAll(PINK,string);
			new INI:filedata = INI_Open(restrictedcarsfilename);
			INI_WriteInt(filedata,"carspawn",carspawn);
			INI_Close(filedata);
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "you have to be admin inorder to use this command");
	}
	return 1;
}
CMD:speedo(playerid, params[])//Working
{//check
	if((gageenabled[playerid])==0)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
		    new playerstate = GetPlayerState(playerid);
		    if(playerstate == PLAYER_STATE_DRIVER)
		    {
		        new vehicleid = GetPlayerVehicleID(playerid);
		        GageOn(playerid,vehicleid);
		        new string[256];
		        gageenabled[playerid] = 1;
		        new INI:filedata = INI_Open(playerdatafilename);
		        format(string,sizeof(string),"gageenabled[%s]",GetPlayerNameReturn(playerid));
				INI_WriteInt(filedata,string,gageenabled[playerid]);
				INI_Close(filedata);
				SendClientMessage(playerid,LIGHTBLUE, "You have enabled the speedmeter");
		    }
		}
	}
	else if((gageenabled[playerid])==1)
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
		    new playerstate = GetPlayerState(playerid);
		    if(playerstate == PLAYER_STATE_DRIVER)
		    {
				GageOff(playerid,playerlastvehicle[playerid]);
				new string[256];
		        gageenabled[playerid] = 0;
		        new INI:filedata = INI_Open(playerdatafilename);
		        format(string,sizeof(string),"gageenabled[%s]",GetPlayerNameReturn(playerid));
				INI_WriteInt(filedata,string,gageenabled[playerid]);
				INI_Close(filedata);
				SendClientMessage(playerid, LIGHTBLUE, "You have disabled the speedmeter");
		    }
		}
	}
	return 1;
}
/*CMD:carnum(playerid, params[])//remove
{
	new carnum,string[128];
	if(sscanf(params,"i",carnum))
	{
		return SendClientMessage(playerid, RED, "Syntax /carnum [number]");
	}
	format(string,sizeof(string),"car modal id: %i is %s",carnum,GetVehicleName(carnum));
	SendClientMessage(playerid, LIGHTBLUE, string);
	return 1;
}*/
CMD:car(playerid,params[])//Working
{
    if(IsPlayerAdmince(playerid,2)||(carspawn)==1)
	{
	    new color1,color2,modelid;
	    if(sscanf(params,"iii",color1,color2,modelid))
	    {
		 	addvstate[playerid] = 2;
	   		choicecolor1[playerid] = 0;
			choicecolor2[playerid] = 0;
			choiceid[playerid] = 0;
			ShowPlayerDialog(playerid,COLORSELECTION1,DIALOG_STYLE_LIST,"Color 1",COLORSELECTIONSTATEMENT,"Ok","Close");
			return 1;
		}
		choicecolor1[playerid] = color1;
		choicecolor2[playerid] = color2;
		choiceid[playerid] = 0;
		addvstate[playerid] = 2;
		AddCar(playerid,modelid);
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be admin or carspawn has to be on");
	}
	return 1;
}
CMD:trunk(playerid,params[])//Working
{
	if(IsPlayerInAnyVehicle(playerid))
	{
        new playerstate = GetPlayerState(playerid);
	    if(playerstate == PLAYER_STATE_DRIVER)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new engine,lights,alarm,doors,bonnet,boot,objective;
		    new string[256],name[MAX_PLAYER_NAME];
		    new Float:x,Float:y,Float:z;
		    GetPlayerPos(playerid,x,y,z);
		    GetPlayerName(playerid,name,sizeof(name));
		    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		    if((boot)==-1)
		    {
		        boot = 0;
		    }
		    if((boot)==0)
		    {
			    format(string,sizeof(string),"%s press a button label trunk. The trunk of %s's vehicle opens",name,name);
			    for(new i; i < MAX_PLAYERS;i++)
			    {
			        if(IsPlayerConnected(i))
			        {
			            SendClientMessage(i,PURPLE,string);
			        }
			    }
			    SendClientMessage(playerid, -1, "You have open the trunk");
			    SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,true,objective);
			}
			else if((boot)==1)
			{
   				format(string,sizeof(string),"%s press a button label trunk. The trunk of %s's vehicle closes",name,name);
			    for(new i; i < MAX_PLAYERS;i++)
			    {
			        if(IsPlayerConnected(i))
			        {
			            SendClientMessage(i,PURPLE,string);
			        }
			    }
			    SendClientMessage(playerid, -1, "You have closed the trunk");
			    SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,false,objective);
			}
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"You have to be in a car in order to open & close the trunk");
	}
	return 1;
}
CMD:hood(playerid,params[])//Working
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new playerstate = GetPlayerState(playerid);
	    if(playerstate == PLAYER_STATE_DRIVER)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new engine,lights,alarm,doors,bonnet,boot,objective;
		    new string[256],name[MAX_PLAYER_NAME];
		    new Float:x,Float:y,Float:z;
		    GetPlayerPos(playerid,x,y,z);
		    GetPlayerName(playerid,name,sizeof(name));
		    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		    if((bonnet)==-1)
		    {
		        bonnet = 0;
		    }
		    if((bonnet)==0)
		    {
				format(string,sizeof(string),"%s flips the switch to open the hood. %s's car hood opens",name,name);
				for(new i; i < MAX_PLAYERS;i++)
				{
				    if(IsPlayerConnected(i))
				    {
				        if(IsPlayerInRangeOfPoint(i,12.0,x,y,z))
				        {
				            SendClientMessage(i,PURPLE,string);
				        }
				    }
				}
				SendClientMessage(playerid, -1, "You have opened the hood");
				SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,true,boot,objective);
		    }
		    else if((bonnet)==1)
		    {
				format(string,sizeof(string),"%s flips the switch to close the hood. %s's car hood closes",name,name);
				for(new i; i < MAX_PLAYERS;i++)
				{
				    if(IsPlayerConnected(i))
				    {
				        if(IsPlayerInRangeOfPoint(i,12.0,x,y,z))
				        {
				            SendClientMessage(i,PURPLE,string);
				        }
				    }
				}
				SendClientMessage(playerid, -1, "You have closed the hood");
				SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,false,boot,objective);
			}
		}
		else
		{
		    SendClientMessage(playerid,RED,"You have to be the driver seat inorder to open and close the hood");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be in a car in order to open & close the hood of your car");
	}
	return 1;
}
CMD:lights(playerid,params[])//Working
{
	if(IsPlayerInAnyVehicle(playerid))
	{
	    new playerstate = GetPlayerState(playerid);
	    if(playerstate == PLAYER_STATE_DRIVER)
		{
		    new vehicleid = GetPlayerVehicleID(playerid);
		    new engine,lights,alarm,doors,bonnet,boot,objective;
		    new string[256],name[MAX_PLAYER_NAME];
		    new Float:x,Float:y,Float:z;
		    GetPlayerPos(playerid,x,y,z);
		    GetPlayerName(playerid,name,sizeof(name));
		    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		    if((lights)==-1)
		    {
				lights = 0;
		    }
			if((lights)==0)
			{
			    format(string,sizeof(string),"%s flips the switch to turn on the lights. The lights in %s's vehicle turns on",name,name);
			    for(new i;i < MAX_PLAYERS;i++)
			    {
					if(IsPlayerConnected(i))
					{
					    if(IsPlayerInRangeOfPoint(i,12.0,x,y,z))
					    {
					        SendClientMessage(playerid, PURPLE,string);
					    }
					}
			    }
			    SendClientMessage(playerid, -1, "You have turned on the lights");
			    SetVehicleParamsEx(vehicleid,engine,true,alarm,doors,bonnet,boot,objective);
			}
			else if((lights)==1)
			{
			    format(string,sizeof(string),"%s flips the switch to turn off the lights. The lights in %s's vehicle turns off",name,name);
			    for(new i;i < MAX_PLAYERS;i++)
			    {
					if(IsPlayerConnected(i))
					{
					    if(IsPlayerInRangeOfPoint(i,12.0,x,y,z))
					    {
					        SendClientMessage(playerid, PURPLE,string);
					    }
					}
			    }
			    SendClientMessage(playerid, -1, "You have turned off the lights");
			    SetVehicleParamsEx(vehicleid,engine,false,alarm,doors,bonnet,boot,objective);
			}
		}
		else
		{
			SendClientMessage(playerid, RED, "You have to the driver of the vehicle inorder to turn on or off the lights");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be in a vehicle inorder to trun on or off the lights");
	}
	return 1;
}
CMD:engine(playerid,params[])//Working
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new playerstate = GetPlayerState(playerid);
		if(playerstate == PLAYER_STATE_DRIVER)
		{
		    new vehicleid = GetPlayerVehicleID(playerid);
		    new engine,lights,alarm,doors,bonnet,boot,objective;
		    new string[256],name[MAX_PLAYER_NAME];
		    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		    if((engine)==-1)
		    {
		        engine = 0;
		    }
		    if((engine)==0)
		    {
				engine = 1;
				GetPlayerName(playerid,name,sizeof(name));
				format(string,sizeof(string),"%s has put the keys in the ignition. %s turns the keys in the vehicle",name,name);
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
    			SendLocalMessage(playerid,PURPLE,string);
				SendClientMessage(playerid, -1, "Please wait your vehicle is starting");
				SetTimerEx("CarStart",2000,false,"ii",playerid,vehicleid);
		    }
			else if((engine)==1)
			{
			    engine = 0;
			    GetPlayerName(playerid,name,sizeof(name));
				new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				format(string,sizeof(string),"%s turns off the vehicle. %s took out the keys",name,name);
				for(new i; i < MAX_PLAYERS;i++)
				{
				    if(IsPlayerConnected(i))
					{
					    if(IsPlayerInRangeOfPoint(i,12.0,x,y,z))
					    {
					        SendClientMessage(i,PURPLE,string);
					    }
					}
				}
				SendClientMessage(playerid,-1, "You have turned off the vehicle");
				KillTimer(fueluseingtimer[vehicleid]);
			    SetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
			}
		}
		else
		{
		    SendClientMessage(playerid, RED, "You have to be the driver to turn on and off the engine");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be in a vehicle inorder to turn on and off an engine");
	}
	return 1;
}
CMD:gotorefinery(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,1))
	{
	    new refineryid,string[256];
		if(sscanf(params,"i",refineryid))
		{
			return SendClientMessage(playerid, RED, "SYNTAX /gotorefinery [refineryid]");
		}
		if((refinerystate[refineryid])==1)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new playerstate = GetPlayerState(playerid);
				if((playerstate)==PLAYER_STATE_DRIVER)
				{
				    new vehicleid = GetPlayerVehicleID(playerid);
				    format(string,sizeof(string),"you have teleported to refinery:%i",refineryid);
				    SetVehiclePos(vehicleid,refineryx[refineryid],refineryy[refineryid],refineryz[refineryid]);
				    SendClientMessage(playerid,LIGHTBLUE,string);
				}
				else
				{
				    SendClientMessage(playerid,RED,"You are not the driver, You can't teleport");
				}
			}
			else
			{
   				format(string,sizeof(string),"you have teleported to refinery:%i",refineryid);
   				SetPlayerPos(playerid,refineryx[refineryid],refineryy[refineryid],refineryz[refineryid]);
				SendClientMessage(playerid,LIGHTBLUE,string);
			}
		}
		else
		{
		    SendClientMessage(playerid, RED, "this refinery does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:gotogasstation(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,1))
	{
	    new gasstationid,string[256];
	    if(sscanf(params,"i",gasstationid))
	    {
	        return SendClientMessage(playerid, RED, "SYNTAX /gotogasstation [gasstationid]");
	    }
	    if((gasstationstate[gasstationid])==1)
	    {
	        if(IsPlayerInAnyVehicle(playerid))
	        {
	        	new playerstate = GetPlayerState(playerid);
				if((playerstate)==PLAYER_STATE_DRIVER)
				{
				    new vehicleid = GetPlayerVehicleID(playerid);
				    SetVehiclePos(vehicleid,gasstationx[gasstationid],gasstationy[gasstationid],gasstationz[gasstationid]);
				    format(string,sizeof(string),"you have teleport to gasstation:%i",gasstationid);
				    SendClientMessage(playerid, LIGHTBLUE,string);
				}
				else
				{
				    SendClientMessage(playerid,RED,"You are not the driver, You can't teleport");
				}
	        }
	        else
	        {
	            SetPlayerPos(playerid,gasstationx[gasstationid],gasstationy[gasstationid],gasstationz[gasstationid]);
	            format(string,sizeof(string),"you have teleport to gasstation:%i",gasstationid);
	            SendClientMessage(playerid, LIGHTBLUE,string);
	        }
	    }
	    else
	    {
	        SendClientMessage(playerid,RED, "This gasstation does not exist");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be admin to use this command");
	}
	return 1;
}
CMD:admingaspumpmove(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,2))
	{
	    new gasstationid,gaspumpid;
		if(sscanf(params,"iis["#64"]",gaspumpid,gasstationid,admineditingreason[playerid]))
		{
		    return SendClientMessage(playerid, RED, "SYNTAX /admingaspumpmove [gaspumpid] [gasstationid] [reason]");
		}
		if((gasstationstate[gasstationid])==1)
		{
			if((gaspumpstate[gaspumpid][gasstationid])==1)
			{
				admineditingstate[playerid] = 1;//adminediting
				buildtype[playerid] = 4;//gaspump
				editobjgasstation[playerid] = gasstationid;
				editobjextra[playerid] = gaspumpid;
				SendClientMessage(playerid, LIGHTBLUE, "You are now editing an object");
				oldx[playerid] = gaspumpx[gaspumpid][gasstationid];
				oldy[playerid] = gaspumpy[gaspumpid][gasstationid];
				oldz[playerid] = gaspumpz[gaspumpid][gasstationid];
				oldxrot[playerid] = gaspumpxrot[gaspumpid][gasstationid];
				oldyrot[playerid] = gaspumpyrot[gaspumpid][gasstationid];
				oldzrot[playerid] = gaspumpzrot[gaspumpid][gasstationid];
				EditDynamicObject(playerid,gaspumpobject[gaspumpid][gasstationid]);
			}
			else
			{
			    SendClientMessage(playerid, RED, "This gas pump does not exist");
			}
		}
		else
		{
		    SendClientMessage(playerid, RED, "This gas station does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:movegaspump(playerid, params[])//Working
{
	new gasstationid,gaspumpid;
	if(sscanf(params,"ii",gaspumpid,gasstationid))
	{
	    return SendClientMessage(playerid,RED,"SYNTAX /movegaspump [gaspumpid] [gasstationid]");
	}
	if((gasstationstate[gasstationid])==1)
	{
		if((gasstationownedstate[gasstationid])==1)
		{
			if(strcmp(gasstationownername[gasstationid],GetPlayerNameReturn(playerid),false,MAX_PLAYER_NAME)==0)
			{
			    if((gaspumpstate[gaspumpid][gasstationid])==1)
			    {
			        buildtype[playerid] = 4;//gaspump
					editobjgasstation[playerid] = gasstationid;
					editobjextra[playerid] = gaspumpid;
					SendClientMessage(playerid, LIGHTBLUE, "You are now editing an object");
					oldx[playerid] = gaspumpx[gaspumpid][gasstationid];
					oldy[playerid] = gaspumpy[gaspumpid][gasstationid];
					oldz[playerid] = gaspumpz[gaspumpid][gasstationid];
					oldxrot[playerid] = gaspumpxrot[gaspumpid][gasstationid];
					oldyrot[playerid] = gaspumpyrot[gaspumpid][gasstationid];
					oldzrot[playerid] = gaspumpzrot[gaspumpid][gasstationid];
					EditDynamicObject(playerid,gaspumpobject[gaspumpid][gasstationid]);
			    }
       			else
       			{
       			    SendClientMessage(playerid, RED, "This gas pump does not exist");
       			}

			}
			else
			{
			    SendClientMessage(playerid, RED, "This gas station is not owned by you");
			}
		}
		else
		{
		    SendClientMessage(playerid, RED, "This gas station is not owned by anyone");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "This gas station does not exist");
	}
	return 1;
}
CMD:sellgasstation(playerid, params[])//Working
{
	new gasstationid;
	if(sscanf(params,"i",gasstationid))
	{
	    return SendClientMessage(playerid,RED, "SYNTAX /sellgasstation [gasstationid]");
	}
	if((gasstationstate[gasstationid])==1)
	{
	    if((gasstationownedstate[gasstationid])==1)
	    {
	        new string[256];
	        if(strcmp(gasstationownername[gasstationid],GetPlayerNameReturn(playerid),false,MAX_PLAYER_NAME)==0)
	        {
	            new refundgas;
	            for(new count;count < MAX_GASPUMPS;count++)
	            {
	                if((gaspumpstate[count][gasstationid])==1)
	                {
	                    if((gaspumpgas[count][gasstationid]) > 0)
	                    {
							refundgas = refundgas + (floatround(REFINERYSELLCOST * gaspumpgas[count][gasstationid],floatround_round) /2);
	                    }
	                    DeleteGasPumpData(count,gasstationid);
						gasstationcash[gasstationid] = gasstationcash[gasstationid] + costofgaspump/2;
	                }
	            }
				if((gasstationneedgasstate[gasstationid])==1)
				{
					new truckerpayment = floatround(gasstationbuygascost[editobjgasstation[playerid]] * PRECENTAGEOFFPAYMENT);
				    gasstationbuygascost[editobjgasstation[playerid]] = gasstationbuygascost[editobjgasstation[playerid]] - truckerpayment;
				    format(string,sizeof(string),"you have canceled buying gas and recived a full refund $%i for %fL",gasstationbuygascost[editobjgasstation[playerid]],ammountofgasneeded[editobjgasstation[playerid]]);
				    SendClientMessage(playerid,LIGHTBLUE,string);
					gasstationneedgasstate[editobjgasstation[playerid]] = 0;
					ammountofgasneeded[editobjgasstation[playerid]] = 0.0;
					gasstationcash[editobjgasstation[playerid]] = gasstationcash[editobjgasstation[playerid]] - gasstationbuygascost[editobjgasstation[playerid]];
					gasstationbuygascost[editobjgasstation[playerid]] = 0;
					GasStationRemoveSlot(editobjgasstation[playerid]);
				}
				if((refundgas) > 0)
				{
					gasstationcash[gasstationid] = gasstationcash[gasstationid] + refundgas;
					format(string,sizeof(string),"You had some gas left and recived $%i for it",refundgas);
					SendClientMessage(playerid,LIGHTBLUE,string);
				}
    			if((gasstationcash[gasstationid])>0)
	            {
					format(string,sizeof(string),"you had $%i in your safe. It is now in your pocket",gasstationcash[gasstationid]);
					SendClientMessage(playerid, LIGHTBLUE,string);
					GivePlayerMoney(playerid,gasstationcash[gasstationid]);
					gasstationcash[gasstationid] = 0;
				}
				gasstationownedstate[gasstationid] = 0;
				gasstationownername[gasstationid] = "";
				format(gasstationname[gasstationid],sizeof(gasstationname),"Not owned gas station");
				format(string,sizeof(string),"%s\ngasstationID:%i\n%s\nyou have %f gas",gasstationname[gasstationid],gasstationid,GasStationOwner(gasstationid),TotalGasInGasStation(gasstationid));
				Update3DTextLabelText(gasstationlabel[gasstationid],YELLOW,string);
				SendClientMessage(playerid,LIGHTBLUE,"You have sold your gasstation");
				SaveQuickGasStationData(gasstationid);
	        }
	        else
	        {
	            SendClientMessage(playerid, RED, "You don't own this gasstation");
	        }
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "this gas station is not owned by anyone");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "this gas station does not exist");
	}
	return 1;
}
CMD:sellgaspump(playerid, params[])//Working
{
	new gasstationid,gaspumpid,string[256];
	if(sscanf(params,"ii",gaspumpid,gasstationid))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /sellgaspump [gaspumpid] [gasstationid]");
	}
	if((gasstationstate[gasstationid])==1)
	{
		if((gasstationownedstate[gasstationid])==1)
		{
			if(strcmp(gasstationownername[gasstationid],GetPlayerNameReturn(playerid),false,MAX_PLAYER_NAME)==0)
			{
			    if((gaspumpstate[gaspumpid][gasstationid])==1)
			    {
			        new ammount = costofgaspump/2;
       				format(string,sizeof(string),"You have sold gas pump %i, It cost's you $%i. You sold it for $%i. The money is in your safe you have a total of $%i",gaspumpid,costofgaspump,ammount,gasstationcash[gasstationid]);
					gasstationcash[gasstationid] = gasstationcash[gasstationid] + ammount;
					DeleteGasPumpData(gaspumpid,gasstationid);
					SendClientMessage(playerid, LIGHTBLUE, string);
			    }
			    else
			    {
			        SendClientMessage(playerid, RED, "This pump does not exist");
			    }
			}
			else
			{
			    SendClientMessage(playerid, RED, "this is not your gasstation");
			}
		}
		else
		{
		    SendClientMessage(playerid, RED, "This gasstation is not owned by anyone");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED,"This gas station does not exits");
	}
	return 1;
}
CMD:buygaspump(playerid,params[])//Working
{
	new gasstationid,choice[4];
	if(sscanf(params,"is["#64"]",gasstationid,choice))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /buygaspump [gasstationid] [if you want the object <yes/no>]");
	}
	if((gasstationstate[gasstationid])==1)
	{
	    if((gasstationownedstate[gasstationid])==1)
	    {
	        if(strcmp(GetPlayerNameReturn(playerid),gasstationownername[gasstationid],false,MAX_PLAYER_NAME)==0)
	        {
				if(IsPlayerInRangeOfPoint(playerid,50.0,gasstationx[gasstationid],gasstationy[gasstationid],gasstationz[gasstationid]))
				{
					if((gasstationcash[gasstationid])>=costofgaspump)
					{
					    for(new count;count < MAX_GASPUMPS;count++)
					    {
							if((gaspumpstate[count][gasstationid])==0)
							{
							    if(strcmp(choice,"yes",true,sizeof(choice))==0)
							    {
									gaspumpobjectid[count][gasstationid] = 1676;
								}
								else if(strcmp(choice,"no",true,sizeof(choice))==0)
								{
									gaspumpobjectid[count][gasstationid] = 19300;
								}
								else
								{
								    SendClientMessage(playerid,RED,"You did not select a valid choice [yes/no]");
								    SendClientMessage(playerid, RED, "SYNTAX /buygaspump [gasstationid] [if you want the object <yes/no>]");
								    return 1;
								}
								new string[256];
							    gaspumpstate[count][gasstationid] = 1;
							    GetPlayerPos(playerid,gaspumpx[count][gasstationid],gaspumpy[count][gasstationid],gaspumpz[count][gasstationid]);
							    gaspumpx[count][gasstationid] = gaspumpx[count][gasstationid] + 3.0;
							    gasstationcash[gasstationid] = gasstationcash[gasstationid] - costofgaspump;
							    format(string,sizeof(string),"gaspump:%i-%i\n%s\ncurrentfuel:%f our of %f\n%s",count,gasstationid,CurrentReful(count,gasstationid),gaspumpgas[count][gasstationid],MAX_GASPERPUMP,GasPumpUsage(count,gasstationid));
							    gaspumplabel[count][gasstationid] = Create3DTextLabel(string,YELLOW,gaspumpx[count][gasstationid],gaspumpy[count][gasstationid],gaspumpz[count][gasstationid],DISTANCELABEL,0,0);
								gaspumpobject[count][gasstationid] = CreateDynamicObject(gaspumpobjectid[count][gasstationid],gaspumpx[count][gasstationid],gaspumpy[count][gasstationid],gaspumpz[count][gasstationid],gaspumpxrot[count][gasstationid],gaspumpyrot[count][gasstationid],gaspumpzrot[count][gasstationid],-1,-1,-1,300.0);
								GasStationCapacity(gasstationid);
								UpdateGasStationLabels(gasstationid);
								new INI:mainfile = INI_Open(mainfilename);
								SaveGasPumpData(mainfile,count,gasstationid);
								SaveGasStationData(mainfile,gasstationid);
								INI_Close(mainfile);
								SendClientMessage(playerid, LIGHTBLUE, "You have bought a gaspump");
							    return 1;
							}
					    }
					    SendClientMessage(playerid, RED, "There are no more avalaible slots for gas pumps");
					}
					else
					{
					    SendClientMessage(playerid, RED, "you don't have enought cash in your gasstation safe");
					}
				}
				else
				{
				    SendClientMessage(playerid, RED, "You have to be near the gas station inorder to buy a gas pump");
				}
	        }
			else
			{
			    SendClientMessage(playerid, RED, "You don't own this gasstation");
			}
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "This gas station is not owned by anyone");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "This gas station does not exist");
	}
	return 1;
}
CMD:gasstationmenu(playerid,params[])//Working
{
	for(new gasstationid;gasstationid < MAX_GASSTATIONS;gasstationid++)
	{
	    if((gasstationstate[gasstationid])==1)
	    {
	        if(IsPlayerInRangeOfPoint(playerid,5.0,gasstationx[gasstationid],gasstationy[gasstationid],gasstationz[gasstationid]))
	        {
	            if((gasstationownedstate[gasstationid])==1)
	            {
	                if(strcmp(GetPlayerNameReturn(playerid),gasstationownername[gasstationid],false,MAX_PLAYER_NAME)==0)
	                {
	                    editobjgasstation[playerid] = gasstationid;
	                    ShowPlayerDialog(playerid,GASSTATIONMENU,DIALOG_STYLE_LIST,"Gas station menu",GASSTATIONMENUSTATEMENT,"Ok","Cancel");
	                }
	                else
	                {
	                    SendClientMessage(playerid, RED, "You do not own this gasstation");
	                }
	            }
	            else
	            {
	                SendClientMessage(playerid, RED, "This gas station is not owned by anyone");
	            }
				return 1;
	        }
	    }
	}
	SendClientMessage(playerid, RED, "You are not near a gasstation");
	return 1;
}
CMD:buygasstation(playerid,params[])//Working
{
	for(new count;count < MAX_GASSTATIONS;count++)
	{
	    if((gasstationstate[count])==1)
	    {
	        if(IsPlayerInRangeOfPoint(playerid,5.0,gasstationx[count],gasstationy[count],gasstationz[count]))
	        {
	            if((gasstationownedstate[count])==0)
	            {
	                new cash = GetPlayerMoney(playerid);
	                if((cash)>=gasstationcost[count])
	                {
						new string[256];
						GetPlayerName(playerid,gasstationownername[count],sizeof(gasstationownername));
						gasstationownedstate[count] = 1;
						GivePlayerMoney(playerid,-gasstationcost[count]);
						format(gasstationname[count],sizeof(gasstationname),"%s's Gasstation",gasstationownername[count]);
						format(string,sizeof(string),"%s\ngasstationID:%i\n%s\nyou have %f gas",gasstationname[count],count,GasStationOwner(count),TotalGasInGasStation(count));
						Update3DTextLabelText(gasstationlabel[count],YELLOW,string);
						SaveQuickGasStationData(count);
						SendClientMessage(playerid, LIGHTBLUE, "You have just bought a gasstation");
	                }
	                else
	                {
	                    SendClientMessage(playerid, RED, "You don't have enought cash inorder to buy this gasstation");
	                }
	            }
	            else
	            {
	                SendClientMessage(playerid, RED, "Some on already owns this gasstation");
	            }
				return 1;
	        }
	    }
	}
	SendClientMessage(playerid,RED,"You are not inrange of a gasstation");
	return 1;
}
CMD:refinerymenu(playerid, params[])//Working
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	for(new refineryid;refineryid < MAX_REFINERYS;refineryid++)
	{
		if(IsPointInRangeOfPoint(x,y,z,refineryx[refineryid],refineryy[refineryid],refineryz[refineryid],2.5))
		{
		    if(strcmp(GetPlayerNameReturn(playerid),refineryownername[refineryid],false,MAX_PLAYER_NAME)==0)
		    {
		        editobjrefinery[playerid] = refineryid;
		        ShowPlayerDialog(playerid,REFINERYMENU,DIALOG_STYLE_LIST,"Refinery menu",REFINERYMENUSTATEMENT,"Ok","Close");
		    }
		    else
		    {
				SendClientMessage(playerid, RED, "you don't own this refinery");
		    }
		    return 1;
		}
	}
	SendClientMessage(playerid, RED, "You are not near a refinery");
	return 1;
}
CMD:setcostofgaspump(playerid,params[])//Working
{
	if(IsPlayerAdmince(playerid,4))
	{
	    new string[128],price;
	    if(sscanf(params,"i",price))
	    {
	        return SendClientMessage(playerid, RED, "SYNTAX /setcostofgaspump [costofgaspump]");
	    }
	    format(string,sizeof(string),"[ADMIN:%s] has changed the costofgaspump from $%i to $%i",GetPlayerNameReturn(playerid),costofgaspump,price);
	    SendClientMessageToAll(PINK,string);
	    costofgaspump = price;
	    new INI:filedata = INI_Open(mainfilename);
		INI_WriteInt(filedata,"costofgaspump",costofgaspump);
		INI_Close(filedata);
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:deletegasstation(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid, 3))
	{
	    new gasstationid,string[256];
	    if(sscanf(params,"i",gasstationid))
	    {
	        return SendClientMessage(playerid, RED, "SYNTAX /deletegasstation [gasstationid]");
	    }
	    if((gasstationstate[gasstationid])==1)
	    {
	        if((gasstationownedstate[gasstationid])==0)
	        {
	            format(string,sizeof(string),"You have deleted gasstation %i",gasstationid);
        		DeleteGasStationData(gasstationid);
        		SendClientMessage(playerid, RED, string);
			}
			else
			{
			    SendClientMessage(playerid, RED, "This gas station is owned by someone, you can't delete it");
			}
		}
		else
		{
		    SendClientMessage(playerid, RED, "this gas station does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED, "You have to be admin to use this command");
	}
	return 1;
}
CMD:creategasstation(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,3))
	{
		new cost;
		if(sscanf(params,"i",cost))
		{
		    return SendClientMessage(playerid,RED, "SYNTAX /creategasstation [cost]");
		}
		for(new count;count < MAX_GASSTATIONS;count++)
		{
		    if((gasstationstate[count])==0)
		    {
				new Float:x,Float:y,Float:z,string[256];
		        gasstationstate[count] = 1;
				GetPlayerPos(playerid,x,y,z);
				for(new count2;count2 < MAX_GASSTATIONS;count2++)
				{
				    if((gasstationstate[count2])==1)
				    {
				        if(IsPointInRangeOfPoint(x,y,z,gasstationx[count],gasstationy[count],gasstationz[count],50.0))
				        {
				            return SendClientMessage(playerid, RED, "you are to close to another gas station");
				        }
				    }
				}
				gasstationgascost[count] = 20;
				format(gasstationname[count],sizeof(gasstationname),"Not owned gas station");
				gasstationcost[count] = cost;
				gasstationx[count] = x;
				gasstationy[count] = y;
				gasstationz[count] = z;
				format(string,sizeof(string),"%s\ngasstationID:%i\n%s\nyou have %f gas",gasstationname[count],count,GasStationOwner(count),TotalGasInGasStation(count));
				gasstationlabel[count] = Create3DTextLabel(string,YELLOW,gasstationx[count],gasstationy[count],gasstationz[count],DISTANCELABEL,0,0);
				SaveQuickGasStationData(count);
				format(string,sizeof(string),"You just created gas station %i",count);
				SendClientMessage(playerid, LIGHTBLUE,string);
		        return 1;
		    }
		}
		SendClientMessage(playerid, RED, "There are no more slots for gasstations");
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:sellrefinery(playerid, params[])//Working
{
	new refineryid;
	if(sscanf(params,"i",refineryid))
	{
	    return SendClientMessage(playerid,RED, "SYNTAX /sellrefinery [refineryid]");
	}
	if((refinerystate[refineryid])==1)
	{
		new string[256];
		if(strcmp(GetPlayerNameReturn(playerid),refineryownername[refineryid],false,MAX_PLAYER_NAME)==0)
		{
		    if((refineryproductionstate[refineryid])==0)
		    {
				for(new count;count < MAX_OILPUMPS;count++)
				{
					if((oilpumpstate[count][refineryid])==1||(oilstoragestate[count][refineryid])==1)
					{
					    return SendClientMessage(playerid,RED,"You have to sell all your oilpumps and oilstorage before you can sell the refinery");
					}
				}
				new ammount = refinerycost[refineryid]/2;
				GivePlayerMoney(playerid,refinerycash[refineryid]);
				GivePlayerMoney(playerid,ammount);
				format(string,sizeof(string),"You bought the refinery for $%i and you sold it for $%i plus an additional $%i you have in the account",refinerycost[refineryid],ammount,refinerycash[refineryid]);
				SendClientMessage(playerid,LIGHTBLUE,string);
				refinerycash[refineryid] = 0;
				refineryownedstate[refineryid] = 0;
				format(refineryownername[refineryid],sizeof(refineryownername),"");
				format(string,sizeof(string),"Refinery:%i\nRefinery state:%s\n%s\nthere is a total of %f fuel",refineryid,RefineryProductionState(refineryid),RefineryOwner(refineryid),TotalOil(refineryid));
				Update3DTextLabelText(refinerylabel[refineryid],YELLOW,string);
	            SaveQuickRefineryData(refineryid);
			}
			else
			{
			    SendClientMessage(playerid, RED, "you have to turn off the refinery before selling it");
			}
		}
		else
		{
		    SendClientMessage(playerid,RED,"You don't own this refinery");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "This refinery does not exist");
	}
	return 1;
}
CMD:buyrefinery(playerid, params[])//Working
{
	new string[256];
	for(new count;count < MAX_REFINERYS;count++)
	{
	    if((refinerystate[count])==1)
	    {
	        if(IsPlayerInRangeOfPoint(playerid,5.0,refineryx[count],refineryy[count],refineryz[count]))
	        {
		        if((refineryownedstate[count])==0)
		        {
		            if((refinerytrailerstate[count])==0)
		            {
		                return SendClientMessage(playerid, RED, "This refinery is not yet set up contact an admin");
		            }
					new cash = GetPlayerMoney(playerid);
					if((cash) >= refinerycost[count])
					{
					    GivePlayerMoney(playerid,-refinerycost[count]);
						refineryownedstate[count] = 1;
						GetPlayerName(playerid,refineryownername[count],sizeof(refineryownername));
						format(string,sizeof(string),"Refinery:%i\nRefinery state:%s\n%s\nthere is a total of %f fuel",count,RefineryProductionState(count),RefineryOwner(count),TotalOil(count));
						Update3DTextLabelText(refinerylabel[count],YELLOW,string);
						SendClientMessage(playerid, LIGHTBLUE, "You bought a refinery");
						SaveQuickRefineryData(count);
					}
					else
					{
						format(string,sizeof(string),"refineryid:%i cost $%i. You only have $%i",count,cash,refinerycost[count]);
						SendClientMessage(playerid,RED,string);
					}
		        }
		        else
				{
		            format(string,sizeof(string),"%s has already purchesed this refinery",refineryownername[count]);
		            SendClientMessage(playerid, RED, string);
		        }
		        return 1;
			}
	    }
	}
	SendClientMessage(playerid,RED, "You are not near a refinery");
	return 1;
}
CMD:setoilpumpedpersec(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,4))
	{
	    new Float:ammount,string[256];
	    if(sscanf(params,"f",ammount))
	    {
	        return SendClientMessage(playerid,RED,"SYNTAX /setoilpumpedpersec [ammount]");
	    }
	    format(string,sizeof(string),"[ADMIN:%s] has set the ammount of oil pumped per second from %f to %f",GetPlayerNameReturn(playerid),oilpumpedpersec,ammount);
		oilpumpedpersec = ammount;
		SendClientMessageToAll(PINK,string);
		new INI:filedata = INI_Open(mainfilename);
		INI_WriteFloat(filedata,"oilpumpedpersec",oilpumpedpersec,6);
		INI_Close(filedata);
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be an admin inorder to use this command");
	}
	return 1;
}
CMD:setoilstoragebuildcost(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid, 4))
	{
		new price,string[256];
		if(sscanf(params,"i",price))
		{
		    return SendClientMessage(playerid, RED, "SYNTAX / setoilstoragebuildcost [price]");
		}
		if((price)>0&&(price)<=10000000)
		{
			format(string,sizeof(string),"[ADMIN:%s] has changed the build cost for the oil storage from $%i to $%i",GetPlayerNameReturn(playerid),costofoilstorage,price);
			SendClientMessageToAll(PINK,string);
			costofoilstorage = price;
			new INI:filedata = INI_Open(mainfilename);
			INI_WriteInt(filedata,"costofoilstorage",costofoilstorage);
			INI_Close(filedata);
		}
		else
		{
			SendClientMessage(playerid, RED, "out of range , The minimum price is $1 the max is $10000000");
   		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be an admin inorder to use this command");
	}
	return 1;
}
CMD:setoilpumpbuildcost(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid, 4))
	{
		new price,string[256];
		if(sscanf(params,"i",price))
		{
			return SendClientMessage(playerid,RED,"SYNTAX / setoilpumpbuildcost [price]");
		}
		if((price)>0&&(price)<=10000000)
		{
   			format(string,sizeof(string),"[ADMIN:%s] has changed the build cost for oil pumps from $%i to $%i",GetPlayerNameReturn(playerid),costofoilpumps,price);
      		costofoilpumps = price;
		    SendClientMessageToAll(PINK,string);
		    new INI:filedata = INI_Open(mainfilename);
			INI_WriteInt(filedata,"costofoilpumps",costofoilpumps);
			INI_Close(filedata);
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "out of range , The minimum price is $1 the max is $10000000");
	    }
	}
	else
	{
		SendClientMessage(playerid, RED, "You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:adminoilstoragemove(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid, 2))
	{
		new refineryid,oilstorageid;
		if(sscanf(params,"iis["#64"]",oilstorageid,refineryid,admineditingreason[playerid]))
		{
		    return SendClientMessage(playerid, RED, "SYNTAX /adminoilstoragemove [oilstorageid] [refineryid] [Reason]");
		}
		if((refinerystate[refineryid])==1)
		{
		    if((oilstoragestate[oilstorageid][refineryid])==1)
		    {
      			buildtype[playerid] = 2;//build type = moveoilstorage
      			admineditingstate[playerid] = 1;//adminediting
	            oldx[playerid] = oilstoragex[oilstorageid][refineryid];
	            oldy[playerid] = oilstoragey[oilstorageid][refineryid];
	            oldz[playerid] = oilstoragez[oilstorageid][refineryid];
	            oldxrot[playerid] = oilstoragexrot[oilstorageid][refineryid];
	            oldyrot[playerid] = oilstorageyrot[oilstorageid][refineryid];
	            oldzrot[playerid] = oilstoragezrot[oilstorageid][refineryid];
	            editobjrefinery[playerid] = refineryid;
				editobjextra[playerid] = oilstorageid;
				SendClientMessage(playerid, LIGHTBLUE, "You are now editing an object");
                EditDynamicObject(playerid,oilstorageobject[oilstorageid][refineryid]);
		    }
		    else
		    {
		        SendClientMessage(playerid, RED, "this oilstorage contaiment does not exist");
		    }
		}
		else
		{
		    SendClientMessage(playerid, RED, "This refinery does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be an admin");
	}
	return 1;
}
CMD:adminoilpumpmove(playerid,params[])//Working
{
	if(IsPlayerAdmince(playerid, 2))
	{
	    new oilpumpid,refineryid;
        if(sscanf(params,"iis["#64"]",oilpumpid,refineryid,admineditingreason[playerid]))
		{
		    return SendClientMessage(playerid, RED, "SYNTAX /adminoilpumpmove [oilstorageid] [refineryid] [Reason]");
		}
		if((refinerystate[refineryid])==1)
		{
		    if((oilpumpstate[oilpumpid][refineryid])==1)
		    {
		    	buildtype[playerid] = 1;//build type = moveoilpump
		    	admineditingstate[playerid] = 1;//adminediting
				editobjrefinery[playerid] = refineryid;
        		oldx[playerid] = oilpumpx[oilpumpid][refineryid];
	            oldy[playerid] = oilpumpy[oilpumpid][refineryid];
	            oldz[playerid] = oilpumpz[oilpumpid][refineryid];
	            oldxrot[playerid] = oilpumpxrot[oilpumpid][refineryid];
	            oldyrot[playerid] = oilpumpyrot[oilpumpid][refineryid];
	            oldzrot[playerid] = oilpumpzrot[oilpumpid][refineryid];
				editobjextra[playerid] = oilpumpid;
				SendClientMessage(playerid, LIGHTBLUE, "You are now editing an object");
                EditDynamicObject(playerid,oilpumpobject[oilpumpid][refineryid]);
		    }
		    else
		    {
		        SendClientMessage(playerid,RED,"This oilpump does not exist");
		    }
		}
		else
		{
		    SendClientMessage(playerid, RED, "This Refinery does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be an admin");
	}
	return 1;
}
CMD:moveoilstorage(playerid, params[])//Working
{
	new refineryid,oilstorageid;
	if(sscanf(params, "ii",oilstorageid,refineryid))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /moveoilstorage [oilpumpid] [refineryid]");
	}
	if((refinerystate[refineryid])==1)
	{
	    if((refineryownedstate[refineryid])==1)
	    {
	        if((oilstoragestate[oilstorageid][refineryid])==1)
	        {
	            if(strcmp(GetPlayerNameReturn(playerid),refineryownername[refineryid],false,MAX_PLAYER_NAME)==0)
	            {
	                if((refineryproductionstate[refineryid])==0)
		    		{
		                buildtype[playerid] = 2;//build type = moveoilstorage
		                oldx[playerid] = oilstoragex[oilstorageid][refineryid];
		                oldy[playerid] = oilstoragey[oilstorageid][refineryid];
		                oldz[playerid] = oilstoragez[oilstorageid][refineryid];
		                oldxrot[playerid] = oilstoragexrot[oilstorageid][refineryid];
		                oldyrot[playerid] = oilstorageyrot[oilstorageid][refineryid];
		                oldzrot[playerid] = oilstoragezrot[oilstorageid][refineryid];
		                editobjrefinery[playerid] = refineryid;
					    editobjextra[playerid] = oilstorageid;
					    SendClientMessage(playerid, LIGHTBLUE, "You are now editing an object");
	                    EditDynamicObject(playerid,oilstorageobject[oilstorageid][refineryid]);
					}
					else
					{
					    SendClientMessage(playerid, RED, "your refinery is on, turn it off");
					}
	            }
	            else
	            {
	                SendClientMessage(playerid, RED, "You do not own this storage");
	            }
	        }
	        else
			{
			    SendClientMessage(playerid, RED, "this oil storage containment does not exits");
			}
	    }
	    else
	    {
	        SendClientMessage(playerid, RED, "This refinery is not owned by anyone");
	    }
	}
	else
	{
	    SendClientMessage(playerid, RED, "This refinery does not exist");
	}
	return 1;
}
CMD:moveoilpump(playerid, params[])//Working
{
	new refineryid,oilpumpid;
	if(sscanf(params, "ii",oilpumpid,refineryid))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /moveoilpump [oilpumpid] [refineryid]");
	}
	if((refinerystate[refineryid])==1)
	{
	    if((refineryownedstate[refineryid])==1)
	    {
		    if((oilpumpstate[oilpumpid][refineryid])==1)
		    {
				if(strcmp(GetPlayerNameReturn(playerid),refineryownername[refineryid],false,MAX_PLAYER_NAME)==0)
				{
				    if((refineryproductionstate[refineryid])==0)
		    		{
					    buildtype[playerid] = 1;//build type = moveoilpump
					    editobjrefinery[playerid] = refineryid;
	        			oldx[playerid] = oilpumpx[oilpumpid][refineryid];
		                oldy[playerid] = oilpumpy[oilpumpid][refineryid];
		                oldz[playerid] = oilpumpz[oilpumpid][refineryid];
		                oldxrot[playerid] = oilpumpxrot[oilpumpid][refineryid];
		                oldyrot[playerid] = oilpumpyrot[oilpumpid][refineryid];
		                oldzrot[playerid] = oilpumpzrot[oilpumpid][refineryid];
					    editobjextra[playerid] = oilpumpid;
					    SendClientMessage(playerid, LIGHTBLUE, "You are now editing an object");
	                    EditDynamicObject(playerid,oilpumpobject[oilpumpid][refineryid]);
					}
					else
					{
					    SendClientMessage(playerid, RED, "the refinery state is currently on, turn it off");
					}
				}
				else
				{
				    SendClientMessage(playerid, RED, "You don't own this oil pump");
				}
		    }
		    else
		    {
		        SendClientMessage(playerid, RED, "This Oil pump does not exist");
		    }
		}
		else
		{
		    SendClientMessage(playerid, RED, "This refinery is not owned by anyone");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "This refinery does not exist");
	}
	return 1;
}
CMD:selloilstorage(playerid, params[])//Working
{
	new refineryid,oilstorageid,string[256];
	if(sscanf(params,"ii",oilstorageid,refineryid))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /selloilstorage [oilstorageid] [refineryid]");
	}
	if((refinerystate[refineryid])==0)
	{
	    return SendClientMessage(playerid, RED, "This refinery does not exist");
	}
	if((refineryownedstate[refineryid])==0)
	{
		return SendClientMessage(playerid, RED, "This refinery is not owned by anyone");
	}
	if((oilstoragestate[oilstorageid][refineryid])==0)
	{
	    return SendClientMessage(playerid, RED, "This oil storage unit does not exist");
	}
	if(strcmp(refineryownername[refineryid],GetPlayerNameReturn(playerid),false,MAX_PLAYER_NAME)==0)
	{
	    if((refineryproductionstate[refineryid])==0)
	    {
		    new cash = costofoilstorage/2;
			format(string,sizeof(string),"oilstorage cost $%i right now so you will get back $%i for your oilstorage containment, this has been added to your refinery deposit",costofoilstorage,cash);
			SendClientMessage(playerid, LIGHTBLUE, string);
			oilstoragestate[oilstorageid][refineryid] = 0;
			oilstoragex[oilstorageid][refineryid] = 0;
			oilstoragey[oilstorageid][refineryid] = 0;
			oilstoragez[oilstorageid][refineryid] = 0;
			oilstoragexrot[oilstorageid][refineryid] = 0;
			oilstorageyrot[oilstorageid][refineryid] = 0;
			oilstoragezrot[oilstorageid][refineryid] = 0;
			oilstorageobjectid[oilstorageid][refineryid] = 0;
			UpdateRefineryLabels(refineryid);
			Delete3DTextLabel(oilstoragelabel[oilstorageid][refineryid]);
			DestroyDynamicObject(oilstorageobject[oilstorageid][refineryid]);
			DeleteOilStorageData(oilstorageid,refineryid);
		}
		else
		{
		    SendClientMessage(playerid, RED, "Your refinery is curretly on, turn it off");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "This is not your refinery");
	}
	return 1;
}
CMD:buyoilstorage(playerid, params[])//Working
{
	new refineryid,string[256],choice[4];
	if(sscanf(params,"is["#4"]",refineryid,choice))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /buyoilstorage [refineryid] [yes/no for object]");
	}
	if((refinerystate[refineryid])==0)
	{
	    return SendClientMessage(playerid, RED, "This refinery does not exist");
	}
	if((refineryownedstate[refineryid])==0)
	{
		return SendClientMessage(playerid, RED, "This refinery is not owned by anyone");
	}
	if(strcmp(GetPlayerNameReturn(playerid),refineryownername[refineryid],false,MAX_PLAYER_NAME)==0)
	{
		if((refinerycash[refineryid]) >= costofoilpumps)
		{
		    if((refineryproductionstate[refineryid])==0)
		    {
	            for(new count;count < MAX_OILPUMPS;count++)
				{
				    if((oilstoragestate[count][refineryid])==0)
			    	{
			    	    new Float:x,Float:y,Float:z;
			    	    GetPlayerPos(playerid,x,y,z);
			    	    oilstoragestate[count][refineryid] = 1;
			    	    oilstoragex[count][refineryid] = x + 15.0;
			    	    oilstoragey[count][refineryid] = y;
			    	    oilstoragez[count][refineryid] = z;
			    	    oilstoragexrot[count][refineryid] = 0;
						oilstorageyrot[count][refineryid] = 0;
						oilstoragezrot[count][refineryid] = 0;
			    	    if(IsOilStorageNotNearOilStorage(count,refineryid))
						{
						    if(IsOilStorageNearRefinery(count,refineryid))
						    {
						        if(strcmp(choice,"yes",true,4)==0)
						        {
									oilstorageobjectid[count][refineryid] = 3636;// oil storage unit
						        }
						        else if(strcmp(choice,"no",true,4)==0)
								{
								    oilstorageobjectid[count][refineryid] = 19300; //blank object id 19300
								}
								else
								{
								    SendClientMessage(playerid, RED, "You did not pick a valid answer, Yes/No");
								    SendClientMessage(playerid, RED, "SYNTAX /buyoilstorage [refineryid] [oilpumpid]");
	  	    						oilstoragestate[count][refineryid] = 0;
						    	    oilstoragex[count][refineryid] = 0;
						    	    oilstoragey[count][refineryid] = 0;
						    	    oilstoragez[count][refineryid] = 0;
								    return 1;
								}
								refinerycash[refineryid] = refinerycash[refineryid] - costofoilstorage;
								oilstorageobject[count][refineryid] = CreateDynamicObject(oilstorageobjectid[count][refineryid],oilstoragex[count][refineryid],oilstoragey[count][refineryid],oilstoragez[count][refineryid],oilstoragexrot[count][refineryid],oilstorageyrot[count][refineryid],oilstoragezrot[count][refineryid],-1,-1,-1,300.0);
								format(string,sizeof(string),"ID:%i-%i\n This fuelstorage is owned by %s\nThere is currently %fL out of %f fuel in hear\ncurrentstate:%s",count,refineryid,refineryownername[refineryid],oilstoragefuel[count][refineryid],MAX_OILSTORAGE,RefineryProductionState(refineryid));
								oilstoragelabel[count][refineryid] = Create3DTextLabel(string,YELLOW,oilstoragex[count][refineryid],oilstoragey[count][refineryid],oilstoragez[count][refineryid],DISTANCELABEL,0,0);
								format(string,sizeof(string),"you have bought an oil storage unit for $%i-This was payed useing your refinery budget",costofoilstorage);
								SendClientMessage(playerid, LIGHTBLUE, string);
								new INI:filedata = INI_Open(mainfilename);
								SaveRefineryData(filedata,refineryid);
								SaveOilStorageData(filedata,count,refineryid);
								INI_Close(filedata);
								printf("oilstoragestate = %i oilstorageobjectid = %i oilstoragex = %f oilstoragey = %f oilstoragez = %f oilstoragexrot = %f oilstorageyrot = %f oilstoragezrot = %f costofoilstorage = %i",oilstoragestate[count][refineryid],oilstorageobjectid[count][refineryid],oilstoragex[count][refineryid],oilstoragey[count][refineryid],oilstoragez[count][refineryid],oilstoragexrot[count][refineryid],oilstorageyrot[count][refineryid],oilstoragezrot[count][refineryid],costofoilstorage);
						    }
						    else
						    {
		   	    				oilstoragestate[count][refineryid] = 0;
					    	    oilstoragex[count][refineryid] = 0;
					    	    oilstoragey[count][refineryid] = 0;
					    	    oilstoragez[count][refineryid] = 0;
						        SendClientMessage(playerid, RED, "This storage unit needs to be closer to the refinery");
						    }
						}
						else
						{
							oilstoragestate[count][refineryid] = 0;
					    	oilstoragex[count][refineryid] = 0;
					    	oilstoragey[count][refineryid] = 0;
					    	oilstoragez[count][refineryid] = 0;
						    SendClientMessage(playerid, RED, "This is to close to another oilstorage unit");
						}
						return 1;
			    	}
				}
				SendClientMessage(playerid, RED, "There is no more space for an oil refinery");
			}
			else
			{
			    SendClientMessage(playerid, RED, "refinery state is currently activated, turn it off");
			}
		}
		else
		{
		    SendClientMessage(playerid,RED,"you don't have enought cash in your refinery budget");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You do not own this refinery");
	}
	return 1;
}
CMD:selloilpump(playerid, params[])//Working
{
	new refineryid,oilpumpid,string[256];
	if(sscanf(params,"ii",refineryid,oilpumpid))
	{
	    return SendClientMessage(playerid, RED, "SYNTAX /selloilpump [refineryid] [oilpumpid]");
	}
	if((refinerystate[refineryid])==0)
	{
	    return SendClientMessage(playerid, RED, "This refinery does not exist");
	}
	if((refineryownedstate[refineryid])==0)
	{
		return SendClientMessage(playerid, RED, "This refinery is not owned by anyone");
	}
	if(strcmp(GetPlayerNameReturn(playerid),refineryownername[refineryid],false,MAX_PLAYER_NAME)==0)
	{
	    if((oilpumpstate[oilpumpid][refineryid])==1)
	    {
	        if((refineryproductionstate[refineryid])==0)
		    {
				new cash = costofoilpumps/2;
				GivePlayerMoney(playerid,cash);
				DeleteOilPump(oilpumpid,refineryid);
				format(string,sizeof(string),"the curent price for an oil pump is $%i so you get $%i back",costofoilpumps,cash);
				SendClientMessage(playerid,RED,string);
				oilpumpstate[oilpumpid][refineryid] = 0;
				oilpumpx[oilpumpid][refineryid] = 0;
				oilpumpy[oilpumpid][refineryid] = 0;
				oilpumpz[oilpumpid][refineryid] = 0;
				oilpumpxrot[oilpumpid][refineryid] = 0;
				oilpumpyrot[oilpumpid][refineryid] = 0;
				oilpumpzrot[oilpumpid][refineryid] = 0;
				oilpumpobjectid[oilpumpid][refineryid] = 0;
				UpdateRefineryLabels(refineryid);
				Delete3DTextLabel(oilpumplabel[oilpumpid][refineryid]);
				DestroyDynamicObject(oilpumpobject[oilpumpid][refineryid]);
	            DeleteOilPumpData(oilpumpid,refineryid);
			}
			else
			{
			    SendClientMessage(playerid, RED, "refinery state is currently on,turn it off");
			}
	    }
	    else
		{
		    SendClientMessage(playerid, RED, "This oil pump does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "This is not your refinery");
	}
	return 1;
}
CMD:buyoilpump(playerid,params[])//Working
{
	new refineryid,string[256],choice[4];
	if(sscanf(params,"is["#4"]",refineryid,choice))
	{
		return SendClientMessage(playerid, RED, "SYNTAX /buyoilpump [refineryid] [want object Yes/No]");
	}
	if((refinerystate[refineryid])==0)
	{
	    return SendClientMessage(playerid, RED, "This refinery does not exist");
	}
	if((refineryownedstate[refineryid])==0)
	{
		return SendClientMessage(playerid, RED, "This refinery is not owned by anyone");
	}
	if(strcmp(GetPlayerNameReturn(playerid),refineryownername[refineryid],false,MAX_PLAYER_NAME)==0)
	{
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		if((refinerycash[refineryid]) >= costofoilpumps)
		{
			for(new count;count < MAX_OILPUMPS;count++)
			{
			    if((oilpumpstate[count][refineryid])==0)
			    {
			        oilpumpstate[count][refineryid] = 1;
					oilpumpx[count][refineryid] = x + 15.0;
					oilpumpy[count][refineryid] = y;
					oilpumpz[count][refineryid] = z;
					if(IsOilPumpNotNearOilPump(count,refineryid))
					{
					    if((refineryproductionstate[refineryid])==0)
		    			{
							if(strcmp(choice,"yes",true,4)==0)
							{
							    oilpumpobjectid[count][refineryid] = 3426; //oilpump
							}
							else if(strcmp(choice,"no",true,4)==0)
							{
							    oilpumpobjectid[count][refineryid] = 19300; //blank object id 19300
							}
							else
							{
							    SendClientMessage(playerid, RED, "You did not yes or no");
							    SendClientMessage(playerid, RED, "SYNTAX /buyoilpump [refineryid] [want object Yes/No]");
							    oilpumpx[count][refineryid] = 0;
								oilpumpy[count][refineryid] = 0;
								oilpumpz[count][refineryid] = 0;
								oilpumpstate[count][refineryid] = 0;
	                            oilpumpxrot[count][refineryid] = 0;
	                            oilpumpyrot[count][refineryid] = 0;
	                            oilpumpzrot[count][refineryid] = 0;
							    return 1;
							}
	                        oilpumpobject[count][refineryid] = CreateDynamicObject(oilpumpobjectid[count][refineryid],oilpumpx[count][refineryid],oilpumpy[count][refineryid],oilpumpz[count][refineryid],oilpumpxrot[count][refineryid],oilpumpyrot[count][refineryid],oilpumpzrot[count][refineryid],-1,-1,-1,300.0);
	                        format(string,sizeof(string),"OilpumpID:%i-%i,owner:%s,state:%s",count,refineryid,refineryownername[refineryid],RefineryProductionState(refineryid));
	                        oilpumplabel[count][refineryid] = Create3DTextLabel(string,YELLOW,oilpumpx[count][refineryid],oilpumpy[count][refineryid],oilpumpz[count][refineryid],DISTANCELABEL,0,0);
	                        refinerycash[refineryid] = refinerycash[refineryid] - costofoilpumps;
							SaveQuickOilPumpData(count,refineryid);
							format(string,sizeof(string),"You have bought a oil pump for $%i the money was taken out of your refinery bank",costofoilpumps);
							SendClientMessage(playerid, LIGHTBLUE, string);
						}
						else
						{
						    SendClientMessage(playerid,RED, "The refinery is currently on turn in off");
						}
					}
					else
					{
	    				oilpumpx[count][refineryid] = x;
						oilpumpy[count][refineryid] = y;
						oilpumpz[count][refineryid] = z;
						oilpumpstate[count][refineryid] = 0;
						SendClientMessage(playerid,RED, "You are to close to an oil pump");
					}
					return 1;
			    }
			}
			SendClientMessage(playerid, RED, "You build the max ammount of oil pumps");
		}
		else
		{
			SendClientMessage(playerid, RED, "You don't have enought cash in your refinery budget to build an oil pump");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You Don't Own This refinery");
	}
	return 1;
}
CMD:deleterefinery(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid, 3))
	{
	    new refineryid,string[256];
	    if(sscanf(params,"i",refineryid))
	    {
			return SendClientMessage(playerid, RED, "SYNTAX /destroyrefinery [refineryid]");
	    }
	    if((refinerystate[refineryid])==1)
		{
			if((refineryownedstate[refineryid])==0)
			{
                format(refineryownername[refineryid],sizeof(refineryownername),"");
                Delete3DTextLabel(refinerylabel[refineryid]);
                refineryx[refineryid] = 0;
                refineryy[refineryid] = 0;
                refineryz[refineryid] = 0;
                refinerystate[refineryid] = 0;
                refinerycost[refineryid] = 0;
                refinerytrailerstate[refineryid] = 0;
                DeleteRefineryData(refineryid);
                format(string,sizeof(string),"You have destoyed refinery id:%i",refineryid);
                SendClientMessage(playerid, RED, string);
			}
			else
			{
			    SendClientMessage(playerid, RED, "A player owns this refinery, You can't delete it");
			}
		}
		else
		{
		    SendClientMessage(playerid, RED, "The refinery you have selected does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid, RED, "You have to be an admin inorder to use this command");
	}
	return 1;
}
CMD:disapproverefinerypickup(playerid, params[])//Working
{
    if((edittrailerposstate[playerid])==1)
	{
	    edittrailerposstate[playerid] = 3;
	    SendClientMessage(playerid, RED, "You have canceled this position, please wait intill the trailer disapears before editing again");
	}
	else
	{
        SendClientMessage(playerid, RED, "You are not makeing a refinery pickup zone");
	}
	return 1;
}
CMD:approverefinerypickup(playerid, params[])//Working
{
	if((edittrailerposstate[playerid])==1)
	{
	    edittrailerposstate[playerid] = 2;
	    SendClientMessage(playerid, LIGHTBLUE, "You approved this position, please wait intill the trailer disapears before editing again");
	}
	else
	{
	    SendClientMessage(playerid, RED, "You are not makeing a refinery pickup zone");
	}
	return 1;
}
CMD:createrefinerypickup(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid,3))
	{
		new refineryid;
	    if(sscanf(params,"i",refineryid))
	    {
	        return SendClientMessage(playerid,RED,"SYNTAX/createrefinerypickup [refineryid]");
	    }
		if((refinerystate[refineryid])==1)
		{
		    if((edittrailerposstate[playerid])==0)
		    {
				GetPlayerPos(playerid,refinerytrailerx[refineryid],refinerytrailery[refineryid],refinerytrailerz[refineryid]);
				GetPlayerFacingAngle(playerid,refinerytrailerrot[refineryid]);
				edittrailerposstate[playerid] = 1;
				refinerytrailerz[refineryid] = refinerytrailerz[refineryid] + 2.0;
				new Float:x = refinerytrailerx[refineryid] +5;
				SetPlayerPos(playerid,x,refinerytrailery[refineryid],refinerytrailerz[refineryid]);
				SetTimerEx("RefineryPickup",20000,false,"ii",playerid,refineryid);
				edittrailertrailer[playerid] = CreateVehicle(584,refinerytrailerx[refineryid],refinerytrailery[refineryid],refinerytrailerz[refineryid],refinerytrailerrot[refineryid],0,0,-1);
				SendClientMessage(playerid,LIGHTBLUE,"Do you like the trailers spot /approverefinerypickup /disapproverefinerypickup");
			}
			else
			{
			    SendClientMessage(playerid, RED, "You are already eding a trailer");
			}
		}
		else
		{
		    SendClientMessage(playerid, RED, "This refinery does not exist");
		}
	}
	else
	{
	    SendClientMessage(playerid,RED, "You have to be admin inorder to use this command");
	}
	return 1;
}
CMD:createrefinery(playerid, params[])//Working
{
	if(IsPlayerAdmince(playerid, 3))
	{
		new price;
		if(sscanf(params,"i",price))
		{
			return SendClientMessage(playerid, RED, "SYNTAX /createrefinery [price]");
		}
	    for(new count;count < MAX_REFINERYS;count++)
	    {
	        if((refinerystate[count])==0)
			{
			    new Float:x,Float:y,Float:z,string[256];
				refinerystate[count] = 1;
				refineryproductionstate[count] = 0;
				GetPlayerPos(playerid,x,y,z);
                refineryx[count] = x;
                refineryy[count] = y;
                refineryz[count] = z;
                refinerycost[count] = price;
                if(IsRefineryNotNearRefinery(count))
                {
                    format(string,sizeof(string),"Refinery:%i\nRefinery state:%s\n%s\nthere is a total of %f fuel",count,RefineryProductionState(count),RefineryOwner(count),TotalOil(count));
                    refinerylabel[count] = Create3DTextLabel(string,YELLOW,refineryx[count],refineryy[count],refineryz[count],DISTANCELABEL,0,0);
                    SaveQuickRefineryData(count);
                    SendClientMessage(playerid, LIGHTBLUE, "You have created a refinery");
                    SendClientMessage(playerid, ORANGE, "!NOTE don't forget to create a pickup zone for trailers /createrefinerypickup");
                }
                else
                {
                    refineryx[count] = 0;
                    refineryy[count] = 0;
                    refineryz[count] = 0;
                    refinerystate[count] = 0;
                    refinerycost[count] = 0;
                    SendClientMessage(playerid, RED, "This refinery is to close to another one");
                }
			    return 1;
			}
	    }
	    SendClientMessage(playerid, RED, "There are no more free slots for a refinery");
	}
	else
	{
		SendClientMessage(playerid, RED, "You have to be admin inorder to use this command");
	}
	return 1;
}
stock CurrentProcductionPercent(slotid,factoryid)
{
	new Float:precent = factorystockcurrent[slotid][factoryid];
	precent = precent / VehicleManufactureingPrice(factorydealerstockmodelid[slotid][factoryid]);
	precent = precent * 100;
	new precentrounded = floatround(precent,floatround_round);
	return precentrounded;
}
stock FactoryOrderState(slotid,factoryid)
{
	new str[128];
	if((factorystockstate[slotid][factoryid])==1)
	{
	    format(str,sizeof(str),"In Manufactureing");
	}
	else if((factorystockstate[slotid][factoryid])==2)
	{
		format(str,sizeof(str),"Done & Ready for delivery");
	}
	return str;
}
stock Float:DivideFuel(refineryid, Float:fuelammount)
{
	new oilstoragecount = 0;
	for(new count2 = 0;count2 < MAX_OILPUMPS;count2++)
	{
		if((oilstoragestate[count2][refineryid])==1)
		{
			oilstoragecount++;
		}
	}
	return fuelammount / oilstoragecount;
}
stock IsThereEnoughFuel(gasstationid,refineryid)
{
	new Float:tfuel = 0.0;
	for(new count;count < MAX_OILPUMPS;count++)
	{
	    if((oilstoragestate[count][refineryid])==1)
	    {
	        tfuel = tfuel + oilstoragefuel[count][refineryid];
	    }
	}
	if((tfuel) >= ammountofgasneeded[gasstationid])
	{
	    return true;
	}
	else
	{
		return false;
	}
}
stock Float:TotalGasInGasStation(gasstationid)
{
	new Float:tfuel;
	for(new count;count < MAX_GASPUMPS;count++)
	{
	    if((gaspumpstate[count][gasstationid])==1)
	    {
			tfuel = tfuel + gaspumpgas[count][gasstationid];
	    }
	}
	return tfuel;
}
stock CurrentReful(gaspumpid,gasstationid)
{
	new string[256];
    if((gaspumpusegestate[gaspumpid][gasstationid]) == 1)
    {
        format(string,sizeof(string),"Cost per L:$%i Currentbuyer:%s\ncurrentsale $%i %fL",gasstationgascost[gasstationid],gaspumpuser[gaspumpid][gasstationid],gaspumpcurrentsaleammount[gaspumpid][gasstationid],gaspumpcurrentfuelammount[gaspumpid][gasstationid]);
    }
    else if((gaspumpusegestate[gaspumpid][gasstationid]) == 0)
    {
        format(string,sizeof(string),"Cost per L:$%i\nlastsale $%i %fL",gasstationgascost[gasstationid],gaspumpcurrentsaleammount[gaspumpid][gasstationid],gaspumpcurrentfuelammount[gaspumpid][gasstationid]);
    }
	return string;
}
stock GetVehicleSpeed(vehicleid)
{
	new Float:speedx,Float:speedy,Float:speedz,Float:editspeed,finalspeed;
	GetVehicleVelocity(vehicleid,speedx,speedy,speedz);
	editspeed = floatsqroot(((speedx*speedx)+(speedy*speedy))+(speedz*speedz))*136.666667;
	finalspeed = floatround(editspeed,floatround_round);
	return finalspeed;
}
stock Float:GetVehicleSpeedAsFloat(vehicleid)
{
	new Float:speedx,Float:speedy,Float:speedz,Float:editspeed;
	GetVehicleVelocity(vehicleid,speedx,speedy,speedz);
	editspeed = floatsqroot(((speedx*speedx)+(speedy*speedy))+(speedz*speedz))*136.666667;
	return editspeed;
}
stock GasPumpUsage(gaspumpid,gasstationid)
{
	new string[128];
	if((gaspumpusegestate[gaspumpid][gasstationid])==1)
	{
	    format(string,sizeof(string),"%s Is filling up on gas",gaspumpuser[gaspumpid][gasstationid]);
	}
	else
	{
	    format(string,sizeof(string),"You can refuel your car buy useing /refuel");
	}
	return string;
}
stock IsVehicleTruck(vehicleid)
{
	new modelid = GetVehicleModel(vehicleid);
	if((modelid)==403)
	{
	    return true;
	}
	if((modelid)==514)
	{
	    return true;
	}
	if((modelid)==515)
	{
	    return true;
	}
	return false;
}
stock Float:TotalOil(refineryid)
{
	new Float:totalfuel;
	for(new count;count < MAX_OILPUMPS;count++)
	{
	    if((oilstoragestate[count][refineryid])==1)
	    {
			totalfuel = totalfuel + oilstoragefuel[count][refineryid];
	    }
	}
	return totalfuel;
}
stock RefineryOwner(refinery)
{
	new string[256];
	if((refineryownedstate[refinery])==0)
	{
		format(string,sizeof(string),"This refinery is not owned by anyone, /buyrefinery to buy it:$%i",refinerycost[refinery]);
	}
	else if((refineryownedstate[refinery])==1)
	{
	    format(string,sizeof(string),"This refinery is owend by:%s",refineryownername[refinery]);
	}
	return string;
}
stock FactoryOwnedState(factoryid)
{
	new string[256];
	if((factoryownedstate[factoryid])==0)
	{
		format(string,sizeof(string),"This factory is not owned by anyone. It is currently priced at $%i. /buyfactory to buy it",factorycost[factoryid]);
	}
	else if((factoryownedstate[factoryid])==1)
	{
	    format(string,sizeof(string),"This factory is owned by %s",factoryownername[factoryid]);
	}
	return string;
}
stock DealershipOwner(dealershipid)
{
	new string[256];
	if((dealershipownedstate[dealershipid])==0)
	{
	    format(string,sizeof(string),"This dealership is up for sale for $%i. /buydealership to buy it",dealershipcost[dealershipid]);
	}
	else if((dealershipownedstate[dealershipid])==1)
	{
	    format(string,sizeof(string),"this dealership is owned by %s",dealershipownername[dealershipid]);
	}
	return string;
}
stock GasStationOwner(gasstationid)
{
	new string[256];
	if((gasstationownedstate[gasstationid])==0)
	{
		format(string,sizeof(string),"the gasstation is not owner by anyone, /buygasstation to it :$%i",gasstationcost[gasstationid]);
	}
	else if((gasstationownedstate[gasstationid])==1)
	{
	    format(string,sizeof(string),"the gasstation is owned by:%s",gasstationownername[gasstationid]);
	}
	return string;
}
stock RefineryProductionState(refinery)
{
	new string[35];
	if((refineryproductionstate[refinery])==0)
	{
		format(string,sizeof(string),"{FF0000}Off{EAFF00}");
	}
	else if((refineryproductionstate[refinery])==1)
	{
	    format(string,sizeof(string),"{22D451}On{EAFF00}");
	}
	else if((refineryproductionstate[refinery])==2)
	{
	    format(string,sizeof(string),"{FF9100}Stalling{EAFF00}");
	}
	return string;
}
stock FactoryProductionState(factoryid)
{
	new string[25];
	if((factoryproductionstate[factoryid])==1)
	{
        format(string,sizeof(string),"{22D451}On{EAFF00}");
	}
	else
	{
        format(string,sizeof(string),"{FF0000}Off{EAFF00}");
	}
	return string;
}
stock IsOilStorageNearRefinery(oilstorageid,refinery)
{
	if(IsPointInRangeOfPoint(oilstoragex[oilstorageid][refinery],oilstoragey[oilstorageid][refinery],oilstoragez[oilstorageid][refinery],refineryx[refinery],refineryy[refinery],refineryz[refinery],200.0))
	{
		return true;
	}
	return false;
}
stock IsOilPumpNotNearOilPump(oilpumpid,refineryid)
{
	for(new count;count < MAX_OILPUMPS;count++)
	{
	    if((oilpumpstate[count][refineryid])==1)
	    {
	        if((oilpumpid)!=count)
	        {
	            if(IsPointInRangeOfPoint(oilpumpx[oilpumpid][refineryid],oilpumpy[oilpumpid][refineryid],oilpumpz[oilpumpid][refineryid],oilpumpx[count][refineryid],oilpumpy[count][refineryid],oilpumpz[count][refineryid],25.0))
	            {
	                return false;
	            }
	        }
	    }
	}
	return true;
}
stock IsOilStorageNotNearOilStorage(oilstorage,refinery)
{
	for(new count;count < MAX_OILPUMPS;count++)
	{
	    if((oilstoragestate[count][refinery])==1)
	    {
	        if((oilstorage)!=count)
	        {
		        if(IsPointInRangeOfPoint(oilstoragex[oilstorage][refinery],oilstoragey[oilstorage][refinery],oilstoragez[oilstorage][refinery],oilstoragex[count][refinery],oilstoragey[count][refinery],oilstoragez[count][refinery],5.0))
		        {
		            return false;
		        }
			}
	    }
	}
	return true;
}
stock IsRefineryNotNearRefinery(refinery)
{
	for(new count;count < MAX_REFINERYS;count++)
	{
	    if((refinerystate[count])==1)
	    {
	        if((refinery)!=count)
	        {
	            if(IsPointInRangeOfPoint(refineryx[refinery],refineryy[refinery],refineryz[refinery],refineryx[count],refineryy[count],refineryz[count],200.0))
	            {
	                return false;
	            }
	        }
	    }
	}
	return true;
}
stock IsPlayerAdmince(playerid,level)
{
	if(IsPlayerAdmin(playerid)||CustomAdmin(playerid,level))
	{
	    return true;
	}
	else
	{
	    return false;
	}
}
stock CustomAdmin(playerid,level)
{
    return CallLocalFunction("InputAdminSystem","ii",playerid,level);
}
stock IsPointInRangeOfPoint(Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2, Float:range)
{
    x2 -= x;
    y2 -= y;
    z2 -= z;
    return ((x2 * x2) + (y2 * y2) + (z2 * z2)) < (range * range);
}
stock IsGasPumpNearGasStation(gaspumpid,gasstationid)
{
	if(PointIsInRangeOfPoint(gasstationx[gasstationid],gasstationy[gasstationid],gasstationz[gasstationid],gaspumpx[gaspumpid][gasstationid],gaspumpy[gaspumpid][gasstationid],gaspumpz[gaspumpid][gasstationid],50.0))
	{
	    return true;
	}
	else
	{
	    return false;
	}
}
stock IsThereAnyOilPumps(refineryid)
{
	for(new count;count < MAX_OILPUMPS;count++)
	{
		if((oilpumpstate[count][refineryid])==1)
		{
			return true;
        }
	}
	return false;
}
stock DealershipCarState(shipingstate)
{
	new string[256];
	if((shipingstate)==1)
	{
		format(string,sizeof(string),"Currently in dealership");
	}
	else if((shipingstate)==2)
	{
		format(string,sizeof(string),"Order placed");
	}
	else if((shipingstate)==3)
	{
	    format(string,sizeof(string),"Current In manufactureing");
	}
	else if((shipingstate)==4)
	{
	    format(string,sizeof(string),"Done & Ready to be shipped");
	}
	return string;
}
stock LockType(carid)
{
	new string[8];
	if((carlocktype[carid])==0)
	{
	    format(string,sizeof(string),"No-Lock");
	}
	else if((carlocktype[carid])==1)
	{
	    format(string,sizeof(string),"S-Lock");
	}
	else if((carlocktype[carid])==2)
	{
	    format(string,sizeof(string),"E-Lock");
	}
	return string;
}
stock LockState(carid)
{
	new string[10];
	if((carlock[carid])==1)
	{
	    format(string,sizeof(string),"Locked");
	}
	else
	{
	    format(string,sizeof(string),"Un-Locked");
	}
	return string;
}
stock CarStock(carid)
{
	new string[256];
	if((cartype[carid])==2)
	{
	    format(string,sizeof(string),"%i in stock-new car-currently-%s",carstock[carid],LockState(carid));
	}
	else if((cartype[carid])==3)
	{
	    format(string,sizeof(string),"Used Car-currently-%s-Has %s",LockState(carid),LockType(carid));
	}
	return string;
}
SendLocalMessageEx(Float:x,Float:y,Float:z,color,message[])
{
	for(new i; i < MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(IsPlayerInRangeOfPoint(i,12.0,x,y,z))
			{
				SendClientMessage(i,color,message);
			}
		}
	}
}
SendLocalMessage(playerid, color, message[])
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	for(new i; i < MAX_PLAYERS;i++)
	{
	    if(IsPlayerConnected(i))
	    {
			if(IsPlayerInRangeOfPoint(i,12.0,x,y,z))
			{
				SendClientMessage(i,color,message);
			}
		}
	}
}
CheckIfGasIsAtMax(gaspumpid,gasstationid)
{
	if(gaspumpgas[gaspumpid][gasstationid] > MAX_GASPERPUMP)
	{
	    new Float:leftovergas = gaspumpgas[gaspumpid][gasstationid] - MAX_GASPERPUMP;
	    new INI:mainfile = INI_Open(mainfilename);
	    for(new count;count < MAX_GASPUMPS;count++)
	    {
	        if((gaspumpstate[count][gasstationid])==1)
	        {
	            if((gaspumpid)!=count)
	            {
	                if((gaspumpgas[count][gasstationid]) < MAX_GASPERPUMP)
	                {
	                	new Float:currentgas = gaspumpgas[count][gasstationid] - MAX_GASPERPUMP;
	                	currentgas = currentgas - (currentgas * 2);
						if((leftovergas) >=currentgas)
						{
							gaspumpgas[gaspumpid][gasstationid] = gaspumpgas[gaspumpid][gasstationid] - currentgas;
							gaspumpgas[count][gasstationid] = gaspumpgas[count][gasstationid] + currentgas;
							leftovergas = leftovergas - currentgas;
							SaveGasPumpData(mainfile,count,gasstationid);
						}
						else
						{
						    gaspumpgas[gaspumpid][gasstationid] = gaspumpgas[gaspumpid][gasstationid] - leftovergas;
						    gaspumpgas[count][gasstationid] = gaspumpgas[count][gasstationid] + leftovergas;
							leftovergas = 0;
                            SaveGasPumpData(mainfile,count,gasstationid);
							break;
						}
					}
	            }
	        }
	    }
	    INI_Close(mainfile);
	    if((leftovergas) > 0)
	    {
			gaspumpgas[gaspumpid][gasstationid] = gaspumpgas[gaspumpid][gasstationid] - leftovergas;
			printf("Could not fine room for %fL of fuel,It has been dumped from gasstation[%i][%i]",leftovergas,gaspumpid,gasstationid);
			leftovergas = 0;
	    }
	}
}
stock IsNumeric( string[ ] ) { for (new i = 0, j = strlen( string); i < j; i++) if ( string[i] > '9'|| string[i] < '0') return 0; return 1; } // thanks to Calgon from VX:RP
stock GetVehicleName(modelid) { return vNames[modelid - 400]; }
stock IsFloat(buf[])
{
	new l = strlen(buf);
	new dcount = 0;
	for(new i=0; i<l; i++)
	{
		if(buf[i] == '.')
		{
			if(i == 0 || i == l-1) return 0;
			else
			{
				dcount++;
			}
		}
		if((buf[i] > '9' || buf[i] < '0') && buf[i] != '+' && buf[i] != '-' && buf[i] != '.') return 0;
		if(buf[i] == '+' || buf[i] == '-')
		{
			if(i != 0 || l == 1) return 0;
		}
	}
	if(dcount == 0 || dcount > 1) return 0;    return 1;
}//thanks Sascha
stock IsVehicleAttachedToTrailer(vehicleid,trailerid)
{
    if(IsTrailerAttachedToVehicle(vehicleid))
    {
        new checktrailerid = GetVehicleTrailer(vehicleid);
        if((trailerid)==checktrailerid)
        {
            return true;
        }
        else
		{
		    return false;
		}
    }
    else
    {
        return false;
    }
}
stock RoundSpeed(speed)
{
	new editspeed;
	if((speed) < 5)
	{
	    editspeed = 0;
	}
	else if((speed) >= 5&&(speed) < 10)
	{
	    editspeed = 5;
	}
	else if((speed) >= 10&&(speed) < 15)
	{
		editspeed = 10;
	}
	else if((speed) >= 15&&(speed) < 20)
	{
		editspeed = 15;
	}
	else if((speed) >= 20&&(speed) < 25)
	{
		editspeed = 20;
	}
	else if((speed) >= 25&&(speed) < 30)
	{
		editspeed = 25;
	}
	else if((speed) >= 30&&(speed) < 35)
	{
		editspeed = 30;
	}
	else if((speed) >= 35&&(speed) < 40)
	{
		editspeed = 35;
	}
	else if((speed) >= 40&&(speed) < 45)
	{
		editspeed = 40;
	}
	else if((speed) >= 45&&(speed) < 50)
	{
		editspeed = 45;
	}
	else if((speed) >= 50&&(speed) < 55)
	{
		editspeed = 50;
	}
	else if((speed) >= 55&&(speed) < 60)
	{
		editspeed = 55;
	}
	else if((speed) >= 60&&(speed) < 65)
	{
		editspeed = 60;
	}
	else if((speed) >= 65&&(speed) < 70)
	{
		editspeed = 65;
	}
	else if((speed) >= 70&&(speed) < 75)
	{
		editspeed = 70;
	}
	else if((speed) >= 75&&(speed) < 80)
	{
		editspeed = 75;
	}
	else if((speed) >= 80&&(speed) < 85)
	{
		editspeed = 80;
	}
	else if((speed) >= 85&&(speed) < 90)
	{
		editspeed = 85;
	}
	else if((speed) >= 90&&(speed) < 95)
	{
		editspeed = 90;
	}
	else if((speed) >= 95&&(speed) < 100)
	{
		editspeed = 95;
	}
	else if((speed) >= 100&&(speed) < 105)
	{
		editspeed = 100;
	}
	else if((speed) >= 105&&(speed) < 110)
	{
		editspeed = 105;
	}
	else if((speed) >= 110&&(speed) < 115)
	{
		editspeed = 110;
	}
	else if((speed) >= 115&&(speed) < 120)
	{
		editspeed = 115;
	}
	else if((speed) >= 120&&(speed) < 125)
	{
		editspeed = 120;
	}
	else if((speed) >= 125&&(speed) < 130)
	{
		editspeed = 125;
	}
	else if((speed) >= 130&&(speed) < 135)
	{
		editspeed = 130;
	}
	else if((speed) >= 135&&(speed) < 140)
	{
		editspeed = 135;
	}
	else if((speed) >= 140&&(speed) < 145)
	{
		editspeed = 140;
	}
	else if((speed) >= 145 &&(speed) < 150)
	{
		editspeed = 145;
	}
	else if((speed) >= 150&&(speed) < 155)
	{
		editspeed = 150;
	}
	else if((speed) >= 155&&(speed) < 160)
	{
		editspeed = 155;
	}
	else if((speed) >= 160&&(speed) < 165)
	{
		editspeed = 160;
	}
	else if((speed) >= 165&&(speed) < 170)
	{
		editspeed = 165;
	}
	else if((speed) >= 170&&(speed) < 175)
	{
		editspeed = 170;
	}
	else if((speed) >= 175&&(speed) < 180)
	{
		editspeed = 175;
	}
	else if((speed) >= 180&&(speed) < 185)
	{
		editspeed = 180;
	}
	else if((speed) >= 185&&(speed) < 190)
	{
		editspeed = 185;
	}
	else if((speed) >= 190&&(speed) < 195)
	{
		editspeed = 190;
	}
	else if((speed) >= 195&&(speed) < 200)
	{
		editspeed = 195;
	}
	else if((speed) >= 200&&(speed) < 205)
	{
	    editspeed = 200;
	}
	else if((speed) >= 205)
	{
		editspeed = 205;
	}
	return editspeed;
}
stock GetClosestPointToPlayer(playerid,Float:range,indexstate[],Float:x[],Float:y[],Float:z[],size)
{
	new index = -1,first = 0, Float:closestdistance;
	for(new count = 0;count < size;count++)
	{
		if((indexstate[count])==1)
		{
			if(IsPlayerInRangeOfPoint(playerid,range,x[count],y[count],z[count]))
			{
				new Float:distance = GetPlayerDistanceFromPoint(playerid,x[count],y[count],z[count]);
				if((first)==0||(distance) < closestdistance)
				{
					first = 1;
					closestdistance = distance;
					index = count;
				}
			}
		}
	}
	return index;	
}
stock ReadRepairshopLog(index)
{
	new string[256],str[128];
	format(str,sizeof(str),"repairshopgrouplog[%i]",index);
	format(string,sizeof(string),"%s",QINI_String(grouplogfilename,str));
    return string;
}
stock GetModName(component)//creds to Kyle_Olsen for this //--http://forum.sa-mp.com/showthread.php?t=282514--//(changed it a bit)
{
    new modname[50];
    switch(component)
    {
       case 1000: format(modname, sizeof(modname), "Pro Spoiler");
       case 1001: format(modname, sizeof(modname), "Win Spoiler");
       case 1002: format(modname, sizeof(modname), "Drag Spoiler");
       case 1003: format(modname, sizeof(modname), "Alpha Spoiler");
       case 1004: format(modname, sizeof(modname), "Champ Scoop");
       case 1005: format(modname, sizeof(modname), "Fury Scoop");
       case 1006: format(modname, sizeof(modname), "Roof Scoop");
       case 1007: format(modname, sizeof(modname), "Right Sideskirt");
       case 1008: format(modname, sizeof(modname), "Nitrous x5");
       case 1009: format(modname, sizeof(modname), "Nitrous x2");
       case 1010: format(modname, sizeof(modname), "Nitrous x10");
       case 1011: format(modname, sizeof(modname), "Race Scoop");
       case 1012: format(modname, sizeof(modname), "Worx Scoop");
       case 1013: format(modname, sizeof(modname), "Round Fog Lights");
       case 1014: format(modname, sizeof(modname), "Champ Spoiler");
       case 1015: format(modname, sizeof(modname), "Race Spoiler");
       case 1016: format(modname, sizeof(modname), "Worx Spoiler");
       case 1017: format(modname, sizeof(modname), "Left Sideskirt");
       case 1018: format(modname, sizeof(modname), "Upswept Exhaust");
       case 1019: format(modname, sizeof(modname), "Twin Exhaust");
       case 1020: format(modname, sizeof(modname), "Large Exhaust");
       case 1021: format(modname, sizeof(modname), "Medium Exhaust");
       case 1022: format(modname, sizeof(modname), "Small Exhaust");
       case 1023: format(modname, sizeof(modname), "Fury Spoiler");
       case 1024: format(modname, sizeof(modname), "Square Fog Lights");
       case 1025: format(modname, sizeof(modname), "Offroad Wheels");
       case 1026, 1036, 1047, 1056, 1069, 1090: format(modname, sizeof(modname), "Right Alien Sideskirt");
       case 1027, 1040, 1051, 1062, 1071, 1094: format(modname, sizeof(modname), "Left Alien Sideskirt");
       case 1028, 1034, 1046, 1064, 1065, 1092: format(modname, sizeof(modname), "Alien Exhaust");
       case 1029, 1037, 1045, 1059, 1066, 1089: format(modname, sizeof(modname), "X-Flow Exhaust");
       case 1030, 1039, 1048, 1057, 1070, 1095: format(modname, sizeof(modname), "Right X-Flow Sideskirt");
       case 1031, 1041, 1052, 1063, 1072, 1093: format(modname, sizeof(modname), "Left X-Flow Sideskirt");
       case 1032, 1038, 1054, 1055, 1067, 1088: format(modname, sizeof(modname), "Alien Roof Vent");
       case 1033, 1035, 1053, 1061, 1068, 1091: format(modname, sizeof(modname), "X-Flow Roof Vent");
       case 1042: format(modname, sizeof(modname), "Right Chrome Sideskirt");
       case 1099: format(modname, sizeof(modname), "Left Chrome Sideskirt");
       case 1043, 1105, 1114, 1127, 1132, 1135: format(modname, sizeof(modname), "Slamin Exhaust");
       case 1044, 1104, 1113, 1126, 1129, 1136: format(modname, sizeof(modname), "Chrome Exhaust");
       case 1050, 1058, 1139, 1146, 1158, 1163: format(modname, sizeof(modname), "X-Flow Spoiler");
       case 1049, 1060, 1138, 1147, 1162, 1164: format(modname, sizeof(modname), "Alien Spoiler");
       case 1073: format(modname, sizeof(modname), "Shadow Wheels");
       case 1074: format(modname, sizeof(modname), "Mega Wheels");
       case 1075: format(modname, sizeof(modname), "Rimshine Wheels");
       case 1076: format(modname, sizeof(modname), "Wires Wheels");
       case 1077: format(modname, sizeof(modname), "Classic Wheels");
       case 1078: format(modname, sizeof(modname), "Twist Wheels");
       case 1079: format(modname, sizeof(modname), "Cutter Wheels");
       case 1080: format(modname, sizeof(modname), "Stitch Wheels");
       case 1081: format(modname, sizeof(modname), "Grove Wheels");
       case 1082: format(modname, sizeof(modname), "Import Wheels");
       case 1083: format(modname, sizeof(modname), "Dollar Wheels");
       case 1084: format(modname, sizeof(modname), "Trance Wheels");
       case 1085: format(modname, sizeof(modname), "Atomic Wheels");
       case 1086: format(modname, sizeof(modname), "Stereo");
       case 1087: format(modname, sizeof(modname), "Hydraulics");
       case 1096: format(modname, sizeof(modname), "Ahab Wheels");
       case 1097: format(modname, sizeof(modname), "Virtual Wheels");
       case 1098: format(modname, sizeof(modname), "Access Wheels");
       case 1100: format(modname, sizeof(modname), "Chrome Grill");
       case 1101: format(modname, sizeof(modname), "Left Chrome Flames Sideskirt");
       case 1102, 1107: format(modname, sizeof(modname), "Left Chrome Strip Sideskirt");
       case 1103: format(modname, sizeof(modname), "Convertible Roof");
       case 1106, 1124: format(modname, sizeof(modname), "Left Chrome Arches Sideskirt");
       case 1108, 1133, 1134: format(modname, sizeof(modname), "Right Chrome Strip Sideskirt");
       case 1109: format(modname, sizeof(modname), "Chrome Rear Bullbars");
       case 1110: format(modname, sizeof(modname), "Slamin Rear Bullbars");
       case 1111, 1112: format(modname, sizeof(modname), "Front Sign");
       case 1115: format(modname, sizeof(modname), "Chrome Front Bullbars");
       case 1116: format(modname, sizeof(modname), "Slamin Front Bullbars");
       case 1117, 1174, 1179, 1182, 1189, 1191: format(modname, sizeof(modname), "Chrome Front Bumper");
       case 1175, 1181, 1185, 1188, 1190: format(modname, sizeof(modname), "Slamin Front Bumper");
       case 1176, 1180, 1184, 1187, 1192: format(modname, sizeof(modname), "Chrome Rear Bumper");
       case 1177, 1178, 1183, 1186, 1193: format(modname, sizeof(modname), "Slamin Rear Bumper");
       case 1118: format(modname, sizeof(modname), "Right Chrome Trim Sideskirt");
       case 1119: format(modname, sizeof(modname), "Right Wheelcovers Sideskirt");
       case 1120: format(modname, sizeof(modname), "Left Chrome Trim Sideskirt");
       case 1121: format(modname, sizeof(modname), "Left Wheelcovers Sideskirt");
       case 1122: format(modname, sizeof(modname), "Right Chrome Flames Sideskirt");
       case 1123: format(modname, sizeof(modname), "Bullbar Chrome Bars");
       case 1125: format(modname, sizeof(modname), "Bullbar Chrome Lights");
       case 1128: format(modname, sizeof(modname), "Vinyl Hardtop Roof");
       case 1130: format(modname, sizeof(modname), "Hardtop Roof");
       case 1131: format(modname, sizeof(modname), "Softtop Roof");
       case 1140, 1148, 1151, 1156, 1161, 1167: format(modname, sizeof(modname), "X-Flow Rear Bumper");
       case 1141, 1149, 1150, 1154, 1159, 1168: format(modname, sizeof(modname), "Alien Rear Bumper");
       case 1142: format(modname, sizeof(modname), "Left Oval Vents");
       case 1143: format(modname, sizeof(modname), "Right Oval Vents");
       case 1144: format(modname, sizeof(modname), "Left Square Vents");
       case 1145: format(modname, sizeof(modname), "Right Square Vents");
       case 1152, 1157, 1165, 1170, 1172, 1173: format(modname, sizeof(modname), "X-Flow Front Bumper");
       case 1153, 1155, 1160, 1166, 1169, 1171: format(modname, sizeof(modname), "Alien Front Bumper");

    }
    return modname;
}
stock ReadParamsEx(input[])//Working
{
	new choice[256];
	format(choice,sizeof(choice),"%s",input);
	new text[256],read = 0;
	for(new c;c < sizeof(choice);c++)
	{
		if((read)==0)
		{
			if(choice[c] == '_')
			{
				read = 1;
			}
		}
		else
		{
		    if(choice[c] == '_')
		    {
		        if(isnull(text))
		        {
		            format(text,sizeof(text)," ");
		        }
		        else
		        {
			    	new texthold[256];
				    format(texthold,sizeof(texthold),"%s",text);
				    format(text,sizeof(text),"%s ",texthold);
				}
				continue;
		    }
			else if(choice[c] == ' ')
			{
			    break;
			}
			else
			{
			    if(isnull(text))
		        {
		            format(text,sizeof(text),"%c",choice[c]);
				}
				else
				{
					new texthold[256];
				    format(texthold,sizeof(texthold),"%s",text);
				    format(text,sizeof(text),"%s%c",texthold,choice[c]);
				}
			}
		}
	}
	return text;
}
stock GetPlayerNameReturn(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	return name;
}
Connect(playerid)
{
	new string[256],name[MAX_PLAYER_NAME];
	TextDrawShowForPlayer(playerid, scriptlabel);
 	GetPlayerName(playerid,name,sizeof(name));
 	format(string,sizeof(string),"gageenabled[%s]",name);
	gageenabled[playerid] = QINI_Int(playerdatafilename,string);
	/*format(string,sizeof(string),"repairshopgroup[%s]",name);//#4
	repairshopgroup[playerid] = QINI_Int(playerdatafilename,string);
	format(string,sizeof(string),"freq[%s]",name);
	freq[playerid] = QINI_Int(playerdatafilename,string);
	format(string,sizeof(string),"paycheckcount[%s]",name);
	paycheckcount[playerid] = QINI_Int(playerdatafilename,string);*/
	format(string,sizeof(string),"placeingblocks[%s]",name);
    placeingblocks[playerid] = QINI_Int(playerdatafilename,string);
	//SetTimerEx("PayCheck",60000,true,"i",playerid);//#4
	SendClientMessage(playerid,LIGHTBLUE,"This server uses JB-Cars 2 created by Horsemeat. Do /jbcarhelp for help");//Please don't remove this becuse It gives me credit you are allowed to use this script for what ever you want as long as this message is still here
}
RefreshCar(carid)//Working
{
	carfuel[carid] = fuel[car[carid]];
	fuel[car[carid]] = 100;
	DestroyVehicle(car[carid]);
	jbcarid[car[carid]] = 0;
    car[carid] = CreateVehicle(carmodelid[carid],carx[carid],cary[carid],carz[carid],carrot[carid],carcolor1[carid],carcolor2[carid],-1);
    jbcarid[car[carid]] = carid;
	fuel[car[carid]] = carfuel[carid];
	for(new count;count < 14;count++)
	{
		if((carmodslot[count][carid])!= 0)
		{
			AddVehicleComponent(car[carid],carmodslot[count][carid]);
		}
	}
	if((carlocktype[carid])==1)
	{
	    new engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(car[carid],engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(car[carid],engine,lights,alarm,carlock[car[carid]],bonnet,boot,objective);
	}
}
RemovePlayerFromCar(playerid)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
    SetPlayerPos(playerid,x,y,z + 3.0);
}
RemoveAllObjects()
{
	for(new count;count < 2000;count++)
	{
		if((count) < MAX_BLOCKS)
		{
		    if((spikestate[count])==1)
		    {
		        DeleteStrip(count);
		    }
		    if((roadblockstate[count])==1)
		    {
				DestroyDynamicObject(roadblockobject[count]);
		    }
		    if((barrelstate[count])==1)
		    {
		        DestroyDynamicObject(barrelobject[count]);
		    }
		}
	    if((count) < MAX_REPAIRSHOPS)
	    {
			if((repairshopstate[count])==1)
		    {
			    DestroyPickup(repairshoppickup[count]);
				Delete3DTextLabel(repairshoplabel[count]);
				DestroyDynamicObject(repairshop[count]);
		    }
	    }
	    if((count) < MAX_DISPOSERS)
	    {
	        if((disposecarstate[count])==1)
		    {
		        Delete3DTextLabel(disposelabel[count]);
		    }
	    }
	    if((count) < MAX_FACTORIES)
	    {
	        if((factorystate[count])==1)
		    {
		        Delete3DTextLabel(factorylabel[count]);
		    }
	    }
	    if((count) < MAX_DEALERSHIPS)
	    {
	        if((dealershipstate[count])==1)
		    {
		        Delete3DTextLabel(dealershiplabel[count]);
		    }
	    }
	    if((count) < MAX_GASSTATIONS)
	    {
	        if((gasstationstate[count])==1)
		    {
		        Delete3DTextLabel(gasstationlabel[count]);
		        for(new count2;count2 < MAX_GASPUMPS;count2++)
		        {
		            if((gaspumpstate[count2][count])==1)
		            {
		                Delete3DTextLabel(gaspumplabel[count2][count]);
		            }
		        }
		    }
	    }
	    if((count) < MAX_REFINERYS)
	    {
			if((refinerystate[count])==1)
		    {
		        for(new count2;count2 < MAX_OILPUMPS;count2++)
		        {
					if((oilpumpstate[count2][count])==1)
					{
					    Delete3DTextLabel(oilpumplabel[count2][count]);
					    DestroyDynamicObject(oilpumpobject[count2][count]);
					}
					if((oilstoragestate[count2][count])==1)
					{
						Delete3DTextLabel(oilstoragelabel[count2][count]);
						DestroyDynamicObject(oilstorageobject[count2][count]);
					}
		        }
		        Delete3DTextLabel(refinerylabel[count]);
		    }
	    }
	    if((carstate[count])==1)
	    {
	        if((cartype[count])==1/*||(cartype[count])==4*/)//#4
	        {
	            DestroyVehicle(car[count]);
	        }
	        else if((cartype[count])==2||(cartype[count])==3)
	        {
		        Delete3DTextLabel(carlabel[count]);
		        DestroyVehicle(car[count]);
			}
	    }
	}
}
SaveAllData()
{
    new INI:mainfile = INI_Open(mainfilename);
    new INI:carfile = INI_Open(carfilename);
    for(new count;count < 2000;count++)
	{
	    if((count) < MAX_REPAIRSHOPS)
	    {
            if((repairshopstate[count])==1)
		    {
				SaveRepairShopData(mainfile,count);
		    }
	    }
	    if((count) < MAX_DISPOSERS)
	    {
            if((disposecarstate[count])==1)
		    {
		        SaveDisposerData(mainfile,count);
		    }
	    }
	    if((count) < MAX_FACTORIES)
	    {
            if((factorystate[count])==1)
		    {
		        SaveFactoryData(mainfile,count);
		    }
	    }
	    if((count) < MAX_DEALERSHIPS)
	    {
		    if((dealershipstate[count])==1)
		    {
		        SaveDealershipData(mainfile,count);
		    }
	    }
	    if((count) < MAX_GASSTATIONS)
	    {
            SaveGasStationData(mainfile,count);
	        for(new count2;count2 < MAX_GASPUMPS;count2++)
	        {
	            if((gaspumpstate[count2][count])==1)
	            {
	                SaveGasPumpData(mainfile,count2,count);
	            }
	        }
	    }
	    if((count) < MAX_REFINERYS)
	    {
            if((refinerystate[count])==1)
		    {
		        for(new count2;count2 < MAX_OILPUMPS;count2++)
		        {
					if((oilpumpstate[count2][count])==1)
					{
					    SaveOilPumpData(mainfile,count2,count);
					}
					if((oilstoragestate[count2][count])==1)
					{
						SaveOilStorageData(mainfile,count2,count);
					}
		        }
		        SaveRefineryData(mainfile,count);
		    }
	    }
	    if((carstate[count])==1)
	    {
			SaveCarData(carfile,count);
	    }
	}
	INI_Close(carfile);
	INI_Close(mainfile);
}
CheckLockState(playerid,vehicleid)
{
	if(IsPlayerInAnyVehicle(playerid))
    {
	    if((gageenabled[playerid])==1)
	    {
		    if((carstate[jbcarid[vehicleid]])==1)
			{
				if((carlock[jbcarid[vehicleid]])==1)
				{
				    TextDrawSetString(textlocked[vehicleid],"Locked");
				}
				else
				{
				    TextDrawSetString(textlocked[vehicleid],"Un-Locked");
				}
			}
			else
			{
				TextDrawSetString(textlocked[vehicleid],"Un-Locked");
			}
		}
	}
}
Park(playerid,vehicleid,carid)
{
	new name[MAX_PLAYER_NAME],string[256];
	GetPlayerName(playerid,name,sizeof(name));
	if((cartype[carid])==1)
    {
	  	new engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		if((engine)==1)
		{
		    SetVehicleParamsEx(vehicleid,false,lights,alarm,doors,bonnet,boot,objective);
		    format(string,sizeof(string),"%s turns off the vehicle. %s took out the keys",name,name);
		    SendLocalMessage(playerid,PURPLE,string);
		}
		carfuel[carid] = fuel[vehicleid];
		GetVehiclePos(vehicleid,carx[carid],cary[carid],carz[carid]);
		GetVehicleZAngle(vehicleid,carrot[carid]);
		SendClientMessage(playerid, -1,"You parked the car");
		format(string,sizeof(string),"%s has parked his vehicle",name);
		SendLocalMessage(playerid,PURPLE,string);
		SaveQuickCarData(carid);
    }
    else if((cartype[carid])==2||(cartype[carid])==3)
    {
	    new engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		if((engine)==1)
		{
		    SetVehicleParamsEx(vehicleid,false,lights,alarm,doors,bonnet,boot,objective);
		    format(string,sizeof(string),"%s turns off the vehicle. %s took out the keys",name,name);
		    SendLocalMessage(playerid,PURPLE,string);
		}
		carfuel[carid] = fuel[vehicleid];
		GetVehiclePos(vehicleid,carx[carid],cary[carid],carz[carid]);
		GetVehicleZAngle(vehicleid,carrot[carid]);
		SendClientMessage(playerid, -1,"You parked the car");
		format(string,sizeof(string),"%s has parked a delearship vehicle",name);
		SendLocalMessage(playerid,PURPLE,string);
		SaveQuickCarData(carid);
    }
	/*else if((cartype[carid])==4)//#4
	{
	    new engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
		if((engine)==1)
		{
		    SetVehicleParamsEx(vehicleid,false,lights,alarm,doors,bonnet,boot,objective);
		    format(string,sizeof(string),"%s turns off the vehicle. %s took out the keys",name,name);
		    SendLocalMessage(playerid,PURPLE,string);
		}
		carfuel[carid] = fuel[vehicleid];
		GetVehiclePos(vehicleid,carx[carid],cary[carid],carz[carid]);
		GetVehicleZAngle(vehicleid,carrot[carid]);
		SendClientMessage(playerid, -1,"You parked a Group vehicle");
		format(string,sizeof(string),"%s has parked his vehicle",name);
		SendLocalMessage(playerid,PURPLE,string);
		GetPlayerName(playerid,name,sizeof(name));
        format(string,sizeof(string),"%s has parked group vehicle ID:%i modelid%i:%s",name,carid,carmodelid[carid],GetVehicleName(carmodelid[carid]));
        SaveRepairshopLog(string);
		for(new i;i < MAX_PLAYERS;i++)
		{
		    if(IsPlayerConnected(i))
		    {
				if((repairshopgroup[i])==1)
				{
				    SendClientMessage(i,REPAIRSHOPCOLOR,string);
				}
		    }
		}
		SaveQuickCarData(carid);
	}*/
}
AddCar(playerid,modelid)
{
	if((addvstate[playerid])==1)
	{
	    new string[256];
		if((VehicleSoldCost(modelid)) <= dealershipcash[choiceid[playerid]])
		{
			if((restrictcar[modelid])==1)
	        {
	            if(!IsPlayerAdmince(playerid,3))
	            {
	            	return SendClientMessage(playerid, RED, "This car is restriced you can't add it to a dealership");
				}
	        }
	        for(new count = 1;count < MAX_VEHICLES;count++)
	        {
	            if((carstate[count])==1)
	            {
	                if((cartype[count])==2)
	                {
	                    if((cardealershipid[count])==choiceid[playerid])
	                    {
							if((carmodelid[count])==modelid)
							{
								ShowPlayerDialog(playerid,CANCEL,DIALOG_STYLE_MSGBOX,"Add Car","You already have this car in your dealership, You can add it again","Close","Close");
								return 1;
							}
						}
	                }
	            }
	        }
			choicemodelid[playerid] = modelid;
			format(string,sizeof(string),"This vehicle will cost $%i from the factory. Please enter how mutch you are going to sell it for",VehicleSoldCost(modelid));
   			ShowPlayerDialog(playerid,DEALERSHIPAPROVE,DIALOG_STYLE_INPUT,"How mutch?",string,"Ok","Cancel");
		}
		else
		{
		    format(string,sizeof(string),"The vehicle cost $%i to manufacture you only have $%i in you dealership",VehicleManufactureingPrice(modelid),dealershipcash[choiceid[playerid]]);
			SendClientMessage(playerid, RED, string);
		}
	}
    else if((addvstate[playerid])==2)
    {
        if((restrictcar[modelid])==1)
        {
            if(!IsPlayerAdmince(playerid,1))
            {
            	return SendClientMessage(playerid, RED, "This car is restriced you can't spawn it");
			}
        }
		new Float:x,Float:y,Float:z,Float:xrot;
		new string[256];
		GetPlayerPos(playerid,x,y,z);
		GetPlayerFacingAngle(playerid,xrot);
		CreateVehicle(modelid,x,y+2.5,z+2.5,xrot,choicecolor1[playerid],choicecolor2[playerid],-1);
		format(string,sizeof(string),"You just spawned a %i:%s at %f-%f-%f-%f",modelid,GetVehicleName(modelid),x,y,z,xrot);
		SendClientMessage(playerid,YELLOW,string);
		addvstate[playerid] = 0;
	   	choicecolor1[playerid] = 0;
		choicecolor2[playerid] = 0;
		choiceid[playerid] = 0;
	}
	else if((addvstate[playerid])==3)
	{
		if((restrictcar[modelid])==0)
		{
		    restrictcar[modelid] = 1;
		    SendClientMessage(playerid, LIGHTBLUE, "You have restriced this vehicle");
		    SaveRestrictedCarData(modelid);
		}
		else if((restrictcar[modelid])==1)
		{
		    restrictcar[modelid] = 0;
		    SendClientMessage(playerid, LIGHTBLUE, "You have unrestricted this vehicle");
		    SaveRestrictedCarData(modelid);
		}
	}
	else if((addvstate[playerid])==4)
	{
	    new string[256];
	    choiceid[playerid] = modelid;
	    format(string,sizeof(string),"Please enter how much you want the %s to cost it currently costs $%i to manufacture and $%i after manufacturing",GetVehicleName(modelid),vehiclemanufactureingcost[modelid - 400],VehicleSoldCost(choiceid[playerid]));
	    ShowPlayerDialog(playerid,VEHICLEMAKEPRICE,DIALOG_STYLE_INPUT,"Vehicle Cost",string,"Ok","Cancel");
	}
	else if((addvstate[playerid])==5)
	{
	    if((requeststockstate[modelid - 400][choiceid[playerid]])!=0)
	    {
	        if((requeststockstate[modelid - 400][choiceid[playerid]])==1)
	        {
	            new string[256];
	            choicemodelid[playerid] = modelid;
	            format(string,sizeof(string),"This car will cost $%i for each purchase, Please enter how many cars you want",VehicleSoldCost(modelid));
	            ShowPlayerDialog(playerid,DEALERSHIPBUYCAR,DIALOG_STYLE_INPUT,"Ammount",string,"Ok","Close");
	        }
	        else
	        {
	            ShowPlayerDialog(playerid,DEALERSHIPBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Dealershipmenu order","You already have an order for this vehicle you can cancle it and order it again","Back","Close");
	        }
	    }
	    else
	    {
	        ShowPlayerDialog(playerid,DEALERSHIPBACK&CANCEL,DIALOG_STYLE_MSGBOX,"Dealershipmenu order","You don't have this car in your dealership","Back","Close");
	    }
	}
	else if((addvstate[playerid])==6)
	{
	    new string[256];
	    format(string,sizeof(string),"A %s will cost $%i to order from a factory",GetVehicleName(modelid),VehicleSoldCost(modelid));
	    ShowPlayerDialog(playerid,CANCEL,DIALOG_STYLE_MSGBOX,"Vehicle manufacture cost",string,"Close","Close");
	}
	return 1;
}
VehicleManufactureingPrice(modelid) return vehiclemanufactureingcost[modelid - 400];
VehicleSoldCost(modelid) return floatround(vehiclemanufactureingcost[modelid - 400] * FACTORYMARKUPPRECENT,floatround_round);
GasStationCapacity(gasstationid)
{
	new numofgaspumps;
	for(new count;count < MAX_GASPUMPS;count++)
	{
	    if((gaspumpstate[count][gasstationid])==1)
	    {
	        numofgaspumps++;
	    }
	}
	gasstationtotalcapacity[gasstationid] = numofgaspumps * MAX_GASPERPUMP;
}
UpdateRefineryLabels(refineryid)
{
	new string[256];
	for(new count;count < MAX_GASPUMPS;count++)
	{
		if((oilstoragestate[count][refineryid])==1)
		{
  			format(string,sizeof(string),"ID:%i-%i\n This fuelstorage is owned by %s\nThere is currently %fL out of %f fuel in hear\ncurrentstate:%s",count,refineryid,refineryownername[refineryid],oilstoragefuel[count][refineryid],MAX_OILSTORAGE,RefineryProductionState(refineryid));
			Update3DTextLabelText(oilstoragelabel[count][refineryid],YELLOW,string);
		}
	}
	format(string,sizeof(string),"Refinery:%i\nRefinery state:%s\n%s\nthere is a total of %f fuel",refineryid,RefineryProductionState(refineryid),RefineryOwner(refineryid),TotalOil(refineryid));
	Update3DTextLabelText(refinerylabel[refineryid],YELLOW,string);
}
UpdateCarLabel(carid)
{
	new str[256];
	format(str,sizeof(str),"%i:Dealership vehicle\nThis vehicle cost $%i\n%s",cardealershipid[carid],carcost[carid],CarStock(carid));
	Update3DTextLabelText(carlabel[carid],YELLOW,str);
}
UpdateFactoryLabel(factoryid)
{
	new str[256];
	format(str,sizeof(str),"Factory id:%i\n%s\nfactoryproductionstate:%s",factoryid,FactoryOwnedState(factoryid),FactoryProductionState(factoryid));
	Update3DTextLabelText(factorylabel[factoryid],YELLOW,str);
}
UpdateDealershipLabels(dealershipid)
{
	new str[256];
	format(str,sizeof(str),"%s\ndealership:%i\n%s",dealershipname[dealershipid],dealershipid,DealershipOwner(dealershipid));
	Update3DTextLabelText(dealershiplabel[dealershipid],YELLOW,str);
}
UpdateGasStationLabels(gasstationid)
{
	new string[256];
	for(new gaspumpid;gaspumpid < MAX_GASPUMPS;gaspumpid++)
	{
		if((gaspumpstate[gaspumpid][gasstationid])==1)
		{
			format(string,sizeof(string),"gaspump:%i-%i\n%s\ncurrentfuel:%f our of %f\n%s",gaspumpid,gasstationid,CurrentReful(gaspumpid,gasstationid),gaspumpgas[gaspumpid][gasstationid],MAX_GASPERPUMP,GasPumpUsage(gaspumpid,gasstationid));
			Update3DTextLabelText(gaspumplabel[gaspumpid][gasstationid],YELLOW,string);
		}
	}
	format(string,sizeof(string),"%s\ngasstationID:%i\n%s\nyou have %f gas",gasstationname[gasstationid],gasstationid,GasStationOwner(gasstationid),TotalGasInGasStation(gasstationid));
	Update3DTextLabelText(gasstationlabel[gasstationid],YELLOW,string);
}
GasStationAddSlot(gasstationid)
{
	for(new count;count < MAX_SLOTS;count++)
	{
	    if((gasstationrequestslotstate[count])==0)
	    {
			gasstationrequestslotstate[count] = 1;
			gasstationrequestslot[count] = gasstationid;
            SaveGasStationRequestSlotData();
			break;
	    }
	}
}
DealershipAddSlot(dealershipid,slotid)
{
	for(new count;count < MAX_SLOTS;count++)
	{
	    if((dealershiprequestslotstate[count])==0)
	    {
			dealershiprequestslotstate[count] = 1;
			dealershiprequestslot[1][count] = dealershipid;
			dealershiprequestslot[0][count] = slotid;
            SaveDealershipRequestSlotData();
			break;
	    }
	}
}
GasStationRemoveSlot(gasstationid)
{
	for(new count;count < MAX_SLOTS;count++)
	{
	    if((gasstationrequestslotstate[count])==1)
	    {
	        if((gasstationrequestslot[count])==gasstationid)
	        {
	            gasstationrequestslotstate[count] = 0;
	            gasstationrequestslot[count] = 0;
				SaveGasStationRequestSlotData();
				break;
	        }
	    }
	}
}
DealershipRemoveSlot(dealershipid,slotid)
{
	for(new count;count < MAX_SLOTS;count++)
	{
	    if((dealershiprequestslotstate[count])==1)
	    {
	        if((dealershiprequestslot[1][count])==dealershipid)
	        {
	            if((dealershiprequestslot[0][count])==slotid)
	            {
	                dealershiprequestslotstate[count] = 0;
	                dealershiprequestslot[0][count] = 0;
	                dealershiprequestslot[1][count] = 0;
	                SaveDealershipRequestSlotData();
	                break;
	            }
	        }
	    }
	}
}
OrganizeGasStationRequestSlot()
{
	for(new count = 0;count < MAX_SLOTS - 1;count++)
	{
	    if((gasstationrequestslotstate[count])==1)
	    {
	        if((gasstationstate[gasstationrequestslot[count]])==0||(gasstationneedgasstate[gasstationrequestslot[count]])==0||(gasstationownedstate[gasstationrequestslot[count]])==0)
	        {
	            gasstationrequestslotstate[count] = 0;
	            gasstationrequestslot[count] = 0;
	        }
	    }
	    if((gasstationrequestslotstate[count])==0&&(gasstationrequestslotstate[count + 1])==1)
	    {
			gasstationrequestslot[count] = gasstationrequestslot[count + 1];
			gasstationrequestslot[count + 1] = 0;
			gasstationrequestslotstate[count] = 1;
			gasstationrequestslotstate[count + 1] = 0;
	    }
	    else if((gasstationrequestslotstate[count])==0&&(gasstationrequestslotstate[count + 1])==0)
	    {
			new changed2 = 0;
	        for(new count2 = count;count2 < MAX_SLOTS;count2++)
	        {
	            if((gasstationrequestslotstate[count2])==1)
	            {
	                changed2 = 1;
					gasstationrequestslot[count] = gasstationrequestslot[count2];
					gasstationrequestslot[count2] = 0;
					gasstationrequestslotstate[count] = 1;
					gasstationrequestslotstate[count2] = 0;
					break;
	            }
	        }
	        if((changed2)==0)
	        {
				for(new count2;count2 < MAX_GASSTATIONS;count2++)
				{
					if((gasstationstate[count2])==1)
					{
					    if((gasstationneedgasstate[count2]) == 1)
					    {
						    new changed3 = 0;
							for(new count3;count3 < MAX_SLOTS;count3++)
							{
							    if((gasstationrequestslotstate[count3])==1)
							    {
							        if((gasstationrequestslot[count3]) == count2)
							        {
							            changed3 = 1;
							            break;
							        }
							    }
							}
							if((changed3)==0)
							{
							    gasstationrequestslotstate[count] = 1;
							    gasstationrequestslot[count] = count2;
							    break;
							}
						}
					}
				}
			}
	    }
	}
	SaveGasStationRequestSlotData();
}
OrganizeDealershipRequestSlot()
{
	for(new count;count < MAX_SLOTS - 1;count++)
	{
	    if((dealershiprequestslotstate[count])==1)
	    {
	        if((dealershipstate[dealershiprequestslot[1][count]])==0||(dealershipownedstate[dealershiprequestslot[1][count]])==0||(requeststockstate[dealershiprequestslot[0][count]][dealershiprequestslot[1][count]])!=2)
	        {
	            dealershiprequestslot[0][count] = 0;
	            dealershiprequestslot[1][count] = 0;
	            dealershiprequestslotstate[count] = 0;
	        }
	    }
	    if((dealershiprequestslotstate[count])==0&&(dealershiprequestslotstate[count + 1])==1)
	    {
			dealershiprequestslot[0][count] = dealershiprequestslot[0][count + 1];
			dealershiprequestslot[1][count] = dealershiprequestslot[1][count + 1];
			dealershiprequestslot[0][count + 1] = 0;
			dealershiprequestslot[1][count + 1] = 0;
			dealershiprequestslotstate[count] = 1;
			dealershiprequestslotstate[count + 1] = 0;
	    }
	    else if((dealershiprequestslotstate[count])==0&&(dealershiprequestslotstate[count + 1])==0)
	    {
			new changed2 = 0;
	        for(new count2 = count;count2 < MAX_SLOTS;count2++)
	        {
	            if((dealershiprequestslotstate[count2])==1)
	            {
	                changed2 = 1;
					dealershiprequestslot[1][count] = dealershiprequestslot[1][count2];
					dealershiprequestslot[0][count] = dealershiprequestslot[0][count2];
					dealershiprequestslot[0][count2] = 0;
					dealershiprequestslot[1][count2] = 0;
					dealershiprequestslotstate[count] = 1;
					dealershiprequestslotstate[count2] = 0;
					break;
	            }
	        }
	        new globalbreakout;
	        if((changed2)==0)
	        {
	            for(new count2;count2 < MAX_DEALERSHIPS;count2++)
	            {
	                if((dealershipstate[count2])==1)
	                {
	                    for(new count3;count3 < 212;count3++)
	                    {
	                        if((requeststockstate[count3][count2])==2)
	                        {
	                            new changed3;
	                            for(new count4;count4 < MAX_SLOTS;count4++)
	                            {
	                                if((dealershiprequestslotstate[count4])==1)
	                                {
	                                    if((dealershiprequestslot[0][count4])==count3&&dealershiprequestslot[1][count4]==count2)
	                                    {
	                                        changed3 = 1;
	                                        break;
	                                    }
	                                }
	                            }
	                            if((changed3)==0)
	                            {
	                                dealershiprequestslot[0][count] = count3;
	                                dealershiprequestslot[1][count] = count2;
	                                dealershiprequestslotstate[count] = 1;
	                                globalbreakout = 1;
	                                break;
	                            }
	                        }
	                    }
	                }
                 	if((globalbreakout)==1)
                    {
                        break;
                    }
	            }
			}
	    }
	}
	SaveDealershipRequestSlotData();
}
UpdateRepairShopLabel(repairshopid)
{
	new string[256];
    if((repairshopstate[repairshopid])==1)
    {
        format(string,sizeof(string),"%i:repairgarage\n/repaircar to repair your car /buylock to buy a lock\nit cost $%i to repair your car & E-$%iS-$%i to buy a lock",repairshopid,repairshopcost[repairshopid],repairshopelockcost[repairshopid],repairshopslockcost[repairshopid]);
    	Update3DTextLabelText(repairshoplabel[repairshopid],YELLOW,string);
    }
}
SaveQuickBarrelData(barrelid)
{
	new INI:mainfile = INI_Open(mainfilename);
	SaveBarrelData(mainfile, barrelid);
	INI_Close(mainfile);
}
SaveBarrelData(INI:mainfile, barrelid)
{
	new str[128];
	format(str,sizeof(str),"barrelstate[%i]",barrelid);
	INI_WriteInt(mainfile,str,barrelstate[barrelid]);
	format(str,sizeof(str),"barrelx[%i]",barrelid);
	INI_WriteFloat(mainfile,str,barrelx[barrelid],6);
	format(str,sizeof(str),"barrely[%i]",barrelid);
	INI_WriteFloat(mainfile,str,barrely[barrelid],6);
	format(str,sizeof(str),"barrelz[%i]",barrelid);
	INI_WriteFloat(mainfile,str,barrelz[barrelid],6);
	format(str,sizeof(str),"barrelxrot[%i]",barrelid);
	INI_WriteFloat(mainfile,str,barrelxrot[barrelid],6);
	format(str,sizeof(str),"barrelyrot[%i]",barrelid);
	INI_WriteFloat(mainfile,str,barrelyrot[barrelid],6);
	format(str,sizeof(str),"barrelzrot[%i]",barrelid);
	INI_WriteFloat(mainfile,str,barrelzrot[barrelid],6);
}
DeleteBarrelData(barrelid)//checked
{
    new INI:mainfile = INI_Open(mainfilename);
    new str[128];
    barrelstate[barrelid] = 0;
    barrelx[barrelid] = 0;
    barrely[barrelid] = 0;
    barrelz[barrelid] = 0;
    barrelxrot[barrelid] = 0;
    barrelyrot[barrelid] = 0;
    barrelzrot[barrelid] = 0;
	format(str,sizeof(str),"barrelstate[%i]",barrelid);
	INI_WriteInt(mainfile,str,barrelstate[barrelid]);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"barrelx[%i]",barrelid);
	INI_WriteFloat(mainfile,str,barrelx[barrelid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"barrely[%i]",barrelid);
	INI_WriteFloat(mainfile,str,barrely[barrelid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"barrelz[%i]",barrelid);
	INI_WriteFloat(mainfile,str,barrelz[barrelid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"barrelxrot[%i]",barrelid);
	INI_WriteFloat(mainfile,str,barrelxrot[barrelid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"barrelyrot[%i]",barrelid);
	INI_WriteFloat(mainfile,str,barrelyrot[barrelid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"barrelzrot[%i]",barrelid);
	INI_WriteFloat(mainfile,str,barrelzrot[barrelid],6);
	INI_RemoveEntry(mainfile,str);
	INI_Close(mainfile);
}
SaveQuickRoadblockData(roadblockid)
{
	new INI:mainfile = INI_Open(mainfilename);
	SaveRoadblockData(mainfile, roadblockid);
	INI_Close(mainfile);
}
SaveRoadblockData(INI:mainfile, roadblockid)
{
	new str[128];
	format(str,sizeof(str),"roadblockstate[%i]",roadblockid);
	INI_WriteInt(mainfile,str,roadblockstate[roadblockid]);
	format(str,sizeof(str),"roadblockx[%i]",roadblockid);
	INI_WriteFloat(mainfile,str,roadblockx[roadblockid],6);
	format(str,sizeof(str),"roadblocky[%i]",roadblockid);
	INI_WriteFloat(mainfile,str,roadblocky[roadblockid],6);
	format(str,sizeof(str),"roadblockz[%i]",roadblockid);
	INI_WriteFloat(mainfile,str,roadblockz[roadblockid],6);
	format(str,sizeof(str),"roadblockxrot[%i]",roadblockid);
	INI_WriteFloat(mainfile,str,roadblockxrot[roadblockid],6);
	format(str,sizeof(str),"roadblockyrot[%i]",roadblockid);
	INI_WriteFloat(mainfile,str,roadblockyrot[roadblockid],6);
	format(str,sizeof(str),"roadblockzrot[%i]",roadblockid);
	INI_WriteFloat(mainfile,str,roadblockzrot[roadblockid],6);
}
DeleteRoadblockData(roadblockid)//Checked
{
	new INI:mainfile = INI_Open(mainfilename);
	new str[128];
	roadblockstate[roadblockid] = 0;
	roadblockx[roadblockid] = 0.0;
	roadblocky[roadblockid] = 0.0;
    roadblockz[roadblockid] = 0.0;
    roadblockxrot[roadblockid] = 0.0;
    roadblockyrot[roadblockid] = 0.0;
    roadblockzrot[roadblockid] = 0.0;
	format(str,sizeof(str),"roadblockstate[%i]",roadblockid);
	INI_WriteInt(mainfile,str,roadblockstate[roadblockid]);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"roadblockx[%i]",roadblockid);
	INI_WriteFloat(mainfile,str,roadblockx[roadblockid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"roadblocky[%i]",roadblockid);
	INI_WriteFloat(mainfile,str,roadblocky[roadblockid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"roadblockz[%i]",roadblockid);
	INI_WriteFloat(mainfile,str,roadblockz[roadblockid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"roadblockxrot[%i]",roadblockid);
	INI_WriteFloat(mainfile,str,roadblockxrot[roadblockid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"roadblockyrot[%i]",roadblockid);
	INI_WriteFloat(mainfile,str,roadblockyrot[roadblockid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"roadblockzrot[%i]",roadblockid);
	INI_WriteFloat(mainfile,str,roadblockzrot[roadblockid],6);
	INI_RemoveEntry(mainfile,str);
	INI_Close(mainfile);
}
SaveQuickSpikeData(spikeid)
{
	new INI:mainfile = INI_Open(mainfilename);
	SaveSpikeData(mainfile,spikeid);
	INI_Close(mainfile);
}
SaveSpikeData(INI:mainfile,spikeid)
{
	new str[128];
	format(str,sizeof(str),"spikestate[%i]",spikeid);
	INI_WriteInt(mainfile,str,spikestate[spikeid]);
	format(str,sizeof(str),"spikex[%i]",spikeid);
	INI_WriteFloat(mainfile,str,spikex[spikeid],6);
	format(str,sizeof(str),"spikey[%i]",spikeid);
	INI_WriteFloat(mainfile,str,spikey[spikeid],6);
	format(str,sizeof(str),"spikez[%i]",spikeid);
	INI_WriteFloat(mainfile,str,spikez[spikeid],6);
	format(str,sizeof(str),"spikexrot[%i]",spikeid);
	INI_WriteFloat(mainfile,str,spikexrot[spikeid],6);
	format(str,sizeof(str),"spikeyrot[%i]",spikeid);
	INI_WriteFloat(mainfile,str,spikeyrot[spikeid],6);
	format(str,sizeof(str),"spikezrot[%i]",spikeid);
	INI_WriteFloat(mainfile,str,spikezrot[spikeid],6);
}
DeleteSpikeData(spikeid)
{
	new INI:mainfile = INI_Open(mainfilename);
	new str[128];
	spikestate[spikeid] = 0;
	spikex[spikeid] = 0.0;
	spikey[spikeid] = 0.0;
	spikez[spikeid] = 0.0;
	spikexrot[spikeid] = 0.0;
	spikeyrot[spikeid] = 0.0;
    spikezrot[spikeid] = 0.0;
	format(str,sizeof(str),"spikestate[%i]",spikeid);
	INI_WriteInt(mainfile,str,spikestate[spikeid]);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"spikex[%i]",spikeid);
	INI_WriteFloat(mainfile,str,spikex[spikeid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"spikey[%i]",spikeid);
	INI_WriteFloat(mainfile,str,spikey[spikeid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"spikez[%i]",spikeid);
	INI_WriteFloat(mainfile,str,spikez[spikeid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"spikexrot[%i]",spikeid);
	INI_WriteFloat(mainfile,str,spikexrot[spikeid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"spikeyrot[%i]",spikeid);
	INI_WriteFloat(mainfile,str,spikeyrot[spikeid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"spikezrot[%i]",spikeid);
	INI_WriteFloat(mainfile,str,spikezrot[spikeid],6);
	INI_RemoveEntry(mainfile,str);
	INI_Close(mainfile);
}
SaveQuickRepairShopData(repairshopid)
{
	new INI:mainfile = INI_Open(mainfilename);
	SaveRepairShopData(mainfile,repairshopid);
	INI_Close(mainfile);
}
SaveRepairShopData(INI:mainfile,repairshopid)
{
	new str[128];
	format(str,sizeof(str),"repairshopstate[%i]",repairshopid);
	INI_WriteInt(mainfile,str,repairshopstate[repairshopid]);
	format(str,sizeof(str),"repairshopx[%i]",repairshopid);
	INI_WriteFloat(mainfile,str,repairshopx[repairshopid],6);
	format(str,sizeof(str),"repairshopy[%i]",repairshopid);
	INI_WriteFloat(mainfile,str,repairshopy[repairshopid],6);
	format(str,sizeof(str),"repairshopz[%i]",repairshopid);
	INI_WriteFloat(mainfile,str,repairshopz[repairshopid],6);
	format(str,sizeof(str),"repairshopxrot[%i]",repairshopid);
	INI_WriteFloat(mainfile,str,repairshopxrot[repairshopid]);
	format(str,sizeof(str),"repairshopyrot[%i]",repairshopid);
	INI_WriteFloat(mainfile,str,repairshopyrot[repairshopid]);
	format(str,sizeof(str),"repairshopzrot[%i]",repairshopid);
	INI_WriteFloat(mainfile,str,repairshopzrot[repairshopid]);
	format(str,sizeof(str),"repairshopobjectid[%i]",repairshopid);
	INI_WriteInt(mainfile,str,repairshopobjectid[repairshopid]);
	format(str,sizeof(str),"repairshopcost[%i]",repairshopid);
	INI_WriteInt(mainfile,str,repairshopcost[repairshopid]);
	format(str,sizeof(str),"repairshopelockcost[%i]",repairshopid);
	INI_WriteInt(mainfile,str,repairshopelockcost[repairshopid]);
	format(str,sizeof(str),"repairshopslockcost[%i]",repairshopid);
	INI_WriteInt(mainfile,str,repairshopslockcost[repairshopid]);
}
DeleteRepairShopData(repairshopid)
{
	new str[128];
	new INI:mainfile = INI_Open(mainfilename);
	repairshopstate[repairshopid] = 0;
	repairshopx[repairshopid] = 0;
	repairshopy[repairshopid] = 0;
	repairshopz[repairshopid] = 0;
	repairshopxrot[repairshopid] = 0;
	repairshopyrot[repairshopid] = 0;
	repairshopzrot[repairshopid] = 0;
	repairshopobjectid[repairshopid] = 0;
	repairshopcost[repairshopid] = 0;
	repairshopelockcost[repairshopid] = 0;
	repairshopslockcost[repairshopid] = 0;
	format(str,sizeof(str),"repairshopstate[%i]",repairshopid);
	INI_WriteInt(mainfile,str,repairshopstate[repairshopid]);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"repairshopx[%i]",repairshopid);
	INI_WriteFloat(mainfile,str,repairshopx[repairshopid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"repairshopy[%i]",repairshopid);
	INI_WriteFloat(mainfile,str,repairshopy[repairshopid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"repairshopz[%i]",repairshopid);
	INI_WriteFloat(mainfile,str,repairshopz[repairshopid],6);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"repairshopxrot[%i]",repairshopid);
	INI_WriteFloat(mainfile,str,repairshopxrot[repairshopid]);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"repairshopyrot[%i]",repairshopid);
	INI_WriteFloat(mainfile,str,repairshopyrot[repairshopid]);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"repairshopzrot[%i]",repairshopid);
	INI_WriteFloat(mainfile,str,repairshopzrot[repairshopid]);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"repairshopobjectid[%i]",repairshopid);
	INI_WriteInt(mainfile,str,repairshopobjectid[repairshopid]);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"repairshopcost[%i]",repairshopid);
	INI_WriteInt(mainfile,str,repairshopcost[repairshopid]);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"repairshopelockcost[%i]",repairshopid);
	INI_WriteInt(mainfile,str,repairshopelockcost[repairshopid]);
	INI_RemoveEntry(mainfile,str);
	format(str,sizeof(str),"repairshopslockcost[%i]",repairshopid);
	INI_WriteInt(mainfile,str,repairshopslockcost[repairshopid]);
	INI_RemoveEntry(mainfile,str);
	INI_Close(mainfile);
}
SaveQuickDisposerData(disposerid)
{
    new INI:filedata = INI_Open(mainfilename);
    SaveDisposerData(INI:filedata,disposerid);
    INI_Close(filedata);
}
SaveDisposerData(INI:filedata,disposerid)
{
	new str[128];
	format(str,sizeof(str),"disposecarstate[%i]",disposerid);
	INI_WriteInt(filedata,str,disposecarstate[disposerid]);
	format(str,sizeof(str),"disposecarx[%i]",disposerid);
	INI_WriteFloat(filedata,str,disposecarx[disposerid],6);
	format(str,sizeof(str),"disposecary[%i]",disposerid);
	INI_WriteFloat(filedata,str,disposecary[disposerid],6);
	format(str,sizeof(str),"disposecarz[%i]",disposerid);
	INI_WriteFloat(filedata,str,disposecarz[disposerid],6);
}
DeleteDisposerData(disposerid)
{
    new INI:filedata = INI_Open(mainfilename);
	new str[128];
 	disposecarstate[disposerid] = 0;
	disposecarx[disposerid] = 0;
	disposecary[disposerid] = 0;
	disposecarz[disposerid] = 0;
	format(str,sizeof(str),"disposecarstate[%i]",disposerid);
	INI_WriteInt(filedata,str,disposecarstate[disposerid]);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"disposecarx[%i]",disposerid);
	INI_WriteFloat(filedata,str,disposecarx[disposerid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"disposecary[%i]",disposerid);
	INI_WriteFloat(filedata,str,disposecary[disposerid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"disposecarz[%i]",disposerid);
	INI_WriteFloat(filedata,str,disposecarz[disposerid],6);
	INI_RemoveEntry(filedata,str);
	INI_Close(filedata);
}
SaveQuickRefineryData(refineryid)
{
    new INI:datasave = INI_Open(mainfilename);
    SaveRefineryData(datasave,refineryid);
    INI_Close(datasave);
}
SaveRefineryData(INI:datasave,refineryid)
{
	new str[128];
	/*format(str,sizeof(str),"refinerydebt[%i]",refineryid);//#4
	INI_WriteFloat(datasave,str,refinerydebt[refineryid],6);*/
	format(str,sizeof(str),"refinerystate[%i]",refineryid);
    INI_WriteInt(datasave,str,refinerystate[refineryid]);
    format(str,sizeof(str),"refineryownedstate[%i]",refineryid);
    INI_WriteInt(datasave,str,refineryownedstate[refineryid]);
    format(str,sizeof(str),"refineryownername[%i]",refineryid);
    INI_WriteString(datasave,str,refineryownername[refineryid]);
    format(str,sizeof(str),"refineryx[%i]",refineryid);
    INI_WriteFloat(datasave,str,refineryx[refineryid],6);
    format(str,sizeof(str),"refineryy[%i]",refineryid);
    INI_WriteFloat(datasave,str,refineryy[refineryid],6);
    format(str,sizeof(str),"refineryz[%i]",refineryid);
    INI_WriteFloat(datasave,str,refineryz[refineryid],6);
    format(str,sizeof(str),"refineryproductionstate[%i]",refineryid);
	INI_WriteInt(datasave,str,refineryproductionstate[refineryid]);
	format(str,sizeof(str),"refinerycost[%i]",refineryid);
	INI_WriteInt(datasave,str,refinerycost[refineryid]);
	format(str,sizeof(str),"refinerycash[%i]",refineryid);
	INI_WriteInt(datasave,str,refinerycash[refineryid]);
	format(str,sizeof(str),"refinerysellstate[%i]",refineryid);
	INI_WriteInt(datasave,str,refinerysellstate[refineryid]);
	format(str,sizeof(str),"refinerytrailerstate[%i]",refineryid);
	INI_WriteInt(datasave,str,refinerytrailerstate[refineryid]);
	format(str,sizeof(str),"refinerytrailerx[%i]",refineryid);
	INI_WriteFloat(datasave,str,refinerytrailerx[refineryid],6);
	format(str,sizeof(str),"refinerytrailery[%i]",refineryid);
	INI_WriteFloat(datasave,str,refinerytrailery[refineryid],6);
	format(str,sizeof(str),"refinerytrailerz[%i]",refineryid);
	INI_WriteFloat(datasave,str,refinerytrailerz[refineryid],6);
	format(str,sizeof(str),"refinerytrailerrot[%i]",refineryid);
	INI_WriteFloat(datasave,str,refinerytrailerrot[refineryid],6);
}
SaveManufactureingcostData()
{
	new INI:datasave = INI_Open(restrictedcarsfilename);
	new str[128];
	for(new count;count < sizeof(vehiclemanufactureingcost);count++)
	{
	    format(str,sizeof(str),"vehiclemanufactureingcost[%i]",count);
	    INI_WriteInt(datasave,str,vehiclemanufactureingcost[count]);
	}
	INI_WriteInt(datasave,"vehiclemanufactureingcoststate",vehiclemanufactureingcoststate);
	INI_Close(datasave);
}
SaveQuickFactoryData(factoryid)
{
    new INI:datasave = INI_Open(mainfilename);
    SaveFactoryData(datasave,factoryid);
    INI_Close(datasave);
}
SaveFactoryData(INI:datasave,factoryid)
{
	new str[128];
	format(str,sizeof(str),"factorystate[%i]",factoryid);
	INI_WriteInt(datasave,str,factorystate[factoryid]);
	format(str,sizeof(str),"factoryx[%i]",factoryid);
	INI_WriteFloat(datasave,str,factoryx[factoryid],6);
	format(str,sizeof(str),"factoryy[%i]",factoryid);
	INI_WriteFloat(datasave,str,factoryy[factoryid],6);
	format(str,sizeof(str),"factoryz[%i]",factoryid);
	INI_WriteFloat(datasave,str,factoryz[factoryid],6);
	format(str,sizeof(str), "factoryownername[%i]",factoryid);
	INI_WriteString(datasave,str,factoryownername[factoryid]);
	format(str,sizeof(str), "factoryownedstate[%i]",factoryid);
	INI_WriteInt(datasave,str,factoryownedstate[factoryid]);
	format(str,sizeof(str),"factorycost[%i]",factoryid);
    INI_WriteInt(datasave,str,factorycost[factoryid]);
    format(str,sizeof(str),"factorycash[%i]",factoryid);
    INI_WriteInt(datasave,str,factorycash[factoryid]);
   	format(str,sizeof(str),"factoryproductionstate[%i]",factoryid);
	INI_WriteInt(datasave,str,factoryproductionstate[factoryid]);
	for(new count;count < FACTORYMAXORDERSATONCE;count++)
	{
		format(str,sizeof(str),"factorystockstate[%i][%i]",count,factoryid);
		INI_WriteInt(datasave,str,factorystockstate[count][factoryid]);
	    format(str,sizeof(str),"factorydealershipid[%i][%i]",count,factoryid);
	    INI_WriteInt(datasave,str,factorydealershipid[count][factoryid]);
	    format(str,sizeof(str),"factorydealerstock[%i][%i]",count,factoryid);
	    INI_WriteInt(datasave,str,factorydealerstock[count][factoryid]);
	    format(str,sizeof(str),"factorydealerstockmodelid[%i][%i]",count,factoryid);
	    INI_WriteInt(datasave,str,factorydealerstockmodelid[count][factoryid]);
	    format(str,sizeof(str),"factorystock[%i][%i]",count,factoryid);
	    INI_WriteInt(datasave,str,factorystock[count][factoryid]);
	    format(str,sizeof(str),"factoryordercost[%i][%i]",count,factoryid);
	    INI_WriteInt(datasave,str,factoryordercost[count][factoryid]);
		format(str,sizeof(str),"factorystockcurrent[%i][%i]",count,factoryid);
		INI_WriteInt(datasave,str,factorystockcurrent[count][factoryid]);
	}
}
DeleteFactoryData(factoryid)
{
	new INI:datasave = INI_Open(mainfilename);
	new str[128];
	factorystate[factoryid] = 0;
	factoryx[factoryid] = 0.0;
	factoryy[factoryid] = 0.0;
	factoryz[factoryid] = 0.0;
	factoryownedstate[factoryid] = 0;
	factorycost[factoryid] = 0;
	factorycash[factoryid] = 0;
    factoryproductionstate[factoryid] = 0;
    format(factoryownername[factoryid],sizeof(factoryownername),"");
	format(str,sizeof(str),"factorystate[%i]",factoryid);
	INI_WriteInt(datasave,str,factorystate[factoryid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"factoryx[%i]",factoryid);
	INI_WriteFloat(datasave,str,factoryx[factoryid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"factoryy[%i]",factoryid);
	INI_WriteFloat(datasave,str,factoryy[factoryid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"factoryz[%i]",factoryid);
	INI_WriteFloat(datasave,str,factoryz[factoryid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str), "factoryownedstate[%i]",factoryid);
	INI_WriteInt(datasave,str,factoryownedstate[factoryid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str), "factoryownername[%i]",factoryid);
	INI_WriteString(datasave,str,factoryownername[factoryid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"factorycost[%i]",factoryid);
    INI_WriteInt(datasave,str,factorycost[factoryid]);
    INI_RemoveEntry(datasave,str);
    format(str,sizeof(str),"factorycash[%i]",factoryid);
    INI_WriteInt(datasave,str,factorycash[factoryid]);
    INI_RemoveEntry(datasave,str);
   	format(str,sizeof(str),"factoryproductionstate[%i]",factoryid);
	INI_WriteInt(datasave,str,factoryproductionstate[factoryid]);
	INI_RemoveEntry(datasave,str);
	for(new count;count < FACTORYMAXORDERSATONCE;count++)
	{
	    factorydealershipid[count][factoryid] = 0;
	    factorydealerstock[count][factoryid] = 0;
	    factorydealerstockmodelid[count][factoryid] = 0;
	    factorystockstate[count][factoryid] = 0;
        factorystock[count][factoryid] = 0;
        factoryordercost[count][factoryid] = 0;
        factorystockcurrent[count][factoryid] = 0;
     	format(str,sizeof(str),"factorystockstate[%i][%i]",count,factoryid);
		INI_WriteInt(datasave,str,factorystockstate[count][factoryid]);
		INI_RemoveEntry(datasave,str);
	    format(str,sizeof(str),"factorydealershipid[%i][%i]",count,factoryid);
	    INI_WriteInt(datasave,str,factorydealershipid[count][factoryid]);
	    INI_RemoveEntry(datasave,str);
	    format(str,sizeof(str),"factorydealerstock[%i][%i]",count,factoryid);
	    INI_WriteInt(datasave,str,factorydealerstock[count][factoryid]);
	    INI_RemoveEntry(datasave,str);
	    format(str,sizeof(str),"factorydealerstockmodelid[%i][%i]",count,factoryid);
	    INI_WriteInt(datasave,str,factorydealerstockmodelid[count][factoryid]);
	    INI_RemoveEntry(datasave,str);
	    format(str,sizeof(str),"factorystock[%i][%i]",count,factoryid);
	    INI_WriteInt(datasave,str,factorystock[count][factoryid]);
	    INI_RemoveEntry(datasave,str);
	    format(str,sizeof(str),"factoryordercost[%i][%i]",count,factoryid);
	    INI_WriteInt(datasave,str,factoryordercost[count][factoryid]);
	    INI_RemoveEntry(datasave,str);
	    format(str,sizeof(str),"factorystockcurrent[%i][%i]",count,factoryid);
		INI_WriteInt(datasave,str,factorystockcurrent[count][factoryid]);
		INI_RemoveEntry(datasave,str);
	}
	INI_Close(datasave);
}
SaveQuickCarData(carid)
{
    new INI:datasave = INI_Open(carfilename);
    SaveCarData(datasave,carid);
    INI_Close(datasave);
}
/*RemoveRepairshopLogEntry(index)//#4
{
	new INI:datasave = INI_Open(grouplogfilename);
	new str[128];
	format(str,sizeof(str),"repairshopgrouplog[%i]",index);
	INI_WriteString(datasave,str,"");
	INI_RemoveEntry(datasave,str);
	INI_Close(datasave);
}
SaveRepairshopLog(input[])
{
	new INI:datasave = INI_Open(grouplogfilename);
	new str[128];
	format(str,sizeof(str),"repairshopgrouplog[%i]",repairshopgrouplogcount);
	INI_WriteString(datasave,str,input);
	repairshopgrouplogcount++;
	INI_WriteInt(datasave,"repairshopgrouplogcount",repairshopgrouplogcount);
	INI_Close(datasave);
}*/
SaveCarData(INI:datasave,carid)
{
	new str[128];
	format(str,sizeof(str),"carstate[%i]",carid);
	INI_WriteInt(datasave,str,carstate[carid]);
	format(str,sizeof(str),"carfuel[%i]",carid);
	INI_WriteFloat(datasave,str,carfuel[carid],6);
	format(str,sizeof(str),"carx[%i]",carid);
	INI_WriteFloat(datasave,str,carx[carid],6);
	format(str,sizeof(str),"cary[%i]",carid);
	INI_WriteFloat(datasave,str,cary[carid],6);
	format(str,sizeof(str),"carz[%i]",carid);
	INI_WriteFloat(datasave,str,carz[carid],6);
	format(str,sizeof(str),"carrot[%i]",carid);
	INI_WriteFloat(datasave,str,carrot[carid],6);
	format(str,sizeof(str),"carcolor1[%i]",carid);
	INI_WriteInt(datasave,str,carcolor1[carid]);
	format(str,sizeof(str),"carcolor2[%i]",carid);
	INI_WriteInt(datasave,str,carcolor2[carid]);
 	format(str,sizeof(str),"carcost[%i]",carid);
	INI_WriteInt(datasave,str,carcost[carid]);
	format(str,sizeof(str),"carmodelid[%i]",carid);
	INI_WriteInt(datasave,str,carmodelid[carid]);
	format(str,sizeof(str),"cardealershipid[%i]",carid);
	INI_WriteInt(datasave,str,cardealershipid[carid]);
	format(str,sizeof(str),"cartype[%i]",carid);
	INI_WriteInt(datasave,str,cartype[carid]);
	format(str,sizeof(str),"carownername[%i]",carid);
	INI_WriteString(datasave,str,carownername[carid]);
	format(str,sizeof(str),"carstock[%i]",carid);
	INI_WriteInt(datasave,str,carstock[carid]);
	format(str,sizeof(str),"carlocktype[%i]",carid);
	INI_WriteInt(datasave,str,carlocktype[carid]);
	format(str,sizeof(str),"carlock[%i]",carid);
	INI_WriteInt(datasave,str,carlock[carid]);
	format(str,sizeof(str),"cartotaldistence[%i]",carid);
	INI_WriteFloat(datasave,str,cartotaldistence[carid],6);
	for(new count;count < 14;count++)
	{
		format(str,sizeof(str),"carmodslot[%i][%i]",count,carid);
		INI_WriteInt(datasave,str,carmodslot[count][carid]);
	}
}
DeleteCarData(carid)
{
	new INI:datasave = INI_Open(carfilename);
	new str[128];
	carstate[carid] = 0;
	carfuel[carid] = 0.0;
	carx[carid] = 0.0;
	cary[carid] = 0.0;
	carz[carid] = 0.0;
	carrot[carid] = 0.0;
	carcolor1[carid] = 0;
	carcolor2[carid] = 0;
	carcost[carid] = 0;
	carmodelid[carid] = 0;
	cardealershipid[carid] = 0;
	cartype[carid] = 0;
	carownername[carid] = "";
	carstock[carid] = 0;
	carlocktype[carid] = 0;
	carlock[carid] = 0;
	cartotaldistence[carid] = 0.0;
	format(str,sizeof(str),"carstate[%i]",carid);
	INI_WriteInt(datasave,str,carstate[carid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"carfuel[%i]",carid);
	INI_WriteFloat(datasave,str,carfuel[carid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"carx[%i]",carid);
	INI_WriteFloat(datasave,str,carx[carid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"cary[%i]",carid);
	INI_WriteFloat(datasave,str,cary[carid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"carz[%i]",carid);
	INI_WriteFloat(datasave,str,carz[carid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"carrot[%i]",carid);
	INI_WriteFloat(datasave,str,carrot[carid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"carcolor1[%i]",carid);
	INI_WriteInt(datasave,str,carcolor1[carid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"carcolor2[%i]",carid);
	INI_WriteInt(datasave,str,carcolor2[carid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"carcost[%i]",carid);
	INI_WriteInt(datasave,str,carcost[carid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"carmodelid[%i]",carid);
	INI_WriteInt(datasave,str,carmodelid[carid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"cardealershipid[%i]",carid);
	INI_WriteInt(datasave,str,cardealershipid[carid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"cartype[%i]",carid);
	INI_WriteInt(datasave,str,cartype[carid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"carownername[%i]",carid);
	INI_WriteString(datasave,str,carownername[carid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"carstock[%i]",carid);
	INI_WriteInt(datasave,str,carstock[carid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"carlocktype[%i]",carid);
	INI_WriteInt(datasave,str,carlocktype[carid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"carlock[%i]",carid);
	INI_WriteInt(datasave,str,carlock[carid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"cartotaldistence[%i]",carid);
	INI_WriteFloat(datasave,str,cartotaldistence[carid],6);
	INI_RemoveEntry(datasave,str);
	for(new count;count < 14;count++)
	{
	    carmodslot[count][carid] = 0;
		format(str,sizeof(str),"carmodslot[%i][%i]",count,carid);
		INI_WriteInt(datasave,str,carmodslot[count][carid]);
		INI_RemoveEntry(datasave,str);
	}
	INI_Close(datasave);
}
SaveQuickDealershipData(dealershipid)
{
    new INI:datasave = INI_Open(mainfilename);
    SaveDealershipData(datasave,dealershipid);
    INI_Close(datasave);
}
SaveDealershipData(INI:datasave,dealershipid)
{
	new str[128];
	format(str,sizeof(str),"dealershipstate[%i]",dealershipid);
	INI_WriteInt(datasave,str,dealershipstate[dealershipid]);
	format(str,sizeof(str),"dealershipx[%i]",dealershipid);
	INI_WriteFloat(datasave,str,dealershipx[dealershipid],6);
	format(str,sizeof(str),"dealershipy[%i]",dealershipid);
	INI_WriteFloat(datasave,str,dealershipy[dealershipid],6);
	format(str,sizeof(str),"dealershipz[%i]",dealershipid);
    INI_WriteFloat(datasave,str,dealershipz[dealershipid],6);
	format(str,sizeof(str),"dealershipownedstate[%i]",dealershipid);
	INI_WriteInt(datasave,str,dealershipownedstate[dealershipid]);
	format(str,sizeof(str),"dealershipownername[%i]",dealershipid);
	INI_WriteString(datasave,str,dealershipownername[dealershipid]);
	format(str,sizeof(str),"dealershipcost[%i]",dealershipid);
	INI_WriteInt(datasave,str,dealershipcost[dealershipid]);
	format(str,sizeof(str),"dealershipcash[%i]",dealershipid);
	INI_WriteInt(datasave,str,dealershipcash[dealershipid]);
	format(str,sizeof(str),"dealershipname[%i]",dealershipid);
	INI_WriteString(datasave,str,dealershipname[dealershipid]);
	format(str,sizeof(str),"dealershipordercash[%i]",dealershipid);
	INI_WriteInt(datasave,str,dealershipordercash[dealershipid]);
	for(new count;count < 212;count++)
	{
		format(str,sizeof(str),"requeststockstate[%i][%i]",count,dealershipid);
		INI_WriteInt(datasave,str,requeststockstate[count][dealershipid]);
		if((requeststockstate[count][dealershipid])!=0)
		{
			format(str,sizeof(str),"requeststock[%i][%i]",count,dealershipid);
			INI_WriteInt(datasave,str,requeststock[count][dealershipid]);
		}
	}
}
DeleteDealerShipData(dealershipid)
{
	new INI:datasave = INI_Open(mainfilename);
	new str[128];
	dealershipstate[dealershipid] = 0;
	dealershipx[dealershipid] = 0;
	dealershipy[dealershipid] = 0;
	dealershipz[dealershipid] = 0;
	dealershipownedstate[dealershipid] = 0;
	dealershipownername[dealershipid] = "";
	dealershipcost[dealershipid] = 0;
	dealershipcash[dealershipid] = 0;
	dealershipname[dealershipid] = "";
	format(str,sizeof(str),"dealershipstate[%i]",dealershipid);
	INI_WriteInt(datasave,str,dealershipstate[dealershipid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"dealershipownedstate[%i]",dealershipid);
	INI_WriteInt(datasave,str,dealershipownedstate[dealershipid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"dealershipownername[%i]",dealershipid);
	INI_WriteString(datasave,str,dealershipownername[dealershipid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"dealershipcost[%i]",dealershipid);
	INI_WriteInt(datasave,str,dealershipcost[dealershipid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"dealershipcash[%i]",dealershipid);
	INI_WriteInt(datasave,str,dealershipcash[dealershipid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"dealershipx[%i]",dealershipid);
	INI_WriteFloat(datasave,str,dealershipx[dealershipid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"dealershipy[%i]",dealershipid);
	INI_WriteFloat(datasave,str,dealershipy[dealershipid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"dealershipz[%i]",dealershipid);
    INI_WriteFloat(datasave,str,dealershipz[dealershipid],6);
    INI_RemoveEntry(datasave,str);
    format(str,sizeof(str),"dealershipname[%i]",dealershipid);
    INI_WriteString(datasave,str,dealershipname[dealershipid]);
    INI_RemoveEntry(datasave,str);
   	for(new count;count < 212;count++)
	{
	    requeststockstate[count][dealershipid] = 0;
	    requeststock[count][dealershipid] = 0;
		format(str,sizeof(str),"requeststockstate[%i][%i]",count,dealershipid);
		INI_WriteInt(datasave,str,requeststockstate[count][dealershipid]);
		INI_RemoveEntry(datasave,str);
		format(str,sizeof(str),"requeststock[%i][%i]",count,dealershipid);
		INI_WriteInt(datasave,str,requeststock[count][dealershipid]);
        INI_RemoveEntry(datasave,str);
	}
    INI_Close(datasave);
}
DeleteRefineryData(refineryid)
{
	new INI:datasave = INI_Open(mainfilename);
	new str[128];
	refinerystate[refineryid] = 0;
	refineryownedstate[refineryid] = 0;
	format(refineryownername[refineryid],sizeof(refineryownername),"");
	refineryx[refineryid] = 0;
	refineryy[refineryid] = 0;
	refineryz[refineryid] = 0;
	refineryproductionstate[refineryid] = 0;
	refinerycost[refineryid] = 0;
	refinerycash[refineryid] =0;
	refinerysellstate[refineryid] = 0;
	refinerytrailerx[refineryid] = 0;
	refinerytrailery[refineryid] = 0;
	refinerytrailerz[refineryid] = 0;
	refinerytrailerrot[refineryid] = 0;
	/*refinerydebt[refineryid] = 0.0;//#4
	format(str,sizeof(str),"refinerydebt[%i]",refineryid);
	INI_WriteFloat(datasave,str,refinerydebt[refineryid],6);
	INI_RemoveEntry(datasave,str);*/
	format(str,sizeof(str),"refinerystate[%i]",refineryid);
	INI_WriteInt(datasave,str,0);
    INI_RemoveEntry(datasave,str);
    format(str,sizeof(str),"refineryownedstate[%i]",refineryid);
    INI_WriteInt(datasave,str,0);
    INI_RemoveEntry(datasave,str);
    format(str,sizeof(str),"refineryownername[%i]",refineryid);
    INI_WriteString(datasave,str,"");
    INI_RemoveEntry(datasave,str);
    format(str,sizeof(str),"refineryx[%i]",refineryid);
    INI_WriteFloat(datasave,str,0,6);
    INI_RemoveEntry(datasave,str);
    format(str,sizeof(str),"refineryy[%i]",refineryid);
    INI_WriteFloat(datasave,str,0,6);
    INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"refineryz[%i]",refineryid);
	INI_WriteFloat(datasave,str,0,6);
    INI_RemoveEntry(datasave,str);
    format(str,sizeof(str),"refineryproductionstate[%i]",refineryid);
    INI_WriteInt(datasave,str,0);
    INI_RemoveEntry(datasave,str);
    format(str,sizeof(str),"refinerycost[%i]",refineryid);
    INI_WriteInt(datasave,str,0);
    INI_RemoveEntry(datasave,str);
    format(str,sizeof(str),"refinerycash[%i]",refineryid);
    INI_WriteInt(datasave,str,0);
    INI_RemoveEntry(datasave,str);
   	format(str,sizeof(str),"refinerysellstate[%i]",refineryid);
	INI_WriteInt(datasave,str,refinerysellstate[refineryid]);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"refinerytrailerx[%i]",refineryid);
	INI_WriteFloat(datasave,str,refinerytrailerx[refineryid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"refinerytrailery[%i]",refineryid);
	INI_WriteFloat(datasave,str,refinerytrailery[refineryid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"refinerytrailerz[%i]",refineryid);
	INI_WriteFloat(datasave,str,refinerytrailerz[refineryid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"refinerytrailerrot[%i]",refineryid);
	INI_WriteFloat(datasave,str,refinerytrailerrot[refineryid],6);
	INI_RemoveEntry(datasave,str);
	format(str,sizeof(str),"refinerytrailerstate[%i]",refineryid);
	INI_WriteInt(datasave,str,refinerytrailerstate[refineryid]);
	INI_RemoveEntry(datasave,str);
    INI_Close(datasave);
}
/*SaveQuickDmvData(dmvid)//Remove
{
    new INI:filedata = INI_Open(mainfilename);
    SaveDmvData(filedata,dmvid);
    INI_Close(filedata);
}
SaveDmvData(INI:filedata,dmvid)
{
	new str[256];
	format(str,sizeof(str),"dmvstate[%i]",dmvid);
	INI_WriteInt(filedata,str,dmvstate[dmvid]);
	format(str,sizeof(str),"dmvx[%i]",dmvid);
	INI_WriteFloat(filedata,str,dmvx[dmvid],6);
	format(str,sizeof(str),"dmvy[%i]",dmvid);
	INI_WriteFloat(filedata,str,dmvy[dmvid],6);
	format(str,sizeof(str),"dmvz[%i]",dmvid);
	INI_WriteFloat(filedata,str,dmvz[dmvid],6);
}
DeleteDmvData(dmvid)
{
	new str[256];
	new INI:filedata = INI_Open(mainfilename);
	dmvstate[dmvid] = 0;
	dmvx[dmvid] = 0;
	dmvy[dmvid] = 0;
	dmvz[dmvid] = 0;
	format(str,sizeof(str),"dmvstate[%i]",dmvid);
	INI_WriteInt(filedata,str,dmvstate[dmvid]);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"dmvx[%i]",dmvid);
	INI_WriteFloat(filedata,str,dmvx[dmvid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"dmvy[%i]",dmvid);
	INI_WriteFloat(filedata,str,dmvy[dmvid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"dmvz[%i]",dmvid);
	INI_WriteFloat(filedata,str,dmvz[dmvid],6);
	INI_RemoveEntry(filedata,str);
	INI_Close(filedata);
}*/
SaveDealershipRequestSlotData()
{
	new str[256];
	new INI:filedata = INI_Open(mainfilename);
	for(new count;count < MAX_SLOTS;count++)
	{
		format(str,sizeof(str),"dealershiprequestslotstate[%i]",count);
		INI_WriteInt(filedata,str,dealershiprequestslotstate[count]);
		if((dealershiprequestslotstate[count])==1)
		{
			format(str,sizeof(str),"dealershiprequestslot[0][%i]",count);
            INI_WriteInt(filedata,str,dealershiprequestslot[0][count]);
            format(str,sizeof(str),"dealershiprequestslot[1][%i]",count);
            INI_WriteInt(filedata,str,dealershiprequestslot[1][count]);
		}
	}
	INI_Close(filedata);
}
SaveGasStationRequestSlotData()
{
	new str[256];
	new INI:filedata = INI_Open(mainfilename);
	for(new count;count < MAX_SLOTS;count++)
	{
		format(str,sizeof(str),"gasstationrequestslotstate[%i]",count);
		INI_WriteInt(filedata,str,gasstationrequestslotstate[count]);
		if((gasstationrequestslotstate[count])==1)
		{
			format(str,sizeof(str),"gasstationrequestslot[%i]",count);
			INI_WriteInt(filedata,str,gasstationrequestslot[count]);
		}
	}
	INI_Close(filedata);
}
SaveRestrictedCarData(modelid)
{
	new str[256];
	new INI:filedata = INI_Open(restrictedcarsfilename);
	format(str,sizeof(str),"%i",modelid);
	INI_WriteInt(filedata,str,restrictcar[modelid]);
	INI_Close(filedata);
}
DeleteOilPump(oilpumpid,refineryid)
{
    Delete3DTextLabel(oilpumplabel[oilpumpid][refineryid]);
	DestroyDynamicObject(oilpumpobject[oilpumpid][refineryid]);
	DeleteOilPumpData(oilpumpid,refineryid);
}
SaveQuickOilPumpData(oilpumpid,refineryid)
{
    new INI:filedata = INI_Open(mainfilename);
    SaveOilPumpData(filedata,oilpumpid,refineryid);
    INI_Close(filedata);
}
SaveOilPumpData(INI:filedata,oilpumpid,refineryid)
{
	new str[128];
	format(str,sizeof(str),"oilpumpstate[%i][%i]",oilpumpid,refineryid);
	INI_WriteInt(filedata,str,oilpumpstate[oilpumpid][refineryid]);
	format(str,sizeof(str),"oilpumpx[%i][%i]",oilpumpid,refineryid);
	INI_WriteFloat(filedata,str,oilpumpx[oilpumpid][refineryid],6);
	format(str,sizeof(str),"oilpumpy[%i][%i]",oilpumpid,refineryid );
	INI_WriteFloat(filedata,str,oilpumpy[oilpumpid][refineryid],6);
	format(str,sizeof(str),"oilpumpz[%i][%i]",oilpumpid,refineryid);
	INI_WriteFloat(filedata,str,oilpumpz[oilpumpid][refineryid],6);
	format(str,sizeof(str),"oilpumpxrot[%i][%i]",oilpumpid,refineryid);
	INI_WriteFloat(filedata,str,oilpumpxrot[oilpumpid][refineryid],6);
	format(str,sizeof(str),"oilpumpyrot[%i][%i]",oilpumpid,refineryid);
	INI_WriteFloat(filedata,str,oilpumpyrot[oilpumpid][refineryid],6);
	format(str,sizeof(str),"oilpumpzrot[%i][%i]",oilpumpid,refineryid);
	INI_WriteFloat(filedata,str,oilpumpzrot[oilpumpid][refineryid],6);
	format(str,sizeof(str),"oilpumpobjectid[%i][%i]",oilpumpid,refineryid);
	INI_WriteInt(filedata,str,oilpumpobjectid[oilpumpid][refineryid]);
}
DeleteOilPumpData(oilpumpid,refineryid)
{
	new INI:filedata = INI_Open(mainfilename);
	new str[128];
	oilpumpstate[oilpumpid][refineryid] = 0;
	oilpumpx[oilpumpid][refineryid] = 0;
	oilpumpy[oilpumpid][refineryid] = 0;
	oilpumpxrot[oilpumpid][refineryid] = 0;
	oilpumpyrot[oilpumpid][refineryid] = 0;
	oilpumpzrot[oilpumpid][refineryid] = 0;
	oilpumpobjectid[oilpumpid][refineryid] = 0;
	format(str,sizeof(str),"oilpumpstate[%i][%i]",oilpumpid,refineryid);
	INI_WriteInt(filedata,str,0);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"oilpumpx[%i][%i]",oilpumpid,refineryid);
	INI_WriteFloat(filedata,str,0,6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"oilpumpy[%i][%i]",oilpumpid,refineryid);
	INI_WriteFloat(filedata,str,0,6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"oilpumpz[%i][%i]",oilpumpid,refineryid);
	INI_WriteFloat(filedata,str,0,6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"oilpumpxrot[%i][%i]",oilpumpid,refineryid);
	INI_WriteFloat(filedata,str,0,6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"oilpumpyrot[%i][%i]",oilpumpid,refineryid);
	INI_WriteFloat(filedata,str,0,6);
    INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"oilpumpzrot[%i][%i]",oilpumpid,refineryid);
	INI_WriteFloat(filedata,str,0,6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"oilpumpobjectid[%i][%i]",oilpumpid,refineryid);
	INI_WriteFloat(filedata,str,0,6);
	INI_RemoveEntry(filedata,str);
	INI_Close(filedata);
}
DeleteGasStationData(gasstationid)
{
	new INI:filedata = INI_Open(mainfilename);
	new str[128];
	gasstationstate[gasstationid] = 0;
	gasstationownername[gasstationid] = "";
	gasstationx[gasstationid] = 0;
	gasstationy[gasstationid] = 0;
	gasstationz[gasstationid] = 0;
	gasstationcost[gasstationid] = 0;
	gasstationcash[gasstationid] = 0;
	gasstationgascost[gasstationid] = 0;
	gasstationownedstate[gasstationid] = 0;
	gasstationneedgasstate[gasstationid] = 0;
	gasstationname[gasstationid] = "";
	ammountofgasneeded[gasstationid] = 0.0;
	gasstationbuygascost[gasstationid] = 0;
	format(str,sizeof(str),"gasstationbuygascost[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationbuygascost[gasstationid]);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gasstationneedgasstate[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationneedgasstate[gasstationid]);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gasstationname[%i]",gasstationid);
	INI_WriteString(filedata,str,gasstationname[gasstationid]);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"ammountofgasneeded[%i]",gasstationid);
	INI_WriteFloat(filedata,str,ammountofgasneeded[gasstationid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gasstationstate[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationstate[gasstationid]);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gasstationownedstate[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationownedstate[gasstationid]);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gasstationownername[%i]",gasstationid);
	INI_WriteString(filedata,str,gasstationownername[gasstationid]);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gasstationx[%i]",gasstationid);
	INI_WriteFloat(filedata,str,gasstationx[gasstationid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gasstationy[%i]",gasstationid);
	INI_WriteFloat(filedata,str,gasstationy[gasstationid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gasstationz[%i]",gasstationid);
	INI_WriteFloat(filedata,str,gasstationz[gasstationid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gasstationcost[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationcost[gasstationid]);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gasstationcash[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationcash[gasstationid]);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gasstationgascost[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationgascost[gasstationid]);
	INI_RemoveEntry(filedata,str);
	INI_Close(filedata);
	Delete3DTextLabel(gasstationlabel[gasstationid]);
}
DeleteGasPumpData(gaspumpid,gasstationid)
{
	new INI:filedata = INI_Open(mainfilename);
	new str[128];
	gaspumpstate[gaspumpid][gasstationid] = 0;
	gaspumpx[gaspumpid][gasstationid] = 0;
	gaspumpy[gaspumpid][gasstationid] = 0;
	gaspumpz[gaspumpid][gasstationid] = 0;
	gaspumpxrot[gaspumpid][gasstationid] = 0;
    gaspumpyrot[gaspumpid][gasstationid] = 0;
    gaspumpzrot[gaspumpid][gasstationid] = 0;
    gaspumpobjectid[gaspumpid][gasstationid] = 0;
    gaspumpgas[gaspumpid][gasstationid] = 0;
   	format(str,sizeof(str),"gaspumpgas[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpgas[gaspumpid][gasstationid]);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gaspumpstate[%i][%i]",gaspumpid,gasstationid);
	INI_WriteInt(filedata,str,gaspumpstate[gaspumpid][gasstationid]);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gaspumpx[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpx[gaspumpid][gasstationid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gaspumpy[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpy[gaspumpid][gasstationid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gaspumpz[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpz[gaspumpid][gasstationid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gaspumpxrot[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpxrot[gaspumpid][gasstationid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gaspumpyrot[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpyrot[gaspumpid][gasstationid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gaspumpzrot[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpzrot[gaspumpid][gasstationid],6);
	INI_RemoveEntry(filedata,str);
	format(str,sizeof(str),"gaspumpobjectid[%i][%i]",gaspumpid,gasstationid);
	INI_WriteInt(filedata,str,gaspumpobjectid[gaspumpid][gasstationid]);
	INI_RemoveEntry(filedata,str);
	INI_Close(filedata);
	Delete3DTextLabel(gaspumplabel[gaspumpid][gasstationid]);
	DestroyDynamicObject(gaspumpobject[gaspumpid][gasstationid]);
}
SaveQuickGasPumpData(gaspumpid,gasstationid)
{
    new INI:filedata = INI_Open(mainfilename);
    SaveGasPumpData(filedata,gaspumpid,gasstationid);
    INI_Close(filedata);
}
SaveGasPumpData(INI:filedata,gaspumpid,gasstationid)
{
	new str[128];
	format(str,sizeof(str),"gaspumpstate[%i][%i]",gaspumpid,gasstationid);
	INI_WriteInt(filedata,str,gaspumpstate[gaspumpid][gasstationid]);
	format(str,sizeof(str),"gaspumpx[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpx[gaspumpid][gasstationid],6);
	format(str,sizeof(str),"gaspumpy[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpy[gaspumpid][gasstationid],6);
	format(str,sizeof(str),"gaspumpz[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpz[gaspumpid][gasstationid],6);
	format(str,sizeof(str),"gaspumpxrot[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpxrot[gaspumpid][gasstationid],6);
	format(str,sizeof(str),"gaspumpyrot[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpyrot[gaspumpid][gasstationid],6);
	format(str,sizeof(str),"gaspumpzrot[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpzrot[gaspumpid][gasstationid],6);
	format(str,sizeof(str),"gaspumpobjectid[%i][%i]",gaspumpid,gasstationid);
	INI_WriteInt(filedata,str,gaspumpobjectid[gaspumpid][gasstationid]);
	format(str,sizeof(str),"gaspumpgas[%i][%i]",gaspumpid,gasstationid);
	INI_WriteFloat(filedata,str,gaspumpgas[gaspumpid][gasstationid]);
}
SaveQuickGasStationData(gasstationid)
{
    new INI:filedata = INI_Open(mainfilename);
    SaveGasStationData(filedata,gasstationid);
   	INI_Close(filedata);
}
SaveGasStationData(INI:filedata,gasstationid)
{
	new str[128];
	format(str,sizeof(str),"gasstationstate[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationstate[gasstationid]);
	format(str,sizeof(str),"gasstationownedstate[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationownedstate[gasstationid]);
	format(str,sizeof(str),"gasstationownername[%i]",gasstationid);
	INI_WriteString(filedata,str,gasstationownername[gasstationid]);
	format(str,sizeof(str),"gasstationx[%i]",gasstationid);
	INI_WriteFloat(filedata,str,gasstationx[gasstationid],6);
	format(str,sizeof(str),"gasstationy[%i]",gasstationid);
	INI_WriteFloat(filedata,str,gasstationy[gasstationid],6);
	format(str,sizeof(str),"gasstationz[%i]",gasstationid);
	INI_WriteFloat(filedata,str,gasstationz[gasstationid],6);
	format(str,sizeof(str),"gasstationcost[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationcost[gasstationid]);
	format(str,sizeof(str),"gasstationcash[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationcash[gasstationid]);
	format(str,sizeof(str),"gasstationgascost[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationgascost[gasstationid]);
	format(str,sizeof(str),"gasstationneedgasstate[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationneedgasstate[gasstationid]);
	format(str,sizeof(str),"gasstationname[%i]",gasstationid);
	INI_WriteString(filedata,str,gasstationname[gasstationid]);
	format(str,sizeof(str),"ammountofgasneeded[%i]",gasstationid);
	INI_WriteFloat(filedata,str,ammountofgasneeded[gasstationid],6);
	format(str,sizeof(str),"gasstationbuygascost[%i]",gasstationid);
	INI_WriteInt(filedata,str,gasstationbuygascost[gasstationid]);
}
SaveQuickOilStorageData(oilstorageid, refineryid)
{
    new INI:filedata = INI_Open(mainfilename);
    SaveOilStorageData(filedata,oilstorageid, refineryid);
    INI_Close(filedata);
}
SaveOilStorageData(INI:filedata,oilstorageid, refineryid)
{
	new str[128];
	format(str,sizeof(str),"oilstorageobjectid[%i][%i]",oilstorageid,refineryid);
	INI_WriteInt(filedata,str,oilstorageobjectid[oilstorageid][refineryid]);
	format(str,sizeof(str),"oilstoragestate[%i][%i]",oilstorageid,refineryid);
	INI_WriteInt(filedata,str,oilstoragestate[oilstorageid][refineryid]);
	format(str,sizeof(str),"oilstoragex[%i][%i]",oilstorageid,refineryid);
	INI_WriteFloat(filedata,str,oilstoragex[oilstorageid][refineryid],6);
	format(str,sizeof(str),"oilstoragey[%i][%i]",oilstorageid,refineryid);
	INI_WriteFloat(filedata,str,oilstoragey[oilstorageid][refineryid],6);
	format(str,sizeof(str),"oilstoragez[%i][%i]",oilstorageid,refineryid);
	INI_WriteFloat(filedata,str,oilstoragez[oilstorageid][refineryid],6);
	format(str,sizeof(str),"oilstoragexrot[%i][%i]",oilstorageid,refineryid);
	INI_WriteFloat(filedata,str,oilstoragexrot[oilstorageid][refineryid],6);
	format(str,sizeof(str),"oilstorageyrot[%i][%i]",oilstorageid,refineryid);
	INI_WriteFloat(filedata,str,oilstorageyrot[oilstorageid][refineryid],6);
	format(str,sizeof(str),"oilstoragezrot[%i][%i]",oilstorageid,refineryid);
	INI_WriteFloat(filedata,str,oilstoragezrot[oilstorageid][refineryid],6);
	format(str,sizeof(str),"oilstoragefuel[%i][%i]",oilstorageid,refineryid);
	INI_WriteFloat(filedata,str,oilstoragefuel[oilstorageid][refineryid],6);
}
DeleteOilStorageData(oilstorageid,refineryid)
{
	new INI:filedata = INI_Open(mainfilename);
	new str[128];
	oilstorageobjectid[oilstorageid][refineryid] = 0;
	oilstoragestate[oilstorageid][refineryid] = 0;
	oilstoragex[oilstorageid][refineryid] = 0;
	oilstoragey[oilstorageid][refineryid] = 0;
	oilstoragez[oilstorageid][refineryid] = 0;
	oilstoragexrot[oilstorageid][refineryid] = 0;
	oilstorageyrot[oilstorageid][refineryid] = 0;
	oilstoragezrot[oilstorageid][refineryid] = 0;
	oilstoragefuel[oilstorageid][refineryid] = 0;
    format(str,sizeof(str),"oilstorageobjectid[%i][%i]",oilstorageid,refineryid);
    INI_WriteInt(filedata,str,0);
    INI_RemoveEntry(filedata,str);
    format(str,sizeof(str),"oilstoragestate[%i][%i]",oilstorageid,refineryid);
    INI_WriteInt(filedata,str,0);
    INI_RemoveEntry(filedata,str);
    format(str,sizeof(str),"oilstoragex[%i][%i]",oilstorageid,refineryid);
	INI_WriteFloat(filedata,str,0,6);
    INI_RemoveEntry(filedata,str);
    format(str,sizeof(str),"oilstoragey[%i][%i]",oilstorageid,refineryid);
    INI_WriteFloat(filedata,str,0,6);
    INI_RemoveEntry(filedata,str);
    format(str,sizeof(str),"oilstoragez[%i][%i]",oilstorageid,refineryid);
    INI_WriteFloat(filedata,str,0,6);
    INI_RemoveEntry(filedata,str);
    format(str,sizeof(str),"oilstoragexrot[%i][%i]",oilstorageid,refineryid);
    INI_WriteFloat(filedata,str,0,6);
    INI_RemoveEntry(filedata,str);
    format(str,sizeof(str),"oilstorageyrot[%i][%i]",oilstorageid,refineryid);
    INI_WriteFloat(filedata,str,0,6);
    INI_RemoveEntry(filedata,str);
    format(str,sizeof(str),"oilstoragezrot[%i][%i]",oilstorageid,refineryid);
    INI_WriteFloat(filedata,str,0,6);
    INI_RemoveEntry(filedata,str);
    format(str,sizeof(str),"oilstoragefuel[%i][%i]",oilstorageid,refineryid);
    INI_WriteFloat(filedata,str,0,6);
    INI_RemoveEntry(filedata,str);
	INI_Close(filedata);
}
/*SaveQuickRepairshopGroupData()
{
	new INI:filedata = INI_Open(mainfilename);
	SaveRepairshopGroupData(filedata);
	INI_Close(filedata);
}
SaveRepairshopGroupData(INI:filedata)
{
	INI_WriteInt(filedata,"repairshopgroupcash",repairshopgroupcash);
	INI_WriteInt(filedata,"repairshoppaycheck",repairshoppaycheck);
}*/
public LoadCarData(name[],value[])
{
	new str[128],arraystate,arraystring[MAX_PLAYER_NAME],arraystr[MAX_PLAYER_NAME],carid,arraycount,namestring[128],slotid;
	format(namestring,sizeof(namestring),"%s",name);
	for(new s;s < sizeof(namestring);s++)
	{
	    if((arraystate)==0)
	    {
		    if(namestring[s] == '[')
		    {
		        if((arraycount) <= 2)
		        {
		        	arraystate = 1;
				}
				else
				{
				    printf("Error reading:%s",namestring);
				}
		    }
		}
		else if((arraystate)==1)
		{
		    if(namestring[s] == ']')
		    {
				if(IsNumeric(arraystring))
				{
				    if((arraycount)==0)
				    {
					    carid = strval(arraystring);
					    format(arraystring,sizeof(arraystring),"");
					    arraycount++;
					}
					else if((arraycount)==1)
					{
					    slotid = carid;
					    carid = 0;
						carid = strval(arraystring);
						format(arraystring,sizeof(arraystring),"");
						arraycount++;
					}
				}
				else
				{
				    printf("Error with reading %s",name);
				    return 1;
				}
				arraystate = 0;
		    }
		    else
			{
			    if(isnull(arraystring))
			    {
			        format(arraystring,sizeof(arraystring),"%c",namestring[s]);
			    }
			    else
			    {
					format(arraystr,sizeof(arraystr),"%s%c",arraystring,namestring[s]);
					format(arraystring,sizeof(arraystring),"%s",arraystr);
			    }
			}
		}
	}
	if((arraycount)==1)
	{
		printf("arraycount = %i slotid = %i carid = %i name = %s",arraycount,slotid,carid,name);//remove
		format(str,sizeof(str),"carstate[%i]",carid);
		INI_Int(str,carstate[carid]);
		format(str,sizeof(str),"carfuel[%i]",carid);
		INI_Float(str,carfuel[carid]);
		format(str,sizeof(str),"carx[%i]",carid);
		INI_Float(str,carx[carid]);
		format(str,sizeof(str),"cary[%i]",carid);
	    INI_Float(str,cary[carid]);
		format(str,sizeof(str),"carz[%i]",carid);
		INI_Float(str,carz[carid]);
		format(str,sizeof(str),"carrot[%i]",carid);
		INI_Float(str,carrot[carid]);
		format(str,sizeof(str),"carcolor1[%i]",carid);
		INI_Int(str,carcolor1[carid]);
		format(str,sizeof(str),"carcolor2[%i]",carid);
		INI_Int(str,carcolor2[carid]);
		format(str,sizeof(str),"carcost[%i]",carid);
		INI_Int(str,carcost[carid]);
	    format(str,sizeof(str),"carmodelid[%i]",carid);
	    INI_Int(str,carmodelid[carid]);
	    format(str,sizeof(str),"cardealershipid[%i]",carid);
	    INI_Int(str,cardealershipid[carid]);
	   	format(str,sizeof(str),"cartype[%i]",carid);
	   	INI_Int(str,cartype[carid]);
		format(str,sizeof(str),"carownername[%i]",carid);
		INI_String(str,carownername[carid],sizeof(carownername));
		format(str,sizeof(str),"carstock[%i]",carid);
		INI_Int(str,carstock[carid]);
		format(str,sizeof(str),"carlocktype[%i]",carid);
		INI_Int(str,carlocktype[carid]);
		format(str,sizeof(str),"carlock[%i]",carid);
		INI_Int(str,carlock[carid]);
		format(str,sizeof(str),"cartotaldistence[%i]",carid);
		INI_Float(str,cartotaldistence[carid]);
	}
	else if((arraycount)==2)
	{
		format(str,sizeof(str),"carmodslot[%i][%i]",slotid,carid);
		INI_Int(str,carmodslot[slotid][carid]);
	}
	return 1;
}
LoadMainCarData()
{
	new string[256];
	INI_ParseFile(carfilename,"LoadCarData",false,false);
	for(new carid = 1;carid < MAX_VEHICLES;carid++)
	{
	    if((carstate[carid])==1)
	    {
	        if((cartype[carid])==1)
	        {
	            new engine,lights,alarm,doors,bonnet,boot,objective;
 				car[carid] = CreateVehicle(carmodelid[carid],carx[carid],cary[carid],carz[carid],carrot[carid],carcolor1[carid],carcolor2[carid],-1);
 				GetVehicleParamsEx(car[carid],engine,lights,alarm,doors,bonnet,boot,objective);
				if((carlocktype[carid])==1)
	            {
					if((carlock[carid])==1)
					{
						doors = 1;
					}
	            }
				jbcarid[car[carid]] = carid;
				fuel[car[carid]] = carfuel[carid];
				totaldistence[car[carid]] = cartotaldistence[carid];
    			for(new count;count < 14;count++)
	            {
		            if((carmodslot[count][carid])!= 0)
					{
					    AddVehicleComponent(car[carid],carmodslot[count][carid]);
					}
     			}
     			SetVehicleParamsEx(car[carid],engine,lights,alarm,doors,bonnet,boot,objective);
				printf("fuel[%i] = %f carfuel[%i] = %f",car[carid],fuel[car[carid]],carid,carfuel[carid]);
				printf("car:%i -- carstate = %i carx = %f cary = %f carz = %f carrot = %f cartype = %i carfuel = %f\n carcolor1 = %i carcolor2 = %i carcost = %i carmodelid = %i cardealershipid = %i carownername = %s",carid,carstate[carid],carx[carid],cary[carid],carz[carid],carrot[carid],cartype[carid],carfuel[carid],carcolor1[carid],carcolor2[carid],carcost[carid],carmodelid[carid],cardealershipid[carid],carownername[carid]);
	        }
	        /* if((cartype[carid])==4)//#4
	        {
	            car[carid] = CreateVehicle(carmodelid[carid],carx[carid],cary[carid],carz[carid],carrot[carid],carcolor1[carid],carcolor2[carid],-1);
	            jbcarid[car[carid]] = carid;
				fuel[car[carid]] = carfuel[carid];
				for(new count;count < 14;count++)
	            {
		            if((carmodslot[count][carid])!= 0)
					{
					    AddVehicleComponent(car[carid],carmodslot[count][carid]);
					}
     			}
     			printf("fuel[%i] = %f carfuel[%i] = %f",car[carid],fuel[car[carid]],carid,carfuel[carid]);
				printf("car:%i -- carstate = %i carx = %f cary = %f carz = %f carrot = %f cartype = %i carfuel = %f\n carcolor1 = %i carcolor2 = %i carcost = %i carmodelid = %i cardealershipid = %i carownername = %s",carid,carstate[carid],carx[carid],cary[carid],carz[carid],carrot[carid],cartype[carid],carfuel[carid],carcolor1[carid],carcolor2[carid],carcost[carid],carmodelid[carid],cardealershipid[carid],carownername[carid]);
	        }*/
			else if((cartype[carid])==2||(cartype[carid])==3)
			{
				car[carid] = CreateVehicle(carmodelid[carid],carx[carid],cary[carid],carz[carid],carrot[carid],carcolor1[carid],carcolor2[carid],-1);
    			if((carlock[carid])==1)
			    {
			        new engine,lights,alarm,doors,bonnet,boot,objective;
                    GetVehicleParamsEx(car[carid],engine,lights,alarm,doors,bonnet,boot,objective);
                    doors = 1;
                    SetVehicleParamsEx(car[carid],engine,lights,alarm,doors,bonnet,boot,objective);
			    }
				jbcarid[car[carid]] = carid;
				fuel[car[carid]] = carfuel[carid];
				printf("fuel[%i] = %f carfuel[%i] = %f",car[carid],fuel[car[carid]],carid,carfuel[carid]);
				format(string,sizeof(string),"%i:Dealership vehicle\nThis vehicle cost $%i\n%s",cardealershipid[carid],carcost[carid],CarStock(carid));
				carlabel[carid] = Create3DTextLabel(string,YELLOW,carx[carid],cary[carid],carz[carid],DISTANCELABEL,0,0);
				Attach3DTextLabelToVehicle(carlabel[carid],car[carid],0,0,0);
				printf("car:%i -- carstate = %i carx = %f cary = %f carz = %f carrot = %f cartype = %i carfuel = %f\n carcolor1 = %i carcolor2 = %i carcost = %i carmodelid = %i cardealershipid = %i carownername = %s",carid,carstate[carid],carx[carid],cary[carid],carz[carid],carrot[carid],cartype[carid],carfuel[carid],carcolor1[carid],carcolor2[carid],carcost[carid],carmodelid[carid],cardealershipid[carid],carownername[carid]);
			}
		}
	}
}
public LoadMainDataFromFile(name[],value[])
{
	//create a way to check for arrays instead of looping throught
    new str[128],count2,count,arraystring[MAX_PLAYER_NAME],arraystr[MAX_PLAYER_NAME],arraycount,arraystate,namestring[128];
    format(namestring,sizeof(namestring),"%s",name);
    for(new s;s < sizeof(namestring);s++)
    {
        if((arraystate)==1)
        {
            if(namestring[s] == ']')
            {
                arraystate = 0;
                if(IsNumeric(arraystring))
                {
                    if((arraycount)==0)
                    {
                        count = 0;
						count = strval(arraystring);
						format(arraystring,sizeof(arraystring),"");
						arraycount++;
					}
					else if((arraycount)==1)
					{
					    count2 = 0;
					    count2 = count;
					    count = 0;
					    count = strval(arraystring);
					    format(arraystring,sizeof(arraystring),"");
					    arraycount++;
					}
                }
                else
                {
                    arraycount = 1;
                }
                continue;
            }
            else
			{
	            if(isnull(arraystring))
	            {
	                format(arraystring,sizeof(arraystring),"%c",namestring[s]);
	            }
	            else
	            {
	                format(arraystr,sizeof(arraystr),"%s%c",arraystring,namestring[s]);
	                format(arraystring,sizeof(arraystring),"%s",arraystr);
	            }
			}
        }
        else if((arraystate)==0)
        {
	        if(namestring[s] == '[')
	        {
	            if((arraycount) <= 2)
	            {
	            	arraystate = 1;
				}
				else
				{
				    printf("Error reading:%s",name);
				}
	        }
		}
    }
    printf("arraycount = %i count2 = %i count = %i name = %s",arraycount,count2,count,name);//remove
    if((arraycount)==0)
    {
	    INI_Int("costofoilpumps",costofoilpumps);
		INI_Int("costofoilstorage",costofoilstorage);
		INI_Float("oilpumpedpersec",oilpumpedpersec);
		INI_Int("costofgaspump",costofgaspump);
		//INI_Float("powercost",powercost);//#4
		INI_Int("vehiclebuildamountincrease",vehiclebuildamountincrease);
		/*INI_Int("repairshopgroupcash",repairshopgroupcash);//#4
		INI_Int("repairshoppaycheck",repairshoppaycheck);*/
	}
	else if((arraycount)==1)
	{
		if(IsNumeric(arraystring))
  		{
	  		//-----------------------Blocks----------------------
	  		format(str,sizeof(str),"spikestate[%i]",count);
			INI_Int(str,spikestate[count]);
            format(str,sizeof(str),"roadblockstate[%i]",count);
            INI_Int(str,roadblockstate[count]);
            format(str,sizeof(str),"barrelstate[%i]",count);
            INI_Int(str,barrelstate[count]);
            format(str,sizeof(str),"spikex[%i]",count);
            INI_Float(str,spikex[count]);
            format(str,sizeof(str),"spikey[%i]",count);
            INI_Float(str,spikey[count]);
            format(str,sizeof(str),"spikez[%i]",count);
            INI_Float(str,spikez[count]);
            format(str,sizeof(str),"spikexrot[%i]",count);
            INI_Float(str,spikexrot[count]);
            format(str,sizeof(str),"spikeyrot[%i]",count);
            INI_Float(str,spikeyrot[count]);
            format(str,sizeof(str),"spikezrot[%i]",count);
            INI_Float(str,spikezrot[count]);
            format(str,sizeof(str),"roadblockx[%i]",count);
            INI_Float(str,roadblockx[count]);
            format(str,sizeof(str),"roadblocky[%i]",count);
            INI_Float(str,roadblocky[count]);
            format(str,sizeof(str),"roadblockz[%i]",count);
            INI_Float(str,roadblockz[count]);
            format(str,sizeof(str),"roadblockxrot[%i]",count);
            INI_Float(str,roadblockxrot[count]);
            format(str,sizeof(str),"roadblockyrot[%i]",count);
            INI_Float(str,roadblockyrot[count]);
            format(str,sizeof(str),"roadblockzrot[%i]",count);
            INI_Float(str,roadblockzrot[count]);
            format(str,sizeof(str),"barrelx[%i]",count);
            INI_Float(str,barrelx[count]);
            format(str,sizeof(str),"barrely[%i]",count);
            INI_Float(str,barrely[count]);
            format(str,sizeof(str),"barrelz[%i]",count);
            INI_Float(str,barrelz[count]);
            format(str,sizeof(str),"barrelxrot[%i]",count);
            INI_Float(str,barrelxrot[count]);
            format(str,sizeof(str),"barrelyrot[%i]",count);
            INI_Float(str,barrelyrot[count]);
            format(str,sizeof(str),"barrelzrot[%i]",count);
            INI_Float(str,barrelzrot[count]);
  		    //--------------Repairshop------------------------------
  		    format(str,sizeof(str),"repairshopstate[%i]",count);
			INI_Int(str,repairshopstate[count]);
			format(str,sizeof(str),"repairshopx[%i]",count);
			INI_Float(str,repairshopx[count]);
			format(str,sizeof(str),"repairshopy[%i]",count);
			INI_Float(str,repairshopy[count]);
			format(str,sizeof(str),"repairshopz[%i]",count);
			INI_Float(str,repairshopz[count]);
			format(str,sizeof(str),"repairshopxrot[%i]",count);
			INI_Float(str,repairshopxrot[count]);
			format(str,sizeof(str),"repairshopyrot[%i]",count);
			INI_Float(str,repairshopyrot[count]);
			format(str,sizeof(str),"repairshopzrot[%i]",count);
			INI_Float(str,repairshopzrot[count]);
			format(str,sizeof(str),"repairshopobjectid[%i]",count);
			INI_Int(str,repairshopobjectid[count]);
			format(str,sizeof(str),"repairshopcost[%i]",count);
			INI_Int(str,repairshopcost[count]);
			format(str,sizeof(str),"repairshopelockcost[%i]",count);
			INI_Int(str,repairshopelockcost[count]);
			format(str,sizeof(str),"repairshopslockcost[%i]",count);
			INI_Int(str,repairshopslockcost[count]);
  		    /*/--------------DMV data--------------------------------//#4
   			format(str,sizeof(str),"dmvstate[%i]",count);
			INI_Int(str,dmvstate[count]);
			format(str,sizeof(str),"dmvx[%i]",count);
			INI_Float(str,dmvx[count]);
			format(str,sizeof(str),"dmvy[%i]",count);
			INI_Float(str,dmvy[count]);
			format(str,sizeof(str),"dmvz[%i]",count);
			INI_Float(str,dmvz[count]);*/
  		    //-------------disposer data----------------------------
  		    format(str,sizeof(str),"disposecarstate[%i]",count);
			INI_Int(str,disposecarstate[count]);
			format(str,sizeof(str),"disposecarx[%i]",count);
			INI_Float(str,disposecarx[count]);
			format(str,sizeof(str),"disposecary[%i]",count);
			INI_Float(str,disposecary[count]);
			format(str,sizeof(str),"disposecarz[%i]",count);
			INI_Float(str,disposecarz[count]);
            //-------------gasstation & dealership request----------
  		    format(str,sizeof(str),"gasstationrequestslotstate[%i]",count);
			INI_Int(str,gasstationrequestslotstate[count]);
			format(str,sizeof(str),"gasstationrequestslot[%i]",count);
			INI_Int(str,gasstationrequestslot[count]);
            //---------------------dealership-----------------------
			format(str,sizeof(str),"dealershiprequestslotstate[%i]",count);
			INI_Int(str,dealershiprequestslotstate[count]);
			format(str,sizeof(str),"dealershipstate[%i]",count);
			INI_Int(str,dealershipstate[count]);
			format(str,sizeof(str),"dealershipx[%i]",count);
			INI_Float(str,dealershipx[count]);
			format(str,sizeof(str),"dealershipy[%i]",count);
			INI_Float(str,dealershipy[count]);
			format(str,sizeof(str),"dealershipz[%i]",count);
			INI_Float(str,dealershipz[count]);
			format(str,sizeof(str),"dealershipownedstate[%i]",count);
			INI_Int(str,dealershipownedstate[count]);
			format(str,sizeof(str),"dealershipownername[%i]",count);
			INI_String(str,dealershipownername[count],sizeof(dealershipownername));
			format(str,sizeof(str),"dealershipcost[%i]",count);
			INI_Int(str,dealershipcost[count]);
			format(str,sizeof(str),"dealershipcash[%i]",count);
			INI_Int(str,dealershipcash[count]);
			format(str,sizeof(str),"dealershipname[%i]",count);
			INI_String(str,dealershipname[count],sizeof(dealershipname));
			format(str,sizeof(str),"dealershipordercash[%i]",count);
			INI_Int(str,dealershipordercash[count]);
			//---------------------factory-----------------------
			format(str,sizeof(str),"factorystate[%i]",count);
		    INI_Int(str,factorystate[count]);
			format(str,sizeof(str),"factoryx[%i]",count);
			INI_Float(str,factoryx[count]);
			format(str,sizeof(str),"factoryy[%i]",count);
			INI_Float(str,factoryy[count]);
			format(str,sizeof(str),"factoryz[%i]",count);
			INI_Float(str,factoryz[count]);
		    format(str,sizeof(str),"factoryownedstate[%i]",count);
		    INI_Int(str,factoryownedstate[count]);
		    format(str,sizeof(str),"factoryownername[%i]",count);
		    INI_String(str,factoryownername[count],sizeof(factoryownername));
		    format(str,sizeof(str),"factorycost[%i]",count);
		    INI_Int(str,factorycost[count]);
		    format(str,sizeof(str),"factorycash[%i]",count);
		    INI_Int(str,factorycash[count]);
			format(str,sizeof(str),"factoryproductionstate[%i]",count);
			INI_Int(str,factoryproductionstate[count]);
			//-----------------------------gasstation--------------------
			format(str,sizeof(str),"gasstationstate[%i]",count);
			INI_Int(str,gasstationstate[count]);
			format(str,sizeof(str),"gasstationownedstate[%i]",count);
			INI_Int(str,gasstationownedstate[count]);
			format(str,sizeof(str),"gasstationownername[%i]",count);
			INI_String(str,gasstationownername[count],sizeof(gasstationownername));
			format(str,sizeof(str),"gasstationx[%i]",count);
			INI_Float(str,gasstationx[count]);
			format(str,sizeof(str),"gasstationy[%i]",count);
			INI_Float(str,gasstationy[count]);
			format(str,sizeof(str),"gasstationz[%i]",count);
			INI_Float(str,gasstationz[count]);
			format(str,sizeof(str),"gasstationcost[%i]",count);
			INI_Int(str,gasstationcost[count]);
			format(str,sizeof(str),"gasstationcash[%i]",count);
			INI_Int(str,gasstationcash[count]);
			format(str,sizeof(str),"gasstationgascost[%i]",count);
			INI_Int(str,gasstationgascost[count]);
			format(str,sizeof(str),"gasstationneedgasstate[%i]",count);
			INI_Int(str,gasstationneedgasstate[count]);
			format(str,sizeof(str),"ammountofgasneeded[%i]",count);
			INI_Float(str,ammountofgasneeded[count]);
			format(str,sizeof(str),"gasstationname[%i]",count);
			INI_String(str,gasstationname[count],sizeof(gasstationname));
			format(str,sizeof(str),"gasstationbuygascost[%i]",count);
			INI_Int(str,gasstationbuygascost[count]);
			//---------------------------refinery------------------------
			format(str,sizeof(str),"refinerystate[%i]",count);
			INI_Int(str,refinerystate[count]);
			format(str,sizeof(str),"refineryownedstate[%i]",count);
			INI_Int(str,refineryownedstate[count]);
			format(str,sizeof(str),"refineryownername[%i]",count);
			INI_String(str,refineryownername[count],sizeof(refineryownername));
			format(str,sizeof(str),"refineryx[%i]",count);
			INI_Float(str,refineryx[count]);
			format(str,sizeof(str),"refineryy[%i]",count);
			INI_Float(str,refineryy[count]);
			format(str,sizeof(str),"refineryz[%i]",count);
			INI_Float(str,refineryz[count]);
			format(str,sizeof(str),"refineryproductionstate[%i]",count);
			INI_Int(str,refineryproductionstate[count]);
			format(str,sizeof(str),"refinerycost[%i]",count);
			INI_Int(str,refinerycost[count]);
			format(str,sizeof(str),"refinerycash[%i]",count);
			INI_Int(str,refinerycash[count]);
			format(str,sizeof(str),"refinerysellstate[%i]",count);
			INI_Int(str,refinerysellstate[count]);
			format(str,sizeof(str),"refinerytrailerstate[%i]",count);
			INI_Int(str,refinerytrailerstate[count]);
			format(str,sizeof(str),"refinerytrailerx[%i]",count);
			INI_Float(str,refinerytrailerx[count]);
			format(str,sizeof(str),"refinerytrailery[%i]",count);
			INI_Float(str,refinerytrailery[count]);
			format(str,sizeof(str),"refinerytrailerz[%i]",count);
			INI_Float(str,refinerytrailerz[count]);
			format(str,sizeof(str),"refinerytrailerrot[%i]",count);
			INI_Float(str,refinerytrailerrot[count]);
  		}
	}
	else if((arraycount)==2)
	{
	    //-------------dealership request----------
		format(str,sizeof(str),"dealershiprequestslot[%i][%i]",count2,count);
		INI_Int(str,dealershiprequestslot[count2][count]);
	    //--------------dealership------------------
   		format(str,sizeof(str),"requeststockstate[%i][%i]",count2,count);
	    INI_Int(str,requeststockstate[count2][count]);
    	format(str,sizeof(str),"requeststock[%i][%i]",count2,count);
    	INI_Int(str,requeststock[count2][count]);
    	//----------------------factory-------------------------------
	    format(str,sizeof(str),"factorystockstate[%i][%i]",count2,count);
	    INI_Int(str,factorystockstate[count2][count]);
		format(str,sizeof(str),"factorydealershipid[%i][%i]",count2,count);
	    INI_Int(str,factorydealershipid[count2][count]);
	    format(str,sizeof(str),"factorydealerstock[%i][%i]",count2,count);
	    INI_Int(str,factorydealerstock[count2][count]);
	    format(str,sizeof(str),"factorydealerstockmodelid[%i][%i]",count2,count);
	    INI_Int(str,factorydealerstockmodelid[count2][count]);
	    format(str,sizeof(str),"factorystock[%i][%i]",count2,count);
	    INI_Int(str,factorystock[count2][count]);
	    format(str,sizeof(str),"factoryordercost[%i][%i]",count2,count);
	    INI_Int(str,factoryordercost[count2][count]);
	    format(str,sizeof(str),"factorystockcurrent[%i][%i]",count2,count);
	    INI_Int(str,factorystockcurrent[count2][count]);
	    //----------------------------gasstation--------------------------
	    format(str,sizeof(str),"gaspumpstate[%i][%i]",count2,count);
		INI_Int(str,gaspumpstate[count2][count]);
		format(str,sizeof(str),"gaspumpx[%i][%i]",count2,count);
		INI_Float(str,gaspumpx[count2][count]);
		format(str,sizeof(str),"gaspumpy[%i][%i]",count2,count);
		INI_Float(str,gaspumpy[count2][count]);
		format(str,sizeof(str),"gaspumpz[%i][%i]",count2,count);
		INI_Float(str,gaspumpz[count2][count]);
		format(str,sizeof(str),"gaspumpxrot[%i][%i]",count2,count);
		INI_Float(str,gaspumpxrot[count2][count]);
		format(str,sizeof(str),"gaspumpyrot[%i][%i]",count2,count);
		INI_Float(str,gaspumpyrot[count2][count]);
		format(str,sizeof(str),"gaspumpzrot[%i][%i]",count2,count);
		INI_Float(str,gaspumpzrot[count2][count]);
		format(str,sizeof(str),"gaspumpobjectid[%i][%i]",count2,count);
		INI_Int(str,gaspumpobjectid[count2][count]);
		format(str,sizeof(str),"gaspumpgas[%i][%i]",count2,count);
		INI_Float(str,gaspumpgas[count2][count]);
		//----------------------------refineryid--------------------------
  		format(str,sizeof(str),"oilstoragestate[%i][%i]",count2,count);
	    INI_Int(str,oilstoragestate[count2][count]);
		format(str,sizeof(str),"oilstorageobjectid[%i][%i]",count2,count);
		INI_Int(str,oilstorageobjectid[count2][count]);
		format(str,sizeof(str),"oilstoragex[%i][%i]",count2,count);
		INI_Float(str,oilstoragex[count2][count]);
		format(str,sizeof(str),"oilstoragey[%i][%i]",count2,count);
		INI_Float(str,oilstoragey[count2][count]);
		format(str,sizeof(str),"oilstoragez[%i][%i]",count2,count);
		INI_Float(str,oilstoragez[count2][count]);
		format(str,sizeof(str),"oilstoragexrot[%i][%i]",count2,count);
		INI_Float(str,oilstoragexrot[count2][count]);
		format(str,sizeof(str),"oilstorageyrot[%i][%i]",count2,count);
		INI_Float(str,oilstorageyrot[count2][count]);
		format(str,sizeof(str),"oilstoragezrot[%i][%i]",count2,count);
		INI_Float(str,oilstoragezrot[count2][count]);
		format(str,sizeof(str),"oilstoragefuel[%i][%i]",count2,count);
		INI_Float(str,oilstoragefuel[count2][count]);
		format(str,sizeof(str),"oilpumpstate[%i][%i]",count2,count);
		INI_Int(str,oilpumpstate[count2][count]);
		format(str,sizeof(str),"oilpumpx[%i][%i]",count2,count);
		INI_Float(str,oilpumpx[count2][count]);
		format(str,sizeof(str),"oilpumpy[%i][%i]",count2,count);
		INI_Float(str,oilpumpy[count2][count]);
		format(str,sizeof(str),"oilpumpz[%i][%i]",count2,count);
		INI_Float(str,oilpumpz[count2][count]);
		format(str,sizeof(str),"oilpumpxrot[%i][%i]",count2,count);
		INI_Float(str,oilpumpxrot[count2][count]);
		format(str,sizeof(str),"oilpumpyrot[%i][%i]",count2,count);
		INI_Float(str,oilpumpyrot[count2][count]);
		format(str,sizeof(str),"oilpumpzrot[%i][%i]",count2,count);
		INI_Float(str,oilpumpzrot[count2][count]);
		format(str,sizeof(str),"oilpumpobjectid[%i][%i]",count2,count);
		INI_Int(str,oilpumpobjectid[count2][count]);
	}
	return 1;
}
LoadMainfileData()
{
    INI_ParseFile(mainfilename,"LoadMainDataFromFile",false,false);
	new str[256];
	for(new count;count < MAX_BLOCKS;count++)
	{
	    if((spikestate[count])==1)
	    {
	        spike[count] = CreateStrip(spikex[count],spikey[count],spikez[count],spikezrot[count]);
	    }
	    if((roadblockstate[count])==1)
	    {
	        roadblockobject[count] = CreateDynamicObject(981,roadblockx[count],roadblocky[count],roadblockz[count],roadblockxrot[count],roadblockyrot[count],roadblockzrot[count],-1,-1,-1,200.0,300.0);
	    }
	    if((barrelstate[count])==1)
	    {
	        barrelobject[count] = CreateDynamicObject(1237,barrelx[count],barrely[count],barrelz[count],barrelxrot[count],barrelyrot[count],barrelzrot[count],-1,-1,-1,200.0,300.0);
	    }
	}
	for(new repairshopid;repairshopid < MAX_REPAIRSHOPS;repairshopid++)
	{
	    if((repairshopstate[repairshopid])==1)
	    {
         	repairshoppickup[repairshopid] = CreatePickup(1239,23,repairshopx[repairshopid],repairshopy[repairshopid],repairshopz[repairshopid],-1);
			repairshop[repairshopid] = CreateDynamicObject(repairshopobjectid[repairshopid],repairshopx[repairshopid],repairshopy[repairshopid],repairshopz[repairshopid] + 1.5,repairshopxrot[repairshopid],repairshopyrot[repairshopid],repairshopzrot[repairshopid],-1,-1,-1,300.0);
			format(str,sizeof(str),"%i:repairgarage\n/repaircar to repair your car /buylock to buy a lock\nit cost $%i to repair your car & E-$%iS-$%i to buy a lock",repairshopid,repairshopcost[repairshopid],repairshopelockcost[repairshopid],repairshopslockcost[repairshopid]);
            repairshoplabel[repairshopid] = Create3DTextLabel(str,YELLOW,repairshopx[repairshopid],repairshopy[repairshopid],repairshopz[repairshopid],DISTANCELABEL,0,0);
	    }
	}
	/*for(new dmvid;dmvid < MAX_DMVS;dmvid++)//#4
	{
	    if((dmvstate[dmvid])==1)
	    {
     		format(str,sizeof(str),"%i:department of motor vehicles",dmvid);
		    dmvlabel[dmvid] = Create3DTextLabel(str,YELLOW,dmvx[dmvid],dmvy[dmvid],dmvz[dmvid],DISTANCELABEL,0,0);
	    }
	}*/
	for(new disposerid;disposerid < MAX_DISPOSERS;disposerid++)
	{
	    if((disposecarstate[disposerid])==1)
	    {
			format(str,sizeof(str),"%i:VehicleDisposer point\nTo dispose of your car type in /disposecar.\nYou will get 1/4 of the vehicles value",disposerid);
			disposelabel[disposerid] = Create3DTextLabel(str,YELLOW,disposecarx[disposerid],disposecary[disposerid],disposecarz[disposerid],DISTANCELABEL,0,0);
	        printf("disposerid:%i -- disposecarstate = %i disposecarx = %f disposecary = %f disposecarz = %f",disposerid,disposecarstate[disposerid],disposecarx[disposerid],disposecary[disposerid],disposecarz[disposerid]);
	    }
	}
	for(new dealershipid;dealershipid < MAX_DEALERSHIPS;dealershipid++)
	{
	    if((dealershipstate[dealershipid])==1)
	    {
          	format(str,sizeof(str),"%s\ndealership:%i\n%s",dealershipname[dealershipid],dealershipid,DealershipOwner(dealershipid));
          	dealershiplabel[dealershipid] = Create3DTextLabel(str,YELLOW,dealershipx[dealershipid],dealershipy[dealershipid],dealershipz[dealershipid],DISTANCELABEL,0,0);
          	printf("dealershipid:%i -- dealershipstate = %i dealershipname = %s dealershipx = %f dealershipy = %f dealershipz = %f dealershipownedstate = %i\n dealershipownername = %s dealershipcost = %i dealershipcash = %i",dealershipid,dealershipstate[dealershipid],dealershipname[dealershipid],dealershipx[dealershipid],dealershipy[dealershipid],dealershipz[dealershipid],dealershipownedstate[dealershipid],dealershipownername[dealershipid],dealershipcost[dealershipid],dealershipcash[dealershipid]);
	    }
	}
	for(new factoryid;factoryid < MAX_FACTORIES;factoryid++)
	{
		if((factorystate[factoryid])==1)
		{
		    format(str,sizeof(str),"Factory id:%i\n%s\nfactoryproductionstate:%s",factoryid,FactoryOwnedState(factoryid),FactoryProductionState(factoryid));
      		factorylabel[factoryid] = Create3DTextLabel(str,YELLOW,factoryx[factoryid],factoryy[factoryid],factoryz[factoryid],DISTANCELABEL,0,0);
      		printf("factoryid:%i -- factorystate = %i factoryx = %f factoryy = %f factoryz = %f\n factoryownername = %s factoryownedstate = %i factorycost = %i",factoryid,factorystate[factoryid],factoryx[factoryid],factoryy[factoryid],factoryz[factoryid],factoryownername[factoryid],factoryownedstate[factoryid],factorycost[factoryid]);
        	for(new count;count < FACTORYMAXORDERSATONCE;count++)
			{
				printf("id:%i-%i factorystockstate = %i",count,factoryid,factorystockstate[count][factoryid]);
				if((factorystockstate[count][factoryid])==1||(factorystockstate[count][factoryid])==2)
				{
				    printf("id:%i-%i -- factorydealershipid = %i factorydealerstock = %i factorydealerstockmodelid = %i factorystock = %i factoryordercost = %i factorystockcurrent = %i",count,factoryid,factorydealershipid[count][factoryid],factorydealerstock[count][factoryid],factorydealerstockmodelid[count][factoryid],factorystock[count][factoryid],factoryordercost[count][factoryid],factorystockcurrent[count][factoryid]);
				}
			}
			if((factoryproductionstate[factoryid])==1)
			{
   				factorytimer[factoryid] = SetTimerEx("VehicleProduction",15000,true,"i",factoryid);
			}
		}
	}
	for(new gasstationid;gasstationid < MAX_GASSTATIONS;gasstationid++)
	{
	    if((gasstationstate[gasstationid])==1)
	    {
	        printf("Gasstationid:%i -- gasstationstate = %i gasstationownedstate = %i gasstationownername = %s gasstationx = %f gasstationy = %f gasstationz = %f gasstationcost = %i ",gasstationid,gasstationstate[gasstationid],gasstationownedstate[gasstationid],gasstationownername[gasstationid],gasstationx[gasstationid],gasstationy[gasstationid],gasstationz[gasstationid],gasstationcost[gasstationid]);
			printf("gasstationneedgasstate = %i ammountofgasneeded = %f gasstationtotalcapacity = %f",gasstationneedgasstate[gasstationid],ammountofgasneeded[gasstationid],gasstationtotalcapacity[gasstationid]);
	        for(new count;count < MAX_GASPUMPS;count++)
	        {
				if((gaspumpstate[count][gasstationid])==1)
				{
				    printf("gaspump:%i-%i -- gaspumpstate = %i gaspumpx = %f gaspumpy = %f gaspumpz = %f gaspumpxrot = %f gaspumpyrot = %f gaspumpzrot = %f",count,gasstationid,gaspumpstate[count][gasstationid],gaspumpx[count][gasstationid],gaspumpy[count][gasstationid],gaspumpz[count][gasstationid],gaspumpxrot[count][gasstationid],gaspumpyrot[count][gasstationid],gaspumpzrot[count][gasstationid]);
					printf("gaspumpobjectid = %i gaspumpcurrentsaleammount = %i gaspumpusegestate = %i gaspumpgas = %f",gaspumpobjectid[count][gasstationid],gaspumpcurrentsaleammount[count][gasstationid],gaspumpusegestate[count][gasstationid],gaspumpgas[count][gasstationid]);
					gaspumpobject[count][gasstationid] = CreateDynamicObject(gaspumpobjectid[count][gasstationid],gaspumpx[count][gasstationid],gaspumpy[count][gasstationid],gaspumpz[count][gasstationid],gaspumpxrot[count][gasstationid],gaspumpyrot[count][gasstationid],gaspumpzrot[count][gasstationid],-1,-1,-1,300.0);
	    			format(str,sizeof(str),"gaspump:%i-%i\n%s\ncurrentfuel:%f our of %f\n%s",count,gasstationid,CurrentReful(count,gasstationid),gaspumpgas[count][gasstationid],MAX_GASPERPUMP,GasPumpUsage(count,gasstationid));
					gaspumplabel[count][gasstationid] = Create3DTextLabel(str,YELLOW,gaspumpx[count][gasstationid],gaspumpy[count][gasstationid],gaspumpz[count][gasstationid],DISTANCELABEL,0,0);
				}
	        }
	        format(str,sizeof(str),"%s\ngasstationID:%i\n%s\nyou have %f gas",gasstationname[gasstationid],gasstationid,GasStationOwner(gasstationid),TotalGasInGasStation(gasstationid));
	        gasstationlabel[gasstationid] = Create3DTextLabel(str,YELLOW,gasstationx[gasstationid],gasstationy[gasstationid],gasstationz[gasstationid],DISTANCELABEL,0,0);
    		UpdateGasStationLabels(gasstationid);
	        GasStationCapacity(gasstationid);
	    }
	}
	for(new refineryid;refineryid < MAX_REFINERYS;refineryid++)
	{
	    if((refinerystate[refineryid])==1)
	    {
			printf("%i:refineryownedstate = %i refineryownername = %s refineryx = %f refineryy = %f refineryz = %f refineryproductionstate = %i refinerycost = %i refinerycash = %i",refineryid,refineryownedstate[refineryid],refineryownername[refineryid],refineryx[refineryid],refineryy[refineryid],refineryz[refineryid],refineryproductionstate[refineryid],refinerycost[refineryid],refinerycash[refineryid]);
	    	format(str,sizeof(str),"Refinery:%i\nRefinery state:%s\n%s\nthere is a total of %f fuel",refineryid,RefineryProductionState(refineryid),RefineryOwner(refineryid),TotalOil(refineryid));
			refinerylabel[refineryid] = Create3DTextLabel(str,YELLOW,refineryx[refineryid],refineryy[refineryid],refineryz[refineryid],DISTANCELABEL,0,0);
   			for(new count;count < MAX_OILPUMPS;count++)
			{
				printf("count = %i oilstoragestate = %i oilpumpstate = %i",count,oilstoragestate[count][refineryid],oilpumpstate[count][refineryid]);
				if((oilstoragestate[count][refineryid])==1)
				{
				    printf("%i-%i:oilstorageobjectid = %i oilstoragestate = %i oilstoragex = %f oilstoragey = %f oilstoragez = %f",count,refineryid,oilstorageobjectid[count][refineryid],oilstoragestate[count][refineryid],oilstoragex[count][refineryid],oilstoragey[count][refineryid],oilstoragez[count][refineryid]);
				    printf("%i-%i:oilstoragexrot = %f oilstorageyrot = %f oilstoragezrot = %f oilstoragefuel = %f",count,refineryid,oilstoragexrot[count][refineryid],oilstorageyrot[count][refineryid],oilstoragezrot[count][refineryid],oilstoragefuel[count][refineryid]);
					format(str,sizeof(str),"ID:%i-%i\n This fuelstorage is owned by %s\nThere is currently %fL out of %f fuel in hear\ncurrentstate:%s",count,refineryid,refineryownername[refineryid],oilstoragefuel[count][refineryid],MAX_OILSTORAGE,RefineryProductionState(refineryid));
					oilstoragelabel[count][refineryid] = Create3DTextLabel(str,YELLOW,oilstoragex[count][refineryid],oilstoragey[count][refineryid],oilstoragez[count][refineryid],DISTANCELABEL,0,0);
					oilstorageobject[count][refineryid] = CreateDynamicObject(oilstorageobjectid[count][refineryid],oilstoragex[count][refineryid],oilstoragey[count][refineryid],oilstoragez[count][refineryid],oilstoragexrot[count][refineryid],oilstorageyrot[count][refineryid],oilstoragezrot[count][refineryid],-1,-1,-1,300.0);
				}
				if((oilpumpstate[count][refineryid])==1)
				{
					printf("%i-%i:oilpumpstate = %i oilpumpx = %f oilpumpy = %f oilpumpz = %f oilpumpxrot = %f oilpumpyrot = %f oilpumpzrot = %f oilpumpobjectid = %i",count,refineryid,oilpumpstate[count][refineryid],oilpumpx[count][refineryid],oilpumpy[count][refineryid],oilpumpz[count][refineryid],oilpumpxrot[count][refineryid],oilpumpyrot[count][refineryid],oilpumpzrot[count][refineryid],oilpumpobjectid[count][refineryid]);
		   			format(str,sizeof(str),"OilpumpID:%i-%i,owner:%s,state:%s",count,refineryid,refineryownername[refineryid],RefineryProductionState(refineryid));
		            oilpumplabel[count][refineryid] = Create3DTextLabel(str,YELLOW,oilpumpx[count][refineryid],oilpumpy[count][refineryid],oilpumpz[count][refineryid],DISTANCELABEL,0,0);
		            oilpumpobject[count][refineryid] = CreateDynamicObject(oilpumpobjectid[count][refineryid],oilpumpx[count][refineryid],oilpumpy[count][refineryid],oilpumpz[count][refineryid],oilpumpxrot[count][refineryid],oilpumpyrot[count][refineryid],oilpumpzrot[count][refineryid],-1,-1,-1,300.0);
				}
			}
			format(str,sizeof(str),"Refinery:%i\nRefinery state:%s\n%s\nthere is a total of %f fuel",refineryid,RefineryProductionState(refineryid),RefineryOwner(refineryid),TotalOil(refineryid));
			Update3DTextLabelText(refinerylabel[refineryid],YELLOW,str);
			if((refineryproductionstate[refineryid])==1||(refineryproductionstate[refineryid])==2)
			{
			    refineryproductiontimer[refineryid] = SetTimerEx("RefineryOilProduction",1000,true,"i",refineryid);
			}
		}
	}
}
CreateGages()
{
	//------------staticvariables------------------//
	
	gagespeedlabels[0] = TextDrawCreate(460.000000, 414.000000, "0");
	TextDrawBackgroundColor(gagespeedlabels[0], 255);
	TextDrawFont(gagespeedlabels[0], 1);
	TextDrawLetterSize(gagespeedlabels[0], 0.500000, 1.000000);
	TextDrawColor(gagespeedlabels[0], 8388863);
	TextDrawSetOutline(gagespeedlabels[0], 0);
	TextDrawSetProportional(gagespeedlabels[0], 1);
	TextDrawSetShadow(gagespeedlabels[0], 1);

	gagespeedlabels[1] = TextDrawCreate(464.000000, 395.000000, "20");
	TextDrawBackgroundColor(gagespeedlabels[1], 255);
	TextDrawFont(gagespeedlabels[1], 1);
	TextDrawLetterSize(gagespeedlabels[1], 0.500000, 1.000000);
	TextDrawColor(gagespeedlabels[1], 8388863);
	TextDrawSetOutline(gagespeedlabels[1], 0);
	TextDrawSetProportional(gagespeedlabels[1], 1);
	TextDrawSetShadow(gagespeedlabels[1], 1);

	gagespeedlabels[2] = TextDrawCreate(468.000000, 379.000000, "40");
	TextDrawBackgroundColor(gagespeedlabels[2], 255);
	TextDrawFont(gagespeedlabels[2], 1);
	TextDrawLetterSize(gagespeedlabels[2], 0.500000, 1.000000);
	TextDrawColor(gagespeedlabels[2], 8388863);
	TextDrawSetOutline(gagespeedlabels[2], 0);
	TextDrawSetProportional(gagespeedlabels[2], 1);
	TextDrawSetShadow(gagespeedlabels[2], 1);

	gagespeedlabels[3] = TextDrawCreate(477.000000, 361.000000, "60");
	TextDrawBackgroundColor(gagespeedlabels[3], 255);
	TextDrawFont(gagespeedlabels[3], 1);
	TextDrawLetterSize(gagespeedlabels[3], 0.500000, 1.000000);
	TextDrawColor(gagespeedlabels[3], 8388863);
	TextDrawSetOutline(gagespeedlabels[3], 0);
	TextDrawSetProportional(gagespeedlabels[3], 1);
	TextDrawSetShadow(gagespeedlabels[3], 1);

	gagespeedlabels[4] = TextDrawCreate(499.000000, 348.000000, "80");
	TextDrawBackgroundColor(gagespeedlabels[4], 255);
	TextDrawFont(gagespeedlabels[4], 1);
	TextDrawLetterSize(gagespeedlabels[4], 0.500000, 1.000000);
	TextDrawColor(gagespeedlabels[4], -65281);
	TextDrawSetOutline(gagespeedlabels[4], 0);
	TextDrawSetProportional(gagespeedlabels[4], 1);
	TextDrawSetShadow(gagespeedlabels[4], 1);

	gagespeedlabels[5] = TextDrawCreate(521.000000, 343.000000, "100");
	TextDrawBackgroundColor(gagespeedlabels[5], 255);
	TextDrawFont(gagespeedlabels[5], 1);
	TextDrawLetterSize(gagespeedlabels[5], 0.500000, 1.000000);
	TextDrawColor(gagespeedlabels[5], -65281);
	TextDrawSetOutline(gagespeedlabels[5], 0);
	TextDrawSetProportional(gagespeedlabels[5], 1);
	TextDrawSetShadow(gagespeedlabels[5], 1);

	gagespeedlabels[6] = TextDrawCreate(551.000000, 350.000000, "120");
	TextDrawBackgroundColor(gagespeedlabels[6], 255);
	TextDrawFont(gagespeedlabels[6], 1);
	TextDrawLetterSize(gagespeedlabels[6], 0.500000, 1.000000);
	TextDrawColor(gagespeedlabels[6], -65281);
	TextDrawSetOutline(gagespeedlabels[6], 0);
	TextDrawSetProportional(gagespeedlabels[6], 1);
	TextDrawSetShadow(gagespeedlabels[6], 1);

	gagespeedlabels[7] = TextDrawCreate(569.000000, 367.000000, "140");
	TextDrawBackgroundColor(gagespeedlabels[7], 255);
	TextDrawFont(gagespeedlabels[7], 1);
	TextDrawLetterSize(gagespeedlabels[7], 0.500000, 1.000000);
	TextDrawColor(gagespeedlabels[7], -65281);
	TextDrawSetOutline(gagespeedlabels[7], 0);
	TextDrawSetProportional(gagespeedlabels[7], 1);
	TextDrawSetShadow(gagespeedlabels[7], 1);

	gagespeedlabels[8] = TextDrawCreate(582.000000, 382.000000, "160");
	TextDrawBackgroundColor(gagespeedlabels[8], 255);
	TextDrawFont(gagespeedlabels[8], 1);
	TextDrawLetterSize(gagespeedlabels[8], 0.500000, 1.000000);
	TextDrawColor(gagespeedlabels[8], -65281);
	TextDrawSetOutline(gagespeedlabels[8], 0);
	TextDrawSetProportional(gagespeedlabels[8], 1);
	TextDrawSetShadow(gagespeedlabels[8], 1);

	gagespeedlabels[9] = TextDrawCreate(590.000000, 397.000000, "180");
	TextDrawBackgroundColor(gagespeedlabels[9], 255);
	TextDrawFont(gagespeedlabels[9], 1);
	TextDrawLetterSize(gagespeedlabels[9], 0.500000, 1.000000);
	TextDrawColor(gagespeedlabels[9], -1828716289);
	TextDrawSetOutline(gagespeedlabels[9], 0);
	TextDrawSetProportional(gagespeedlabels[9], 1);
	TextDrawSetShadow(gagespeedlabels[9], 1);

	gagespeedlabels[10] = TextDrawCreate(598.000000, 415.000000, "200");
	TextDrawBackgroundColor(gagespeedlabels[10], 255);
	TextDrawFont(gagespeedlabels[10], 1);
	TextDrawLetterSize(gagespeedlabels[10], 0.500000, 1.000000);
	TextDrawColor(gagespeedlabels[10], -1828716289);
	TextDrawSetOutline(gagespeedlabels[10], 0);
	TextDrawSetProportional(gagespeedlabels[10], 1);
	TextDrawSetShadow(gagespeedlabels[10], 1);

	gagecenterpoint = TextDrawCreate(537.000000, 414.000000, ".");
	TextDrawBackgroundColor(gagecenterpoint, 255);
	TextDrawFont(gagecenterpoint, 1);
	TextDrawLetterSize(gagecenterpoint, 0.500000, 1.000000);
	TextDrawColor(gagecenterpoint, -1);
	TextDrawSetOutline(gagecenterpoint, 0);
	TextDrawSetProportional(gagecenterpoint, 1);
	TextDrawSetShadow(gagecenterpoint, 1);

	gagehealth = TextDrawCreate(447.000000, 436.000000, "Health");
	TextDrawBackgroundColor(gagehealth, 255);
	TextDrawFont(gagehealth, 1);
	TextDrawLetterSize(gagehealth, 0.280003, 0.899996);
	TextDrawColor(gagehealth, -754974721);
	TextDrawSetOutline(gagehealth, 0);
	TextDrawSetProportional(gagehealth, 1);
	TextDrawSetShadow(gagehealth, 1);
	
	//--------------------0----------------------------------
    gagepoint[0][0] = TextDrawCreate(526.000000, 414.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][0], 255);
	TextDrawFont(gagepoint[0][0], 1);
	TextDrawLetterSize(gagepoint[0][0], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][0], 8388863);
	TextDrawSetOutline(gagepoint[0][0], 0);
	TextDrawSetProportional(gagepoint[0][0], 1);
	TextDrawSetShadow(gagepoint[0][0], 1);

	gagepoint[1][0] = TextDrawCreate(513.000000, 414.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][0], 255);
	TextDrawFont(gagepoint[1][0], 1);
	TextDrawLetterSize(gagepoint[1][0], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][0], 8388863);
	TextDrawSetOutline(gagepoint[1][0], 0);
	TextDrawSetProportional(gagepoint[1][0], 1);
	TextDrawSetShadow(gagepoint[1][0], 1);

	gagepoint[2][0] = TextDrawCreate(501.000000, 414.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][0], 255);
	TextDrawFont(gagepoint[2][0], 1);
	TextDrawLetterSize(gagepoint[2][0], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][0], 8388863);
	TextDrawSetOutline(gagepoint[2][0], 0);
	TextDrawSetProportional(gagepoint[2][0], 1);
	TextDrawSetShadow(gagepoint[2][0], 1);

	gagepoint[3][0] = TextDrawCreate(488.000000, 414.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][0], 255);
	TextDrawFont(gagepoint[3][0], 1);
	TextDrawLetterSize(gagepoint[3][0], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][0], 8388863);
	TextDrawSetOutline(gagepoint[3][0], 0);
	TextDrawSetProportional(gagepoint[3][0], 1);
	TextDrawSetShadow(gagepoint[3][0], 1);
	//--------------------5----------------------------------
    gagepoint[0][5] = TextDrawCreate(526.000000, 413.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][5], 255);
	TextDrawFont(gagepoint[0][5], 1);
	TextDrawLetterSize(gagepoint[0][5], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][5], 8388863);
	TextDrawSetOutline(gagepoint[0][5], 0);
	TextDrawSetProportional(gagepoint[0][5], 1);
	TextDrawSetShadow(gagepoint[0][5], 1);

	gagepoint[1][5] = TextDrawCreate(513.000000, 412.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][5], 255);
	TextDrawFont(gagepoint[1][5], 1);
	TextDrawLetterSize(gagepoint[1][5], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][5], 8388863);
	TextDrawSetOutline(gagepoint[1][5], 0);
	TextDrawSetProportional(gagepoint[1][5], 1);
	TextDrawSetShadow(gagepoint[1][5], 1);

	gagepoint[2][5] = TextDrawCreate(501.000000, 411.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][5], 255);
	TextDrawFont(gagepoint[2][5], 1);
	TextDrawLetterSize(gagepoint[2][5], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][5], 8388863);
	TextDrawSetOutline(gagepoint[2][5], 0);
	TextDrawSetProportional(gagepoint[2][5], 1);
	TextDrawSetShadow(gagepoint[2][5], 1);

	gagepoint[3][5] = TextDrawCreate(488.000000, 410.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][5], 255);
	TextDrawFont(gagepoint[3][5], 1);
	TextDrawLetterSize(gagepoint[3][5], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][5], 8388863);
	TextDrawSetOutline(gagepoint[3][5], 0);
	TextDrawSetProportional(gagepoint[3][5], 1);
	TextDrawSetShadow(gagepoint[3][5], 1);
	//--------------------10----------------------------------
	gagepoint[0][10] = TextDrawCreate(526.000000, 412.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][10], 255);
	TextDrawFont(gagepoint[0][10], 1);
	TextDrawLetterSize(gagepoint[0][10], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][10], 8388863);
	TextDrawSetOutline(gagepoint[0][10], 0);
	TextDrawSetProportional(gagepoint[0][10], 1);
	TextDrawSetShadow(gagepoint[0][10], 1);

	gagepoint[1][10] = TextDrawCreate(513.000000, 410.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][10], 255);
	TextDrawFont(gagepoint[1][10], 1);
	TextDrawLetterSize(gagepoint[1][10], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][10], 8388863);
	TextDrawSetOutline(gagepoint[1][10], 0);
	TextDrawSetProportional(gagepoint[1][10], 1);
	TextDrawSetShadow(gagepoint[1][10], 1);

	gagepoint[2][10] = TextDrawCreate(501.000000, 408.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][10], 255);
	TextDrawFont(gagepoint[2][10], 1);
	TextDrawLetterSize(gagepoint[2][10], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][10], 8388863);
	TextDrawSetOutline(gagepoint[2][10], 0);
	TextDrawSetProportional(gagepoint[2][10], 1);
	TextDrawSetShadow(gagepoint[2][10], 1);

	gagepoint[3][10] = TextDrawCreate(488.000000, 405.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][10], 255);
	TextDrawFont(gagepoint[3][10], 1);
	TextDrawLetterSize(gagepoint[3][10], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][10], 8388863);
	TextDrawSetOutline(gagepoint[3][10], 0);
	TextDrawSetProportional(gagepoint[3][10], 1);
	TextDrawSetShadow(gagepoint[3][10], 1);
	//--------------------15----------------------------------
	gagepoint[0][15] = TextDrawCreate(526.000000, 411.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][15], 255);
	TextDrawFont(gagepoint[0][15], 1);
	TextDrawLetterSize(gagepoint[0][15], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][15], 8388863);
	TextDrawSetOutline(gagepoint[0][15], 0);
	TextDrawSetProportional(gagepoint[0][15], 1);
	TextDrawSetShadow(gagepoint[0][15], 1);

	gagepoint[1][15] = TextDrawCreate(513.000000, 408.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][15], 255);
	TextDrawFont(gagepoint[1][15], 1);
	TextDrawLetterSize(gagepoint[1][15], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][15], 8388863);
	TextDrawSetOutline(gagepoint[1][15], 0);
	TextDrawSetProportional(gagepoint[1][15], 1);
	TextDrawSetShadow(gagepoint[1][15], 1);

	gagepoint[2][15] = TextDrawCreate(501.000000, 404.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][15], 255);
	TextDrawFont(gagepoint[2][15], 1);
	TextDrawLetterSize(gagepoint[2][15], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][15], 8388863);
	TextDrawSetOutline(gagepoint[2][15], 0);
	TextDrawSetProportional(gagepoint[2][15], 1);
	TextDrawSetShadow(gagepoint[2][15], 1);

	gagepoint[3][15] = TextDrawCreate(488.000000, 401.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][15], 255);
	TextDrawFont(gagepoint[3][15], 1);
	TextDrawLetterSize(gagepoint[3][15], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][15], 8388863);
	TextDrawSetOutline(gagepoint[3][15], 0);
	TextDrawSetProportional(gagepoint[3][15], 1);
	TextDrawSetShadow(gagepoint[3][15], 1);
	//--------------------20----------------------------------
	gagepoint[0][20] = TextDrawCreate(526.000000, 410.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][20], 255);
	TextDrawFont(gagepoint[0][20], 1);
	TextDrawLetterSize(gagepoint[0][20], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][20], 8388863);
	TextDrawSetOutline(gagepoint[0][20], 0);
	TextDrawSetProportional(gagepoint[0][20], 1);
	TextDrawSetShadow(gagepoint[0][20], 1);

	gagepoint[1][20] = TextDrawCreate(513.000000, 406.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][20], 255);
	TextDrawFont(gagepoint[1][20], 1);
	TextDrawLetterSize(gagepoint[1][20], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][20], 8388863);
	TextDrawSetOutline(gagepoint[1][20], 0);
	TextDrawSetProportional(gagepoint[1][20], 1);
	TextDrawSetShadow(gagepoint[1][20], 1);

	gagepoint[2][20] = TextDrawCreate(501.000000, 401.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][20], 255);
	TextDrawFont(gagepoint[2][20], 1);
	TextDrawLetterSize(gagepoint[2][20], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][20], 8388863);
	TextDrawSetOutline(gagepoint[2][20], 0);
	TextDrawSetProportional(gagepoint[2][20], 1);
	TextDrawSetShadow(gagepoint[2][20], 1);

	gagepoint[3][20] = TextDrawCreate(488.000000, 397.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][20], 255);
	TextDrawFont(gagepoint[3][20], 1);
	TextDrawLetterSize(gagepoint[3][20], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][20], 8388863);
	TextDrawSetOutline(gagepoint[3][20], 0);
	TextDrawSetProportional(gagepoint[3][20], 1);
	TextDrawSetShadow(gagepoint[3][20], 1);
	//--------------------25----------------------------------
	gagepoint[0][25] = TextDrawCreate(526.000000, 409.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][25], 255);
	TextDrawFont(gagepoint[0][25], 1);
	TextDrawLetterSize(gagepoint[0][25], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][25], 8388863);
	TextDrawSetOutline(gagepoint[0][25], 0);
	TextDrawSetProportional(gagepoint[0][25], 1);
	TextDrawSetShadow(gagepoint[0][25], 1);

	gagepoint[1][25] = TextDrawCreate(513.000000, 404.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][25], 255);
	TextDrawFont(gagepoint[1][25], 1);
	TextDrawLetterSize(gagepoint[1][25], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][25], 8388863);
	TextDrawSetOutline(gagepoint[1][25], 0);
	TextDrawSetProportional(gagepoint[1][25], 1);
	TextDrawSetShadow(gagepoint[1][25], 1);

	gagepoint[2][25] = TextDrawCreate(501.000000, 398.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][25], 255);
	TextDrawFont(gagepoint[2][25], 1);
	TextDrawLetterSize(gagepoint[2][25], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][25], 8388863);
	TextDrawSetOutline(gagepoint[2][25], 0);
	TextDrawSetProportional(gagepoint[2][25], 1);
	TextDrawSetShadow(gagepoint[2][25], 1);

	gagepoint[3][25] = TextDrawCreate(488.000000, 393.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][25], 255);
	TextDrawFont(gagepoint[3][25], 1);
	TextDrawLetterSize(gagepoint[3][25], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][25], 8388863);
	TextDrawSetOutline(gagepoint[3][25], 0);
	TextDrawSetProportional(gagepoint[3][25], 1);
	TextDrawSetShadow(gagepoint[3][25], 1);
	//--------------------30----------------------------------
	gagepoint[0][30] = TextDrawCreate(526.000000, 408.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][30], 255);
	TextDrawFont(gagepoint[0][30], 1);
	TextDrawLetterSize(gagepoint[0][30], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][30], 8388863);
	TextDrawSetOutline(gagepoint[0][30], 0);
	TextDrawSetProportional(gagepoint[0][30], 1);
	TextDrawSetShadow(gagepoint[0][30], 1);

	gagepoint[1][30] = TextDrawCreate(513.000000, 402.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][30], 255);
	TextDrawFont(gagepoint[1][30], 1);
	TextDrawLetterSize(gagepoint[1][30], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][30], 8388863);
	TextDrawSetOutline(gagepoint[1][30], 0);
	TextDrawSetProportional(gagepoint[1][30], 1);
	TextDrawSetShadow(gagepoint[1][30], 1);

	gagepoint[2][30] = TextDrawCreate(501.000000, 395.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][30], 255);
	TextDrawFont(gagepoint[2][30], 1);
	TextDrawLetterSize(gagepoint[2][30], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][30], 8388863);
	TextDrawSetOutline(gagepoint[2][30], 0);
	TextDrawSetProportional(gagepoint[2][30], 1);
	TextDrawSetShadow(gagepoint[2][30], 1);

	gagepoint[3][30] = TextDrawCreate(488.000000, 389.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][30], 255);
	TextDrawFont(gagepoint[3][30], 1);
	TextDrawLetterSize(gagepoint[3][30], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][30], 8388863);
	TextDrawSetOutline(gagepoint[3][30], 0);
	TextDrawSetProportional(gagepoint[3][30], 1);
	TextDrawSetShadow(gagepoint[3][30], 1);
	//--------------------35----------------------------------
	gagepoint[0][35] = TextDrawCreate(526.000000, 407.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][35], 255);
	TextDrawFont(gagepoint[0][35], 1);
	TextDrawLetterSize(gagepoint[0][35], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][35], 8388863);
	TextDrawSetOutline(gagepoint[0][35], 0);
	TextDrawSetProportional(gagepoint[0][35], 1);
	TextDrawSetShadow(gagepoint[0][35], 1);

	gagepoint[1][35] = TextDrawCreate(513.000000, 400.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][35], 255);
	TextDrawFont(gagepoint[1][35], 1);
	TextDrawLetterSize(gagepoint[1][35], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][35], 8388863);
	TextDrawSetOutline(gagepoint[1][35], 0);
	TextDrawSetProportional(gagepoint[1][35], 1);
	TextDrawSetShadow(gagepoint[1][35], 1);

	gagepoint[2][35] = TextDrawCreate(501.000000, 392.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][35], 255);
	TextDrawFont(gagepoint[2][35], 1);
	TextDrawLetterSize(gagepoint[2][35], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][35], 8388863);
	TextDrawSetOutline(gagepoint[2][35], 0);
	TextDrawSetProportional(gagepoint[2][35], 1);
	TextDrawSetShadow(gagepoint[2][35], 1);

	gagepoint[3][35] = TextDrawCreate(488.000000, 385.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][35], 255);
	TextDrawFont(gagepoint[3][35], 1);
	TextDrawLetterSize(gagepoint[3][35], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][35], 8388863);
	TextDrawSetOutline(gagepoint[3][35], 0);
	TextDrawSetProportional(gagepoint[3][35], 1);
	TextDrawSetShadow(gagepoint[3][35], 1);
	//--------------------40----------------------------------
	gagepoint[0][40] = TextDrawCreate(527.000000, 407.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][40], 255);
	TextDrawFont(gagepoint[0][40], 1);
	TextDrawLetterSize(gagepoint[0][40], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][40], 8388863);
	TextDrawSetOutline(gagepoint[0][40], 0);
	TextDrawSetProportional(gagepoint[0][40], 1);
	TextDrawSetShadow(gagepoint[0][40], 1);

	gagepoint[1][40] = TextDrawCreate(514.000000, 398.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][40], 255);
	TextDrawFont(gagepoint[1][40], 1);
	TextDrawLetterSize(gagepoint[1][40], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][40], 8388863);
	TextDrawSetOutline(gagepoint[1][40], 0);
	TextDrawSetProportional(gagepoint[1][40], 1);
	TextDrawSetShadow(gagepoint[1][40], 1);

	gagepoint[2][40] = TextDrawCreate(502.000000, 389.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][40], 255);
	TextDrawFont(gagepoint[2][40], 1);
	TextDrawLetterSize(gagepoint[2][40], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][40], 8388863);
	TextDrawSetOutline(gagepoint[2][40], 0);
	TextDrawSetProportional(gagepoint[2][40], 1);
	TextDrawSetShadow(gagepoint[2][40], 1);

	gagepoint[3][40] = TextDrawCreate(489.000000, 381.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][40], 255);
	TextDrawFont(gagepoint[3][40], 1);
	TextDrawLetterSize(gagepoint[3][40], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][40], 8388863);
	TextDrawSetOutline(gagepoint[3][40], 0);
	TextDrawSetProportional(gagepoint[3][40], 1);
	TextDrawSetShadow(gagepoint[3][40], 1);
	//--------------------45----------------------------------
	gagepoint[0][45] = TextDrawCreate(528.000000, 406.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][45], 255);
	TextDrawFont(gagepoint[0][45], 1);
	TextDrawLetterSize(gagepoint[0][45], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][45], 8388863);
	TextDrawSetOutline(gagepoint[0][45], 0);
	TextDrawSetProportional(gagepoint[0][45], 1);
	TextDrawSetShadow(gagepoint[0][45], 1);

	gagepoint[1][45] = TextDrawCreate(516.000000, 396.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][45], 255);
	TextDrawFont(gagepoint[1][45], 1);
	TextDrawLetterSize(gagepoint[1][45], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][45], 8388863);
	TextDrawSetOutline(gagepoint[1][45], 0);
	TextDrawSetProportional(gagepoint[1][45], 1);
	TextDrawSetShadow(gagepoint[1][45], 1);

	gagepoint[2][45] = TextDrawCreate(504.000000, 386.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][45], 255);
	TextDrawFont(gagepoint[2][45], 1);
	TextDrawLetterSize(gagepoint[2][45], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][45], 8388863);
	TextDrawSetOutline(gagepoint[2][45], 0);
	TextDrawSetProportional(gagepoint[2][45], 1);
	TextDrawSetShadow(gagepoint[2][45], 1);

	gagepoint[3][45] = TextDrawCreate(491.000000, 377.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][45], 255);
	TextDrawFont(gagepoint[3][45], 1);
	TextDrawLetterSize(gagepoint[3][45], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][45], 8388863);
	TextDrawSetOutline(gagepoint[3][45], 0);
	TextDrawSetProportional(gagepoint[3][45], 1);
	TextDrawSetShadow(gagepoint[3][45], 1);
	//--------------------50----------------------------------
	gagepoint[0][50] = TextDrawCreate(529.000000, 405.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][50], 255);
	TextDrawFont(gagepoint[0][50], 1);
	TextDrawLetterSize(gagepoint[0][50], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][50], 8388863);
	TextDrawSetOutline(gagepoint[0][50], 0);
	TextDrawSetProportional(gagepoint[0][50], 1);
	TextDrawSetShadow(gagepoint[0][50], 1);

	gagepoint[1][50] = TextDrawCreate(517.000000, 394.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][50], 255);
	TextDrawFont(gagepoint[1][50], 1);
	TextDrawLetterSize(gagepoint[1][50], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][50], 8388863);
	TextDrawSetOutline(gagepoint[1][50], 0);
	TextDrawSetProportional(gagepoint[1][50], 1);
	TextDrawSetShadow(gagepoint[1][50], 1);

	gagepoint[2][50] = TextDrawCreate(505.000000, 383.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][50], 255);
	TextDrawFont(gagepoint[2][50], 1);
	TextDrawLetterSize(gagepoint[2][50], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][50], 8388863);
	TextDrawSetOutline(gagepoint[2][50], 0);
	TextDrawSetProportional(gagepoint[2][50], 1);
	TextDrawSetShadow(gagepoint[2][50], 1);

	gagepoint[3][50] = TextDrawCreate(492.000000, 373.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][50], 255);
	TextDrawFont(gagepoint[3][50], 1);
	TextDrawLetterSize(gagepoint[3][50], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][50], 8388863);
	TextDrawSetOutline(gagepoint[3][50], 0);
	TextDrawSetProportional(gagepoint[3][50], 1);
	TextDrawSetShadow(gagepoint[3][50], 1);
	//--------------------55----------------------------------
	gagepoint[0][55] = TextDrawCreate(530.000000, 404.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][55], 255);
	TextDrawFont(gagepoint[0][55], 1);
	TextDrawLetterSize(gagepoint[0][55], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][55], 8388863);
	TextDrawSetOutline(gagepoint[0][55], 0);
	TextDrawSetProportional(gagepoint[0][55], 1);
	TextDrawSetShadow(gagepoint[0][55], 1);

	gagepoint[1][55] = TextDrawCreate(518.000000, 392.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][55], 255);
	TextDrawFont(gagepoint[1][55], 1);
	TextDrawLetterSize(gagepoint[1][55], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][55], 8388863);
	TextDrawSetOutline(gagepoint[1][55], 0);
	TextDrawSetProportional(gagepoint[1][55], 1);
	TextDrawSetShadow(gagepoint[1][55], 1);

	gagepoint[2][55] = TextDrawCreate(506.000000, 380.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][55], 255);
	TextDrawFont(gagepoint[2][55], 1);
	TextDrawLetterSize(gagepoint[2][55], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][55], 8388863);
	TextDrawSetOutline(gagepoint[2][55], 0);
	TextDrawSetProportional(gagepoint[2][55], 1);
	TextDrawSetShadow(gagepoint[2][55], 1);

	gagepoint[3][55] = TextDrawCreate(493.000000, 369.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][55], 255);
	TextDrawFont(gagepoint[3][55], 1);
	TextDrawLetterSize(gagepoint[3][55], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][55], 8388863);
	TextDrawSetOutline(gagepoint[3][55], 0);
	TextDrawSetProportional(gagepoint[3][55], 1);
	TextDrawSetShadow(gagepoint[3][55], 1);
	//--------------------60----------------------------------
	gagepoint[0][60] = TextDrawCreate(530.000000, 403.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][60], 255);
	TextDrawFont(gagepoint[0][60], 1);
	TextDrawLetterSize(gagepoint[0][60], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][60], 8388863);
	TextDrawSetOutline(gagepoint[0][60], 0);
	TextDrawSetProportional(gagepoint[0][60], 1);
	TextDrawSetShadow(gagepoint[0][60], 1);

	gagepoint[1][60] = TextDrawCreate(520.000000, 390.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][60], 255);
	TextDrawFont(gagepoint[1][60], 1);
	TextDrawLetterSize(gagepoint[1][60], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][60], 8388863);
	TextDrawSetOutline(gagepoint[1][60], 0);
	TextDrawSetProportional(gagepoint[1][60], 1);
	TextDrawSetShadow(gagepoint[1][60], 1);

	gagepoint[2][60] = TextDrawCreate(507.000000, 377.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][60], 255);
	TextDrawFont(gagepoint[2][60], 1);
	TextDrawLetterSize(gagepoint[2][60], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][60], 8388863);
	TextDrawSetOutline(gagepoint[2][60], 0);
	TextDrawSetProportional(gagepoint[2][60], 1);
	TextDrawSetShadow(gagepoint[2][60], 1);

	gagepoint[3][60] = TextDrawCreate(495.000000, 365.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][60], 255);
	TextDrawFont(gagepoint[3][60], 1);
	TextDrawLetterSize(gagepoint[3][60], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][60], 8388863);
	TextDrawSetOutline(gagepoint[3][60], 0);
	TextDrawSetProportional(gagepoint[3][60], 1);
	TextDrawSetShadow(gagepoint[3][60], 1);
	//--------------------65----------------------------------
	gagepoint[0][65] = TextDrawCreate(531.000000, 402.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][65], 255);
	TextDrawFont(gagepoint[0][65], 1);
	TextDrawLetterSize(gagepoint[0][65], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][65], 8388863);
	TextDrawSetOutline(gagepoint[0][65], 0);
	TextDrawSetProportional(gagepoint[0][65], 1);
	TextDrawSetShadow(gagepoint[0][65], 1);

	gagepoint[1][65] = TextDrawCreate(522.000000, 388.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][65], 255);
	TextDrawFont(gagepoint[1][65], 1);
	TextDrawLetterSize(gagepoint[1][65], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][65], 8388863);
	TextDrawSetOutline(gagepoint[1][65], 0);
	TextDrawSetProportional(gagepoint[1][65], 1);
	TextDrawSetShadow(gagepoint[1][65], 1);

	gagepoint[2][65] = TextDrawCreate(510.000000, 374.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][65], 255);
	TextDrawFont(gagepoint[2][65], 1);
	TextDrawLetterSize(gagepoint[2][65], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][65], 8388863);
	TextDrawSetOutline(gagepoint[2][65], 0);
	TextDrawSetProportional(gagepoint[2][65], 1);
	TextDrawSetShadow(gagepoint[2][65], 1);

	gagepoint[3][65] = TextDrawCreate(500.000000, 361.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][65], 255);
	TextDrawFont(gagepoint[3][65], 1);
	TextDrawLetterSize(gagepoint[3][65], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][65], 8388863);
	TextDrawSetOutline(gagepoint[3][65], 0);
	TextDrawSetProportional(gagepoint[3][65], 1);
	TextDrawSetShadow(gagepoint[3][65], 1);
	//--------------------70----------------------------------
	gagepoint[0][70] = TextDrawCreate(531.000000, 402.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][70], 255);
	TextDrawFont(gagepoint[0][70], 1);
	TextDrawLetterSize(gagepoint[0][70], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][70], 8388863);
	TextDrawSetOutline(gagepoint[0][70], 0);
	TextDrawSetProportional(gagepoint[0][70], 1);
	TextDrawSetShadow(gagepoint[0][70], 1);

	gagepoint[1][70] = TextDrawCreate(524.000000, 388.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][70], 255);
	TextDrawFont(gagepoint[1][70], 1);
	TextDrawLetterSize(gagepoint[1][70], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][70], 8388863);
	TextDrawSetOutline(gagepoint[1][70], 0);
	TextDrawSetProportional(gagepoint[1][70], 1);
	TextDrawSetShadow(gagepoint[1][70], 1);

	gagepoint[2][70] = TextDrawCreate(513.000000, 374.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][70], 255);
	TextDrawFont(gagepoint[2][70], 1);
	TextDrawLetterSize(gagepoint[2][70], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][70], 8388863);
	TextDrawSetOutline(gagepoint[2][70], 0);
	TextDrawSetProportional(gagepoint[2][70], 1);
	TextDrawSetShadow(gagepoint[2][70], 1);

	gagepoint[3][70] = TextDrawCreate(504.000000, 360.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][70], 255);
	TextDrawFont(gagepoint[3][70], 1);
	TextDrawLetterSize(gagepoint[3][70], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][70], 8388863);
	TextDrawSetOutline(gagepoint[3][70], 0);
	TextDrawSetProportional(gagepoint[3][70], 1);
	TextDrawSetShadow(gagepoint[3][70], 1);
	//--------------------75----------------------------------
	gagepoint[0][75] = TextDrawCreate(532.000000, 401.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][75], 255);
	TextDrawFont(gagepoint[0][75], 1);
	TextDrawLetterSize(gagepoint[0][75], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][75], 8388863);
	TextDrawSetOutline(gagepoint[0][75], 0);
	TextDrawSetProportional(gagepoint[0][75], 1);
	TextDrawSetShadow(gagepoint[0][75], 1);

	gagepoint[1][75] = TextDrawCreate(525.000000, 387.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][75], 255);
	TextDrawFont(gagepoint[1][75], 1);
	TextDrawLetterSize(gagepoint[1][75], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][75], 8388863);
	TextDrawSetOutline(gagepoint[1][75], 0);
	TextDrawSetProportional(gagepoint[1][75], 1);
	TextDrawSetShadow(gagepoint[1][75], 1);

	gagepoint[2][75] = TextDrawCreate(516.000000, 373.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][75], 255);
	TextDrawFont(gagepoint[2][75], 1);
	TextDrawLetterSize(gagepoint[2][75], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][75], 8388863);
	TextDrawSetOutline(gagepoint[2][75], 0);
	TextDrawSetProportional(gagepoint[2][75], 1);
	TextDrawSetShadow(gagepoint[2][75], 1);

	gagepoint[3][75] = TextDrawCreate(508.000000, 359.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][75], 255);
	TextDrawFont(gagepoint[3][75], 1);
	TextDrawLetterSize(gagepoint[3][75], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][75], 8388863);
	TextDrawSetOutline(gagepoint[3][75], 0);
	TextDrawSetProportional(gagepoint[3][75], 1);
	TextDrawSetShadow(gagepoint[3][75], 1);
	//--------------------80----------------------------------
	gagepoint[0][80] = TextDrawCreate(532.000000, 401.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][80], 255);
	TextDrawFont(gagepoint[0][80], 1);
	TextDrawLetterSize(gagepoint[0][80], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][80], 8388863);
	TextDrawSetOutline(gagepoint[0][80], 0);
	TextDrawSetProportional(gagepoint[0][80], 1);
	TextDrawSetShadow(gagepoint[0][80], 1);

	gagepoint[1][80] = TextDrawCreate(526.000000, 386.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][80], 255);
	TextDrawFont(gagepoint[1][80], 1);
	TextDrawLetterSize(gagepoint[1][80], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][80], 8388863);
	TextDrawSetOutline(gagepoint[1][80], 0);
	TextDrawSetProportional(gagepoint[1][80], 1);
	TextDrawSetShadow(gagepoint[1][80], 1);

	gagepoint[2][80] = TextDrawCreate(520.000000, 372.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][80], 255);
	TextDrawFont(gagepoint[2][80], 1);
	TextDrawLetterSize(gagepoint[2][80], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][80], 8388863);
	TextDrawSetOutline(gagepoint[2][80], 0);
	TextDrawSetProportional(gagepoint[2][80], 1);
	TextDrawSetShadow(gagepoint[2][80], 1);

	gagepoint[3][80] = TextDrawCreate(513.000000, 357.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][80], 255);
	TextDrawFont(gagepoint[3][80], 1);
	TextDrawLetterSize(gagepoint[3][80], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][80], 8388863);
	TextDrawSetOutline(gagepoint[3][80], 0);
	TextDrawSetProportional(gagepoint[3][80], 1);
	TextDrawSetShadow(gagepoint[3][80], 1);
	//--------------------85----------------------------------
	gagepoint[0][85] = TextDrawCreate(533.000000, 401.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][85], 255);
	TextDrawFont(gagepoint[0][85], 1);
	TextDrawLetterSize(gagepoint[0][85], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][85], 8388863);
	TextDrawSetOutline(gagepoint[0][85], 0);
	TextDrawSetProportional(gagepoint[0][85], 1);
	TextDrawSetShadow(gagepoint[0][85], 1);

	gagepoint[1][85] = TextDrawCreate(528.000000, 386.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][85], 255);
	TextDrawFont(gagepoint[1][85], 1);
	TextDrawLetterSize(gagepoint[1][85], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][85], 8388863);
	TextDrawSetOutline(gagepoint[1][85], 0);
	TextDrawSetProportional(gagepoint[1][85], 1);
	TextDrawSetShadow(gagepoint[1][85], 1);

	gagepoint[2][85] = TextDrawCreate(523.000000, 372.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][85], 255);
	TextDrawFont(gagepoint[2][85], 1);
	TextDrawLetterSize(gagepoint[2][85], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][85], 8388863);
	TextDrawSetOutline(gagepoint[2][85], 0);
	TextDrawSetProportional(gagepoint[2][85], 1);
	TextDrawSetShadow(gagepoint[2][85], 1);

	gagepoint[3][85] = TextDrawCreate(517.000000, 357.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][85], 255);
	TextDrawFont(gagepoint[3][85], 1);
	TextDrawLetterSize(gagepoint[3][85], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][85], 8388863);
	TextDrawSetOutline(gagepoint[3][85], 0);
	TextDrawSetProportional(gagepoint[3][85], 1);
	TextDrawSetShadow(gagepoint[3][85], 1);
	//--------------------90----------------------------------
	gagepoint[0][90] = TextDrawCreate(534.000000, 401.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][90], 255);
	TextDrawFont(gagepoint[0][90], 1);
	TextDrawLetterSize(gagepoint[0][90], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][90], 8388863);
	TextDrawSetOutline(gagepoint[0][90], 0);
	TextDrawSetProportional(gagepoint[0][90], 1);
	TextDrawSetShadow(gagepoint[0][90], 1);

	gagepoint[1][90] = TextDrawCreate(530.000000, 386.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][90], 255);
	TextDrawFont(gagepoint[1][90], 1);
	TextDrawLetterSize(gagepoint[1][90], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][90], 8388863);
	TextDrawSetOutline(gagepoint[1][90], 0);
	TextDrawSetProportional(gagepoint[1][90], 1);
	TextDrawSetShadow(gagepoint[1][90], 1);

	gagepoint[2][90] = TextDrawCreate(526.000000, 372.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][90], 255);
	TextDrawFont(gagepoint[2][90], 1);
	TextDrawLetterSize(gagepoint[2][90], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][90], 8388863);
	TextDrawSetOutline(gagepoint[2][90], 0);
	TextDrawSetProportional(gagepoint[2][90], 1);
	TextDrawSetShadow(gagepoint[2][90], 1);

	gagepoint[3][90] = TextDrawCreate(522.000000, 357.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][90], 255);
	TextDrawFont(gagepoint[3][90], 1);
	TextDrawLetterSize(gagepoint[3][90], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][90], 8388863);
	TextDrawSetOutline(gagepoint[3][90], 0);
	TextDrawSetProportional(gagepoint[3][90], 1);
	TextDrawSetShadow(gagepoint[3][90], 1);
	//--------------------95----------------------------------
	gagepoint[0][95] = TextDrawCreate(535.000000, 400.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][95], 255);
	TextDrawFont(gagepoint[0][95], 1);
	TextDrawLetterSize(gagepoint[0][95], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][95], 8388863);
	TextDrawSetOutline(gagepoint[0][95], 0);
	TextDrawSetProportional(gagepoint[0][95], 1);
	TextDrawSetShadow(gagepoint[0][95], 1);

	gagepoint[1][95] = TextDrawCreate(532.000000, 385.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][95], 255);
	TextDrawFont(gagepoint[1][95], 1);
	TextDrawLetterSize(gagepoint[1][95], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][95], 8388863);
	TextDrawSetOutline(gagepoint[1][95], 0);
	TextDrawSetProportional(gagepoint[1][95], 1);
	TextDrawSetShadow(gagepoint[1][95], 1);

	gagepoint[2][95] = TextDrawCreate(529.000000, 371.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][95], 255);
	TextDrawFont(gagepoint[2][95], 1);
	TextDrawLetterSize(gagepoint[2][95], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][95], 8388863);
	TextDrawSetOutline(gagepoint[2][95], 0);
	TextDrawSetProportional(gagepoint[2][95], 1);
	TextDrawSetShadow(gagepoint[2][95], 1);

	gagepoint[3][95] = TextDrawCreate(526.000000, 356.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][95], 255);
	TextDrawFont(gagepoint[3][95], 1);
	TextDrawLetterSize(gagepoint[3][95], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][95], 8388863);
	TextDrawSetOutline(gagepoint[3][95], 0);
	TextDrawSetProportional(gagepoint[3][95], 1);
	TextDrawSetShadow(gagepoint[3][95], 1);
	//--------------------100----------------------------------
	gagepoint[0][100] = TextDrawCreate(536.000000, 400.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][100], 255);
	TextDrawFont(gagepoint[0][100], 1);
	TextDrawLetterSize(gagepoint[0][100], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][100], 8388863);
	TextDrawSetOutline(gagepoint[0][100], 0);
	TextDrawSetProportional(gagepoint[0][100], 1);
	TextDrawSetShadow(gagepoint[0][100], 1);

	gagepoint[1][100] = TextDrawCreate(534.000000, 385.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][100], 255);
	TextDrawFont(gagepoint[1][100], 1);
	TextDrawLetterSize(gagepoint[1][100], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][100], 8388863);
	TextDrawSetOutline(gagepoint[1][100], 0);
	TextDrawSetProportional(gagepoint[1][100], 1);
	TextDrawSetShadow(gagepoint[1][100], 1);

	gagepoint[2][100] = TextDrawCreate(533.000000, 371.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][100], 255);
	TextDrawFont(gagepoint[2][100], 1);
	TextDrawLetterSize(gagepoint[2][100], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][100], 8388863);
	TextDrawSetOutline(gagepoint[2][100], 0);
	TextDrawSetProportional(gagepoint[2][100], 1);
	TextDrawSetShadow(gagepoint[2][100], 1);

	gagepoint[3][100] = TextDrawCreate(532.000000, 356.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][100], 255);
	TextDrawFont(gagepoint[3][100], 1);
	TextDrawLetterSize(gagepoint[3][100], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][100], 8388863);
	TextDrawSetOutline(gagepoint[3][100], 0);
	TextDrawSetProportional(gagepoint[3][100], 1);
	TextDrawSetShadow(gagepoint[3][100], 1);
	//--------------------105----------------------------------
	gagepoint[0][105] = TextDrawCreate(537.000000, 401.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][105], 255);
	TextDrawFont(gagepoint[0][105], 1);
	TextDrawLetterSize(gagepoint[0][105], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][105], 8388863);
	TextDrawSetOutline(gagepoint[0][105], 0);
	TextDrawSetProportional(gagepoint[0][105], 1);
	TextDrawSetShadow(gagepoint[0][105], 1);

	gagepoint[1][105] = TextDrawCreate(536.000000, 386.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][105], 255);
	TextDrawFont(gagepoint[1][105], 1);
	TextDrawLetterSize(gagepoint[1][105], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][105], 8388863);
	TextDrawSetOutline(gagepoint[1][105], 0);
	TextDrawSetProportional(gagepoint[1][105], 1);
	TextDrawSetShadow(gagepoint[1][105], 1);

	gagepoint[2][105] = TextDrawCreate(536.000000, 372.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][105], 255);
	TextDrawFont(gagepoint[2][105], 1);
	TextDrawLetterSize(gagepoint[2][105], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][105], 8388863);
	TextDrawSetOutline(gagepoint[2][105], 0);
	TextDrawSetProportional(gagepoint[2][105], 1);
	TextDrawSetShadow(gagepoint[2][105], 1);

	gagepoint[3][105] = TextDrawCreate(536.000000, 357.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][105], 255);
	TextDrawFont(gagepoint[3][105], 1);
	TextDrawLetterSize(gagepoint[3][105], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][105], 8388863);
	TextDrawSetOutline(gagepoint[3][105], 0);
	TextDrawSetProportional(gagepoint[3][105], 1);
	TextDrawSetShadow(gagepoint[3][105], 1);
	//--------------------110----------------------------------
	gagepoint[0][110] = TextDrawCreate(538.000000, 402.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][110], 255);
	TextDrawFont(gagepoint[0][110], 1);
	TextDrawLetterSize(gagepoint[0][110], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][110], 8388863);
	TextDrawSetOutline(gagepoint[0][110], 0);
	TextDrawSetProportional(gagepoint[0][110], 1);
	TextDrawSetShadow(gagepoint[0][110], 1);

	gagepoint[1][110] = TextDrawCreate(538.000000, 387.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][110], 255);
	TextDrawFont(gagepoint[1][110], 1);
	TextDrawLetterSize(gagepoint[1][110], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][110], 8388863);
	TextDrawSetOutline(gagepoint[1][110], 0);
	TextDrawSetProportional(gagepoint[1][110], 1);
	TextDrawSetShadow(gagepoint[1][110], 1);

	gagepoint[2][110] = TextDrawCreate(539.000000, 373.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][110], 255);
	TextDrawFont(gagepoint[2][110], 1);
	TextDrawLetterSize(gagepoint[2][110], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][110], 8388863);
	TextDrawSetOutline(gagepoint[2][110], 0);
	TextDrawSetProportional(gagepoint[2][110], 1);
	TextDrawSetShadow(gagepoint[2][110], 1);

	gagepoint[3][110] = TextDrawCreate(539.000000, 358.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][110], 255);
	TextDrawFont(gagepoint[3][110], 1);
	TextDrawLetterSize(gagepoint[3][110], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][110], 8388863);
	TextDrawSetOutline(gagepoint[3][110], 0);
	TextDrawSetProportional(gagepoint[3][110], 1);
	TextDrawSetShadow(gagepoint[3][110], 1);
	//--------------------115----------------------------------
    gagepoint[0][115] = TextDrawCreate(539.000000, 403.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][115], 255);
	TextDrawFont(gagepoint[0][115], 1);
	TextDrawLetterSize(gagepoint[0][115], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][115], 8388863);
	TextDrawSetOutline(gagepoint[0][115], 0);
	TextDrawSetProportional(gagepoint[0][115], 1);
	TextDrawSetShadow(gagepoint[0][115], 1);

	gagepoint[1][115] = TextDrawCreate(540.000000, 389.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][115], 255);
	TextDrawFont(gagepoint[1][115], 1);
	TextDrawLetterSize(gagepoint[1][115], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][115], 8388863);
	TextDrawSetOutline(gagepoint[1][115], 0);
	TextDrawSetProportional(gagepoint[1][115], 1);
	TextDrawSetShadow(gagepoint[1][115], 1);

	gagepoint[2][115] = TextDrawCreate(542.000000, 375.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][115], 255);
	TextDrawFont(gagepoint[2][115], 1);
	TextDrawLetterSize(gagepoint[2][115], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][115], 8388863);
	TextDrawSetOutline(gagepoint[2][115], 0);
	TextDrawSetProportional(gagepoint[2][115], 1);
	TextDrawSetShadow(gagepoint[2][115], 1);

	gagepoint[3][115] = TextDrawCreate(543.000000, 360.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][115], 255);
	TextDrawFont(gagepoint[3][115], 1);
	TextDrawLetterSize(gagepoint[3][115], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][115], 8388863);
	TextDrawSetOutline(gagepoint[3][115], 0);
	TextDrawSetProportional(gagepoint[3][115], 1);
	TextDrawSetShadow(gagepoint[3][115], 1);
	//--------------------120----------------------------------
    gagepoint[0][120] = TextDrawCreate(539.000000, 403.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][120], 255);
	TextDrawFont(gagepoint[0][120], 1);
	TextDrawLetterSize(gagepoint[0][120], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][120], 8388863);
	TextDrawSetOutline(gagepoint[0][120], 0);
	TextDrawSetProportional(gagepoint[0][120], 1);
	TextDrawSetShadow(gagepoint[0][120], 1);

	gagepoint[1][120] = TextDrawCreate(542.000000, 389.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][120], 255);
	TextDrawFont(gagepoint[1][120], 1);
	TextDrawLetterSize(gagepoint[1][120], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][120], 8388863);
	TextDrawSetOutline(gagepoint[1][120], 0);
	TextDrawSetProportional(gagepoint[1][120], 1);
	TextDrawSetShadow(gagepoint[1][120], 1);

	gagepoint[2][120] = TextDrawCreate(545.000000, 377.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][120], 255);
	TextDrawFont(gagepoint[2][120], 1);
	TextDrawLetterSize(gagepoint[2][120], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][120], 8388863);
	TextDrawSetOutline(gagepoint[2][120], 0);
	TextDrawSetProportional(gagepoint[2][120], 1);
	TextDrawSetShadow(gagepoint[2][120], 1);

	gagepoint[3][120] = TextDrawCreate(549.000000, 362.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][120], 255);
	TextDrawFont(gagepoint[3][120], 1);
	TextDrawLetterSize(gagepoint[3][120], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][120], 8388863);
	TextDrawSetOutline(gagepoint[3][120], 0);
	TextDrawSetProportional(gagepoint[3][120], 1);
	TextDrawSetShadow(gagepoint[3][120], 1);
	//--------------------125----------------------------------
    gagepoint[0][125] = TextDrawCreate(540.000000, 403.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][125], 255);
	TextDrawFont(gagepoint[0][125], 1);
	TextDrawLetterSize(gagepoint[0][125], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][125], 8388863);
	TextDrawSetOutline(gagepoint[0][125], 0);
	TextDrawSetProportional(gagepoint[0][125], 1);
	TextDrawSetShadow(gagepoint[0][125], 1);

	gagepoint[1][125] = TextDrawCreate(544.000000, 390.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][125], 255);
	TextDrawFont(gagepoint[1][125], 1);
	TextDrawLetterSize(gagepoint[1][125], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][125], 8388863);
	TextDrawSetOutline(gagepoint[1][125], 0);
	TextDrawSetProportional(gagepoint[1][125], 1);
	TextDrawSetShadow(gagepoint[1][125], 1);

	gagepoint[2][125] = TextDrawCreate(548.000000, 378.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][125], 255);
	TextDrawFont(gagepoint[2][125], 1);
	TextDrawLetterSize(gagepoint[2][125], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][125], 8388863);
	TextDrawSetOutline(gagepoint[2][125], 0);
	TextDrawSetProportional(gagepoint[2][125], 1);
	TextDrawSetShadow(gagepoint[2][125], 1);

	gagepoint[3][125] = TextDrawCreate(553.000000, 364.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][125], 255);
	TextDrawFont(gagepoint[3][125], 1);
	TextDrawLetterSize(gagepoint[3][125], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][125], 8388863);
	TextDrawSetOutline(gagepoint[3][125], 0);
	TextDrawSetProportional(gagepoint[3][125], 1);
	TextDrawSetShadow(gagepoint[3][125], 1);
	//--------------------130----------------------------------
	gagepoint[0][130] = TextDrawCreate(541.000000, 404.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][130], 255);
	TextDrawFont(gagepoint[0][130], 1);
	TextDrawLetterSize(gagepoint[0][130], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][130], 8388863);
	TextDrawSetOutline(gagepoint[0][130], 0);
	TextDrawSetProportional(gagepoint[0][130], 1);
	TextDrawSetShadow(gagepoint[0][130], 1);

	gagepoint[1][130] = TextDrawCreate(545.000000, 391.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][130], 255);
	TextDrawFont(gagepoint[1][130], 1);
	TextDrawLetterSize(gagepoint[1][130], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][130], 8388863);
	TextDrawSetOutline(gagepoint[1][130], 0);
	TextDrawSetProportional(gagepoint[1][130], 1);
	TextDrawSetShadow(gagepoint[1][130], 1);

	gagepoint[2][130] = TextDrawCreate(550.000000, 379.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][130], 255);
	TextDrawFont(gagepoint[2][130], 1);
	TextDrawLetterSize(gagepoint[2][130], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][130], 8388863);
	TextDrawSetOutline(gagepoint[2][130], 0);
	TextDrawSetProportional(gagepoint[2][130], 1);
	TextDrawSetShadow(gagepoint[2][130], 1);

	gagepoint[3][130] = TextDrawCreate(556.000000, 366.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][130], 255);
	TextDrawFont(gagepoint[3][130], 1);
	TextDrawLetterSize(gagepoint[3][130], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][130], 8388863);
	TextDrawSetOutline(gagepoint[3][130], 0);
	TextDrawSetProportional(gagepoint[3][130], 1);
	TextDrawSetShadow(gagepoint[3][130], 1);
	//--------------------135----------------------------------
    gagepoint[0][135] = TextDrawCreate(541.000000, 404.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][135], 255);
	TextDrawFont(gagepoint[0][135], 1);
	TextDrawLetterSize(gagepoint[0][135], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][135], 8388863);
	TextDrawSetOutline(gagepoint[0][135], 0);
	TextDrawSetProportional(gagepoint[0][135], 1);
	TextDrawSetShadow(gagepoint[0][135], 1);

	gagepoint[1][135] = TextDrawCreate(547.000000, 392.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][135], 255);
	TextDrawFont(gagepoint[1][135], 1);
	TextDrawLetterSize(gagepoint[1][135], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][135], 8388863);
	TextDrawSetOutline(gagepoint[1][135], 0);
	TextDrawSetProportional(gagepoint[1][135], 1);
	TextDrawSetShadow(gagepoint[1][135], 1);

	gagepoint[2][135] = TextDrawCreate(552.000000, 381.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][135], 255);
	TextDrawFont(gagepoint[2][135], 1);
	TextDrawLetterSize(gagepoint[2][135], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][135], 8388863);
	TextDrawSetOutline(gagepoint[2][135], 0);
	TextDrawSetProportional(gagepoint[2][135], 1);
	TextDrawSetShadow(gagepoint[2][135], 1);

	gagepoint[3][135] = TextDrawCreate(558.000000, 369.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][135], 255);
	TextDrawFont(gagepoint[3][135], 1);
	TextDrawLetterSize(gagepoint[3][135], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][135], 8388863);
	TextDrawSetOutline(gagepoint[3][135], 0);
	TextDrawSetProportional(gagepoint[3][135], 1);
	TextDrawSetShadow(gagepoint[3][135], 1);
	//--------------------140----------------------------------
    gagepoint[0][140] = TextDrawCreate(541.000000, 405.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][140], 255);
	TextDrawFont(gagepoint[0][140], 1);
	TextDrawLetterSize(gagepoint[0][140], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][140], 8388863);
	TextDrawSetOutline(gagepoint[0][140], 0);
	TextDrawSetProportional(gagepoint[0][140], 1);
	TextDrawSetShadow(gagepoint[0][140], 1);

	gagepoint[1][140] = TextDrawCreate(549.000000, 394.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][140], 255);
	TextDrawFont(gagepoint[1][140], 1);
	TextDrawLetterSize(gagepoint[1][140], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][140], 8388863);
	TextDrawSetOutline(gagepoint[1][140], 0);
	TextDrawSetProportional(gagepoint[1][140], 1);
	TextDrawSetShadow(gagepoint[1][140], 1);

	gagepoint[2][140] = TextDrawCreate(555.000000, 383.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][140], 255);
	TextDrawFont(gagepoint[2][140], 1);
	TextDrawLetterSize(gagepoint[2][140], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][140], 8388863);
	TextDrawSetOutline(gagepoint[2][140], 0);
	TextDrawSetProportional(gagepoint[2][140], 1);
	TextDrawSetShadow(gagepoint[2][140], 1);

	gagepoint[3][140] = TextDrawCreate(562.000000, 373.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][140], 255);
	TextDrawFont(gagepoint[3][140], 1);
	TextDrawLetterSize(gagepoint[3][140], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][140], 8388863);
	TextDrawSetOutline(gagepoint[3][140], 0);
	TextDrawSetProportional(gagepoint[3][140], 1);
	TextDrawSetShadow(gagepoint[3][140], 1);
	//--------------------145----------------------------------
    gagepoint[0][145] = TextDrawCreate(542.000000, 407.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][145], 255);
	TextDrawFont(gagepoint[0][145], 1);
	TextDrawLetterSize(gagepoint[0][145], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][145], 8388863);
	TextDrawSetOutline(gagepoint[0][145], 0);
	TextDrawSetProportional(gagepoint[0][145], 1);
	TextDrawSetShadow(gagepoint[0][145], 1);

	gagepoint[1][145] = TextDrawCreate(550.000000, 397.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][145], 255);
	TextDrawFont(gagepoint[1][145], 1);
	TextDrawLetterSize(gagepoint[1][145], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][145], 8388863);
	TextDrawSetOutline(gagepoint[1][145], 0);
	TextDrawSetProportional(gagepoint[1][145], 1);
	TextDrawSetShadow(gagepoint[1][145], 1);

	gagepoint[2][145] = TextDrawCreate(558.000000, 386.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][145], 255);
	TextDrawFont(gagepoint[2][145], 1);
	TextDrawLetterSize(gagepoint[2][145], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][145], 8388863);
	TextDrawSetOutline(gagepoint[2][145], 0);
	TextDrawSetProportional(gagepoint[2][145], 1);
	TextDrawSetShadow(gagepoint[2][145], 1);

	gagepoint[3][145] = TextDrawCreate(566.000000, 376.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][145], 255);
	TextDrawFont(gagepoint[3][145], 1);
	TextDrawLetterSize(gagepoint[3][145], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][145], 8388863);
	TextDrawSetOutline(gagepoint[3][145], 0);
	TextDrawSetProportional(gagepoint[3][145], 1);
	TextDrawSetShadow(gagepoint[3][145], 1);
	//--------------------150----------------------------------
    gagepoint[0][150] = TextDrawCreate(542.000000, 407.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][150], 255);
	TextDrawFont(gagepoint[0][150], 1);
	TextDrawLetterSize(gagepoint[0][150], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][150], 8388863);
	TextDrawSetOutline(gagepoint[0][150], 0);
	TextDrawSetProportional(gagepoint[0][150], 1);
	TextDrawSetShadow(gagepoint[0][150], 1);

	gagepoint[1][150] = TextDrawCreate(551.000000, 398.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][150], 255);
	TextDrawFont(gagepoint[1][150], 1);
	TextDrawLetterSize(gagepoint[1][150], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][150], 8388863);
	TextDrawSetOutline(gagepoint[1][150], 0);
	TextDrawSetProportional(gagepoint[1][150], 1);
	TextDrawSetShadow(gagepoint[1][150], 1);

	gagepoint[2][150] = TextDrawCreate(560.000000, 388.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][150], 255);
	TextDrawFont(gagepoint[2][150], 1);
	TextDrawLetterSize(gagepoint[2][150], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][150], 8388863);
	TextDrawSetOutline(gagepoint[2][150], 0);
	TextDrawSetProportional(gagepoint[2][150], 1);
	TextDrawSetShadow(gagepoint[2][150], 1);

	gagepoint[3][150] = TextDrawCreate(569.000000, 378.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][150], 255);
	TextDrawFont(gagepoint[3][150], 1);
	TextDrawLetterSize(gagepoint[3][150], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][150], 8388863);
	TextDrawSetOutline(gagepoint[3][150], 0);
	TextDrawSetProportional(gagepoint[3][150], 1);
	TextDrawSetShadow(gagepoint[3][150], 1);
	//--------------------155----------------------------------
	gagepoint[0][155] = TextDrawCreate(545.000000, 408.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][155], 255);
	TextDrawFont(gagepoint[0][155], 1);
	TextDrawLetterSize(gagepoint[0][155], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][155], 8388863);
	TextDrawSetOutline(gagepoint[0][155], 0);
	TextDrawSetProportional(gagepoint[0][155], 1);
	TextDrawSetShadow(gagepoint[0][155], 1);

	gagepoint[1][155] = TextDrawCreate(553.000000, 400.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][155], 255);
	TextDrawFont(gagepoint[1][155], 1);
	TextDrawLetterSize(gagepoint[1][155], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][155], 8388863);
	TextDrawSetOutline(gagepoint[1][155], 0);
	TextDrawSetProportional(gagepoint[1][155], 1);
	TextDrawSetShadow(gagepoint[1][155], 1);

	gagepoint[2][155] = TextDrawCreate(563.000000, 390.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][155], 255);
	TextDrawFont(gagepoint[2][155], 1);
	TextDrawLetterSize(gagepoint[2][155], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][155], 8388863);
	TextDrawSetOutline(gagepoint[2][155], 0);
	TextDrawSetProportional(gagepoint[2][155], 1);
	TextDrawSetShadow(gagepoint[2][155], 1);

	gagepoint[3][155] = TextDrawCreate(573.000000, 380.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][155], 255);
	TextDrawFont(gagepoint[3][155], 1);
	TextDrawLetterSize(gagepoint[3][155], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][155], 8388863);
	TextDrawSetOutline(gagepoint[3][155], 0);
	TextDrawSetProportional(gagepoint[3][155], 1);
	TextDrawSetShadow(gagepoint[3][155], 1);
	//--------------------160----------------------------------
	gagepoint[0][160] = TextDrawCreate(545.000000, 408.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][160], 255);
	TextDrawFont(gagepoint[0][160], 1);
	TextDrawLetterSize(gagepoint[0][160], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][160], 8388863);
	TextDrawSetOutline(gagepoint[0][160], 0);
	TextDrawSetProportional(gagepoint[0][160], 1);
	TextDrawSetShadow(gagepoint[0][160], 1);

	gagepoint[1][160] = TextDrawCreate(555.000000, 401.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][160], 255);
	TextDrawFont(gagepoint[1][160], 1);
	TextDrawLetterSize(gagepoint[1][160], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][160], 8388863);
	TextDrawSetOutline(gagepoint[1][160], 0);
	TextDrawSetProportional(gagepoint[1][160], 1);
	TextDrawSetShadow(gagepoint[1][160], 1);

	gagepoint[2][160] = TextDrawCreate(566.000000, 393.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][160], 255);
	TextDrawFont(gagepoint[2][160], 1);
	TextDrawLetterSize(gagepoint[2][160], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][160], 8388863);
	TextDrawSetOutline(gagepoint[2][160], 0);
	TextDrawSetProportional(gagepoint[2][160], 1);
	TextDrawSetShadow(gagepoint[2][160], 1);

	gagepoint[3][160] = TextDrawCreate(577.000000, 386.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][160], 255);
	TextDrawFont(gagepoint[3][160], 1);
	TextDrawLetterSize(gagepoint[3][160], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][160], 8388863);
	TextDrawSetOutline(gagepoint[3][160], 0);
	TextDrawSetProportional(gagepoint[3][160], 1);
	TextDrawSetShadow(gagepoint[3][160], 1);
	//--------------------165----------------------------------
    gagepoint[0][165] = TextDrawCreate(545.000000, 409.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][165], 255);
	TextDrawFont(gagepoint[0][165], 1);
	TextDrawLetterSize(gagepoint[0][165], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][165], 8388863);
	TextDrawSetOutline(gagepoint[0][165], 0);
	TextDrawSetProportional(gagepoint[0][165], 1);
	TextDrawSetShadow(gagepoint[0][165], 1);

	gagepoint[1][165] = TextDrawCreate(555.000000, 403.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][165], 255);
	TextDrawFont(gagepoint[1][165], 1);
	TextDrawLetterSize(gagepoint[1][165], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][165], 8388863);
	TextDrawSetOutline(gagepoint[1][165], 0);
	TextDrawSetProportional(gagepoint[1][165], 1);
	TextDrawSetShadow(gagepoint[1][165], 1);

	gagepoint[2][165] = TextDrawCreate(566.000000, 396.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][165], 255);
	TextDrawFont(gagepoint[2][165], 1);
	TextDrawLetterSize(gagepoint[2][165], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][165], 8388863);
	TextDrawSetOutline(gagepoint[2][165], 0);
	TextDrawSetProportional(gagepoint[2][165], 1);
	TextDrawSetShadow(gagepoint[2][165], 1);

	gagepoint[3][165] = TextDrawCreate(577.000000, 390.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][165], 255);
	TextDrawFont(gagepoint[3][165], 1);
	TextDrawLetterSize(gagepoint[3][165], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][165], 8388863);
	TextDrawSetOutline(gagepoint[3][165], 0);
	TextDrawSetProportional(gagepoint[3][165], 1);
	TextDrawSetShadow(gagepoint[3][165], 1);
	//--------------------170----------------------------------
    gagepoint[0][170] = TextDrawCreate(546.000000, 409.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][170], 255);
	TextDrawFont(gagepoint[0][170], 1);
	TextDrawLetterSize(gagepoint[0][170], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][170], 8388863);
	TextDrawSetOutline(gagepoint[0][170], 0);
	TextDrawSetProportional(gagepoint[0][170], 1);
	TextDrawSetShadow(gagepoint[0][170], 1);

	gagepoint[1][170] = TextDrawCreate(555.000000, 404.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][170], 255);
	TextDrawFont(gagepoint[1][170], 1);
	TextDrawLetterSize(gagepoint[1][170], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][170], 8388863);
	TextDrawSetOutline(gagepoint[1][170], 0);
	TextDrawSetProportional(gagepoint[1][170], 1);
	TextDrawSetShadow(gagepoint[1][170], 1);

	gagepoint[2][170] = TextDrawCreate(566.000000, 398.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][170], 255);
	TextDrawFont(gagepoint[2][170], 1);
	TextDrawLetterSize(gagepoint[2][170], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][170], 8388863);
	TextDrawSetOutline(gagepoint[2][170], 0);
	TextDrawSetProportional(gagepoint[2][170], 1);
	TextDrawSetShadow(gagepoint[2][170], 1);

	gagepoint[3][170] = TextDrawCreate(577.000000, 392.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][170], 255);
	TextDrawFont(gagepoint[3][170], 1);
	TextDrawLetterSize(gagepoint[3][170], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][170], 8388863);
	TextDrawSetOutline(gagepoint[3][170], 0);
	TextDrawSetProportional(gagepoint[3][170], 1);
	TextDrawSetShadow(gagepoint[3][170], 1);
	//--------------------175----------------------------------
    gagepoint[0][175] = TextDrawCreate(546.000000, 411.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][175], 255);
	TextDrawFont(gagepoint[0][175], 1);
	TextDrawLetterSize(gagepoint[0][175], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][175], 8388863);
	TextDrawSetOutline(gagepoint[0][175], 0);
	TextDrawSetProportional(gagepoint[0][175], 1);
	TextDrawSetShadow(gagepoint[0][175], 1);

	gagepoint[1][175] = TextDrawCreate(555.000000, 406.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][175], 255);
	TextDrawFont(gagepoint[1][175], 1);
	TextDrawLetterSize(gagepoint[1][175], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][175], 8388863);
	TextDrawSetOutline(gagepoint[1][175], 0);
	TextDrawSetProportional(gagepoint[1][175], 1);
	TextDrawSetShadow(gagepoint[1][175], 1);

	gagepoint[2][175] = TextDrawCreate(564.000000, 401.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][175], 255);
	TextDrawFont(gagepoint[2][175], 1);
	TextDrawLetterSize(gagepoint[2][175], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][175], 8388863);
	TextDrawSetOutline(gagepoint[2][175], 0);
	TextDrawSetProportional(gagepoint[2][175], 1);
	TextDrawSetShadow(gagepoint[2][175], 1);

	gagepoint[3][175] = TextDrawCreate(576.000000, 395.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][175], 255);
	TextDrawFont(gagepoint[3][175], 1);
	TextDrawLetterSize(gagepoint[3][175], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][175], 8388863);
	TextDrawSetOutline(gagepoint[3][175], 0);
	TextDrawSetProportional(gagepoint[3][175], 1);
	TextDrawSetShadow(gagepoint[3][175], 1);
	//--------------------180----------------------------------
	gagepoint[0][180] = TextDrawCreate(546.000000, 412.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][180], 255);
	TextDrawFont(gagepoint[0][180], 1);
	TextDrawLetterSize(gagepoint[0][180], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][180], 8388863);
	TextDrawSetOutline(gagepoint[0][180], 0);
	TextDrawSetProportional(gagepoint[0][180], 1);
	TextDrawSetShadow(gagepoint[0][180], 1);

	gagepoint[1][180] = TextDrawCreate(558.000000, 408.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][180], 255);
	TextDrawFont(gagepoint[1][180], 1);
	TextDrawLetterSize(gagepoint[1][180], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][180], 8388863);
	TextDrawSetOutline(gagepoint[1][180], 0);
	TextDrawSetProportional(gagepoint[1][180], 1);
	TextDrawSetShadow(gagepoint[1][180], 1);

	gagepoint[2][180] = TextDrawCreate(570.000000, 404.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][180], 255);
	TextDrawFont(gagepoint[2][180], 1);
	TextDrawLetterSize(gagepoint[2][180], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][180], 8388863);
	TextDrawSetOutline(gagepoint[2][180], 0);
	TextDrawSetProportional(gagepoint[2][180], 1);
	TextDrawSetShadow(gagepoint[2][180], 1);

	gagepoint[3][180] = TextDrawCreate(582.000000, 400.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][180], 255);
	TextDrawFont(gagepoint[3][180], 1);
	TextDrawLetterSize(gagepoint[3][180], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][180], 8388863);
	TextDrawSetOutline(gagepoint[3][180], 0);
	TextDrawSetProportional(gagepoint[3][180], 1);
	TextDrawSetShadow(gagepoint[3][180], 1);
	//--------------------185----------------------------------
    gagepoint[0][185] = TextDrawCreate(548.000000, 412.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][185], 255);
	TextDrawFont(gagepoint[0][185], 1);
	TextDrawLetterSize(gagepoint[0][185], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][185], 8388863);
	TextDrawSetOutline(gagepoint[0][185], 0);
	TextDrawSetProportional(gagepoint[0][185], 1);
	TextDrawSetShadow(gagepoint[0][185], 1);

	gagepoint[1][185] = TextDrawCreate(559.000000, 409.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][185], 255);
	TextDrawFont(gagepoint[1][185], 1);
	TextDrawLetterSize(gagepoint[1][185], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][185], 8388863);
	TextDrawSetOutline(gagepoint[1][185], 0);
	TextDrawSetProportional(gagepoint[1][185], 1);
	TextDrawSetShadow(gagepoint[1][185], 1);

	gagepoint[2][185] = TextDrawCreate(571.000000, 406.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][185], 255);
	TextDrawFont(gagepoint[2][185], 1);
	TextDrawLetterSize(gagepoint[2][185], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][185], 8388863);
	TextDrawSetOutline(gagepoint[2][185], 0);
	TextDrawSetProportional(gagepoint[2][185], 1);
	TextDrawSetShadow(gagepoint[2][185], 1);

	gagepoint[3][185] = TextDrawCreate(584.000000, 403.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][185], 255);
	TextDrawFont(gagepoint[3][185], 1);
	TextDrawLetterSize(gagepoint[3][185], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][185], 8388863);
	TextDrawSetOutline(gagepoint[3][185], 0);
	TextDrawSetProportional(gagepoint[3][185], 1);
	TextDrawSetShadow(gagepoint[3][185], 1);
	//--------------------190----------------------------------
    gagepoint[0][190] = TextDrawCreate(548.000000, 413.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][190], 255);
	TextDrawFont(gagepoint[0][190], 1);
	TextDrawLetterSize(gagepoint[0][190], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][190], 8388863);
	TextDrawSetOutline(gagepoint[0][190], 0);
	TextDrawSetProportional(gagepoint[0][190], 1);
	TextDrawSetShadow(gagepoint[0][190], 1);

	gagepoint[1][190] = TextDrawCreate(560.000000, 411.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][190], 255);
	TextDrawFont(gagepoint[1][190], 1);
	TextDrawLetterSize(gagepoint[1][190], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][190], 8388863);
	TextDrawSetOutline(gagepoint[1][190], 0);
	TextDrawSetProportional(gagepoint[1][190], 1);
	TextDrawSetShadow(gagepoint[1][190], 1);

	gagepoint[2][190] = TextDrawCreate(572.000000, 409.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][190], 255);
	TextDrawFont(gagepoint[2][190], 1);
	TextDrawLetterSize(gagepoint[2][190], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][190], 8388863);
	TextDrawSetOutline(gagepoint[2][190], 0);
	TextDrawSetProportional(gagepoint[2][190], 1);
	TextDrawSetShadow(gagepoint[2][190], 1);

	gagepoint[3][190] = TextDrawCreate(586.000000, 407.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][190], 255);
	TextDrawFont(gagepoint[3][190], 1);
	TextDrawLetterSize(gagepoint[3][190], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][190], 8388863);
	TextDrawSetOutline(gagepoint[3][190], 0);
	TextDrawSetProportional(gagepoint[3][190], 1);
	TextDrawSetShadow(gagepoint[3][190], 1);
	//--------------------195----------------------------------
    gagepoint[0][195] = TextDrawCreate(548.000000, 413.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][195], 255);
	TextDrawFont(gagepoint[0][195], 1);
	TextDrawLetterSize(gagepoint[0][195], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][195], 8388863);
	TextDrawSetOutline(gagepoint[0][195], 0);
	TextDrawSetProportional(gagepoint[0][195], 1);
	TextDrawSetShadow(gagepoint[0][195], 1);

	gagepoint[1][195] = TextDrawCreate(560.000000, 412.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][195], 255);
	TextDrawFont(gagepoint[1][195], 1);
	TextDrawLetterSize(gagepoint[1][195], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][195], 8388863);
	TextDrawSetOutline(gagepoint[1][195], 0);
	TextDrawSetProportional(gagepoint[1][195], 1);
	TextDrawSetShadow(gagepoint[1][195], 1);

	gagepoint[2][195] = TextDrawCreate(572.000000, 411.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][195], 255);
	TextDrawFont(gagepoint[2][195], 1);
	TextDrawLetterSize(gagepoint[2][195], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][195], 8388863);
	TextDrawSetOutline(gagepoint[2][195], 0);
	TextDrawSetProportional(gagepoint[2][195], 1);
	TextDrawSetShadow(gagepoint[2][195], 1);

	gagepoint[3][195] = TextDrawCreate(585.000000, 410.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][195], 255);
	TextDrawFont(gagepoint[3][195], 1);
	TextDrawLetterSize(gagepoint[3][195], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][195], 8388863);
	TextDrawSetOutline(gagepoint[3][195], 0);
	TextDrawSetProportional(gagepoint[3][195], 1);
	TextDrawSetShadow(gagepoint[3][195], 1);
	//--------------------200----------------------------------
	gagepoint[0][200] = TextDrawCreate(548.000000, 414.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][200], 255);
	TextDrawFont(gagepoint[0][200], 1);
	TextDrawLetterSize(gagepoint[0][200], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][200], 8388863);
	TextDrawSetOutline(gagepoint[0][200], 0);
	TextDrawSetProportional(gagepoint[0][200], 1);
	TextDrawSetShadow(gagepoint[0][200], 1);

	gagepoint[1][200] = TextDrawCreate(560.000000, 414.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][200], 255);
	TextDrawFont(gagepoint[1][200], 1);
	TextDrawLetterSize(gagepoint[1][200], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][200], 8388863);
	TextDrawSetOutline(gagepoint[1][200], 0);
	TextDrawSetProportional(gagepoint[1][200], 1);
	TextDrawSetShadow(gagepoint[1][200], 1);

	gagepoint[2][200] = TextDrawCreate(572.000000, 414.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][200], 255);
	TextDrawFont(gagepoint[2][200], 1);
	TextDrawLetterSize(gagepoint[2][200], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][200], 8388863);
	TextDrawSetOutline(gagepoint[2][200], 0);
	TextDrawSetProportional(gagepoint[2][200], 1);
	TextDrawSetShadow(gagepoint[2][200], 1);

	gagepoint[3][200] = TextDrawCreate(585.000000, 414.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][200], 255);
	TextDrawFont(gagepoint[3][200], 1);
	TextDrawLetterSize(gagepoint[3][200], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][200], 8388863);
	TextDrawSetOutline(gagepoint[3][200], 0);
	TextDrawSetProportional(gagepoint[3][200], 1);
	TextDrawSetShadow(gagepoint[3][200], 1);
	//--------------------205++---------------------------------
	gagepoint[0][205] = TextDrawCreate(548.000000, 415.000000, ".");
	TextDrawBackgroundColor(gagepoint[0][205], 255);
	TextDrawFont(gagepoint[0][205], 1);
	TextDrawLetterSize(gagepoint[0][205], 0.500000, 1.000000);
	TextDrawColor(gagepoint[0][205], -16776961);
	TextDrawSetOutline(gagepoint[0][205], 0);
	TextDrawSetProportional(gagepoint[0][205], 1);
	TextDrawSetShadow(gagepoint[0][205], 1);

	gagepoint[1][205] = TextDrawCreate(560.000000, 416.000000, ".");
	TextDrawBackgroundColor(gagepoint[1][205], 255);
	TextDrawFont(gagepoint[1][205], 1);
	TextDrawLetterSize(gagepoint[1][205], 0.500000, 1.000000);
	TextDrawColor(gagepoint[1][205], -16776961);
	TextDrawSetOutline(gagepoint[1][205], 0);
	TextDrawSetProportional(gagepoint[1][205], 1);
	TextDrawSetShadow(gagepoint[1][205], 1);

	gagepoint[2][205] = TextDrawCreate(573.000000, 417.000000, ".");
	TextDrawBackgroundColor(gagepoint[2][205], 255);
	TextDrawFont(gagepoint[2][205], 1);
	TextDrawLetterSize(gagepoint[2][205], 0.500000, 1.000000);
	TextDrawColor(gagepoint[2][205], -16776961);
	TextDrawSetOutline(gagepoint[2][205], 0);
	TextDrawSetProportional(gagepoint[2][205], 1);
	TextDrawSetShadow(gagepoint[2][205], 1);

	gagepoint[3][205] = TextDrawCreate(587.000000, 418.000000, ".");
	TextDrawBackgroundColor(gagepoint[3][205], 255);
	TextDrawFont(gagepoint[3][205], 1);
	TextDrawLetterSize(gagepoint[3][205], 0.500000, 1.000000);
	TextDrawColor(gagepoint[3][205], -16776961);
	TextDrawSetOutline(gagepoint[3][205], 0);
	TextDrawSetProportional(gagepoint[3][205], 1);
	TextDrawSetShadow(gagepoint[3][205], 1);
}
GageOn(playerid,vehicleid)
{
	new string[256];
	new speed = GetVehicleSpeed(vehicleid);
    new editspeed = RoundSpeed(speed);
	//------------------------------------------------------------------------------------------------
	textlocked[vehicleid] = TextDrawCreate(599.000000, 428.000000, "-");
	TextDrawBackgroundColor(textlocked[vehicleid], 255);
	TextDrawFont(textlocked[vehicleid], 1);
	TextDrawLetterSize(textlocked[vehicleid], 0.230000, 0.899999);
	TextDrawColor(textlocked[vehicleid], -1);
	TextDrawSetOutline(textlocked[vehicleid], 0);
	TextDrawSetProportional(textlocked[vehicleid], 1);
	TextDrawSetShadow(textlocked[vehicleid], 1);
	
	if((carstate[jbcarid[vehicleid]])==1)
	{
		if((carlock[jbcarid[vehicleid]])==1)
		{
		    TextDrawSetString(textlocked[vehicleid],"Locked");
		}
		else
		{
		    TextDrawSetString(textlocked[vehicleid],"Un-Locked");
		}
	}
	else
	{
		TextDrawSetString(textlocked[vehicleid],"Un-Locked");
	}
	//-------------------------------------------------------------------------------------------------
	format(string,sizeof(string),"Distence: %i KM/H",floatround(totaldistence[vehicleid]));
    gagedistance[vehicleid] = TextDrawCreate(488.000000, 335.000000, string);
	TextDrawBackgroundColor(gagedistance[vehicleid], 255);
	TextDrawFont(gagedistance[vehicleid], 1);
	TextDrawLetterSize(gagedistance[vehicleid], 0.230000, 0.799999);
	TextDrawColor(gagedistance[vehicleid], -1);
	TextDrawSetOutline(gagedistance[vehicleid], 0);
	TextDrawSetProportional(gagedistance[vehicleid], 1);
	TextDrawSetShadow(gagedistance[vehicleid], 1);

    format(string,sizeof(string),"Speed: %i KM/H",speed);
	gagespeed[vehicleid] = TextDrawCreate(476.000000, 428.000000, string);
	TextDrawBackgroundColor(gagespeed[vehicleid], 255);
	TextDrawFont(gagespeed[vehicleid], 1);
	TextDrawLetterSize(gagespeed[vehicleid], 0.280003, 0.899996);
	TextDrawColor(gagespeed[vehicleid], -754974721);
	TextDrawSetOutline(gagespeed[vehicleid], 0);
	TextDrawSetProportional(gagespeed[vehicleid], 1);
	TextDrawSetShadow(gagespeed[vehicleid], 1);

    format(string,sizeof(string),"Fuel: %i",floatround(fuel[vehicleid]));
	gagefuel[vehicleid] = TextDrawCreate(550.000000, 428.000000, string);
	TextDrawBackgroundColor(gagefuel[vehicleid], 255);
	TextDrawFont(gagefuel[vehicleid], 1);
	TextDrawLetterSize(gagefuel[vehicleid], 0.280003, 0.899996);
	TextDrawColor(gagefuel[vehicleid], -754974721);
	TextDrawSetOutline(gagefuel[vehicleid], 0);
	TextDrawSetProportional(gagefuel[vehicleid], 1);
	TextDrawSetShadow(gagefuel[vehicleid], 1);

	//-----------------bars------------------
	barhealth[vehicleid] = CreateProgressBar(481.00, 441.00, 62.50, 1.50, -16776961, 1000.0);
	barfuel[vehicleid] = CreateProgressBar(554.00, 440.00, 75.50, 3.20, 108623615, 100.0);
	//-------------------------------------------------------------------------------------------------
 	for(new count;count < 11;count++)
	{
	     TextDrawShowForPlayer(playerid,gagespeedlabels[count]);
	}
	if((totaledvehicle[vehicleid])==1)
	{
	    TextDrawShowForPlayer(playerid,texttotaledcar);
	}
	TextDrawShowForPlayer(playerid,gagedistance[vehicleid]);
	TextDrawShowForPlayer(playerid,textlocked[vehicleid]);
 	TextDrawShowForPlayer(playerid,gagecenterpoint);
    TextDrawShowForPlayer(playerid,gagespeed[vehicleid]);
    TextDrawShowForPlayer(playerid,gagefuel[vehicleid]);
    TextDrawShowForPlayer(playerid,gagehealth);
    ShowProgressBarForPlayer(playerid,barhealth[vehicleid]);
    ShowProgressBarForPlayer(playerid,barfuel[vehicleid]);
    SetProgressBarValue(barfuel[vehicleid],fuel[vehicleid]);
    UpdateProgressBar(barfuel[vehicleid],playerid);
	new Float:health;
	GetVehicleHealth(vehicleid,health);
    SetProgressBarValue(barhealth[vehicleid],health);
    UpdateProgressBar(barhealth[vehicleid],playerid);
	for(new count; count < 4;count++)
	{
	    TextDrawShowForPlayer(playerid,gagepoint[count][editspeed]);
	}
	gagelastspeed[vehicleid] = editspeed;
    gagetimer[playerid] = SetTimerEx("GageChange",200,true,"ii",playerid,vehicleid);
}
GageOff(playerid,vehicleid)
{
	for(new count; count < 4;count++)
	{
    	TextDrawHideForPlayer(playerid,gagepoint[count][gagelastspeed[vehicleid]]);
	}
	for(new count; count < 11;count++)
	{
	    TextDrawHideForPlayer(playerid,gagespeedlabels[count]);
	}
	if((totaledvehicle[vehicleid])==1)
	{
	    TextDrawHideForPlayer(playerid,texttotaledcar);
	}
	TextDrawHideForPlayer(playerid,gagedistance[vehicleid]);
	TextDrawHideForPlayer(playerid,textlocked[vehicleid]);
	TextDrawHideForPlayer(playerid,gagecenterpoint);
    TextDrawHideForPlayer(playerid,gagespeed[vehicleid]);
    TextDrawHideForPlayer(playerid,gagefuel[vehicleid]);
    TextDrawHideForPlayer(playerid,gagehealth);
    HideProgressBarForPlayer(playerid,barhealth[vehicleid]);
    HideProgressBarForPlayer(playerid,barfuel[vehicleid]);
	//-------------------------------------------------------------------------------------------------
    DestroyProgressBar(barhealth[vehicleid]);
	DestroyProgressBar(barfuel[vehicleid]);
	TextDrawDestroy(gagespeed[vehicleid]);
 	TextDrawDestroy(gagefuel[vehicleid]);
 	TextDrawDestroy(textlocked[vehicleid]);
 	KillTimer(gagetimer[playerid]);
 	//-------------------------------------------------------------------------------------------------
}
//This script has been edited by me but is originaly owned by --
#define MAX_SPIKESTRIPS MAX_BLOCKS

enum sInfo
{
	sCreated,
    Float:sX,
    Float:sY,
    Float:sZ,
    sObject,
};
new SpikeInfo[MAX_SPIKESTRIPS][sInfo];

public OnPlayerUpdate(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;

    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        for(new i = 0; i < sizeof(SpikeInfo); i++)
  	    {
  	        if(IsPlayerInRangeOfPoint(playerid, 3.0, SpikeInfo[i][sX], SpikeInfo[i][sY], SpikeInfo[i][sZ]))
            {
  	            if(SpikeInfo[i][sCreated] == 1)
  	            {
  	                new panels, doors, lights, tires;
  	                new carid = GetPlayerVehicleID(playerid);
		            GetVehicleDamageStatus(carid, panels, doors, lights, tires);
		            tires = encode_tires(1, 1, 1, 1);
		            UpdateVehicleDamageStatus(carid, panels, doors, lights, tires);
  	                return 0;
  	            }
  	        }
  	    }
  	}

	return 1;
}

stock CreateStrip(Float:x,Float:y,Float:z,Float:Angle)
{
    for(new i = 0; i < sizeof(SpikeInfo); i++)
  	{
  	    if(SpikeInfo[i][sCreated] == 0)
  	    {
            SpikeInfo[i][sCreated]=1;
            SpikeInfo[i][sX]=x;
            SpikeInfo[i][sY]=y;
            SpikeInfo[i][sZ]=z-0.7;
            SpikeInfo[i][sObject] = CreateDynamicObject(2899, x, y, z-0.9, 0, 0, Angle-90,-1,-1,-1,200.0,300.0);
	        return i;
  	    }
  	}
  	return -1;
}

stock DeleteAllStrip()
{
    for(new i = 0; i < sizeof(SpikeInfo); i++)
  	{
  	    if(SpikeInfo[i][sCreated] == 1)
  	    {
  	        SpikeInfo[i][sCreated]=0;
            SpikeInfo[i][sX]=0.0;
            SpikeInfo[i][sY]=0.0;
            SpikeInfo[i][sZ]=0.0;
            DestroyDynamicObject(SpikeInfo[i][sObject]);
  	    }
	}
    return 0;
}

stock DeleteClosestStrip(playerid)
{
    for(new i = 0; i < sizeof(SpikeInfo); i++)
  	{
  	    if(IsPlayerInRangeOfPoint(playerid, 2.0, SpikeInfo[i][sX], SpikeInfo[i][sY], SpikeInfo[i][sZ]))
        {
  	        if(SpikeInfo[i][sCreated] == 1)
            {
                SpikeInfo[i][sCreated]=0;
                SpikeInfo[i][sX]=0.0;
                SpikeInfo[i][sY]=0.0;
                SpikeInfo[i][sZ]=0.0;
                DestroyDynamicObject(SpikeInfo[i][sObject]);
                return 1;
  	        }
  	    }
  	}
    return 0;
}
stock DeleteStrip(spikeid)
{
	if(SpikeInfo[spikeid][sCreated] == 1)
	{
		SpikeInfo[spikeid][sCreated]=0;
		SpikeInfo[spikeid][sX]=0.0;
		SpikeInfo[spikeid][sY]=0.0;
		SpikeInfo[spikeid][sZ]=0.0;
		DestroyDynamicObject(SpikeInfo[spikeid][sObject]);
		return 1;
	}
	return -1;
}
EditStrip(playerid,spikeid)
{
	EditDynamicObject(playerid,SpikeInfo[spikeid][sObject]);
}
encode_tires(tires1, tires2, tires3, tires4) {

	return tires1 | (tires2 << 1) | (tires3 << 2) | (tires4 << 3);

}
