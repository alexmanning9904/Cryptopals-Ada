with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;
with Radix; use Radix;
with Types; use Types;

procedure S1_C2 is
   Input_1 : constant String := "1c0111001f010100061a024b53535009181c"; -- Hex Operand A
   Input_2 : constant String := "686974207468652062756c6c277320657965"; -- Hex Operand B
   Bytes_1, Bytes_2, Output_Bytes : Byte_Array (1 .. Input_1'Length/2); -- Operand and Output Byte Arrays
   Output : String (1 .. Input_1'Length);

   -- Timing Boilerplate
   Start_Time, Stop_Time : CPU_Time;
   Elapsed_Time : Time_Span;
begin
   -- Start Challenge
   Put_Line("Starting Set 1 Challenge 2");
   Start_Time := Clock;

   -- Execute
   Bytes_1 := Hex_String_To_Bytes(Input_1); -- Input Strings
   Bytes_2 := Hex_String_To_Bytes(Input_2);
   Output_Bytes := Bytes_1 xor Bytes_2; -- XOR
   Output := Bytes_To_Hex_String(Output_Bytes); --Change to Hex

   -- Stop Challenge
   Stop_Time := Clock;
   Elapsed_Time := Stop_Time - Start_Time;

   -- Show Results
   Put_Line("Output: " & Output);
   Put_Line("Execution Time: " & Duration'Image(To_Duration (Elapsed_Time)) & "s");
end S1_C2;