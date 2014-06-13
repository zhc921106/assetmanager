-- var_dump(ASFramework, "ASFramework")

-- var_dump(cc.XMLHttpRequest, "cc.XMLHttpRequest");
-- var_dump(cc.WebSocket, "cc.WebSocket");
echo (utils.File:writeablePath());

-- utils.purchaseIOS(config.IOS_ProductID1, function(result, pid)
--  echo (result, pid);
-- end);


local javaBridgeCenter = require("center.javaBridgeCenter");
local objcBridgeCenter = require("center.objcBridgeCenter");
local app = ASApplication.getInstance();

echo ("##################################################")
echo ("version      #", app:getVersion());
echo ("sound        #", app:getsoundToggle())
echo ("platform     #", sys.platform)

echo ("device id    #", utils.device:deviceID())
echo ("device name  #", utils.device:deviceName())

echo ("luaj  # javaBridgeCenter.getAndroidUid       $ ", javaBridgeCenter.getAndroidUid())
echo ("luaj  # javaBridgeCenter.getAndroidName      $ ", javaBridgeCenter.getAndroidName())
echo ("luaj  # javaBridgeCenter.isAndroidNetwork    $ ", javaBridgeCenter.isAndroidNetwork())
echo ("luaj  # javaBridgeCenter.isAndroidWifi       $ ", javaBridgeCenter.isAndroidWifi())

echo ("luaoc # objcBridgeCenter.isWiFiAvailable     $ ", objcBridgeCenter.isWiFiAvailable())
echo ("luaoc # objcBridgeCenter.isInternetAvailable $ ", objcBridgeCenter.isInternetAvailable())

echo ("##################################################")

echo ("遍历 writeablePath")
local list = utils.Dir:list(utils.File:writeablePath());
var_dump(list)

-- echo ("##################################################")
-- echo ("网络测试")

-- local completion = function(request)
-- 	var_dump(request.response);
-- 	echo ("##################################################")
-- end
-- local errorHandler = function(request)
-- 	echo (request.error);
-- 	echo ("##################################################")
-- end

-- -- local request = ASHttpRequest.create(completion, errorHandler);
-- -- request:setRequestHeader({nihao = "luwei"})
-- -- request:send("http://localhost/~luwei/")
echo ("##################################################")


