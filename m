Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF53364E93;
	Fri, 19 Jun 2026 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858251; cv=none; b=Hwj4vKp8tiNocEDF4UcS+VSV3WivCJ9e52nNDE9ZbQz5ICoGZvKxFBpzsZ+hCY9fXIKAGiN/2ROJw3HfTbZd9H88YEa3PHhQQGibKZldm8yzb9U8wkKVNzgj/4ZcYFLRlNLAkRbIW3Wabz3nu9cjcFke8+Q7BsEI6LbB/lYtlh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858251; c=relaxed/simple;
	bh=sHFpwAETpysMLZ2j9jnl8QT8Z7++KFUHxozklPxp4yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cbjNYv7mhKATYuruzUGI7tUTs/mbIHTwgdk63pWPfVqnqvJkvwi47zItjrjvM07m6fm79aFQZOAxO4dooEHCfPCAp688HonrQZrEzmqSyLosttRTehqjWMP0IDDt/mwVvwnejiDKFPWInzOOc+EOtUkPjeSWoxNdVEdfgmyr1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQA/eY6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQA/eY6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923B01F000E9;
	Fri, 19 Jun 2026 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858250;
	bh=j34L4LdK7yesaw14SQwq/o7Pm28E2NNZK4SgmvCxgJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JQA/eY6u7UgXvqEEW3L52Bg5mna9g8gSTxna2GqzY0z9VIdV+Dsozm7070kjVBUr3
	 ZHSH8M8nhjzFahWbXLIoCMGBg4btCN4WkBA5eBjyC8TPuY8s+WgsNXmOOO+TnMfgeW
	 jpX4INMK+P1CvqNBFxmWYW3wRsusiAuqD5+OLo/ZQ8rTObeXeTs4UUwG+XndkMdwNb
	 HQRoZRjq3nbRHO9e8zjdF7Cj/rY9fx3X3iUVPAmwB6qsJZWLzauyqNljD9Hl5rAvWG
	 ZVz7Dof6XE2+87YGuA+Fizj6ltMrWh5hTx/9fs9hAD9KK9cSzhH5zwtdk59ru9k9Y+
	 YBKCkXQD5Wo3A==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 19 Jun 2026 10:36:52 +0200
