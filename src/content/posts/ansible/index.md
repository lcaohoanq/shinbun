---
title: Ansible 101 - Công cụ tự động hóa quản lý server
published: 2026-01-12
description: 'Hoàng ơi mới launch 50 con server Linux, em cài Docker giúp anh với, gấp nha. Làm tay sao nổi, dùng Ansible thôi!'
image: "ansible.png"
tags: [Linux, Server, Bash, yml, Automation, DevOps]
category: 'Công nghệ'
draft: false
lang: 'vi'
---

# Mở đầu

- Có nhiều cách để tự động hóa việc quản lí server:
  - Bash Scripting / Batch Scripting
  - Python/PERL/Ruby Scripting
  - Powershell: dành cho Windows Server
  - Puppet (viết bằng Ruby): cần cài agent trên server quản lí
  - Salt Stack (viết bằng Python)
  - Chef: Cần cài agent trên server quản lí
  - Ansible (viết bằng Python): đơn giản, dễ học, không cần agent cài trên server quản lí, sử dụng các kết nối có sẵn của OS (Linux: SSH, Windows: WinRM)
  - Terraform (IAC: infrastructure as code): tập trung hơn cho cloud automation, hiện giờ HashiCorp đổi license từ (MPL 2.0 sang BSL) không còn tự do open-source nữa, hiện tại có bản fork v1.5.x đặt tên là OpenTofu đưa về Linux Foundation quản lí.

![ricing](ricing.jpg)

> Người dùng Linux rất thích ricing (term khác của config, customize)

# Ứng dụng

- Automation: Bất kì hệ thống nào
- Change Management:
- Provisioning
- Orchestration

![automation](automation.jpg)

# Cách hoạt động

- Ansible sử dụng mô hình client-server, trong đó máy chủ Ansible (control node) quản lý các máy khách (managed nodes) thông qua giao thức SSH (cho Linux), WinRM (cho Windows) và API (cho cloud).
- Viết yaml chạy trên control node, gọi là playbook, mô tả các tác vụ cần thực hiện trên managed nodes. Sẽ dịch từ yaml sang các lệnh shell tương ứng và gửi qua SSH/WinRM để thực thi trên managed nodes.

# Các định dạng file

| Thành phần              | Định dạng chính        | Các tùy chọn hỗ trợ khác                                                                |
|-------------------------|------------------------|-----------------------------------------------------------------------------------------|
| Inventories             | INI, YAML              | JSON, hoặc inventory động viết bằng bất kỳ ngôn ngữ nào (Python, Bash, ...) trả về JSON |
| Playbooks & Roles       | YAML                   | Không có (YAML là tiêu chuẩn bắt buộc cho playbook)                                     |
| Modules (tùy chỉnh)     | Python, PowerShell     | Bất kỳ ngôn ngữ nào có thể trả về dữ liệu JSON (Ruby, Bash, ...)                        |
| Cấu hình (Configuration)| INI (`ansible.cfg`)    | Biến môi trường, tham số dòng lệnh                                                      |

File `ansible.cfg`: thường ở /etc/ansible/ansible.cfg khi cài bằng các package manager, còn cài bằng pip thì sẽ không có, ta có thể tạo file này trong thư mục project để override các thiết lập mặc định, bằng lệnh sau:

```zsh
ansible-config init --disabled > ansible.cfg
```

<details>

  <summary>Click để xem nội dung file ansible.cfg mẫu</summary>

