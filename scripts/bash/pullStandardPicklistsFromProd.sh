#!/bin/bash
# Extracts from production, all standard Picklist values

#Account Standard Value Types
sfdx force:source:retrieve -m StandardValueSet:AccountType -u $1
sfdx force:source:retrieve -m StandardValueSet:AccountContactMultiRoles -u $1
sfdx force:source:retrieve -m StandardValueSet:AccountContactRole -u $1
sfdx force:source:retrieve -m StandardValueSet:AccountOwnership -u $1
sfdx force:source:retrieve -m StandardValueSet:AccountRating -u $1
sfdx force:source:retrieve -m StandardValueSet:AccountType -u $1

sfdx force:source:retrieve -m StandardValueSet:AssetStatus -u $1
sfdx force:source:retrieve -m StandardValueSet:CampaignMemberStatus -u $1
sfdx force:source:retrieve -m StandardValueSet:CampaignStatus -u $1
sfdx force:source:retrieve -m StandardValueSet:CampaignType -u $1

sfdx force:source:retrieve -m StandardValueSet:CaseContactRole -u $1
sfdx force:source:retrieve -m StandardValueSet:CaseOrigin -u $1
sfdx force:source:retrieve -m StandardValueSet:CasePriority -u $1
sfdx force:source:retrieve -m StandardValueSet:CaseReason -u $1
sfdx force:source:retrieve -m StandardValueSet:CaseStatus -u $1
sfdx force:source:retrieve -m StandardValueSet:CaseType -u $1


sfdx force:source:retrieve -m StandardValueSet:ContractStatus -u $1
sfdx force:source:retrieve -m StandardValueSet:EntitlementType -u $1

#Events / Tasks
sfdx force:source:retrieve -m StandardValueSet:EventSubject -u $1
sfdx force:source:retrieve -m StandardValueSet:EventType -u $1
sfdx force:source:retrieve -m StandardValueSet:TaskPriority -u $1
sfdx force:source:retrieve -m StandardValueSet:TaskStatus -u $1
sfdx force:source:retrieve -m StandardValueSet:TaskSubject -u $1
sfdx force:source:retrieve -m StandardValueSet:TaskType -u $1

#Fiscal Year
sfdx force:source:retrieve -m StandardValueSet:FiscalYearPeriodName -u $1
sfdx force:source:retrieve -m StandardValueSet:FiscalYearPeriodPrefix -u $1
sfdx force:source:retrieve -m StandardValueSet:FiscalYearQuarterName -u $1
sfdx force:source:retrieve -m StandardValueSet:FiscalYearQuarterPrefix -u $1

#Ideas
sfdx force:source:retrieve -m StandardValueSet:IdeaCategory1 -u $1
sfdx force:source:retrieve -m StandardValueSet:IdeaMultiCategory -u $1
sfdx force:source:retrieve -m StandardValueSet:IdeaStatus -u $1
sfdx force:source:retrieve -m StandardValueSet:IdeaThemeStatus -u $1

#Industry
sfdx force:source:retrieve -m StandardValueSet:Industry -u $1

#Lead
sfdx force:source:retrieve -m StandardValueSet:LeadSource -u $1

#Opportunity
sfdx force:source:retrieve -m StandardValueSet:ContactRole -u $1
sfdx force:source:retrieve -m StandardValueSet:ContractContactRole -u $1
sfdx force:source:retrieve -m StandardValueSet:Opportunity.Source -u $1
sfdx force:source:retrieve -m StandardValueSet:OpportunityCompetitor -u $1
sfdx force:source:retrieve -m StandardValueSet:OpportunityStage -u $1
sfdx force:source:retrieve -m StandardValueSet:OpportunityType -u $1
sfdx force:source:retrieve -m StandardValueSet:SalesTeamRole -u $1

#Orders
sfdx force:source:retrieve -m StandardValueSet:OrderStatus -u $1
sfdx force:source:retrieve -m StandardValueSet:OrderType -u $1
sfdx force:source:retrieve -m StandardValueSet:PartnerRole -u $1

sfdx force:source:retrieve -m StandardValueSet:Product2Family -u $1
sfdx force:source:retrieve -m StandardValueSet:QuestionOrigin1 -u $1
sfdx force:source:retrieve -m StandardValueSet:QuickTextCategory -u $1
sfdx force:source:retrieve -m StandardValueSet:QuickTextChannel -u $1
sfdx force:source:retrieve -m StandardValueSet:QuoteStatus -u $1
sfdx force:source:retrieve -m StandardValueSet:RoleInTerritory2 -u $1
sfdx force:source:retrieve -m StandardValueSet:Salutation	 -u $1

sfdx force:source:retrieve -m StandardValueSet:ServiceContractApprovalStatus -u $1
sfdx force:source:retrieve -m StandardValueSet:SocialPostClassification -u $1
sfdx force:source:retrieve -m StandardValueSet:SocialPostEngagementLevel -u $1
sfdx force:source:retrieve -m StandardValueSet:SolutionStatus -u $1

sfdx force:source:retrieve -m StandardValueSet:WorkOrderLineItemStatus -u $1
sfdx force:source:retrieve -m StandardValueSet:WorkOrderPriority -u $1
sfdx force:source:retrieve -m StandardValueSet:WorkOrderStatus -u $1
