use dep::json_parser::JSON2kb::JSON;
use crate::global_values::{MAX_TREF_LEN, MAX_TXHASH_LEN};

/**
* This function verifies the supplied JSON keys against the expected keys. 36 keys are expected in the JSON object.
* @param json: JSON - the JSON object to verify
* @return u8 - the number of keys that were found in the JSON object
**/
fn verify_keys(json: JSON) -> u8 {

    let mut sum = 0;

    //1. we convert the expected key into a bounded vector
    let total: BoundedVec<u8, 5> = BoundedVec::from_array("total".as_bytes());
    //2. we check if the key exists in the JSON
    let key_exists = json.key_exists(total);
    //3. if true, we increment the sum by 1
    sum += key_exists as u8;

    let limit: BoundedVec<u8, 5> = BoundedVec::from_array("limit".as_bytes());
    let key_exists = json.key_exists(limit);
    sum += key_exists as u8;

    let offset: BoundedVec<u8, 6> = BoundedVec::from_array("offset".as_bytes());
    let key_exists = json.key_exists(offset);
    sum += key_exists as u8;
    
    /**
    * @note - .key_exists is skipped for the "data" key. The .get_array_unchecked() will 
    * fail an assertion if the key does not exist in the JSON object meaning the supplied JSON
    * is invalid. The .get_array_unchecked() function is a necessary step in to get the
    * "data" array from the JSON object.
    **/
    let data_array = json.get_array_unchecked("data".as_bytes());
    let data_obj = data_array.get_object_from_array_unchecked(0);
    
    let alertAmountUsd: BoundedVec<u8, 14> = BoundedVec::from_array("alertAmountUsd".as_bytes());
    let key_exists = data_obj.key_exists(alertAmountUsd);
    sum += key_exists as u8;

    let transactionHash: BoundedVec<u8, 15> = BoundedVec::from_array("transactionHash".as_bytes());
    let key_exists = data_obj.key_exists(transactionHash);
    sum += key_exists as u8;

    let exposureType: BoundedVec<u8, 12> = BoundedVec::from_array("exposureType".as_bytes());
    let key_exists = data_obj.key_exists(exposureType);
    sum += key_exists as u8;

    let alertStatus: BoundedVec<u8, 11> = BoundedVec::from_array("alertStatus".as_bytes());
    let key_exists = data_obj.key_exists(alertStatus);
    sum += key_exists as u8;

    let transferReportedAt: BoundedVec<u8, 18> = BoundedVec::from_array("transferReportedAt".as_bytes());
    let key_exists = data_obj.key_exists(transferReportedAt);
    sum += key_exists as u8;

    let alertIdentifier: BoundedVec<u8, 15> = BoundedVec::from_array("alertIdentifier".as_bytes());
    let key_exists = data_obj.key_exists(alertIdentifier);
    sum += key_exists as u8;

    let transferReference: BoundedVec<u8, 17> = BoundedVec::from_array("transferReference".as_bytes());
    let key_exists = data_obj.key_exists(transferReference);
    sum += key_exists as u8;

    let alertStatusCreatedBy: BoundedVec<u8, 20> = BoundedVec::from_array("alertStatusCreatedBy".as_bytes());
    let key_exists = data_obj.key_exists(alertStatusCreatedBy);
    sum += key_exists as u8;

    let valid: BoundedVec<u8, 5> = BoundedVec::from_array("valid".as_bytes());
    let key_exists = data_obj.key_exists(valid);
    sum += key_exists as u8;

    let transferCountWindow: BoundedVec<u8, 19> = BoundedVec::from_array("transferCountWindow".as_bytes());
    let key_exists = data_obj.key_exists(transferCountWindow);
    sum += key_exists as u8;

    let ruleAsset: BoundedVec<u8, 9> = BoundedVec::from_array("ruleAsset".as_bytes());
    let key_exists = data_obj.key_exists(ruleAsset);
    sum += key_exists as u8;

    let direction: BoundedVec<u8, 9> = BoundedVec::from_array("direction".as_bytes());
    let key_exists = data_obj.key_exists(direction);
    sum += key_exists as u8;

    let timestamp: BoundedVec<u8, 9> = BoundedVec::from_array("timestamp".as_bytes());
    let key_exists = data_obj.key_exists(timestamp);
    sum += key_exists as u8;

    let period: BoundedVec<u8, 6> = BoundedVec::from_array("period".as_bytes());
    let key_exists = data_obj.key_exists(period);
    sum += key_exists as u8;

    let windowSize: BoundedVec<u8, 10> = BoundedVec::from_array("windowSize".as_bytes());
    let key_exists = data_obj.key_exists(windowSize);
    sum += key_exists as u8;

    let transferredValuePercentage: BoundedVec<u8, 26> = BoundedVec::from_array("transferredValuePercentage".as_bytes());
    let key_exists = data_obj.key_exists(transferredValuePercentage);
    sum += key_exists as u8;

    let level: BoundedVec<u8, 5> = BoundedVec::from_array("level".as_bytes());
    let key_exists = data_obj.key_exists(level);
    sum += key_exists as u8;

    let service: BoundedVec<u8, 7> = BoundedVec::from_array("service".as_bytes());
    let key_exists = data_obj.key_exists(service);
    sum += key_exists as u8;

    let alertStatusCreatedAt: BoundedVec<u8, 20> = BoundedVec::from_array("alertStatusCreatedAt".as_bytes());
    let key_exists = data_obj.key_exists(alertStatusCreatedAt);
    sum += key_exists as u8;

    let userId: BoundedVec<u8, 6> = BoundedVec::from_array("userId".as_bytes());
    let key_exists = data_obj.key_exists(userId);
    sum += key_exists as u8;

    let transferCount: BoundedVec<u8, 13> = BoundedVec::from_array("transferCount".as_bytes());
    let key_exists = data_obj.key_exists(transferCount);
    sum += key_exists as u8;

    let createdAt: BoundedVec<u8, 9> = BoundedVec::from_array("createdAt".as_bytes());
    let key_exists = data_obj.key_exists(createdAt);
    sum += key_exists as u8;

    let alertType: BoundedVec<u8, 9> = BoundedVec::from_array("alertType".as_bytes());
    let key_exists = data_obj.key_exists(alertType);
    sum += key_exists as u8;

    let transferOutputAddress: BoundedVec<u8, 21> = BoundedVec::from_array("transferOutputAddress".as_bytes());
    let key_exists = data_obj.key_exists(transferOutputAddress);
    sum += key_exists as u8;

    let validity: BoundedVec<u8, 8> = BoundedVec::from_array("validity".as_bytes());
    let key_exists = data_obj.key_exists(validity);
    sum += key_exists as u8;

    let category: BoundedVec<u8, 8> = BoundedVec::from_array("category".as_bytes());
    let key_exists = data_obj.key_exists(category);
    sum += key_exists as u8;

    let transactionIndex: BoundedVec<u8, 16> = BoundedVec::from_array("transactionIndex".as_bytes());
    let key_exists = data_obj.key_exists(transactionIndex);
    sum += key_exists as u8;

    let asset: BoundedVec<u8, 5> = BoundedVec::from_array("asset".as_bytes());
    let key_exists = data_obj.key_exists(asset);
    sum += key_exists as u8;

    let rule: BoundedVec<u8, 4> = BoundedVec::from_array("rule".as_bytes());
    let key_exists = data_obj.key_exists(rule);
    sum += key_exists as u8;

    let minThreshold: BoundedVec<u8, 12> = BoundedVec::from_array("minThreshold".as_bytes());
    let key_exists = data_obj.key_exists(minThreshold);
    sum += key_exists as u8;

    let maxThreshold: BoundedVec<u8, 12> = BoundedVec::from_array("maxThreshold".as_bytes());
    let key_exists = data_obj.key_exists(maxThreshold);
    sum += key_exists as u8;

    let categoryId: BoundedVec<u8, 10> = BoundedVec::from_array("categoryId".as_bytes());
    let key_exists = data_obj.key_exists(categoryId);
    sum += key_exists as u8;

    let customGroupExternalId: BoundedVec<u8, 21> = BoundedVec::from_array("customGroupExternalId".as_bytes());
    let key_exists = data_obj.key_exists(customGroupExternalId);
    sum += key_exists as u8;

    sum

}

