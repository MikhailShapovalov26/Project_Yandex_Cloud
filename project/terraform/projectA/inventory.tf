resource "local_file" "inventory" {
  content = <<-DOC
    # Ansible inventory containing variable values from Terraform.
    # Generated by Terraform.

    [db-all:children]
    db-master
    db-slave

    [nginx]
    proxy ansible_host=${local.Foo}

    [db-master]
    db-master-01 ansible_host=${yandex_compute_instance.db01.hostname} 
    [db-master:vars]
    ansible_ssh_common_args='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${local.Foo}"'

    [db-slave]
    db-slave-01 ansible_host=${yandex_compute_instance.db02.hostname} 
    [db-slave:vars]
    ansible_ssh_common_args='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${local.Foo}"'

    [wordpress]
    wordpress ansible_host=${yandex_compute_instance.wd_msh762.hostname} 
    [wordpress:vars]
    ansible_ssh_common_args='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${local.Foo}"'

    [gitlab]
    gitlab-msh762 ansible_host=${yandex_compute_instance.gitlab_msh762.hostname}
    [gitlab:vars]
    ansible_ssh_common_args='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${local.Foo}"'

    [runner]
    runner ansible_host=${yandex_compute_instance.runner.hostname}
    [runner:vars]
    ansible_ssh_common_args='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${local.Foo}"'

    [monitoring]
    monitoring ansible_host=${yandex_compute_instance.monitoring.hostname}
    [monitoring:vars]
    ansible_ssh_common_args='-o UserKnownHostsFile=/dev/null -o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${local.Foo}"'
    DOC
  filename = "../../ansible/inventory"

  depends_on = [
    yandex_compute_instance.db01,
    yandex_compute_instance.db02,
    yandex_compute_instance.proxy,
    yandex_compute_instance.wd_msh762,
    yandex_compute_instance.gitlab_msh762,
    yandex_compute_instance.runner,
    yandex_compute_instance.monitoring
  ]
}
