<?xml version="1.0" encoding="utf-8" ?>
<clientConfig version="1.1">
  <emailProvider id="{{ config.findtext('domain') }}">
    <domain>{{ config.findtext('domain') }}</domain>
    <displayName>{{ config.findtext('displayname') }}</displayName>
    <displayShortName>{{ config.findtext('displayshortname') }}</displayShortName>
    % if config.findtext('useImap') == 'true':
    <incomingServer type="imap">
      <hostname>{{ config.find('imap').findtext('server') }}</hostname>
      <port>{{ config.find('imap').findtext('port') }}</port>
      <socketType>\\
      % if config.find('imap').findtext('encryption') == 'none':
      plain\\
      %end
      % if config.find('imap').findtext('encryption') == 'ssl':
      SSL\\
      %end
      % if config.find('imap').findtext('encryption') == 'starttls':
      STARTTLS\\
      % end
      </socketType>
      <authentication>{{ 'password-encrypted' if config.find('imap').findtext('password') == 'encrypted' else 'password-cleartext' }}</authentication>
      <username>{{ '%EMAILADDRESS%' if config.find('imap').findtext('loginname') == 'email' else '%EMAILLOCALPART%' }}</username>
    </incomingServer>
    % end
    % if config.findtext('usePop') == 'true':
    <incomingServer type="pop3">
      <hostname>{{ config.find('pop').findtext('server') }}</hostname>
      <port>{{ config.find('pop').findtext('port') }}</port>
      <socketType>\\
      % if config.find('pop').findtext('encryption') == 'none':
      plain\\
      %end
      % if config.find('pop').findtext('encryption') == 'ssl':
      SSL\\
      %end
      % if config.find('pop').findtext('encryption') == 'starttls':
      STARTTLS\\
      % end
      </socketType>
      <authentication>{{ 'password-encrypted' if config.find('pop').findtext('password') == 'encrypted' else 'password-cleartext' }}</authentication>
      <username>{{ '%EMAILADDRESS%' if config.find('pop').findtext('loginname') == 'email' else '%EMAILLOCALPART%' }}</username>
    </incomingServer>
    % end
    <outgoingServer type="smtp">
      <hostname>{{ config.find('smtp').findtext('server') }}</hostname>
      <port>{{ config.find('smtp').findtext('port') }}</port>
      <socketType>\\
      % if config.find('smtp').findtext('encryption') == 'none':
      plain\\
      %end
      % if config.find('smtp').findtext('encryption') == 'ssl':
      SSL\\
      %end
      % if config.find('smtp').findtext('encryption') == 'starttls':
      STARTTLS\\
      % end
      </socketType>
      <authentication>{{ 'password-encrypted' if config.find('pop').findtext('password') == 'encrypted' else 'password-cleartext' }}</authentication>
      <username>{{ '%EMAILADDRESS%' if config.find('smtp').findtext('loginname') == 'email' else '%EMAILLOCALPART%' }}</username>
    </outgoingServer>
  </emailProvider>
</clientConfig>