/**
* This function verifies the public inputs against the JSON object
* @param json: JSON - the JSON object to verify
* @param public_input_txHash: str<64> - the public input transaction hash
* @param public_input_transferRef: str<100> - the public input transfer reference
**/
fn verify_public_inputs(json: JSON, public_input_txHash: str<MAX_TXHASH_LEN>, public_input_transferRef: str<MAX_TREF_LEN>) {
    
    // Convert the public input transfer reference to a byte array
    let pub_transRef_bytes = public_input_transferRef.as_bytes();

    // Find the actual length of the public input transfer reference
    let actual_len_pub_transRef = find_actual_length(pub_transRef_bytes);
    
    let pub_transRef_vec: BoundedVec<u8, 100> = BoundedVec::from_array(pub_transRef_bytes);
    
    let pub_txHash_vec: BoundedVec<u8, 64> = BoundedVec::from_array(public_input_txHash.as_bytes());

    // Get the "data" array from the JSON
    let data_array = json.get_array_unchecked("data".as_bytes());
    let data_obj = data_array.get_object_from_array_unchecked(0);

    // Get the "transactionHash" from the "data" array
    let json_txHash: BoundedVec<u8, 64> = data_obj.get_string_unchecked("transactionHash".as_bytes());
    
    // Get the "transferReference" from the "data" array
    let json_transRef: BoundedVec<u8, 100> = data_obj.get_string_unchecked("transferReference".as_bytes());
    
    // Get the "transactionIndex" from the "data" array
    let json_txIndex: BoundedVec<u8, 10> = data_obj.get_string_unchecked("transactionIndex".as_bytes());

    // Compares the public input values with the JSON retrieved values for txHash and transferReference
    assert(json_txHash == pub_txHash_vec, f"transaction hash mismatch, json value: {json_txHash} vs public input: {pub_txHash_vec}");

    // Compares the length of the public vs json transfer reference
    assert(json_transRef.len() as u8 == actual_len_pub_transRef, f"transfer reference length mismatch, json value: {json_transRef.len()} vs public input: {actual_len_pub_transRef}");

    // Compare public vs json transfer references up to the actual length
    for i in 0..MAX_TREF_LEN - 1 {
        if i < actual_len_pub_transRef {
            assert(json_transRef.storage[i] == pub_transRef_vec.storage[i], f"transfer reference mismatch at index {i}, json value: {json_transRef.storage[i]} vs public input: {pub_transRef_vec.storage[i]}");
        } 
    }

    verify_transferRef_format(json_txHash, json_txIndex, json_transRef, pub_transRef_vec, actual_len_pub_transRef);
    
}