```ini
[defaults]
# (boolean) By default, Ansible will issue a warning when received from a task action (module or action plugin).
# These warnings can be silenced by adjusting this setting to False.
;action_warnings=True

# (boolean) When enabled, this option allows conditionals with non-boolean results to be used.
# A deprecation warning will be emitted in these cases.
# By default, non-boolean conditionals result in an error.
# Such results often indicate unintentional use of templates where they are not supported, resulting in a conditional that is always true.
# When this option is enabled, conditional expressions which are a literal ``None`` or empty string will evaluate as true for backwards compatibility.
;allow_broken_conditionals=False

# (boolean) When enabled, this option allows embedded templates to be used for specific backward compatibility scenarios.
# A deprecation warning will be emitted in these cases.
# First, conditionals (for example, ``failed_when``, ``until``, ``assert.that``) fully enclosed in template delimiters.
# Second, string constants in conditionals (for example, ``when: some_var == '{{ some_other_var }}'``).
# Finally, positional arguments to lookups (for example, ``lookup('pipe', 'echo {{ some_var }}')``).
# This feature is deprecated, since embedded templates are unnecessary in these cases.
# When disabled, use of embedded templates will result in an error.
# A future release will disable this feature by default.
;allow_embedded_templates=True

# (list) Accept a list of cowsay templates that are 'safe' to use, set to an empty list if you want to enable all installed templates.
;cowsay_enabled_stencils=bud-frogs, bunny, cheese, daemon, default, dragon, elephant-in-snake, elephant, eyes, hellokitty, kitty, luke-koala, meow, milk, moofasa, moose, ren, sheep, small, stegosaurus, stimpy, supermilker, three-eyes, turkey, turtle, tux, udder, vader-koala, vader, www

# (string) Specify a custom cowsay path or swap in your cowsay implementation of choice.
;cowpath=

# (string) This allows you to choose a specific cowsay stencil for the banners or use 'random' to cycle through them.
;cow_selection=default

# (boolean) This option forces color mode even when running without a TTY or the "nocolor" setting is True.
;force_color=False

# (path) The default root path for Ansible config files on the controller.
;home=~/.ansible

# (boolean) This setting allows suppressing colorizing output, which is used to give a better indication of failure and status information.
;nocolor=False

# (boolean) If you have cowsay installed but want to avoid the 'cows' (why????), use this.
;nocows=False

# (boolean) Sets the default value for the any_errors_fatal keyword, if True, Task failures will be considered fatal errors.
;any_errors_fatal=False

# (path) The password file to use for the become plugin. ``--become-password-file``.
# If executable, it will be run and the resulting stdout will be used as the password.
;become_password_file=

# (pathspec) Colon-separated paths in which Ansible will search for Become Plugins.
;become_plugins=/home/lcaohoanq/.ansible/plugins/become:/usr/share/ansible/plugins/become

# (string) Chooses which fact cache plugin to use. By default, no cache is used and facts do not persist between runs.
;fact_caching=memory

# (string) Defines connection or path information for the fact cache plugin.
;fact_caching_connection=

# (string) Prefix to use for fact cache plugin files/tables.
;fact_caching_prefix=ansible_facts

# (integer) Expiration timeout for the fact cache plugin data.
;fact_caching_timeout=86400

# (list) List of enabled callbacks, not all callbacks need enabling, but many of those shipped with Ansible do as we don't want them activated by default.
;callbacks_enabled=

# (string) When a collection is loaded that does not support the running Ansible version (with the collection metadata key `requires_ansible`).
;collections_on_ansible_version_mismatch=warning

# (pathspec) Colon-separated paths in which Ansible will search for collections content. Collections must be in nested *subdirectories*, not directly in these directories. For example, if ``COLLECTIONS_PATHS`` includes ``'{{ ANSIBLE_HOME ~ "/collections" }}'``, and you want to add ``my.collection`` to that directory, it must be saved as ``'{{ ANSIBLE_HOME} ~ "/collections/ansible_collections/my/collection" }}'``.

;collections_path=/home/lcaohoanq/.ansible/collections:/usr/share/ansible/collections

# (boolean) A boolean to enable or disable scanning the sys.path for installed collections.
;collections_scan_sys_path=True

# (path) The password file to use for the connection plugin. ``--connection-password-file``.
;connection_password_file=

# (pathspec) Colon-separated paths in which Ansible will search for Action Plugins.
;action_plugins=/home/lcaohoanq/.ansible/plugins/action:/usr/share/ansible/plugins/action

# (boolean) When enabled, this option allows lookup plugins (whether used in variables as ``{{lookup('foo')}}`` or as a loop as with_foo) to return data that is not marked 'unsafe'.
# By default, such data is marked as unsafe to prevent the templating engine from evaluating any jinja2 templating language, as this could represent a security risk. This option is provided to allow for backward compatibility, however, users should first consider adding allow_unsafe=True to any lookups that may be expected to contain data that may be run through the templating engine late.
;allow_unsafe_lookups=False

# (boolean) This controls whether an Ansible playbook should prompt for a login password. If using SSH keys for authentication, you probably do not need to change this setting.
;ask_pass=False

# (boolean) This controls whether an Ansible playbook should prompt for a vault password.
;ask_vault_pass=False

# (pathspec) Colon-separated paths in which Ansible will search for Cache Plugins.
;cache_plugins=/home/lcaohoanq/.ansible/plugins/cache:/usr/share/ansible/plugins/cache

# (pathspec) Colon-separated paths in which Ansible will search for Callback Plugins.
;callback_plugins=/home/lcaohoanq/.ansible/plugins/callback:/usr/share/ansible/plugins/callback

# (pathspec) Colon-separated paths in which Ansible will search for Cliconf Plugins.
;cliconf_plugins=/home/lcaohoanq/.ansible/plugins/cliconf:/usr/share/ansible/plugins/cliconf

# (pathspec) Colon-separated paths in which Ansible will search for Connection Plugins.
;connection_plugins=/home/lcaohoanq/.ansible/plugins/connection:/usr/share/ansible/plugins/connection

# (boolean) Toggles debug output in Ansible. This is *very* verbose and can hinder multiprocessing. Debug output can also include secret information despite no_log settings being enabled, which means debug mode should not be used in production.
;debug=False

# (string) This indicates the command to use to spawn a shell under, which is required for Ansible's execution needs on a target. Users may need to change this in rare instances when shell usage is constrained, but in most cases, it may be left as is.
;executable=/bin/sh

# (pathspec) Colon-separated paths in which Ansible will search for Jinja2 Filter Plugins.
;filter_plugins=/home/lcaohoanq/.ansible/plugins/filter:/usr/share/ansible/plugins/filter

# (boolean) This option controls if notified handlers run on a host even if a failure occurs on that host.
# When false, the handlers will not run if a failure has occurred on a host.
# This can also be set per play or on the command line. See Handlers and Failure for more details.
;force_handlers=False

# (integer) Maximum number of forks Ansible will use to execute tasks on target hosts.
;forks=5

# (string) This setting controls the default policy of fact gathering (facts discovered about remote systems).
# This option can be useful for those wishing to save fact gathering time. Both 'smart' and 'explicit' will use the cache plugin.
;gathering=implicit

# (string) This setting controls how duplicate definitions of dictionary variables (aka hash, map, associative array) are handled in Ansible.
# This does not affect variables whose values are scalars (integers, strings) or arrays.
# **WARNING**, changing this setting is not recommended as this is fragile and makes your content (plays, roles, collections) nonportable, leading to continual confusion and misuse. Don't change this setting unless you think you have an absolute need for it.
# We recommend avoiding reusing variable names and relying on the ``combine`` filter and ``vars`` and ``varnames`` lookups to create merged versions of the individual variables. In our experience, this is rarely needed and is a sign that too much complexity has been introduced into the data structures and plays.
# For some uses you can also look into custom vars_plugins to merge on input, even substituting the default ``host_group_vars`` that is in charge of parsing the ``host_vars/`` and ``group_vars/`` directories. Most users of this setting are only interested in inventory scope, but the setting itself affects all sources and makes debugging even harder.
# All playbooks and roles in the official examples repos assume the default for this setting.
# Changing the setting to ``merge`` applies across variable sources, but many sources will internally still overwrite the variables. For example ``include_vars`` will dedupe variables internally before updating Ansible, with 'last defined' overwriting previous definitions in same file.
# The Ansible project recommends you **avoid ``merge`` for new projects.**
# It is the intention of the Ansible developers to eventually deprecate and remove this setting, but it is being kept as some users do heavily rely on it. New projects should **avoid 'merge'**.
;hash_behaviour=replace

# (pathlist) Comma-separated list of Ansible inventory sources
;inventory=['/etc/ansible/hosts']

# (pathspec) Colon-separated paths in which Ansible will search for HttpApi Plugins.
;httpapi_plugins=/home/lcaohoanq/.ansible/plugins/httpapi:/usr/share/ansible/plugins/httpapi

# (float) This sets the interval (in seconds) of Ansible internal processes polling each other. Lower values improve performance with large playbooks at the expense of extra CPU load. Higher values are more suitable for Ansible usage in automation scenarios when UI responsiveness is not required but CPU usage might be a concern.
# The default corresponds to the value hardcoded in Ansible <= 2.1
;internal_poll_interval=0.001

# (pathspec) Colon-separated paths in which Ansible will search for Inventory Plugins.
;inventory_plugins=/home/lcaohoanq/.ansible/plugins/inventory:/usr/share/ansible/plugins/inventory

# (list) This is a developer-specific feature that allows enabling additional Jinja2 extensions.
# See the Jinja2 documentation for details. If you do not know what these do, you probably don't need to change this setting :)
;jinja2_extensions=

# (boolean) This option preserves variable types during template operations.
;jinja2_native=True

# (boolean) Enables/disables the cleaning up of the temporary files Ansible used to execute the tasks on the remote.
# If this option is enabled it will disable ``ANSIBLE_PIPELINING``.
;keep_remote_files=False

# (boolean) Controls whether callback plugins are loaded when running /usr/bin/ansible. This may be used to log activity from the command line, send notifications, and so on. Callback plugins are always loaded for ``ansible-playbook``.
;bin_ansible_callbacks=False

# (tmppath) Temporary directory for Ansible to use on the controller.
;local_tmp=/home/lcaohoanq/.ansible/tmp

# (list) List of logger names to filter out of the log file.
;log_filter=

# (path) File to which Ansible will log on the controller.
# When not set the logging is disabled.
;log_path=

# (pathspec) Colon-separated paths in which Ansible will search for Lookup Plugins.
;lookup_plugins=/home/lcaohoanq/.ansible/plugins/lookup:/usr/share/ansible/plugins/lookup

# (string) Sets the macro for the 'ansible_managed' variable available for :ref:`ansible_collections.ansible.builtin.template_module` and :ref:`ansible_collections.ansible.windows.win_template_module`.  This is only relevant to those two modules.
;ansible_managed=Ansible managed

# (string) This sets the default arguments to pass to the ``ansible`` adhoc binary if no ``-a`` is specified.
;module_args=

# (string) Compression scheme to use when transferring Python modules to the target.
;module_compression=ZIP_DEFLATED

# (string) Module to use with the ``ansible`` AdHoc command, if none is specified via ``-m``.
;module_name=command

# (pathspec) Colon-separated paths in which Ansible will search for Modules.
;library=/home/lcaohoanq/.ansible/plugins/modules:/usr/share/ansible/plugins/modules

# (pathspec) Colon-separated paths in which Ansible will search for Module utils files, which are shared by modules.
;module_utils=/home/lcaohoanq/.ansible/plugins/module_utils:/usr/share/ansible/plugins/module_utils

# (pathspec) Colon-separated paths in which Ansible will search for Netconf Plugins.
;netconf_plugins=/home/lcaohoanq/.ansible/plugins/netconf:/usr/share/ansible/plugins/netconf

# (boolean) Toggle Ansible's display and logging of task details, mainly used to avoid security disclosures.
;no_log=False

# (boolean) Toggle Ansible logging to syslog on the target when it executes tasks. On Windows hosts, this will disable a newer style PowerShell modules from writing to the event log.
;no_target_syslog=False

# (raw) What templating should return as a 'null' value. When not set it will let Jinja2 decide.
;null_representation=

# (integer) For asynchronous tasks in Ansible (covered in Asynchronous Actions and Polling), this is how often to check back on the status of those tasks when an explicit poll interval is not supplied. The default is a reasonably moderate 15 seconds which is a tradeoff between checking in frequently and providing a quick turnaround when something may have completed.
;poll_interval=15

# (path) Option for connections using a certificate or key file to authenticate, rather than an agent or passwords, you can set the default value here to avoid re-specifying ``--private-key`` with every invocation.
;private_key_file=

# (boolean) By default, imported roles publish their variables to the play and other roles, this setting can avoid that.
# This was introduced as a way to reset role variables to default values if a role is used more than once in a playbook.
# Starting in version '2.17' M(ansible.builtin.include_roles) and M(ansible.builtin.import_roles) can individually override this via the C(public) parameter.
# Included roles only make their variables public at execution, unlike imported roles which happen at playbook compile time.
;private_role_vars=False

# (integer) Port to use in remote connections, when blank it will use the connection plugin default.
;remote_port=

# (string) Sets the login user for the target machines
# When blank it uses the connection plugin's default, normally the user currently executing Ansible.
;remote_user=

# (pathspec) Colon-separated paths in which Ansible will search for Roles.
;roles_path=/home/lcaohoanq/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles

# (string) Set the main callback used to display Ansible output. You can only have one at a time.
# You can have many other callbacks, but just one can be in charge of stdout.
# See :ref:`callback_plugins` for a list of available options.
;stdout_callback=default

# (string) Set the default strategy used for plays.
;strategy=linear

# (pathspec) Colon-separated paths in which Ansible will search for Strategy Plugins.
;strategy_plugins=/home/lcaohoanq/.ansible/plugins/strategy:/usr/share/ansible/plugins/strategy

# (boolean) Toggle the use of "su" for tasks.
;su=False

# (string) Syslog facility to use when Ansible logs to the remote target.
;syslog_facility=LOG_USER

# (pathspec) Colon-separated paths in which Ansible will search for Terminal Plugins.
;terminal_plugins=/home/lcaohoanq/.ansible/plugins/terminal:/usr/share/ansible/plugins/terminal

# (pathspec) Colon-separated paths in which Ansible will search for Jinja2 Test Plugins.
;test_plugins=/home/lcaohoanq/.ansible/plugins/test:/usr/share/ansible/plugins/test

# (integer) This is the default timeout for connection plugins to use.
;timeout=10

# (string) Can be any connection plugin available to your ansible installation.
# There is also a (DEPRECATED) special 'smart' option, that will toggle between 'ssh' and 'paramiko' depending on controller OS and ssh versions.
;transport=ssh

# (boolean) When True, this causes ansible templating to fail steps that reference variable names that are likely typoed.
# Otherwise, any '{{ template_expression }}' that contains undefined variables will be rendered in a template or ansible action line exactly as written.
;error_on_undefined_vars=True

# (pathspec) Colon-separated paths in which Ansible will search for Vars Plugins.
;vars_plugins=/home/lcaohoanq/.ansible/plugins/vars:/usr/share/ansible/plugins/vars

# (string) The vault_id to use for encrypting by default. If multiple vault_ids are provided, this specifies which to use for encryption. The ``--encrypt-vault-id`` CLI option overrides the configured value.
;vault_encrypt_identity=

# (string) The label to use for the default vault id label in cases where a vault id label is not provided.
;vault_identity=default

# (list) A list of vault-ids to use by default. Equivalent to multiple ``--vault-id`` args. Vault-ids are tried in order.
;vault_identity_list=

# (string) If true, decrypting vaults with a vault id will only try the password from the matching vault-id.
;vault_id_match=False

# (path) The vault password file to use. Equivalent to ``--vault-password-file`` or ``--vault-id``.
# If executable, it will be run and the resulting stdout will be used as the password.
;vault_password_file=

# (integer) Sets the default verbosity, equivalent to the number of ``-v`` passed in the command line.
;verbosity=0

# (boolean) Toggle to control the showing of deprecation warnings
;deprecation_warnings=True

# (boolean) Toggle to control showing warnings related to running devel.
;devel_warning=True

# (boolean) Normally ``ansible-playbook`` will print a header for each task that is run. These headers will contain the name: field from the task if you specified one. If you didn't then ``ansible-playbook`` uses the task's action to help you tell which task is presently running. Sometimes you run many of the same action and so you want more information about the task to differentiate it from others of the same action. If you set this variable to True in the config then ``ansible-playbook`` will also include the task's arguments in the header.
# This setting defaults to False because there is a chance that you have sensitive values in your parameters and you do not want those to be printed.
# If you set this to True you should be sure that you have secured your environment's stdout (no one can shoulder surf your screen and you aren't saving stdout to an insecure file) or made sure that all of your playbooks explicitly added the ``no_log: True`` parameter to tasks that have sensitive values :ref:`keep_secret_data` for more information.
;display_args_to_stdout=False

# (boolean) Toggle to control displaying skipped task/host entries in a task in the default callback.
;display_skipped_hosts=True

# (list) When to include tracebacks in extended error messages
;display_traceback=never

# (string) Root docsite URL used to generate docs URLs in warning/error text; must be an absolute URL with a valid scheme and trailing slash.
;docsite_root_url=https://docs.ansible.com/ansible-core/

# (pathspec) Colon-separated paths in which Ansible will search for Documentation Fragments Plugins.
;doc_fragment_plugins=/home/lcaohoanq/.ansible/plugins/doc_fragments:/usr/share/ansible/plugins/doc_fragments

# (string) By default, Ansible will issue a warning when a duplicate dict key is encountered in YAML.
# These warnings can be silenced by adjusting this setting to False.
;duplicate_dict_key=warn

# (string) for the cases in which Ansible needs to return a file within an editor, this chooses the application to use.
;editor=vi

# (boolean) Whether or not to enable the task debugger, this previously was done as a strategy plugin.
# Now all strategy plugins can inherit this behavior. The debugger defaults to activating when
# a task is failed on unreachable. Use the debugger keyword for more flexibility.
;enable_task_debugger=False

# (boolean) Toggle to allow missing handlers to become a warning instead of an error when notifying.
;error_on_missing_handler=True

# (list) Which modules to run during a play's fact gathering stage, using the default of 'smart' will try to figure it out based on connection type.
# If adding your own modules but you still want to use the default Ansible facts, you will want to include 'setup' or corresponding network module to the list (if you add 'smart', Ansible will also figure it out).
# This does not affect explicit calls to the 'setup' module, but does always affect the 'gather_facts' action (implicit or explicit).
;facts_modules=smart

# (boolean) Set this to "False" if you want to avoid host key checking by the underlying connection plugin Ansible uses to connect to the host.
# Please read the documentation of the specific connection plugin used for details.
;host_key_checking=True

# (boolean) Facts are available inside the `ansible_facts` variable, this setting also pushes them as their own vars in the main namespace.
# Unlike inside the `ansible_facts` dictionary where the prefix `ansible_` is removed from fact names, these will have the exact names that are returned by the module.
;inject_facts_as_vars=True

# (string) Path to the Python interpreter to be used for module execution on remote targets, or an automatic discovery mode. Supported discovery modes are ``auto`` (the default), ``auto_silent``, ``auto_legacy``, and ``auto_legacy_silent``. All discovery modes match against an ordered list of well-known Python interpreter locations. The fallback behavior will issue a warning that the interpreter should be set explicitly (since interpreters installed later may change which one is used). This warning behavior can be disabled by setting ``auto_silent``. The ``auto_legacy`` modes are deprecated and behave the same as their respective ``auto`` modes. They exist for backward-compatibility with older Ansible releases that always defaulted to ``/usr/bin/python3``, which will use that interpreter if present.
;interpreter_python=auto

# (boolean) If 'false', invalid attributes for a task will result in warnings instead of errors.
;invalid_task_attribute_failed=True

# (boolean) By default, Ansible will issue a warning when there are no hosts in the inventory.
# These warnings can be silenced by adjusting this setting to False.
;localhost_warning=True

# (int) This will set log verbosity if higher than the normal display verbosity, otherwise it will match that.
;log_verbosity=

# (int) Maximum size of files to be considered for diff display.
;max_diff_size=104448

# (list) List of extensions to ignore when looking for modules to load.
# This is for rejecting script and binary module fallback extensions.
;module_ignore_exts=.pyc, .pyo, .swp, .bak, ~, .rpm, .md, .txt, .rst, .yaml, .yml, .ini

# (bool) Enables whether module responses are evaluated for containing non-UTF-8 data.
# Disabling this may result in unexpected behavior.
# Only ansible-core should evaluate this configuration.
;module_strict_utf8_response=True

# (list) TODO: write it
;network_group_modules=eos, nxos, ios, iosxr, junos, enos, ce, vyos, sros, dellos9, dellos10, dellos6, asa, aruba, aireos, bigip, ironware, onyx, netconf, exos, voss, slxos

# (boolean) Previously Ansible would only clear some of the plugin loading caches when loading new roles, this led to some behaviors in which a plugin loaded in previous plays would be unexpectedly 'sticky'. This setting allows the user to return to that behavior.
;old_plugin_cache_clear=False

# (string) for the cases in which Ansible needs to return output in a pageable fashion, this chooses the application to use.
;pager=less

# (path) A number of non-playbook CLIs have a ``--playbook-dir`` argument; this sets the default value for it.
;playbook_dir=

# (string) This sets which playbook dirs will be used as a root to process vars plugins, which includes finding host_vars/group_vars.
;playbook_vars_root=top

# (path) A path to configuration for filtering which plugins installed on the system are allowed to be used.
# See :ref:`plugin_filtering_config` for details of the filter file's format.
#  The default is /etc/ansible/plugin_filters.yml
;plugin_filters_cfg=

# (string) Attempts to set RLIMIT_NOFILE soft limit to the specified value when executing Python modules (can speed up subprocess usage on Python 2.x. See https://bugs.python.org/issue11284). The value will be limited by the existing hard limit. Default value of 0 does not attempt to adjust existing system-defined limits.
;python_module_rlimit_nofile=0

# (bool) This controls whether a failed Ansible playbook should create a .retry file.
;retry_files_enabled=False

# (path) This sets the path in which Ansible will save .retry files when a playbook fails and retry files are enabled.
# This file will be overwritten after each run with the list of failed hosts from all plays.
;retry_files_save_path=

# (str) This setting can be used to optimize vars_plugin usage depending on the user's inventory size and play selection.
;run_vars_plugins=demand

# (bool) This adds the custom stats set via the set_stats plugin to the default output.
;show_custom_stats=False

# (boolean) Allows disabling of warnings related to potential issues on the system running Ansible itself (not on the managed hosts).
# These may include warnings about third-party packages or other conditions that should be resolved if possible.
;system_warnings=True

# (string) A string to insert into target logging for tracking purposes
;target_log_info=

# (boolean) This option defines whether the task debugger will be invoked on a failed task when ignore_errors=True is specified.
# True specifies that the debugger will honor ignore_errors, and False will not honor ignore_errors.
;task_debugger_ignore_errors=True

# (integer) Set the maximum time (in seconds) for a task action to execute in.
# Timeout runs independently from templating or looping. It applies per each attempt of executing the task's action and remains unchanged by the total time spent on a task.
# When the action execution exceeds the timeout, Ansible interrupts the process. This is registered as a failure due to outside circumstances, not a task failure, to receive appropriate response and recovery process.
# If set to 0 (the default) there is no timeout.
;task_timeout=0

# (string) Make ansible transform invalid characters in group names supplied by inventory sources.
;force_valid_group_names=never

# (boolean) Toggles the use of persistence for connections.
;use_persistent_connections=False

# (bool) A toggle to disable validating a collection's 'metadata' entry for a module_defaults action group. Metadata containing unexpected fields or value types will produce a warning when this is True.
;validate_action_group_metadata=True

# (list) Accept list for variable plugins that require it.
;vars_plugins_enabled=host_group_vars

# (list) Allows to change the group variable precedence merge order.
;precedence=all_inventory, groups_inventory, all_plugins_inventory, all_plugins_play, groups_plugins_inventory, groups_plugins_play

# (string) The salt to use for the vault encryption. If it is not provided, a random salt will be used.
;vault_encrypt_salt=

# (bool) Force 'verbose' option to use stderr instead of stdout
;verbose_to_stderr=False

# (integer) For asynchronous tasks in Ansible (covered in Asynchronous Actions and Polling), this is how long, in seconds, to wait for the task spawned by Ansible to connect back to the named pipe used on Windows systems. The default is 5 seconds. This can be too low on slower systems, or systems under heavy load.
# This is not the total time an async command can run for, but is a separate timeout to wait for an async command to start. The task will only start to be timed against its async_timeout once it has connected to the pipe, so the overall maximum duration the task can take will be extended by the amount specified here.
;win_async_startup_timeout=5

# (list) Check all of these extensions when looking for 'variable' files which should be YAML or JSON or vaulted versions of these.
# This affects vars_files, include_vars, inventory and vars plugins among others.
;yaml_valid_extensions=.yml, .yaml, .json


[privilege_escalation]
# (boolean) Display an agnostic become prompt instead of displaying a prompt containing the command line supplied become method.
;agnostic_become_prompt=True

# (boolean) When ``False``(default), Ansible will skip using become if the remote user is the same as the become user, as this is normally a redundant operation. In other words root sudo to root.
# If ``True``, this forces Ansible to use the become plugin anyways as there are cases in which this is needed.
;become_allow_same_user=False

# (boolean) Toggles the use of privilege escalation, allowing you to 'become' another user after login.
;become=False

# (boolean) Toggle to prompt for privilege escalation password.
;become_ask_pass=False

# (string) executable to use for privilege escalation, otherwise Ansible will depend on PATH.
;become_exe=

# (string) Flags to pass to the privilege escalation executable.
;become_flags=

# (string) Privilege escalation method to use when `become` is enabled.
;become_method=sudo

# (string) The user your login/remote user 'becomes' when using privilege escalation, most systems will use 'root' when no user is specified.
;become_user=root


[persistent_connection]
# (path) Specify where to look for the ansible-connection script. This location will be checked before searching $PATH.
# If null, ansible will start with the same directory as the ansible script.
;ansible_connection_path=

# (int) This controls the amount of time to wait for a response from a remote device before timing out a persistent connection.
;command_timeout=30

# (integer) This controls the retry timeout for persistent connection to connect to the local domain socket.
;connect_retry_timeout=15

# (integer) This controls how long the persistent connection will remain idle before it is destroyed.
;connect_timeout=30

# (path) Path to the socket to be used by the connection persistence system.
;control_path_dir=/home/lcaohoanq/.ansible/pc


[connection]
# (boolean) This is a global option, each connection plugin can override either by having more specific options or not supporting pipelining at all.
# Pipelining, if supported by the connection plugin, reduces the number of network operations required to execute a module on the remote server, by executing many Ansible modules without actual file transfer.
# It can result in a very significant performance improvement when enabled.
# However this conflicts with privilege escalation (become). For example, when using 'sudo:' operations you must first disable 'requiretty' in /etc/sudoers on all managed hosts, which is why it is disabled by default.
# This setting will be disabled if ``ANSIBLE_KEEP_REMOTE_FILES`` is enabled.
;pipelining=False

# (string) Manage an SSH Agent via Ansible. A configuration of ``none`` will not interact with an agent, ``auto`` will start and destroy an agent via ``ssh-agent`` binary during the run, and a path to an SSH_AUTH_SOCK will allow interaction with a pre-existing agent.
;ssh_agent=none

# (str) When ``SSH_AGENT`` is ``auto``, the path or name of the ssh agent executable to start.
;ssh_agent_executable=ssh-agent

# (int) For keys inserted into an agent defined by ``SSH_AGENT``, define a lifetime, in seconds, that the key may remain in the agent.
;ssh_agent_key_lifetime=


[colors]
# (string) Defines the color to use on 'Changed' task status.
;changed=yellow

# (string) Defines the default color to use for ansible-console.
;console_prompt=white

# (string) Defines the color to use when emitting debug messages.
;debug=dark gray

# (string) Defines the color to use when emitting deprecation messages.
;deprecate=purple

# (string) Defines the color to use when showing added lines in diffs.
;diff_add=green

# (string) Defines the color to use when showing diffs.
;diff_lines=cyan

# (string) Defines the color to use when showing removed lines in diffs.
;diff_remove=red

# (string) Defines the color to use when emitting a constant in the ansible-doc output.
;doc_constant=dark gray

# (string) Defines the color to use when emitting a deprecated value in the ansible-doc output.
;doc_deprecated=magenta

# (string) Defines the color to use when emitting a link in the ansible-doc output.
;doc_link=cyan

# (string) Defines the color to use when emitting a module name in the ansible-doc output.
;doc_module=yellow

# (string) Defines the color to use when emitting a plugin name in the ansible-doc output.
;doc_plugin=yellow

# (string) Defines the color to use when emitting cross-reference in the ansible-doc output.
;doc_reference=magenta

# (string) Defines the color to use when emitting error messages.
;error=red

# (string) Defines the color to use for highlighting.
;highlight=white

# (string) Defines the color to use when showing 'Included' task status.
;included=cyan

# (string) Defines the color to use when showing 'OK' task status.
;ok=green

# (string) Defines the color to use when showing 'Skipped' task status.
;skip=cyan

# (string) Defines the color to use on 'Unreachable' status.
;unreachable=bright red

# (string) Defines the color to use when emitting verbose messages. In other words, those that show with '-v's.
;verbose=blue

# (string) Defines the color to use when emitting warning messages.
;warn=bright purple


[selinux]
# (boolean) This setting causes libvirt to connect to LXC containers by passing ``--noseclabel`` parameter to ``virsh`` command. This is necessary when running on systems which do not have SELinux.
;libvirt_lxc_noseclabel=False

# (list) Some filesystems do not support safe operations and/or return inconsistent errors, this setting makes Ansible 'tolerate' those in the list without causing fatal errors.
# Data corruption may occur and writes are not always verified when a filesystem is in the list.
;special_context_filesystems=fuse, nfs, vboxsf, ramfs, 9p, vfat


[diff]
# (bool) Configuration toggle to tell modules to show differences when in 'changed' status, equivalent to ``--diff``.
;always=False

# (integer) Number of lines of context to show when displaying the differences between files.
;context=3


[galaxy]
# (path) The directory that stores cached responses from a Galaxy server.
# This is only used by the ``ansible-galaxy collection install`` and ``download`` commands.
# Cache files inside this dir will be ignored if they are world writable.
;cache_dir=/home/lcaohoanq/.ansible/galaxy_cache

# (bool) whether ``ansible-galaxy collection install`` should warn about ``--collections-path`` missing from configured :ref:`collections_paths`.
;collections_path_warning=True

# (path) Collection skeleton directory to use as a template for the ``init`` action in ``ansible-galaxy collection``, same as ``--collection-skeleton``.
;collection_skeleton=

# (list) patterns of files to ignore inside a Galaxy collection skeleton directory.
;collection_skeleton_ignore=^.git$, ^.*/.git_keep$

# (bool) Disable GPG signature verification during collection installation.
;disable_gpg_verify=False

# (bool) Some steps in ``ansible-galaxy`` display a progress wheel which can cause issues on certain displays or when outputting the stdout to a file.
# This config option controls whether the display wheel is shown or not.
# The default is to show the display wheel if stdout has a tty.
;display_progress=

# (path) Configure the keyring used for GPG signature verification during collection installation and verification.
;gpg_keyring=

# (boolean) If set to yes, ansible-galaxy will not validate TLS certificates. This can be useful for testing against a server with a self-signed certificate.
;ignore_certs=

# (list) A list of GPG status codes to ignore during GPG signature verification. See L(https://github.com/gpg/gnupg/blob/master/doc/DETAILS#general-status-codes) for status code descriptions.
# If fewer signatures successfully verify the collection than `GALAXY_REQUIRED_VALID_SIGNATURE_COUNT`, signature verification will fail even if all error codes are ignored.
;ignore_signature_status_codes=

# (str) The number of signatures that must be successful during GPG signature verification while installing or verifying collections.
# This should be a positive integer or all to indicate all signatures must successfully validate the collection.
# Prepend + to the value to fail if no valid signatures are found for the collection.
;required_valid_signature_count=1

# (path) Role skeleton directory to use as a template for the ``init`` action in ``ansible-galaxy``/``ansible-galaxy role``, same as ``--role-skeleton``.
;role_skeleton=

# (list) patterns of files to ignore inside a Galaxy role or collection skeleton directory.
;role_skeleton_ignore=^.git$, ^.*/.git_keep$

# (string) URL to prepend when roles don't specify the full URI, assume they are referencing this server as the source.
;server=https://galaxy.ansible.com

# (list) A list of Galaxy servers to use when installing a collection.
# The value corresponds to the config ini header ``[galaxy_server.{{item}}]`` which defines the server details.
# See :ref:`galaxy_server_config` for more details on how to define a Galaxy server.
# The order of servers in this list is used as the order in which a collection is resolved.
# Setting this config option will ignore the :ref:`galaxy_server` config option.
;server_list=

# (int) The default timeout for Galaxy API calls. Galaxy servers that don't configure a specific timeout will fall back to this value.
;server_timeout=60

# (path) Local path to galaxy access token file
;token_path=/home/lcaohoanq/.ansible/galaxy_token


[inventory]
# (string) This setting changes the behaviour of mismatched host patterns, it allows you to force a fatal error, a warning or just ignore it.
;host_pattern_mismatch=warning

# (boolean) If 'true', it is a fatal error when any given inventory source cannot be successfully parsed by any available inventory plugin; otherwise, this situation only attracts a warning.

;any_unparsed_is_failed=False

# (list) List of enabled inventory plugins, it also determines the order in which they are used.
;enable_plugins=host_list, script, auto, yaml, ini, toml

# (bool) Controls if ansible-inventory will accurately reflect Ansible's view into inventory or its optimized for exporting.
;export=False

# (list) List of extensions to ignore when using a directory as an inventory source.
;ignore_extensions=.pyc, .pyo, .swp, .bak, ~, .rpm, .md, .txt, .rst, .orig, .cfg, .retry

# (list) List of patterns to ignore when using a directory as an inventory source.
;ignore_patterns=

# (bool) If 'true' it is a fatal error if every single potential inventory source fails to parse, otherwise, this situation will only attract a warning.

;unparsed_is_failed=False

# (boolean) By default, Ansible will issue a warning when no inventory was loaded and notes that it will use an implicit localhost-only inventory.
# These warnings can be silenced by adjusting this setting to False.
;inventory_unparsed_warning=True


[netconf_connection]
# (string) This variable is used to enable bastion/jump host with netconf connection. If set to True the bastion/jump host ssh settings should be present in ~/.ssh/config file, alternatively it can be set to custom ssh configuration file path to read the bastion/jump host settings.
;ssh_config=


[paramiko_connection]
# (boolean) TODO: write it
;host_key_auto_add=False

# (boolean) TODO: write it
;look_for_keys=True


[jinja2]
# (list) This list of filters avoids 'type conversion' when templating variables.
# Useful when you want to avoid conversion into lists or dictionaries for JSON strings, for example.
;dont_type_filters=string, to_json, to_nice_json, to_yaml, to_nice_yaml, ppretty, json


[tags]
# (list) default list of tags to run in your plays, Skip Tags has precedence.
;run=

# (list) default list of tags to skip in your plays, has precedence over Run Tags
;skip=
```

