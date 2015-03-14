//
//  ChooseSportItemViewController.m
//  Sportplus
//
//  Created by 虎猫儿 on 15/3/9.
//  Copyright (c) 2015年 JiaZai. All rights reserved.
//

#import "ChooseSportItemViewController.h"
#import "spCommon.h"

typedef enum {
    spBtnStateNormal = 0 ,
    spBtnStateSelected ,
} spBtnState;

@interface SportModel : NSObject

@property (nonatomic) NSString *selectedImgName ;
@property (nonatomic) NSString *normalImgName ;
@property (nonatomic) NSInteger type ;

- (instancetype)initWithSelectedImgName:(NSString *)selectedImgName NormalImgName:(NSString *)NormalImgName type:(NSInteger)type ;

@end

@implementation SportModel

- (instancetype)initWithSelectedImgName:(NSString *)selectedImgName NormalImgName:(NSString *)normalImgName type:(NSInteger)type {
    self = [super init] ;
    if (self) {
        self.selectedImgName = selectedImgName ;
        self.normalImgName = normalImgName ;
        self.type = type ;
    }
    return self ;
}

@end


@interface ChooseSportItemViewController () {
    NSMutableArray *_sportModels ;
    NSMutableArray *_sportBtnStates ;
    NSArray *_btnArray ;
    NSInteger _selectedIndex ;
}

@end

@implementation ChooseSportItemViewController

- (void)initSportModels {
    NSArray *normalImgNames = @[@"pingpong",@"tennise",@"soccer",@"run",@"build",@"basketball",@"badminton"] ;
    NSArray *selectedImgNames = @[@"pingpongChoose",@"tenniseChoose",@"soccerChoose",@"runChoose",@"buildChoose",@"basketballChoose",@"badmintonChoose"] ;
    NSArray *types = @[SPNum(SPORTSTYPE_pingpong) ,SPNum(SPORTSTYPE_tennise),SPNum(SPORTSTYPE_soccer),SPNum(SPORTSTYPE_run),SPNum(SPORTSTYPE_build),SPNum(SPORTSTYPE_basketball),SPNum(SPORTSTYPE_badminton)] ;
    
    _sportModels = [[NSMutableArray alloc] init] ;
    
    for (NSInteger i = 0 ; i < [types count]; i++) {
        SportModel *model = [[SportModel alloc] initWithSelectedImgName:[selectedImgNames objectAtIndex:i] NormalImgName:[normalImgNames objectAtIndex:i] type:[[types objectAtIndex:i] integerValue]] ;
        [_sportModels addObject:model] ;
    }
    
    
}

- (void)initBtnTag {
    [self.pingpongBtn setTag:1] ;
    [self.tenniseBtn setTag:2] ;
    [self.soccerBtn setTag:3] ;
    [self.runBtn setTag:4] ;
    [self.buildBtn setTag:5] ;
    [self.basketBallBtn setTag:6] ;
    [self.badmintonBtn setTag:7] ;
    
    _btnArray = @[self.pingpongBtn,self.tenniseBtn,self.soccerBtn,self.runBtn,self.buildBtn,self.basketBallBtn,self.badmintonBtn] ;
}

- (void)initBtnState {
    _sportBtnStates = [[NSMutableArray alloc] init] ;
    for (NSInteger i = 0 ; i < [_sportModels count]; i++) {
        [_sportBtnStates addObject:SPNum(spBtnStateNormal)] ;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectedIndex = -1 ;
    [self initSportModels] ;
    [self initBtnTag] ;
    [self initBtnState] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction

- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)ensureBtnClicked:(id)sender {
    [sp_notificationCenter postNotificationName:NOTIFICATION_SPORTS_CHOOSED object:[self getDataFromSportsBtnState]] ;
    
    [self.navigationController popViewControllerAnimated:YES] ;
}

- (IBAction)btnClicked:(UIButton *)sender {
    NSInteger index = sender.tag - 1 ;
    spBtnState state = (spBtnState)[[_sportBtnStates objectAtIndex:index] integerValue];
    
    if ( state == spBtnStateNormal ) {
        if ( _selectedIndex != -1 ) {
            //to Normal
            [self setBtn:[_btnArray objectAtIndex:_selectedIndex] toState:spBtnStateNormal] ;
            _selectedIndex = -1 ;
        }
        
        //to Selected ;
        _selectedIndex = index ;
        [self setBtn:sender toState:spBtnStateSelected] ;
        
    } else {
        //to Normal ;
        [self setBtn:sender toState:spBtnStateNormal] ;
        _selectedIndex = -1 ;
    }
}


#pragma mark - Utilits Method

- (void)setBtn:(UIButton *)sender toState:(spBtnState)state{
    NSInteger index = sender.tag - 1 ;
    SportModel *model = [_sportModels objectAtIndex:index] ;
    UIImage *img ;
    if (state == spBtnStateNormal) {
        img = [UIImage imageNamed:[model normalImgName]] ;
        
        [_sportBtnStates replaceObjectAtIndex:index withObject:SPNum(spBtnStateNormal)] ;
    } else {
        img = [UIImage imageNamed:[model
                                   selectedImgName]] ;
        [_sportBtnStates replaceObjectAtIndex:index withObject:SPNum(spBtnStateSelected)] ;
    }
    
    [sender setImage:img forState:UIControlStateNormal] ;
    
}

- (NSArray *)getDataFromSportsBtnState {
    NSMutableArray *data = [[NSMutableArray alloc] init] ;
    for (NSInteger i = 0 ; i < [_sportBtnStates count]; i++) {
        spBtnState state = (spBtnState)[[_sportBtnStates objectAtIndex:i] integerValue] ;
        
        if ( state == spBtnStateSelected ) {
            NSInteger type = [(SportModel *)[_sportModels objectAtIndex:i] type] ;
            [data addObject:SPNum(type)] ;
        }
    }
    return data ;
}

@end