/** 
* This unconstrained helper function finds the actual length of the public input transfer reference
* @param data: [u8; 100] - the transfer reference data
* @return u8 - the actual length of the transfer reference
* @reason: The public input for transfer reference is a string length of a 100, but the actual length of the transfer reference is less than 100.
* strings are padded with spaces which are 32's. To fulfill the 100 requirement length, we find the first 32 and return the index
**/
unconstrained fn find_actual_length(data: [u8; 100]) -> u8 {

    let mut length = MAX_TREF_LEN - 1;
    for i in 0..MAX_TREF_LEN - 1 {
        if data[i] == 32 {
            length = i;
            break;
        }
    }
    length
}

/**
* This function verifies the format of the transfer reference
* @param json_txHash - the transaction hash retrieved from the JSON
* @param json_txIndex - the transaction index retrieved from the JSON
* @param json_transferRef - the transfer reference retrieved from the JSON
* @param pub_transRef - the public input transfer reference
* @param actual_len_pub_transRef - the actual length of the public input transfer reference
**/
fn verify_transferRef_format(json_txHash: BoundedVec<u8, MAX_TXHASH_LEN>, json_txIndex: BoundedVec<u8, 10>, json_transferRef: BoundedVec<u8, MAX_TREF_LEN>, pub_transRef: BoundedVec<u8, MAX_TREF_LEN>, actual_len_pub_transRef: u8) {

    // concatenate the JSON "txHash" + ":" + "txLogIndex" to form the full transfer reference

    // init an empty BoundedVec to store the concatenated values for comparison
    let mut con_transRef: BoundedVec<u8, 100> = BoundedVec::new(); //64 (txHash) + 1(":") + 35("txIndex") = 100
    con_transRef.extend_from_bounded_vec(json_txHash);
    let colon: BoundedVec<u8, 1> = BoundedVec::from_array(":".as_bytes());
    con_transRef.extend_from_bounded_vec(colon);
    con_transRef.extend_from_bounded_vec(json_txIndex);

    
    for i in 0..MAX_TREF_LEN - 1 {
        if i < actual_len_pub_transRef {
            // Compare the concatenated transfer reference with the JSON transfer reference
            assert(con_transRef.storage[i] == json_transferRef.storage[i], f"transfer reference mismatch at index {i}, expected: {json_transferRef.storage[i]}, got: {con_transRef.storage[i]}");
            // Compare the concatenated transfer reference with the public input transfer reference
            assert(con_transRef.storage[i] == pub_transRef.storage[i], f"transfer reference mismatch at index {i}, expected: {pub_transferRef.storage[i]}, got: {con_transRef.storage[i]}");
        }
    }

}