</details>

> Thường sẽ chỉnh option `;host_key_checking=True` thành `host_key_checking=False` để tránh bị hỏi xác nhận key (Yes-No) khi kết nối SSH đến host mới lần đầu tiên.

# Inventory

## Làm quen với Inventory

Đề bài: mình có 4 host với thông tin lần lượt (hostname: ip, user, ssh_private_key_file) như sau:

- ubuntu: 192.168.88.106, devops, /home/lcaohoanq/.ssh/id_ed25519
- centos: 192.168.88.168, devops, /home/lcaohoanq/.ssh/id_ed25519
- debian: 192.168.88.157, root, /home/lcaohoanq/.ssh/id_ed25519
- fpt: 123.456.78.999, root, /home/lcaohoanq/.ssh/key.pem

Thực hành ssh và ping tất cả các host từ máy local.

Chiến thôi:

Trong thư mục hiện tại tạo file `inventory` bằng lệnh:

```zsh
nvim ./inventory
```

- Nội dung file `inventory` như sau:

```yml
all:
  hosts:
    ubuntu:
      ansible_host: 192.168.88.106
      ansible_user: devops
      ansible_ssh_private_key_file: /home/lcaohoanq/.ssh/id_ed25519
    centos:
      ansible_host: 192.168.88.168
      ansible_user: devops
      ansible_ssh_private_key_file: /home/lcaohoanq/.ssh/id_ed25519
    debian:
      ansible_host: 192.168.88.157
      ansible_user: root
      ansible_ssh_private_key_file: /home/lcaohoanq/.ssh/id_ed25519
    fpt:
      ansible_host: 123.456.78.999
      ansible_user: root
      ansible_ssh_private_key_file: /home/lcaohoanq/.ssh/key.pem
```

