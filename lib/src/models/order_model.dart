class BasicOrder {
    BasicOrder({
        this.emailClient,
        this.talent,
        this.isPublic,
        this.to,
        this.fromClient,
        this.occasion,
        this.phoneNumber,
        this.instructions,
        this.orderState,
    });

    String emailClient;
    String talent;
    String isPublic;
    String to;
    String fromClient;
    String occasion;
    String phoneNumber;
    String instructions;
    String orderState;

    factory BasicOrder.fromJson(Map<String, dynamic> json) => BasicOrder(
        emailClient : json["email_client"],
        talent      : json["talent"],
        isPublic    : json["is_public"],
        to          : json["to"],
        fromClient  : json["from_client"],
        occasion    : json["occasion"],
        phoneNumber : json["phone_number"],
        instructions: json["instructions"],
        orderState  : json["order_state"],
    );

    Map<String, dynamic> toJson() => {
        "email_client": emailClient,
        "talent"      : talent,
        "is_public"   : isPublic,
        "to"          : to,
        "from_client" : fromClient,
        "occasion"    : occasion,
        "phone_number": phoneNumber,
        "instructions": instructions,
        "order_state" : orderState,
    };
}

class Order {
    Order({
        this.id,
        this.talent,
        this.occasion,
        this.payMethod,
        this.talentResponse,
        this.orderState,
        this.created,
        this.modified,
        this.emailClient,
        this.phoneNumber,
        this.isPublic,
        this.to,
        this.fromClient,
        this.instructions,
    });

    int id;
    String talent;
    String occasion;
    String payMethod;
    String talentResponse;
    String orderState;
    DateTime created;
    DateTime modified;
    String emailClient;
    String phoneNumber;
    bool isPublic;
    String to;
    String fromClient;
    String instructions;

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id            : json["id"],
        talent        : json["talent"],
        occasion      : json["occasion"],
        payMethod     : json["pay_method"],
        talentResponse: json["talent_response"],
        orderState    : json["order_state"],
        created       : DateTime.parse(json["created"]),
        modified      : DateTime.parse(json["modified"]),
        emailClient   : json["email_client"],
        phoneNumber   : json["phone_number"],
        isPublic      : json["is_public"],
        to            : json["to"],
        fromClient    : json["from_client"],
        instructions  : json["instructions"],
    );

    Map<String, dynamic> toJson() => {
        "id"             : id,
        "talent"         : talent,
        "occasion"       : occasion,
        "pay_method"     : payMethod,
        "talent_response": talentResponse,
        "order_state"    : orderState,
        "created"        : created.toIso8601String(),
        "modified"       : modified.toIso8601String(),
        "email_client"   : emailClient,
        "phone_number"   : phoneNumber,
        "is_public"      : isPublic,
        "to"             : to,
        "from_client"    : fromClient,
        "instructions"   : instructions,
    };
}