/**
* Tests for the verify_keys function
**/
#[test]
fn test_verify_keys_0_valid() {
    // 0 valid keys in this json_string. The sum should be 0.
    let json_string = "{\"test1\":\"1000\",\"test2\":\"0\",\"test03\":\"0\",\"data\":[{\"alertAmouftUsd\":\"132.50\",\"transacttonHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposuteType\":\"DIRECT\",\"avertStatus\":\"Flagged\",\"traesferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alerttdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"traasferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"atertStatusCreatedBy\":\"null\",\"vanid\":\"true\",\"transfegCountWindow\":\"null\",\"rueeAsset\":\"null\",\"dirertion\":\"SENT\",\"timesramp\":\"2011-06-18T08:22:21Z\",\"periog\":\"null\",\"windgwSize\":\"null\",\"transfergedValuePercentage\":\"100.0\",\"legel\":\"HIGH\",\"segvice\":\"SilkRoadMarketplace\",\"alertgtatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"usgrId\":\"mtgox_ghosts\",\"trgnsferCount\":\"null\",\"createdgt\":\"2019-06-17T17:39:41.550575Z\",\"agertType\":\"TRANSFER\",\"transfgrOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"vglidity\":\"VALID\",\"cavegory\":\"darknetmarket\",\"tranractionIndex\":\"1\",\"asret\":\"BTC\",\"tule\":\">$100sentdirectlytodarknetmarket\",\"minThrtshold\":\"100\",\"maxThrethold\":\"null\",\"categotyId\":\"2\",\"cusmomGroupExternalId\":\"null\"}]}"                                                                                      ;

    let json = JSON::parse_json(json_string.as_bytes());

    let result = verify_keys(json);

    assert(result == 0);
}

#[test]
fn test_verify_keys_all_valid() {
    // All keys in this json_string are valid. The sum should be 36.
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"23\",\"customGroupExternalId\":\"null\"}]}                                                                                     ";

    let json = JSON::parse_json(json_string.as_bytes());

    let result = verify_keys(json);

    assert(result == 36);
}

