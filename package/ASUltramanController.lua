
--
-- CLASS: ASUltramanController
-- 控制器，所有的奥特曼的出场都从这里控制
--
local ASUltramanController = class("ASUltramanController")

--
-- 公共变量
--
local sharedInstance = nil;

--
-- 成员变量
--
ASUltramanController._posMap = nil   --奥特曼Y轴值设定点table
ASUltramanController._layMap  = nil   --奥特曼的Z值表 确实渲染的层次感

local shaderMap = {     --渲染的层次
    {11},
    {13,5},
    {11,15,3},
    {13,17,7,3}
}
local waveMap = {       --波数站位
    {0.44},
    {0.42,0.5},
    {0.44,0.4,0.52},
    {0.42,0.38,0.48,0.52}
}
------------------------------------------------
-- getInstance - 获取单例
-- @param: void
-- @return: 返回ASUltramanController对象
------------------------------------------------
function ASUltramanController.getInstance()
    if nil == sharedInstance then
        sharedInstance = ASUltramanController.new();
        if sharedInstance then 
            if sharedInstance:init() ~= true then return nil end
        end
    end
    return sharedInstance;
end

------------------------------------------------
-- destroyInstance - 删除单例
-- @param: void
-- @return: void
------------------------------------------------
function ASUltramanController.destroyInstance()
    sharedInstance = nil;
end

------------------------------------------------
-- init - 初始化（auto-invoked）
-- @param: void
-- @return: bool类型，表示初始化是否成功
------------------------------------------------
function ASUltramanController:init()

    --初始化3个表
    self._posMap = {}
    self._layMap = {}
    return true;
end

------------------------------------------------
-- ultStartTrigger - 奥特曼出场触发器,一旦触发奥特曼自动安装地图数据出场
-- @param:  waveUltMap 数据 table ,timeMap
-- @return: void
------------------------------------------------
function ASUltramanController:ultStartTrigger(waveUltMap,controller,timeMap)
    
    self:ultControllerInit(waveUltMap)  --保存加载的地图数据
    local sumTime = 0   --用于计算时间
    for i=1,#timeMap do
        local function hand()
            for j=1,#waveUltMap[i] do       
                controller:addWithModel(waveUltMap[i][j]):start();  --被延迟出场的奥特曼
            end
        end
        sumTime = timeMap[i] + sumTime
        ASScheduler.scheduleWithDelay(hand,sumTime);
    end
end

------------------------------------------------
-- ultControllerInit - 初始化出场控制表,决定位置和渲染层次
-- @param:  waveUltMap 数据 table
-- @return: void
------------------------------------------------
function ASUltramanController:ultControllerInit(waveUltMap)
    if #waveUltMap == 0 then return false end
    self._posMap = {}
    self._layMap = {}
    for i=1,#waveUltMap do
        local num = #waveUltMap[i]
        for k,v in pairs(waveMap[num]) do
            table.insert(self._posMap,v)
        end
        for k,v in pairs(shaderMap[num]) do
            table.insert(self._layMap,v)
        end
    end
    return true
end

------------------------------------------------
-- getUltramanPosY() - 确定奥特曼Y轴位置
-- @param:  object 类型
-- @return: void
------------------------------------------------
function ASUltramanController:getUltramanPosY(object)
    if #self._posMap == 0 then return 0 end
    if #self._layMap == 0 then return 0 end
    local posY = self._posMap[1]
    object:setLocalZOrder(self._layMap[1])
    table.remove(self._posMap,1)
    table.remove(self._layMap,1)
    return posY
end

return ASUltramanController;