- Kiểm tra file `inventory` đã đúng định dạng YAML chưa bằng lệnh:

```zsh
ansible-inventory -i ./inventory --list
```

Trả ra đúng định dạng JSON là ok.

```json
{
    "_meta": {
        "hostvars": {
            "centos": {
                "ansible_host": "192.168.88.168",
                "ansible_ssh_private_key_file": "/home/lcaohoanq/.ssh/id_ed25519",
                "ansible_user": "devops"
            },
            "debian": {
                "ansible_host": "192.168.88.157",
                "ansible_ssh_private_key_file": "/home/lcaohoanq/.ssh/id_ed25519",
                "ansible_user": "root"
            },
            "fpt": {
                "ansible_host": "123.456.78.999",
                "ansible_ssh_private_key_file": "/home/lcaohoanq/.ssh/key.pem",
                "ansible_user": "root"
            },
            "ubuntu": {
                "ansible_host": "192.168.88.106",
                "ansible_ssh_private_key_file": "/home/lcaohoanq/.ssh/id_ed25519",
                "ansible_user": "devops"
            }
        },
        "profile": "inventory_legacy"
    },
    "all": {
        "children": [
            "ungrouped"
        ]
    },
    "ungrouped": {
        "hosts": [
            "ubuntu",
            "centos",
            "debian",
            "fpt"
        ]
    }
}
```

