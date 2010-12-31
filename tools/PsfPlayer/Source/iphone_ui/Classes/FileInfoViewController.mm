#import "FileInfoViewController.h"

@implementation FileInfoViewController

-(void)dealloc 
{
    [super dealloc];
}

-(void)setTags: (const CPsfTags&)tags
{
	m_tags = tags;
	m_rawTags.clear();
	
	for(CPsfTags::ConstTagIterator tagIterator(m_tags.GetTagsBegin());
		tagIterator != m_tags.GetTagsEnd(); tagIterator++)
	{
		std::string rawTag;
		rawTag = tagIterator->first + ": " + tagIterator->second;
		m_rawTags.push_back(rawTag);
	}
	
	[self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView: (UITableView*)tableView 
{
    return 1;
}

-(NSInteger)tableView: (UITableView*)tableView numberOfRowsInSection: (NSInteger)section 
{
	if(section == 0)
	{
		return m_rawTags.size();
	}
    return 0;
}

-(NSString*)tableView: (UITableView*)tableView titleForHeaderInSection: (NSInteger)section 
{
	NSString *sectionHeader = nil;
	
	if(section == 0) 
	{
		sectionHeader = @"Raw Tags";
	}
	
	return sectionHeader;
}

-(UITableViewCell*)tableView: (UITableView*)tableView cellForRowAtIndexPath: (NSIndexPath*)indexPath 
{
	static NSString* CellIdentifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if(cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier] autorelease];
    }
	
	if(indexPath.section == 0)
	{
		std::string rawTag = m_rawTags[indexPath.row];
		cell.textLabel.text = [NSString stringWithUTF8String: rawTag.c_str()];
	}
	
    return cell;
}

@end

