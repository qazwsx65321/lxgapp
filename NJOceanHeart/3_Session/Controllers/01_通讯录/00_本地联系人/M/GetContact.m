//
//  GetContact.m
//  X16.QiHu
//
//  Created by 史伟文 on 16/9/27.
//  Copyright © 2016年 NanJing. All rights reserved.
//

#import "GetContact.h"
#import "ContactModel.h"
#import "ChineseString.h"
#import <Contacts/Contacts.h>
#import "GetContactModel.h"
#import <AddressBook/AddressBook.h>

@implementation GetContact

+ (NSArray *)getNativeContact
{
    NSMutableArray *contacts = [NSMutableArray array];
    // 1.获取授权状态
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    // 2.如果不是已经授权,则直接返回
    if (status != CNAuthorizationStatusAuthorized) return @[];
    
    // 3.获取联系人
    // 3.1.创建联系人仓库
    CNContactStore *store = [[CNContactStore alloc] init];
    
    // 3.2.创建联系人的请求对象
    // keys决定这次要获取哪些信息,比如姓名/电话
    NSArray *fetchKeys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey];
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:fetchKeys];
    
    // 3.3.请求联系人
    NSError *error = nil;
    
    [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        // stop是决定是否要停止
        ContactModel *tempContact = [ContactModel new];
        
        // 1.获取姓名
        NSString *firstname = contact.givenName?contact.givenName:@"";
        NSString *lastname = contact.familyName?contact.familyName:@"";
//        NSLog(@"%@ %@", firstname, lastname);
        tempContact.name = [NSString stringWithFormat:@"%@ %@", lastname, firstname];
        tempContact.icon = contact.imageData;
        // 2.获取电话号码
        NSArray *phones = contact.phoneNumbers;
        
        // 3.遍历电话号码
        
        tempContact.phone =@"";
        
        for (CNLabeledValue *labelValue in phones) {
            CNPhoneNumber *phoneNumber = labelValue.value;
            NSString *newphone = phoneNumber.stringValue;
            newphone= [newphone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            newphone=  [newphone stringByReplacingOccurrencesOfString:@"-" withString:@""];
            newphone= [newphone stringByReplacingOccurrencesOfString:@"-" withString:@""];
            newphone= [newphone stringByReplacingOccurrencesOfString:@"+" withString:@""];
            tempContact.phone = newphone;
            break;
        }
        
        [contacts addObject:tempContact];
    }];
    
//    NSLog(@"%@", contacts);
    return contacts;
}

+ (NSArray *)getNativeContactPrevIOS10
{
    NSMutableArray *contacts = [NSMutableArray array];
    
    int __block tip = 0;
    
    ABAddressBookRef addressBook = nil;
    
    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (!granted) {
            tip = 1;
        }
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    if (tip) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请允许" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return @[];
    }
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex number = ABAddressBookGetPersonCount(addressBook);
    for (NSInteger i = 0; i < number; i ++) {
        ContactModel *tempContact = [ContactModel new];
        ABRecordRef  people = CFArrayGetValueAtIndex(allPeople, i);
        //获取当前联系人名字
        NSString * firstName = (__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty))?(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty)):@"";
        //获取当前联系人姓氏
        NSString * lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty))?(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty)):@"";
        tempContact.name = [NSString stringWithFormat:@"%@ %@", lastName, firstName];
        
        //获取当前联系人头像图片
        NSData * userImage=(__bridge NSData*)(ABPersonCopyImageData(people));
        tempContact.icon = userImage;
        
        //获取当前联系人的电话 数组
        ABMultiValueRef phones= ABRecordCopyValue(people, kABPersonPhoneProperty);
        
        tempContact.phone = @"";
        if (ABMultiValueGetCount(phones)) {
            NSString *newphone =(__bridge NSString*)ABMultiValueCopyValueAtIndex(phones,0);
            newphone= [newphone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
            newphone=  [newphone stringByReplacingOccurrencesOfString:@"-" withString:@""];
            newphone= [newphone stringByReplacingOccurrencesOfString:@"-" withString:@""];
            newphone= [newphone stringByReplacingOccurrencesOfString:@"+" withString:@""];
            tempContact.phone = newphone;
        }
        [contacts addObject:tempContact];
  
    }
    
    return contacts;
}


#pragma mark - sort function
NSInteger nameSort(id user1, id user2, void *context)
{
    ContactModel *u1,*u2;
    //类型转换
    u1 = (ContactModel*)user1;
    u2 = (ContactModel*)user2;
    return  [u1.name localizedCompare:u2.name];
}



@end