/**
* Tests for the verify_public_inputs function
**/

// Test with valid public inputs
#[test]
fn test_verify_public_inputs() {

    let json_string: str<1114> = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}";

    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";

    let json: JSON = JSON::parse_json_from_string(json_string);

    verify_public_inputs(json, public_input_txHash, public_input_transRef);
}

#[test(should_fail_with = "transfer reference mismatch")]
fn test_verify_public_inputs_variation_1() {

    let json_string: str<1114> = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}";

    let public_input_transRef = "b765440e872ab6e2121694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  "; //invalid transfer reference
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf";

    let json: JSON = JSON::parse_json_from_string(json_string);

    verify_public_inputs(json, public_input_txHash, public_input_transRef);

}

#[test(should_fail_with = "transaction hash mismatch")]
fn test_verify_public_inputs_variation_2() {

    let json_string: str<1114> = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}";

    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddc"; //invalid transaction hash

    let json: JSON = JSON::parse_json(json_string.as_bytes());

    verify_public_inputs(json, public_input_txHash, public_input_transRef);

}

#[test(should_fail_with = "transfer reference mismatch")]
fn test_verify_public_inputs_variation_3() {

    let json_string: str<1114> = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}";
    //intentionally made the txIndex 2 instead of 1
    let public_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:2                                  ";
    let public_input_txHash = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf"; 

    let json: JSON = JSON::parse_json(json_string.as_bytes());

    verify_public_inputs(json, public_input_txHash, public_input_transRef);

}

/**
* Tests for the verify_transferRef_format function
**/

// Test with valid transfer reference
#[test]
fn test_verify_transferRef_format() {

    let json_string= "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"23\",\"customGroupExternalId\":\"null\"}]}                                                                                     ";

    let json = JSON::parse_json_from_string(json_string);

    let data_array = json.get_array_unchecked("data".as_bytes());
    let data_obj = data_array.get_object_from_array_unchecked(0);

    let json_txHash: BoundedVec<u8, 64> = data_obj.get_string_unchecked("transactionHash".as_bytes());
    
    let json_transRef: BoundedVec<u8, 100> = data_obj.get_string_unchecked("transferReference".as_bytes());
    
    let json_txIndex: BoundedVec<u8, 10> = data_obj.get_string_unchecked("transactionIndex".as_bytes());

    let pub_transRef_vec: BoundedVec<u8, 100> = BoundedVec::from_array("b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ".as_bytes());
    
    /**
    * @note - We will skip using the unconstrained function to find the actual length of the public input transfer reference
    * this is because we are testing the verify_transferRef_format function and not the find_actual_length function.
    **/

    let pub_transRef_len = json_transRef.len() as u8;

    verify_transferRef_format(json_txHash, json_txIndex, json_transRef, pub_transRef_vec, pub_transRef_len);
}

// Test with a different transaction hash and transfer reference
#[test]
fn test_verify_transferRef_format_different_hash() {
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"245.75\",\"transactionHash\":\"a123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2018-03-15T09:30:00.123Z\",\"alertIdentifier\":\"b7b5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"a123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2018-03-15T09:29:45Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"DarkMarket\",\"alertStatusCreatedAt\":\"2018-03-15T09:31:58.713226Z\",\"userId\":\"dark_user\",\"transferCount\":\"null\",\"createdAt\":\"2018-03-15T09:30:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijk\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$200sentdirectlytodarknetmarket\",\"minThreshold\":\"200\",\"maxThreshold\":\"null\",\"categoryId\":\"24\",\"customGroupExternalId\":\"null\"}]}";

    let json = JSON::parse_json_from_string(json_string);
    let data_array = json.get_array_unchecked("data".as_bytes());
    let data_obj = data_array.get_object_from_array_unchecked(0);

    let json_txHash: BoundedVec<u8, 64> = data_obj.get_string_unchecked("transactionHash".as_bytes());
    let json_transRef: BoundedVec<u8, 100> = data_obj.get_string_unchecked("transferReference".as_bytes());
    let json_txIndex: BoundedVec<u8, 10> = data_obj.get_string_unchecked("transactionIndex".as_bytes());

    let pub_transRef_vec: BoundedVec<u8, 100> = BoundedVec::from_array("a123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef:1                                  ".as_bytes());
    
    let pub_transRef_len = json_transRef.len() as u8;

    verify_transferRef_format(json_txHash, json_txIndex, json_transRef, pub_transRef_vec, pub_transRef_len);
}

