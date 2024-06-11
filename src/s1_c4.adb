with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;
with Ada.Command_Line; use Ada.Command_Line;
with Radix; use Radix;
with Types; use Types;
with English; use English;

procedure S1_C4 is
   Input_File : File_Type;
   Input_Line : String (1 .. 60); -- Hex Encoded String
   Last_Character : Natural;
   Input_Bytes : Byte_Array (1 .. Input_Line'Length/2); -- Input Byte Array
   Decrypted_Bytes : Byte_Array (1 .. Input_Line'Length/2); -- Byte array of decrypted bytes
   Decrypted_String : String (1 .. Input_Line'Length/2);

   Score : Float; -- Current Chi-Squared Score
   Best_Score : Float := 1.0; -- Best (Lowest) Chi-Squared Score
   Best_String : String ( 1 .. Input_Line'Length/2); -- Best String

   -- Timing Boilerplate
   Start_Time, Stop_Time : CPU_Time;
   Elapsed_Time : Time_Span;
begin
   -- Start Challenge
   Put_Line("Starting Set 1 Challenge 4");
   Put_Line("Using " & Argument(1) & " as input");
   Start_Time := Clock;

   -- Execute
   Open(Input_File, In_File, Argument(1)); -- Open the Input File

   while not End_Of_File(Input_File) loop -- Loop Through Each Line

      Get_Line(Input_File, Input_Line, Last_Character); -- Read the Line

      Input_Bytes := Hex_String_To_Bytes(Input_Line); -- Convert the Hex String to Bytes

      for I in Byte'range loop -- For each potential Key byte
         Decrypted_Bytes := Input_Bytes xor I; -- Decrypt the Input
         Decrypted_String := Bytes_To_ASCII_String(Decrypted_Bytes); -- Convert the bytes to a String
         Score := English_Chi_Squared(Decrypted_String); -- Calculate the English-Ness of the string

         if Score < Best_Score then -- This is the most English string yet
            Best_Score := Score; -- Save the score to track the best
            Best_String := Decrypted_String; -- Hold on to it to print
         end if;
      end loop;
   
   end loop;

   -- Stop Challenge
   Stop_Time := Clock;
   Elapsed_Time := Stop_Time - Start_Time;

   -- Show Results
   Put_Line("Output: " & Best_String);
   Put_Line("Execution Time: " & Duration'Image(To_Duration (Elapsed_Time)) & "s");
end S1_C4;