with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;
with Radix; use Radix;
with Types; use Types;
with English; use English;

procedure S1_C3 is
   Input : constant String := "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"; -- Hex Encoded String
   Input_Bytes : Byte_Array (1 .. Input'Length/2); -- Input Byte Array
   Decrypted_Bytes : Byte_Array (1 .. Input'Length/2); -- Byte array of decrypted bytes
   Decrypted_String : String (1 .. Input'Length/2);

   Score : Float; -- Current Chi-Squared Score
   Best_Score : Float := 1.0; -- Best (Lowest) Chi-Squared Score
   Best_Key : Byte; -- Decryption Key with best score

   -- Timing Boilerplate
   Start_Time, Stop_Time : CPU_Time;
   Elapsed_Time : Time_Span;
begin
   -- Start Challenge
   Put_Line("Starting Set 1 Challenge 3");
   Start_Time := Clock;

   -- Execute
   Input_Bytes := Hex_String_To_Bytes(Input); -- Input Strings

   for I in Byte'range loop -- For each potential Key byte
      Decrypted_Bytes := Input_Bytes xor I; -- Decrypt the Input
      Decrypted_String := Bytes_To_ASCII_String(Decrypted_Bytes); -- Convert the bytes to a String
      Score := English_Chi_Squared(Decrypted_String); -- Calculate the English-Ness of the string

      if Score < Best_Score then -- This is the most English string yet
         Best_Score := Score;
         Best_Key := I;
      end if;
   end loop;

   Decrypted_Bytes := Input_Bytes xor Best_Key; -- Decrypt the Input with the best Key
   Decrypted_String := Bytes_To_ASCII_String(Decrypted_Bytes); -- Convert the bytes to a String

   -- Stop Challenge
   Stop_Time := Clock;
   Elapsed_Time := Stop_Time - Start_Time;

   -- Show Results
   Put_Line("Output: " & Decrypted_String);
   Put_Line("Execution Time: " & Duration'Image(To_Duration (Elapsed_Time)) & "s");
end S1_C3;