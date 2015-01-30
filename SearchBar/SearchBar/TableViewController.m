//
//  TableViewController.m
//  SearchBar
//
//  Created by Pablo on 13/03/14.
//  Copyright (c) 2014 Pablo Marcos. All rights reserved.
//

#import "TableViewController.h"
#import "Mascota.h"

@interface TableViewController ()

@property(strong,nonatomic) NSMutableArray *mascotasArray;
@property(strong,nonatomic) NSArray *mascotasResult;

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mascotasArray = [[NSMutableArray alloc] init];
    
    Mascota *mascota01 = [[Mascota alloc] init];
    [mascota01 setNombre:@"Paco"];
    [mascota01 setEspecie:@"Perro"];
    [_mascotasArray addObject:mascota01];
    
    Mascota *mascota02 = [[Mascota alloc] init];
    [mascota02 setNombre:@"Rayo"];
    [mascota02 setEspecie:@"Perro"];
    [_mascotasArray addObject:mascota02];
    
    Mascota *mascota03 = [[Mascota alloc] init];
    [mascota03 setNombre:@"Beni"];
    [mascota03 setEspecie:@"Canario"];
    [_mascotasArray addObject:mascota03];
    
    Mascota *mascota04 = [[Mascota alloc] init];
    [mascota04 setNombre:@"Rob"];
    [mascota04 setEspecie:@"Erizo"];
    [_mascotasArray addObject:mascota04];
    
    Mascota *mascota05 = [[Mascota alloc] init];
    [mascota05 setNombre:@"Willy"];
    [mascota05 setEspecie:@"Delfin"];
    [_mascotasArray addObject:mascota05];
    
    Mascota *mascota06 = [[Mascota alloc] init];
    [mascota06 setNombre:@"Brutus"];
    [mascota06 setEspecie:@"Perro"];
    [_mascotasArray addObject:mascota06];
    
    Mascota *mascota07 = [[Mascota alloc] init];
    [mascota07 setNombre:@"Taco"];
    [mascota07 setEspecie:@"Gato"];
    [_mascotasArray addObject:mascota07];
    
    Mascota *mascota08 = [[Mascota alloc] init];
    [mascota08 setNombre:@"Lepe"];
    [mascota08 setEspecie:@"Loro"];
    [_mascotasArray addObject:mascota08];

    Mascota *mascota09 = [[Mascota alloc] init];
    [mascota09 setNombre:@"Arturo"];
    [mascota09 setEspecie:@"Loro"];
    [_mascotasArray addObject:mascota09];
    
    Mascota *mascota10 = [[Mascota alloc] init];
    [mascota10 setNombre:@"Loto"];
    [mascota10 setEspecie:@"Serpiente"];
    [_mascotasArray addObject:mascota10];
    
    Mascota *mascota11 = [[Mascota alloc] init];
    [mascota11 setNombre:@"Lila"];
    [mascota11 setEspecie:@"Serpiente"];
    [_mascotasArray addObject:mascota11];
    
    Mascota *mascota12 = [[Mascota alloc] init];
    [mascota12 setNombre:@"Taka"];
    [mascota12 setEspecie:@"Serpiente"];
    [_mascotasArray addObject:mascota12];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_mascotasResult count];
    } else {
        return [_mascotasArray count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        // Resultado de la búsqueda...
        [[cell textLabel] setText:[[_mascotasResult objectAtIndex:indexPath.row] nombre]];
        [[cell detailTextLabel] setText:[[_mascotasResult objectAtIndex:indexPath.row] especie]];
    }else{
        [[cell textLabel] setText:[[_mascotasArray objectAtIndex:indexPath.row] nombre]];
        [[cell detailTextLabel] setText:[[_mascotasArray objectAtIndex:indexPath.row] especie]];
    }
    
    return cell;
}

#pragma mark - Buscador
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.nombre contains[cd] %@ OR SELF.especie contains[cd] %@",
                                    searchText,
                                    searchText];
    
    _mascotasResult = [_mascotasArray filteredArrayUsingPredicate:resultPredicate];
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                       objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
