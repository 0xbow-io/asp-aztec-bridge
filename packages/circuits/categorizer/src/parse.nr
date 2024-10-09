use dep::json_parser::JSON2kb::JSON;

/**
* The function parse_json takes a JSON object and returns a ValidatedJSON struct containing all the values parsed from the JSON object.
* @param json: JSON - the JSON object to be parsed
* @return ValidatedJSON - the struct containing all the values parsed from the JSON object
*/
fn parse_json(json: JSON) -> ValidatedJSON {

    // "total" 
    let total: BoundedVec<u8, 10> = json.get_string_unchecked("total".as_bytes());

    // "limit"
    let limit: BoundedVec<u8, 10> = json.get_string_unchecked("limit".as_bytes());

    // "offset"
    let offset: BoundedVec<u8, 10> = json.get_string_unchecked("offset".as_bytes());

    // "data" (Array)
    let data_array: JSON = json.get_array_unchecked("data".as_bytes());
    let data_obj: JSON = data_array.get_object_from_array_unchecked(0);

    //below is all the data inside the data Array

    //"alertAmountUsd"
    let alertAmountUsd: BoundedVec<u8, 6> = data_obj.get_string_unchecked("alertAmountUsd".as_bytes());

    // "transactionHash"
    let transactionHash: BoundedVec<u8, 64> = data_obj.get_string_unchecked("transactionHash".as_bytes());

    // "exposureType"
    let exposureType: BoundedVec<u8, 10> = data_obj.get_string_unchecked("exposureType".as_bytes());

    // "alertStatus": 
    let alertStatus: BoundedVec<u8, 10> = data_obj.get_string_unchecked("alertStatus".as_bytes());

    // "transferReportedAt"
    let transferReportedAt: BoundedVec<u8, 24> = data_obj.get_string_unchecked("transferReportedAt".as_bytes());

    // "alertIdentifier"
    let alertIdentifier: BoundedVec<u8, 36> = data_obj.get_string_unchecked("alertIdentifier".as_bytes());

    //"transferReference": (WILL BE NULL IF ITS A BEHAVOURIAL ALERT I.E. THIS MUST BE POPULATED)
    let transferReference: BoundedVec<u8,66> = data_obj.get_string_unchecked("transferReference".as_bytes());

    // "alertStatusCreatedBy"
    let alertStatusCreatedBy: BoundedVec<u8, 50> = data_obj.get_string_unchecked("alertStatusCreatedBy".as_bytes());

    // "valid"
    let valid: BoundedVec<u8, 5> = data_obj.get_string_unchecked("valid".as_bytes());
    
    // "transferCountWindow"
    let transferCountWindow: BoundedVec<u8, 4> = data_obj.get_string_unchecked("transferCountWindow".as_bytes());

    // "ruleAsset"
    let ruleAsset: BoundedVec<u8, 10> = data_obj.get_string_unchecked("ruleAsset".as_bytes());

    // "direction"
    let direction: BoundedVec<u8, 8> = data_obj.get_string_unchecked("direction".as_bytes());
    
    // "timestamp"
    let timestamp: BoundedVec<u8, 20> = data_obj.get_string_unchecked("timestamp".as_bytes());

    // "period"
    let period: BoundedVec<u8, 4> = data_obj.get_string_unchecked("period".as_bytes());

    // "windowSize"
    let windowSize: BoundedVec<u8, 4> = data_obj.get_string_unchecked("windowSize".as_bytes());
    
    // "transferredValuePercentage"
    let transferredValuePercentage: BoundedVec<u8, 5> = data_obj.get_string_unchecked("transferredValuePercentage".as_bytes());

    // "level"
    let level: BoundedVec<u8, 10> = data_obj.get_string_unchecked("level".as_bytes());

    // "service"
    let service: BoundedVec<u8, 21> = data_obj.get_string_unchecked("service".as_bytes());
    
    // "alertStatusCreatedAt"
    let alertStatusCreatedAt: BoundedVec<u8, 30> = data_obj.get_string_unchecked("alertStatusCreatedAt".as_bytes());

    // "userId"
    let userId: BoundedVec<u8, 20> = data_obj.get_string_unchecked("userId".as_bytes());

    // "transferCount"
    let transferCount: BoundedVec<u8, 4> = data_obj.get_string_unchecked("transferCount".as_bytes());

    // "createdAt"
    let createdAt: BoundedVec<u8, 30> = data_obj.get_string_unchecked("createdAt".as_bytes());

    // "alertType": "TRANSFER",
    let alertType: BoundedVec<u8, 10> = data_obj.get_string_unchecked("alertType".as_bytes());

    // "transferOutputAddress"
    let transferOutputAddress: BoundedVec<u8, 34> = data_obj.get_string_unchecked("transferOutputAddress".as_bytes());

    // "validity"
    let validity: BoundedVec<u8, 7> = data_obj.get_string_unchecked("validity".as_bytes());

    // "transactionIndex"
    let transactionIndex: BoundedVec<u8, 10> = data_obj.get_string_unchecked("transactionIndex".as_bytes());

    // "asset"
    let asset: BoundedVec<u8, 10> = data_obj.get_string_unchecked("asset".as_bytes());

    // "rule"
    let rule: BoundedVec<u8, 50> = data_obj.get_string_unchecked("rule".as_bytes());

    // "minThreshold": 100,
    let minThreshold: BoundedVec<u8, 3> = data_obj.get_string_unchecked("minThreshold".as_bytes());

    // "maxThreshold"
    let maxThreshold: BoundedVec<u8, 10> = data_obj.get_string_unchecked("maxThreshold".as_bytes());

    // "categoryId"
    let categoryId: BoundedVec<u8, 3> = data_obj.get_string_unchecked("categoryId".as_bytes());

    // "customGroupExternalId"
    let customGroupExternalId: BoundedVec<u8, 10> = data_obj.get_string_unchecked("customGroupExternalId".as_bytes());

    let result = ValidatedJSON{
        total: total,
        limit: limit,
        offset: offset,
        alertAmountUsd: alertAmountUsd,
        transactionHash: transactionHash,
        exposureType: exposureType,
        alertStatus: alertStatus,
        transferReportedAt: transferReportedAt,
        alertIdentifier: alertIdentifier,
        transferReference: transferReference,
        alertStatusCreatedBy: alertStatusCreatedBy,
        valid: valid,
        transferCountWindow: transferCountWindow,
        ruleAsset: ruleAsset,
        direction: direction,
        timestamp: timestamp,
        period: period,
        windowSize: windowSize,
        transferredValuePercentage: transferredValuePercentage,
        level: level,
        service: service,
        alertStatusCreatedAt: alertStatusCreatedAt,
        userId: userId,
        transferCount: transferCount,
        createdAt: createdAt,
        alertType: alertType,
        transferOutputAddress: transferOutputAddress,
        validity: validity,
        transactionIndex: transactionIndex,
        asset: asset,
        rule: rule,
        minThreshold: minThreshold,
        maxThreshold: maxThreshold,
        categoryId: categoryId,
        customGroupExternalId: customGroupExternalId
    };

    result
}

