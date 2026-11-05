Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890725;
	b=FmOonlui2HGtJm11RHAE2cyY5T+Jm43JjSFHQ1VizF5hflV5J/LQTsjhX96jO6t5w8Wx
	 9mw3M9TXC9UbIC/SkeQy4dkBAxshNLBWOzGTwo4CHIEFFXwYc2bEH0n31yJmzgicHcYuj
	 7446vd9d3iOlTJT8v2MKIyE3/c//IoGt3ouUCwbl6s90RVoiclH6eyH4DpkWn1ZSO44Os
	 EfimQ05qJfuF6pquYU/eJPV5tNJv7AnF1IMftnpNC0quOBVN7PUxnFlJGlTQ7Sm7n2R6A
	 PuB9cGEUETLVxP2RQ59yz+I3bLudljuolJgwBD8TM+TzfW1GBxhVLqvXzCb1KoxJLng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=buOTmB6dMBkT+g+e+VlChs8aFr20egJQvSL81OYURcg=;
	b=28KUSGptuYD25DJcf0OR6H/YgR9/f/I6JJFA/6I7CPnVKPWMrmYBjWhMTu8ixdZejCfq
	 gfUG2x8DYOegn9+r3JboFTzVT9rLDn4WpF9h6zrFqehgETsUr28sl39RiMPkDigMtSQ6A
	 UrH7Rl6Tcdtwx++197uvXr35Bc3E3ueFM2U3biDYvRYETlqP37vWaSsvDjv8WypatJ+PJ
	 +25sYfxw4JQP+NqDlHwYFco0JHcmMQSy0AdJ06rI38h6hxEc/sY5a5jSFq/bq6K4mANyD
	 DskT9zWskvfEnmJdMGgYVGmIrjYW2OfCicRHTRPypeMMv1uqpcpX18gkFKlEGXGs5hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=erkvnXUk;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA966082BD5
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 14:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA966082BD5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=erkvnXUk
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-843b6f8e2c7so2154593a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 06:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793890723; x=1794495523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=buOTmB6dMBkT+g+e+VlChs8aFr20egJQvSL81OYURcg=;
        b=erkvnXUkm8aB2WnNzJftRRZ+DY3KmyWhLQBiAKN1H+E+7MIfMDO4BygWkJitjRi0tL
         cnfkpd94djLeGz3mN70uZ33o0JmOLYklG8e0TwPcNsQIg1NYFGGAd6JWlVqIzAUeDcQ3
         pqqu34NBupkb5GpKm+UgO0gjR+83usYZ9gGULpRsYk/wa2s0m5nkhcjWf0DQavjoiuN/
         cy8XmZPnhKkPTlZecESnfgTDBgXPR+j69xMEHk4m68csit0fOUcImvWWIFIXKMC1oET2
         Xz2T13iY/behXTjKiAUgT6D1d+pxgcdhOBk96ojdwKohdM2q1JuItqbnKUj7JVvTvI1e
         OGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890723; x=1794495523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=buOTmB6dMBkT+g+e+VlChs8aFr20egJQvSL81OYURcg=;
        b=uw4fFmCL4KQsNjjQ8OG+QZnMIv67MTcq38K/3vAzI3Dr2S78eBtJlftnkERNShVDFe
         COwF5jl3ngQT24DM5hAjqwURrNyECe9CeWLu8jToaRUHVwyyyMEsWYbiAc3dfa0VyfJW
         cQASgeEL3fcK6MZwOTGFaXpM3/Zz6gbwDNrRErnn4INZTbZ8lUvBf9b1DmlfOzTQ64xU
         J9DUqp9IfSUp4eOfA9bV1fRnE7QKwNh4YF+tEt3u6JODX8AVP7JuWf52DFYUc2WXhXsz
         NYKS+HjvHCZDxqIwWZYTBYduYJK0MGWPHeE1ThaSC90whDoctlHMiekR6ltoPqYPTDqC
         jdoA==
