Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205531;
	b=jySafsh5kGAPIUEx88P65CYPs0A/YTfm8pZQ0ejqE6TUs4mp7HUpwzEzSU6McqouK0jy
	 KhGvid4/n6eaJnOuT/Zqo5ZbRQyANIg4x8qsmTZekGhyO5QWlzjLkme50YxX45YqRJyaL
	 M0PqEhVj0bO92NEA3U4gLSgD16WPP5YpoVXZGUFLuLFzePY/V0C9YrdcMRLUPXdopEZMV
	 2PFMYg70AnF/AwlzbNyrNT5KsYsVkGJRZdqsXT8ihat9Ttqt9McWw83Jkc13n+xV26sFV
	 N4v6+Q8qmUNIktY41DPeCU15atKmJfL4/Ww7YYwovGLXZYlPlYODNjcvqDHAPIEIyNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205531;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ifR0qDy/iaxXGXvQm3zB7TkCmfvzruM7DFYN/9xaScM=;
	b=le+g6uSf5eG5m3/LTff+kOJlGOfOiQmrqPC9p5JGzof5j/hYRZ9RBMT3GI+9gTDvdNnD
	 R5NQo60ONhFfs61+3910jiqU+Era0tltEeatNDnfZ/R07FdcReoKTylFGPz0xyYAsITgW
	 7kDw/MWwmSnff21aVWYAGk+/yDEiKWvW5dbmNzLejusGHdVZ5BsSreRNg0WvaZmjfCaMr
	 0Hy4FVnHN0fTfUAA1YNAocKydiDDHczLVjeZAgTdbzsrKhXQH26EKHhI/1sqKiIG04Hg4
	 WPGRPqRNBTbHV3k7NhxyTGBO9R20ypTk1Bq/Qyi2+zVoQnQZGh+svjXQWUgQDWFWqTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nKfJXe8w;
	arc=none smtp.remote-ip=91.218.175.87
Received: from mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB957606B2AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB957606B2AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nKfJXe8w
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kpn3x0ZLcIzl4sHYfMb536xhUwwO2lJCcQ17NPADT+w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205529; v=1; x=1793810329;
 b=nKfJXe8wQ6N3w7OmyuMTi0wf549hs6VrCS7HhamhGcrWPXu3Z4GNVNhXjiAyLcjpEUTES6+O
 yAvPp4i1xNN8EX5hDJ6aCFRSkOV2w/VgIOlBXbR+wem/fhHZyNyVazuYpLMTU4nH0R+zPnJJoYa
 Xu/qJH79DWNuGfb0qGeh+mnA=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 8d7449e846000ce6;
	Wed, 28 Oct 2026 16:38:49 +0000
X-Mizu-Trace-ID: 8d7449e846000ce6
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 35/39] netfilter: move logger sysctl context to priv
Date: Thu, 29 Oct 2026 00:35:14 +0800
Message-Id: <f757d99eb27472d43fb503c4b3e9fa2b1dc76fa1.1793204511.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
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

nf_log keeps the netns in extra2 and encodes the protocol family into
extra1 as an integer cast to a pointer. Both share the fields that hold
numeric bounds elsewhere, and the family encoding is a type error
waiting to happen.

