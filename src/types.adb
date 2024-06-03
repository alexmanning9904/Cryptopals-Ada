package body Types is

    function "xor" (Left, Right : Byte_Array) return Byte_Array is
        Output : Byte_Array(1 .. Left'Length);
    begin
        for I in Output'Range loop
            Output(I) := Left(I) xor Right(I);
        end loop;

        return Output;
    end "xor";
end Types;