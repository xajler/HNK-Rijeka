#import "MISqlLiteQuery.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "MIClub.h"
#import "MIGameResult.h"
#import "MICalendarItem.h"
#import "MILeagueTableItem.h"
#import "MIPlayer.h"

NSString *const MICurrentSeason = @"2013/14";

@implementation MISqlLiteQuery

FMDatabase *db;
NSMutableArray *clubs;
NSString *path;

-(id)init
{
    self = [super init];
    
    if (self)
    {
        path = [[NSBundle mainBundle] pathForResource:@"rijeka" ofType:@"db3"];
        // NSLog(@"Path: %@", path);
        db = [FMDatabase databaseWithPath:path];
    }
    
    return self;
}


-(NSMutableArray *)getClubs
{
    [db open];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet *resultSet = [db executeQuery:@"SELECT id, name, short_name, image_name FROM clubs ORDER BY is_current DESC"];
    
    while ([resultSet next])
    {
        MIClub *club = [[MIClub alloc] init];
        
        club.id = @([resultSet intForColumn:@"id"]);
        club.name = [resultSet stringForColumn:@"name"];
        club.shortName = [resultSet stringForColumn:@"short_name"];
        club.imageName = [resultSet stringForColumn:@"image_name"];
        
        // NSLog(@"ID: %@ and Name: %@", club.id, club.name);
        
        [result addObject:club];
    }
    
    [db close];
    
    return result;
}

-(NSMutableArray *)getGameResultsFor:(NSString *)season
{
    clubs = [self getClubs];
    
    [db open];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSString *query = @"";
    FMResultSet *resultSet;
    
    NSLog(@"%@", query);
    resultSet = [db executeQuery:@"SELECT id, season, date, home_clubid, guest_clubid, home_goals, guest_goals, number FROM results WHERE season = ? ORDER BY date", season];
    
    while ([resultSet next])
    {
        MIGameResult *gameResult = [[MIGameResult alloc] init];
        gameResult.id = @([resultSet intForColumn:@"id"]);
        gameResult.season = [self getSeasonBySeason:[resultSet stringForColumn:@"season"]];
        gameResult.date = [resultSet dateForColumn:@"date"];
        gameResult.homeClub = [self getClubById:@([resultSet intForColumn:@"home_clubid"])];
        gameResult.guestClub = [self getClubById:@([resultSet intForColumn:@"guest_clubid"])];
        gameResult.homeGoals = @([resultSet intForColumn:@"home_goals"]);
        gameResult.guestGoals = @([resultSet intForColumn:@"guest_goals"]);
        gameResult.number = @([resultSet intForColumn:@"number"]);
        
        [result addObject:gameResult];
    }
    
    [db close];
    
    return result;
}

-(NSMutableArray *)getSeasons
{
    NSArray *seasons = @[ @"2013/14",
                          @"2012/13",
                          @"2011/12",
                          @"2010/11",
                          @"2009/10",
                          @"2008/09",
                          @"2007/08",
                          @"2006/07",
                          @"2005/06",
                          @"2004/05",
                          @"2003/04",
                          @"2002/03",
                          @"2001/02",
                          @"2000/01",
                          @"1999/00",
                          @"1998/99",
                          @"1997/98",
                          @"1996/97",
                          @"1995/96",
                          @"1994/95",
                          @"1993/94",
                          @"1992/93",
                          @"1992"
                          ];
    
    return [NSMutableArray arrayWithArray:seasons];
}

-(NSMutableArray *)getCalendarItems
{
    clubs = [self getClubs];
    
    [db open];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet *resultSet = [db executeQuery:@"SELECT id, home_clubid, guest_clubid, match_date FROM calendar_items ORDER BY match_date"];
    
    while ([resultSet next])
    {
        MICalendarItem *calendarItem = [[MICalendarItem alloc] init];
        calendarItem.id = @([resultSet intForColumn:@"id"]);
        calendarItem.homeClub = [self getClubById:@([resultSet intForColumn:@"home_clubid"])];
        calendarItem.guestClub = [self getClubById:@([resultSet intForColumn:@"guest_clubid"])];
        calendarItem.matchDate = [resultSet dateForColumn:@"match_date"];
        
        [result addObject:calendarItem];
    }
    
    [db close];
    
    return result;
}

