package body Types is

    function "xor" (Left, Right : Byte_Array) return Byte_Array is
        Output : Byte_Array(1 .. Left'Length);
    begin
        for I in Output'Range loop
            Output(I) := Left(Left'First + I - 1) xor Right((I - 1) mod Right'Length + Right'First);
        end loop;

        return Output;
    end "xor";

    function "xor" (Left : Byte_Array; Right : Byte) return Byte_Array is
        Output : Byte_Array(1 .. Left'Length);
    begin
        for I in Output'Range loop
            Output(I) := Left(I) xor Right;
        end loop;

        return Output;
    end "xor";

    function Hamming_Distance (Left, Right : Byte_Array) return Natural is
        Intermediate : Byte_Array(Left'Range); -- Holds the xor'd value of left and right
        Output : Natural := 0;
    begin
        -- XOR the operators to get a byte array with as many 1's as the Hamming distance
        Intermediate := Left xor Right;

        for Byte_Iterator in Intermediate'Range loop -- Iterate through each byte
            for Bit_Iterator in 0 .. 7 loop -- Iterate through each bit in the byte
                if (Intermediate(Byte_Iterator) and Shift_Left(1, Bit_Iterator)) /= 0 then -- Found a 1
                    Output := Output + 1;
                end if;
            end loop;
        end loop;

        return Output;

    end Hamming_Distance;
end Types;