- Lệnh kiểm tra ssh tới một host cụ thể, ví dụ host `fpt`:

```zsh
ansible fpt -i ./inventory -m ping
```

Nếu kết nối thành công sẽ trả về:

```json
[WARNING]: Host 'fpt' is using the discovered Python interpreter at '/usr/bin/python3.12', but future installation of another Python interpreter could cause a different interpreter to be discovered. See https://docs.ansible.com/ansible-core/2.19/reference_appendices/interpreter_discovery.html for more information.
fpt | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.12"
    },
    "changed": false,
    "ping": "pong"
}
```

> Dòng **[WARNING]** là cảnh báo về việc Ansible tự động phát hiện phiên bản Python trên host từ xa, không ảnh hưởng gì đến kết quả, tắt cảnh báo bằng cách thêm một dòng `ansible_python_interpreter: /usr/bin/python3.12` vào host `fpt`

```yml
    fpt:
      ansible_host: 123.456.78.999
      ansible_user: root
      ansible_python_interpreter: /usr/bin/python3.12
```

- Chạy lệnh kiểm tra kết nối đến tất cả các host trong inventory:

```zsh
ansible all -i ./inventory -m ping

# hoặc ansible '*' -i ./inventory -m ping
```

- Kết quả trả về sẽ như sau:

