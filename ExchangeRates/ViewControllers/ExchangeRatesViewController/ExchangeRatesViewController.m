//
//  ViewController.m
//  ExchangeRates
//
//  Created by Elvis on 3/10/17.
//  Copyright © 2017 Elvis. All rights reserved.
//

#import "ExchangeRatesViewController.h"
#import "ExchangeRatesViewControllerVM.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "ExchangeRatesCell.h"

@interface ExchangeRatesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@property (strong, nonatomic) ExchangeRatesViewControllerVM *viewModel;

@end

@implementation ExchangeRatesViewController

static NSString *cellIdentifier = @"cellIdentifier";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:@"ExchangeRatesViewController" bundle:nil]) {
        self.viewModel = [[ExchangeRatesViewControllerVM alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview: self.refreshControl];
    self.refreshControl.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        [self.viewModel requestData];
        return [RACSignal empty];
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExchangeRatesCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.f;
    
    [self setupRAC];
    [self.viewModel requestData];
}

- (void)setupRAC {
    [self.viewModel.startedUpdateSignal subscribeNext:^(id  _Nullable x) {
        [self.refreshControl beginRefreshing];
    }];
    
    [self.viewModel.endedUpdateSignal subscribeNext:^(id  _Nullable x) {
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
    
    [self.viewModel.reciveErrorSignal subscribeNext:^(NSError   * _Nullable error) {
        [self.refreshControl endRefreshing];
        [AlertController showWithError: error];
        [self.tableView reloadData];
    }];
}

- (void)refreshControlHandler:(UIRefreshControl*)sender {
    [self.viewModel requestData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.cellsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExchangeRatesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    id cellVM = self.viewModel.cellsData[indexPath.row];
    [cell setupWithViewModel:cellVM];
    return cell;
}

#pragma mark - UITableViewDelegate




@end
