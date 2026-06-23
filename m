Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2843CFF7E;
	Tue, 23 Jun 2026 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206192; cv=none; b=csm7k5CPVs8nT7PZdaBz+nx/wvjAOZwqO41/TCTrABj7a8+XG9qqOV/LNCocpbR8NjXByaLDyVbP5n8krgjNM5GaN4PAPoIEvUZnWiIN7nY/jDcZFdDqNL5OjMyVDjO5RdzmKIs6Wi1zrlqoeAaNdxjOl8u6cljjfncUV/p4xDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206192; c=relaxed/simple;
	bh=uvgO9J0kRBEdlIvePY51gBGsA4oKrRf/x6gtH90OfBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bM9qH4xRXw32YdJvgXi0CAqWDOdhyUlB7C2Rji4u8Ps29k9sSAtpvE0S3QI2cvNEn1BsDMAYXcni/muFSAMzSK2nmZt1k4sYNRtiwokxUho+GZ14Jf2yGcE+0hEPsKAQjHO+LMO4HWFIqZ7gM7djsBQVpTTbV3axm3DnjaUn0E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXfoiuXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXfoiuXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9291F00A3E;
	Tue, 23 Jun 2026 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206190;
	bh=eE0Kb2w+6TP2MJUhKYKFbGVe4J6OnReBbcpkFT2KzTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fXfoiuXbnNficJZq96Rx9TS94Uqc6RsQQAmq7+e77bCuZkdLea4sbu9sqAN4FAZ08
	 QIOvsHiA4iahPM5Z4j760y9aHiJ34fvvoxiyGl8yYdoktEqlqDGMiWqno2fuX9Ogzh
	 RCI4ysV0sSaysQk7VAubLXjxaI7V7M8W4Yd0WY6n2WDQmAa/OPNOQXNBfEpZ2QWySl
	 yMVpqsxV88tyYM11YEQ/efcyWydGkaZCcJ+xGdPZwevon5oCHvvmyOHpJl0W9zbqL/
	 T5AHGxz4YI6dc3hEKIitUAizIY+/QXx1bMXGV24+CAAEX8bEzqfWyF9pgaUbEpsen9
	 wsrHUsATT79vQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Tue, 23 Jun 2026 11:15:55 +0200
Subject: [PATCH RFC v3 10/12] nvmet: per net-namespace port list
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-configfs-ns-v3-10-841c100fd5dd@kernel.org>
References: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
In-Reply-To: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=4715;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=uvgO9J0kRBEdlIvePY51gBGsA4oKrRf/x6gtH90OfBw=;
 b=HHlkFBtGeyWnXdFNQttCCC2liWT1T9MGnC/BzWdSa2mwJj/ek7QSmlJSZ39FKdSmUS1h8SkQe
 0enSo7kjaHVDDN+X11YwldX/1FZ5jKrxhCE+GQ1OUawO7Aa8wcnH8VK
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

The port list needs to be per net-namespace, as each network namespace
has a different view on the existing IP addresses etc.
So replace the global list with an xarray of lists indexed by the
network namespace id.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/configfs.c  | 61 ++++++++++++++++++++++++++++++++++++++---
 drivers/nvme/target/discovery.c |  4 ++-
 drivers/nvme/target/nvmet.h     |  1 -
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 6030647cee937195d772bcf4b92cb37b6ebf9f08..9c761a7f98496d59aa993e3663f0b3da63b6d3c1 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -25,8 +25,7 @@
 static const struct config_item_type nvmet_host_type;
 static const struct config_item_type nvmet_subsys_type;
 
-static LIST_HEAD(nvmet_ports_list);
-struct list_head *nvmet_ports = &nvmet_ports_list;
+static DEFINE_XARRAY(nvmet_ports_xa);
 
 struct nvmet_type_name_map {
 	u8		type;
@@ -61,6 +60,60 @@ u64 nvmet_get_ns_id(struct net *net_ns)
 	return net_ns == &init_net ? 0 : ns->ns_id;
 }
 
