library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lutcos_block is
    Port (
        address      : in  std_logic_vector(9 downto 0);                    -- 640 alamat
        cosine_697     : out std_logic_vector(15 downto 0);  
        cosine_941     : out std_logic_vector(15 downto 0);  
        cosine_1477    : out std_logic_vector(15 downto 0)  
    );
end lutcos_block;

architecture Behavioral of lutcos_block is

    type sample_array is array (0 to 2) of std_logic_vector(15 downto 0);
    type rom_array is array (0 to 639) of sample_array;

    constant rom : rom_array := (
        (x"4000", x"4000", x"4000"), 
        (x"3F67", x"3EE9", x"3D54"), 
        (x"3D9E", x"3BAE", x"3588"), 
        (x"3AAE", x"366B", x"2945"), 
        (x"36A6", x"2F4D", x"198E"), 
        (x"3198", x"2694", x"07B6"), 
        (x"2B9C", x"1C8A", x"F538"), 
        (x"24D0", x"1188", x"E3A1"), 
        (x"1D53", x"05EC", x"D469"), 
        (x"154A", x"FA1D", x"C8D4"), 
        (x"0CDB", x"EE82", x"C1DB"), 
        (x"042E", x"E37F", x"C013"), 
        (x"FB6E", x"D974", x"C3A2"), 
        (x"F2C3", x"D0B9", x"CC3B"), 
        (x"EA58", x"C99A", x"D927"), 
        (x"E255", x"C455", x"E952"), 
        (x"DADF", x"C119", x"FB61"), 
        (x"D41B", x"C000", x"0DD4"), 
        (x"CE2A", x"C115", x"1F1E"), 
        (x"C927", x"C44E", x"2DD0"), 
        (x"C52A", x"C990", x"38AE"), 
        (x"C247", x"D0AC", x"3ED0"), 
        (x"C08C", x"D964", x"3FB3"), 
        (x"C000", x"E36D", x"3B44"), 
        (x"C0A7", x"EE6F", x"31E2"), 
        (x"C27D", x"FA0A", x"2456"), 
        (x"C57A", x"05D9", x"13C1"), 
        (x"C98E", x"1175", x"0185"), 
        (x"CEA8", x"1C79", x"EF29"), 
        (x"D4AD", x"2684", x"DE35"), 
        (x"DB82", x"2F40", x"D013"), 
        (x"E306", x"3661", x"C5F3"), 
        (x"EB14", x"3BA7", x"C0AB"), 
        (x"F387", x"3EE6", x"C0AD"), 
        (x"FC35", x"4000", x"C5F9"), 
        (x"04F5", x"3EED", x"D01E"), 
        (x"0D9E", x"3BB5", x"DE43"), 
        (x"1606", x"3675", x"EF39"), 
        (x"1E04", x"2F5A", x"0195"), 
        (x"2572", x"26A3", x"13D0"), 
        (x"2C2D", x"1C9B", x"2463"), 
        (x"3215", x"119A", x"31ED"), 
        (x"370D", x"05FF", x"3B4A"), 
        (x"3AFD", x"FA31", x"3FB5"), 
        (x"3DD3", x"EE94", x"3ECD"), 
        (x"3F81", x"E390", x"38A6"), 
        (x"3FFF", x"D983", x"2DC4"), 
        (x"3F4A", x"D0C6", x"1F10"), 
        (x"3D67", x"C9A4", x"0DC4"), 
        (x"3A5E", x"C45C", x"FB51"), 
        (x"363D", x"C11C", x"E943"), 
        (x"3119", x"C000", x"D91A"), 
        (x"2B09", x"C112", x"CC32"), 
        (x"242C", x"C448", x"C39C"), 
        (x"1CA1", x"C986", x"C012"), 
        (x"148D", x"D09F", x"C1DF"), 
        (x"0C17", x"D955", x"C8DD"), 
        (x"0367", x"E35C", x"D475"), 
        (x"FAA7", x"EE5D", x"E3B0"), 
        (x"F201", x"F9F7", x"F548"), 
        (x"E99D", x"05C6", x"07C6"), 
        (x"E1A4", x"1162", x"199D"), 
        (x"DA3D", x"1C67", x"2951"), 
        (x"D38B", x"2675", x"3591"), 
        (x"CDAD", x"2F33", x"3D58"), 
        (x"C8C1", x"3656", x"4000"), 
        (x"C4DD", x"3BA0", x"3D4F"), 
        (x"C214", x"3EE2", x"3580"), 
        (x"C073", x"4000", x"2938"), 
        (x"C003", x"3EF0", x"1980"), 
        (x"C0C5", x"3BBC", x"07A6"), 
        (x"C2B5", x"367F", x"F528"), 
        (x"C5CC", x"2F67", x"E393"), 
        (x"C9F8", x"26B3", x"D45D"), 
        (x"CF28", x"1CAD", x"C8CC"), 
        (x"D541", x"11AD", x"C1D8"), 
        (x"DC27", x"0613", x"C014"), 
        (x"E3B8", x"FA44", x"C3A7"), 
        (x"EBD1", x"EEA7", x"CC44"), 
        (x"F44B", x"E3A1", x"D934"), 
        (x"FCFC", x"D993", x"E961"), 
        (x"05BC", x"D0D3", x"FB71"), 
        (x"0E61", x"C9AF", x"0DE3"), 
        (x"16C0", x"C463", x"1F2C"), 
        (x"1EB3", x"C120", x"2DDB"), 
        (x"2613", x"C000", x"38B5"), 
        (x"2CBD", x"C10E", x"3ED3"), 
        (x"3290", x"C441", x"3FB1"), 
        (x"3771", x"C97C", x"3B3E"), 
        (x"3B49", x"D092", x"31D8"), 
        (x"3E05", x"D946", x"2449"), 
        (x"3F98", x"E34B", x"13B2"), 
        (x"3FFB", x"EE4A", x"0175"), 
        (x"3F2C", x"F9E4", x"EF1A"), 
        (x"3D2E", x"05B3", x"DE27"), 
        (x"3A0B", x"1150", x"D009"), 
        (x"35D2", x"1C56", x"C5EC"), 
        (x"3098", x"2666", x"C0A8"), 
        (x"2A75", x"2F26", x"C0AF"), 
        (x"2386", x"364C", x"C600"), 
        (x"1BEE", x"3B99", x"D029"), 
        (x"13D0", x"3EDE", x"DE50"), 
        (x"0B53", x"4000", x"EF48"), 
        (x"02A0", x"3EF4", x"01A5"), 
        (x"F9E1", x"3BC3", x"13DF"), 
        (x"F13E", x"3689", x"2471"), 
        (x"E8E2", x"2F74", x"31F7"), 
        (x"E0F5", x"26C2", x"3B50"), 
        (x"D99D", x"1CBE", x"3FB6"), 
        (x"D2FC", x"11BF", x"3ECA"), 
        (x"CD33", x"0626", x"389F"), 
        (x"C85D", x"FA57", x"2DB9"), 
        (x"C492", x"EEB9", x"1F02"), 
        (x"C1E2", x"E3B3", x"0DB4"), 
        (x"C05D", x"D9A2", x"FB41"), 
        (x"C008", x"D0E0", x"E934"), 
        (x"C0E5", x"C9B9", x"D90D"), 
        (x"C2F0", x"C46A", x"CC28"), 
        (x"C620", x"C123", x"C397"), 
        (x"CA64", x"C000", x"C012"), 
        (x"CFA9", x"C10B", x"C1E3"), 
        (x"D5D6", x"C43A", x"C8E5"), 
        (x"DCCD", x"C972", x"D480"), 
        (x"E46C", x"D085", x"E3BE"), 
        (x"EC8F", x"D936", x"F558"), 
        (x"F50F", x"E33A", x"07D6"), 
        (x"FDC3", x"EE38", x"19AC"), 
        (x"0683", x"F9D0", x"295D"), 
        (x"0F23", x"059F", x"359A"), 
        (x"177A", x"113D", x"3D5D"), 
        (x"1F62", x"1C45", x"4000"), 
        (x"26B3", x"2656", x"3D4B"), 
        (x"2D4A", x"2F19", x"3577"), 
        (x"3309", x"3642", x"292C"), 
        (x"37D4", x"3B92", x"1971"), 
        (x"3B93", x"3EDB", x"0796"), 
        (x"3E35", x"4000", x"F518"), 
        (x"3FAE", x"3EF7", x"E384"), 
        (x"3FF5", x"3BCA", x"D451"), 
        (x"3F0A", x"3693", x"C8C4"), 
        (x"3CF2", x"2F81", x"C1D4"), 
        (x"39B6", x"26D1", x"C015"), 
        (x"3565", x"1CCF", x"C3AC"), 
        (x"3015", x"11D2", x"CC4E"), 
        (x"29DF", x"0639", x"D941"), 
        (x"22E0", x"FA6A", x"E970"), 
        (x"1B3A", x"EECC", x"FB81"), 
        (x"1312", x"E3C4", x"0DF3"), 
        (x"0A8F", x"D9B2", x"1F3A"), 
        (x"01D9", x"D0ED", x"2DE6"), 
        (x"F91A", x"C9C3", x"38BD"), 
        (x"F07C", x"C472", x"3ED6"), 
        (x"E829", x"C127", x"3FB0"), 
        (x"E048", x"C000", x"3B38"), 
        (x"D8FE", x"C107", x"31CE"), 
        (x"D26F", x"C433", x"243C"), 
        (x"CCBB", x"C968", x"13A2"), 
        (x"C7FC", x"D078", x"0165"), 
        (x"C449", x"D927", x"EF0A"), 
        (x"C1B4", x"E328", x"DE1A"), 
        (x"C049", x"EE25", x"CFFE"), 
        (x"C00F", x"F9BD", x"C5E5"), 
        (x"C107", x"058C", x"C0A6"), 
        (x"C32D", x"112B", x"C0B2"), 
        (x"C676", x"1C34", x"C607"), 
        (x"CAD2", x"2647", x"D034"), 
        (x"D02D", x"2F0C", x"DE5E"), 
        (x"D66D", x"3638", x"EF58"), 
        (x"DD74", x"3B8B", x"01B5"), 
        (x"E520", x"3ED7", x"13EF"), 
        (x"ED4D", x"4000", x"247E"), 
        (x"F5D4", x"3EFB", x"3201"), 
        (x"FE8B", x"3BD1", x"3B56"), 
        (x"0749", x"369D", x"3FB8"), 
        (x"0FE4", x"2F8E", x"3EC6"), 
        (x"1834", x"26E1", x"3897"), 
        (x"200F", x"1CE0", x"2DAE"), 
        (x"2751", x"11E4", x"1EF4"), 
        (x"2DD6", x"064C", x"0DA4"), 
        (x"3381", x"FA7D", x"FB31"), 
        (x"3834", x"EEDF", x"E925"), 
        (x"3BDB", x"E3D5", x"D901"), 
        (x"3E63", x"D9C1", x"CC1F"), 
        (x"3FC0", x"D0FA", x"C392"), 
        (x"3FED", x"C9CD", x"C011"), 
        (x"3EE7", x"C479", x"C1E7"), 
        (x"3CB4", x"C12B", x"C8ED"), 
        (x"395E", x"C000", x"D48C"), 
        (x"34F6", x"C104", x"E3CC"), 
        (x"2F90", x"C42C", x"F568"), 
        (x"2947", x"C95E", x"07E6"), 
        (x"2238", x"D06B", x"19BA"), 
        (x"1A85", x"D918", x"2969"), 
        (x"1253", x"E317", x"35A3"), 
        (x"09CA", x"EE12", x"3D62"), 
        (x"0111", x"F9AA", x"4000"), 
        (x"F854", x"0579", x"3D46"), 
        (x"EFBB", x"1118", x"356E"), 
        (x"E770", x"1C22", x"2920"), 
        (x"DF9B", x"2637", x"1962"), 
        (x"D861", x"2EFF", x"0786"), 
        (x"D1E4", x"362E", x"F509"), 
        (x"CC44", x"3B84", x"E376"), 
        (x"C79C", x"3ED3", x"D446"), 
        (x"C402", x"4000", x"C8BC"), 
        (x"C187", x"3EFE", x"C1D0"), 
        (x"C037", x"3BD7", x"C016"), 
        (x"C019", x"36A7", x"C3B2"), 
        (x"C12C", x"2F9B", x"CC57"), 
        (x"C36C", x"26F0", x"D94D"), 
        (x"C6CE", x"1CF2", x"E97F"), 
        (x"CB42", x"11F7", x"FB91"), 
        (x"D0B3", x"0660", x"0E03"), 
        (x"D705", x"FA91", x"1F48"), 
        (x"DE1C", x"EEF1", x"2DF1"), 
        (x"E5D6", x"E3E6", x"38C4"), 
        (x"EE0C", x"D9D1", x"3ED9"), 
        (x"F699", x"D107", x"3FAE"), 
        (x"FF52", x"C9D8", x"3B32"), 
        (x"080F", x"C480", x"31C4"), 
        (x"10A5", x"C12E", x"242E"), 
        (x"18EC", x"C000", x"1393"), 
        (x"20BB", x"C100", x"0155"), 
        (x"27ED", x"C425", x"EEFB"), 
        (x"2E61", x"C954", x"DE0C"), 
        (x"33F6", x"D05E", x"CFF4"), 
        (x"3893", x"D908", x"C5DE"), 
        (x"3C20", x"E306", x"C0A4"), 
        (x"3E8E", x"EE00", x"C0B4"), 
        (x"3FD1", x"F997", x"C60E"), 
        (x"3FE2", x"0566", x"D03E"), 
        (x"3EC1", x"1105", x"DE6C"), 
        (x"3C73", x"1C11", x"EF67"), 
        (x"3905", x"2628", x"01C6"), 
        (x"3485", x"2EF2", x"13FE"), 
        (x"2F0A", x"3623", x"248B"), 
        (x"28AE", x"3B7D", x"320B"), 
        (x"218F", x"3ED0", x"3B5C"), 
        (x"19CF", x"3FFF", x"3FB9"), 
        (x"1194", x"3F01", x"3EC3"), 
        (x"0905", x"3BDE", x"3890"), 
        (x"004A", x"36B1", x"2DA3"), 
        (x"F78E", x"2FA8", x"1EE6"), 
        (x"EEFB", x"26FF", x"0D95"), 
        (x"E6B9", x"1D03", x"FB21"), 
        (x"DEF0", x"1209", x"E916"), 
        (x"D7C5", x"0673", x"D8F4"), 
        (x"D15B", x"FAA4", x"CC15"), 
        (x"CBD0", x"EF04", x"C38D"), 
        (x"C73F", x"E3F8", x"C010"), 
        (x"C3BE", x"D9E0", x"C1EB"), 
        (x"C15D", x"D115", x"C8F5"), 
        (x"C028", x"C9E2", x"D498"), 
        (x"C025", x"C487", x"E3DB"), 
        (x"C153", x"C132", x"F578"), 
        (x"C3AE", x"C001", x"07F6"), 
        (x"C729", x"C0FD", x"19C9"), 
        (x"CBB4", x"C41E", x"2976"), 
        (x"D13A", x"C949", x"35AC"), 
        (x"D79F", x"D052", x"3D66"), 
        (x"DEC6", x"D8F9", x"4000"), 
        (x"E68C", x"E2F5", x"3D41"), 
        (x"EECC", x"EDED", x"3565"), 
        (x"F75E", x"F984", x"2913"), 
        (x"001A", x"0552", x"1953"), 
        (x"08D5", x"10F3", x"0776"), 
        (x"1165", x"1BFF", x"F4F9"), 
        (x"19A3", x"2618", x"E368"), 
        (x"2166", x"2EE5", x"D43A"), 
        (x"2888", x"3619", x"C8B4"), 
        (x"2EE9", x"3B76", x"C1CC"), 
        (x"346A", x"3ECC", x"C017"), 
        (x"38EF", x"3FFF", x"C3B7"), 
        (x"3C64", x"3F05", x"CC61"), 
        (x"3EB7", x"3BE5", x"D95A"), 
        (x"3FDF", x"36BC", x"E98E"), 
        (x"3FD4", x"2FB5", x"FBA1"), 
        (x"3E98", x"270F", x"0E12"), 
        (x"3C31", x"1D14", x"1F56"), 
        (x"38A9", x"121C", x"2DFC"), 
        (x"3412", x"0686", x"38CB"), 
        (x"2E82", x"FAB7", x"3EDC"), 
        (x"2813", x"EF16", x"3FAD"), 
        (x"20E4", x"E409", x"3B2C"), 
        (x"1918", x"D9F0", x"31BA"), 
        (x"10D4", x"D122", x"2421"), 
        (x"083F", x"C9EC", x"1384"), 
        (x"FF83", x"C48E", x"0145"), 
        (x"F6C9", x"C136", x"EEEB"), 
        (x"EE3B", x"C001", x"DDFE"), 
        (x"E602", x"C0FA", x"CFE9"), 
        (x"DE45", x"C417", x"C5D8"), 
        (x"D72B", x"C93F", x"C0A2"), 
        (x"D0D3", x"D045", x"C0B7"), 
        (x"CB5E", x"D8EA", x"C615"), 
        (x"C6E4", x"E2E3", x"D049"), 
        (x"C37C", x"EDDB", x"DE79"), 
        (x"C135", x"F970", x"EF77"), 
        (x"C01B", x"053F", x"01D6"), 
        (x"C033", x"10E0", x"140D"), 
        (x"C17D", x"1BEE", x"2498"), 
        (x"C3F1", x"2609", x"3215"), 
        (x"C786", x"2ED8", x"3B62"), 
        (x"CC28", x"360F", x"3FBB"), 
        (x"D1C3", x"3B6E", x"3EC0"), 
        (x"D83B", x"3EC8", x"3888"), 
        (x"DF71", x"3FFF", x"2D97"), 
        (x"E744", x"3F08", x"1ED8"), 
        (x"EF8D", x"3BEC", x"0D85"), 
        (x"F824", x"36C6", x"FB11"), 
        (x"00E1", x"2FC2", x"E906"), 
        (x"099A", x"271E", x"D8E7"), 
        (x"1225", x"1D25", x"CC0C"), 
        (x"1A59", x"122E", x"C387"), 
        (x"220F", x"0699", x"C010"), 
        (x"2922", x"FACA", x"C1EF"), 
        (x"2F70", x"EF29", x"C8FD"), 
        (x"34DB", x"E41B", x"D4A4"), 
        (x"3949", x"D9FF", x"E3E9"), 
        (x"3CA4", x"D12F", x"F587"), 
        (x"3EDE", x"C9F7", x"0805"), 
        (x"3FEA", x"C495", x"19D8"), 
        (x"3FC5", x"C13A", x"2982"), 
        (x"3E6E", x"C001", x"35B4"), 
        (x"3BEC", x"C0F6", x"3D6B"), 
        (x"384B", x"C411", x"4000"), 
        (x"339D", x"C936", x"3D3D"), 
        (x"2DF8", x"D038", x"355C"), 
        (x"2777", x"D8DA", x"2907"), 
        (x"2039", x"E2D2", x"1944"), 
        (x"1860", x"EDC8", x"0766"), 
        (x"1013", x"F95D", x"F4E9"), 
        (x"0779", x"052C", x"E359"), 
        (x"FEBB", x"10CE", x"D42E"), 
        (x"F603", x"1BDD", x"C8AC"), 
        (x"ED7B", x"25F9", x"C1C8"), 
        (x"E54C", x"2ECB", x"C017"), 
        (x"DD9D", x"3604", x"C3BD"), 
        (x"D692", x"3B67", x"CC6A"), 
        (x"D04D", x"3EC5", x"D967"), 
        (x"CAED", x"3FFF", x"E99D"), 
        (x"C68B", x"3F0B", x"FBB1"), 
        (x"C33C", x"3BF3", x"0E22"), 
        (x"C110", x"36CF", x"1F64"), 
        (x"C011", x"2FCF", x"2E08"), 
        (x"C044", x"272D", x"38D3"), 
        (x"C1A9", x"1D36", x"3EDF"), 
        (x"C437", x"1241", x"3FAB"), 
        (x"C7E4", x"06AC", x"3B26"), 
        (x"CC9E", x"FADE", x"31B0"), 
        (x"D24E", x"EF3C", x"2414"), 
        (x"D8D8", x"E42C", x"1374"), 
        (x"E01E", x"DA0F", x"0135"), 
        (x"E7FC", x"D13C", x"EEDC"), 
        (x"F04E", x"CA01", x"DDF1"), 
        (x"F8EA", x"C49C", x"CFDE"), 
        (x"01A9", x"C13D", x"C5D1"), 
        (x"0A5F", x"C001", x"C09F"), 
        (x"12E4", x"C0F3", x"C0B9"), 
        (x"1B0E", x"C40A", x"C61B"), 
        (x"22B7", x"C92C", x"D054"), 
        (x"29BA", x"D02B", x"DE87"), 
        (x"2FF5", x"D8CB", x"EF86"), 
        (x"354A", x"E2C1", x"01E6"), 
        (x"39A1", x"EDB6", x"141D"), 
        (x"3CE3", x"F94A", x"24A5"), 
        (x"3F02", x"0519", x"321F"), 
        (x"3FF3", x"10BB", x"3B68"), 
        (x"3FB2", x"1BCB", x"3FBC"), 
        (x"3E41", x"25EA", x"3EBD"), 
        (x"3BA5", x"2EBD", x"3881"), 
        (x"37EB", x"35FA", x"2D8C"), 
        (x"3326", x"3B60", x"1ECA"), 
        (x"2D6C", x"3EC1", x"0D75"), 
        (x"26D9", x"3FFF", x"FB01"), 
        (x"1F8C", x"3F0F", x"E8F7"), 
        (x"17A7", x"3BF9", x"D8DA"), 
        (x"0F52", x"36D9", x"CC02"), 
        (x"06B3", x"2FDB", x"C382"), 
        (x"FDF4", x"273C", x"C00F"), 
        (x"F53F", x"1D47", x"C1F3"), 
        (x"ECBD", x"1253", x"C906"), 
        (x"E497", x"06C0", x"D4B0"), 
        (x"DCF5", x"FAF1", x"E3F8"), 
        (x"D5FA", x"EF4E", x"F597"), 
        (x"CFC9", x"E43D", x"0815"), 
        (x"CA7F", x"DA1E", x"19E7"), 
        (x"C634", x"D149", x"298E"), 
        (x"C2FE", x"CA0B", x"35BD"), 
        (x"C0ED", x"C4A4", x"3D6F"), 
        (x"C009", x"C141", x"4000"), 
        (x"C058", x"C002", x"3D38"), 
        (x"C1D7", x"C0F0", x"3553"), 
        (x"C480", x"C403", x"28FB"), 
        (x"C845", x"C922", x"1936"), 
        (x"CD16", x"D01E", x"0756"), 
        (x"D2DA", x"D8BC", x"F4D9"), 
        (x"D976", x"E2B0", x"E34B"), 
        (x"E0CB", x"EDA3", x"D422"), 
        (x"E8B6", x"F937", x"C8A4"), 
        (x"F10F", x"0505", x"C1C5"), 
        (x"F9B0", x"10A8", x"C018"), 
        (x"0270", x"1BBA", x"C3C2"), 
        (x"0B24", x"25DA", x"CC74"), 
        (x"13A2", x"2EB0", x"D974"), 
        (x"1BC3", x"35F0", x"E9AC"), 
        (x"235E", x"3B59", x"FBC1"), 
        (x"2A51", x"3EBD", x"0E32"), 
        (x"3078", x"3FFE", x"1F72"), 
        (x"35B8", x"3F12", x"2E13"), 
        (x"39F6", x"3C00", x"38DA"), 
        (x"3D1F", x"36E3", x"3EE2"), 
        (x"3F24", x"2FE8", x"3FA9"), 
        (x"3FFA", x"274C", x"3B20"), 
        (x"3F9E", x"1D59", x"31A6"), 
        (x"3E11", x"1266", x"2406"), 
        (x"3B5B", x"06D3", x"1365"), 
        (x"3789", x"FB04", x"0125"), 
        (x"32AD", x"EF61", x"EECC"), 
        (x"2CDF", x"E44F", x"DDE3"), 
        (x"263A", x"DA2E", x"CFD4"), 
        (x"1EDE", x"D156", x"C5CA"), 
        (x"16ED", x"CA16", x"C09D"), 
        (x"0E90", x"C4AB", x"C0BB"), 
        (x"05EC", x"C145", x"C622"), 
        (x"FD2C", x"C002", x"D05E"), 
        (x"F47A", x"C0EC", x"DE95"), 
        (x"EBFF", x"C3FC", x"EF96"), 
        (x"E3E4", x"C918", x"01F6"), 
        (x"DC4F", x"D011", x"142C"), 
        (x"D565", x"D8AD", x"24B3"), 
        (x"CF47", x"E29F", x"3229"), 
        (x"CA12", x"ED91", x"3B6E"), 
        (x"C5E0", x"F924", x"3FBE"), 
        (x"C2C3", x"04F2", x"3EBA"), 
        (x"C0CC", x"1096", x"3879"), 
        (x"C004", x"1BA9", x"2D81"), 
        (x"C06D", x"25CA", x"1EBC"), 
        (x"C208", x"2EA3", x"0D65"), 
        (x"C4CA", x"35E5", x"FAF1"), 
        (x"C8A9", x"3B52", x"E8E8"), 
        (x"CD90", x"3EB9", x"D8CE"), 
        (x"D368", x"3FFE", x"CBF9"), 
        (x"DA16", x"3F15", x"C37D"), 
        (x"E17A", x"3C07", x"C00E"), 
        (x"E970", x"36ED", x"C1F7"), 
        (x"F1D1", x"2FF5", x"C90E"), 
        (x"FA77", x"275B", x"D4BB"), 
        (x"0337", x"1D6A", x"E406"), 
        (x"0BE8", x"1278", x"F5A7"), 
        (x"1460", x"06E6", x"0825"), 
        (x"1C76", x"FB17", x"19F5"), 
        (x"2404", x"EF74", x"299A"), 
        (x"2AE5", x"E460", x"35C6"), 
        (x"30FA", x"DA3D", x"3D74"), 
        (x"3623", x"D164", x"4000"), 
        (x"3A4A", x"CA20", x"3D33"), 
        (x"3D59", x"C4B2", x"354A"), 
        (x"3F43", x"C149", x"28EE"), 
        (x"3FFE", x"C002", x"1927"), 
        (x"3F87", x"C0E9", x"0746"), 
        (x"3DDF", x"C3F6", x"F4C9"), 
        (x"3B10", x"C90E", x"E33C"), 
        (x"3725", x"D005", x"D417"), 
        (x"3233", x"D89E", x"C89C"), 
        (x"2C50", x"E28E", x"C1C1"), 
        (x"2599", x"ED7E", x"C019"), 
        (x"1E2E", x"F910", x"C3C8"), 
        (x"1633", x"04DF", x"CC7D"), 
        (x"0DCD", x"1083", x"D981"), 
        (x"0526", x"1B97", x"E9BB"), 
        (x"FC65", x"25BB", x"FBD2"), 
        (x"F3B6", x"2E96", x"0E41"), 
        (x"EB42", x"35DB", x"1F80"), 
        (x"E331", x"3B4A", x"2E1E"), 
        (x"DBAA", x"3EB5", x"38E2"), 
        (x"D4D1", x"3FFE", x"3EE5"), 
        (x"CEC6", x"3F19", x"3FA8"), 
        (x"C9A8", x"3C0E", x"3B19"), 
        (x"C58D", x"36F7", x"319C"), 
        (x"C28B", x"3002", x"23F9"), 
        (x"C0AE", x"276A", x"1356"), 
        (x"C001", x"1D7B", x"0115"), 
        (x"C086", x"128B", x"EEBD"), 
        (x"C23B", x"06F9", x"DDD6"), 
        (x"C517", x"FB2B", x"CFC9"), 
        (x"C90E", x"EF86", x"C5C3"), 
        (x"CE0B", x"E472", x"C09B"), 
        (x"D3F8", x"DA4D", x"C0BE"), 
        (x"DAB8", x"D171", x"C629"), 
        (x"E22A", x"CA2A", x"D069"), 
        (x"EA2B", x"C4B9", x"DEA3"), 
        (x"F294", x"C14D", x"EFA5"), 
        (x"FB3E", x"C002", x"0206"), 
        (x"03FE", x"C0E6", x"143B"), 
        (x"0CAC", x"C3EF", x"24C0"), 
        (x"151C", x"C904", x"3233"), 
        (x"1D28", x"CFF8", x"3B74"), 
        (x"24A8", x"D88E", x"3FBF"), 
        (x"2B79", x"E27D", x"3EB7"), 
        (x"3179", x"ED6C", x"3871"), 
        (x"368D", x"F8FD", x"2D75"), 
        (x"3A9B", x"04CC", x"1EAE"), 
        (x"3D91", x"1070", x"0D56"), 
        (x"3F60", x"1B86", x"FAE1"), 
        (x"4000", x"25AB", x"E8D9"), 
        (x"3F6D", x"2E89", x"D8C1"), 
        (x"3DAB", x"35D0", x"CBF0"), 
        (x"3AC2", x"3B43", x"C378"), 
        (x"36BF", x"3EB1", x"C00E"), 
        (x"31B6", x"3FFD", x"C1FB"), 
        (x"2BBF", x"3F1C", x"C916"), 
        (x"24F7", x"3C14", x"D4C7"), 
        (x"1D7E", x"3701", x"E415"), 
        (x"1577", x"300F", x"F5B7"), 
        (x"0D0A", x"2779", x"0835"), 
        (x"045F", x"1D8C", x"1A04"), 
        (x"FB9E", x"129D", x"29A7"), 
        (x"F2F3", x"070C", x"35CF"), 
        (x"EA86", x"FB3E", x"3D78"), 
        (x"E27F", x"EF99", x"3FFF"), 
        (x"DB06", x"E483", x"3D2F"), 
        (x"D43E", x"DA5D", x"3542"), 
        (x"CE48", x"D17E", x"28E2"), 
        (x"C93F", x"CA35", x"1918"), 
        (x"C53D", x"C4C1", x"0736"), 
        (x"C254", x"C151", x"F4B9"), 
        (x"C092", x"C003", x"E32E"), 
        (x"C000", x"C0E3", x"D40B"), 
        (x"C0A0", x"C3E8", x"C894"), 
        (x"C270", x"C8FA", x"C1BD"), 
        (x"C566", x"CFEB", x"C01A"), 
        (x"C975", x"D87F", x"C3CD"), 
        (x"CE89", x"E26B", x"CC87"), 
        (x"D48A", x"ED5A", x"D98E"), 
        (x"DB5B", x"F8EA", x"E9CA"), 
        (x"E2DB", x"04B8", x"FBE2"), 
        (x"EAE7", x"105E", x"0E51"), 
        (x"F357", x"1B74", x"1F8E"), 
        (x"FC05", x"259C", x"2E29"), 
        (x"04C5", x"2E7B", x"38E9"), 
        (x"0D6F", x"35C6", x"3EE8"), 
        (x"15D8", x"3B3C", x"3FA6"), 
        (x"1DD9", x"3EAE", x"3B13"), 
        (x"254B", x"3FFD", x"3191"), 
        (x"2C0A", x"3F1F", x"23EC"), 
        (x"31F7", x"3C1B", x"1346"), 
        (x"36F4", x"370B", x"0105"), 
        (x"3AEA", x"301B", x"EEAD"), 
        (x"3DC6", x"2788", x"DDC8"), 
        (x"3F7B", x"1D9D", x"CFBF"), 
        (x"3FFF", x"12B0", x"C5BD"), 
        (x"3F51", x"071F", x"C099"), 
        (x"3D75", x"FB51", x"C0C0"), 
        (x"3A71", x"EFAC", x"C630"), 
        (x"3656", x"E494", x"D074"), 
        (x"3137", x"DA6C", x"DEB0"), 
        (x"2B2D", x"D18B", x"EFB5"), 
        (x"2453", x"CA3F", x"0216"), 
        (x"1CCC", x"C4C8", x"144A"), 
        (x"14BB", x"C154", x"24CD"), 
        (x"0C47", x"C003", x"323D"), 
        (x"0398", x"C0DF", x"3B7A"), 
        (x"FAD7", x"C3E2", x"3FC0"), 
        (x"F230", x"C8F0", x"3EB3"), 
        (x"E9CA", x"CFDE", x"386A"), 
        (x"E1CF", x"D870", x"2D6A"), 
        (x"DA64", x"E25A", x"1E9F"), 
        (x"D3AE", x"ED47", x"0D46"), 
        (x"CDCB", x"F8D7", x"FAD1"), 
        (x"C8D9", x"04A5", x"E8CA"), 
        (x"C4EF", x"104B", x"D8B4"), 
        (x"C220", x"1B63", x"CBE6"), 
        (x"C079", x"258C", x"C372"), 
        (x"C002", x"2E6E", x"C00D"), 
        (x"C0BD", x"35BB", x"C1FF"), 
        (x"C2A8", x"3B34", x"C91E"), 
        (x"C5B8", x"3EAA", x"D4D3"), 
        (x"C9DE", x"3FFD", x"E423"), 
        (x"CF09", x"3F22", x"F5C7"), 
        (x"D51D", x"3C21", x"0845"), 
        (x"DBFF", x"3715", x"1A13"), 
        (x"E38D", x"3028", x"29B3"), 
        (x"EBA3", x"2798", x"35D7"), 
        (x"F41B", x"1DAE", x"3D7D"), 
        (x"FCCC", x"12C2", x"3FFF"), 
        (x"058C", x"0733", x"3D2A"), 
        (x"0E32", x"FB64", x"3539"), 
        (x"1693", x"EFBE", x"28D5"), 
        (x"1E89", x"E4A6", x"1909"), 
        (x"25EC", x"DA7C", x"0726"), 
        (x"2C9A", x"D199", x"F4AA"), 
        (x"3272", x"CA4A", x"E320"), 
        (x"3759", x"C4CF", x"D3FF"), 
        (x"3B37", x"C158", x"C88C"), 
        (x"3DF9", x"C003", x"C1B9"), 
        (x"3F93", x"C0DC", x"C01B"), 
        (x"3FFC", x"C3DB", x"C3D2"), 
        (x"3F33", x"C8E6", x"CC91"), 
        (x"3D3C", x"CFD2", x"D99A"), 
        (x"3A1F", x"D861", x"E9D9"), 
        (x"35EC", x"E249", x"FBF2"), 
        (x"30B7", x"ED35", x"0E61"), 
        (x"2A99", x"F8C4", x"1F9C"), 
        (x"23AF", x"0492", x"2E34"), 
        (x"1C1A", x"1038", x"38F0"), 
        (x"13FE", x"1B51", x"3EEB"), 
        (x"0B83", x"257C", x"3FA4"), 
        (x"02D0", x"2E61", x"3B0D"), 
        (x"FA11", x"35B1", x"3187"), 
        (x"F16D", x"3B2D", x"23DF"), 
        (x"E90F", x"3EA6", x"1337"), 
        (x"E120", x"3FFC", x"00F4"), 
        (x"D9C4", x"3F25", x"EE9E"), 
        (x"D31F", x"3C28", x"DDBA"), 
        (x"CD51", x"371F", x"CFB4"), 
        (x"C875", x"3035", x"C5B6"), 
        (x"C4A4", x"27A7", x"C097"), 
        (x"C1EE", x"1DBF", x"C0C3"), 
        (x"C062", x"12D5", x"C637"), 
        (x"C006", x"0746", x"D07F"), 
        (x"C0DD", x"FB78", x"DEBE"), 
        (x"C2E2", x"EFD1", x"EFC5"), 
        (x"C60B", x"E4B7", x"0226"), 
        (x"CA4A", x"DA8B", x"145A"), 
        (x"CF8A", x"D1A6", x"24DA"), 
        (x"D5B2", x"CA54", x"3247"), 
        (x"DCA4", x"C4D7", x"3B80"), 
        (x"E440", x"C15C", x"3FC2"), 
        (x"EC61", x"C004", x"3EB0"), 
        (x"F4DF", x"C0D9", x"3862"), 
        (x"FD93", x"C3D5", x"2D5F"), 
        (x"0653", x"C8DD", x"1E91"), 
        (x"0EF4", x"CFC5", x"0D36"), 
        (x"174D", x"D852", x"FAC1"), 
        (x"1F38", x"E238", x"E8BB"), 
        (x"268C", x"ED22", x"D8A8"), 
        (x"2D28", x"F8B1", x"CBDD"), 
        (x"32EC", x"047F", x"C36D"), 
        (x"37BC", x"1026", x"C00C")
    );

begin
    cosine_697   <= rom(to_integer(unsigned(address)))(0);
    cosine_941   <= rom(to_integer(unsigned(address)))(1);
    cosine_1477  <= rom(to_integer(unsigned(address)))(2);
end Behavioral;
