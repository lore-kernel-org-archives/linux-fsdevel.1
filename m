Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FAD35B63B;
	Fri, 19 Jun 2026 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858246; cv=none; b=V3n1DU8rD+TNBhNDPdFknZ+bQbMGuGX1W8OtgctpVw7b1XwPuHlPJ2JJGQ8abQUz49dNGA9PB1676A+NcmWpm7yxBR0lI3qs1T1gw6ZkwLnrL8UB7jF2OHQQzD9iooBzCx8/xvszz3LAq0yU0LLJZXhvsBHDQHcAspKzggFgo+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858246; c=relaxed/simple;
	bh=6Slvd7PHbPTVG64F5yRfN2Jq/00r4Jeyd4q4sRH65Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kGqJq55VDgVaM1bjIyJyXJKGMblEjcUpfklcf98rvWvFY9s1llL6BvH6Kel8gr+rkF5LuZQa5YCirp2fyGzYRvEAnjUtawqREGRObs/6GZR/YZR5w1mDjT5m79D7l0NzSQ8JyTTSHjnsxqdNXLIEITCXFPj2mTXQbsn+nJKwtgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXrESfH0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXrESfH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A241F000E9;
	Fri, 19 Jun 2026 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858244;
	bh=QCsS+rFDtXHrZIpjDnMkofQrvh6A0Az++BxVe5umTgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HXrESfH01aKw5YFgXOiDg73IrsqW4NVMxbXlDW3id6drwQv6YMeNaqIiiQftg8IFu
	 cXYfg5TjgxFvQG+nPrye5JY3A6wDl1NUQAYW2nrEmjBA8trFq405fHaRNkwPl7W7+1
	 EUByLYSXch6Pvb7S5CWuZHxlAOiIkFI93jfEKshTBgUvdIIcKID46Vva9AV5V1oCTz
	 nT1WFXbCzL8VGb1VbmFQmsiT97K/Pi4TtbBrv8Js79wuAL9tlus+C6TmberEwCohHy
	 X21HjwcULXRhBGdawfBszPEigLGwtyz0IgK3mX63F6O2Ze5NfL77DDU3sWLMXPH2ZM
	 lPsaIG+f+rLTg==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 19 Jun 2026 10:36:50 +0200
Subject: [PATCH RFC v2 10/12] nvmet: make discovery subsystem dynamic
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-ns-v2-10-82fd7094b8dc@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=11379;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=6Slvd7PHbPTVG64F5yRfN2Jq/00r4Jeyd4q4sRH65Yg=;
 b=reTB/xNWxsxOvX+DTzzDGWLk6btQ7NDF0JczWXpsvnPJe/wN+omYtElpIh60tDSULOKbpuoSQ
 2hItMHNKMP8A5k7W/JAbrk0AD9pxuX68+3Fki9f8c5Qo1+7bu3hcWxp
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

In preparation to make nvmet namespace-aware convert the
discovery subsystem to dynamic allocation.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/configfs.c  | 33 +++++++++++++---
 drivers/nvme/target/core.c      | 30 ++++++--------
 drivers/nvme/target/discovery.c | 86 +++++++++++++++++++++++++++++------------
 drivers/nvme/target/nvmet.h     | 11 ++++--
 4 files changed, 108 insertions(+), 52 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b88f897f06e25e3e604615c75dc55cc5b2a1f1a1..6030647cee937195d772bcf4b92cb37b6ebf9f08 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -51,6 +51,16 @@ static const struct nvmet_type_name_map nvmet_addr_family[] = {
 	{ NVMF_ADDR_FAMILY_LOOP,	"loop" },
 };
 
