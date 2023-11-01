# Powershell
Powershell Scripts

Get Event Logs with ID's - 4625,4688,4648,1102,4697,4698,4719,4760,4663,4739,4776,4789


Pentetration Tester

Event ID 4625 - Failed Logon

Event ID 4688 - A new process was created. When a pentester successfully gain access.

Event ID 4648 - A logon was attempted using explicit credentials. 

Event ID 1102 - The audit log was cleared.


Signs of Malware

Event ID 4697 - A service was installed in the system. Malware might install itself as a service to maintain persistence

Event ID 4698 - A scheduled task was created. 

Event ID 4719 - System audit policy was changed. 

Event ID 4760 - A SID-History was added to an account. Some advanced malware can use this to move laterally  


Signs of Actual User

Event ID 4663 - Attempt was made to access an object. Normal File or directory access

Event ID 4738 - A user account was changed. Password change or other account details.

Event ID 4776 - Domain controller attempted to validate the credentials for an account.

Event ID 4789 - The password hash of the account was accessed. This can occur when users or applications attempt to change password
