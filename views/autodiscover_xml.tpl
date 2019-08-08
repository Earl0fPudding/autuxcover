<?xml version="1.0" encoding="utf-8" ?>
<Autodiscover xmlns="http://schemas.microsoft.com/exchange/autodiscover/responseschema/2006">
  <Response xmlns="http://schemas.microsoft.com/exchange/autodiscover/outlook/responseschema/2006a">
    <User>
      <DisplayName>{{ config.findtext('displayname') }}</DisplayName>
    </User>
    <Account>
      <AccountType>email</AccountType>
      <Action>settings</Action>
      % if config.findtext('usePop') == 'true': 
      <Protocol>
        <Type>POP3</Type>
        <Server>{{ config.find('pop').findtext('server') }}</Server>
        <Port>{{ config.find('pop').findtext('port') }}</Port>
        <LoginName>{{ email if config.find('pop').findtext('loginname') == 'email' else username }}</LoginName>
        <DomainRequired>{{ 'on' if config.find('pop').findtext('loginname') == 'email' else 'off' }}</DomainRequired>
        <SPA>{{ 'on' if config.find('pop').findtext('password') == 'encrypted' else 'off' }}</SPA>
        <SSL>{{ 'on' if config.find('pop').findtext('encryption') != 'none' else 'off' }}</SSL>
        <AuthRequired>on</AuthRequired>
      </Protocol>
      %end
      % if config.findtext('useImap') == 'true':
      <Protocol>
        <Type>IMAP</Type>
        <Server>{{ config.find('imap').findtext('server') }}</Server>
        <Port>{{ config.find('imap').findtext('port') }}</Port>
        <DomainRequired>{{ 'on' if config.find('imap').findtext('loginname') == 'email' else 'off' }}</DomainRequired>
        <LoginName>{{ email if config.find('imap').findtext('loginname') == 'email' else username }}</LoginName>
        <SPA>{{ 'on' if config.find('imap').findtext('password') == 'encrypted' else 'off' }}</SPA>
        <SSL>{{ 'on' if config.find('imap').findtext('encryption') != 'none' else 'off' }}</SSL>
        <AuthRequired>on</AuthRequired>
      </Protocol>
      % end
      <Protocol>
        <Type>SMTP</Type>
        <Server>{{ config.find('smtp').findtext('server') }}</Server>
        <Port>{{ config.find('smtp').findtext('port') }}</Port>
        <DomainRequired>{{ 'on' if config.find('smtp').findtext('loginname') == 'email' else 'off' }}</DomainRequired>
        <LoginName>{{ email if config.find('smtp').findtext('loginname') == 'email' else username }}</LoginName>
        <SPA>{{ 'on' if config.find('smtp').findtext('password') == 'encrypted' else 'off' }}</SPA>
        <SSL>{{ 'on' if config.find('smtp').findtext('encryption') != 'none' else 'off' }}</SSL>
        <AuthRequired>on</AuthRequired>
        <UsePOPAuth>off</UsePOPAuth>
        <SMTPLast>off</SMTPLast>
      </Protocol>
    </Account>
  </Response>
</Autodiscover>
