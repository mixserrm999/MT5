//+------------------------------------------------------------------+
//|                                        Equity-based Position Closure.mq5 |
//|                                              Copyright 2023, KISHORE K. |
//|                     https://www.mql5.com/en/users/kishorekiruba |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2023, KISHORE K"
#property link      "https://www.mql5.com/en/users/kishorekiruba"
#property version   "1.000"
//---
//#include <MQL_Easy_Example.mqh> // Only for demostration purposes
#include <MQL_Easy\MQL_Easy.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\Trade.mqh>
#include <Trade\AccountInfo.mqh>
CTrade m_trade;     
//-- Object that execute trades
CExecute execute;
//-- Object that manage trades
CPosition position;                 // trading object
//--- input parameters
input string a = "▼"; // ╔═════════BUY═════════╗

input double ForBuyLS = 0.01; // Lot Size
input double ForBuySL = 50; // Stop Loss
input double ForBuyTP = 100; // Take Profite

input string d = "▲"; // ╚═════════BUY═════════╝

input string b = "▼"; // ╔═════════SELL═════════╗

input double ForSellLS = 0.01; // Lot Size
input double ForSellSL = 50; // Stop Loss
input double ForSellTP = 100; // Take Profit

input string c = "▲"; // ╚═════════SELL═════════╝

input string Z = "ทั้งสองฝั่งเหมือนกัน BUY SELL"; // ทั้งสองฝั่งตั้งเหมือนกันของฝั่ง BUY SELL
input string X = "ทั้งสองฝั่งเหมือนกัน current"; // ทั้งสองฝั่งตั้งเหมือนกันของฝั่ง current

input string e = "▼"; // ╔═════════current═════════╗

input double CurrentPriceAutoSLForBuy = 200; // เมื่อราคาไปถึงจะทำการ SL หน้าทุน
input double UpdateSLBuy = 100; // เมื่อราคาขยับตัวจะทำการ อัพเดท SLขึ้น

input string f = "▲"; // ╚════════current══════════╝

input string h = "▼"; // ╔════════current══════════╗

input double CurrentPriceAutoSLForSell = 200; // เมื่อราคาไปถึงจะทำการ SL หน้าทุน
input double UpdateSLSell = 100; // เมื่อราคาขยับตัวจะทำการ อัพเดท SL ขึ้น

input string g = "▲"; // ╚═════════current═════════╝

input string Dont = "ดัานล่างอย่าตั้งค่า";
input int buttonX = 100;  // X-coordinate of the button
input int buttonY = 100;  // Y-coordinate of the button
//input int buttonWidth = 100;  // Width of the button
//input int buttonHeight = 50;  // Height of the button