+struct list_head *nvmet_get_port_list(struct net *net_ns)
+{
+	struct list_head *port_list;
+	u64 ns_id = nvmet_get_ns_id(net_ns);
+
+	port_list = xa_load(&nvmet_ports_xa, ns_id);
+	return port_list;
+}
+
+static int nvmet_add_port_list(struct nvmet_port *p)
+{
+	u64 ns_id = nvmet_get_ns_id(&init_net);
+	struct list_head *port_list;
+	int err = 0;
+
+	xa_lock(&nvmet_ports_xa);
+	port_list = xa_load(&nvmet_ports_xa, ns_id);
+	if (!port_list) {
+		port_list = kzalloc_obj(*port_list);
+		if (!port_list) {
+			err = -ENOMEM;
+			goto out_unlock;
+		}
+		INIT_LIST_HEAD(port_list);
+		err = __xa_insert(&nvmet_ports_xa, ns_id,
+				  port_list, GFP_KERNEL);
+		if (err < 0) {
+			kfree(port_list);
+			goto out_unlock;
+		}
+	}
+	list_add(&p->global_entry, port_list);
+out_unlock:
+	xa_unlock(&nvmet_ports_xa);
+	return err;
+}
+
+static void nvmet_del_port_list(struct nvmet_port *p)
+{
+	struct list_head *port_list;
+	u64 ns_id = nvmet_get_ns_id(&init_net);
+
+	xa_lock(&nvmet_ports_xa);
+	port_list = xa_load(&nvmet_ports_xa, ns_id);
+	if (!WARN_ON(!port_list)) {
+		list_del_init(&p->global_entry);
+		if (list_empty(port_list)) {
+			__xa_erase(&nvmet_ports_xa, ns_id);
+			kfree(port_list);
+		}
+	}
+	xa_unlock(&nvmet_ports_xa);
+}
+
 static bool nvmet_is_port_enabled(struct nvmet_port *p, const char *caller)
 {
 	if (p->enabled)
@@ -2017,7 +2070,7 @@ static void nvmet_port_release(struct config_item *item)
 
 	/* Let inflight controllers teardown complete */
 	flush_workqueue(nvmet_wq);
-	list_del(&port->global_entry);
+	nvmet_del_port_list(port);
 
 	key_put(port->keyring);
 	kfree(port->ana_state);
@@ -2085,7 +2138,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 			port->ana_state[i] = NVME_ANA_INACCESSIBLE;
 	}
 
-	list_add(&port->global_entry, &nvmet_ports_list);
+	nvmet_add_port_list(port);
 
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 4a0e5929125ece4c98bf25918ce82b66d4140228..e929402314f66b635e330980d4d771b9474e7e3d 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -111,6 +111,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 {
 	struct nvmet_port *port;
 	struct nvmet_subsys_link *s;
+	struct list_head *port_list;
 	struct nvmet_subsys *disc_subsys;
 
 	lockdep_assert_held(&nvmet_config_sem);
@@ -119,7 +120,8 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 		return;
 	disc_subsys->genctr++;
 
-	list_for_each_entry(port, nvmet_ports, global_entry)
+	port_list = nvmet_get_port_list(&init_net);
+	list_for_each_entry(port, port_list, global_entry)
 		list_for_each_entry(s, &port->subsystems, entry) {
 			if (s->subsys != subsys)
 				continue;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2bbee443ce7c7a13be15976c18ab003265a366cb..fc871b2b777d633dd64b6d339e124668fd760f8b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -665,7 +665,6 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len);
 u32 nvmet_get_log_page_len(struct nvme_command *cmd);
 u64 nvmet_get_log_page_offset(struct nvme_command *cmd);
 
-extern struct list_head *nvmet_ports;
 void nvmet_port_disc_changed(struct nvmet_port *port,
 		struct nvmet_subsys *subsys);
 void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,

-- 
2.51.0

