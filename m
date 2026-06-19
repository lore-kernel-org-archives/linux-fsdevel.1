Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BBF35E922;
	Fri, 19 Jun 2026 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858248; cv=none; b=fUo0c3NWjqz0zSEG3ExbUdIdRGvMAp14dhOMKVxYX9wop8KO5lMXZdwnIXAQWoYbkjI8JDo20T/tlV/TTMpmeIdV4PdfEmHo0FgEK9JD+lG0iRqanOKtLicKA/d4xmljdO6f8KKQMiGnmGs9UsI/bd32w7taIqqlKgUQ8nW0lgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858248; c=relaxed/simple;
	bh=uvgO9J0kRBEdlIvePY51gBGsA4oKrRf/x6gtH90OfBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbXpbAbbLTIpXcrJNqVMyMu7bE1ne1Y/7HWucpt1Lw9g8F+tlRKpoh/ehPjtsd6jePnfMnqZT+DiziLCM1A7Ki97UD3r7XSAA6/ndAtKCwSnqxFwIocNSYKBMt5hj93QNbdfH4tLXdNCN8aVSvQiA6qvKALfR3l7jcFwsbWIlOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I68k/+E+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I68k/+E+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D0A1F00A3A;
	Fri, 19 Jun 2026 08:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781858247;
	bh=eE0Kb2w+6TP2MJUhKYKFbGVe4J6OnReBbcpkFT2KzTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I68k/+E+NKPMYIt7CKtJKN8WU90kBUQShgooRdvAuJ4iB149yoyidKZCLBwh7OeHP
	 z6yJmYYqUwS3kHyaVKHVnw7MV1TY3UvLSsQkqqOboJChbdMUop8HO5gO+SEglR+P6/
	 v+UUnRkTCyFF/tPtGFSUMOcO2AItPbPzWrw0WsW4AccvxvQ+3cSeR+e9JabvzMIiM7
	 4g6rKipeKSHUarOrMgVU79sWY1I9ZEpM0baTYP8V4Iu0rSHu6/32DLs1xk5FZuT4qe
	 aVAnOLMdMUMYoayI21zgElhk2VAQYW/aNxuAtFLQbQFutKgZmAQ1qYQBt5g99AD6VH
	 r5AGePypn0HOw==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 19 Jun 2026 10:36:51 +0200
Subject: [PATCH RFC v2 11/12] nvmet: per net-namespace port list
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-configfs-ns-v2-11-82fd7094b8dc@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781858211; l=4715;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=uvgO9J0kRBEdlIvePY51gBGsA4oKrRf/x6gtH90OfBw=;
 b=o1tCBsOS6qkL2O2NIrCYf1zzygh8spNzDXhqXvgDt0IsZwXWQRxmd1ZwINUy7Ar2IDgIpZiRp
 tDV5EtpKjnmCxxVV+nw7wip3P0nRyKeuxsOY9AUqMsSTElmm9ugMP5D
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

