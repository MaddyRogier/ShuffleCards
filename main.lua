--[[----------------------------------
       Shuffle Deck of Cards 
	   Designed on iPhone 6 
          Maddy Rogier
----------------------------------]]--

--[[----------------------------------
function - card design
----------------------------------]]-- 
red   = {1, 0, 0}
black = {0, 0, 0}

suitFiles =  { "club.png", "diamond.png", "heart.png", "spade.png" }
suitColors = {  black,      red,           red,         black }

local function getCardSuit( card ) --card 2 character string, 1st character is suit then turned number, 
    local suit = string.sub(card, 1, 1) --calls first character of card, lua build in sub calls string 
    
    if suit == "C" then --starts to compare character suit
        return 1
    elseif suit == "D" then
        return 2
    elseif suit == "H" then
        return 3
    elseif suit == "S" then
        return 4
    end --/if
end --/function

local function getCardRank( card )
    local rank = string.sub(card, 2) --starting at second character and ending at 2nd character string
    return rank
end --/function

--[[----------------------------------
function - render
----------------------------------]]-- 
local function render( card )
    
    local rankString = getCardRank( card )
    local suitNumber = getCardSuit( card )
    local suitColor  = suitColors[ suitNumber ]
    local suitFile   = suitFiles[ suitNumber ]
    
    local group = display.newGroup()
    
    local back = display.newRoundedRect(0,0,455,700,20)

    back:setFillColor(.961,.925,.875)
    back:setStrokeColor(.227,.2,.267)
    back.strokeWidth = 2
    
    local suit = display.newImage(suitFile,-150,-180)
    suit:scale(.1, .1)
    
    local rankText = display.newText(rankString,-150,-280,"verdana",72)
    rankText:setFillColor(unpack(suitColor))
    
    group:insert(back)
    group:insert(suit)
    group:insert(rankText)
    
    return group
end --/function 


--[[---------------------------------- 
function - creates/rotates cards  
----------------------------------]]--
local function drawCard( index, card ) --index counter 
    local image = render( card )
    
    image.x = 400+100*index
    image.y = 450
    image.rotation = -50+11*index
end --/function 


--[[---------------------------------- 
array - 52 cards 
----------------------------------]]-- 
local deckOfCards = {
                "CA", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "C10", "CJ", "CQ", "CK", 
                "DA", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D10", "DJ", "DQ", "DK", 
                "HA", "H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "H10", "HJ", "HQ", "HK", 
                "SA", "S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "S10", "SJ", "SQ", "SK", }
                
--[[----------------------------------
function - shuffles cards randomly  
----------------------------------]]-- 
math.randomseed( os.time() )
 
local function shuffleTable( t )
    
    local randomNum = math.random 
    assert( t, "shuffleTable() error" )
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = randomNum(i)
        t[i], t[j] = t[j], t[i]
    end --/for
end --/function
 
shuffleTable( deckOfCards )

--[[----------------------------------
function - draws cards
----------------------------------]]--
local function drawCards( count, deck )
    for i = 1, count do
        drawCard( i, deck[ i ] )
    end
end

 
--[[----------------------------------
function - deals out 5 cards
----------------------------------]]-- 
drawCards( 5, deckOfCards )
