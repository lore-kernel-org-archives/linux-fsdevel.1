Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB4390CB5
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781349304; cv=none; b=nNQ4Io7GFsYIUS7Ne9dYqGYlbirMHA564wUl7DlaT2wWDSrUrpDDIIwWR0t5FSFm4eKS0rFTd0bFPKxXkvy0p2bGtLyb5he/dcnogWwCL/xuURfRrKAYZPM07elumth4nrrRguSgNEUu7oIY6ES3BiO0gxPH42aJtbR7eDGbJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781349304; c=relaxed/simple;
	bh=DAaT3zzoxCStN+muTNoshdxtJIAKXG8PlhG1WU7sX5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hF/wyuJ37lFGKpFwGhjm/wVwUIYORA0YNQhD5lGBKwwbWglfeYtMKhPAdBAnKEcbFO4+b0xDL/PidcFkg0wF65Wjduz98jYFS2PoArngZC9NrSJSUbMXLI0wtCzdzki4jCB93HitfuIbaevQHx3E+CHfum46tz2T7aK/AeRcbGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibFatUrd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibFatUrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEE41F00A3D;
	Sat, 13 Jun 2026 11:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781349302;
	bh=9jbTENfEtcMypRYFmBxIFXoVN0I1wCLneXBwrv7eoKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ibFatUrdaW5gpkcUqsVbhJCoMwF+bpsvIOYep3TTZe7ZPWCdFqxG9vmjJAc+mhS/w
	 BqiyDzhF/zouHJf9bA6NL0H7HmvCP202NkB6m27YUm1b8iBpbpqgFmCInE16CD+bdt
	 WVtsBHVwEEn05A8ML+jHEVh6n7f8fIOEwYP0fztjXJAVKPEjAsvymgZfLXRnzfsomE
	 CFxb6DYBme1xuQmwzNfG0Ef6rqCHOwTBKv2jJCvCvemk3C8XjWGBkf2yMSfxyG1Ax2
	 GDYhsUHJb5QiF3WSRCj/fc8UBmpqZyz6eY3ukfup+ot1OcLQMVIZAci4kNQT+n0V/Z
	 EJRQTj2LA0azA==
From: Hannes Reinecke <hare@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 8/8] nvmet: make configfs setup namespace aware
Date: Sat, 13 Jun 2026 13:14:37 +0200
Message-ID: <20260613111437.101763-9-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260613111437.101763-1-hare@kernel.org>
References: <20260613111437.101763-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement 'fill_subsystem' and 'clear_subsystem' callbacks to make
nvmet configfs namespace aware.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/configfs.c  | 183 ++++++++++++++++++++++++++------
 drivers/nvme/target/core.c      |  35 +++---
 drivers/nvme/target/discovery.c | 101 +++++++++++++-----
 drivers/nvme/target/nvmet.h     |  13 ++-
 fs/configfs/dir.c               |   4 +
 fs/configfs/mount.c             |  16 +++
 include/linux/configfs.h        |   2 +
 8 files changed, 273 insertions(+), 85 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 3a80a5e20d07..dcdf46780608 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -25,8 +25,9 @@
 static const struct config_item_type nvmet_host_type;
 static const struct config_item_type nvmet_subsys_type;
 
