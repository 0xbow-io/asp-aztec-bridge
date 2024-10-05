//Chainalysis Categories
mod Chainalysis {
    global CHILD_ABUSE_MATERIAL = "1";
    global DARKNET_MARKET = "2";
    global SANCTIONED_ENTITY = "3";
    global NO_KYC_EXCHANGE = "4";
    global STOLEN_FUNDS = "6";
    global RANSOMWARE = "12";
    global MIXING = "13";
    global ICO = "14";
    global GAMBLING = "16";
    global SCAM = "18";
    global EXCHANGE = "21";
    global TERRORIST_FINANCING = "23";
    global SANCTIONED_JURISDICTION = "25";
    global FRAUD_SHOP = "28";
    global ILLICIT_ACTOR_ORG = "29";
    global SPECIAL_MEASURES = "34";
    global MALWARE = "35";
    global SEIZED_FUNDS = "39";
}

//Bitmap Categories
global TERRORISM: Field = 2;          
global SCAM: Field = 4;               
global MONEY_LAUNDERING: Field = 8;   
global EXPLOIT: Field = 16;           
global INDIRECT_OFAC: Field = 32;     
global DIRECT_OFAC: Field = 64;       
global INDIRECT_KYC: Field = 128;     
global DIRECT_KYC: Field = 256;       
global CEX: Field = 512;            
