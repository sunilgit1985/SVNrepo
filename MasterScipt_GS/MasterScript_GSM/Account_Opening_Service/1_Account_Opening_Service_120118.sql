
/*01_ap_pdf_service_tables.sql120118_abhnag*/

use service;

DROP TABLE IF EXISTS `pdf_file_details`;
CREATE TABLE `pdf_file_details` (
  `vendor` varchar(20) NOT NULL,
  `fileName` varchar(100) NOT NULL,
  `fileId` varchar(45) NOT NULL,
  `fileExtension` varchar(10) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `active` varchar(1) NOT NULL DEFAULT 'N',
  `fileNameAppender` varchar(20) DEFAULT NULL,
  `appenderType` varchar(20) DEFAULT NULL,
  `appenderFormat` varchar(20) DEFAULT NULL,
  `available` varchar(7) DEFAULT NULL,
  `sourceDir` varchar(80) DEFAULT NULL COMMENT 'Local Directory',
  `uploadDir` varchar(80) DEFAULT NULL COMMENT 'SFTP Server Directory',
  `isPwdProtected` varchar(1) DEFAULT 'N',
  `pwdRules` varchar(10) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `lastupdated` datetime DEFAULT NULL,
  PRIMARY KEY (`vendor`,`fileName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `service`.`pdf_file_details` (`vendor`, `fileName`, `fileId`, `fileExtension`, `description`, `active`, `isPwdProtected`) VALUES ('UOB', 'APPLICATION TO OPEN ROBO ADVISOR ACCOUNT - EXISTING USER', 'UOB_ACCT_OPEN_EXISTING_USER', 'pdf', 'UOBKH Individual & Joint Application for ROBO Advisor Account _Existing Client_ 27 Oct 2017', 'A', 'N');
INSERT INTO `service`.`pdf_file_details` (`vendor`, `fileName`, `fileId`, `fileExtension`, `description`, `active`, `isPwdProtected`) VALUES ('UOB', 'APPLICATION TO OPEN ROBO ADVISOR ACCOUNT - NEW USER', 'UOB_ACCT_OPEN_NEW_USER', 'pdf', 'UOBKH Individual & Joint Application for ROBO Advisor Account _New Client_ 27 Oct 2017', 'A', 'N');
INSERT INTO `service`.`pdf_file_details` (`vendor`, `fileName`, `fileId`, `fileExtension`, `description`, `active`, `isPwdProtected`) VALUES ('UOB', 'Guide and Cautionary Notes', 'UOB_GUIDE_CAUTIONARY_NOTES', 'pdf', 'Guide and Cautionary Notes', 'I', 'N');
INSERT INTO `service`.`pdf_file_details` (`vendor`, `fileName`, `fileId`, `fileExtension`, `description`, `active`, `isPwdProtected`) VALUES ('UOB', 'Risk Disclosure Statements 27 Oct 2017', 'UOB_RISK_DISC_STATEMENT', 'pdf', 'Risk Disclosure Statements 27 Oct 2017', 'I', 'N');




DROP TABLE IF EXISTS `pdf_file_rules`;
CREATE TABLE `pdf_file_rules` (
  `fileId` varchar(45) NOT NULL,
  `dataField` varchar(45) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `pageNo` int(2) DEFAULT NULL,
  `xcord` float DEFAULT NULL,
  `ycord` float DEFAULT NULL,
  `length` int(5) DEFAULT NULL,
  `dbColumn` varchar(45) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL,
  `isRequired` varchar(1) DEFAULT 'N',
  `needToEncrypt` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`fileId`,`dataField`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'acctTypeId', 'Type of Account', '4', '230', '30', 'acctTypeId', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'controlOverUOBAcct', 'any trading account', '4', '230', '30', 'controlOverUOBAcct', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'controlOverUOBAcctName1', 'Account Name1', '4', '230', '30', 'controlOverUOBAcctName1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'controlOverUOBAcctName2', 'Account Name2', '4', '230', '30', 'controlOverUOBAcctName2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'controlOverUOBAcctNumber1', 'Account No.1', '4', '230', '30', 'controlOverUOBAcctNumber1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'controlOverUOBAcctNumber2', 'Account No.2', '4', '230', '30', 'controlOverUOBAcctNumber2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'dbCOlumn', 'description', '4', '230', '30', 'dbCOlumn', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'employerCity,employerState', 'City / State', '4', '230', '30', 'employerCity,employerState', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'employerStreetAddress4', 'Employer Address', '2', '230', '132', '1', 'employerStreetAddress4', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'faxNumber', 'Fax No.', '4', '230', '30', 'faxNumber', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'investmentObjectives', 'investmentObjectives', '4', '230', '30', 'investmentObjectives', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'investmentObjectiveSpecify', 'investmentObjectiveSpecify', '4', '230', '30', 'investmentObjectiveSpecify', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointannualIncome', 'jointAnnual Income', '4', '230', '30', 'annualIncome', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointareYouUnableToPayYouDebts ', 'jointAreYouUnableToPayYouDebts ', '4', '230', '30', 'areYouUnableToPayYouDebts ', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointareYouUnableToPayYouDebtsDescribe', 'jointAreYouUnableToPayYouDebtsDescribe', '4', '230', '30', 'areYouUnableToPayYouDebtsDescribe', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointcontrolOverUOBAcct', 'jointany trading account', '4', '230', '30', 'controlOverUOBAcct', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointcontrolOverUOBAcctName1', 'jointAccount Name1', '4', '230', '30', 'controlOverUOBAcctName1', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointcontrolOverUOBAcctName2', 'jointAccount Name2', '4', '230', '30', 'controlOverUOBAcctName2', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointcontrolOverUOBAcctNumber1', 'jointAccount No.1', '4', '230', '30', 'controlOverUOBAcctNumber1', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointcontrolOverUOBAcctNumber2', 'jointAccount No.2', '4', '230', '30', 'controlOverUOBAcctNumber2', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointcountryOfBirth', 'jointCountry of Birth', '1', '230', '64', '1', 'countryOfBirth', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointcountryOfBirthSpecify', 'jointCountry of Birth Other Specify', '1', '230', '1', '1', 'countryOfBirthSpecify', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointdob', 'jointDate of Birth (DD/MM/YYYY)', '4', '230', '475', 'dob', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointdoYouHaveAnyDisputedAccount', 'jointDoYouHaveAnyDisputedAccount', '4', '230', '30', 'doYouHaveAnyDisputedAccount', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointdoYouHaveAnyDisputedAccountDescribe', 'jointDoYouHaveAnyDisputedAccountDescribe', '4', '230', '30', 'doYouHaveAnyDisputedAccountDescribe', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointemployerCityEmployerState', 'jointCity / State', '2', '230', '116', '1', 'employerCity', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointemployerName', 'jointName of Employer', '4', '230', '215', 'employerName', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointemployerStreetAddress1', 'jointEmployer Address', '4', '230', '200', 'employerStreetAddress1', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointemployerStreetAddress2', 'jointEmployer Address', '4', '230', '200', 'employerStreetAddress2', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointemployerStreetAddress3', 'jointEmployer Address', '4', '230', '200', 'employerStreetAddress3', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointemployerStreetAddress4', 'jointEmployer Address', '4', '230', '200', 'employerStreetAddress4', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointemployerZipCode', 'jointPostal Code', '4', '230', '185', 'employerZipCode', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointemployerZipCountry', 'jointCountry', '4', '230', '170', 'employerZipCountry', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointfatherName', 'jointFather’s Name ', '4', '230', '30', 'fatherName', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointfaxNumber', 'jointFax No.', '4', '230', '30', 'faxNumber', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointfullName', 'jointFullname', '1', '230', '-15', '1', 'fullName', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointgender', 'jointGender', '1', '230', '174', '1', 'gender', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointhomeTelNumber', 'jointHome Tel No.', '1', '230', '-31', '1', 'homeTelNumber', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointinvestmentObjectives', 'jointInvestentObjectives', '4', '230', '30', 'investmentObjectives', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointinvestmentObjectiveSpecify', 'jointInvestmentObjectiveSpecify', '4', '230', '30', 'investmentObjectiveSpecify', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointmobNumber', 'jointMobile No.', '1', '230', '-47', '1', 'mobNumber', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointmotherMaidenName', 'jointMother’s Maiden Name ', '4', '230', '30', 'motherMaidenName', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointnameOfOtherFinancialInstitution', 'jointNameOfOtherFinancialInstitution', '4', '230', '30', 'nameOfOtherFinancialInstitution', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointnameOfPrimarySchool', 'jointName of Primary School Attended', '4', '230', '30', 'nameOfPrimarySchool', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointnationality', 'jointNationality', '1', '230', '-63', '1', 'nationality', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointnationalitySpecify', 'jointNationality Other Specify', '1', '230', '-78', '1', 'nationalitySpecify', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointnetworth', 'jointNetworth', '4', '230', '30', 'networth', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointnricPassport', 'jointNRIC/Passport No.', '1', '230', '-94', '1', 'nric, passport', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointoccupation', 'jointOccupation', '4', '230', '30', 'occupation', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointofficeTelNumber', 'jointOffice Tel No.', '4', '230', '30', 'officeTelNumber', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointpermanentResidentOfSingapore', 'jointPermanent Resident of Singapore', '1', '230', '-189', '1', 'permanentResidentOfSingapore', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointphysicalAddressCity, physicalAddressStat', 'jointCity / State', '1', '230', '-204', '1', 'physicalAddressCity, physicalAddressState', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointphysicalAddressCountry', 'jointCountry', '1', '230', '-157', '1', 'physicalAddressCountry', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointPhysicalAddressStreet1', 'jointResidential Address', '1', '230', '-141', '1', 'physicalAddressStreet1', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointphysicalAddressStreet2', 'jointResidential Address', '1', '230', '-173', '1', 'physicalAddressStreet2', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointphysicalAddressStreet3', 'jointResidential Address', '1', '230', '-126', '1', 'physicalAddressStreet3', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointphysicalAddressStreet4', 'jointResidential Address', '1', '230', '142', '1', 'physicalAddressStreet4', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointphysicalAddressZipCode', 'jointPostal Code', '1', '230', '-110', '1', 'physicalAddressZipCode', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointpreviousInvestingExperience ', 'jointPreviousInvestingExperience ', '4', '230', '30', 'previousInvestingExperience ', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointpreviousInvestingExperienceSpecify', 'jointPreviousInvestingExperienceSpecify', '4', '230', '30', 'previousInvestingExperienceSpecify', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointqualifications', 'jointEducational Qualifications', '4', '230', '30', 'qualifications', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointqualificationsSpecify', 'jointEducational Qualifications Other Specify', '4', '230', '30', 'qualificationsSpecify', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointrelatedToAnyEmplfUOB', 'jointRelated to any employee', '4', '230', '30', 'relatedToAnyEmplfUOB', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointrelatedToAnyEmplName1', 'jointName1', '4', '230', '30', 'relatedToAnyEmplName1', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointrelatedToAnyEmplName2', 'jointName2', '4', '230', '30', 'relatedToAnyEmplName2', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointrelatedToAnyEmplRelation1', 'jointRelationship1', '4', '230', '30', 'relatedToAnyEmplRelation1', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointrelatedToAnyEmplRelation2', 'jointRelationship2', '4', '230', '30', 'relatedToAnyEmplRelation2', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointsourceOfFundsWealth', 'jointSource of Funds / Wealth', '4', '230', '30', 'sourceOfFundsWealth', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointsourceOfFundsWealthSpecify', 'jointSource of Funds / Wealth Other Specify', '4', '230', '30', 'sourceOfFundsWealthSpecify', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointssn', 'jointUS Taxpayer Identification No.', '1', '230', '16', '1', 'ssn', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointtitle', 'jointTitile', '1', '230', '48', '1', 'title', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointuobAcctHolderControlOverTradeAcct', 'jointany account holder', '4', '230', '30', 'uobAcctHolderControlOverTradeAcct', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointuobAcctHolderControlOverTradeAcctName1', 'jointAccount Name1', '4', '230', '30', 'uobAcctHolderControlOverTradeAcctName1', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointuobAcctHolderControlOverTradeAcctName2', 'jointAccount Name2', '4', '230', '30', 'uobAcctHolderControlOverTradeAcctName2', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointuobAcctHolderControlOverTradeAcctNumber1', 'jointAccount No.1', '4', '230', '30', 'uobAcctHolderControlOverTradeAcctNumber1', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'jointuobAcctHolderControlOverTradeAcctNumber2', 'jointAccount No.2', '4', '230', '30', 'uobAcctHolderControlOverTradeAcctNumber2', 'Joint', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'mailingAddressStreet4', 'Residential Address', '1', '230', '39', '1', 'mailingAddressStreet4', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'nameOfOtherFinancialInstitution', 'nameOfOtherFinancialInstitution', '4', '230', '30', 'nameOfOtherFinancialInstitution', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'physicalAddressStreet4', 'Residential Address', '1', '230', '55', '1', 'physicalAddressStreet4', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'previousInvestingExperience ', 'previousInvestingExperience ', '4', '230', '30', 'previousInvestingExperience ', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'previousInvestingExperienceSpecify', 'previousInvestingExperienceSpecify', '4', '230', '30', 'previousInvestingExperienceSpecify', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'relatedToAnyEmplfUOB', 'related to any employee', '4', '230', '30', 'relatedToAnyEmplfUOB', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'ROBOReferenceNo', 'ROBOReferenceNo.', '4', '230', '30', '', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'sourceOfFundsWealthSpecify', 'Source of Funds / Wealth Other Specify', '4', '230', '30', 'sourceOfFundsWealthSpecify', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'trCode', 'TR Code ', '4', '230', '30', '', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'trName', 'TR Name', '4', '230', '30', '', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'uobAcctHolderControlOverTradeAcct', 'any account holder', '4', '230', '30', 'uobAcctHolderControlOverTradeAcct', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'uobAcctHolderControlOverTradeAcctName1', 'Account Name1', '4', '230', '30', 'uobAcctHolderControlOverTradeAcctName1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'uobAcctHolderControlOverTradeAcctName2', 'Account Name2', '4', '230', '30', 'uobAcctHolderControlOverTradeAcctName2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'uobAcctHolderControlOverTradeAcctNumber1', 'Account No.1', '4', '230', '30', 'uobAcctHolderControlOverTradeAcctNumber1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'uobAcctHolderControlOverTradeAcctNumber2', 'Account No.2', '4', '230', '30', 'uobAcctHolderControlOverTradeAcctNumber2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('2', 'UOBKHTradingAccountNo', 'UOBKHTradingAccountNo.', '4', '230', '30', '', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'acctnum', 'acctnum', '1', '230', '650', '5', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'acctnum1', 'acctnum', '1', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'acctnum2', 'acctnum', '2', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'acctTypeId', 'Account Type', '1', '230', '609', '2', 'acctTypeVal', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAccountHolderName', 'Name of Bank Account Holder', '1', '230', '360', '4', 'bankAccountHolderName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAccountNo', 'bankAccountNo', '1', '230', '318', '1', 'bankAccountNo', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAddressCity,  bankAddressState', 'bankAddressCity,  bankAddressState', '1', '230', '260', '1', 'bankAddressCity', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAddressCountry', 'bankAddressCountry', '1', '230', '231', '1', 'bankAddressCountry', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAddressStreet1', 'bankAddressStreet1', '1', '230', '304', '1', 'bankAddressStreet1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAddressStreet2', 'bankAddressStreet2', '1', '230', '289', '1', 'bankAddressStreet2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAddressStreet3', 'bankAddressStreet3', '1', '230', '275', '1', 'bankAddressStreet3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankAddressZipCode', 'bankAddressZipCode', '1', '230', '246', '1', 'bankAddressZipCode', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'bankName', 'bankName', '1', '230', '333', '2', 'bankName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'correspondentBank', 'correspondentBank', '1', '230', '202', '1', 'correspondentBank', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'correspondentBankSwiftBic', 'correspondentBankSwiftBic', '1', '230', '187', '1', 'correspondentBankSwiftBic', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'dateOfApplication', 'Date Of Application', '1', '230', '565', '1', 'dateOfApplication', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'emailAddress', 'Email Address', '1', '230', '414', '4', 'emailAddress', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'existingTradeAcctNumber', 'UOBKH Existing Account Number', '1', '230', '635', '1', 'existingTradeAcctNumber', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'fatherName', 'Father’s Name', '2', '230', '416', '1', 'fatherName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'fullName', 'fullname', '1', '230', '496', '5', 'fullName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'icno', 'I C No.', '1', '230', '482', '0', 'icno', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'jurisdictionOfTaxResidence1', 'jurisdictionOfTaxResidence1', '2', '110', '606', '13', 'jurisdictionOfTaxResidence1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'jurisdictionOfTaxResidence2', 'jurisdictionOfTaxResidence2', '2', '110', '591', '1', 'jurisdictionOfTaxResidence2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'jurisdictionOfTaxResidence3', 'jurisdictionOfTaxResidence3', '2', '110', '577', '1', 'jurisdictionOfTaxResidence3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'jurisdictionOfTaxResidenceB1', 'jurisdictionOfTaxResidenceB1', '2', '110', '523', '4', 'jurisdictionOfTaxResidenceB1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'jurisdictionOfTaxResidenceB2', 'jurisdictionOfTaxResidenceB2', '2', '110', '509', '1', 'jurisdictionOfTaxResidenceB2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'jurisdictionOfTaxResidenceB3', 'jurisdictionOfTaxResidenceB3', '2', '110', '494', '1', 'jurisdictionOfTaxResidenceB3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'mobNumber', 'Mobile No.', '1', '270', '467', '0', 'mobNumber', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'mobNumberCD', 'Mob Number CD', '1', '230', '467', '1', 'mobNumberCD', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'motherMaidenName', 'Mother’s Maiden Name', '2', '230', '431', '5', 'motherMaidenName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'nameOfPrimarySchool', 'Name of Primary School Attended', '2', '230', '401', '1', 'nameOfPrimarySchool', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'nric', 'NRIC', '1', '230', '482', '1', 'nric', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'passport', 'Passport No.', '1', '230', '482', '0', 'passport', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'repId', 'TR Code', '1', '230', '594', '1', 'repId', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'salesPersonName', 'TR Name', '1', '230', '579', '1', 'salesPersonName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'swiftBic', 'swiftBic', '1', '230', '216', '1', 'swiftBic', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'taxIdentificationNumber1', 'taxIdentificationNumber1', '2', '260', '606', '0', 'taxIdentificationNumber1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'taxIdentificationNumber2', 'taxIdentificationNumber2', '2', '260', '591', '0', 'taxIdentificationNumber2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'taxIdentificationNumber3', 'taxIdentificationNumber3', '2', '260', '577', '0', 'taxIdentificationNumber3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'tinUnavailableReason1', 'tinUnavailableReason1', '2', '415', '606', '0', 'tinUnavailableReason1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'tinUnavailableReason2', 'tinUnavailableReason2', '2', '415', '591', '0', 'tinUnavailableReason2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'tinUnavailableReason3', 'tinUnavailableReason3', '2', '415', '577', '0', 'tinUnavailableReason3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'tinUnavailableValueB1', 'tinUnavailableValueB1', '2', '260', '523', '0', 'tinUnavailableValueB1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'tinUnavailableValueB2', 'tinUnavailableValueB2', '2', '260', '509', '0', 'tinUnavailableValueB2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_EXISTING_USER', 'tinUnavailableValueB3', 'tinUnavailableValueB3', '2', '260', '494', '0', 'tinUnavailableValueB3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctnum', 'acctnum', '1', '230', '650', '5', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctnum1', 'acctnum', '1', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctnum2', 'acctnum', '2', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctnum3', 'acctnum', '3', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctnum4', 'acctnum', '4', '490', '723', '1', 'acctnum', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'acctTypeId', 'Account Type', '1', '230', '635', '1', 'acctTypeVal', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'annualIncome', 'Annual Income', '3', '230', '353', '4', 'annualIncome', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'areYouUnableToPayYouDebts', 'areYouUnableToPayYouDebts', '4', '230', '455', '9', 'areYouUnableToPayYouDebts', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'areYouUnableToPayYouDebtsDescribe', 'areYouUnableToPayYouDebtsDescribe', '4', '80', '428', '2', 'areYouUnableToPayYouDebtsDescribe', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAccountHolderName', 'Name of Bank Account Holder', '2', '230', '481', '4', 'bankAccountHolderName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAccountNo', 'bankAccountNo', '2', '230', '439', '1', 'bankAccountNo', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAddressCity,  bankAddressState', 'bankAddressCity,  bankAddressState', '2', '230', '381', '1', 'bankAddressCity', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAddressCountry', 'bankAddressCountry', '2', '230', '352', '1', 'bankAddressCountry', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAddressStreet1', 'bankAddressStreet1', '2', '230', '425', '1', 'bankAddressStreet1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAddressStreet2', 'bankAddressStreet2', '2', '230', '410', '1', 'bankAddressStreet2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAddressStreet3', 'bankAddressStreet3', '2', '230', '396', '1', 'bankAddressStreet3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankAddressZipCode', 'bankAddressZipCode', '2', '230', '367', '1', 'bankAddressZipCode', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'bankName', 'bankName', '2', '230', '454', '2', 'bankName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'consentCallContact', 'consentCallContact', '4', '230', '231', '8', 'consentCallContact', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'consentTextContact', 'consentTextContact', '4', '230', '217', '1', 'consentTextContact', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'correspondentBank', 'correspondentBank', '2', '230', '323', '1', 'correspondentBank', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'correspondentBankSwiftBic', 'correspondentBankSwiftBic', '2', '230', '309', '1', 'correspondentBankSwiftBic', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'countryOfBirth', 'Country of Birth', '1', '230', '466', '1', 'countryOfBirth', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'countryOfBirthSpecify', 'Country of Birth Other Specify', '1', '320', '466', '0', 'countryOfBirthSpecify', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'dateOfApplication', 'Date Of Application', '1', '230', '592', '1', 'dateOfApplication', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'dob', 'Date of Birth (DD/MM/YYYY)', '1', '230', '452', '1', 'dobDDMMYYYY', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'doYouHaveAnyDisputedAccount', 'doYouHaveAnyDisputedAccount', '4', '230', '372', '4', 'doYouHaveAnyDisputedAccount', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'doYouHaveAnyDisputedAccountDescribe', 'doYouHaveAnyDisputedAccountDescribe', '4', '80', '345', '2', 'doYouHaveAnyDisputedAccountDescribe', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'emailAddress', 'Email Address', '1', '230', '367', '1', 'emailAddress', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerCity,employerState', 'City / State', '3', '230', '451', '1', 'employerCity', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerName', 'Name of Employer', '3', '230', '509', '1', 'employerName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerStreetAddress1', 'Employer Address', '3', '230', '494', '1', 'employerStreetAddress1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerStreetAddress2', 'Employer Address', '3', '230', '480', '1', 'employerStreetAddress2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerStreetAddress3', 'Employer Address', '3', '230', '465', '1', 'employerStreetAddress3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerZipCode', 'Postal Code', '3', '230', '436', '1', 'employerZipCode', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employerZipCountry', 'Country', '3', '230', '422', '1', 'employerZipCountry', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'employmentStatus', 'Employment Status', '3', '230', '553', '5', 'emplTypeId', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'fatherName', 'Father’s Name', '3', '230', '635', '1', 'fatherName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'fullName', 'fullname', '1', '230', '510', '1', 'fullName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'gender', 'gender', '1', '230', '495', '1', 'gender', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'goodsServicesTax', 'Goods & Services Tax', '3', '230', '268', '3', 'havingGST', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'homeTelNumber', 'Home Tel No.', '1', '270', '381', '0', 'homeTelNumber', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'homeTelNumberCD', 'Home TelNumber CD', '1', '230', '381', '1', 'homeTelNumberCD', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'icno', 'I C No.', '1', '230', '481', '0', 'icno', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'jurisdictionOfTaxResidence1', 'jurisdictionOfTaxResidence1', '2', '110', '198', '8', 'jurisdictionOfTaxResidence1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'jurisdictionOfTaxResidence2', 'jurisdictionOfTaxResidence2', '2', '110', '183', '1', 'jurisdictionOfTaxResidence2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'jurisdictionOfTaxResidence3', 'jurisdictionOfTaxResidence3', '2', '110', '169', '1', 'jurisdictionOfTaxResidence3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'jurisdictionOfTaxResidenceB1', 'jurisdictionOfTaxResidenceB1', '2', '110', '113', '4', 'jurisdictionOfTaxResidenceB1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'jurisdictionOfTaxResidenceB2', 'jurisdictionOfTaxResidenceB2', '2', '110', '98', '1', 'jurisdictionOfTaxResidenceB2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'jurisdictionOfTaxResidenceB3', 'jurisdictionOfTaxResidenceB3', '2', '110', '84', '1', 'jurisdictionOfTaxResidenceB3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailAddressSameAsPhysical', 'Mailing Address Same As Physical', '2', '230', '650', '5', 'mailAddressSameAsPhysical', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailingAddressCity, mailingAddressState', 'Mailing City / State', '2', '230', '564', '1', 'mailingAddressCity', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailingAddressCountry', 'Mailing Country', '2', '230', '535', '1', 'mailingAddressCountry', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailingAddressStreet1', 'Mailing Address', '2', '230', '608', '1', 'mailingAddressStreet1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailingAddressStreet2', 'Mailing Address', '2', '230', '593', '1', 'mailingAddressStreet2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailingAddressStreet3', 'Mailing Address', '2', '230', '578', '1', 'mailingAddressStreet3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mailingAddressZipCode', 'Mailing Postal Code', '2', '230', '549', '1', 'mailingAddressZipCode', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mobNumber', 'Mobile No.', '1', '270', '396', '0', 'mobNumber', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'mobNumberCD', 'Mob Number CD', '1', '230', '396', '2', 'mobNumberCD', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'motherMaidenName', 'Mother’s Maiden Name', '3', '230', '650', '5', 'motherMaidenName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'nameOfPrimarySchool', 'Name of Primary School Attended', '3', '230', '621', '1', 'nameOfPrimarySchool', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'nationality', 'Nationality', '1', '230', '437', '1', 'nationality', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'nationalitySpecify', 'Nationality Other Specify', '1', '320', '437', '0', 'nationalitySpecify', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'networth', 'Networth', '3', '230', '324', '1', 'networth', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'nric', 'NRIC', '1', '230', '481', '1', 'nric', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'occupation', 'Occupation', '3', '230', '523', '1', 'occupation', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'officeTelNumber', 'Office Tel No.', '3', '270', '407', '0', 'officeTelNumber', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'officeTelNumberCD', 'Office Tel Number CD', '3', '230', '407', '1', 'officeTelNumberCD', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'passport', 'Passport No.', '1', '230', '481', '0', 'passport', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'permanentRsdntOfSingapore', 'Permanent Resident of Singapore', '1', '230', '423', '1', 'permanentRsdntOfSingapore', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'physicalAddressCity, physicalAddressState', 'Residential City / State', '1', '230', '269', '1', 'physicalAddressCity', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'physicalAddressCountry', 'Residential Country', '1', '230', '240', '1', 'physicalAddressCountry', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'physicalAddressStreet1', 'Residential Address', '1', '230', '313', '4', 'physicalAddressStreet1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'physicalAddressStreet2', 'Residential Address', '1', '230', '298', '1', 'physicalAddressStreet2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'physicalAddressStreet3', 'Residential Address', '1', '230', '284', '1', 'physicalAddressStreet3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'physicalAddressZipCode', 'Residential Postal Code', '1', '230', '255', '1', 'physicalAddressZipCode', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'qualifications', 'Educational Qualifications', '3', '230', '310', '1', 'qualifications', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'qualificationsSpecify', 'Educational Qualifications Other Specify', '3', '350', '310', '0', 'qualificationsSpecify', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'reasonForMailAddreDiffer', 'reasonForMailAddreDiffer', '2', '230', '622', '2', 'reasonForMailAddreDiffer', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'relatedToAnyEmplfUOB', 'relatedToAnyEmplfUOB', '4', '505', '645', '1', 'relatedToAnyEmplfUOB', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'relatedToAnyEmplName1', 'Name1', '4', '230', '630', '1', 'relatedToAnyEmplName1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'relatedToAnyEmplName2', 'Name2', '4', '230', '601', '1', 'relatedToAnyEmplName2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'relatedToAnyEmplRelation1', 'Relationship1', '4', '230', '616', '1', 'relatedToAnyEmplRelation1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'relatedToAnyEmplRelation2', 'Relationship2', '4', '230', '587', '1', 'relatedToAnyEmplRelation2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'repId', 'TR Code', '1', '230', '621', '1', 'repId', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'salesPersonName', 'TR Name', '1', '230', '606', '1', 'salesPersonName', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'sourceOfFundsWealth', 'Source of Funds / Wealth', '3', '230', '339', '1', 'sourceOfFundsWealth', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'sourceOfFundsWealthSpecify', 'Source of Funds / Wealth Other Specify', '3', '350', '339', '0', 'sourceOfFundsWealthSpecify', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'swiftBic', 'swiftBic', '2', '230', '338', '1', 'swiftBic', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'taxIdentificationNumber1', 'taxIdentificationNumber1', '2', '260', '198', '0', 'taxIdentificationNumber1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'taxIdentificationNumber2', 'taxIdentificationNumber2', '2', '260', '183', '0', 'taxIdentificationNumber2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'taxIdentificationNumber3', 'taxIdentificationNumber3', '2', '260', '169', '0', 'taxIdentificationNumber3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'tinUnavailableReason1', 'tinUnavailableReason1', '2', '415', '198', '0', 'tinUnavailableReason1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'tinUnavailableReason2', 'tinUnavailableReason2', '2', '415', '183', '0', 'tinUnavailableReason2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'tinUnavailableReason3', 'tinUnavailableReason3', '2', '415', '169', '0', 'tinUnavailableReason3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'tinUnavailableValueB1', 'tinUnavailableValueB1', '2', '260', '113', '0', 'tinUnavailableValueB1', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'tinUnavailableValueB2', 'tinUnavailableValueB2', '2', '260', '98', '0', 'tinUnavailableValueB2', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'tinUnavailableValueB3', 'tinUnavailableValueB3', '2', '260', '84', '0', 'tinUnavailableValueB3', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'title', 'titile', '1', '230', '524', '5', 'title', 'Client', 'N', 'N');
INSERT INTO `service`.`pdf_file_rules` (`fileId`, `dataField`, `description`, `pageNo`, `xcord`, `ycord`, `length`, `dbColumn`, `role`, `isRequired`, `needToEncrypt`) VALUES ('UOB_ACCT_OPEN_NEW_USER', 'unemploymentReason', 'Unemployment Reason', '3', '230', '538', '1', 'reasonForUnemployment', 'Client', 'N', 'N');


/*02_ap_pdf_file_rules.sql120118_abhnag*/

INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'CC_EXTERNAL_RECEIVER', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'CC_INVESSENCE_RECEIVER', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'HOST', 'smtp.gmail.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'L1_SUPPORT_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'L2_SUPPORT_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'LOCAL_SRC_DIRECTORY', 'C:/UOB/data/acctOpenfiles', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PASSWORD', 'G3n3r@l89', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PDF_FILES_CUST_DIRECTORY', 'D:/data1/pdf/UOB/customerFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PDF_FILES_MASTER_DIRECTORY', 'D:/data1/pdf/UOB/masterFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PORT', '587', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'SENDER_EMAIL', 'no-reply@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'SFTP_SRC_DIRECTORY', '/data/download/UOB/acctOpenfiles', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'USERNAME', 'no-reply@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('DEV', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'ZIP_FILES_DIRECTORY', 'D:/data1/pdf/UOB/zipFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'CC_EXTERNAL_RECEIVER', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'CC_INVESSENCE_RECEIVER', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'HOST', 'smtp.gmail.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'L1_SUPPORT_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'L2_SUPPORT_EMAIL', 'abhangp@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'LOCAL_SRC_DIRECTORY', 'C:/UOB/data/acctOpenfiles', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PASSWORD', 'G3n3r@l89', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PDF_FILES_CUST_DIRECTORY', '/data/pdf/UOB/customerFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PDF_FILES_MASTER_DIRECTORY', '/data/pdf/UOB/masterFiles/', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'PORT', '587', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'SENDER_EMAIL', 'no-reply@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'SFTP_SRC_DIRECTORY', '/data/download/UOB/acctOpenfiles', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'USERNAME', 'no-reply@invessence.com', 'N', '2017-11-16 11:10:02');
INSERT INTO `service`.`service_config_details` (`mode`, `company`, `service`, `vendor`, `name`, `value`, `encrFlag`, `created`) VALUES ('UAT', 'UOB', 'DOCUMENT-SERVICES', 'iText', 'ZIP_FILES_DIRECTORY', '/data/pdf/UOB/zipFiles/', 'N', '2017-11-16 11:10:02');



INSERT INTO `service`.`service_master` (`company`, `service`, `status`, `vendor`) VALUES ('UOB', 'DOCUMENT-SERVICES', 'A', 'iTEXT');



INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `refValue`) VALUES ('UOB', 'DOCUMENT-SERVICES', 'ACCT_OPEN_EXISTING_USER', 'iText', 'A', 'UOB_ACCT_OPEN_EXISTING_USER');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `refValue`) VALUES ('UOB', 'DOCUMENT-SERVICES', 'ACCT_OPEN_NEW_USER', 'iText', 'A', 'UOB_ACCT_OPEN_NEW_USER');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `refValue`) VALUES ('UOB', 'DOCUMENT-SERVICES', 'GUIDE_CAUTIONARY_NOTES', 'iText', 'A', 'UOB_GUIDE_CAUTIONARY_NOTES');
INSERT INTO `service`.`service_operation_details` (`company`, `service`, `operation`, `vendor`, `status`, `refValue`) VALUES ('UOB', 'DOCUMENT-SERVICES', 'RISK_DISC_STATEMENT', 'iText', 'A', 'UOB_RISK_DISC_STATEMENT');


/*03_ap_sel_service_details.sql120118_abhnag*/

USE `service`;
DROP procedure IF EXISTS `sel_service_details`;

DELIMITER $$
USE `service`$$
CREATE PROCEDURE `sel_service_details`(
IN p_product  varchar(50),
IN p_service  varchar(50),
IN p_type  varchar(50),
IN p_info varchar(50)
)
BEGIN
if(p_service ='DOCUMENT-SERVICES' and p_type='ADDITIONAL_DETAILS' and p_info='PDF_FILE_DETAILS')then

select vendor, fileName, fileId, fileExtension, description, active, fileNameAppender, appenderType, appenderFormat, available, 
	sourceDir, uploadDir, isPwdProtected, pwdRules
	from service.pdf_file_details
    where vendor= p_product order by fileId;
elseif(p_service ='DOCUMENT-SERVICES' and p_type='COMMON_DETAILS' and p_info='PDF_FILE_RULES')then

select fileId, dataField, description, pageNo, xcord, ycord, length, dbColumn, isRequired, needToEncrypt,role
	from service.pdf_file_rules fcr
	where fcr.fileId in(select fileId from service.pdf_file_details where vendor= p_product) order by fileId, role;
	
elseif(p_service ='FILE-PROCESS' and p_type='ADDITIONAL_DETAILS' and p_info='FILE_DETAILS')then

select vendor, fileName, processId, process, fileType, fileExtension, fileId, containsHeader,
    active, seqNo, uploadDir, preDBProcess, postDBProcess, preInstruction, postInstruction, fileNameAppender,
    appenderFormat, available, sourcePath, downloadDir, loadFormat, required, canBeEmpty, encryptionMethod, decrFileExtension,
    tmpTableName, canBeDups, delimiter, delFlagServerFile, delDayServerFile, delFlagLocalFile,
	delDayLocalFile, delFlagDecrFile, fileProcessType, parentPreDBProcess, parentPostDBProcess, parentPreInstruction,
    parentPostInstruction
	from service.file_details
    where vendor= p_product order by processId, seqNo;
elseif(p_service ='FILE-PROCESS' and p_type='COMMON_DETAILS' and p_info='FILE_RULES')then

	select fcr.fileId, fcr.dataField, fcr.description, fcr.seqNo, fcr.startPos, fcr.endPos,
    fcr.length, fcr.format, fcr.decimals, fcr.isDelimited, fcr.delimiter, fcr.justified,fcr.dbColumn, fcr.isRequired, fcr.needToEncrypt
	from service.file_process_rules fcr
	where fcr.fileId in(select fileId from service.file_details where vendor= p_product) order by fileId, fcr.seqNo;
elseif(p_service ='DOCUSIGN-SERVICES' and p_type='COMMON_DETAILS' and p_info='DOCUSIGN_MAPPING')then

	select * from service.dc_template_mapping
    where (dbColumn IS NOT NULL or dbColumn != '')
    order by tempCode, role, tab;
 elseif(p_service ='DOCUSIGN-SERVICES' and p_type='ADDITIONAL_DETAILS' and p_info='TEMPLATE_DETAILS')then

	select * from service.dc_template_details
    where company= p_product
    order by company,mode, tempCode;

elseif(p_type='OPERATION_DETAILS' and p_info='OPERATION_DETAILS')then

	select * from service.service_operation_details
    where  status='A' and company=p_product and service=p_service
	order by operation;
end if;

END$$

DELIMITER ;

/*04_ap_country_master.sql120118_abhnag*/

CREATE TABLE IF NOT EXISTS service.`country_master` (
  `iso` char(2) NOT NULL,
  `name` varchar(80) NOT NULL,
  `nicename` varchar(80) NOT NULL,
  `iso3` char(3) DEFAULT NULL,
  `numcode` smallint(6) DEFAULT NULL,
  `phonecode` int(5) NOT NULL,
  `status` char(1) NOT NULL,
  PRIMARY KEY (`iso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

create view service.vw_country as select * from service.country_master;

INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AD', 'Andorra', 'Andorra', 'AND', '20', '376', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AE', 'United Arab Emirates', 'United Arab Emirates', 'ARE', '784', '971', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AF', 'Afghanistan', 'Afghanistan', 'AFG', '4', '93', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AG', 'Antigua and Barbuda', 'Antigua and Barbuda', 'ATG', '28', '1268', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AI', 'Anguilla', 'Anguilla', 'AIA', '660', '1264', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AL', 'Albania', 'Albania', 'ALB', '8', '355', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AM', 'Armenia', 'Armenia', 'ARM', '51', '374', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AN', 'Netherlands Antilles', 'Netherlands Antilles', 'ANT', '530', '599', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AO', 'Angola', 'Angola', 'AGO', '24', '244', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AP', 'Asia / Pacific Region', 'Asia / Pacific Region', '0', '0', '0', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('AQ', 'Antarctica', 'Antarctica', '0', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AR', 'Argentina', 'Argentina', 'ARG', '32', '54', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AS', 'American Samoa', 'American Samoa', 'ASM', '16', '1684', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AT', 'Austria', 'Austria', 'AUT', '40', '43', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AU', 'Australia', 'Australia', 'AUS', '36', '61', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AW', 'Aruba', 'Aruba', 'ABW', '533', '297', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AX', 'Aland Islands', 'Aland Islands', 'ALA', '248', '358', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('AZ', 'Azerbaijan', 'Azerbaijan', 'AZE', '31', '994', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BA', 'Bosnia and Herzegovina', 'Bosnia and Herzegovina', 'BIH', '70', '387', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BB', 'Barbados', 'Barbados', 'BRB', '52', '1246', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BD', 'Bangladesh', 'Bangladesh', 'BGD', '50', '880', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BE', 'Belgium', 'Belgium', 'BEL', '56', '32', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BF', 'Burkina Faso', 'Burkina Faso', 'BFA', '854', '226', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BG', 'Bulgaria', 'Bulgaria', 'BGR', '100', '359', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BH', 'Bahrain', 'Bahrain', 'BHR', '48', '973', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BI', 'Burundi', 'Burundi', 'BDI', '108', '257', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BJ', 'Benin', 'Benin', 'BEN', '204', '229', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BL', 'Saint Barthelemy', 'Saint Barthelemy', 'BLM', '652', '590', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BM', 'Bermuda', 'Bermuda', 'BMU', '60', '1441', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BN', 'Brunei Darussalam', 'Brunei Darussalam', 'BRN', '96', '673', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BO', 'Bolivia', 'Bolivia', 'BOL', '68', '591', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BQ', 'Bonaire, Sint Eustatius and Saba', 'Bonaire, Sint Eustatius and Saba', 'BES', '535', '599', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BR', 'Brazil', 'Brazil', 'BRA', '76', '55', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BS', 'Bahamas', 'Bahamas', 'BHS', '44', '1242', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BT', 'Bhutan', 'Bhutan', 'BTN', '64', '975', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('BV', 'Bouvet Island', 'Bouvet Island', '0', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BW', 'Botswana', 'Botswana', 'BWA', '72', '267', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BY', 'Belarus', 'Belarus', 'BLR', '112', '375', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('BZ', 'Belize', 'Belize', 'BLZ', '84', '501', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CA', 'Canada', 'Canada', 'CAN', '124', '1', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('CC', 'Cocos (Keeling) Islands', 'Cocos (Keeling) Islands', '672', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CD', 'Congo, the Democratic Republic of the', 'Congo, the Democratic Republic of the', 'COD', '180', '243', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CF', 'Central African Republic', 'Central African Republic', 'CAF', '140', '236', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CG', 'Congo', 'Congo', 'COG', '178', '242', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CH', 'Switzerland', 'Switzerland', 'CHE', '756', '41', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CI', 'Cote D\'Ivoire', 'Cote D\'Ivoire', 'CIV', '384', '225', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CK', 'Cook Islands', 'Cook Islands', 'COK', '184', '682', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CL', 'Chile', 'Chile', 'CHL', '152', '56', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CM', 'Cameroon', 'Cameroon', 'CMR', '120', '237', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CN', 'China', 'China', 'CHN', '156', '86', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CO', 'Colombia', 'Colombia', 'COL', '170', '57', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CR', 'Costa Rica', 'Costa Rica', 'CRI', '188', '506', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('CS', 'Serbia and Montenegro', 'Serbia and Montenegro', '381', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CU', 'Cuba', 'Cuba', 'CUB', '192', '53', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CV', 'Cape Verde', 'Cape Verde', 'CPV', '132', '238', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CW', 'Curacao', 'Curacao', 'CUW', '531', '599', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('CX', 'Christmas Island', 'Christmas Island', '61', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CY', 'Cyprus', 'Cyprus', 'CYP', '196', '357', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('CZ', 'Czech Republic', 'Czech Republic', 'CZE', '203', '420', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('DE', 'Germany', 'Germany', 'DEU', '276', '49', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('DJ', 'Djibouti', 'Djibouti', 'DJI', '262', '253', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('DK', 'Denmark', 'Denmark', 'DNK', '208', '45', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('DM', 'Dominica', 'Dominica', 'DMA', '212', '1767', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('DO', 'Dominican Republic', 'Dominican Republic', 'DOM', '214', '1809', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('DZ', 'Algeria', 'Algeria', 'DZA', '12', '213', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('EC', 'Ecuador', 'Ecuador', 'ECU', '218', '593', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('EE', 'Estonia', 'Estonia', 'EST', '233', '372', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('EG', 'Egypt', 'Egypt', 'EGY', '818', '20', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('EH', 'Western Sahara', 'Western Sahara', 'ESH', '732', '212', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('ER', 'Eritrea', 'Eritrea', 'ERI', '232', '291', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('ES', 'Spain', 'Spain', 'ESP', '724', '34', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('ET', 'Ethiopia', 'Ethiopia', 'ETH', '231', '251', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('FI', 'Finland', 'Finland', 'FIN', '246', '358', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('FJ', 'Fiji', 'Fiji', 'FJI', '242', '679', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('FK', 'Falkland Islands (Malvinas)', 'Falkland Islands (Malvinas)', 'FLK', '238', '500', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('FM', 'Micronesia, Federated States of', 'Micronesia, Federated States of', 'FSM', '583', '691', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('FO', 'Faroe Islands', 'Faroe Islands', 'FRO', '234', '298', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('FR', 'France', 'France', 'FRA', '250', '33', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GA', 'Gabon', 'Gabon', 'GAB', '266', '241', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GB', 'United Kingdom', 'United Kingdom', 'GBR', '826', '44', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GD', 'Grenada', 'Grenada', 'GRD', '308', '1473', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GE', 'Georgia', 'Georgia', 'GEO', '268', '995', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GF', 'French Guiana', 'French Guiana', 'GUF', '254', '594', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GG', 'Guernsey', 'Guernsey', 'GGY', '831', '44', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GH', 'Ghana', 'Ghana', 'GHA', '288', '233', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GI', 'Gibraltar', 'Gibraltar', 'GIB', '292', '350', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GL', 'Greenland', 'Greenland', 'GRL', '304', '299', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GM', 'Gambia', 'Gambia', 'GMB', '270', '220', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GN', 'Guinea', 'Guinea', 'GIN', '324', '224', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GP', 'Guadeloupe', 'Guadeloupe', 'GLP', '312', '590', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GQ', 'Equatorial Guinea', 'Equatorial Guinea', 'GNQ', '226', '240', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GR', 'Greece', 'Greece', 'GRC', '300', '30', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('GS', 'South Georgia and the South Sandwich Islands', 'South Georgia and the South Sandwich Islands', '0', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GT', 'Guatemala', 'Guatemala', 'GTM', '320', '502', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GU', 'Guam', 'Guam', 'GUM', '316', '1671', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GW', 'Guinea-Bissau', 'Guinea-Bissau', 'GNB', '624', '245', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('GY', 'Guyana', 'Guyana', 'GUY', '328', '592', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('HK', 'Hong Kong', 'Hong Kong', 'HKG', '344', '852', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('HM', 'Heard Island and Mcdonald Islands', 'Heard Island and Mcdonald Islands', '0', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('HN', 'Honduras', 'Honduras', 'HND', '340', '504', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('HR', 'Croatia', 'Croatia', 'HRV', '191', '385', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('HT', 'Haiti', 'Haiti', 'HTI', '332', '509', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('HU', 'Hungary', 'Hungary', 'HUN', '348', '36', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('ID', 'Indonesia', 'Indonesia', 'IDN', '360', '62', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('IE', 'Ireland', 'Ireland', 'IRL', '372', '353', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('IL', 'Israel', 'Israel', 'ISR', '376', '972', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('IM', 'Isle of Man', 'Isle of Man', 'IMN', '833', '44', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('IN', 'India', 'India', 'IND', '356', '91', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('IO', 'British Indian Ocean Territory', 'British Indian Ocean Territory', '246', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('IQ', 'Iraq', 'Iraq', 'IRQ', '368', '964', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('IR', 'Iran, Islamic Republic of', 'Iran, Islamic Republic of', 'IRN', '364', '98', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('IS', 'Iceland', 'Iceland', 'ISL', '352', '354', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('IT', 'Italy', 'Italy', 'ITA', '380', '39', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('JE', 'Jersey', 'Jersey', 'JEY', '832', '44', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('JM', 'Jamaica', 'Jamaica', 'JAM', '388', '1876', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('JO', 'Jordan', 'Jordan', 'JOR', '400', '962', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('JP', 'Japan', 'Japan', 'JPN', '392', '81', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('KE', 'Kenya', 'Kenya', 'KEN', '404', '254', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('KG', 'Kyrgyzstan', 'Kyrgyzstan', 'KGZ', '417', '996', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('KH', 'Cambodia', 'Cambodia', 'KHM', '116', '855', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('KI', 'Kiribati', 'Kiribati', 'KIR', '296', '686', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('KM', 'Comoros', 'Comoros', 'COM', '174', '269', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('KN', 'Saint Kitts and Nevis', 'Saint Kitts and Nevis', 'KNA', '659', '1869', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('KP', 'Korea, Democratic People\'s Republic of', 'Korea, Democratic People\'s Republic of', 'PRK', '408', '850', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('KR', 'Korea, Republic of', 'Korea, Republic of', 'KOR', '410', '82', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('KW', 'Kuwait', 'Kuwait', 'KWT', '414', '965', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('KY', 'Cayman Islands', 'Cayman Islands', 'CYM', '136', '1345', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('KZ', 'Kazakhstan', 'Kazakhstan', 'KAZ', '398', '7', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('LA', 'Lao People\'s Democratic Republic', 'Lao People\'s Democratic Republic', 'LAO', '418', '856', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('LB', 'Lebanon', 'Lebanon', 'LBN', '422', '961', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('LC', 'Saint Lucia', 'Saint Lucia', 'LCA', '662', '1758', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('LI', 'Liechtenstein', 'Liechtenstein', 'LIE', '438', '423', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('LK', 'Sri Lanka', 'Sri Lanka', 'LKA', '144', '94', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('LR', 'Liberia', 'Liberia', 'LBR', '430', '231', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('LS', 'Lesotho', 'Lesotho', 'LSO', '426', '266', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('LT', 'Lithuania', 'Lithuania', 'LTU', '440', '370', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('LU', 'Luxembourg', 'Luxembourg', 'LUX', '442', '352', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('LV', 'Latvia', 'Latvia', 'LVA', '428', '371', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('LY', 'Libyan Arab Jamahiriya', 'Libyan Arab Jamahiriya', 'LBY', '434', '218', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MA', 'Morocco', 'Morocco', 'MAR', '504', '212', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MC', 'Monaco', 'Monaco', 'MCO', '492', '377', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MD', 'Moldova, Republic of', 'Moldova, Republic of', 'MDA', '498', '373', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('ME', 'Montenegro', 'Montenegro', 'MNE', '499', '382', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MF', 'Saint Martin', 'Saint Martin', 'MAF', '663', '590', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MG', 'Madagascar', 'Madagascar', 'MDG', '450', '261', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MH', 'Marshall Islands', 'Marshall Islands', 'MHL', '584', '692', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MK', 'Macedonia, the Former Yugoslav Republic of', 'Macedonia, the Former Yugoslav Republic of', 'MKD', '807', '389', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('ML', 'Mali', 'Mali', 'MLI', '466', '223', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MM', 'Myanmar', 'Myanmar', 'MMR', '104', '95', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MN', 'Mongolia', 'Mongolia', 'MNG', '496', '976', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MO', 'Macao', 'Macao', 'MAC', '446', '853', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MP', 'Northern Mariana Islands', 'Northern Mariana Islands', 'MNP', '580', '1670', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MQ', 'Martinique', 'Martinique', 'MTQ', '474', '596', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MR', 'Mauritania', 'Mauritania', 'MRT', '478', '222', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MS', 'Montserrat', 'Montserrat', 'MSR', '500', '1664', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MT', 'Malta', 'Malta', 'MLT', '470', '356', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MU', 'Mauritius', 'Mauritius', 'MUS', '480', '230', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MV', 'Maldives', 'Maldives', 'MDV', '462', '960', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MW', 'Malawi', 'Malawi', 'MWI', '454', '265', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MX', 'Mexico', 'Mexico', 'MEX', '484', '52', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MY', 'Malaysia', 'Malaysia', 'MYS', '458', '60', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('MZ', 'Mozambique', 'Mozambique', 'MOZ', '508', '258', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('NA', 'Namibia', 'Namibia', 'NAM', '516', '264', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('NC', 'New Caledonia', 'New Caledonia', 'NCL', '540', '687', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('NE', 'Niger', 'Niger', 'NER', '562', '227', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('NF', 'Norfolk Island', 'Norfolk Island', 'NFK', '574', '672', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('NG', 'Nigeria', 'Nigeria', 'NGA', '566', '234', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('NI', 'Nicaragua', 'Nicaragua', 'NIC', '558', '505', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('NL', 'Netherlands', 'Netherlands', 'NLD', '528', '31', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('NO', 'Norway', 'Norway', 'NOR', '578', '47', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('NP', 'Nepal', 'Nepal', 'NPL', '524', '977', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('NR', 'Nauru', 'Nauru', 'NRU', '520', '674', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('NU', 'Niue', 'Niue', 'NIU', '570', '683', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('NZ', 'New Zealand', 'New Zealand', 'NZL', '554', '64', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('OM', 'Oman', 'Oman', 'OMN', '512', '968', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PA', 'Panama', 'Panama', 'PAN', '591', '507', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PE', 'Peru', 'Peru', 'PER', '604', '51', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PF', 'French Polynesia', 'French Polynesia', 'PYF', '258', '689', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PG', 'Papua New Guinea', 'Papua New Guinea', 'PNG', '598', '675', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PH', 'Philippines', 'Philippines', 'PHL', '608', '63', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PK', 'Pakistan', 'Pakistan', 'PAK', '586', '92', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PL', 'Poland', 'Poland', 'POL', '616', '48', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PM', 'Saint Pierre and Miquelon', 'Saint Pierre and Miquelon', 'SPM', '666', '508', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PN', 'Pitcairn', 'Pitcairn', 'PCN', '612', '0', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PR', 'Puerto Rico', 'Puerto Rico', 'PRI', '630', '1787', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('PS', 'Palestinian Territory, Occupied', 'Palestinian Territory, Occupied', '970', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PT', 'Portugal', 'Portugal', 'PRT', '620', '351', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PW', 'Palau', 'Palau', 'PLW', '585', '680', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('PY', 'Paraguay', 'Paraguay', 'PRY', '600', '595', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('QA', 'Qatar', 'Qatar', 'QAT', '634', '974', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('RE', 'Reunion', 'Reunion', 'REU', '638', '262', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('RO', 'Romania', 'Romania', 'ROM', '642', '40', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('RS', 'Serbia', 'Serbia', 'SRB', '688', '381', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('RU', 'Russian Federation', 'Russian Federation', 'RUS', '643', '7', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('RW', 'Rwanda', 'Rwanda', 'RWA', '646', '250', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SA', 'Saudi Arabia', 'Saudi Arabia', 'SAU', '682', '966', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SB', 'Solomon Islands', 'Solomon Islands', 'SLB', '90', '677', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SC', 'Seychelles', 'Seychelles', 'SYC', '690', '248', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SD', 'Sudan', 'Sudan', 'SDN', '736', '249', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SE', 'Sweden', 'Sweden', 'SWE', '752', '46', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SG', 'Singapore', 'Singapore', 'SGP', '702', '65', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SH', 'Saint Helena', 'Saint Helena', 'SHN', '654', '290', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SI', 'Slovenia', 'Slovenia', 'SVN', '705', '386', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SJ', 'Svalbard and Jan Mayen', 'Svalbard and Jan Mayen', 'SJM', '744', '47', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SK', 'Slovakia', 'Slovakia', 'SVK', '703', '421', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SL', 'Sierra Leone', 'Sierra Leone', 'SLE', '694', '232', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SM', 'San Marino', 'San Marino', 'SMR', '674', '378', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SN', 'Senegal', 'Senegal', 'SEN', '686', '221', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SO', 'Somalia', 'Somalia', 'SOM', '706', '252', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SR', 'Suriname', 'Suriname', 'SUR', '740', '597', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SS', 'South Sudan', 'South Sudan', 'SSD', '728', '211', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('ST', 'Sao Tome and Principe', 'Sao Tome and Principe', 'STP', '678', '239', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SV', 'El Salvador', 'El Salvador', 'SLV', '222', '503', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SX', 'Sint Maarten', 'Sint Maarten', 'SXM', '534', '1', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SY', 'Syrian Arab Republic', 'Syrian Arab Republic', 'SYR', '760', '963', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('SZ', 'Swaziland', 'Swaziland', 'SWZ', '748', '268', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TC', 'Turks and Caicos Islands', 'Turks and Caicos Islands', 'TCA', '796', '1649', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TD', 'Chad', 'Chad', 'TCD', '148', '235', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('TF', 'French Southern Territories', 'French Southern Territories', '0', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TG', 'Togo', 'Togo', 'TGO', '768', '228', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TH', 'Thailand', 'Thailand', 'THA', '764', '66', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TJ', 'Tajikistan', 'Tajikistan', 'TJK', '762', '992', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TK', 'Tokelau', 'Tokelau', 'TKL', '772', '690', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('TL', 'Timor-Leste', 'Timor-Leste', '670', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TM', 'Turkmenistan', 'Turkmenistan', 'TKM', '795', '7370', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TN', 'Tunisia', 'Tunisia', 'TUN', '788', '216', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TO', 'Tonga', 'Tonga', 'TON', '776', '676', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TR', 'Turkey', 'Turkey', 'TUR', '792', '90', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TT', 'Trinidad and Tobago', 'Trinidad and Tobago', 'TTO', '780', '1868', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TV', 'Tuvalu', 'Tuvalu', 'TUV', '798', '688', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TW', 'Taiwan, Province of China', 'Taiwan, Province of China', 'TWN', '158', '886', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('TZ', 'Tanzania, United Republic of', 'Tanzania, United Republic of', 'TZA', '834', '255', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('UA', 'Ukraine', 'Ukraine', 'UKR', '804', '380', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('UG', 'Uganda', 'Uganda', 'UGA', '800', '256', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('UM', 'United States Minor Outlying Islands', 'United States Minor Outlying Islands', '1', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('US', 'United States', 'United States', 'USA', '840', '1', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('UY', 'Uruguay', 'Uruguay', 'URY', '858', '598', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('UZ', 'Uzbekistan', 'Uzbekistan', 'UZB', '860', '998', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('VA', 'Holy See (Vatican City State)', 'Holy See (Vatican City State)', 'VAT', '336', '39', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('VC', 'Saint Vincent and the Grenadines', 'Saint Vincent and the Grenadines', 'VCT', '670', '1784', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('VE', 'Venezuela', 'Venezuela', 'VEN', '862', '58', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('VG', 'Virgin Islands, British', 'Virgin Islands, British', 'VGB', '92', '1284', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('VI', 'Virgin Islands, U.s.', 'Virgin Islands, U.s.', 'VIR', '850', '1340', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('VN', 'Viet Nam', 'Viet Nam', 'VNM', '704', '84', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('VU', 'Vanuatu', 'Vanuatu', 'VUT', '548', '678', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('WF', 'Wallis and Futuna', 'Wallis and Futuna', 'WLF', '876', '681', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('WS', 'Samoa', 'Samoa', 'WSM', '882', '684', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('XK', 'Kosovo', 'Kosovo', '---', '0', '381', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('YE', 'Yemen', 'Yemen', 'YEM', '887', '967', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `phonecode`, `status`) VALUES ('YT', 'Mayotte', 'Mayotte', '269', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('ZA', 'South Africa', 'South Africa', 'ZAF', '710', '27', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('ZM', 'Zambia', 'Zambia', 'ZMB', '894', '260', 'A');
INSERT INTO `service`.`country_master` (`iso`, `name`, `nicename`, `iso3`, `numcode`, `phonecode`, `status`) VALUES ('ZW', 'Zimbabwe', 'Zimbabwe', 'ZWE', '716', '263', 'A');


/*05_ap_ao_account_opening.sql120118_abhnag*/

CREATE DATABASE  IF NOT EXISTS `invdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `invdb`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: invdb
-- ------------------------------------------------------
-- Server version	5.5.57

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ao_acct_details`
--

DROP TABLE IF EXISTS `ao_acct_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_acct_details` (
  `acctnum` bigint(20) NOT NULL,
  `clientAccountID` varchar(45) DEFAULT NULL,
  `repId` varchar(45) DEFAULT NULL,
  `caseNumber` varchar(45) DEFAULT NULL,
  `advisorId` bigint(20) DEFAULT NULL,
  `acctTypeId` varchar(45) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `createdBy` varchar(45) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `updatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_acct_misc_details`
--

DROP TABLE IF EXISTS `ao_acct_misc_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_acct_misc_details` (
  `acctnum` bigint(20) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_citizenship_details`
--

DROP TABLE IF EXISTS `ao_citizenship_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_citizenship_details` (
  `acctnum` bigint(20) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  `recId` int(2) NOT NULL,
  PRIMARY KEY (`acctnum`,`name`,`recId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_column_lookup`
--

DROP TABLE IF EXISTS `ao_column_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_column_lookup` (
  `product` varchar(45) DEFAULT NULL,
  `lookupSet` varchar(45) NOT NULL,
  `lookupCode` varchar(45) NOT NULL,
  `displayName` varchar(500) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `tableName` varchar(45) DEFAULT NULL,
  `parentLookupId` varchar(45) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `sortOrder` int(11) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`lookupSet`,`lookupCode`),
  UNIQUE KEY `lookupCode_UNIQUE` (`lookupCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_bank_details`
--

DROP TABLE IF EXISTS `ao_owners_bank_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_bank_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `bankName` varchar(100) DEFAULT NULL,
  `bankAccountNo` varchar(45) DEFAULT NULL,
  `bankAccountHolderName` varchar(60) DEFAULT NULL,
  `bankAddressStreet1` varchar(100) DEFAULT NULL,
  `bankAddressStreet2` varchar(100) DEFAULT NULL,
  `bankAddressStreet3` varchar(100) DEFAULT NULL,
  `bankAddressStreet4` varchar(100) DEFAULT NULL,
  `bankAddressCity` varchar(45) DEFAULT NULL,
  `bankAddressState` varchar(45) DEFAULT NULL,
  `bankAddressZipCode` varchar(45) DEFAULT NULL,
  `bankAddressCountry` varchar(45) DEFAULT NULL,
  `swiftBic` varchar(45) DEFAULT NULL,
  `correspondentBank` varchar(100) DEFAULT NULL,
  `correspondentBankSwiftBic` varchar(45) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `createdBy` varchar(45) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `updatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_citizenship_details`
--

DROP TABLE IF EXISTS `ao_owners_citizenship_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_citizenship_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_contact_details`
--

DROP TABLE IF EXISTS `ao_owners_contact_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_contact_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_details`
--

DROP TABLE IF EXISTS `ao_owners_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `title` varchar(45) DEFAULT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `midInitial` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `fullName` varchar(100) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `dob` varchar(45) DEFAULT NULL,
  `countryOfBirth` varchar(45) DEFAULT NULL,
  `emailAddress` varchar(45) DEFAULT NULL,
  `physicalAddressStreet1` varchar(100) DEFAULT NULL,
  `physicalAddressStreet2` varchar(100) DEFAULT NULL,
  `physicalAddressStreet3` varchar(100) DEFAULT NULL,
  `physicalAddressStreet4` varchar(100) DEFAULT NULL,
  `physicalAddressCity` varchar(45) DEFAULT NULL,
  `physicalAddressState` varchar(45) DEFAULT NULL,
  `physicalAddressZipCode` varchar(45) DEFAULT NULL,
  `physicalAddressCountry` varchar(45) DEFAULT NULL,
  `mailingAddressStreet1` varchar(100) DEFAULT NULL,
  `mailingAddressStreet2` varchar(100) DEFAULT NULL,
  `mailingAddressStreet3` varchar(100) DEFAULT NULL,
  `mailingAddressStreet4` varchar(100) DEFAULT NULL,
  `mailingAddressCity` varchar(45) DEFAULT NULL,
  `mailingAddressState` varchar(45) DEFAULT NULL,
  `mailingAddressZipCode` varchar(45) DEFAULT NULL,
  `mailingAddressCountry` varchar(45) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `createdBy` varchar(45) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `updatedBy` varchar(45) DEFAULT NULL,
  `ownership` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_employment_details`
--

DROP TABLE IF EXISTS `ao_owners_employment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_employment_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `emplId` int(2) NOT NULL,
  `emplTypeId` varchar(45) NOT NULL,
  `sourceOfIncome` varchar(100) DEFAULT NULL,
  `employerName` varchar(45) DEFAULT NULL,
  `occupation` varchar(45) DEFAULT NULL,
  `typeOfBusiness` varchar(45) DEFAULT NULL,
  `employerStreetAddress1` varchar(100) DEFAULT NULL,
  `employerStreetAddress2` varchar(100) DEFAULT NULL,
  `employerStreetAddress3` varchar(100) DEFAULT NULL,
  `employerStreetAddress4` varchar(100) DEFAULT NULL,
  `employerCity` varchar(45) DEFAULT NULL,
  `employerState` varchar(45) DEFAULT NULL,
  `employerZipCode` varchar(45) DEFAULT NULL,
  `employerZipCountry` varchar(45) DEFAULT NULL,
  `fromDate` varchar(10) DEFAULT NULL,
  `toDate` varchar(10) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `createdBy` varchar(45) DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `updatedBy` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`acctOwnerId`,`emplId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_finacial_details`
--

DROP TABLE IF EXISTS `ao_owners_finacial_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_finacial_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_indentification_details`
--

DROP TABLE IF EXISTS `ao_owners_indentification_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_indentification_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_misc_details`
--

DROP TABLE IF EXISTS `ao_owners_misc_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_misc_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_regularity_details`
--

DROP TABLE IF EXISTS `ao_owners_regularity_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_regularity_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`name`,`acctOwnerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_owners_sets_misc_details`
--

DROP TABLE IF EXISTS `ao_owners_sets_misc_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_owners_sets_misc_details` (
  `acctnum` bigint(20) NOT NULL,
  `acctOwnerId` int(2) NOT NULL,
  `category` varchar(45) NOT NULL,
  `id` int(2) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '',
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`acctnum`,`acctOwnerId`,`category`,`id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_request_audit`
--

DROP TABLE IF EXISTS `ao_request_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_request_audit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product` varchar(50) DEFAULT NULL,
  `mode` varchar(20) DEFAULT NULL,
  `requestIds` varchar(100) DEFAULT NULL,
  `eventNum` int(11) DEFAULT NULL,
  `acctnum` bigint(20) DEFAULT NULL,
  `aoRequest` varchar(5000) DEFAULT NULL,
  `aoResponce` varchar(1000) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `remarks` varchar(1000) DEFAULT NULL,
  `reqTime` datetime DEFAULT NULL,
  `resTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_requests`
--

DROP TABLE IF EXISTS `ao_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_requests` (
  `reqId` bigint(20) NOT NULL AUTO_INCREMENT,
  `product` varchar(50) DEFAULT NULL,
  `acctnum` bigint(20) NOT NULL,
  `advisorid` int(11) NOT NULL,
  `eventNum` int(11) NOT NULL,
  `reqType` varchar(45) NOT NULL,
  `reqHeading` varchar(100) DEFAULT NULL,
  `reqAckwNum` varchar(45) DEFAULT NULL,
  `status` varchar(45) NOT NULL COMMENT 'I = Init, S = Sent, C = Completed, E= Error',
  `aoRequestFor` varchar(45) DEFAULT NULL,
  `action` varchar(45) DEFAULT NULL,
  `subaction` varchar(45) DEFAULT NULL,
  `terminalDetails` varchar(100) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `updated` date DEFAULT NULL,
  PRIMARY KEY (`reqId`),
  KEY `ak1_ao_request` (`acctnum`,`reqType`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ao_requests_final`
--

DROP TABLE IF EXISTS `ao_requests_final`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ao_requests_final` (
  `reqId` bigint(20) NOT NULL AUTO_INCREMENT,
  `refReqId` bigint(20) NOT NULL,
  `product` varchar(50) DEFAULT NULL,
  `acctnum` bigint(20) NOT NULL,
  `advisorid` int(11) NOT NULL,
  `eventNum` int(11) NOT NULL,
  `reqType` varchar(45) NOT NULL,
  `seqno` int(11) NOT NULL,
  `reqHeading` varchar(100) DEFAULT NULL,
  `reqAckwNum` varchar(45) DEFAULT NULL,
  `status` varchar(45) NOT NULL COMMENT 'I = Init, S = Sent, C = Completed, E= Error',
  `formType` varchar(45) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `updated` date DEFAULT NULL,
  PRIMARY KEY (`reqId`),
  KEY `ak1_ao_request` (`acctnum`,`reqType`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-12  5:45:46


/*11_ap_spao_uob_fetch_data.sql120118_abhnag*/

USE `invdb`;
DROP procedure IF EXISTS `spao_uob_fetch_data`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `spao_uob_fetch_data`(`p_acctnum` bigint(20))
BEGIN

declare v_acc_deta_count int;

/* select count(1) into v_acc_deta_count from invdb.ao_acct_details where acctnum=p_acctnum;
if(v_acc_deta_count=0)then
	select * from invdb.ao_acct_details where 1=2;
else*/
	select acctnum, clientAccountID, repId, caseNumber, advisorId, acctTypeId,
			IF((ISNULL(acctTypeId)
                OR (acctTypeId = '')),
            NULL,
            (SELECT 
                    dc_m_lookup.value
                FROM
                    dc_m_lookup
                WHERE
                    (dc_m_lookup.lookupCode = acctTypeId))) AS acctTypeVal,
                   (select date_format(created,'%d/%m/%Y') from ao_requests where reqId=(select max(reqid) from ao_requests where acctnum=p_acctnum)) as dateOfApplication
                    from invdb.ao_acct_details where acctnum=p_acctnum;
    select acctnum, name, case when(name ='existingTradeAcctNumber') then LPAD(value,7,'0') else value end as value from ao_acct_misc_details where acctnum=p_acctnum;
-- end if;

select acctnum, acctOwnerId, title, firstName, midInitial, lastName, fullName, gender, dob,
date_format(STR_TO_DATE(dob, '%m-%d-%Y'),'%d/%m/%Y') dobDDMMYYYY,
countryOfBirth, emailAddress, physicalAddressStreet1, physicalAddressStreet2, physicalAddressStreet3, physicalAddressStreet4, physicalAddressCity, physicalAddressState, physicalAddressZipCode, physicalAddressCountry, mailingAddressStreet1, mailingAddressStreet2, mailingAddressStreet3, mailingAddressStreet4, mailingAddressCity, mailingAddressState, mailingAddressZipCode, mailingAddressCountry, created, createdBy, updated, updatedBy, ownership 
from invdb.ao_owners_details where acctnum=p_acctnum;

select * from invdb.ao_owners_contact_details where acctnum=p_acctnum;
select * from ao_owners_finacial_details where acctnum=p_acctnum;
select * from ao_owners_regularity_details where acctnum=p_acctnum; 
select * from ao_owners_misc_details where acctnum=p_acctnum; 
select * from ao_owners_indentification_details where acctnum=p_acctnum;
select * from ao_owners_citizenship_details where acctnum=p_acctnum;
select * from ao_owners_employment_details where acctnum=p_acctnum;
select * from ao_owners_sets_misc_details where acctnum=p_acctnum order by acctnum, acctOwnerId, category, id, name;
select * from ao_owners_bank_details where acctnum=p_acctnum;  

END$$

DELIMITER ;

/*12_ap_spao_requests.sql120118_abhnag*/

USE `invdb`;
DROP procedure IF EXISTS `spao_requests`;

DELIMITER $$
USE `invdb`$$
CREATE  PROCEDURE `spao_requests`(`p_acctnum` bigint(20),`p_eventnum` int(2))
BEGIN

declare v_acc_deta_count int;

/* select count(1) into v_acc_deta_count from invdb.ao_acct_details where acctnum=p_acctnum;
if(v_acc_deta_count=0)then
	select * from invdb.ao_acct_details where 1=2;
else*/
	select * from invdb.ao_requests_final where acctnum=p_acctnum and eventNum=p_eventnum 
    and refReqId=(select max(refReqId) from invdb.ao_requests_final where acctnum=p_acctnum and eventNum=p_eventnum ) 
    order by eventNum, seqno;

END$$

DELIMITER ;

/* 13_ap_ao_request_auditrial.sql120118_abhnag*/

USE `invdb`;
DROP procedure IF EXISTS `ao_request_auditrial`;

DELIMITER $$
USE `invdb`$$
CREATE PROCEDURE `ao_request_auditrial`(
in p_id numeric(10),
in p_product varchar(50),
in p_mode varchar(20),
in p_requestIds varchar(100),
in p_acctNum varchar(12),
in p_eventNum varchar(12),
in p_reqAckwNum varchar(100),
in p_status varchar(1),
in p_aoRequest varchar(5000),
in p_aoResponce  varchar(1000),
in p_reqTime  datetime,
in p_resTime   datetime,
in p_remarks varchar(1000),
in p_opt varchar(20),
out op_msgCode int(3),out op_msg varchar(20))
BEGIN

if(p_opt='INSERT') then
	Insert into ao_request_audit(product, mode, requestIds,acctnum,eventNum, aoRequest, aoResponce, status, remarks, reqTime, resTime)
    value(p_product, p_mode, p_requestIds,p_acctNum, p_eventNum, p_aoRequest, p_aoResponce, p_status, p_remarks, p_reqTime, p_resTime);

    if(p_status='S') then
		update ao_requests_final set status='S' , reqAckwNum =p_reqAckwNum where acctnum=p_acctNum and eventNum=p_eventNum and status='I';
        update ao_requests set status='S' , reqAckwNum =p_reqAckwNum where reqId in(select distinct(refReqId) from ao_requests_final where acctnum=p_acctNum and eventNum=p_eventNum);
    elseif(p_status='E') then
		update ao_requests_final set status='E' where acctnum=p_acctNum and eventNum=p_eventNum and status='I';
        update ao_requests set status='E' where reqId in(select distinct(refReqId) from ao_requests_final where acctnum=p_acctNum and eventNum=p_eventNum);
    else
		update ao_requests_final set status='X' where acctnum=p_acctNum and eventNum=p_eventNum and status='I';
        update ao_requests set status='X' where reqId in(select distinct(refReqId) from ao_requests_final where acctnum=p_acctNum and eventNum=p_eventNum);

    end if;

	SELECT p_opt, 1 INTO op_msg , op_msgCode;

end if;
END$$

DELIMITER ;

/* 14_ap_vw_user_logon.sql130118_abhnag*/

ALTER TABLE `invdb`.`user_logon` 
ADD COLUMN `fullname` VARCHAR(45) NULL AFTER `firstname`;
USE `invdb`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
   
    SQL SECURITY DEFINER
VIEW `invdb`.`vw_user_logon` AS
    SELECT 
        `ui`.`logonid` AS `logonid`,
        `ui`.`userid` AS `userid`,
        `ui`.`email` AS `email`,
        `ui`.`pwd` AS `pwd`,
        `ui`.`logonstatus` AS `logonstatus`,
        `ui`.`firstname` AS `firstname`,
        `ui`.`lastname` AS `lastname`,
        IFNULL(`ui`.`fullname`, `ui`.`firstname`) AS `fullname`,
        `ui`.`ip` AS `ip`,
        `ui`.`stateRegistered` AS `stateRegistered`,
        `ui`.`leadSource` AS `leadSource`,
        `ui`.`resetID` AS `resetID`,
        `ui`.`cid` AS `cid`,
        `ui`.`advisor` AS `advisor`,
        `ui`.`rep` AS `rep`,
        `ui`.`emailmsgtype` AS `emailmsgtype`,
        IFNULL(`ui`.`access`, 'User') AS `access`,
        `ui`.`atstart` AS `atstart`,
        IFNULL(`basket`.`theme`, '0.Core') AS `theme`
    FROM
        (`invdb`.`user_logon` `ui`
        LEFT JOIN `invdb`.`user_basket_access` `basket` ON (((`basket`.`advisor` = `ui`.`advisor`)
            AND (`basket`.`sortorder` = 0)
            AND (`basket`.`primary` = 'Y'))));

/*21_ap_insert_adv_table.sql120118_abhnag*/

INSERT INTO `invdb`.`adv_request_document_mappings` (`templateId`, `action`, `subaction`, `reqType`, `envelopeHeading`, `seqno`, `formType`) VALUES ('UOBInternal', 'ACCT_OPEN', 'ACCT_OPEN_EXISTING_USER', 'ACCT_OPEN_EXISTING_USER', 'Please sign Account Application document.', '2', 'ITEXT');
INSERT INTO `invdb`.`adv_request_document_mappings` (`templateId`, `action`, `subaction`, `reqType`, `envelopeHeading`, `seqno`, `formType`) VALUES ('UOBInternal', 'ACCT_OPEN', 'ACCT_OPEN_NEW_USER', 'ACCT_OPEN_NEW_USER', 'Please sign Account Application document.', '3', 'ITEXT');
INSERT INTO `invdb`.`adv_request_document_mappings` (`templateId`, `action`, `subaction`, `reqType`, `envelopeHeading`, `seqno`, `formType`) VALUES ('UOBInternal', 'ACCT_OPEN', 'DEFAULT', 'GUIDE_CAUTIONARY_NOTES', 'Please sign Account Application document.', '1', 'ADV');
INSERT INTO `invdb`.`adv_request_document_mappings` (`templateId`, `action`, `subaction`, `reqType`, `envelopeHeading`, `seqno`, `formType`) VALUES ('UOBInternal', 'ACCT_OPEN', 'DEFAULT', 'RISK_DISC_STATEMENT', 'Please sign Account Application document.', '1', 'ADV');


