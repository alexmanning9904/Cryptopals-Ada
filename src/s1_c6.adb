with Ada.Text_IO; use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Execution_Time; use Ada.Execution_Time;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Strings.Unbounded; use  Ada.Strings.Unbounded;
with Radix; use Radix;
with Types; use Types;
with English; use English;

procedure S1_C6 is
   Input_File : File_Type;
   Input_Text : Unbounded_String := Null_Unbounded_String;

   Block_Pair_Count : constant Natural := 20; -- How many block pairs to average the key length guess hamming distance over (challenge section 4)
   Current_Normalized_Distance : Float; -- Goodness of current key length guess
   Best_Key_Length : Natural := 0; -- Best Key Length Guess
   Best_Normalized_Distance : Float := 1.0; -- "Goodness" (Hamming Distance/Bits) of best key length guess
   
   --  Input_Line : String (1 .. 60); -- Hex Encoded String
   --  Last_Character : Natural;
   --  Input_Bytes : Byte_Array (1 .. Input_Line'Length/2); -- Input Byte Array
   --  Decrypted_Bytes : Byte_Array (1 .. Input_Line'Length/2); -- Byte array of decrypted bytes
   --  Decrypted_Transposed_String : String (1 .. Input_Line'Length/2);

   --  Score : Float; -- Current Chi-Squared Score
   --  Best_Score : Float := 1.0; -- Best (Lowest) Chi-Squared Score
   --  Best_String : String ( 1 .. Input_Line'Length/2); -- Best String

   -- Timing Boilerplate
   Start_Time, Stop_Time : CPU_Time;
   Elapsed_Time : Time_Span;
begin
   -- Start Challenge
   Put_Line("Starting Set 1 Challenge 6");
   Put_Line("Using " & Argument(1) & " as input");
   Start_Time := Clock;

   -- Execute

   Open(Input_File, In_File, Argument(1)); -- Open the Input File

   while not End_Of_File(Input_File) loop -- Loop Through Each Line
      Append(Input_Text, Get_Line(Input_File)); -- Add each line to the long input string
   end loop;

   declare
      Input_Bytes : constant Byte_Array := B64_String_To_Bytes(To_String(Input_Text)); --Convert the input B64 string to bytes
   begin
      -- Figure out the Key Length.  2-40 is suggested in the challenge description itself
      for Key_Length_Guess in 2..40 loop
         Current_Normalized_Distance := 0.0; -- Reset the distance to 0

         for Block_Pair in 1 .. Block_Pair_Count loop -- Take the calculation over a few pairs
            Current_Normalized_Distance := Current_Normalized_Distance + Float(Hamming_Distance(
               Input_Bytes( 1 + 2 * Key_Length_Guess * (Block_Pair - 1) .. Key_Length_Guess + 2 * Key_Length_Guess * (Block_Pair - 1)),
               Input_Bytes( Key_Length_Guess + 1 + 2 * Key_Length_Guess * (Block_Pair - 1) .. Key_Length_Guess * 2 + 2 * Key_Length_Guess * (Block_Pair - 1))
            ));
         end loop;

         Current_Normalized_Distance := Current_Normalized_Distance / Float(Key_Length_Guess * 8 * Block_Pair_Count); -- Divide down to be normalized between 0 and 1
         
         if Current_Normalized_Distance < Best_Normalized_Distance then -- This is the new best key length
            Best_Normalized_Distance := Current_Normalized_Distance;
            Best_Key_Length := Key_Length_Guess;
         end if;


      end loop;

      declare
         Key : Byte_Array (1 .. Best_Key_Length);
         Transposed_Input_Bytes : Byte_Array (1 .. Input_Bytes'Length/Key'Length); -- Transposed section length.  This will actually chop off some of the last input bytes, but it shouldn't matter for the statistical section
         Decrypted_Transposed_Input_Bytes : Byte_Array (1 .. Input_Bytes'Length/Key'Length); -- XORed transposed section
         Decrypted_Transposed_String : String (1 .. Input_Bytes'Length/Key'Length); -- XORed transposed section String
         Key_String : String (1 .. Key'Length);
         Decrypted_String : String (Input_Bytes'Range);

         Score : Float; -- Current Chi-Squared Score
         Best_Score : Float; -- Best (Lowest) Chi-Squared Score
         Best_Key_Byte : Byte := 0; -- Key Byte corresponding to best Chi-Squared Score
      begin
         for Key_Index in Key'Range loop -- For each key byte
            Best_Score := 1.0;

            for I in Transposed_Input_Bytes'Range loop -- Fill up the Transposed Byte Array
               Transposed_Input_Bytes(I) := Input_Bytes(Key_Index + (Key'Length * (I - 1)));
            end loop;

            -- Crack the transposed section
            for I in Byte'range loop -- For each potential Key byte
               Decrypted_Transposed_Input_Bytes := Transposed_Input_Bytes xor I; -- Decrypt the Input
               Decrypted_Transposed_String := Bytes_To_ASCII_String(Decrypted_Transposed_Input_Bytes); -- Convert the bytes to a String
               Score := English_Chi_Squared(Decrypted_Transposed_String); -- Calculate the English-Ness of the string

               if Score < Best_Score then -- This is the most English string yet
                  Best_Score := Score; -- Save the score to track the best
                  Best_Key_Byte := I; -- Save the best Key byte
               end if;
            end loop;

            Key(Key_Index) := Best_Key_Byte;

         end loop;

         Key_String := Bytes_To_ASCII_STRING(Key); -- Cracked Key
         Decrypted_String := Bytes_To_ASCII_STRING(Input_Bytes xor Key); -- Cracked Text

         -- Stop Challenge
         Stop_Time := Clock;
         Elapsed_Time := Stop_Time - Start_Time;

         -- Show Results
         Put_Line(Decrypted_String);
         Put_Line("Key: " & Key_String);
         Put_Line("Execution Time: " & Duration'Image(To_Duration (Elapsed_Time)) & "s");
      end;
   end;

end S1_C6;