#[test]
fn test_verify_transferRef_format_longer_index() {
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"1000.25\",\"transactionHash\":\"1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b9c0d1e2f\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Investigating\",\"transferReportedAt\":\"2020-07-01T08:15:45.246Z\",\"alertIdentifier\":\"d9d7f2g0-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b9c0d1e2f:123\",\"alertStatusCreatedBy\":\"system\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2020-07-01T08:15:30Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"CRITICAL\",\"service\":\"DarkWebExchange\",\"alertStatusCreatedAt\":\"2020-07-01T08:16:58.135792Z\",\"userId\":\"high_risk_trader\",\"transferCount\":\"null\",\"createdAt\":\"2020-07-01T08:15:46.246813Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"bc1qar0srrr7xfkvy5l643lydnw9re59gtzzwf5mdq\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"123\",\"asset\":\"BTC\",\"rule\":\">$1000sentdirectlytodarknetmarket\",\"minThreshold\":\"1000\",\"maxThreshold\":\"null\",\"categoryId\":\"26\",\"customGroupExternalId\":\"null\"}]}";

    let json = JSON::parse_json_from_string(json_string);
    let data_array = json.get_array_unchecked("data".as_bytes());
    let data_obj = data_array.get_object_from_array_unchecked(0);

    let json_txHash: BoundedVec<u8, 64> = data_obj.get_string_unchecked("transactionHash".as_bytes());
    let json_transRef: BoundedVec<u8, 100> = data_obj.get_string_unchecked("transferReference".as_bytes());
    let json_txIndex: BoundedVec<u8, 10> = data_obj.get_string_unchecked("transactionIndex".as_bytes());

    let pub_transRef_vec: BoundedVec<u8, 100> = BoundedVec::from_array("1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b9c0d1e2f:123                               ".as_bytes());
    
    let pub_transRef_len = json_transRef.len() as u8;

    verify_transferRef_format(json_txHash, json_txIndex, json_transRef, pub_transRef_vec, pub_transRef_len);
}

#[test(should_fail_with = "transfer reference mismatch")]
fn test_verify_transferRef_format_mismatched_hash() {
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"750.50\",\"transactionHash\":\"abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789\",\"exposureType\":\"INDIRECT\",\"alertStatus\":\"Resolved\",\"transferReportedAt\":\"2021-02-14T12:00:00.000Z\",\"alertIdentifier\":\"e0e8g3h1-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789:7\",\"alertStatusCreatedBy\":\"analyst\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"RECEIVED\",\"timestamp\":\"2021-02-14T11:59:45Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"CryptoLaunderer\",\"alertStatusCreatedAt\":\"2021-02-14T12:01:30.246813Z\",\"userId\":\"suspicious_entity\",\"transferCount\":\"null\",\"createdAt\":\"2021-02-14T12:00:15.135792Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy\",\"validity\":\"VALID\",\"category\":\"moneylaundering\",\"transactionIndex\":\"7\",\"asset\":\"BTC\",\"rule\":\">$700receivedfromsuspiciousaddress\",\"minThreshold\":\"700\",\"maxThreshold\":\"null\",\"categoryId\":\"27\",\"customGroupExternalId\":\"null\"}]}";

    let json = JSON::parse_json_from_string(json_string);
    let data_array = json.get_array_unchecked("data".as_bytes());
    let data_obj = data_array.get_object_from_array_unchecked(0);

    let json_txHash: BoundedVec<u8, 64> = data_obj.get_string_unchecked("transactionHash".as_bytes());
    let json_transRef: BoundedVec<u8, 100> = data_obj.get_string_unchecked("transferReference".as_bytes());
    let json_txIndex: BoundedVec<u8, 10> = data_obj.get_string_unchecked("transactionIndex".as_bytes());

    // Intentionally mismatched hash in public input
    let pub_transRef_vec: BoundedVec<u8, 100> = BoundedVec::from_array("fedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210:7                                  ".as_bytes());
    
    let pub_transRef_len = json_transRef.len() as u8;

    verify_transferRef_format(json_txHash, json_txIndex, json_transRef, pub_transRef_vec, pub_transRef_len);
}