X-Gm-Message-State: APuU4Z+5umQDdC65W8AFGqFH3/UNFxpe91oowFbVk1t3lGMm6nUDjd8P
	pnS4NZ9AznoWtGOHCHEFoAMyyqV9MfeqElozLNvT29qDp0syOo90VvmcXaHW5wTmiyrY8HVXhnN
	Eh4r6w8E=
X-Gm-Gg: AYBFou1ZFBOG5u6r0lES0dk9D9DutEdyEdM2ojvj6ofyB8IdU5B8Rz6Lepg2Ui410QS
	HLDX+GSohGhhjdn2fNajv/kNGWhRTVCBvhu+GLPldyiGsBDAOd5/Srns/sGIgSaAiVnIa0rh+YX
	lXl6fXsmGqYZnVrSAwR+X+SZ1WtaX+ifzPlPSqPoDlHFF/CINDCnVOnpTBFCCanspEpyloSnbvo
	cmLgRrCcKvROL5Av9WOo+lnmyRLHZ+aEJi3b6ziziVBhzk3J1wYovMdIPSMMsW0PDqeWXNWtw4P
	x4rDdOVYMbBcHtwy4/XO0NSK3WifOIyn/Qzfn3DlefR3JoTphNM5tGmt0S27GDx8FqVrfnurqdu
	y5eOXJDeFa41guvUYMbsnwQ9FViozBisH75gpGXSFVDqlHgwRal8Fh/sJQmMB+JKTef6JM8WD7H
	fYEYs86ym5/L4Jy/WlwjGk8NX2kAhiB9PBVMUy2uQFAeO5iKv7s5d978EJdd1nbpn1Ot9vOpYhi
	prCnerSYLlqRv0BICGacn+5kGenyY3lQSxNZoJQnzGTr6ABToZShGsZMTvtz9Y67OSgoBIZmeyX
	fcneqoptj8IVG3PJfrdKBDnHGVtGtFxfS7sr0NYgGMIeTw==
X-Received: by 2002:a05:6830:25d6:b0:829:9992:20e7 with SMTP id 46e09a7af769-85d366454f8mr16577501a34.30.1793890723347;
        Thu, 05 Nov 2026 06:58:43 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e603b9sm4639148a34.20.2026.11.05.06.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:58:42 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 14:57:14 +0000
Subject: [PATCH RFC v3 23/90] nsproxy: build the nsproxy the tasks of a
 cell share
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-23-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890670; l=4299;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=0xMERCPZyIg8/DpTITYMjSEaKK9pIKI3JZmJ5dj+u00=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCAXUMNK5XT1BglVpSfYJxXcdL2YqKiUKoGCbB+p1RuwNLSINsd+5TtlA8aIZenFz5CtnZ5Gt3s
 UK/ZuPhPFrQ0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The namespaces of a cell are a property of the cell, not of its tasks. A
task of a cell can call neither unshare() nor setns(). So a single
nsproxy, created when the cell is sealed, can serve every task that the
cell will ever have.

Add cell_create_nsproxy(), which builds that nsproxy from the namespaces
in the slots of the cell. The uts and ipc namespaces are always new.
Objects in a shared ipc namespace would be owned by ids of the cell and
could outlive the cell. The time namespace is that of the builder.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/nsproxy.h |  9 +++++++
 kernel/nsproxy.c        | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index dc2447f5f092..02101d96e4dd 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -12,6 +12,9 @@ struct ipc_namespace;
 struct pid_namespace;
 struct cgroup_namespace;
 struct fs_struct;