```json
fpt | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3.12"
    },
    "changed": false,
    "ping": "pong"
}
[ERROR]: Task failed: Failed to connect to the host via ssh: ssh: connect to host 192.168.88.157 port 22: No route to host
Origin: <adhoc 'ping' task>

{'action': 'ping', 'args': {}, 'timeout': 0, 'async_val': 0, 'poll': 15}

debian | UNREACHABLE! => {
    "changed": false,
    "msg": "Task failed: Failed to connect to the host via ssh: ssh: connect to host 192.168.88.157 port 22: No route to host",
    "unreachable": true
}
[ERROR]: Task failed: Failed to connect to the host via ssh: ssh: connect to host 192.168.88.106 port 22: No route to host
Origin: <adhoc 'ping' task>

{'action': 'ping', 'args': {}, 'timeout': 0, 'async_val': 0, 'poll': 15}

ubuntu | UNREACHABLE! => {
    "changed": false,
    "msg": "Task failed: Failed to connect to the host via ssh: ssh: connect to host 192.168.88.106 port 22: No route to host",
    "unreachable": true
}
[ERROR]: Task failed: Failed to connect to the host via ssh: ssh: connect to host 192.168.88.168 port 22: No route to host
Origin: <adhoc 'ping' task>

{'action': 'ping', 'args': {}, 'timeout': 0, 'async_val': 0, 'poll': 15}

centos | UNREACHABLE! => {
    "changed": false,
    "msg": "Task failed: Failed to connect to the host via ssh: ssh: connect to host 192.168.88.168 port 22: No route to host",
    "unreachable": true
}
```

- Trường hợp lỗi, do các host khác chưa bật, tất cả các host trả về SUCCESS là ok nhé.

## Group các host trong Inventory

- Tiếp tục với file `inventory2`:

```zsh
cp ./inventory ./inventory2
nvim ./inventory2
```

- Thêm các group host như sau:

```yml
all:
  hosts:
    ubuntu:
      ansible_host: 192.168.88.106
      ansible_user: devops
      ansible_ssh_private_key_file: /home/lcaohoanq/.ssh/id_ed25519
    centos:
      ansible_host: 192.168.88.168
      ansible_user: devops
      ansible_ssh_private_key_file: /home/lcaohoanq/.ssh/id_ed25519
    debian:
      ansible_host: 192.168.88.157
      ansible_user: root
      ansible_ssh_private_key_file: /home/lcaohoanq/.ssh/id_ed25519
    fpt:
      ansible_host: 123.456.78.999
      ansible_user: root
      ansible_ssh_private_key_file: /home/lcaohoanq/.ssh/key.pem

  children:
    proxmox_lxc:
      hosts:
        ubuntu:
        centos:
        debian:
    bitlearning_server:
      hosts:
        fpt:
    dc_oregon:
      children:
        proxmox_lxc:
        bitlearning_server:
```

- Kiểm tra file `inventory2` đã đúng định dạng YAML chưa bằng lệnh:

```zsh
ansible-inventory -i ./inventory2 --list
```

Kết quả trả về đúng định dạng JSON là ok.

Ở đây ta có các group host như sau:

- `proxmox_lxc`: gồm 3 host ubuntu, centos, debian
- `bitlearning_server`: gồm 1 host fpt
- `dc_oregon`: gồm 2 group con là proxmox_lxc và bitlearning_server

- Chạy lệnh kiểm tra kết nối đến tất cả các host trong group `proxmox_lxc`:

```zsh
ansible proxmox_lxc -i ./inventory2 -m ping
```

Kết quả sẽ trả về **tổng 3 host** (ubuntu, centos, debian)

- Check group `dc_oregon` ta sẽ check luôn tất cả host trong 2 group con:

```zsh
ansible dc_oregon -i ./inventory2 -m ping
```

Kết quả sẽ trả về **tổng 4 host** (ubuntu, centos, debian, fpt)

## Variable trong Inventory

- Vấn đề xảy ra khi có quá nhiều host, password, username hoặc giá trị nào đó bị lặp đi lặp lại, ta sẽ sử dụng option `vars` để giải quyết.
- Tiếp tục với file `inventory3`, thêm variable cho group host và host như sau:

```yml
all:
  hosts:
    ubuntu:
      ansible_host: 192.168.88.106
      ansible_user: devops
    centos:
      ansible_host: 192.168.88.168
      ansible_user: devops
    debian:
      ansible_host: 192.168.88.157
      ansible_user: root
    fpt:
      ansible_host: 123.456.78.999
      ansible_user: root

  children:
    proxmox_lxc:
      vars:
        ansible_ssh_private_key_file: /home/lcaohoanq/.ssh/id_ed25519
      hosts:
        ubuntu:
        centos:
        debian:
    bitlearning_server:
      vars:
        ansible_ssh_private_key_file: /home/lcaohoanq/.ssh/key.pem
      hosts:
        fpt:
    dc_oregon:
      children:
        proxmox_lxc:
        bitlearning_server:
```

- Thay vì khai báo `ansible_ssh_private_key_file` cho từng host, ta khai báo chung cho cả group host `proxmox_lxc` và `bitlearning_server` luôn.
  - Tất cả các host trong group `proxmox_lxc` sẽ dùng chung file key `/home/lcaohoanq/.ssh/id_ed25519`
  - Host `fpt` trong group `bitlearning_server` sẽ dùng file key `/home/lcaohoanq/.ssh/key.pem`, config sẵn trong tương lai nếu thêm host mới vào group này sẽ không cần khai báo file key nữa.

## Ad hoc

- Doc: <https://docs.ansible.com/projects/ansible/latest/command_guide/intro_adhoc.html>
- Ad hoc là các lệnh đơn giản, không cần viết playbook, dùng để kiểm tra nhanh, chạy lệnh nhanh trên nhiều host.

### Ví dụ 1: Kiểm tra disk space trên tất cả host trong inventory

```zsh
ansible all -i ./inventory3 -a "df -h"
```

- Ví dụ: kiểm tra phiên bản OS trên tất cả host trong inventory:

```zsh
ansible all -i ./inventory3 -a "cat /etc/os-release"
```

Kết quả

```json
fpt | CHANGED | rc=0 >>
PRETTY_NAME="Ubuntu 24.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
VERSION="24.04.3 LTS (Noble Numbat)"
VERSION_CODENAME=noble
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=noble
LOGO=ubuntu-logo
```

### Ví dụ 2: Cài đặt `nano` trên tất cả host trong group `proxmox_lxc`

Chạy trực tiếp lệnh shell:

```zsh
ansible proxmox_lxc -i ./inventory3 -a "apt-get update && apt-get install -y nano" --become
```

- Option `--become`: dùng để chạy lệnh với quyền `sudo` (root), vì có một vài host ssh bằng user `devops` không có quyền cài đặt phần mềm.

Sử dụng module `ansible.builtin.apt` (thay vì chạy lệnh shell), module này sẽ tự động xử lý việc update cache trước khi cài đặt:

- Option `name=nano`: tên phần mềm cần cài đặt
- Option `state=present`: để đảm bảo phần mềm được cài đặt

```zsh
ansible bitlearning_server -m ansible.builtin.apt -a "name=nano state=present" -i inventory3
```

Không cần `--become` vì host `fpt` ssh bằng user `root` luôn.

> Gỡ bỏ `nano` trên group `bitlearning_server`:

- Option `state=absent`: để gỡ bỏ phần mềm

```zsh
ansible bitlearning_server -m ansible.builtin.apt -a "name=nano state=absent" -i inventory3
```

### Ví dụ 3: Start service `fail2ban` trên group `bitlearning_server`

- Option `state=started`: để khởi động service
- Option `enabled=yes`: để service tự động khởi động cùng hệ thống

```zsh
ansible bitlearning_server -m ansible.builtin.service -a "name=fail2ban state=started enabled=yes" -i inventory3
```

Kiểm tra trạng thái service `fail2ban` trên host `fpt`:

- Flag `is-enabled`: để kiểm tra service có được kích hoạt tự động khởi động cùng hệ thống không

