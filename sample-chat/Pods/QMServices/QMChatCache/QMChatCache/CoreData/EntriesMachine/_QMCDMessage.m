// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to QMCDMessage.m instead.

#import "_QMCDMessage.h"

@implementation QMCDMessageID
@end

@implementation _QMCDMessage

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"QMCDMessage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"QMCDMessage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"QMCDMessage" inManagedObjectContext:moc_];
}

- (QMCDMessageID*)objectID {
	return (QMCDMessageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"delayedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"delayed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"recipientIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"recipientID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"senderIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"senderID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic createAt;

@dynamic customParameters;

@dynamic dateSend;

@dynamic delayed;

- (BOOL)delayedValue {
	NSNumber *result = [self delayed];
	return [result boolValue];
}

- (void)setDelayedValue:(BOOL)value_ {
	[self setDelayed:@(value_)];
}

- (BOOL)primitiveDelayedValue {
	NSNumber *result = [self primitiveDelayed];
	return [result boolValue];
}

- (void)setPrimitiveDelayedValue:(BOOL)value_ {
	[self setPrimitiveDelayed:@(value_)];
}

@dynamic deliveredIDs;

@dynamic dialogID;

@dynamic messageID;

@dynamic readIDs;

@dynamic recipientID;

- (int32_t)recipientIDValue {
	NSNumber *result = [self recipientID];
	return [result intValue];
}

- (void)setRecipientIDValue:(int32_t)value_ {
	[self setRecipientID:@(value_)];
}

- (int32_t)primitiveRecipientIDValue {
	NSNumber *result = [self primitiveRecipientID];
	return [result intValue];
}

- (void)setPrimitiveRecipientIDValue:(int32_t)value_ {
	[self setPrimitiveRecipientID:@(value_)];
}

@dynamic senderID;

- (int32_t)senderIDValue {
	NSNumber *result = [self senderID];
	return [result intValue];
}

- (void)setSenderIDValue:(int32_t)value_ {
	[self setSenderID:@(value_)];
}

- (int32_t)primitiveSenderIDValue {
	NSNumber *result = [self primitiveSenderID];
	return [result intValue];
}

- (void)setPrimitiveSenderIDValue:(int32_t)value_ {
	[self setPrimitiveSenderID:@(value_)];
}

@dynamic senderNick;

@dynamic text;

@dynamic updateAt;

@dynamic attachments;

- (NSMutableSet<QMCDAttachment*>*)attachmentsSet {
	[self willAccessValueForKey:@"attachments"];

	NSMutableSet<QMCDAttachment*> *result = (NSMutableSet<QMCDAttachment*>*)[self mutableSetValueForKey:@"attachments"];

	[self didAccessValueForKey:@"attachments"];
	return result;
}

@dynamic dialog;

@end

@implementation QMCDMessageAttributes 
+ (NSString *)createAt {
	return @"createAt";
}
+ (NSString *)customParameters {
	return @"customParameters";
}
+ (NSString *)dateSend {
	return @"dateSend";
}
+ (NSString *)delayed {
	return @"delayed";
}
+ (NSString *)deliveredIDs {
	return @"deliveredIDs";
}
+ (NSString *)dialogID {
	return @"dialogID";
}
+ (NSString *)messageID {
	return @"messageID";
}
+ (NSString *)readIDs {
	return @"readIDs";
}
+ (NSString *)recipientID {
	return @"recipientID";
}
+ (NSString *)senderID {
	return @"senderID";
}
+ (NSString *)senderNick {
	return @"senderNick";
}
+ (NSString *)text {
	return @"text";
}
+ (NSString *)updateAt {
	return @"updateAt";
}
@end

@implementation QMCDMessageRelationships 
+ (NSString *)attachments {
	return @"attachments";
}
+ (NSString *)dialog {
	return @"dialog";
}
@end