+struct cell;
+struct net;
+struct user_namespace;
 
 /*
  * A structure to contain pointers to all per-process
@@ -101,6 +104,12 @@ void switch_task_namespaces(struct task_struct *tsk, struct nsproxy *new);
 int exec_task_namespaces(void);
 void deactivate_nsproxy(struct nsproxy *ns);
 void nsproxy_free(struct nsproxy *ns);
+struct nsproxy *cell_create_nsproxy(struct user_namespace *user_ns,
+				    struct mnt_namespace *mnt_ns,
+				    struct pid_namespace *pid_ns,
+				    struct net *net,
+				    struct cgroup_namespace *cgroup_ns,
+				    const char *hostname);
 int unshare_nsproxy_namespaces(unsigned long, struct nsproxy **,
 	struct cred *, struct fs_struct *);
 int __init nsproxy_cache_init(void);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 2dcf105e8ee2..bfdd392f4007 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -28,6 +28,7 @@
 #include <linux/cgroup.h>
 #include <linux/perf_event.h>
 #include <linux/nstree.h>
+#include <linux/cell.h>
 
 static struct kmem_cache *nsproxy_cachep;
 
@@ -242,6 +243,72 @@ int unshare_nsproxy_namespaces(unsigned long unshare_flags,
 	return err;
 }
 
+#ifdef CONFIG_CELLS
+/**
+ * cell_create_nsproxy - make the nsproxy every task of a cell shares
+ * @user_ns:   the user namespace of the cell
+ * @mnt_ns:    its mount namespace
+ * @pid_ns:    its pid namespace
+ * @net:       its network namespace
+ * @cgroup_ns: its cgroup namespace
+ * @hostname:  its hostname
+ *
+ * The nsproxy never changes: a task of a cell can neither unshare() nor
+ * setns(). It takes its own references. The uts and ipc namespaces are always
+ * fresh, the time namespace is the caller's.
+ *
+ * Return: the nsproxy, active and with a reference for put_nsproxy(), or an
+ * ERR_PTR().
+ */
+struct nsproxy *cell_create_nsproxy(struct user_namespace *user_ns,
+				    struct mnt_namespace *mnt_ns,
+				    struct pid_namespace *pid_ns,
+				    struct net *net,
+				    struct cgroup_namespace *cgroup_ns,
+				    const char *hostname)
+{
+	struct nsproxy *cur = current->nsproxy;
+	struct nsproxy *nsp;
+	int err;
+
+	nsp = create_nsproxy();
+	if (!nsp)
+		return ERR_PTR(-ENOMEM);
+
+	nsp->uts_ns = copy_utsname(CLONE_NEWUTS, user_ns, cur->uts_ns);
+	if (IS_ERR(nsp->uts_ns)) {
+		err = PTR_ERR(nsp->uts_ns);
+		goto out_free;
+	}
+	/* Nobody else can see it yet. */
+	strscpy_pad(nsp->uts_ns->name.nodename, hostname);
+	strscpy_pad(nsp->uts_ns->name.domainname, "(none)");
+
+	nsp->ipc_ns = copy_ipcs(CLONE_NEWIPC, user_ns, cur->ipc_ns);
+	if (IS_ERR(nsp->ipc_ns)) {
+		err = PTR_ERR(nsp->ipc_ns);
+		goto out_uts;
+	}
+
+	nsp->mnt_ns = mnt_ns_get_from_common(from_mnt_ns(mnt_ns));
+	nsp->pid_ns_for_children = get_pid_ns(pid_ns);
+	nsp->net_ns = get_net(net);
+	get_cgroup_ns(cgroup_ns);
+	nsp->cgroup_ns = cgroup_ns;
+	nsp->time_ns = get_time_ns(cur->time_ns);
+	nsp->time_ns_for_children = get_time_ns(cur->time_ns);
+
+	nsproxy_ns_active_get(nsp);
+	return nsp;
+
+out_uts:
+	put_uts_ns(nsp->uts_ns);
+out_free:
+	kmem_cache_free(nsproxy_cachep, nsp);
+	return ERR_PTR(err);
+}
+#endif
+
 void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
 {
 	struct nsproxy *ns;

-- 
2.55.0

