with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;
with Radix; use Radix;
with Types; use Types;

procedure S1_C1 is
   Input : constant String := "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d";
   Bytes : Byte_Array (1 .. Input'Length/2);
   Output : String (1 .. Bytes'Length*4/3);

   Start_Time, Stop_Time : CPU_Time;
   Elapsed_Time : Time_Span;
begin
   -- Start Challenge
   Put_Line("Starting Set 1 Challenge 1");
   Start_Time := Clock;

   -- Execute
   Bytes := Hex_String_To_Bytes(Input);
   Output := Bytes_To_B64_String(Bytes);

   -- Stop Challenge
   Stop_Time := Clock;
   Elapsed_Time := Stop_Time - Start_Time;

   -- Show Results
   Put_Line("Output: " & Output);
   Put_Line("Execution Time: " & Duration'Image(To_Duration (Elapsed_Time)) & "s");
end S1_C1;