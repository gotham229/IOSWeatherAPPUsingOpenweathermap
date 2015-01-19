//
//  ViewController.m
//  WeatherApp
//
//  Created by Gowtham Parvataneni on 1/18/15.
//  Copyright (c) 2015 Gowtham Parvataneni. All rights reserved.
//

#import "ViewController.h"
#import "WAAPIObjectManager.h"
#import "WACityWeatherData.h"
#import "WACitiesData.h"
#import "WACityInfo.h"
#import "Masonry.h"
#import "UIControl+BlocksKit.h"
#import "WACityWeatherDataController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITextField *typeaheadTextField;
@property (nonatomic, weak) UIView *typeaheadContainerView;
@property (nonatomic, weak) UITableView *typeaheadTableView;
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, copy) NSString *searchString;

@end

@implementation ViewController

- (void)loadView {
    
    self.view = [[UIView alloc] init];
    
    UIView *typeaheadContainerView = [[UIView alloc] init];
    self.typeaheadContainerView = typeaheadContainerView;
    self.typeaheadContainerView.backgroundColor = [UIColor whiteColor];

    self.typeaheadContainerView.clipsToBounds = YES;
    [self.view addSubview:self.typeaheadContainerView];
    
    UITextField *typeaheadTextField = [[UITextField alloc] init];
    self.typeaheadTextField = typeaheadTextField;
    self.typeaheadTextField.placeholder = @"Enter City name";
    self.typeaheadTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.typeaheadTextField.layer.cornerRadius = 2.5f;
    self.typeaheadTextField.layer.borderWidth = 1.f;
    self.typeaheadTextField.adjustsFontSizeToFitWidth = YES;
    self.typeaheadTextField.minimumFontSize = 12.f;;
    self.typeaheadTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.typeaheadTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.typeaheadContainerView addSubview:self.typeaheadTextField];
    
    
    UITableView *tableView = [UITableView new];
    self.typeaheadTableView = tableView;
    [self.typeaheadContainerView addSubview:self.typeaheadTableView];
    self.typeaheadTableView.tableFooterView = [UIView new];
    self.typeaheadTableView.tableHeaderView = [UIView new];
    [self.typeaheadTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    self.typeaheadTableView.delegate = self;
    self.typeaheadTableView.dataSource = self;
    
    [self setupViewConstraints];
    
}

- (void)setupViewConstraints {
    __weak typeof (self) weakSelf = self;
    
    
    [self.typeaheadContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    
    [self.typeaheadTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        const CGFloat padding = 10.f;
        make.top.equalTo(weakSelf.typeaheadContainerView.mas_top).with.offset(15);
        make.height.equalTo(@(40));
        make.left.equalTo(weakSelf.typeaheadContainerView.mas_left).with.offset(padding);
        make.right.equalTo(weakSelf.typeaheadContainerView.mas_right).with.offset(-padding);
    }];
    
    [self.typeaheadTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.typeaheadTextField.mas_bottom);
        make.left.equalTo(weakSelf.typeaheadContainerView.mas_left);
        make.right.equalTo(weakSelf.typeaheadContainerView.mas_right);
        make.bottom.equalTo(weakSelf.typeaheadContainerView.mas_bottom);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.    
    __weak typeof (self) weakSelf = self;
    self.title = @"Weather";
    
    [self.typeaheadTextField bk_addEventHandler:^(id sender) {
        if (weakSelf.searchString != weakSelf.typeaheadTextField.text) {
            weakSelf.searchString = weakSelf.typeaheadTextField.text;
            weakSelf.cities = [[WACitiesData sharedObject] cityInfoForCity:weakSelf.searchString];
            [weakSelf.typeaheadTableView reloadData];
        }
    } forControlEvents:UIControlEventEditingChanged];
}

#pragma mark TypeAhead UITableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= [self.cities count]) {
        return [UITableViewCell new];
    }
    
    WACityInfo *cityInfo = self.cities[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", cityInfo.city, cityInfo.country];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row >= self.cities.count) {
        return;
    }
    
    WACityInfo *cityInfo = self.cities[indexPath.row];
    WACityWeatherDataController *controller = [[WACityWeatherDataController alloc] initWithCityInfo:cityInfo];
    [self.navigationController pushViewController:controller animated:YES];
    [self.typeaheadTextField resignFirstResponder];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.typeaheadTextField resignFirstResponder];
}
@end