//---
ulong m_magic = 15489;                // magic number
ulong m_slippage = 50;                // slippage
bool isBuyButtonClicked = false; 
bool isSellButtonClicked = false;     // Flag to track button click

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
   m_trade.SetExpertMagicNumber(m_magic);
   m_trade.SetMarginMode();
   m_trade.SetTypeFillingBySymbol(Symbol());
   m_trade.SetDeviationInPoints(m_slippage);

   // Create the button object
   ObjectCreate(0, "BuyButton", OBJ_BUTTON, 0, 0, 0, 0, 0);

   // Set button properties
   ObjectSetString(0, "BuyButton", OBJPROP_TEXT, "BUY");  // Set the text of the button
   ObjectSetInteger(0, "BuyButton", OBJPROP_XDISTANCE, buttonX, 10);  // Set the X-distance of the button
   ObjectSetInteger(0, "BuyButton", OBJPROP_YDISTANCE, buttonY, 20);  // Set the Y-distance of the button
   //ObjectSetInteger(0, "BuyButton", OBJPROP_XSIZE, buttonWidth);  // Set the width of the button
   //ObjectSetInteger(0, "BuyButton", OBJPROP_YSIZE, buttonHeight);  // Set the height of the button

   // Set button appearance
   ObjectSetInteger(0, "BuyButton", OBJPROP_COLOR, clrBlack);  // Set the button color
   ObjectSetInteger(0, "BuyButton", OBJPROP_BGCOLOR, clrLimeGreen);  // Set the button background color
   ObjectSetInteger(0, "BuyButton", OBJPROP_BORDER_COLOR, clrBlack);  // Set the button border color
   ObjectSetInteger(0, "BuyButton", OBJPROP_FONTSIZE, 16);  // Set the font size of the button text
      // Create the sell button object
   ObjectCreate(0, "SellButton", OBJ_BUTTON, 0, 0, 0, 0, 0);

   // Set sell button properties
   ObjectSetString(0, "SellButton", OBJPROP_TEXT, "SELL");  // Set the text of the sell button
   ObjectSetInteger(0, "SellButton", OBJPROP_XDISTANCE, buttonX, 120);  // Set the X-distance of the sell button
   ObjectSetInteger(0, "SellButton", OBJPROP_YDISTANCE, buttonY, 20);  // Set the Y-distance of the sell button
   //ObjectSetInteger(0, "SellButton", OBJPROP_XSIZE, buttonWidth);  // Set the width of the sell button
   //ObjectSetInteger(0, "SellButton", OBJPROP_YSIZE, buttonHeight);  // Set the height of the sell button

   // Set sell button appearance
   ObjectSetInteger(0, "SellButton", OBJPROP_COLOR, clrBlack);  // Set the sell button color
   ObjectSetInteger(0, "SellButton", OBJPROP_BGCOLOR, clrRed);  // Set the sell button background color
   ObjectSetInteger(0, "SellButton", OBJPROP_BORDER_COLOR, clrBlack);  // Set the sell button border color
   ObjectSetInteger(0, "SellButton", OBJPROP_FONTSIZE, 16);  // Set the font size of the sell button text


   EventSetMillisecondTimer(1);
   return (INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{

}

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
{
   // Check if the event is a mouse click event
   if (id == CHARTEVENT_OBJECT_CLICK)
   {
      // Check if the clicked object is the buy button
      if (sparam == "BuyButton")
      {
         isBuyButtonClicked = true;
      }
      if (sparam == "SellButton")
      {
         isSellButtonClicked = true;
      }
   }
}

void OnTick()
{
   if (isBuyButtonClicked)
   {
      // Open an order when the button is clicked
      string symbol = _Symbol;
      int magicNumber = 12345;
      execute.SetSymbol(symbol);
      execute.SetMagicNumber(magicNumber);
      position.SetGroupSymbol(symbol);
      position.SetGroupMagicNumber(magicNumber);
     
      //-- Create a trade Position BUY
      ENUM_TYPE_POSITION type = TYPE_POSITION_BUY;
      double volume = ForBuyLS;
      double stopLoss = ForBuySL;
      double takeProfit = ForBuyTP;    
      execute.Position(type,volume,stopLoss,takeProfit,SLTP_PIPS);
      //-- delay for visual purpose and slow brokers
      Sleep(2000);
      //-- Collect Information about the trade
      if(position.SelectByIndex(0) != -1){
         long ticket       = position.GetTicket();
         double openPrice  = position.GetPriceOpen();  
         Print("#Ticket: "+(string)ticket+", OpenPrice: "+(string)openPrice);    
      }
      isBuyButtonClicked = false;  // Reset the flag
   }
   if (isSellButtonClicked)
   {
      // Open an order when the button is clicked
      string symbol = _Symbol;
      int magicNumber = 12345;
      execute.SetSymbol(symbol);
      execute.SetMagicNumber(magicNumber);
      position.SetGroupSymbol(symbol);
      position.SetGroupMagicNumber(magicNumber);
     
      //-- Create a trade Position BUY
      ENUM_TYPE_POSITION type = TYPE_POSITION_SELL;
      double volume = ForSellLS;
      double stopLoss = ForSellSL;
      double takeProfit = ForSellTP;    
      execute.Position(type,volume,stopLoss,takeProfit,SLTP_PIPS);
      //-- delay for visual purpose and slow brokers
      Sleep(2000);
      //-- Collect Information about the trade
      if(position.SelectByIndex(0) != -1){
         long ticket       = position.GetTicket();
         double openPrice  = position.GetPriceOpen();  
         Print("#Ticket: "+(string)ticket+", OpenPrice: "+(string)openPrice);    
      }
      isSellButtonClicked = false; // Reset the flag
   }
   // Check for open positions
   if (position.SelectByIndex(0) != -1)
   {
      double openPrice = position.GetPriceOpen();
      double currentPrice = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      double pointSize = SymbolInfoDouble(_Symbol, SYMBOL_POINT);

      // Calculate the number of 200-pip increments in the price movement
      int increments = 0;
      if (position.GetType() == POSITION_TYPE_BUY)
      {
         increments = (int)((currentPrice - openPrice) / (CurrentPriceAutoSLForBuy * pointSize));
      }
      else if (position.GetType() == POSITION_TYPE_SELL)
      {
         increments = (int)((openPrice - currentPrice) / (CurrentPriceAutoSLForSell * pointSize));
      }

      // Update the stop loss based on the number of 200-pip increments
      if (increments > 0)
      {
         double newStopLoss = 0;
         if (position.GetType() == POSITION_TYPE_BUY)
         {
            newStopLoss = openPrice + (increments - 1) * UpdateSLBuy * pointSize;
         }
         else if (position.GetType() == POSITION_TYPE_SELL)
         {
            newStopLoss = openPrice - (increments - 1) * UpdateSLSell * pointSize;
         }

         // Update the stop loss if the new value is better than the current one
         if ((position.GetType() == POSITION_TYPE_BUY && newStopLoss > position.GetStopLoss()) ||
             (position.GetType() == POSITION_TYPE_SELL && (newStopLoss < position.GetStopLoss() || position.GetStopLoss() == 0)))
         {
            m_trade.PositionModify(position.GetTicket(), newStopLoss, position.GetTakeProfit());
         }
      }
   }
}