```zsh
❯ ansible fpt -i inventory -a "systemctl is-enabled fail2ban"
fpt | CHANGED | rc=0 >>
enabled
```

- Flag `is-active`: để kiểm tra service có đang chạy không

```zsh
❯ ansible fpt -i inventory -a "systemctl is-active fail2ban"
fpt | CHANGED | rc=0 >>
active
```

> Tắt service `fail2ban` trên group `bitlearning_server`:

- Option `state=stopped`: để dừng service
- Option `enabled=no`:  để service không tự động khởi động cùng hệ thống

```zsh
ansible bitlearning_server -m ansible.builtin.service -a "name=fail2ban state=stopped enabled=no" -i inventory3
```

Có một vấn đề rất hay ho ở đây, ta không thể check bằng `is-enabled` và `is-actice` được nữa, ansible sẽ báo lỗi

```zsh
❯ ansible fpt -i inventory -a "systemctl is-enabled fail2ban"
Origin: <adhoc 'command' task>

{'action': 'command', 'args': {'_raw_params': 'systemctl is-enabled fail2ban'}, 'timeout': 0, 'async_val': 0, [...]

fpt | FAILED | rc=1 >>
disablednon-zero return code
```

- Chú ý kết quả vẫn có `disabled`, nhưng ansible bị báo FAILED vì mã trả về khác 0 **(rc=1)**

```zsh

❯ ansible fpt -i inventory -a "systemctl is-active fail2ban"
Origin: <adhoc 'command' task>

{'action': 'command', 'args': {'_raw_params': 'systemctl is-active fail2ban'}, 'timeout': 0, 'async_val': 0, 'poll': 15}

fpt | FAILED | rc=3 >>
inactivenon-zero return code
```

- Ở đây kết quả vẫn có `inactive`, nhưng ansible bị báo FAILED vì mã trả về khác 0 **(rc=3)**

Thử **ssh vào host fpt** check tay thì service đã tắt hoàn toàn 🤔

```zsh
➜  ~ systemctl is-enabled fail2ban
disabled
➜  ~ systemctl is-active fail2ban
inactive
```

> Tại sao lại như vậy?

Khi service `fail2ban` bị tắt hoàn toàn (stopped + disabled) thì lệnh `systemctl is-enabled` và `systemctl is-active` sẽ trả về mã lỗi khác 0, dẫn đến ansible báo lỗi. Cụ thể như sau:

`systemctl is-active` có quy ước exit code rất rõ:

| Trạng thái | Output   | Exit code |
|------------|----------|-----------|
| active     | active   | 0 ✅      |
| inactive   | inactive | 3 ❌      |
| failed     | failed   | 3 ❌      |
| unknown  - | unknown  | 4 ❌      |

Với rc=1 và rc=3 đều là mã lỗi, ansible sẽ báo FAILED.

Cách chuẩn hơn, ta sẽ dùng module `ansible.builtin.systemd` + `grep` để check trạng thái service:

```zsh
ansible fpt -m ansible.builtin.systemd -a "name=fail2ban" -i inventory3 --become
```

<details>
  <summary>Click để xem thêm kết quả, siêu dài</summary>

