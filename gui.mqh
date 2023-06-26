//+------------------------------------------------------------------+
//|                                               ControlsDialog.mqh |
//|                             Copyright 2000-2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\Edit.mqh>
#include <Controls\DatePicker.mqh>
#include <Controls\ListView.mqh>
#include <Controls\ComboBox.mqh>
#include <Controls\SpinEdit.mqh>
#include <Controls\RadioGroup.mqh>
#include <Controls\CheckGroup.mqh>
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- indents and gaps
#define INDENT_LEFT                         (11)      // indent from left (with allowance for border width)
#define INDENT_TOP                          (11)      // indent from top (with allowance for border width)
#define INDENT_RIGHT                        (11)      // indent from right (with allowance for border width)
#define INDENT_BOTTOM                       (11)      // indent from bottom (with allowance for border width)
#define CONTROLS_GAP_X                      (5)       // gap by X coordinate
#define CONTROLS_GAP_Y                      (5)       // gap by Y coordinate
//--- for buttons
#define BUTTON_WIDTH                        (100)     // size by X coordinate
#define BUTTON_HEIGHT                       (20)      // size by Y coordinate
//--- for the indication area
#define EDIT_HEIGHT                         (20)      // size by Y coordinate
#define INPUT_WIDTH                         (70)
#define INPUT_HEIGHT                        (20)
//--- for group controls
//+------------------------------------------------------------------+
//| Class CControlsDialog                                            |
//| Usage: main dialog of the Controls application                   |
//+------------------------------------------------------------------+
class CControlsDialog : public CAppDialog
  {
private:
   CEdit             m_edit;                          // the display field object
   CButton           m_button1;                       // the button object
   CButton           m_button2;                       // the button object
   CButton           m_button3;                       // the fixed button object
   CEdit             m_numberEdit;                    // number
   CEdit             m_input1;
   CEdit             m_input2;
   CEdit             m_input3;
   CEdit             m_input4;
   
   CEdit             m_input5;
   CEdit             m_input6;
   CEdit             m_input7;
   CEdit             m_input8;

public:
   bool              CreateInputField1(void);
   bool              CreateInputField2(void);
   bool              CreateInputField3(void);
   bool              CreateInputField4(void);
   bool              CreateInputField5(void);
   bool              CreateInputField6(void);
   bool              CreateInputField7(void);
   bool              CreateInputField8(void);
                     CControlsDialog(void);
                    ~CControlsDialog(void);
   //--- create
   virtual bool      Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2);
   //--- chart event handler
   virtual bool      OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam);

protected:
   //--- create dependent controls
   bool              CreateEdit(void);
   bool              CreateButton1(void);
   bool              CreateButton2(void);
   bool              CreateButton3(void);
   //--- handlers of the dependent controls events
   void              OnClickButton1(void);
   void              OnClickButton2(void);
   void              OnClickButton3(void);
  };
//+------------------------------------------------------------------+
//| Event Handling                                                   |
//+------------------------------------------------------------------+
EVENT_MAP_BEGIN(CControlsDialog)
   ON_EVENT(ON_CLICK,m_button1,OnClickButton1)
   ON_EVENT(ON_CLICK,m_button2,OnClickButton2)
   ON_EVENT(ON_CLICK,m_button3,OnClickButton3)
EVENT_MAP_END(CAppDialog)
//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CControlsDialog::CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CControlsDialog::~CControlsDialog(void)
  {
  }
