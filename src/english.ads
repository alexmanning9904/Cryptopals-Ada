package English is

    function English_Chi_Squared (Input : String) return Float; -- Calculate Chi-Squared Scored to see the probability that some text is English Language
    function Count_Instances (Input : String; Token : Character) return Integer; -- Count the instances of a Character in a string
    function Count_Frequency (Input : String; Token : Character) return Float; -- Count the frequency of a Character in a string

private

    English_Letter_Frequency : constant array (Character) of Float := (
        'A' => 0.0595,
        'B' => 0.0144,
        'C' => 0.0322,
        'D' => 0.0266,
        'E' => 0.0906,
        'F' => 0.0096,
        'G' => 0.0212,
        'H' => 0.0182,
        'I' => 0.0709,
        'J' => 0.0012,
        'K' => 0.0066,
        'L' => 0.0418,
        'M' => 0.0223,
        'N' => 0.0539,
        'O' => 0.0518,
        'P' => 0.0231,
        'Q' => 0.0012,
        'R' => 0.0556,
        'S' => 0.0749,
        'T' => 0.0525,
        'U' => 0.0257,
        'V' => 0.0077,
        'W' => 0.0058,
        'X' => 0.0022,
        'Y' => 0.0128,
        'Z' => 0.0037,
        ' ' => 0.2127,
        others => 0.0
    );




























end English;