# Powershell
Powershell Scripts

Get Event Logs with ID's - 4625,4688,4648,1102,4697,4698,4719,4760,4663,4739,4776,4789



<b>Pentetration Tester</b>

Event ID 4625 - Failed Logon

Event ID 4688 - A new process was created. When a pentester successfully gain access.

Event ID 4648 - A logon was attempted using explicit credentials. 

Event ID 1102 - The audit log was cleared.



<b>Signs of Malware</b>

Event ID 4697 - A service was installed in the system. Malware might install itself as a service to maintain persistence

Event ID 4698 - A scheduled task was created. 

Event ID 4719 - System audit policy was changed. 

Event ID 4760 - A SID-History was added to an account. Some advanced malware can use this to move laterally  


<b>Signs of Actual User</b>

Event ID 4663 - Attempt was made to access an object. Normal File or directory access

Event ID 4738 - A user account was changed. Password change or other account details.

Event ID 4776 - Domain controller attempted to validate the credentials for an account.

Event ID 4789 - The password hash of the account was accessed. This can occur when users or applications attempt to change password




Event ID	What it means
4624	Successful account log on
4625	Failed account log on
4634	An account logged off
4648	A logon attempt was made with explicit credentials
4719	System audit policy was changed.
4964	A special group has been assigned to a new log on
1102	Audit log was cleared. This can relate to a potential attack
4720	A user account was created
4722	A user account was enabled
4723	An attempt was made to change the password of an account
4725	A user account was disabled
4728	A user was added to a privileged global group
4732	A user was added to a privileged local group
4756	A user was added to a privileged universal group
4738	A user account was changed
4740	A user account was locked out
4767	A user account was unlocked
4735	A privileged local group was modified
4737	A privileged global group was modified
4755	A privileged universal group was modified
4772	A Kerberos authentication ticket request failed
4777	The domain controller failed to validate the credentials of an account.
4782	Password hash an account was accessed
4616	System time was changed
4657	A registry value was changed
4697	An attempt was made to install a service
4698, 4699, 4700, 4701, 4702	Events related to Windows scheduled tasks being created, modified, deleted, enabled or disabled
4946	A rule was added to the Windows Firewall exception list
4947	A rule was modified in the Windows Firewall exception list
4950	A setting was changed in Windows Firewall
4954	Group Policy settings for Windows Firewall has changed
5025	The Windows Firewall service has been stopped
5031	Windows Firewall blocked an application from accepting incoming traffic
5152, 5153	A network packet was blocked by Windows Filtering Platform
5155	Windows Filtering Platform blocked an application or service from listening on a port
5157	Windows Filtering Platform blocked a connection
5447	A Windows Filtering Platform filter was changed
