Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845287;
	b=04c2/fdVPHv7ITE4qfS7aNAM1CxpEO/KR91fSFlv1d3zI0eOUcgF5WuvkCfWgzL3eHPD
	 qa+RXbuCnYNxdTKfdn+DimamexIkGjngUX4KeaYgqWmkKaLRohzlBP6kjyPCMcPbCQWiO
	 3QErRDiJWoQNzdt63U3w9NWWdHyD0RtUlQ2c/QBRtohmt6C6kp+0JHMgk9gbWMvUBrrl5
	 18RRil1sgQtcag8KCoMTbKtt4DAaGe9pf+HYBFSUzhH4+dDR5O/JYnvo2N5dBHNsLTUX0
	 4YBCZwgpbjVeEuX5ujVoI8nhVpgggzRkb3U+j/w0DcPAzfS7DlxxHdVrSIb7bhQrgXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845287;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cY1ptpdpzY6d6M5zd2byaVzfqVSf/rcUaqIp+fd/WNo=;
	b=wEHk1d9QMrhEMVsBlS7Yi8dwOeX1mahTn19vIOoOv3LWzWkn4P7VDYg8tY+uZjj3fyuP
	 c6GDPkOY/CtbZuw5m75rsPQ58u8TCd0IQjesrT7NG6WlpFVLXdpuK5+6bIE+dEYn+NWAv
	 SsDeW/B3wBPd0ciQ7ISf+YSDrJ+VJJkwqfOXa7mzYOEI/N4i2wLAfQO3Yli+mRjhuprd6
	 6nlbmIkvgBYY+5hFNY1FEUBUtNvYQmHMd0iKP1laVGj2ZxoVzgbJ2qLttlGDmrE0iMJSc
	 1GCoGSd/4PT+PZmkDUQStiRWqaHs1dy599phvy33c0nK2wULaPt7tHy2cE9eiix89tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nbgbT35W;
	arc=none smtp.remote-ip=95.215.58.175
Received: from mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB3606A329
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 16:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07DB3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nbgbT35W
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vVQv2yC0CMO6Wl5J4Bf/X9x3LY4+beyCytjVwD/G5M4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794845285; v=1; x=1795450085;
 b=nbgbT35W4M2gAw0MehN8oXboBHOgRQsHuvT2lhRDaiFDbHdX5wz0xs54mk3XiH9c3mq3+GS0
 xy4sQYYnmJRONLUDl9PmsqXrU2bUUfsydhxdzFmfPy0+O8jIV31ZcTsnAU7knz6TXRU4vXJMikW
 3j7wKvLZ+Rr9DLqkUmrHIYyI=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id e41334e2048b9b68;
	Mon, 16 Nov 2026 16:08:04 +0000
X-Mizu-Trace-ID: e41334e2048b9b68
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Kees Cook <kees@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/5] netfilter: embed logger sysctl context using stride
Date: Tue, 17 Nov 2026 00:07:35 +0800
Message-Id: <796f4b6532668a124365c0fabf39af53405f3236.1794844686.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1794844686.git.wen.yang@linux.dev>
References: <cover.1794844686.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Embed struct ctl_table into struct nf_log_sysctl_entry along with
per-entry net and pf context, and register the array with
register_net_sysctl_stride().

In the proc_handler nf_log_proc_dostring(), recover the entry using
standard container_of(table, struct nf_log_sysctl_entry, ctl).  This
eliminates the need for 11 per-family wrapper functions while keeping
struct ctl_table free of a priv field.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/netfilter/nf_log.c | 84 +++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index f1d3649e3fc6..c8cbbadc50ba 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -420,8 +420,13 @@ static const struct seq_operations nflog_seq_ops = {
 #endif /* PROC_FS */
 
 #ifdef CONFIG_SYSCTL
+struct nf_log_sysctl_entry {
+	struct ctl_table ctl;
+	struct net *net;
+	int pf;
+};
+
 static char nf_log_sysctl_fnames[NFPROTO_NUMPROTO-NFPROTO_UNSPEC][3];
-static struct ctl_table nf_log_sysctl_table[NFPROTO_NUMPROTO];
 static struct ctl_table_header *nf_log_sysctl_fhdr;
 