//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool CControlsDialog::Create(const long chart,const string name,const int subwin,const int x1,const int y1,const int x2,const int y2)
  {
   if(!CAppDialog::Create(chart,name,subwin,x1,y1,x2,y2))
      return(false);
//--- create dependent controls
   if(!CreateEdit())
      return(false);
   if(!CreateButton1())
      return(false);
   if(!CreateButton2())
      return(false);
   if(!CreateButton3())
      return(false);
   if (!CreateInputField1()) // Create the input field
      return(false);
   if (!CreateInputField2()) // Create the input field
      return(false);
   if (!CreateInputField3()) // Create the input field
      return(false);
   if (!CreateInputField4()) // Create the input field
      return(false);
   if (!CreateInputField5()) // Create the input field
      return(false);
   if (!CreateInputField6()) // Create the input field
      return(false);
   if (!CreateInputField7()) // Create the input field
      return(false);
   if (!CreateInputField8()) // Create the input field
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the display field                                         |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateEdit(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP;
   int x2=ClientAreaWidth()-INDENT_RIGHT;
   int y2=y1+EDIT_HEIGHT;
//--- create
   if(!m_edit.Create(m_chart_id,m_name+"Edit",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_edit.ReadOnly(true))
      return(false);
   if(!Add(m_edit))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button1" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton1(void)
  {
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button1.Create(m_chart_id,m_name+"Button1",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button1.Text("BUY"))
      return(false);
   if(!Add(m_button1))
      return(false);
//--- succeed
   return(true);
  }
//+------------------------------------------------------------------+
//| Create the "Button2" button                                      |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton2(void)
{
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+2*(EDIT_HEIGHT+CONTROLS_GAP_Y); // Increase the y-coordinate
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button2.Create(m_chart_id,m_name+"Button2",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button2.Text("SELL"))
      return(false);
   if(!Add(m_button2))
      return(false);
//--- succeed
   return(true);
}
//+------------------------------------------------------------------+
//| Create the "Button3" fixed button                                |
//+------------------------------------------------------------------+
bool CControlsDialog::CreateButton3(void)
{
//--- coordinates
   int x1=INDENT_LEFT;
   int y1=INDENT_TOP+3*(EDIT_HEIGHT+CONTROLS_GAP_Y);
   int x2=x1+BUTTON_WIDTH;
   int y2=y1+BUTTON_HEIGHT;
//--- create
   if(!m_button3.Create(m_chart_id,m_name+"Button3",m_subwin,x1,y1,x2,y2))
      return(false);
   if(!m_button3.Text("check"))
      return(false);
   if(!Add(m_button3))
      return(false);
   m_button3.Locking(true);
//--- succeed
   return(true);
}
bool CControlsDialog::CreateInputField1(void)
{
   //--- coordinates
   int x1 = INDENT_LEFT + 1.35 * BUTTON_WIDTH + CONTROLS_GAP_X; // ปรับค่า x1 เพิ่มอีก BUTTON_WIDTH และ CONTROLS_GAP_X เพื่อให้ช่อง input มาต่อท้ายด้านขวาของ button3
   int y1 = INDENT_TOP + 1 * (EDIT_HEIGHT + CONTROLS_GAP_Y);
   int x2 = x1 + INPUT_WIDTH;
   int y2 = y1 + INPUT_HEIGHT;
   //--- create
   if (!m_input1.Create(m_chart_id, m_name + "InputField1", m_subwin, x1, y1, x2, y2))
      return (false);
   if (!m_input1.Text("")) // Initialize the input field with an empty string
      return (false);
   if (!Add(m_input1))
      return (false);
   //--- succeed
   return (true);
}
bool CControlsDialog::CreateInputField2(void)
{
   //--- coordinates
   int x1 = INDENT_LEFT + 2.15 * BUTTON_WIDTH + CONTROLS_GAP_X; // ปรับค่า x1 เพิ่มอีก BUTTON_WIDTH และ CONTROLS_GAP_X เพื่อให้ช่อง input มาต่อท้ายด้านขวาของ button3
   int y1 = INDENT_TOP + 1 * (EDIT_HEIGHT + CONTROLS_GAP_Y);
   int x2 = x1 + INPUT_WIDTH;
   int y2 = y1 + INPUT_HEIGHT;
   //--- create
   if (!m_input2.Create(m_chart_id, m_name + "InputField2", m_subwin, x1, y1, x2, y2))
      return (false);
   if (!m_input2.Text("")) // Initialize the input field with an empty string
      return (false);
   if (!Add(m_input2))
      return (false);
   //--- succeed
   return (true);
}
bool CControlsDialog::CreateInputField3(void)
{
   //--- coordinates
   int x1 = INDENT_LEFT + 2.95 * BUTTON_WIDTH + CONTROLS_GAP_X; // ปรับค่า x1 เพิ่มอีก BUTTON_WIDTH และ CONTROLS_GAP_X เพื่อให้ช่อง input มาต่อท้ายด้านขวาของ button3
   int y1 = INDENT_TOP + 1 * (EDIT_HEIGHT + CONTROLS_GAP_Y);
   int x2 = x1 + INPUT_WIDTH;
   int y2 = y1 + INPUT_HEIGHT;
   //--- create
   if (!m_input3.Create(m_chart_id, m_name + "InputField3", m_subwin, x1, y1, x2, y2))
      return (false);
   if (!m_input3.Text("")) // Initialize the input field with an empty string
      return (false);
   if (!Add(m_input3))
      return (false);
   //--- succeed
   return (true);
}
bool CControlsDialog::CreateInputField4(void)
{
   //--- coordinates
   int x1 = INDENT_LEFT + 3.75 * BUTTON_WIDTH + CONTROLS_GAP_X; // ปรับค่า x1 เพิ่มอีก BUTTON_WIDTH และ CONTROLS_GAP_X เพื่อให้ช่อง input มาต่อท้ายด้านขวาของ button3
   int y1 = INDENT_TOP + 1 * (EDIT_HEIGHT + CONTROLS_GAP_Y);
   int x2 = x1 + INPUT_WIDTH;
   int y2 = y1 + INPUT_HEIGHT;
   //--- create
   if (!m_input4.Create(m_chart_id, m_name + "InputField4", m_subwin, x1, y1, x2, y2))
      return (false);
   if (!m_input4.Text("")) // Initialize the input field with an empty string
      return (false);
   if (!Add(m_input4))
      return (false);
   //--- succeed
   return (true);
}
bool CControlsDialog::CreateInputField5(void)
{
   //--- coordinates
   int x1 = INDENT_LEFT + 1.35 * BUTTON_WIDTH + CONTROLS_GAP_X; // ปรับค่า x1 เพิ่มอีก BUTTON_WIDTH และ CONTROLS_GAP_X เพื่อให้ช่อง input มาต่อท้ายด้านขวาของ button3
   int y1 = INDENT_TOP + 2 * (EDIT_HEIGHT + CONTROLS_GAP_Y);
   int x2 = x1 + INPUT_WIDTH;
   int y2 = y1 + INPUT_HEIGHT;
   //--- create
   if (!m_input5.Create(m_chart_id, m_name + "InputField5", m_subwin, x1, y1, x2, y2))
      return (false);
   if (!m_input5.Text("")) // Initialize the input field with an empty string
      return (false);
   if (!Add(m_input5))
      return (false);
   //--- succeed
   return (true);
}
bool CControlsDialog::CreateInputField6(void)
{
   //--- coordinates
   int x1 = INDENT_LEFT + 2.15 * BUTTON_WIDTH + CONTROLS_GAP_X; // ปรับค่า x1 เพิ่มอีก BUTTON_WIDTH และ CONTROLS_GAP_X เพื่อให้ช่อง input มาต่อท้ายด้านขวาของ button3
   int y1 = INDENT_TOP + 2 * (EDIT_HEIGHT + CONTROLS_GAP_Y);
   int x2 = x1 + INPUT_WIDTH;
   int y2 = y1 + INPUT_HEIGHT;
   //--- create
   if (!m_input6.Create(m_chart_id, m_name + "InputField6", m_subwin, x1, y1, x2, y2))
      return (false);
   if (!m_input6.Text("")) // Initialize the input field with an empty string
      return (false);
   if (!Add(m_input6))
      return (false);
   //--- succeed
   return (true);
}
bool CControlsDialog::CreateInputField7(void)
{
   //--- coordinates
   int x1 = INDENT_LEFT + 2.95 * BUTTON_WIDTH + CONTROLS_GAP_X; // ปรับค่า x1 เพิ่มอีก BUTTON_WIDTH และ CONTROLS_GAP_X เพื่อให้ช่อง input มาต่อท้ายด้านขวาของ button3
   int y1 = INDENT_TOP + 2 * (EDIT_HEIGHT + CONTROLS_GAP_Y);
   int x2 = x1 + INPUT_WIDTH;
   int y2 = y1 + INPUT_HEIGHT;
   //--- create
   if (!m_input7.Create(m_chart_id, m_name + "InputField7", m_subwin, x1, y1, x2, y2))
      return (false);
   if (!m_input7.Text("")) // Initialize the input field with an empty string
      return (false);
   if (!Add(m_input7))
      return (false);
   //--- succeed
   return (true);
}
bool CControlsDialog::CreateInputField8(void)
{
   //--- coordinates
   int x1 = INDENT_LEFT + 3.75 * BUTTON_WIDTH + CONTROLS_GAP_X; // ปรับค่า x1 เพิ่มอีก BUTTON_WIDTH และ CONTROLS_GAP_X เพื่อให้ช่อง input มาต่อท้ายด้านขวาของ button3
   int y1 = INDENT_TOP + 2 * (EDIT_HEIGHT + CONTROLS_GAP_Y);
   int x2 = x1 + INPUT_WIDTH;
   int y2 = y1 + INPUT_HEIGHT;
   //--- create
   if (!m_input8.Create(m_chart_id, m_name + "InputField8", m_subwin, x1, y1, x2, y2))
      return (false);
   if (!m_input8.Text("")) // Initialize the input field with an empty string
      return (false);
   if (!Add(m_input8))
      return (false);
   //--- succeed
   return (true);
}
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton1(void)
  {
   m_edit.Text("BUY!!");
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton2(void)
  {
   m_edit.Text("SELL!!");
  }
//+------------------------------------------------------------------+
//| Event handler                                                    |
//+------------------------------------------------------------------+
void CControlsDialog::OnClickButton3(void)
  {
   if(m_button3.Pressed())
      m_edit.Text(__FUNCTION__+"On");
   else
      m_edit.Text(__FUNCTION__+"Off");
  }
//+------------------------------------------------------------------+
