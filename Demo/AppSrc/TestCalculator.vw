Use Windows.pkg
Use DFClient.pkg
Use Calculator.dg
Use cCJGrid.pkg
Use cCJGridColumn.pkg

Activate_View Activate_oTestCalculator for oTestCalculator
Object oTestCalculator is a dbView
    Set Border_Style to Border_Thick
    Set Size to 200 300
    Set Location to 2 2
    Set pbAutoActivate to True
    Set Label to "Calculator testing"

    Object oValueForm is a Form
        Set Size to 12 100
        Set Location to 10 35
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
        Set Label to "Value 1:"
        Set Form_Datatype to Mask_Numeric_Window
        Set Prompt_Button_Mode to PB_PromptOn
        Set psToolTip to "Click the prompt button or press the kCalculator accelerator key (Alt+F5) to popup the calculator modal dialog"

        Procedure Prompt
            Real rValue

            Get Value to rValue
            Get CalculatedResult of oCalculatorDialog rValue to rValue

            Set Value to rValue
        End_Procedure

        On_Key kCalculate Send Prompt // kCalculate is Alt+F5
    End_Object

    Object oValuesGrid is a cCJGrid
        Set Size to 119 100
        Set Location to 24 35
        Set pbUseAlternateRowBackgroundColor to True
        Set pbFixedInplaceButtonHeight to True

        Object oValueColumn is a cCJGridColumn
            Set piWidth to 100
            Set psCaption to "Values"
            Set Prompt_Button_Mode to PB_PromptOn
            Set peDataType to Mask_Numeric_Window
            Set psMask to "*.*"

            Function OnGetTooltip Integer iRow String sValue String sText Returns String
                Function_Return "Click the prompt button or press the kCalculator accelerator key (Alt+F5) to popup the calculator modal dialog"
            End_Procedure

            Procedure Prompt
                Send OpenCalculator
            End_Procedure

            Procedure OpenCalculator
                Real rValue

                Get SelectedRowValue to rValue
                Get CalculatedResult of oCalculatorDialog rValue to rValue

                Send UpdateCurrentValue rValue
            End_Procedure

            On_Key kCalculate Send Prompt // kCalculate is Alt+F5
        End_Object

        // Floating menu to open the calculator dialog
        Object oValuesGridContextMenu is a cCJContextMenu
            Object oOpenCalculatorMenuItem is a cCJMenuItem
                Set psCaption to "Open Calculator"
                Set psTooltip to "Open Calculator"

                Procedure OnExecute Variant vCommandBarControl
                    Send OpenCalculator of oValueColumn
                End_Procedure
            End_Object
        End_Object

        Set phoContextMenu to oValuesGridContextMenu
    End_Object
End_Object
