[
    {server, [
        {cacertfile,"syscmd(printf '%s' $PWD)/ca.crt"},
        {certfile, "syscmd(printf '%s' $PWD)/server.crt"},
        {keyfile, "syscmd(printf '%s' $PWD)/server.key"},
        {verify, verify_peer},
        {fail_if_no_peer_cert, true},
        {versions, ['tlsv1.3']}
    ]},
    {client, [
        {cacertfile,"syscmd(printf '%s' $PWD)/ca.crt"},
        {certfile, "syscmd(printf '%s' $PWD)/client.crt"},
        {keyfile, "syscmd(printf '%s' $PWD)/client.key"},
        {verify, verify_peer},
        {versions, ['tlsv1.3']},
        {customize_hostname_check, [
            {match_fun, public_key:pkix_verify_hostname_match_fun(https)}
        ]}
    ]}
].
