use dep::json_parser::JSON2kb::JSON;
use crate::categories::Bitmap;
use crate::categories::Chainalysis::{TERRORIST_FINANCING, SCAM, FRAUD_SHOP, ICO, MIXING, SEIZED_FUNDS, GAMBLING, SPECIAL_MEASURES, STOLEN_FUNDS, RANSOMWARE, MALWARE, SANCTIONED_JURISDICTION, NO_KYC_EXCHANGE, EXCHANGE, CHILD_ABUSE_MATERIAL, DARKNET_MARKET, ILLICIT_ACTOR_ORG, SANCTIONED_ENTITY};
use crate::global_values::{MAX_JSON_LEN, MAX_TREF_LEN, MAX_TXHASH_LEN};

mod parse;
mod categories;
mod verifiers;
mod global_values;

/**
* @note - NOTE: Verify keys step is technically not needed as the parse_json function will 
* fail an assertion if the expected keys are not found. Saves about 1k Opcodes. However, it may cut down computation time
* if the supplied JSON has invalid keys.
**/

fn main(json_string : str<MAX_JSON_LEN>, transferReference : pub str<MAX_TREF_LEN>, transactionHash : pub str<MAX_TXHASH_LEN>) -> pub Field {
    
    let json: JSON = JSON::parse_json_from_string(json_string);

    // 1. we verify the keys first, we ensure that the expected keys are the same as the json retrieved keys
    
    let result = verifiers::verify_keys(json);
    assert(result == 36, f"not enough valid keys counted: {result}/36"); 
    
    // 2. we then verify the public inputs vs the json retrieved data

    verifiers::verify_public_inputs(json, transactionHash, transferReference);

    // Reasoning: we do these checks first before executing larger computations via retrieving values from the JSON (i.e. the next step).

    // 3. if there are no issues, we continue parsing the JSON, this step also further validates the schema and returns a validated JSON struct containing all the values
    let validated_json = parse::parse_json(json);

    // 4. evaluates the data and reviews for a certain category
    let category = evaluate(validated_json);

    // 5. return the retrieved category
    category
}

/**
* @info - evaluates the JSON data and returns a bitmap based on the category checks
* @param json: parse::ValidatedJSON - a validated JSON struct containing all the values
* @return Field - a bitmap containing the categories that were found in the JSON
**/
fn evaluate(json: parse::ValidatedJSON) -> Field {

    //categoryId should return a value. If it is empty, the JSON is invalid. An ID of 20 should be returned if it is "None".
    assert(json.categoryId.len() > 0, "categoryId is empty");

    let mut bitmap: Field = 0;

    is_terrorism(json, &mut bitmap);
    is_scam(json, &mut bitmap);
    is_money_laundering(json, &mut bitmap);
    is_exploit(json, &mut bitmap);
    is_indirect_ofac(json, &mut bitmap);
    is_direct_ofac(json, &mut bitmap);
    is_indirect_kyc(json, &mut bitmap);
    is_direct_kyc(json, &mut bitmap);
    is_cex(json, &mut bitmap);

    bitmap

    
}