-static LIST_HEAD(nvmet_ports_list);
-struct list_head *nvmet_ports = &nvmet_ports_list;
+
+static DEFINE_IDR(nvmet_ports_idr);
+static DEFINE_MUTEX(nvmet_ports_mutex);
 
 struct nvmet_type_name_map {
 	u8		type;
@@ -51,6 +52,58 @@ static const struct nvmet_type_name_map nvmet_addr_family[] = {
 	{ NVMF_ADDR_FAMILY_LOOP,	"loop" },
 };
 
+struct list_head *nvmet_get_port_list(u64 ns_id)
+{
+	struct list_head *port_list;
+
+	mutex_lock(&nvmet_ports_mutex);
+	port_list = idr_find(&nvmet_ports_idr, ns_id);
+	mutex_unlock(&nvmet_ports_mutex);
+	return port_list;
+}
+
+static int nvmet_add_port_list(u64 ns_id, struct nvmet_port *p)
+{
+	struct list_head *port_list;
+
+	mutex_lock(&nvmet_ports_mutex);
+	port_list = idr_find(&nvmet_ports_idr, ns_id);
+	if (!port_list) {
+		int err;
+
+		port_list = kzalloc_obj(*port_list);
+		if (!port_list)
+			return -ENOMEM;
+		INIT_LIST_HEAD(port_list);
+		err = idr_alloc(&nvmet_ports_idr, port_list,
+				ns_id, ns_id + 1, GFP_KERNEL);
+		if (err < 0) {
+			kfree(port_list);
+			return err;
+		}
+		WARN_ON(err != ns_id);
+	}
+	list_add(&p->global_entry, port_list);
+	mutex_unlock(&nvmet_ports_mutex);
+	return 0;
+}
+
+static void nvmet_del_port_list(u64 ns_id, struct nvmet_port *p)
+{
+	struct list_head *port_list;
+
+	mutex_lock(&nvmet_ports_mutex);
+	port_list = idr_find(&nvmet_ports_idr, ns_id);
+	if (!WARN_ON(!port_list)) {
+		list_del_init(&p->global_entry);
+		if (list_empty(port_list)) {
+			idr_remove(&nvmet_ports_idr, ns_id);
+			kfree(port_list);
+		}
+	}
+	mutex_unlock(&nvmet_ports_mutex);
+}
+
 static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
 {
 	if (p->enabled)
@@ -1718,6 +1771,7 @@ static void nvmet_subsys_release(struct config_item *item)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
+	configfs_remove_default_groups(&subsys->group);
 	nvmet_subsys_del_ctrls(subsys);
 	nvmet_subsys_put(subsys);
 }
@@ -1735,19 +1789,21 @@ static const struct config_item_type nvmet_subsys_type = {
 static struct config_group *nvmet_subsys_make(struct config_group *group,
 		const char *name)
 {
-	struct nvmet_subsys *subsys;
+	struct nvmet_subsys *subsys, *disc_subsys;
+	u64 ns_id = configfs_nsid_from_group(group);
 
 	if (sysfs_streq(name, NVME_DISC_SUBSYS_NAME)) {
 		pr_err("can't create discovery subsystem through configfs\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (sysfs_streq(name, nvmet_disc_subsys->subsysnqn)) {
+	disc_subsys = nvmet_get_disc_subsys(ns_id);
+	if (sysfs_streq(name, disc_subsys->subsysnqn)) {
 		pr_err("can't create subsystem using unique discovery NQN\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
+	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME, ns_id);
 	if (IS_ERR(subsys))
 		return ERR_CAST(subsys);
 
@@ -2002,11 +2058,13 @@ static const struct config_item_type nvmet_ana_groups_type = {
 static void nvmet_port_release(struct config_item *item)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	u64 ns_id = configfs_nsid_from_group(&port->group);
 
 	/* Let inflight controllers teardown complete */
 	flush_workqueue(nvmet_wq);
-	list_del(&port->global_entry);
+	nvmet_del_port_list(ns_id, port);
 
+	configfs_remove_default_groups(&port->group);
 	key_put(port->keyring);
 	kfree(port->ana_state);
 	kfree(port);
@@ -2041,6 +2099,7 @@ static const struct config_item_type nvmet_port_type = {
 static struct config_group *nvmet_ports_make(struct config_group *group,
 		const char *name)
 {
+	u64 ns_id = configfs_nsid_from_group(group);
 	struct nvmet_port *port;
 	u16 portid;
 	u32 i;
@@ -2073,7 +2132,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 			port->ana_state[i] = NVME_ANA_INACCESSIBLE;
 	}
 
-	list_add(&port->global_entry, &nvmet_ports_list);
+	nvmet_add_port_list(ns_id, port);
 
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
@@ -2120,9 +2179,6 @@ static const struct config_item_type nvmet_ports_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
-static struct config_group nvmet_subsystems_group;
-static struct config_group nvmet_ports_group;
-
 #ifdef CONFIG_NVME_TARGET_AUTH
 static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
 		char *page)
@@ -2304,17 +2360,22 @@ static const struct config_item_type nvmet_hosts_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
-static struct config_group nvmet_hosts_group;
-
 static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
 					     char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%s\n", nvmet_disc_subsys->subsysnqn);
+	u64 ns_id = configfs_nsid_from_group(to_config_group(item));
+	struct nvmet_subsys *disc_subsys = nvmet_get_disc_subsys(ns_id);
+
+	return snprintf(page, PAGE_SIZE, "%s\n", disc_subsys->subsysnqn);
 }
 
 static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 		const char *page, size_t count)
 {
+	struct config_item *subsystems_item;
+	struct config_group *subsystems_group;
+	u64 ns_id = configfs_nsid_from_group(to_config_group(item));
+	struct nvmet_subsys *disc_subsys;
 	struct list_head *entry;
 	char *old_nqn, *new_nqn;
 	size_t len;
@@ -2328,7 +2389,14 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 		return -ENOMEM;
 
 	down_write(&nvmet_config_sem);
-	list_for_each(entry, &nvmet_subsystems_group.cg_children) {
+	subsystems_item = config_group_find_item(to_config_group(item), "subsystems");
+	if (WARN_ON(!subsystems_item)) {
+		kfree(new_nqn);
+		up_write(&nvmet_config_sem);
+		return -EINVAL;
+	}
+	subsystems_group = to_config_group(subsystems_item);
+	list_for_each(entry, &subsystems_group->cg_children) {
 		struct config_item *item =
 			container_of(entry, struct config_item, ci_entry);
 
@@ -2339,8 +2407,9 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 			return -EINVAL;
 		}
 	}
-	old_nqn = nvmet_disc_subsys->subsysnqn;
-	nvmet_disc_subsys->subsysnqn = new_nqn;
+	disc_subsys = nvmet_get_disc_subsys(ns_id);
+	old_nqn = disc_subsys->subsysnqn;
+	disc_subsys->subsysnqn = new_nqn;
 	up_write(&nvmet_config_sem);
 
 	kfree(old_nqn);
@@ -2359,6 +2428,68 @@ static const struct config_item_type nvmet_root_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
+static int nvmet_configfs_fill_subsystem(struct configfs_subsystem *subsys,
+					 u64 ns_id)
+{
+	struct config_group *subsystems_group, *ports_group, *hosts_group;
+	int err;
+
+	err = nvmet_add_disc_subsys(ns_id);
+	if (err < 0)
+		return err;
+
+	subsystems_group = kzalloc_obj(*subsystems_group);
+	if (!subsystems_group) {
+		nvmet_del_disc_subsys(ns_id);
+		return -ENOMEM;
+	}
+	config_group_init_type_name(subsystems_group,
+			"subsystems", &nvmet_subsystems_type);
+	configfs_add_default_group(subsystems_group,
+			&subsys->su_group);
+
+	ports_group = kzalloc_obj(*ports_group);
+	if (!ports_group) {
+		kfree(subsystems_group);
+		nvmet_del_disc_subsys(ns_id);
+		return -ENOMEM;
+	}
+	config_group_init_type_name(ports_group,
+			"ports", &nvmet_ports_type);
+	configfs_add_default_group(ports_group,
+			&subsys->su_group);
+
+	hosts_group = kzalloc_obj(*hosts_group);
+	if (!hosts_group) {
+		kfree(ports_group);
+		kfree(subsystems_group);
+		nvmet_del_disc_subsys(ns_id);
+		return -ENOMEM;
+	}
+	config_group_init_type_name(hosts_group,
+			"hosts", &nvmet_hosts_type);
+	configfs_add_default_group(hosts_group,
+			&subsys->su_group);
+	strcpy(subsys->su_group.cg_item.ci_namebuf, "nvmet");
+	subsys->su_group.cg_item.ci_type = &nvmet_root_type;
+
+	return 0;
+}
+
+static void nvmet_configfs_clear_subsystem(struct configfs_subsystem *subsys,
+					   u64 ns_id)
+{
+	struct config_group *g, *n;
+
+	list_for_each_entry_safe(g, n, &subsys->su_group.default_groups,
+				 group_entry) {
+		list_del(&g->group_entry);
+		config_item_put(&g->cg_item);
+		kfree(g);
+	}
+	nvmet_del_disc_subsys(ns_id);
+}
+
 static struct configfs_subsystem nvmet_configfs_subsystem = {
 	.su_group = {
 		.cg_item = {
@@ -2366,30 +2497,14 @@ static struct configfs_subsystem nvmet_configfs_subsystem = {
 			.ci_type	= &nvmet_root_type,
 		},
 	},
+	.fill_subsystem = nvmet_configfs_fill_subsystem,
+	.clear_subsystem = nvmet_configfs_clear_subsystem,
 };
 
 int __init nvmet_init_configfs(void)
 {
 	int ret;
 
-	config_group_init(&nvmet_configfs_subsystem.su_group);
-	mutex_init(&nvmet_configfs_subsystem.su_mutex);
-
-	config_group_init_type_name(&nvmet_subsystems_group,
-			"subsystems", &nvmet_subsystems_type);
-	configfs_add_default_group(&nvmet_subsystems_group,
-			&nvmet_configfs_subsystem.su_group);
-
-	config_group_init_type_name(&nvmet_ports_group,
-			"ports", &nvmet_ports_type);
-	configfs_add_default_group(&nvmet_ports_group,
-			&nvmet_configfs_subsystem.su_group);
-
-	config_group_init_type_name(&nvmet_hosts_group,
-			"hosts", &nvmet_hosts_type);
-	configfs_add_default_group(&nvmet_hosts_group,
-			&nvmet_configfs_subsystem.su_group);
-
 	ret = configfs_register_subsystem(&nvmet_configfs_subsystem);
 	if (ret) {
 		pr_err("configfs_register_subsystem: %d\n", ret);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e28e0010cfea..ead61c06adff 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1798,22 +1798,27 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		const char *subsysnqn)
 {
 	struct nvmet_subsys_link *p;
+	struct nvmet_subsys *disc_subsys;
+	u64 ns_id;
 
 	if (!port)
 		return NULL;
 
+	ns_id = configfs_nsid_from_group(&port->group);
+	disc_subsys = nvmet_get_disc_subsys(ns_id);
+
 	if (!strcmp(NVME_DISC_SUBSYS_NAME, subsysnqn)) {
-		if (!kref_get_unless_zero(&nvmet_disc_subsys->ref))
+		if (!kref_get_unless_zero(&disc_subsys->ref))
 			return NULL;
-		return nvmet_disc_subsys;
+		return disc_subsys;
 	}
 
 	down_read(&nvmet_config_sem);
-	if (!strncmp(nvmet_disc_subsys->subsysnqn, subsysnqn,
+	if (!strncmp(disc_subsys->subsysnqn, subsysnqn,
 				NVMF_NQN_SIZE)) {
-		if (kref_get_unless_zero(&nvmet_disc_subsys->ref)) {
+		if (kref_get_unless_zero(&disc_subsys->ref)) {
 			up_read(&nvmet_config_sem);
-			return nvmet_disc_subsys;
+			return disc_subsys;
 		}
 	}
 	list_for_each_entry(p, &port->subsystems, entry) {
@@ -1830,7 +1835,7 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 }
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
-		enum nvme_subsys_type type)
+		enum nvme_subsys_type type, u64 ns_id)
 {
 	struct nvmet_subsys *subsys;
 	char serial[NVMET_SN_MAX_SIZE / 2];
@@ -1888,10 +1893,11 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
 
-	ret = nvmet_debugfs_subsys_setup(subsys);
-	if (ret)
-		goto free_subsysnqn;
-
+	if (ns_id) {
+		ret = nvmet_debugfs_subsys_setup(subsys);
+		if (ret)
+			goto free_subsysnqn;
+	}
 	return subsys;
 
 free_subsysnqn:
@@ -1976,21 +1982,15 @@ static int __init nvmet_init(void)
 	if (error)
 		goto out_free_nvmet_aen_work_queue;
 
-	error = nvmet_init_discovery();
-	if (error)
-		goto out_exit_debugfs;
-
 	error = nvmet_init_configfs();
 	if (error)
-		goto out_exit_discovery;
+		goto out_exit_debugfs;
 
 #ifdef CONFIG_NVME_TARGET_BPF
 	nvmet_bpf_struct_ops_init();
 #endif
 	return 0;
 
-out_exit_discovery:
-	nvmet_exit_discovery();
 out_exit_debugfs:
 	nvmet_exit_debugfs();
 out_free_nvmet_aen_work_queue:
@@ -2009,7 +2009,6 @@ static int __init nvmet_init(void)
 static void __exit nvmet_exit(void)
 {
 	nvmet_exit_configfs();
-	nvmet_exit_discovery();
 	nvmet_exit_debugfs();
 	ida_destroy(&cntlid_ida);
 	destroy_workqueue(nvmet_aen_wq);
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index e9b35549e254..95a6fc0e690a 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -8,9 +8,48 @@
 #include <generated/utsrelease.h>
 #include "nvmet.h"
 
-struct nvmet_subsys *nvmet_disc_subsys;
+static DEFINE_IDR(nvmet_disc_idr);
+static DEFINE_MUTEX(nvmet_disc_mutex);
 
-static u64 nvmet_genctr;
+struct nvmet_subsys *nvmet_get_disc_subsys(u64 ns_id)
+{
+	struct nvmet_subsys *subsys;
+
+	mutex_lock(&nvmet_disc_mutex);
+	subsys = idr_find(&nvmet_disc_idr, ns_id);
+	mutex_unlock(&nvmet_disc_mutex);
+	return subsys;
+}
+
+int nvmet_add_disc_subsys(u64 ns_id)
+{
+	struct nvmet_subsys *disc_subsys;
+	int err;
+
+	disc_subsys = nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME,
+					 NVME_NQN_CURR, ns_id);
+	if (IS_ERR(disc_subsys))
+		return PTR_ERR(disc_subsys);
+	mutex_lock(&nvmet_disc_mutex);
+	err = idr_alloc(&nvmet_disc_idr, disc_subsys,
+			ns_id, ns_id + 1, GFP_KERNEL);
+	if (err < 0)
+		nvmet_subsys_put(disc_subsys);
+
+	mutex_unlock(&nvmet_disc_mutex);
+	return err;
+}
+
+void nvmet_del_disc_subsys(u64 ns_id)
+{
+	struct nvmet_subsys *disc_subsys;
+
+	mutex_lock(&nvmet_disc_mutex);
+	disc_subsys = idr_remove(&nvmet_disc_idr, ns_id);
+	if (disc_subsys)
+		nvmet_subsys_put(disc_subsys);
+	mutex_unlock(&nvmet_disc_mutex);
+}
 
 static void __nvmet_disc_changed(struct nvmet_port *port,
 				 struct nvmet_ctrl *ctrl)
@@ -29,18 +68,23 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 			     struct nvmet_subsys *subsys)
 {
 	struct nvmet_ctrl *ctrl;
+	u64 ns_id = configfs_nsid_from_group(&port->group);
+	struct nvmet_subsys *disc_subsys;
 
 	lockdep_assert_held(&nvmet_config_sem);
-	nvmet_genctr++;
+	disc_subsys = nvmet_get_disc_subsys(ns_id);
+	if (WARN_ON(!disc_subsys))
+		return;
+	disc_subsys->genctr++;
 
-	mutex_lock(&nvmet_disc_subsys->lock);
-	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
+	mutex_lock(&disc_subsys->lock);
+	list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
 		if (subsys && !nvmet_host_allowed(subsys, ctrl->hostnqn))
 			continue;
 
 		__nvmet_disc_changed(port, ctrl);
 	}
-	mutex_unlock(&nvmet_disc_subsys->lock);
+	mutex_unlock(&disc_subsys->lock);
 
 	/* If transport can signal change, notify transport */
 	if (port->tr_ops && port->tr_ops->discovery_chg)
@@ -49,18 +93,22 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 
 static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
 					struct nvmet_subsys *subsys,
-					struct nvmet_host *host)
+					struct nvmet_host *host, u64 ns_id)
 {
 	struct nvmet_ctrl *ctrl;
+	struct nvmet_subsys *disc_subsys;
 
-	mutex_lock(&nvmet_disc_subsys->lock);
-	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
+	disc_subsys = nvmet_get_disc_subsys(ns_id);
+	if (WARN_ON(!disc_subsys))
+		return;
+	mutex_lock(&disc_subsys->lock);
+	list_for_each_entry(ctrl, &disc_subsys->ctrls, subsys_entry) {
 		if (host && strcmp(nvmet_host_name(host), ctrl->hostnqn))
 			continue;
 
 		__nvmet_disc_changed(port, ctrl);
 	}
-	mutex_unlock(&nvmet_disc_subsys->lock);
+	mutex_unlock(&disc_subsys->lock);
 }
 
 void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
@@ -68,15 +116,22 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 {
 	struct nvmet_port *port;
 	struct nvmet_subsys_link *s;
+	struct list_head *port_list;
+	struct nvmet_subsys *disc_subsys;
+	u64 ns_id = configfs_nsid_from_group(&subsys->group);
 
 	lockdep_assert_held(&nvmet_config_sem);
-	nvmet_genctr++;
+	disc_subsys = nvmet_get_disc_subsys(ns_id);
+	if (WARN_ON(!disc_subsys))
+		return;
+	disc_subsys->genctr++;
 
-	list_for_each_entry(port, nvmet_ports, global_entry)
+	port_list = nvmet_get_port_list(ns_id);
+	list_for_each_entry(port, port_list, global_entry)
 		list_for_each_entry(s, &port->subsystems, entry) {
 			if (s->subsys != subsys)
 				continue;
-			__nvmet_subsys_disc_changed(port, subsys, host);
+			__nvmet_subsys_disc_changed(port, subsys, host, ns_id);
 		}
 }
 
@@ -172,6 +227,8 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	u16 status = 0;
 	void *buffer;
 	char traddr[NVMF_TRADDR_SIZE];
+	u64 ns_id = configfs_nsid_from_group(&req->port->group);
+	struct nvmet_subsys *disc_subsys;
 
 	if (!nvmet_check_transfer_len(req, data_len))
 		return;
@@ -206,10 +263,12 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	}
 	hdr = buffer;
 
+	disc_subsys = nvmet_get_disc_subsys(ns_id);
+
 	nvmet_set_disc_traddr(req, req->port, traddr);
 
 	nvmet_format_discovery_entry(hdr, req->port,
-				     nvmet_disc_subsys->subsysnqn,
+				     disc_subsys->subsysnqn,
 				     traddr, NVME_NQN_CURR, numrec);
 	numrec++;
 
@@ -234,7 +293,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 		numrec++;
 	}
 
-	hdr->genctr = cpu_to_le64(nvmet_genctr);
+	hdr->genctr = cpu_to_le64(disc_subsys->genctr);
 	hdr->numrec = cpu_to_le64(numrec);
 	hdr->recfmt = cpu_to_le16(0);
 
@@ -407,15 +466,3 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 	}
 
 }
-
-int __init nvmet_init_discovery(void)
-{
-	nvmet_disc_subsys =
-		nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME, NVME_NQN_CURR);
-	return PTR_ERR_OR_ZERO(nvmet_disc_subsys);
-}
-
-void nvmet_exit_discovery(void)
-{
-	nvmet_subsys_put(nvmet_disc_subsys);
-}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 002e94123fb2..d23815a325a5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -328,6 +328,9 @@ struct nvmet_subsys {
 	u16			cntlid_min;
 	u16			cntlid_max;
 
+	/* For discovery subsystems */
+	u64 genctr;
+
 	struct list_head	ctrls;
 
 	struct list_head	hosts;
@@ -632,7 +635,7 @@ ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
 		char *traddr, size_t traddr_len);
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
-		enum nvme_subsys_type type);
+		enum nvme_subsys_type type, u64 ns_id);
 void nvmet_subsys_put(struct nvmet_subsys *subsys);
 void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys);
 