 static struct ctl_table nf_log_sysctl_ftable[] = {
@@ -437,11 +442,13 @@ static struct ctl_table nf_log_sysctl_ftable[] = {
 static int nf_log_proc_dostring(const struct ctl_table *table, int write,
 			 void *buffer, size_t *lenp, loff_t *ppos)
 {
+	const struct nf_log_sysctl_entry *entry =
+		container_of(table, struct nf_log_sysctl_entry, ctl);
 	const struct nf_logger *logger;
 	char buf[NFLOGGER_NAME_LEN];
 	int r = 0;
-	int tindex = (unsigned long)table->extra1;
-	struct net *net = table->extra2;
+	int tindex = entry->pf;
+	struct net *net = entry->net;
 
 	if (write) {
 		struct ctl_table tmp = *table;
@@ -486,66 +493,59 @@ static int nf_log_proc_dostring(const struct ctl_table *table, int write,
 
 static int netfilter_log_sysctl_init(struct net *net)
 {
+	struct nf_log_sysctl_entry *entries;
 	int i;
-	struct ctl_table *table;
-
-	table = nf_log_sysctl_table;
-	if (!net_eq(net, &init_net)) {
-		table = kmemdup(nf_log_sysctl_table,
-				 sizeof(nf_log_sysctl_table),
-				 GFP_KERNEL_ACCOUNT);
-		if (!table)
-			goto err_alloc;
-	} else {
-		for (i = NFPROTO_UNSPEC; i < NFPROTO_NUMPROTO; i++) {
-			snprintf(nf_log_sysctl_fnames[i],
-				 3, "%d", i);
-			nf_log_sysctl_table[i].procname	=
-				nf_log_sysctl_fnames[i];
-			nf_log_sysctl_table[i].maxlen = NFLOGGER_NAME_LEN;
-			nf_log_sysctl_table[i].mode = 0644;
-			nf_log_sysctl_table[i].proc_handler =
-				nf_log_proc_dostring;
-			nf_log_sysctl_table[i].extra1 =
-				(void *)(unsigned long) i;
-		}
+
+	entries = kzalloc(sizeof(*entries) * NFPROTO_NUMPROTO, GFP_KERNEL_ACCOUNT);
+	if (!entries)
+		return -ENOMEM;
+
+	for (i = NFPROTO_UNSPEC; i < NFPROTO_NUMPROTO; i++) {
+		snprintf(nf_log_sysctl_fnames[i], 3, "%d", i);
+		entries[i].ctl.procname = nf_log_sysctl_fnames[i];
+		entries[i].ctl.maxlen = NFLOGGER_NAME_LEN;
+		entries[i].ctl.mode = 0644;
+		entries[i].ctl.proc_handler = nf_log_proc_dostring;
+		entries[i].net = net;
+		entries[i].pf = i;
+	}
+
+	if (net_eq(net, &init_net)) {
 		nf_log_sysctl_fhdr = register_net_sysctl(net, "net/netfilter",
 							 nf_log_sysctl_ftable);
-		if (!nf_log_sysctl_fhdr)
-			goto err_freg;
+		if (!nf_log_sysctl_fhdr) {
+			kfree(entries);
+			return -ENOMEM;
+		}
 	}
 
-	for (i = NFPROTO_UNSPEC; i < NFPROTO_NUMPROTO; i++)
-		table[i].extra2 = net;
-
-	net->nf.nf_log_dir_header = register_net_sysctl_sz(net,
-							   "net/netfilter/nf_log",
-							   table,
-							   ARRAY_SIZE(nf_log_sysctl_table));
+	net->nf.nf_log_dir_header = register_net_sysctl_stride(net,
+							       "net/netfilter/nf_log",
+							       &entries[0].ctl,
+							       NFPROTO_NUMPROTO,
+							       sizeof(*entries));
 	if (!net->nf.nf_log_dir_header)
 		goto err_reg;
 
 	return 0;
 
 err_reg:
-	if (!net_eq(net, &init_net))
-		kfree(table);
-	else
+	if (net_eq(net, &init_net))
 		unregister_net_sysctl_table(nf_log_sysctl_fhdr);
-err_freg:
-err_alloc:
+	kfree(entries);
 	return -ENOMEM;
 }
 
 static void netfilter_log_sysctl_exit(struct net *net)
 {
 	const struct ctl_table *table;
+	struct nf_log_sysctl_entry *entries;
 
 	table = net->nf.nf_log_dir_header->ctl_table_arg;
+	entries = container_of(table, struct nf_log_sysctl_entry, ctl);
 	unregister_net_sysctl_table(net->nf.nf_log_dir_header);
-	if (!net_eq(net, &init_net))
-		kfree(table);
-	else
+	kfree(entries);
+	if (net_eq(net, &init_net))
 		unregister_net_sysctl_table(nf_log_sysctl_fhdr);
 }
 #else
-- 
2.25.1