Carry {net, family} in priv, leave data NULL, and keep maxlen as the
proc_dostring() name length. The family becomes a real field.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/netfilter/nf_log.c | 67 ++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index f1d3649e3fc6..8163774ad4d4 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -420,8 +420,18 @@ static const struct seq_operations nflog_seq_ops = {
 #endif /* PROC_FS */
 
 #ifdef CONFIG_SYSCTL
+struct nf_log_sysctl_context {
+	struct net *net;
+	unsigned int family;
+};
+
+struct nf_log_sysctl_table {
+	struct ctl_table vars[NFPROTO_NUMPROTO];
+	struct nf_log_sysctl_context context[NFPROTO_NUMPROTO];
+};
+
 static char nf_log_sysctl_fnames[NFPROTO_NUMPROTO-NFPROTO_UNSPEC][3];
-static struct ctl_table nf_log_sysctl_table[NFPROTO_NUMPROTO];
+static struct nf_log_sysctl_table nf_log_sysctl_table;
 static struct ctl_table_header *nf_log_sysctl_fhdr;
 
 static struct ctl_table nf_log_sysctl_ftable[] = {
@@ -440,8 +450,9 @@ static int nf_log_proc_dostring(const struct ctl_table *table, int write,
 	const struct nf_logger *logger;
 	char buf[NFLOGGER_NAME_LEN];
 	int r = 0;
-	int tindex = (unsigned long)table->extra1;
-	struct net *net = table->extra2;
+	const struct nf_log_sysctl_context *ctx = table->priv;
+	unsigned int tindex = ctx->family;
+	struct net *net = ctx->net;
 
 	if (write) {
 		struct ctl_table tmp = *table;
@@ -451,6 +462,7 @@ static int nf_log_proc_dostring(const struct ctl_table *table, int write,
 		 */
 		buf[0] = '\0';
 		tmp.data = buf;
+		tmp.maxlen = sizeof(buf);
 		r = proc_dostring(&tmp, write, buffer, lenp, ppos);
 		if (r)
 			return r;
@@ -471,6 +483,7 @@ static int nf_log_proc_dostring(const struct ctl_table *table, int write,
 		struct ctl_table tmp = *table;
 
 		tmp.data = buf;
+		tmp.maxlen = sizeof(buf);
 		mutex_lock(&nf_log_mutex);
 		logger = nft_log_dereference(net->nf.nf_loggers[tindex]);
 		if (!logger)
@@ -486,42 +499,38 @@ static int nf_log_proc_dostring(const struct ctl_table *table, int write,
 
 static int netfilter_log_sysctl_init(struct net *net)
 {
+	struct nf_log_sysctl_table *t = &nf_log_sysctl_table;
 	int i;
-	struct ctl_table *table;
 
-	table = nf_log_sysctl_table;
 	if (!net_eq(net, &init_net)) {
-		table = kmemdup(nf_log_sysctl_table,
-				 sizeof(nf_log_sysctl_table),
-				 GFP_KERNEL_ACCOUNT);
-		if (!table)
-			goto err_alloc;
+		t = kmemdup(t, sizeof(*t), GFP_KERNEL_ACCOUNT);
+		if (!t)
+			return -ENOMEM;
 	} else {
 		for (i = NFPROTO_UNSPEC; i < NFPROTO_NUMPROTO; i++) {
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
+			snprintf(nf_log_sysctl_fnames[i], 3, "%d", i);
+			t->vars[i].procname = nf_log_sysctl_fnames[i];
+			t->vars[i].maxlen = NFLOGGER_NAME_LEN;
+			t->vars[i].mode = 0644;
+			t->vars[i].proc_handler = nf_log_proc_dostring;
 		}
 		nf_log_sysctl_fhdr = register_net_sysctl(net, "net/netfilter",
 							 nf_log_sysctl_ftable);
 		if (!nf_log_sysctl_fhdr)
-			goto err_freg;
+			return -ENOMEM;
 	}
 
-	for (i = NFPROTO_UNSPEC; i < NFPROTO_NUMPROTO; i++)
-		table[i].extra2 = net;
+	for (i = NFPROTO_UNSPEC; i < NFPROTO_NUMPROTO; i++) {
+		t->context[i].net = net;
+		t->context[i].family = i;
+		t->vars[i].data = NULL;
+		t->vars[i].priv = &t->context[i];
+	}
 
 	net->nf.nf_log_dir_header = register_net_sysctl_sz(net,
 							   "net/netfilter/nf_log",
-							   table,
-							   ARRAY_SIZE(nf_log_sysctl_table));
+							   t->vars,
+							   ARRAY_SIZE(t->vars));
 	if (!net->nf.nf_log_dir_header)
 		goto err_reg;
 
@@ -529,22 +538,22 @@ static int netfilter_log_sysctl_init(struct net *net)
 
 err_reg:
 	if (!net_eq(net, &init_net))
-		kfree(table);
+		kfree(t);
 	else
 		unregister_net_sysctl_table(nf_log_sysctl_fhdr);
-err_freg:
-err_alloc:
 	return -ENOMEM;
 }
 
 static void netfilter_log_sysctl_exit(struct net *net)
 {
 	const struct ctl_table *table;
+	const struct nf_log_sysctl_table *t;
 
 	table = net->nf.nf_log_dir_header->ctl_table_arg;
+	t = container_of(table, struct nf_log_sysctl_table, vars[0]);
 	unregister_net_sysctl_table(net->nf.nf_log_dir_header);
 	if (!net_eq(net, &init_net))
-		kfree(table);
+		kfree(t);
 	else
 		unregister_net_sysctl_table(nf_log_sysctl_fhdr);
 }
-- 
2.25.1