Subject: [PATCH RFC v2 12/12] nvmet: make configfs setup namespace aware
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-ns-v2-12-82fd7094b8dc@kernel.org>
References: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
In-Reply-To: <20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=15408;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=sHFpwAETpysMLZ2j9jnl8QT8Z7++KFUHxozklPxp4yo=;
 b=293fOrsgZ5xjjv4pyiEThng+YGt1NYfN0F/1ajnZm2Zcexd9WmJSFYiN3qgpMBK5rxVOYwf5b
 vFaLJu9u5NYApRYa9nZcsV5GHSTv9VqbK1mCCYVBrwV7r7TF2BT3ef+
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Implement 'fill_subsystem' and 'clear_subsystem' callbacks to make
nvmet configfs namespace aware.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/configfs.c  | 119 ++++++++++++++++++++++++++++++----------
 drivers/nvme/target/core.c      |  12 +++-
 drivers/nvme/target/discovery.c |  13 +++--
 drivers/nvme/target/nvmet.h     |   3 +-
 drivers/nvme/target/tcp.c       |   6 +-
 fs/configfs/mount.c             |  16 ++++++
 include/linux/configfs.h        |   2 +
 7 files changed, 129 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9c761a7f98496d59aa993e3663f0b3da63b6d3c1..d974a97364cf0b778f0f8f768d952a79f4b2b5db 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -71,7 +71,7 @@ struct list_head *nvmet_get_port_list(struct net *net_ns)
 
 static int nvmet_add_port_list(struct nvmet_port *p)
 {
-	u64 ns_id = nvmet_get_ns_id(&init_net);
+	u64 ns_id = nvmet_get_ns_id(p->net_ns);
 	struct list_head *port_list;
 	int err = 0;
 
@@ -100,7 +100,7 @@ static int nvmet_add_port_list(struct nvmet_port *p)
 static void nvmet_del_port_list(struct nvmet_port *p)
 {
 	struct list_head *port_list;
-	u64 ns_id = nvmet_get_ns_id(&init_net);
+	u64 ns_id = nvmet_get_ns_id(p->net_ns);
 
 	xa_lock(&nvmet_ports_xa);
 	port_list = xa_load(&nvmet_ports_xa, ns_id);
@@ -1780,6 +1780,7 @@ static void nvmet_subsys_release(struct config_item *item)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
+	configfs_remove_default_groups(&subsys->group);
 	nvmet_subsys_del_ctrls(subsys);
 	nvmet_subsys_put(subsys);
 }
@@ -1798,13 +1799,14 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 		const char *name)
 {
 	struct nvmet_subsys *subsys, *disc_subsys;
+	struct net *net_ns = configfs_ns_from_group(group);
 
 	if (sysfs_streq(name, NVME_DISC_SUBSYS_NAME)) {
 		pr_err("can't create discovery subsystem through configfs\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(net_ns);
 	if (!disc_subsys)
 		return ERR_PTR(-ENOENT);
 	if (sysfs_streq(name, disc_subsys->subsysnqn)) {
@@ -1812,7 +1814,7 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 		return ERR_PTR(-EINVAL);
 	}
 
-	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
+	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME, net_ns);
 	if (IS_ERR(subsys))
 		return ERR_CAST(subsys);
 
@@ -2072,6 +2074,7 @@ static void nvmet_port_release(struct config_item *item)
 	flush_workqueue(nvmet_wq);
 	nvmet_del_port_list(port);
 
+	configfs_remove_default_groups(&port->group);
 	key_put(port->keyring);
 	kfree(port->ana_state);
 	kfree(port);
@@ -2123,6 +2126,10 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	port->net_ns = configfs_ns_from_group(group);
+	if (!port->net_ns)
+		port->net_ns = get_net(&init_net);
+
 	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS) && nvme_keyring_id()) {
 		port->keyring = key_lookup(nvme_keyring_id());
 		if (IS_ERR(port->keyring)) {
@@ -2185,9 +2192,6 @@ static const struct config_item_type nvmet_ports_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
-static struct config_group nvmet_subsystems_group;
-static struct config_group nvmet_ports_group;
-
 #ifdef CONFIG_NVME_TARGET_AUTH
 static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
 		char *page)
@@ -2369,12 +2373,11 @@ static const struct config_item_type nvmet_hosts_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
-static struct config_group nvmet_hosts_group;
-
 static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
 					     char *page)
 {
-	struct nvmet_subsys *disc_subsys = nvmet_get_disc_subsys(&init_net);
+	struct net *net_ns = configfs_ns_from_group(to_config_group(item));
+	struct nvmet_subsys *disc_subsys = nvmet_get_disc_subsys(net_ns);
 
 	if (!disc_subsys)
 		return -ENOENT;
@@ -2384,6 +2387,9 @@ static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
 static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 		const char *page, size_t count)
 {
+	struct config_item *subsystems_item;
+	struct config_group *subsystems_group;
+	struct net *net_ns = configfs_ns_from_group(to_config_group(item));
 	struct nvmet_subsys *disc_subsys;
 	struct list_head *entry;
 	char *old_nqn, *new_nqn;
@@ -2398,7 +2404,14 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
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
 
@@ -2409,7 +2422,7 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 			return -EINVAL;
 		}
 	}
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(net_ns);
 	if (disc_subsys) {
 		old_nqn = disc_subsys->subsysnqn;
 		disc_subsys->subsysnqn = new_nqn;
@@ -2432,6 +2445,68 @@ static const struct config_item_type nvmet_root_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
+static int nvmet_configfs_fill_subsystem(struct configfs_subsystem *subsys,
+					 struct net *net_ns)
+{
+	struct config_group *subsystems_group, *ports_group, *hosts_group;
+	int err;
+
+	err = nvmet_add_disc_subsys(net_ns);
+	if (err < 0)
+		return err;
+
+	subsystems_group = kzalloc_obj(*subsystems_group);
+	if (!subsystems_group) {
+		nvmet_del_disc_subsys(net_ns);
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
+		nvmet_del_disc_subsys(net_ns);
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
+		nvmet_del_disc_subsys(net_ns);
+		return -ENOMEM;
+	}
+	config_group_init_type_name(hosts_group,
+			"hosts", &nvmet_hosts_type);
+	configfs_add_default_group(hosts_group,
+			&subsys->su_group);
+	strscpy(subsys->su_group.cg_item.ci_namebuf, "nvmet", 5);
+	subsys->su_group.cg_item.ci_type = &nvmet_root_type;
+
+	return 0;
+}
+
+static void nvmet_configfs_clear_subsystem(struct configfs_subsystem *subsys,
+					   struct net *net_ns)
+{
+	struct config_group *g, *n;
+
+	list_for_each_entry_safe(g, n, &subsys->su_group.default_groups,
+				 group_entry) {
+		list_del(&g->group_entry);
+		config_item_put(&g->cg_item);
+		kfree(g);
+	}
+	nvmet_del_disc_subsys(net_ns);
+}
+
 static struct configfs_subsystem nvmet_configfs_subsystem = {
 	.su_group = {
 		.cg_item = {
@@ -2439,30 +2514,14 @@ static struct configfs_subsystem nvmet_configfs_subsystem = {
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
index 1831a218319b84a1e1a1cfba7fb48e3ad40b09f7..39989b8bae92f8e5b384a93c891b9f3e9900305e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1803,7 +1803,7 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 	if (!port)
 		return NULL;
 
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(port->net_ns);
 	if (!disc_subsys)
 		return NULL;
 
@@ -1835,7 +1835,7 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 }
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
-		enum nvme_subsys_type type)
+		enum nvme_subsys_type type, struct net *net_ns)
 {
 	struct nvmet_subsys *subsys;
 	char serial[NVMET_SN_MAX_SIZE / 2];
@@ -1893,8 +1893,16 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
 
+	/* Disable debugfs for non-initial namespaces */
+	if (net_ns == &init_net) {
+		ret = nvmet_debugfs_subsys_setup(subsys);
+		if (ret)
+			goto free_subsysnqn;
+	}
 	return subsys;
 
+free_subsysnqn:
+	kfree(subsys->subsysnqn);
 free_fr:
 	kfree(subsys->firmware_rev);
 free_mn:
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index e929402314f66b635e330980d4d771b9474e7e3d..b4984fc65ba787456186a0c18ff8586f388fa50d 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -26,7 +26,7 @@ int nvmet_add_disc_subsys(struct net *net_ns)
 	int err;
 
 	disc_subsys = nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME,
-					 NVME_NQN_CURR);
+					 NVME_NQN_CURR, net_ns);
 	if (IS_ERR(disc_subsys))
 		return PTR_ERR(disc_subsys);
 	err = xa_insert(&nvmet_disc_xa, ns_id,
@@ -67,7 +67,7 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 	struct nvmet_subsys *disc_subsys;
 
 	lockdep_assert_held(&nvmet_config_sem);
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(port->net_ns);
 	if (WARN_ON(!disc_subsys))
 		return;
 	disc_subsys->genctr++;
@@ -93,7 +93,7 @@ static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
 	struct nvmet_ctrl *ctrl;
 	struct nvmet_subsys *disc_subsys;
 
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(port->net_ns);
 	if (WARN_ON(!disc_subsys))
 		return;
 	mutex_lock(&disc_subsys->lock);
@@ -113,14 +113,15 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 	struct nvmet_subsys_link *s;
 	struct list_head *port_list;
 	struct nvmet_subsys *disc_subsys;
+	struct net *net_ns = configfs_ns_from_group(&subsys->group);
 
 	lockdep_assert_held(&nvmet_config_sem);
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(net_ns);
 	if (WARN_ON(!disc_subsys))
 		return;
 	disc_subsys->genctr++;
 
-	port_list = nvmet_get_port_list(&init_net);
+	port_list = nvmet_get_port_list(net_ns);
 	list_for_each_entry(port, port_list, global_entry)
 		list_for_each_entry(s, &port->subsystems, entry) {
 			if (s->subsys != subsys)
@@ -257,7 +258,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	}
 	hdr = buffer;
 
-	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	disc_subsys = nvmet_get_disc_subsys(req->port->net_ns);
 
 	nvmet_set_disc_traddr(req, req->port, traddr);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index fc871b2b777d633dd64b6d339e124668fd760f8b..681f935d80086b610f137bd64fa27ed16296b3f3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -210,6 +210,7 @@ struct nvmet_port {
 	struct nvmet_ana_group		ana_default_group;
 	enum nvme_ana_state		*ana_state;
 	struct key			*keyring;
+	struct net			*net_ns;
 	void				*priv;
 	bool				enabled;
 	int				inline_data_size;
@@ -629,7 +630,7 @@ ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
 		char *traddr, size_t traddr_len);
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
-		enum nvme_subsys_type type);
+		enum nvme_subsys_type type, struct net *net_ns);
 void nvmet_subsys_put(struct nvmet_subsys *subsys);
 void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys);
 
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 15c52f1f95f1b040f380d01c0b7ad690355d91be..016bef65a76dd9004471fe8bbcd3550f5910137a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2074,7 +2074,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_port;
 	}
 