/**
* @info - checks the categoryId from the JSON, if the id is 23(TERRORIST_FINANCING) or 29(ILLICIT_ACTOR_ORG) the Terrorism category 
* value is added to the bitmap.
* @param json: parse::ValidatedJSON - a validated JSON struct containing all the values
* @param bitmap_value: &mut Field - a mutable reference to a Field that will be updated based on the category checks
**/
fn is_terrorism(json: parse::ValidatedJSON, bitmap_value: &mut Field) {
    let value: Field = Bitmap::TERRORISM;
    
    let conditions = (json.categoryId == BoundedVec::from_array(TERRORIST_FINANCING.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(ILLICIT_ACTOR_ORG.as_bytes()));
    
    if conditions {
        *bitmap_value += value;
    }
}

/**
* @info - checks the categoryId from the JSON, if the id is 18(SCAM) or 28(FRAUD_SHOP) or 14(ICO) or 
* 29(ILLICIT_ACTOR_ORG) the Scam category value is added to the bitmap.
* @param json: parse::ValidatedJSON - a validated JSON struct containing all the values
* @param bitmap_value: &mut Field - a mutable reference to a Field that will be updated based on the category checks
**/
fn is_scam(json: parse::ValidatedJSON, bitmap_value: &mut Field) {
    let value: Field = Bitmap::SCAM;
    
    //Noir does not support || or && so we need to use bitwise operators
    let conditions = (json.categoryId == BoundedVec::from_array(SCAM.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(FRAUD_SHOP.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(ILLICIT_ACTOR_ORG.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(ICO.as_bytes()));

    if conditions {
        *bitmap_value += value;
    }
}

/**
* @info - checks the categoryId from the JSON, if the id is 13(MIXING) or 39(SEIZED_FUNDS) or 16(GAMBLING) or 
* 1(CHILD_ABUSE_MATERIAL) or 3(DARKNET_MARKET) or 34(SPECIAL_MEASURES) the Money Laundering category value is added to the bitmap.
* @param json: parse::ValidatedJSON - a validated JSON struct containing all the values
* @param bitmap_value: &mut Field - a mutable reference to a Field that will be updated based on the category checks
**/
fn is_money_laundering(json: parse::ValidatedJSON, bitmap_value: &mut Field) {
    let value: Field = Bitmap::MONEY_LAUNDERING;

    let conditions = (json.categoryId == BoundedVec::from_array(MIXING.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(SEIZED_FUNDS.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(GAMBLING.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(CHILD_ABUSE_MATERIAL.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(DARKNET_MARKET.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(SPECIAL_MEASURES.as_bytes()));

    if conditions {
        *bitmap_value += value;
    }

}

/**
* @info - checks the categoryId from the JSON, if the id is 6(STOLEN_FUNDS) or 12(RANSOMWARE) or 35(MALWARE) the Exploit category value is added to the bitmap.
* @param json: parse::ValidatedJSON - a validated JSON struct containing all the values
* @param bitmap_value: &mut Field - a mutable reference to a Field that will be updated based on the category checks
**/
fn is_exploit(json: parse::ValidatedJSON, bitmap_value: &mut Field) {
    let value: Field = Bitmap::EXPLOIT;

    let conditions = (json.categoryId == BoundedVec::from_array(STOLEN_FUNDS.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(RANSOMWARE.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(MALWARE.as_bytes()));

    if conditions {
        *bitmap_value += value;
    }
}

/**
* @info - checks the categoryId & exposureType from the JSON. If the categoryId is 25(SANCTIONED_JURISDICTION) AND
* 3(SANCTIONED_ENTITY) AND exposureType is "INDIRECT" then the Indirect OFAC category value is added to the bitmap. 
* @param json: parse::ValidatedJSON - a validated JSON struct containing all the values
* @param bitmap_value: &mut Field - a mutable reference to a Field that will be updated based on the category checks
**/
fn is_indirect_ofac(json: parse::ValidatedJSON, bitmap_value: &mut Field) {
    let value: Field = Bitmap::INDIRECT_OFAC;

    let conditions = ((json.categoryId == BoundedVec::from_array(SANCTIONED_JURISDICTION.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(SANCTIONED_ENTITY.as_bytes()))) &
                     (json.exposureType == BoundedVec::from_array("INDIRECT".as_bytes()));

    if conditions {
        *bitmap_value += value;
    }
}

/**
* @info - checks the categoryId & exposureType from the JSON. If the categoryId is 25(SANCTIONED_JURISDICTION) OR 3(SANCTIONED_ENTITY) 
* AND exposureType is "DIRECT" then the Direct OFAC category value is added to the bitmap.
* @param json: parse::ValidatedJSON - a validated JSON struct containing all the values
* @param bitmap_value: &mut Field - a mutable reference to a Field that will be updated based on the category checks
**/
fn is_direct_ofac(json: parse::ValidatedJSON, bitmap_value: &mut Field) {
    let value: Field = Bitmap::DIRECT_OFAC;

    let conditions = ((json.categoryId == BoundedVec::from_array(SANCTIONED_JURISDICTION.as_bytes())) |
                     (json.categoryId == BoundedVec::from_array(SANCTIONED_ENTITY.as_bytes()))) &
                     (json.exposureType == BoundedVec::from_array("DIRECT".as_bytes()));

    if conditions {
        *bitmap_value += value;
    }
}

/**
* @info - checks the categoryId & exposureType from the JSON. If the categoryId is 25(SANCTIONED_JURISDICTION) AND 
* exposureType is "DIRECT" then the Direct OFAC category value is added to the bitmap.
* @param json: parse::ValidatedJSON - a validated JSON struct containing all the values
* @param bitmap_value: &mut Field - a mutable reference to a Field that will be updated based on the category checks
**/
fn is_indirect_kyc(json: parse::ValidatedJSON, bitmap_value: &mut Field) {
    let value: Field = Bitmap::INDIRECT_KYC;

    let conditions = (json.categoryId == BoundedVec::from_array(NO_KYC_EXCHANGE.as_bytes())) &
                     (json.exposureType == BoundedVec::from_array("INDIRECT".as_bytes()));

    if conditions {
        *bitmap_value += value;
    }
}

/**
* @info - checks the categoryId & exposureType from the JSON. If the categoryId is 25(SANCTIONED_JURISDICTION) AND 
* exposureType is "DIRECT" then the Direct OFAC category value is added to the bitmap.
* @param json: parse::ValidatedJSON - a validated JSON struct containing all the values
* @param bitmap_value: &mut Field - a mutable reference to a Field that will be updated based on the category checks
**/
fn is_direct_kyc(json: parse::ValidatedJSON, bitmap_value: &mut Field) {
    let value: Field = Bitmap::DIRECT_KYC;

    let conditions = (json.categoryId == BoundedVec::from_array(NO_KYC_EXCHANGE.as_bytes())) &
                     (json.exposureType == BoundedVec::from_array("DIRECT".as_bytes()));

    if conditions {
        *bitmap_value += value;
    }
}

/**
* @info - checks the categoryId from the JSON, if the categoryId is 21(EXCHANGE) then the CEX category value is added to the bitmap.
* @param json: parse::ValidatedJSON - a validated JSON struct containing all the values
* @param bitmap_value: &mut Field - a mutable reference to a Field that will be updated based on the category checks
**/
fn is_cex(json: parse::ValidatedJSON, bitmap_value: &mut Field) {
    let value: Field = Bitmap::CEX;

    if json.categoryId == BoundedVec::from_array(EXCHANGE.as_bytes()) {
        *bitmap_value += value;
    }
}

#[test]
fn test_terrorism() {
    let json_string_list = [
        //29(ILLICIT_ACTOR_ORG)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"23\",\"customGroupExternalId\":\"null\"}]}                                                                                     ",
        //23(TERRORIST_FINANCING)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"29\",\"customGroupExternalId\":\"null\"}]}                                                                                     "
    ];
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";

    for i in 0..1 {
        let result = main(json_string_list[i], public_input_transRef, public_input_txHash);
        assert(result == Bitmap::TERRORISM, "Terrorism category not detected");
    }
}

#[test]
fn test_scam() {
    
    let json_string_list = [
        //18(SCAM)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"18\",\"customGroupExternalId\":\"null\"}]}                                                                                     ",
        //28(FRAUD_SHOP)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"28\",\"customGroupExternalId\":\"null\"}]}                                                                                     ",
        //14(ICO)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"14\",\"customGroupExternalId\":\"null\"}]}                                                                                     ",
        //29(ILLICIT_ACTOR_ORG)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"29\",\"customGroupExternalId\":\"null\"}]}                                                                                     ",
    ];
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";

    for i in 0..3 {
        let result = main(json_string_list[i], public_input_transRef, public_input_txHash);
        assert(result == Bitmap::SCAM, "Scam category not detected");
    }
}

#[test]
fn test_money_laundering() {
    
    let json_string_list = [
        //13(MIXING)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"13\",\"customGroupExternalId\":\"null\"}]}                                                                                     ",
        //39(SEIZED_FUNDS) 
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"39\",\"customGroupExternalId\":\"null\"}]}                                                                                     ",
        //39(GAMBLING)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"16\",\"customGroupExternalId\":\"null\"}]}                                                                                     ",
        //1(CHILD_ABUSE_MATERIAL)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"1\",\"customGroupExternalId\":\"null\"}]}                                                                                      ",
        //2(DARKNET_MARKET)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ",
        //34(SPECIAL_MEASURES)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"34\",\"customGroupExternalId\":\"null\"}]}                                                                                     ",
    ];
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";

    for i in 0..5 {
        let result = main(json_string_list[i], public_input_transRef, public_input_txHash);
        assert(result == Bitmap::MONEY_LAUNDERING, "Money laundering category not detected");
    }
}

#[test]
fn test_exploit() {
    let json_string_list = [
        //6(STOLEN_FUNDS)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"6\",\"customGroupExternalId\":\"null\"}]}                                                                                      ",
        //12(RANSOMWARE)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"12\",\"customGroupExternalId\":\"null\"}]}                                                                                     ",
        //35(MALWARE)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"35\",\"customGroupExternalId\":\"null\"}]}                                                                                     ",

    ];
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";

    for i in 0..2 {
        let result = main(json_string_list[i], public_input_transRef, public_input_txHash);
        assert(result == Bitmap::EXPLOIT, "Exploit category not detected");
    }
    
}

#[test]
fn test_direct_ofac() {
    
    let json_string_list = [
        //25(SANCTIONED_JURISDICTION)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"25\",\"customGroupExternalId\":\"null\"}]}                                                                                     ",
        //3(SANCTIONED_ENTITY)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"3\",\"customGroupExternalId\":\"null\"}]}                                                                                      ",
    ];
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";

    for i in 0..1 {
        let result = main(json_string_list[i], public_input_transRef, public_input_txHash);
        assert(result == Bitmap::DIRECT_OFAC, "Direct OFAC category not detected");
    }
}

#[test]
fn test_indirect_ofac() {
    
    let json_string_list = [
        //25(SANCTIONED_JURISDICTION)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"INDIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"25\",\"customGroupExternalId\":\"null\"}]}                                                                                   ",
        //3(SANCTIONED_ENTITY)
        "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"INDIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"3\",\"customGroupExternalId\":\"null\"}]}                                                                                    ",
    ];
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";

    for i in 0..1 {
        let result = main(json_string_list[i], public_input_transRef, public_input_txHash);
        assert(result == Bitmap::INDIRECT_OFAC, "Indirect OFAC category not detected");
    }
}

#[test]
fn test_direct_kyc() {
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"4\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";
    let result = main(json_string, public_input_transRef, public_input_txHash);
    assert(result == Bitmap::DIRECT_KYC, "Direct KYC category not detected");
}

#[test]
fn test_indirect_kyc() {
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"INDIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"4\",\"customGroupExternalId\":\"null\"}]}                                                                                    ";
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";
    let result = main(json_string, public_input_transRef, public_input_txHash);
    assert(result == Bitmap::INDIRECT_KYC, "Indirect KYC category not detected");
}

#[test]
fn test_cex() {
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"21\",\"customGroupExternalId\":\"null\"}]}                                                                                     ";
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";
    let result = main(json_string, public_input_transRef, public_input_txHash);
    assert(result == Bitmap::CEX, "CEX category not detected");
}

#[test]
fn test_multiple_categories() {
    //29(ILLICIT_ACTOR_ORG): Falls under both SCAM and TERRORISM bitmap categories
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"29\",\"customGroupExternalId\":\"null\"}]}                                                                                     ";
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";
    let result = main(json_string, public_input_transRef, public_input_txHash);
    assert(result == (Bitmap::SCAM + Bitmap::TERRORISM), "invalid category");
    
}

//categoryId field does not have any values, should return an id of 20 if its "None". Therefore, if its empty, something is wrong.
#[test(should_fail_with = "categoryId is empty")]
fn test_empty_categoryId() {
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"\",\"customGroupExternalId\":\"null\"}]}                                                                                       ";
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";
    let _ = main(json_string, public_input_transRef, public_input_txHash);
    
}

//categoryId value is an invalid string
#[test(should_fail_with = "ScanData: Invalid token")]
fn test_uncategorized_null() {
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":nul\"\",\"customGroupExternalId\":\"null\"}]}                                                                                    ";
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";
    let _ = main(json_string, public_input_transRef, public_input_txHash);
    
}

//categoryId value is invalid or empty
#[test(should_fail_with = "ScanData: Invalid token")]
fn test_invalid_exposureType() {
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"lol\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":6\"\",\"customGroupExternalId\":\"null\"}]}                                                                                         ";
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";
    let _ = main(json_string, public_input_transRef, public_input_txHash);
    
}
