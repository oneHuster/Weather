//
//  weatherdata.m
//  weather
//
//  Created by 邹应天 on 15/8/8.
//  Copyright (c) 2015年 邹应天. All rights reserved.
//

#import "weatherdata.h"
@implementation weatherdata
-(id)init{
    self=[super init];
    if (self) {
        self.element=[[NSMutableString alloc]init];
        self.information=[[NSMutableDictionary alloc]init];
        self.forecastArray=[[NSMutableArray alloc]init];
        self.foreinfo= [[NSMutableDictionary alloc]init];
        self.forecast=YES;
    }
    return self;
}
-(void)StartRequest{

#pragma mark -xml解析重点
    NSError *error1;
    NSURLRequest *urlRequest2=[NSURLRequest requestWithURL:[NSURL URLWithString://@"http:php.weather.sina.com.cn/xml.php?city=%CE%E4%BA%BA&password=DJOYnieT8234jlsK"]];
                            @"http://wthrcdn.etouch.cn/WeatherApi?citykey=101200101"]];
    NSHTTPURLResponse *response1;

    NSData *data1 =[NSURLConnection sendSynchronousRequest:urlRequest2 returningResponse:&response1 error:&error1];
    if (response1!=NULL) {
        self.offline=NO;
        NSXMLParser *xmlParser=[[NSXMLParser alloc]initWithData:data1];
        [xmlParser setDelegate:self];
        [xmlParser parse];
        NSLog(@"response1!=NULL");
    }
    else{
        self.offline=YES;
        NSLog(@"response1=NULL");
    }
   //NSLog(@"response %@ \n error %@",response1,error1);
  //  NSString *b=[[NSString alloc]initWithData:data1 encoding:NSUTF8StringEncoding];
    //数据储存在字典中直接输出都不是汉字，通过键值得到的都是自动转码的
    //NSLog(@"%@",[self.information objectForKey:@"city"]);
}
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"date"]){
        self.foreinfo=[[NSMutableDictionary alloc]init];
    }
    if ([elementName isEqualToString:@"day"]) {
        self.day=YES;
    }else if ([elementName isEqualToString:@"night"]){
        self.day=NO;
    }
    if ([elementName isEqualToString:@"forecast"]) {
        self.forecast=NO;
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{   [self.element setString:@""];
    [self.element appendString:string];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
     NSString *str=[[NSString alloc] initWithString:self.element];
    if (self.forecast) {
        
    
        if ([elementName isEqualToString:@"city"]) {
            [self.information setValue:str forKey:@"city"];
        
        }
        if ([elementName isEqualToString:@"updatetime"]) {
            [self.information setValue:str forKey:@"updatetime"];
        }
        if ([elementName isEqualToString:@"wendu"]) {
            [self.information setValue:str forKey:@"wendu"];
        
        }
    
        if ([elementName isEqualToString:@"fengli"]) {
            [self.information setValue:str forKey:@"fengli"];
        
        }
        if ([elementName isEqualToString:@"fengxiang"]) {
            [self.information setValue:str forKey:@"fengxiang"];
            
        }
        if ([elementName isEqualToString:@"shidu"]) {
            [self.information setValue:str forKey:@"shidu"];
        
        }
        if ([elementName isEqualToString:@"sunrise_1"]) {
            [self.information setValue:str forKey:@"sunrise_1"];
        }
        if ([elementName isEqualToString:@"sunrise_2"]) {
            [self.information setValue:str forKey:@"sunrise_2"];
            [self.forecastArray addObject:self.information];
        }
    }
    
    if ([elementName isEqualToString:@"date"]) {
        [self.foreinfo setValue:str forKey:@"date"];
    }
    if ([elementName isEqualToString:@"high"]) {
        [self.foreinfo setValue:str forKey:@"high"];
    }
    if ([elementName isEqualToString:@"low"]) {
        [self.foreinfo setValue:str forKey:@"low"];
    }
    if ([elementName isEqualToString:@"type"]&& self.day) {
        [self.foreinfo setValue:str forKey:@"type"];
        [self.forecastArray addObject:self.foreinfo];
    }
}
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    //for (int i=0; i<self.forecastArray.count; i++) {
        //NSLog(@"%lu",(unsigned long)self.forecastArray.count);
       // NSMutableDictionary *temp=[[NSMutableDictionary alloc]initWithDictionary:[self.forecastArray objectAtIndex:i]];
       // NSLog(@"%@",[temp objectForKey:@"date"]);
        //[temp removeAllObjects];
    //}
}














#pragma mark--json analysis
-(void)JsonRequest{
    NSError *error;
     NSURLRequest *urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.weather.com.cn/adat/sk/101010100.html"]];
     NSHTTPURLResponse *response;
     NSData *data =[NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
        NSLog(@"%@",data);
        if (error!=nil) {
            NSLog(@"error on load =%@",[error localizedDescription]);
    
        }
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
            if (httpResponse.statusCode!=200) {
                NSLog(@"%ld",(long)httpResponse.statusCode);
            }
        }
         NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    
    
    NSString *a=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    // NSDictionary *dictionary2=[NSXMLParser ]
    
    
        if (error!=nil) {
    
             NSLog(@"feed is=%@  %@",dictionary,error);
        }
        NSString *strURL=[[NSString alloc]initWithFormat:@"http://iosbook1.com/service/mynotes/webservice.php?&type=%@&action=%@",@"JSON",@"query" ];
       // NSURL *url=[NSURL URLWithString:[strURL URLEncodingString]];
       // NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
       // ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
       // [request startSynchronous];
       // NSData *data  = [request responseData];
        //NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSLog(@"request finished");
        NSDictionary *resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSDictionary *dictionaryWeatherInfo = [dictionary objectForKey: @"weatherinfo"];
     //output weather of today
     NSLog(@"今天是 %@  %@  %@  的天气状况是：%@  %@ ", [dictionaryWeatherInfo objectForKey: @"time"], [dictionaryWeatherInfo objectForKey: @"week"],[dictionaryWeatherInfo objectForKey: @"city"], [dictionaryWeatherInfo objectForKey: @"WD"], [dictionaryWeatherInfo objectForKey: @"temp"]);
    NSLog(@"%@",dictionary);
    NSLog(@"%@",[dictionary valueForKey:@"weatherinfo"]);
    NSLog(@"%@",a);
}
@end
