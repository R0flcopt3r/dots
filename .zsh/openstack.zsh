autoload -U bashcompinit
bashcompinit

if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
if [[ -z ${ZSH_VERSION:+set} ]]; then
_get_comp_words_by_ref ()
{
	local exclude cur_ words_ cword_
	if [ "$1" = "-n" ]; then
		exclude=$2
		shift 2
	fi
	__git_reassemble_comp_words_by_ref "$exclude"
	cur_=${words_[cword_]}
	while [ $# -gt 0 ]; do
		case "$1" in
		cur)
			cur=$cur_
			;;
		prev)
			prev=${words_[$cword_-1]}
			;;
		words)
			words=("${words_[@]}")
			;;
		cword)
			cword=$cword_
			;;
		esac
		shift
	done
}
else
_get_comp_words_by_ref ()
{
	while [ $# -gt 0 ]; do
		case "$1" in
		cur)
			cur=${COMP_WORDS[COMP_CWORD]}
			;;
		prev)
			prev=${COMP_WORDS[COMP_CWORD-1]}
			;;
		words)
			words=("${COMP_WORDS[@]}")
			;;
		cword)
			cword=$COMP_CWORD
			;;
		-n)
			# assume COMP_WORDBREAKS is already set sanely
			shift
			;;
		esac
		shift
	done
}
fi
fi