```json
fpt | SUCCESS => {
    "changed": false,
    "name": "fail2ban",
    "status": {
        "ActiveEnterTimestampMonotonic": "0",
        "ActiveExitTimestampMonotonic": "0",
        "ActiveState": "inactive",
        "After": "iptables.service ip6tables.service firewalld.service systemd-journald.socket network.target basic.target ipset.service system.slice sysinit.target -.mount nftables.service",
        "AllowIsolate": "no",
        "AssertResult": "no",
        "AssertTimestampMonotonic": "0",
        "Before": "shutdown.target",
        "BlockIOAccounting": "no",
        "BlockIOWeight": "[not set]",
        "CPUAccounting": "yes",
        "CPUAffinityFromNUMA": "no",
        "CPUQuotaPerSecUSec": "infinity",
        "CPUQuotaPeriodUSec": "infinity",
        "CPUSchedulingPolicy": "0",
        "CPUSchedulingPriority": "0",
        "CPUSchedulingResetOnFork": "no",
        "CPUShares": "[not set]",
        "CPUUsageNSec": "[not set]",
        "CPUWeight": "[not set]",
        "CacheDirectoryMode": "0755",
        "CanClean": "runtime",
        "CanFreeze": "yes",
        "CanIsolate": "no",
        "CanReload": "yes",
        "CanStart": "yes",
        "CanStop": "yes",
        "CapabilityBoundingSet": "cap_chown cap_dac_override cap_dac_read_search cap_fowner cap_fsetid cap_kill cap_setgid cap_setuid cap_setpcap cap_linux_immutable cap_net_bind_service cap_net_broadcast cap_net_admin cap_net_raw cap_ipc_lock cap_ipc_owner cap_sys_module cap_sys_rawio cap_sys_chroot cap_sys_ptrace cap_sys_pacct cap_sys_admin cap_sys_boot cap_sys_nice cap_sys_resource cap_sys_time cap_sys_tty_config cap_mknod cap_lease cap_audit_write cap_audit_control cap_setfcap cap_mac_override cap_mac_admin cap_syslog cap_wake_alarm cap_block_suspend cap_audit_read cap_perfmon cap_bpf cap_checkpoint_restore",
        "CleanResult": "success",
        "CollectMode": "inactive",
        "ConditionResult": "no",
        "ConditionTimestampMonotonic": "0",
        "ConfigurationDirectoryMode": "0755",
        "Conflicts": "shutdown.target",
        "ControlGroupId": "0",
        "ControlPID": "0",
        "CoredumpFilter": "0x33",
        "CoredumpReceive": "no",
        "DefaultDependencies": "yes",
        "DefaultMemoryLow": "0",
        "DefaultMemoryMin": "0",
        "DefaultStartupMemoryLow": "0",
        "Delegate": "no",
        "Description": "Fail2Ban Service",
        "DevicePolicy": "auto",
        "Documentation": "\"man:fail2ban(1)\"",
        "DynamicUser": "no",
        "Environment": "PYTHONNOUSERSITE=yes",
        "ExecMainCode": "0",
        "ExecMainExitTimestampMonotonic": "0",
        "ExecMainPID": "0",
        "ExecMainStartTimestampMonotonic": "0",
        "ExecMainStatus": "0",
        "ExecReload": "{ path=/usr/bin/fail2ban-client ; argv[]=/usr/bin/fail2ban-client reload ; ignore_errors=no ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }",
        "ExecReloadEx": "{ path=/usr/bin/fail2ban-client ; argv[]=/usr/bin/fail2ban-client reload ; flags= ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }",
        "ExecStart": "{ path=/usr/bin/fail2ban-server ; argv[]=/usr/bin/fail2ban-server -xf start ; ignore_errors=no ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }",
        "ExecStartEx": "{ path=/usr/bin/fail2ban-server ; argv[]=/usr/bin/fail2ban-server -xf start ; flags= ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }",
        "ExecStop": "{ path=/usr/bin/fail2ban-client ; argv[]=/usr/bin/fail2ban-client stop ; ignore_errors=no ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }",
        "ExecStopEx": "{ path=/usr/bin/fail2ban-client ; argv[]=/usr/bin/fail2ban-client stop ; flags= ; start_time=[n/a] ; stop_time=[n/a] ; pid=0 ; code=(null) ; status=0/0 }",
        "ExitType": "main",
        "ExtensionImagePolicy": "root=verity+signed+encrypted+unprotected+absent:usr=verity+signed+encrypted+unprotected+absent:home=encrypted+unprotected+absent:srv=encrypted+unprotected+absent:tmp=encrypted+unprotected+absent:var=encrypted+unprotected+absent",
        "FailureAction": "none",
        "FileDescriptorStoreMax": "0",
        "FileDescriptorStorePreserve": "restart",
        "FinalKillSignal": "9",
        "FragmentPath": "/usr/lib/systemd/system/fail2ban.service",
        "FreezerState": "running",
        "GID": "[not set]",
        "GuessMainPID": "yes",
        "IOAccounting": "no",
        "IOReadBytes": "[not set]",
        "IOReadOperations": "[not set]",
        "IOSchedulingClass": "2",
        "IOSchedulingPriority": "4",
        "IOWeight": "[not set]",
        "IOWriteBytes": "[not set]",
        "IOWriteOperations": "[not set]",
        "IPAccounting": "no",
        "IPEgressBytes": "[no data]",
        "IPEgressPackets": "[no data]",
        "IPIngressBytes": "[no data]",
        "IPIngressPackets": "[no data]",
        "Id": "fail2ban.service",
        "IgnoreOnIsolate": "no",
        "IgnoreSIGPIPE": "yes",
        "InactiveEnterTimestampMonotonic": "0",
        "InactiveExitTimestampMonotonic": "0",
        "JobRunningTimeoutUSec": "infinity",
        "JobTimeoutAction": "none",
        "JobTimeoutUSec": "infinity",
        "KeyringMode": "private",
        "KillMode": "control-group",
        "KillSignal": "15",
        "LimitAS": "infinity",
        "LimitASSoft": "infinity",
        "LimitCORE": "infinity",
        "LimitCORESoft": "0",
        "LimitCPU": "infinity",
        "LimitCPUSoft": "infinity",
        "LimitDATA": "infinity",
        "LimitDATASoft": "infinity",
        "LimitFSIZE": "infinity",
        "LimitFSIZESoft": "infinity",
        "LimitLOCKS": "infinity",
        "LimitLOCKSSoft": "infinity",
        "LimitMEMLOCK": "8388608",
        "LimitMEMLOCKSoft": "8388608",
        "LimitMSGQUEUE": "819200",
        "LimitMSGQUEUESoft": "819200",
        "LimitNICE": "0",
        "LimitNICESoft": "0",
        "LimitNOFILE": "524288",
        "LimitNOFILESoft": "1024",
        "LimitNPROC": "39787",
        "LimitNPROCSoft": "39787",
        "LimitRSS": "infinity",
        "LimitRSSSoft": "infinity",
        "LimitRTPRIO": "0",
        "LimitRTPRIOSoft": "0",
        "LimitRTTIME": "infinity",
        "LimitRTTIMESoft": "infinity",
        "LimitSIGPENDING": "39787",
        "LimitSIGPENDINGSoft": "39787",
        "LimitSTACK": "infinity",
        "LimitSTACKSoft": "8388608",
        "LoadState": "loaded",
        "LockPersonality": "no",
        "LogLevelMax": "-1",
        "LogRateLimitBurst": "0",
        "LogRateLimitIntervalUSec": "0",
        "LogsDirectoryMode": "0755",
        "MainPID": "0",
        "ManagedOOMMemoryPressure": "auto",
        "ManagedOOMMemoryPressureLimit": "0",
        "ManagedOOMPreference": "none",
        "ManagedOOMSwap": "auto",
        "MemoryAccounting": "yes",
        "MemoryAvailable": "6636195840",
        "MemoryCurrent": "[not set]",
        "MemoryDenyWriteExecute": "no",
        "MemoryHigh": "infinity",
        "MemoryKSM": "no",
        "MemoryLimit": "infinity",
        "MemoryLow": "0",
        "MemoryMax": "infinity",
        "MemoryMin": "0",
        "MemoryPeak": "[not set]",
        "MemoryPressureThresholdUSec": "200ms",
        "MemoryPressureWatch": "auto",
        "MemorySwapCurrent": "[not set]",
        "MemorySwapMax": "infinity",
        "MemorySwapPeak": "[not set]",
        "MemoryZSwapCurrent": "[not set]",
        "MemoryZSwapMax": "infinity",
        "MountAPIVFS": "no",
        "MountImagePolicy": "root=verity+signed+encrypted+unprotected+absent:usr=verity+signed+encrypted+unprotected+absent:home=encrypted+unprotected+absent:srv=encrypted+unprotected+absent:tmp=encrypted+unprotected+absent:var=encrypted+unprotected+absent",
        "NFileDescriptorStore": "0",
        "NRestarts": "0",
        "NUMAPolicy": "n/a",
        "Names": "fail2ban.service",
        "NeedDaemonReload": "no",
        "Nice": "0",
        "NoNewPrivileges": "no",
        "NonBlocking": "no",
        "NotifyAccess": "none",
        "OOMPolicy": "stop",
        "OOMScoreAdjust": "0",
        "OnFailureJobMode": "replace",
        "OnSuccessJobMode": "fail",
        "PIDFile": "/run/fail2ban/fail2ban.pid",
        "PartOf": "firewalld.service",
        "Perpetual": "no",
        "PrivateDevices": "no",
        "PrivateIPC": "no",
        "PrivateMounts": "no",
        "PrivateNetwork": "no",
        "PrivateTmp": "no",
        "PrivateUsers": "no",
        "ProcSubset": "all",
        "ProtectClock": "no",
        "ProtectControlGroups": "no",
        "ProtectHome": "no",
        "ProtectHostname": "no",
        "ProtectKernelLogs": "no",
        "ProtectKernelModules": "no",
        "ProtectKernelTunables": "no",
        "ProtectProc": "default",
        "ProtectSystem": "no",
        "RefuseManualStart": "no",
        "RefuseManualStop": "no",
        "ReloadResult": "success",
        "ReloadSignal": "1",
        "RemainAfterExit": "no",
        "RemoveIPC": "no",
        "Requires": "system.slice sysinit.target -.mount",
        "RequiresMountsFor": "/run/fail2ban",
        "Restart": "on-failure",
        "RestartKillSignal": "15",
        "RestartMaxDelayUSec": "infinity",
        "RestartMode": "normal",
        "RestartPreventExitStatus": "0 255",
        "RestartSteps": "0",
        "RestartUSec": "100ms",
        "RestartUSecNext": "100ms",
        "RestrictNamespaces": "no",
        "RestrictRealtime": "no",
        "RestrictSUIDSGID": "no",
        "Result": "success",
        "RootDirectoryStartOnly": "no",
        "RootEphemeral": "no",
        "RootImagePolicy": "root=verity+signed+encrypted+unprotected+absent:usr=verity+signed+encrypted+unprotected+absent:home=encrypted+unprotected+absent:srv=encrypted+unprotected+absent:tmp=encrypted+unprotected+absent:var=encrypted+unprotected+absent",
        "RuntimeDirectory": "fail2ban",
        "RuntimeDirectoryMode": "0755",
        "RuntimeDirectoryPreserve": "no",
        "RuntimeMaxUSec": "infinity",
        "RuntimeRandomizedExtraUSec": "0",
        "SameProcessGroup": "no",
        "SecureBits": "0",
        "SendSIGHUP": "no",
        "SendSIGKILL": "yes",
        "SetLoginEnvironment": "no",
        "Slice": "system.slice",
        "StandardError": "inherit",
        "StandardInput": "null",
        "StandardOutput": "journal",
        "StartLimitAction": "none",
        "StartLimitBurst": "5",
        "StartLimitIntervalUSec": "10s",
        "StartupBlockIOWeight": "[not set]",
        "StartupCPUShares": "[not set]",
        "StartupCPUWeight": "[not set]",
        "StartupIOWeight": "[not set]",
        "StartupMemoryHigh": "infinity",
        "StartupMemoryLow": "0",
        "StartupMemoryMax": "infinity",
        "StartupMemorySwapMax": "infinity",
        "StartupMemoryZSwapMax": "infinity",
        "StateChangeTimestampMonotonic": "0",
        "StateDirectoryMode": "0755",
        "StatusErrno": "0",
        "StopWhenUnneeded": "no",
        "SubState": "dead",
        "SuccessAction": "none",
        "SurviveFinalKillSignal": "no",
        "SyslogFacility": "3",
        "SyslogLevel": "6",
        "SyslogLevelPrefix": "yes",
        "SyslogPriority": "30",
        "SystemCallErrorNumber": "2147483646",
        "TTYReset": "no",
        "TTYVHangup": "no",
        "TTYVTDisallocate": "no",
        "TasksAccounting": "yes",
        "TasksCurrent": "[not set]",
        "TasksMax": "11936",
        "TimeoutAbortUSec": "1min 30s",
        "TimeoutCleanUSec": "infinity",
        "TimeoutStartFailureMode": "terminate",
        "TimeoutStartUSec": "1min 30s",
        "TimeoutStopFailureMode": "terminate",
        "TimeoutStopUSec": "1min 30s",
        "TimerSlackNSec": "50000",
        "Transient": "no",
        "Type": "simple",
        "UID": "[not set]",
        "UMask": "0022",
        "UnitFilePreset": "enabled",
        "UnitFileState": "disabled",
        "UtmpMode": "init",
        "WatchdogSignal": "6",
        "WatchdogTimestampMonotonic": "0",
        "WatchdogUSec": "infinity"
    }
}
```

</details>

Chú ý có dòng `"ActiveState": "inactive",` nghĩa là service đang tắt. Vậy update script kiểm tra trạng thái service `fail2ban` như sau:

```zsh
ansible fpt -m ansible.builtin.systemd -a "name=fail2ban" -i inventory3 --become | grep '"ActiveState":'
```

Kết quả trả về:

```json
    "ActiveState": "inactive",
```