struct ValidatedJSON {
    total: BoundedVec<u8, 10>,
    limit: BoundedVec<u8, 10>,
    offset: BoundedVec<u8, 10>,
    alertAmountUsd: BoundedVec<u8, 6>,
    transactionHash: BoundedVec<u8, 64>,
    exposureType: BoundedVec<u8, 10>,
    alertStatus: BoundedVec<u8, 10>,
    transferReportedAt: BoundedVec<u8, 24>,
    alertIdentifier: BoundedVec<u8, 36>,
    transferReference: BoundedVec<u8, 66>,
    alertStatusCreatedBy: BoundedVec<u8, 50>,
    valid: BoundedVec<u8, 5>,
    transferCountWindow: BoundedVec<u8, 4>,
    ruleAsset: BoundedVec<u8, 10>,
    direction: BoundedVec<u8, 8>,
    timestamp: BoundedVec<u8, 20>,
    period: BoundedVec<u8, 4>,
    windowSize: BoundedVec<u8, 4>,
    transferredValuePercentage: BoundedVec<u8, 5>,
    level: BoundedVec<u8, 10>,
    service: BoundedVec<u8, 21>,
    alertStatusCreatedAt: BoundedVec<u8, 30>,
    userId: BoundedVec<u8, 20>,
    transferCount: BoundedVec<u8, 4>,
    createdAt: BoundedVec<u8, 30>,
    alertType: BoundedVec<u8, 10>,
    transferOutputAddress: BoundedVec<u8, 34>,
    validity: BoundedVec<u8, 7>,
    transactionIndex: BoundedVec<u8, 10>,
    asset: BoundedVec<u8, 10>,
    rule: BoundedVec<u8, 50>,
    minThreshold: BoundedVec<u8, 3>,
    maxThreshold: BoundedVec<u8, 10>,
    categoryId: BoundedVec<u8, 3>,
    customGroupExternalId: BoundedVec<u8, 10>
}

/**
* @Note: Below are all units tests for the parse_json function
*/

// A valid JSON will that will not fail any assertions. 

#[test]
fn test_parse_json_success() {
    // all keys are valid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"29\",\"customGroupExternalId\":\"null\"}]}                                                                                     ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let  _ = parse_json(json);
}