-(NSMutableArray *)getLeagueTableItemsForSeason:(NSString *)season
{
    clubs = [self getClubs];
    
    [db open];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    FMResultSet *resultSet = [db executeQuery:@"SELECT id, position, wins, draws, loses, goal_for, "
                              "goal_against, points, clubid, season "
                              "FROM league_tables "
                              "WHERE season = ? "
                              "ORDER BY position", season];
    
    while ([resultSet next])
    {
        MILeagueTableItem *leagueTable = [[MILeagueTableItem alloc] init];
        leagueTable.id = @([resultSet intForColumn:@"id"]);
        leagueTable.position = @([resultSet intForColumn:@"position"]);
        leagueTable.wins = @([resultSet intForColumn:@"wins"]);
        leagueTable.draws = @([resultSet intForColumn:@"draws"]);
        leagueTable.loses = @([resultSet intForColumn:@"loses"]);
        leagueTable.goalFor = @([resultSet intForColumn:@"goal_for"]);
        leagueTable.goalAgainst = @([resultSet intForColumn:@"goal_against"]);
        leagueTable.points = @([resultSet intForColumn:@"points"]);
        leagueTable.club = [self getClubById:@([resultSet intForColumn:@"clubid"])];
        leagueTable.season = [self getSeasonBySeason:season];
        
        [result addObject:leagueTable];
    }
        
    [db close];
    
    return result;
}

-(NSMutableArray *)getPlayersForSeason:(NSString *)season andPositon:(NSString *)positon
{
    [db open];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    FMResultSet *resultSet = [db executeQuery:@"SELECT id, birth_date, height, weight, position, uniform_number, image_name, "
                              "about, contract_until_date, season, first_name, last_name "
                              "FROM players "
                              "WHERE season = ? AND position = ?", season, positon];
    
    while ([resultSet next])
    {
        MIPlayer *player = [[MIPlayer alloc] init];
        player.id = @([resultSet intForColumn:@"id"]);
        player.birthDate = [resultSet dateForColumn:@"birth_date"];
        player.height = @([resultSet intForColumn:@"height"]);
        player.weight = @([resultSet intForColumn:@"weight"]);
        player.position = [resultSet stringForColumn:@"position"];
        player.uniformNumber = @([resultSet intForColumn:@"uniform_number"]);
        player.about = [resultSet stringForColumn:@"about"];
        player.contractUntilDate = [resultSet dateForColumn:@"contract_until_date"];
        player.season = [self getSeasonBySeason:season];
        player.firstName = [resultSet stringForColumn:@"first_name"];
        player.lastName = [resultSet stringForColumn:@"last_name"];
        player.imageName = [resultSet stringForColumn:@"image_name"];
        
        [result addObject:player];
    }
    
    [db close];
    
    return result;
}

-(MIClub *)getClubById:(NSNumber *)id
{
    NSMutableArray *result = [NSMutableArray arrayWithArray:clubs];
    [result filterUsingPredicate:[NSPredicate predicateWithFormat:@"id == %@", id]];
    
//    MIClub *club = result[0];
//    NSLog(@"Id: %@", id);
//    NSLog(@"Count: %lu; Club Name: %@", [result count], club.name);
    
    return result[0];
}

-(NSString *)getSeasonBySeason:(NSString *)season
{
    NSMutableArray *result = [self getSeasons];
    [result filterUsingPredicate:[NSPredicate predicateWithFormat:@"self == %@", season]];
    
//    NSLog(@"Season: %@", season);
//    NSLog(@"Count: %lu; Season: %@", [result count], result[0]);
    
    return result[0];
}

@end
