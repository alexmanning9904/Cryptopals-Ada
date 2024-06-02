package body Radix is

    function Hex_String_To_Bytes(Hex_String : String) return Byte_Array is
    Bytes : Byte_Array (1 .. Hex_String'Length/2) := (others => 0);
    begin
        for I in 1 .. Hex_String'Length/2 loop -- Loop through String 2 at a time
            declare
                Current_Hex_Upper_Nibble : Character renames Hex_String( 2*I - 1 ); -- Upper Nibble rename
                Current_Hex_Lower_Nibble : Character renames Hex_String( 2*I ); -- Lower Nubble Rename
            begin
                Bytes(I) := Hex_To_Byte_Lookup(Current_Hex_Upper_Nibble, Current_Hex_Lower_Nibble); -- Perform the lookup
                    
            end;
        end loop;
        return Bytes;
    end Hex_String_To_Bytes;

    function Bytes_To_B64_String(Bytes : Byte_Array) return String is
    B64_String : String (1 .. Bytes'Length * 4/3) := (others => '?');
    begin
        for I in 1 .. Bytes'Length/3 loop -- Handle 3 Bytes at a time (maps to 4 B64 characters) 
            declare
                Byte_1 : Byte renames Bytes( 3*I - 2);
                Byte_2 : Byte renames Bytes( 3*I - 1);
                Byte_3 : Byte renames Bytes( 3*I - 0);
            begin
                B64_String(4*I - 3 .. 4*I) :=   Byte_To_B64_Lookup(Shift_Right(Byte_1, 2)) &
                                                Byte_To_B64_Lookup(Shift_Left(Byte_1 and 2#0000_0011#, 4) or Shift_Right(Byte_2, 4)) &
                                                Byte_To_B64_Lookup(Shift_Left(Byte_2 and 2#0000_1111#, 2) or Shift_Right(Byte_3, 6)) &
                                                Byte_To_B64_Lookup(Byte_3 and 2#0011_1111#); -- Write the String
            end;
        end loop;
        return B64_String;
    end Bytes_To_B64_String;

end Radix;