@@ -668,7 +671,6 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len);
 u32 nvmet_get_log_page_len(struct nvme_command *cmd);
 u64 nvmet_get_log_page_offset(struct nvme_command *cmd);
 
-extern struct list_head *nvmet_ports;
 void nvmet_port_disc_changed(struct nvmet_port *port,
 		struct nvmet_subsys *subsys);
 void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
@@ -702,11 +704,12 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 
 int __init nvmet_init_configfs(void);
 void __exit nvmet_exit_configfs(void);
+extern struct list_head *nvmet_get_port_list(u64 ns_id);
 
-int __init nvmet_init_discovery(void);
-void nvmet_exit_discovery(void);
+extern int nvmet_add_disc_subsys(u64 ns_id);
+extern void nvmet_del_disc_subsys(u64 ns_id);
+extern struct nvmet_subsys *nvmet_get_disc_subsys(u64 ns_id);
 
-extern struct nvmet_subsys *nvmet_disc_subsys;
 extern struct rw_semaphore nvmet_config_sem;
 
 extern u32 nvmet_ana_group_enabled[NVMET_MAX_ANAGRPS + 1];
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index bf59165acec7..a4eb47a34f46 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1903,6 +1903,9 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
 	}
 
 	if (subsys->fill_subsystem) {
+		INIT_LIST_HEAD(&subsys->su_link);
+		mutex_init(&subsys->su_mutex);
+		config_group_init(&subsys->su_group);
 		err = subsys->fill_subsystem(subsys, info->ns_id);
 		if (err)
 			goto out_release;
@@ -1951,6 +1954,7 @@ void configfs_link_subsystems(struct super_block *sb,
 		subsys->clear_subsystem = s->clear_subsystem;
 		INIT_LIST_HEAD(&subsys->su_link);
 		mutex_init(&subsys->su_mutex);
+		config_group_init(&subsys->su_group);
 		err = subsys->fill_subsystem(subsys, info->ns_id);
 		if (err) {
 			kfree(subsys);
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 197f5a13a62d..4e6d3cb251bb 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -265,6 +265,22 @@ void configfs_release_fs(struct super_block *sb)
 	simple_release_fs(&info->mnt, &info->mnt_count);
 }
 
+u64 configfs_nsid_from_group(struct config_group *group)
+{
+	struct configfs_super_info *info = configfs_root;
+	u64 ns_id = 0;
+
+	if (group) {
+		struct dentry *dentry = group->cg_item.ci_dentry;
+
+		info = dentry->d_sb->s_fs_info;
+		if (info)
+			ns_id = info->ns_id;
+	}
+	return ns_id;
+}
+EXPORT_SYMBOL_GPL(configfs_nsid_from_group);
+
 static int __init configfs_init(void)
 {
 	int err = -ENOMEM;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index ce88da5bdcec..9c5facf874d9 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -257,6 +257,8 @@ configfs_register_default_group(struct config_group *parent_group,
 				const struct config_item_type *item_type);
 void configfs_unregister_default_group(struct config_group *group);
 
+u64 configfs_nsid_from_group(struct config_group *group);
+
 /* These functions can sleep and can alloc with GFP_KERNEL */
 /* WARNING: These cannot be called underneath configfs callbacks!! */
 int configfs_depend_item(struct configfs_subsystem *subsys,
-- 
2.51.0