-	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
+	ret = inet_pton_with_scope(nport->net_ns, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
 		pr_err("malformed ip/port passed: %s:%s\n",
@@ -2087,8 +2087,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (port->nport->inline_data_size < 0)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
-	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+	ret = sock_create_kern(nport->net_ns, port->addr.ss_family, SOCK_STREAM,
+			    IPPROTO_TCP, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index 1f61bc1efe6e2644985c6b90777fa8ddcbb4b742..de773872c98c7a6de7283fbc001801a4080cb00f 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -276,6 +276,22 @@ void configfs_release_fs(struct super_block *sb)
 	mntput(mnt);
 }
 
+struct net *configfs_ns_from_group(struct config_group *group)
+{
+	struct configfs_super_info *info = configfs_root;
+	struct net *net_ns = NULL;
+
+	if (group) {
+		struct dentry *dentry = group->cg_item.ci_dentry;
+
+		info = dentry->d_sb->s_fs_info;
+		if (info)
+			net_ns = info->net_ns;
+	}
+	return net_ns;
+}
+EXPORT_SYMBOL_GPL(configfs_ns_from_group);
+
 static int __init configfs_init(void)
 {
 	int err = -ENOMEM;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 893ae778585fb8be60026c661cb1ef63980ff0e3..76e0bb1a72b9dbbbb3695cfe6b282abb77d03f63 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -258,6 +258,8 @@ configfs_register_default_group(struct config_group *parent_group,
 				const struct config_item_type *item_type);
 void configfs_unregister_default_group(struct config_group *group);
 
+struct net *configfs_ns_from_group(struct config_group *group);
+
 /* These functions can sleep and can alloc with GFP_KERNEL */
 /* WARNING: These cannot be called underneath configfs callbacks!! */
 int configfs_depend_item(struct configfs_subsystem *subsys,

-- 
2.51.0