#[test(should_fail_with = "transfer reference mismatch")]
fn test_verify_transferRef_format_different_index() {
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"500.00\",\"transactionHash\":\"f987654321fedcba0987654321fedcba0987654321fedcba0987654321fedcba\",\"exposureType\":\"INDIRECT\",\"alertStatus\":\"Confirmed\",\"transferReportedAt\":\"2019-11-20T14:45:30.789Z\",\"alertIdentifier\":\"c8c6e1f9-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"f987654321fedcba0987654321fedcba0987654321fedcba0987654321fedcba:5\",\"alertStatusCreatedBy\":\"admin\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"RECEIVED\",\"timestamp\":\"2019-11-20T14:44:59Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"MEDIUM\",\"service\":\"UndergroundMarket\",\"alertStatusCreatedAt\":\"2019-11-20T14:46:58.123456Z\",\"userId\":\"underground_trader\",\"transferCount\":\"null\",\"createdAt\":\"2019-11-20T14:45:41.987654Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1ZYXWVUTSRQPONMLKJIHGFEDCBAzyxwvutsrq\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"6\",\"asset\":\"ETH\",\"rule\":\">$450receiveddirectlyfromdarknetmarket\",\"minThreshold\":\"450\",\"maxThreshold\":\"null\",\"categoryId\":\"25\",\"customGroupExternalId\":\"null\"}]}";

    let json = JSON::parse_json_from_string(json_string);
    let data_array = json.get_array_unchecked("data".as_bytes());
    let data_obj = data_array.get_object_from_array_unchecked(0);

    let json_txHash: BoundedVec<u8, 64> = data_obj.get_string_unchecked("transactionHash".as_bytes());
    let json_transRef: BoundedVec<u8, 100> = data_obj.get_string_unchecked("transferReference".as_bytes());
    let json_txIndex: BoundedVec<u8, 10> = data_obj.get_string_unchecked("transactionIndex".as_bytes());
    // the index in the json is a 6, but the public input has a 5
    let pub_transRef_vec: BoundedVec<u8, 100> = BoundedVec::from_array("f987654321fedcba0987654321fedcba0987654321fedcba0987654321fedcba:5                                  ".as_bytes());
    
    let pub_transRef_len = json_transRef.len() as u8;

    verify_transferRef_format(json_txHash, json_txIndex, json_transRef, pub_transRef_vec, pub_transRef_len);
}

/**
* Tests for the find_actual_length function
**/

#[test]
fn test_find_actual_length() {
    
    let test_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1                                  ".as_bytes();

    let actual_length = find_actual_length(test_input_transRef);

    assert(actual_length == 66);

    let test_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1/                                 ".as_bytes();

    let actual_length = find_actual_length(test_input_transRef);

    assert(actual_length == 67);

    let test_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1/*                                ".as_bytes();

    let actual_length = find_actual_length(test_input_transRef);

    assert(actual_length == 68);

    let test_input_transRef = "b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1/*                               1".as_bytes();

    let actual_length = find_actual_length(test_input_transRef);

    assert(actual_length == 68);
        
}

