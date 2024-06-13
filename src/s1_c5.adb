with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Radix; use Radix;
with Types; use Types;

procedure S1_C5 is
   Input_Plaintext : constant String := "Burning 'em, if you ain't quick and nimble" & LF & "I go crazy when I hear a cymbal"; -- Plaintext to Encrypt
   Input_Key : constant String := "ICE"; -- Encryption Key
   Input_Bytes, Output_Bytes : Byte_Array (Input_Plaintext'Range); -- Input and Output Byte Arrays
   Key_Bytes : Byte_Array (Input_Key'Range);
   Output : String (1 .. Output_Bytes'Length * 2);

   -- Timing Boilerplate
   Start_Time, Stop_Time : CPU_Time;
   Elapsed_Time : Time_Span;
begin
   -- Start Challenge
   Put_Line("Starting Set 1 Challenge 5");
   Start_Time := Clock;

   -- Execute
   Input_Bytes := ASCII_String_To_Bytes(Input_Plaintext); -- Input Strings
   Key_Bytes := ASCII_String_To_Bytes(Input_Key);
   Output_Bytes := Input_Bytes xor Key_Bytes; -- XOR
   Output := Bytes_To_Hex_String(Output_Bytes); --Change to Hex

   -- Stop Challenge
   Stop_Time := Clock;
   Elapsed_Time := Stop_Time - Start_Time;

   -- Show Results
   Put_Line("Output: " & Output);
   Put_Line("Execution Time: " & Duration'Image(To_Duration (Elapsed_Time)) & "s");
end S1_C5;