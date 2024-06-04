with Ada.Characters.Handling; use Ada.Characters.Handling;

package body English is
    function Count_Instances (Input : String; Token : Character) return Integer is
        Count : Integer := 0;
    begin
        for I in Input'Range loop
            if Input(I) = Token then
                Count := Count + 1;
            end if;
        end loop;

        return Count;
    end Count_Instances;

    function Count_Frequency (Input : String; Token : Character) return Float is
        Frequency : Float;
    begin
        Frequency := Float(Count_Instances(Input, Token)) / Float(Input'Length);
        return Frequency;
    end Count_Frequency;

    function English_Chi_Squared (Input : String) return Float is
        Input_Uppercase : String (1 .. Input'Length);
        Chi_Squared : Float := 0.0;
    begin
        Input_Uppercase := To_Upper(Input); -- Convert Input to Uppercase

        for C in English_Letter_Frequency'Range loop -- For each letter
            Chi_Squared := Chi_Squared + (Count_Frequency(Input_Uppercase, C) - English_Letter_Frequency(C)) ** 2; -- Sum into Chi-Squared
        end loop;

        Chi_Squared := Chi_Squared / Float(Input'Length); -- Divide by Input String length

        return Chi_Squared;

    end English_Chi_Squared;

end English;