// Below are all the tests for the parse_json function that will fail. Unable to use loops to make this test more concise due to the nature of the JSON object. All keys are tested.

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_1() {
    // the first key ("total") is invalid
    let json_string = "{\"test1\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_2() {
    // the second key ("limit") is invalid
    let json_string = "{\"total\":\"1000\",\"limic\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_3() {
    // the third key ("offset") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"1ffset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_4() {
    // the fourth key ("data") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"d4ta\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_5() {
    // the fifth key ("alertAmountUsd") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmouftUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);
}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_6() {
    // the sixth key ("transactionHash") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transacttonHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);
}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_7() {
    // the seventh key ("exposureType") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposuteType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);
}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_8() {
    // the eighth key ("alertStatus") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"avertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);
}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_9() {
    // the ninth key ("transferReportedAt") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"traesferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);
}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_10() {
    // the tenth key ("alertIdentifier") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alerttdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);
}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_11() {
    // the eleventh key ("transferReference") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"traasferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);
}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_12() {
    // the twelfth key ("alertStatusCreatedBy") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"atertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);
}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_13() {
    // the thirteenth key ("valid") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"vanid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);
}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_14() {
    // the fourteenth key ("transferCountWindow") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transfegCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_15() {
    // the fifteenth key ("ruleAsset") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"rueeAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_16() {
    // the sixteenth key ("direction") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"dirertion\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_17() {
    // the seventeenth key ("timestamp") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timesramp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_18() {
    // the eighteenth key ("period") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"periog\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_19() {
    // the nineteenth key ("windowSize") is invalid
    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windgwSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);
}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_20() {
    // the twentieth key ("transferredValuePercentage") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transfergedValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_21() {
    // the twenty-first key ("level") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"legel\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_22() {
    // the twenty-second key ("service") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"segvice\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_23() {
    // the twenty-third key ("alertStatusCreatedAt") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertgtatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_24() {
    // the twenty-fourth key ("userId") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"usgrId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_25() {
    // the twenty-fifth key ("transferCount") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"trgnsferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_26() {
    // the twenty-sixth key ("createdAt") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdgt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_27() {
    // the twenty-seventh key ("alertType") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"agertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_28() {
    // the twenty-eighth key ("transferOutputAddress") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transfgrOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_29() {
    // the twenty-ninth key ("validity") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"vglidity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_30() {
    // the thirtieth key ("category") is invalid. Note that category is now deprecated, we use categoryId instead.

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"cavegory\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_31() {
    // the thirty-first key ("transactionIndex") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"tranractionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_32() {
    // the thirty-second key ("asset") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asret\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_33() {
    // the thirty-third key ("rule") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"tule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_34() {
    // the thirty-fourth key ("minThreshold") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThrtshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_35() {
    // the thirty-fifth key ("maxThreshold") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThrethold\":\"null\",\"categotyId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_36() {
    // the thirty-sixth key ("categoryId") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categotyId\":\"2\",\"customGroupExternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}

#[test(should_fail_with = "find_key_in_map, key not found")]
fn test_parse_json_37() {
    // the thirty-seventh key ("customGroupExternalId") is invalid

    let json_string = "{\"total\":\"1000\",\"limit\":\"0\",\"offset\":\"0\",\"data\":[{\"alertAmountUsd\":\"132.50\",\"transactionHash\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf\",\"exposureType\":\"DIRECT\",\"alertStatus\":\"Flagged\",\"transferReportedAt\":\"2017-01-05T14:23:00.397Z\",\"alertIdentifier\":\"a6a5d0f8-9753-11e9-a517-ebce3e967522\",\"transferReference\":\"b765440e872ab6e2521694d10465415bda4adf8ed7fc2fdafb6d39bd17c5fddf:1\",\"alertStatusCreatedBy\":\"null\",\"valid\":\"true\",\"transferCountWindow\":\"null\",\"ruleAsset\":\"null\",\"direction\":\"SENT\",\"timestamp\":\"2011-06-18T08:22:21Z\",\"period\":\"null\",\"windowSize\":\"null\",\"transferredValuePercentage\":\"100.0\",\"level\":\"HIGH\",\"service\":\"SilkRoadMarketplace\",\"alertStatusCreatedAt\":\"2020-01-14T13:57:58.713226Z\",\"userId\":\"mtgox_ghosts\",\"transferCount\":\"null\",\"createdAt\":\"2019-06-17T17:39:41.550575Z\",\"alertType\":\"TRANSFER\",\"transferOutputAddress\":\"1DP38CC2kf6ewUDaaVd9nBfuAD8SP15g2T\",\"validity\":\"VALID\",\"category\":\"darknetmarket\",\"transactionIndex\":\"1\",\"asset\":\"BTC\",\"rule\":\">$100sentdirectlytodarknetmarket\",\"minThreshold\":\"100\",\"maxThreshold\":\"null\",\"categoryId\":\"2\",\"customGroupxxternalId\":\"null\"}]}                                                                                      ";

    let json: JSON = JSON::parse_json_from_string(json_string);

    let _ = parse_json(json);

}