+u64 nvmet_get_ns_id(struct net *net_ns)
+{
+	struct ns_common *ns;
+
+	if (!net_ns)
+		return 0;
+	ns = to_ns_common(net_ns);
+	return net_ns == &init_net ? 0 : ns->ns_id;
+}
+
 static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
 {
 	if (p->enabled)
@@ -1734,14 +1744,17 @@ static const struct config_item_type nvmet_subsys_type = {
 static struct config_group *nvmet_subsys_make(struct config_group *group,
 		const char *name)
 {
-	struct nvmet_subsys *subsys;
+	struct nvmet_subsys *subsys, *disc_subsys;
 
 	if (sysfs_streq(name, NVME_DISC_SUBSYS_NAME)) {
 		pr_err("can't create discovery subsystem through configfs\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (sysfs_streq(name, nvmet_disc_subsys->subsysnqn)) {
+	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	if (!disc_subsys)
+		return ERR_PTR(-ENOENT);
+	if (sysfs_streq(name, disc_subsys->subsysnqn)) {
 		pr_err("can't create subsystem using unique discovery NQN\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -2308,12 +2321,17 @@ static struct config_group nvmet_hosts_group;
 static ssize_t nvmet_root_discovery_nqn_show(struct config_item *item,
 					     char *page)
 {
-	return snprintf(page, PAGE_SIZE, "%s\n", nvmet_disc_subsys->subsysnqn);
+	struct nvmet_subsys *disc_subsys = nvmet_get_disc_subsys(&init_net);
+
+	if (!disc_subsys)
+		return -ENOENT;
+	return snprintf(page, PAGE_SIZE, "%s\n", disc_subsys->subsysnqn);
 }
 
 static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 		const char *page, size_t count)
 {
+	struct nvmet_subsys *disc_subsys;
 	struct list_head *entry;
 	char *old_nqn, *new_nqn;
 	size_t len;
@@ -2338,12 +2356,15 @@ static ssize_t nvmet_root_discovery_nqn_store(struct config_item *item,
 			return -EINVAL;
 		}
 	}
-	old_nqn = nvmet_disc_subsys->subsysnqn;
-	nvmet_disc_subsys->subsysnqn = new_nqn;
+	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	if (disc_subsys) {
+		old_nqn = disc_subsys->subsysnqn;
+		disc_subsys->subsysnqn = new_nqn;
+	}
 	up_write(&nvmet_config_sem);
 
 	kfree(old_nqn);
-	return len;
+	return disc_subsys ? len : -ENOENT;
 }
 
 CONFIGFS_ATTR(nvmet_root_, discovery_nqn);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 62dd59b9aa4f1c9bfd32361e3f06ab1520424ce8..1831a218319b84a1e1a1cfba7fb48e3ad40b09f7 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1798,22 +1798,27 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		const char *subsysnqn)
 {
 	struct nvmet_subsys_link *p;
+	struct nvmet_subsys *disc_subsys;
 
 	if (!port)
 		return NULL;
 
+	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	if (!disc_subsys)
+		return NULL;
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
@@ -1888,14 +1893,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
 
-	ret = nvmet_debugfs_subsys_setup(subsys);
-	if (ret)
-		goto free_subsysnqn;
-
 	return subsys;
 
-free_subsysnqn:
-	kfree(subsys->subsysnqn);
 free_fr:
 	kfree(subsys->firmware_rev);
 free_mn:
@@ -1976,18 +1975,12 @@ static int __init nvmet_init(void)
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
 
 	return 0;
 
-out_exit_discovery:
-	nvmet_exit_discovery();
 out_exit_debugfs:
 	nvmet_exit_debugfs();
 out_free_nvmet_aen_work_queue:
@@ -2006,7 +1999,6 @@ static int __init nvmet_init(void)
 static void __exit nvmet_exit(void)
 {
 	nvmet_exit_configfs();
-	nvmet_exit_discovery();
 	nvmet_exit_debugfs();
 	ida_destroy(&cntlid_ida);
 	destroy_workqueue(nvmet_aen_wq);
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 114869d16a1f3ce8740a2126a2cb491ec8007ed7..4a0e5929125ece4c98bf25918ce82b66d4140228 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -8,9 +8,44 @@
 #include <generated/utsrelease.h>
 #include "nvmet.h"
 
-struct nvmet_subsys *nvmet_disc_subsys;
+static DEFINE_XARRAY(nvmet_disc_xa);
 
-static u64 nvmet_genctr;
+struct nvmet_subsys *nvmet_get_disc_subsys(struct net *net_ns)
+{
+	struct nvmet_subsys *subsys;
+	u64 ns_id = nvmet_get_ns_id(net_ns);
+
+	subsys = xa_load(&nvmet_disc_xa, ns_id);
+	return subsys;
+}
+
+int nvmet_add_disc_subsys(struct net *net_ns)
+{
+	struct nvmet_subsys *disc_subsys;
+	u64 ns_id = nvmet_get_ns_id(net_ns);
+	int err;
+
+	disc_subsys = nvmet_subsys_alloc(NVME_DISC_SUBSYS_NAME,
+					 NVME_NQN_CURR);
+	if (IS_ERR(disc_subsys))
+		return PTR_ERR(disc_subsys);
+	err = xa_insert(&nvmet_disc_xa, ns_id,
+			disc_subsys, GFP_KERNEL);
+	if (err < 0)
+		nvmet_subsys_put(disc_subsys);
+
+	return err;
+}
+
+void nvmet_del_disc_subsys(struct net *net_ns)
+{
+	struct nvmet_subsys *disc_subsys;
+	u64 ns_id = nvmet_get_ns_id(net_ns);
+
+	disc_subsys = xa_erase(&nvmet_disc_xa, ns_id);
+	if (disc_subsys)
+		nvmet_subsys_put(disc_subsys);
+}
 
 static void __nvmet_disc_changed(struct nvmet_port *port,
 				 struct nvmet_ctrl *ctrl)
@@ -29,18 +64,22 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 			     struct nvmet_subsys *subsys)
 {
 	struct nvmet_ctrl *ctrl;
+	struct nvmet_subsys *disc_subsys;
 
 	lockdep_assert_held(&nvmet_config_sem);
-	nvmet_genctr++;
+	disc_subsys = nvmet_get_disc_subsys(&init_net);
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
@@ -52,15 +91,19 @@ static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
 					struct nvmet_host *host)
 {
 	struct nvmet_ctrl *ctrl;
+	struct nvmet_subsys *disc_subsys;
 
-	mutex_lock(&nvmet_disc_subsys->lock);
-	list_for_each_entry(ctrl, &nvmet_disc_subsys->ctrls, subsys_entry) {
+	disc_subsys = nvmet_get_disc_subsys(&init_net);
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
@@ -68,9 +111,13 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 {
 	struct nvmet_port *port;
 	struct nvmet_subsys_link *s;
+	struct nvmet_subsys *disc_subsys;
 
 	lockdep_assert_held(&nvmet_config_sem);
-	nvmet_genctr++;
+	disc_subsys = nvmet_get_disc_subsys(&init_net);
+	if (WARN_ON(!disc_subsys))
+		return;
+	disc_subsys->genctr++;
 
 	list_for_each_entry(port, nvmet_ports, global_entry)
 		list_for_each_entry(s, &port->subsystems, entry) {
@@ -173,6 +220,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	u16 status = 0;
 	void *buffer;
 	char traddr[NVMF_TRADDR_SIZE];
+	struct nvmet_subsys *disc_subsys;
 
 	if (!nvmet_check_transfer_len(req, data_len))
 		return;
@@ -207,10 +255,12 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	}
 	hdr = buffer;
 
+	disc_subsys = nvmet_get_disc_subsys(&init_net);
+
 	nvmet_set_disc_traddr(req, req->port, traddr);
 
 	nvmet_format_discovery_entry(hdr, req->port,
-				     nvmet_disc_subsys->subsysnqn,
+				     disc_subsys->subsysnqn,
 				     traddr, NVME_NQN_CURR, numrec);
 	numrec++;
 
@@ -235,7 +285,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 		numrec++;
 	}
 
-	hdr->genctr = cpu_to_le64(nvmet_genctr);
+	hdr->genctr = cpu_to_le64(disc_subsys->genctr);
 	hdr->numrec = cpu_to_le64(numrec);
 	hdr->recfmt = cpu_to_le16(0);
 
@@ -428,15 +478,3 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
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
index 3305a88684ecab5d59c53d7f975d1b0a1cb213a2..2bbee443ce7c7a13be15976c18ab003265a366cb 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -325,6 +325,9 @@ struct nvmet_subsys {
 	u16			cntlid_min;
 	u16			cntlid_max;
 
+	/* For discovery subsystems */
+	u64 genctr;
+
 	struct list_head	ctrls;
 
 	struct list_head	hosts;
@@ -696,11 +699,13 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 
 int __init nvmet_init_configfs(void);
 void __exit nvmet_exit_configfs(void);
+extern struct list_head *nvmet_get_port_list(struct net *net_ns);
 
-int __init nvmet_init_discovery(void);
-void nvmet_exit_discovery(void);
+extern u64 nvmet_get_ns_id(struct net *net_ns);
+extern int nvmet_add_disc_subsys(struct net *net_ns);
+extern void nvmet_del_disc_subsys(struct net *net_ns);
+extern struct nvmet_subsys *nvmet_get_disc_subsys(struct net *net_ns);
 
-extern struct nvmet_subsys *nvmet_disc_subsys;
 extern struct rw_semaphore nvmet_config_sem;
 
 extern u32 nvmet_ana_group_enabled[NVMET_MAX_ANAGRPS + 1];

-- 
2.51.0