_openstack()
{
  local cur prev words
  COMPREPLY=()
  _get_comp_words_by_ref -n : cur prev words

  # Command data:
  cmds='address aggregate availability backup catalog command complete compute configuration consistency console container ec2 endpoint extension flavor floating help host hypervisor image ip keypair limits module network object port project quota role router security server service snapshot subnet token usage user volume'
  cmds_address='scope'
  cmds_address_scope='create delete list set show'
  cmds_address_scope_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --ip-version --project --project-domain --share --no-share'
  cmds_address_scope_delete='-h --help'
  cmds_address_scope_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --name --ip-version --project --project-domain --share --no-share'
  cmds_address_scope_set='-h --help --name --share --no-share'
  cmds_address_scope_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_aggregate='add create delete list remove set show unset'
  cmds_aggregate_add='host'
  cmds_aggregate_add_host='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_aggregate_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --zone --property'
  cmds_aggregate_delete='-h --help'
  cmds_aggregate_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --long'
  cmds_aggregate_remove='host'
  cmds_aggregate_remove_host='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_aggregate_set='-h --help --name --zone --property --no-property'
  cmds_aggregate_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_aggregate_unset='-h --help --property'
  cmds_availability='zone'
  cmds_availability_zone='list'
  cmds_availability_zone_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --compute --network --volume --long'
  cmds_backup='create delete list restore show'
  cmds_backup_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --name --description --container --snapshot --force --incremental'
  cmds_backup_delete='-h --help --force'
  cmds_backup_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --long --name --status --volume --marker --limit --all-projects'
  cmds_backup_restore='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_backup_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_catalog='list show'
  cmds_catalog_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_catalog_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_command='list'
  cmds_command_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_complete='-h --help --name --shell'
  cmds_compute='agent service'
  cmds_compute_agent='create delete list set'
  cmds_compute_agent_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_compute_agent_delete='-h --help'
  cmds_compute_agent_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --hypervisor'
  cmds_compute_agent_set='-h --help --agent-version --url --md5hash'
  cmds_compute_service='delete list set'
  cmds_compute_service_delete='-h --help'
  cmds_compute_service_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --host --service --long'
  cmds_compute_service_set='-h --help --enable --disable --disable-reason --up --down'
  cmds_configuration='show'
  cmds_configuration_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --mask --unmask'
  cmds_consistency='group'
  cmds_consistency_group='add create delete list remove set show snapshot'
  cmds_consistency_group_add='volume'
  cmds_consistency_group_add_volume='-h --help'
  cmds_consistency_group_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --volume-type --consistency-group-source --consistency-group-snapshot --description --availability-zone'
  cmds_consistency_group_delete='-h --help --force'
  cmds_consistency_group_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --all-projects --long'
  cmds_consistency_group_remove='volume'
  cmds_consistency_group_remove_volume='-h --help'
  cmds_consistency_group_set='-h --help --name --description'
  cmds_consistency_group_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_consistency_group_snapshot='create delete list show'
  cmds_consistency_group_snapshot_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --consistency-group --description'
  cmds_consistency_group_snapshot_delete='-h --help'
  cmds_consistency_group_snapshot_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --all-projects --long --status --consistency-group'
  cmds_consistency_group_snapshot_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_console='log url'
  cmds_console_log='show'
  cmds_console_log_show='-h --help --lines'
  cmds_console_url='show'
  cmds_console_url_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --novnc --xvpvnc --spice --rdp --serial --mks'
  cmds_container='create delete list save set show unset'
  cmds_container_create='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_container_delete='-h --help --recursive -r'
  cmds_container_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --prefix --marker --end-marker --limit --long --all'
  cmds_container_save='-h --help'
  cmds_container_set='-h --help --property'
  cmds_container_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_container_unset='-h --help --property'
  cmds_ec2='credentials'
  cmds_ec2_credentials='create delete list show'
  cmds_ec2_credentials_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --project --user'
  cmds_ec2_credentials_delete='-h --help --user'
  cmds_ec2_credentials_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --user'
  cmds_ec2_credentials_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --user'
  cmds_endpoint='create delete list show'
  cmds_endpoint_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --publicurl --adminurl --internalurl --region'
  cmds_endpoint_delete='-h --help'
  cmds_endpoint_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --long'
  cmds_endpoint_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_extension='list'
  cmds_extension_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --compute --identity --network --volume --long'
  cmds_flavor='create delete list set show unset'
  cmds_flavor_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --id --ram --disk --ephemeral --swap --vcpus --rxtx-factor --public --private --property --project --project-domain'
  cmds_flavor_delete='-h --help'
  cmds_flavor_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --public --private --all --long --marker --limit'
  cmds_flavor_set='-h --help --property --project --project-domain'
  cmds_flavor_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_flavor_unset='-h --help --property --project --project-domain'
  cmds_floating='ip'
  cmds_floating_ip='create delete list pool show'
  cmds_floating_ip_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --subnet --port --floating-ip-address --fixed-ip-address --description --project --project-domain'
  cmds_floating_ip_delete='-h --help'
  cmds_floating_ip_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --network --port --fixed-ip-address --long --status --project --project-domain --router'
  cmds_floating_ip_pool='list'
  cmds_floating_ip_pool_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_floating_ip_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_help='-h --help'
  cmds_host='list set show'
  cmds_host_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --zone'
  cmds_host_set='-h --help --enable --disable --enable-maintenance --disable-maintenance'
  cmds_host_show='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_hypervisor='list show stats'
  cmds_hypervisor_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --matching --long'
  cmds_hypervisor_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_hypervisor_stats='show'
  cmds_hypervisor_stats_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_image='add create delete list remove save set show unset'
  cmds_image_add='project'
  cmds_image_add_project='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --project-domain'
  cmds_image_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --id --container-format --disk-format --min-disk --min-ram --file --volume --force --protected --unprotected --public --private --property --tag --project --owner --project-domain --size --location --copy-from --checksum --store'
  cmds_image_delete='-h --help'
  cmds_image_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --public --private --shared --property --long --page-size --sort --limit --marker'
  cmds_image_remove='project'
  cmds_image_remove_project='-h --help --project-domain'
  cmds_image_save='-h --help --file'
  cmds_image_set='-h --help --name --min-disk --min-ram --container-format --disk-format --protected --unprotected --public --private --property --tag --architecture --instance-id --instance-uuid --kernel-id --os-distro --os-version --ramdisk-id --deactivate --activate --project --owner --project-domain --visibility --accept --reject --pending'
  cmds_image_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_image_unset='-h --help --tag --property'
  cmds_ip='availability fixed floating'
  cmds_ip_availability='list show'
  cmds_ip_availability_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --ip-version --project --project-domain'
  cmds_ip_availability_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_ip_fixed='add remove'
  cmds_ip_fixed_add='-h --help'
  cmds_ip_fixed_remove='-h --help'
  cmds_ip_floating='add create delete list pool remove show'
  cmds_ip_floating_add='-h --help'
  cmds_ip_floating_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --subnet --port --floating-ip-address --fixed-ip-address --description --project --project-domain'
  cmds_ip_floating_delete='-h --help'
  cmds_ip_floating_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --network --port --fixed-ip-address --long --status --project --project-domain --router'
  cmds_ip_floating_pool='list'
  cmds_ip_floating_pool_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_ip_floating_remove='-h --help'
  cmds_ip_floating_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_keypair='create delete list show'
  cmds_keypair_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --public-key'
  cmds_keypair_delete='-h --help'
  cmds_keypair_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_keypair_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --public-key'
  cmds_limits='show'
  cmds_limits_show='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --absolute --rate --reserved --project --domain'
  cmds_module='list'
  cmds_module_list='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --all'
  cmds_network='agent create delete list meter qos rbac segment service set show'
  cmds_network_agent='delete list set show'
  cmds_network_agent_delete='-h --help'
  cmds_network_agent_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --agent-type --host'
  cmds_network_agent_set='-h --help --description --enable --disable'
  cmds_network_agent_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_network_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --share --no-share --enable --disable --project --description --project-domain --availability-zone-hint --enable-port-security --disable-port-security --external --internal --default --no-default --qos-policy --provider-network-type --provider-physical-network --provider-segment --transparent-vlan --no-transparent-vlan'
  cmds_network_delete='-h --help'
  cmds_network_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --external --internal --long --name --enable --disable --project --project-domain --share --no-share --status --provider-network-type --provider-physical-network --provider-segment'
  cmds_network_meter='create delete list rule show'
  cmds_network_meter_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --description --project --project-domain --share --no-share'
  cmds_network_meter_delete='-h --help'
  cmds_network_meter_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_network_meter_rule='create delete list show'
  cmds_network_meter_rule_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --project --project-domain --exclude --include --ingress --egress --remote-ip-prefix'
  cmds_network_meter_rule_delete='-h --help'
  cmds_network_meter_rule_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_network_meter_rule_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_network_meter_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_network_qos='policy rule'
  cmds_network_qos_policy='create delete list set show'
  cmds_network_qos_policy_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --description --share --no-share --project --project-domain'
  cmds_network_qos_policy_delete='-h --help'
  cmds_network_qos_policy_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_network_qos_policy_set='-h --help --name --description --share --no-share'
  cmds_network_qos_policy_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_network_qos_rule='create delete list set show type'
  cmds_network_qos_rule_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --type --max-kbps --max-burst-kbits --dscp-mark --min-kbps --ingress --egress'
  cmds_network_qos_rule_delete='-h --help'
  cmds_network_qos_rule_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_network_qos_rule_set='-h --help --max-kbps --max-burst-kbits --dscp-mark --min-kbps --ingress --egress'
  cmds_network_qos_rule_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_network_qos_rule_type='list'
  cmds_network_qos_rule_type_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_network_rbac='create delete list set show'
  cmds_network_rbac_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --type --action --target-project --target-project-domain --project --project-domain'
  cmds_network_rbac_delete='-h --help'
  cmds_network_rbac_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --type --action --long'
  cmds_network_rbac_set='-h --help --target-project --target-project-domain'
  cmds_network_rbac_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_network_segment='create delete list set show'
  cmds_network_segment_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --description --physical-network --segment --network --network-type'
  cmds_network_segment_delete='-h --help'
  cmds_network_segment_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --long --network'
  cmds_network_segment_set='-h --help --description --name'
  cmds_network_segment_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_network_service='provider'
  cmds_network_service_provider='list'
  cmds_network_service_provider_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_network_set='-h --help --name --enable --disable --share --no-share --description --enable-port-security --disable-port-security --external --internal --default --no-default --qos-policy --no-qos-policy --provider-network-type --provider-physical-network --provider-segment --transparent-vlan --no-transparent-vlan'
  cmds_network_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_object='create delete list save set show store unset'
  cmds_object_create='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --name'
  cmds_object_delete='-h --help'
  cmds_object_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --prefix --delimiter --marker --end-marker --limit --long --all'
  cmds_object_save='-h --help --file'
  cmds_object_set='-h --help --property'
  cmds_object_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_object_store='account'
  cmds_object_store_account='set show unset'
  cmds_object_store_account_set='-h --help --property'
  cmds_object_store_account_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_object_store_account_unset='-h --help --property'
  cmds_object_unset='-h --help --property'
  cmds_port='create delete list set show unset'
  cmds_port_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --network --description --device --device-id --device-owner --vnic-type --host --host-id --dns-name --fixed-ip --binding-profile --enable --disable --mac-address --project --project-domain --security-group --no-security-group --enable-port-security --disable-port-security --allowed-address'
  cmds_port_delete='-h --help'
  cmds_port_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --device-owner --network --router --server --mac-address --long --project --project-domain'
  cmds_port_set='-h --help --description --device --device-id --device-owner --vnic-type --host --host-id --dns-name --enable --disable --name --fixed-ip --no-fixed-ip --binding-profile --no-binding-profile --security-group --no-security-group --enable-port-security --disable-port-security --allowed-address --no-allowed-address'
  cmds_port_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_port_unset='-h --help --fixed-ip --binding-profile --security-group --allowed-address'
  cmds_project='create delete list set show unset'
  cmds_project_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --description --enable --disable --property --or-show'
  cmds_project_delete='-h --help'
  cmds_project_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --long'
  cmds_project_set='-h --help --name --description --enable --disable --property'
  cmds_project_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_project_unset='-h --help --property'
  cmds_quota='set show'
  cmds_quota_set='-h --help --class --properties --server-groups --ram --key-pairs --instances --fixed-ips --injected-file-size --server-group-members --injected-files --cores --injected-path-size --per-volume-gigabytes --gigabytes --backup-gigabytes --snapshots --volumes --backups --l7policies --subnetpools --vips --ports --subnets --networks --floating-ips --secgroup-rules --health-monitors --secgroups --routers --rbac-policies --volume-type'
  cmds_quota_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --class --default'
  cmds_role='add assignment create delete list remove show'
  cmds_role_add='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --project --user'
  cmds_role_assignment='list'
  cmds_role_assignment_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --user --project --names --auth-user --auth-project'
  cmds_role_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --or-show'
  cmds_role_delete='-h --help'
  cmds_role_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --project --user'
  cmds_role_remove='-h --help --project --user'
  cmds_role_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_router='add create delete list remove set show unset'
  cmds_router_add='port subnet'
  cmds_router_add_port='-h --help'
  cmds_router_add_subnet='-h --help'
  cmds_router_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --enable --disable --distributed --ha --description --project --project-domain --availability-zone-hint'
  cmds_router_delete='-h --help'
  cmds_router_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --name --enable --disable --long --project --project-domain'
  cmds_router_remove='port subnet'
  cmds_router_remove_port='-h --help'
  cmds_router_remove_subnet='-h --help'
  cmds_router_set='-h --help --name --description --enable --disable --distributed --centralized --route --no-route --clear-routes --ha --no-ha --external-gateway --fixed-ip --enable-snat --disable-snat'
  cmds_router_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_router_unset='-h --help --route --external-gateway'
  cmds_security='group'
  cmds_security_group='create delete list rule set show'
  cmds_security_group_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --description --project --project-domain'
  cmds_security_group_delete='-h --help'
  cmds_security_group_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --all-projects --project --project-domain'
  cmds_security_group_rule='create delete list show'
  cmds_security_group_rule_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --remote-ip --remote-group --src-ip --src-group --description --dst-port --icmp-type --icmp-code --protocol --proto --ingress --egress --ethertype --project --project-domain'
  cmds_security_group_rule_delete='-h --help'
  cmds_security_group_rule_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --all-projects --protocol --ingress --egress --long'
  cmds_security_group_rule_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_security_group_set='-h --help --name --description'
  cmds_security_group_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_server='add backup create delete dump group image list lock migrate pause reboot rebuild remove rescue resize restore resume set shelve show ssh start stop suspend unlock unpause unrescue unset unshelve'
  cmds_server_add='fixed floating security volume'
  cmds_server_add_fixed='ip'
  cmds_server_add_fixed_ip='-h --help'
  cmds_server_add_floating='ip'
  cmds_server_add_floating_ip='-h --help'
  cmds_server_add_security='group'
  cmds_server_add_security_group='-h --help'
  cmds_server_add_volume='-h --help --device'
  cmds_server_backup='create'
  cmds_server_backup_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --name --type --rotate --wait'
  cmds_server_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --image --volume --flavor --security-group --key-name --property --file --user-data --availability-zone --block-device-mapping --nic --hint --config-drive --min --max --wait'
  cmds_server_delete='-h --help --wait'
  cmds_server_dump='create'
  cmds_server_dump_create='-h --help'
  cmds_server_group='create delete list show'
  cmds_server_group_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --policy'
  cmds_server_group_delete='-h --help'
  cmds_server_group_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --all-projects --long'
  cmds_server_group_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_server_image='create'
  cmds_server_image_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --name --wait'
  cmds_server_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --reservation-id --ip --ip6 --name --instance-name --status --flavor --image --host --all-projects --project --project-domain --user --user-domain --long --marker --limit --deleted --changes-since'
  cmds_server_lock='-h --help'
  cmds_server_migrate='-h --help --live --shared-migration --block-migration --disk-overcommit --no-disk-overcommit --wait'
  cmds_server_pause='-h --help'
  cmds_server_reboot='-h --help --hard --soft --wait'
  cmds_server_rebuild='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --image --password --wait'
  cmds_server_remove='fixed floating security volume'
  cmds_server_remove_fixed='ip'
  cmds_server_remove_fixed_ip='-h --help'
  cmds_server_remove_floating='ip'
  cmds_server_remove_floating_ip='-h --help'
  cmds_server_remove_security='group'
  cmds_server_remove_security_group='-h --help'
  cmds_server_remove_volume='-h --help'
  cmds_server_rescue='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_server_resize='-h --help --flavor --confirm --revert --wait'
  cmds_server_restore='-h --help'
  cmds_server_resume='-h --help'
  cmds_server_set='-h --help --name --root-password --property --state'
  cmds_server_shelve='-h --help'
  cmds_server_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --diagnostics'
  cmds_server_ssh='-h --help --login -l --port -p --identity -i --option -o -4 -6 --public --private --address-type -v'
  cmds_server_start='-h --help'
  cmds_server_stop='-h --help'
  cmds_server_suspend='-h --help'
  cmds_server_unlock='-h --help'
  cmds_server_unpause='-h --help'
  cmds_server_unrescue='-h --help'
  cmds_server_unset='-h --help --property'
  cmds_server_unshelve='-h --help'
  cmds_service='create delete list show'
  cmds_service_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --type --name --description'
  cmds_service_delete='-h --help'
  cmds_service_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --long'
  cmds_service_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --catalog'
  cmds_snapshot='create delete list set show unset'
  cmds_snapshot_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --name --description --force --property'
  cmds_snapshot_delete='-h --help'
  cmds_snapshot_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --all-projects --long --marker --limit'
  cmds_snapshot_set='-h --help --name --description --property --state'
  cmds_snapshot_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_snapshot_unset='-h --help --property'
  cmds_subnet='create delete list pool set show unset'
  cmds_subnet_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --project --project-domain --subnet-pool --use-default-subnet-pool --prefix-length --subnet-range --dhcp --no-dhcp --gateway --ip-version --ipv6-ra-mode --ipv6-address-mode --network-segment --network --description --allocation-pool --dns-nameserver --host-route --service-type'
  cmds_subnet_delete='-h --help'
  cmds_subnet_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --long --ip-version --dhcp --no-dhcp --service-type --project --project-domain --network --gateway --name --subnet-range'
  cmds_subnet_pool='create delete list set show unset'
  cmds_subnet_pool_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --pool-prefix --default-prefix-length --min-prefix-length --max-prefix-length --project --project-domain --address-scope --default --no-default --share --no-share --description'
  cmds_subnet_pool_delete='-h --help'
  cmds_subnet_pool_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --long --share --no-share --default --no-default --project --project-domain --name --address-scope'
  cmds_subnet_pool_set='-h --help --name --pool-prefix --default-prefix-length --min-prefix-length --max-prefix-length --address-scope --no-address-scope --default --no-default --description'
  cmds_subnet_pool_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_subnet_pool_unset='-h --help --pool-prefix'
  cmds_subnet_set='-h --help --name --dhcp --no-dhcp --gateway --description --allocation-pool --no-allocation-pool --dns-nameserver --no-dns-nameservers --host-route --no-host-route --service-type'
  cmds_subnet_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_subnet_unset='-h --help --allocation-pool --dns-nameserver --host-route --service-type'
  cmds_token='issue revoke'
  cmds_token_issue='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_token_revoke='-h --help'
  cmds_usage='list show'
  cmds_usage_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --start --end'
  cmds_usage_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --project --start --end'
  cmds_user='create delete list role set show'
  cmds_user_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --project --password --password-prompt --email --enable --disable --or-show'
  cmds_user_delete='-h --help'
  cmds_user_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --project --long'
  cmds_user_role='list'
  cmds_user_role_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --project'
  cmds_user_set='-h --help --name --project --password --password-prompt --email --enable --disable'
  cmds_user_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_volume='backup create delete host list migrate qos service set show snapshot transfer type unset'
  cmds_volume_backup='create delete list restore set show'
  cmds_volume_backup_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --name --description --container --snapshot --force --incremental'
  cmds_volume_backup_delete='-h --help --force'
  cmds_volume_backup_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --long --name --status --volume --marker --limit --all-projects'
  cmds_volume_backup_restore='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_volume_backup_set='-h --help --name --description --state'
  cmds_volume_backup_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_volume_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --size --type --image --snapshot --source --source-replicated --description --user --project --availability-zone --consistency-group --property --hint --multi-attach --bootable --non-bootable --read-only --read-write'
  cmds_volume_delete='-h --help --force --purge'
  cmds_volume_host='set'
  cmds_volume_host_set='-h --help --disable --enable'
  cmds_volume_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --project --project-domain --user --user-domain --name --status --all-projects --long --marker --limit'
  cmds_volume_migrate='-h --help --host --force-host-copy --lock-volume --unlock-volume'
  cmds_volume_qos='associate create delete disassociate list set show unset'
  cmds_volume_qos_associate='-h --help'
  cmds_volume_qos_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --consumer --property'
  cmds_volume_qos_delete='-h --help --force'
  cmds_volume_qos_disassociate='-h --help --volume-type --all'
  cmds_volume_qos_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote'
  cmds_volume_qos_set='-h --help --property'
  cmds_volume_qos_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_volume_qos_unset='-h --help --property'
  cmds_volume_service='list set'
  cmds_volume_service_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --host --service --long'
  cmds_volume_service_set='-h --help --enable --disable --disable-reason'
  cmds_volume_set='-h --help --name --size --description --property --image-property --state --type --retype-policy --bootable --non-bootable --read-only --read-write'
  cmds_volume_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_volume_snapshot='create delete list set show unset'
  cmds_volume_snapshot_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --volume --description --force --property --remote-source'
  cmds_volume_snapshot_delete='-h --help --force'
  cmds_volume_snapshot_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --all-projects --project --project-domain --long --marker --limit --name --status --volume'
  cmds_volume_snapshot_set='-h --help --name --description --no-property --property --state'
  cmds_volume_snapshot_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_volume_snapshot_unset='-h --help --property'
  cmds_volume_transfer='request'
  cmds_volume_transfer_request='accept create delete list show'
  cmds_volume_transfer_request_accept='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_volume_transfer_request_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --name'
  cmds_volume_transfer_request_delete='-h --help'
  cmds_volume_transfer_request_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --all-projects'
  cmds_volume_transfer_request_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_volume_type='create delete list set show unset'
  cmds_volume_type_create='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix --description --public --private --property --project --project-domain'
  cmds_volume_type_delete='-h --help'
  cmds_volume_type_list='-h --help -f --format -c --column --max-width --print-empty --noindent --quote --long --default --public --private'
  cmds_volume_type_set='-h --help --name --description --property --project --project-domain'
  cmds_volume_type_show='-h --help -f --format -c --column --max-width --print-empty --noindent --variable --prefix'
  cmds_volume_type_unset='-h --help --property --project --project-domain'
  cmds_volume_unset='-h --help --property --image-property'

  dash=-
  underscore=_
  cmd=""
  words[0]=""
  completed="${cmds}"
  for var in "${words[@]:1}"
  do
    if [[ ${var} == -* ]] ; then
      break
    fi
    if [ -z "${cmd}" ] ; then
      proposed="${var}"
    else
      proposed="${cmd}_${var}"
    fi
    local i="cmds_${proposed}"
    i=${i//$dash/$underscore}
    eval "local comp=\"\${$i}\""
    if [ -z "${comp}" ] ; then
      break
    fi
    if [[ ${comp} == -* ]] ; then
      if [[ ${cur} != -* ]] ; then
        completed=""
        break
      fi
    fi
    cmd="${proposed}"
    completed="${comp}"
  done

  if [ -z "${completed}" ] ; then
    COMPREPLY=( $( compgen -f -- "$cur" ) $( compgen -d -- "$cur" ) )
  else
    COMPREPLY=( $(compgen -W "${completed}" -- ${cur}) )
  fi
  return 0
}
complete -F _openstack openstack
