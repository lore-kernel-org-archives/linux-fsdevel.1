Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892306;
	b=aZnGcRVS7P1POsHCXkyxZE6VdJHI4IlaQeNtmPvlE3DRbeXGAbyrzZIzZJBRAi8nwwK1
	 V6fvPESKIHIwIvkYXoc14tVejP3iw2Mnz4d4w0XwfQ9bLgHSbf9Ta2M6fngMLZ1nke51G
	 TTtkXrupgQrODsfSyENrBXeA7SMgrUZCddqetEGqPda0OqpTBh44y4Z+lkSQttVtt8TDQ
	 QpHVm0HB3O42Um06cLCj9VeH8A3pbl5J9vLOchIM1sGmwn4/kws+uK+y/OGQ7QQyzZffS
	 WwCgTxKEt3cHH1/gZe+/kRK7cnKtbTJJX8hEUQ7VJaTg8V762O63Nt7yxGIdVbLllIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=nCSH+BUHXufl69korllSQg4yCYhVD/kVb/8Rq5qoQOY=;
	b=ybRHVke9NxlGpps35nLbCU0xZNlK22OnIs7gT2Z2oi+aa0BFa8hkhkxJO3/o/QifEccq
	 oX3IQZ9fhscYh7M/N3z+Y7c0TWhpzzgbb4DHRsSVUQMLPqrJtOxmwy82hL82c1SDxFuI4
	 hjkfMTYO7d3RdRAjB4O5dgPzQfpBjfAzmbYBQBB7d0Ls0Jyu38yYOcq03huE1KBlkiS+H
	 D0Rf96on5m0Bo5KGMtpX/KqA3qPDyFOYxoED0MH/nyJYkE5hFUBcGVKRkFBoHS854qNh3
	 o9BOHbWXyEx/ktdUFtk95z0bteLAhNwD9Gu7LdbqP7/zP7l/lmMzetTgMJHu6WQox8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Xlq7e5y3;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30108606D805
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30108606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Xlq7e5y3
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53653e30353so26213521cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892305; x=1794497105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nCSH+BUHXufl69korllSQg4yCYhVD/kVb/8Rq5qoQOY=;
        b=Xlq7e5y33FgelORf21wJphe1YNfYzNbtqhRD1fD9h35XnC2ymKi0z2rRYNnGgPICPQ
         EoRhKQEoWawWcw2J6NGDkwB1ms4NWnxr7Rfj+yjMhm2S8clnwZvJu+saVF0xgeb4jtev
         mUmkj3bn45qmput34TzDCplGY53u5ARki+IyfaV+rWODoRn7eWfc5x4uhkvg83dmNQZX
         LvYJqPlExN2Vxihat84I6kvrqS2b6v8J2G6R/FkaH0aKkbI77eCrCrj/sn4SGSItrj8/
         zb3Ub4nYxxEZcUJ6h3DXG/4sV5wR6IcYZ8oyE9dpmDP2Yj/h0V7jaD2DF6tdwSE6L5Tk
         D3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892305; x=1794497105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nCSH+BUHXufl69korllSQg4yCYhVD/kVb/8Rq5qoQOY=;
        b=ad1Pa3uu5Lnthf4umiH+Ff0yNkC2zwD1e4d9MBPwj+eC36bwbkNcKA8rMxB+1oKAO0
         Gkgv2zhyG+pFpgMunkl6QQOmYj0zWzxXansuVbf4BCp0T8+f9WFL0fEPpXxubTsoyf3k
         eNpEl/BDQM3uEsTvCwc+bVdJxlpjD6QBGNo7arXTUVAgYhK4+ImymtD/zGWg0f2NWv6G
         zRmuTz3k48G5/3R1q5eU9WHPlgRoC8cD7Lr+8b2CUgalL8+FQMlvhoUvY5Y81ugS+20V
         dyH18bIL+Xl6snwnb73vfqklmnZDBxz7fud2R5mBER89OMrsEmsANqL6ebYSTbHIyn/R
         DL/Q==
X-Gm-Message-State: APuU4Z/mufG/gSLPoBFJpVlW9yeNK2hh9/rSkHEUpcNIQ0zbd6XCGqBm
	KYXj/O5309jwlG2dXEb9rZu04GSnDxKmRnEbdBiHtH4U6Cs6FE59TCoAFN/PCzge4iw=
X-Gm-Gg: AYBFou3lcsfieH+H4LxfBJlqiX6y2LdWQO08RLB++VpfmD7uHWQjzr6EsWxnjeC1GYI
	6nP876rDaHxelf+oZaY3mjdOBN2z5fPKBGaeqFiPHkmr6y8UPQkBVH4QJ4T7VUDK41mh1g7OdK4
	cKT1JHkXWQA0XD6IfK3isDZvBpp//pttjkG+kFofhY/hcaKS0dG4LZT/0SiVEebAwCQPOr/uiKa
	wNrsbmiiubJGPI+7cJ8P1qgRStgnPk13Fst/uTmxZk88xangJGetYrhoeeGIb1PKLWP7DC69CwR
	zilI/BlvztVbrsRxbcO9zV9wmt3nyTDVeB1iXnOtI3GCe2GHlVMsSON4h24q2rhsBfLZdzInm1N
	K93ujZRNkkO00O0Qyo5xtkEX3qVr+PH/lbR1e0kp2B0MGuvrKvIhwg6n9AxvoPpqH11KJnLYeF7
	qtYTR/BEOHC22U5UjShRm+Je3LeHxbIzaUaki9PSVRJ5a5TQYnOQTTyt38xURP9WpNxDnWLmirZ
	me2JPkT+PJYzEKk+siso0iCEVwO/iUseN7QVWkkbYy2eJY1KAnrQD4ApcVyEfG3fFEbZ+RWTLJ4
	X9aNrJfS2jEZJe/vNv1Mhq1IqIioOOYvpgP/T9jb6okR
X-Received: by 2002:a05:622a:4ce:b0:536:93e0:4b46 with SMTP id d75a77b69052e-542b62a60d3mr318811851cf.25.1793892303844;
        Thu, 05 Nov 2026 07:25:03 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7dfb8c99sm50242586d6.11.2026.11.05.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:25:03 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:02:59 +0000
Subject: [PATCH RFC v3 67/90] af_unix: deliver ancillary data only within a
 cell
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
Message-Id: <20261105-b4-cells-v3-67-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=5713;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=34UKHpmDhuJgkiY9ttXT0mOBt7M8IYPnkWTo02k64zU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDXWL9Ra8ycAhVa29Rmlg3YacDDDMLJg+gOJMozkadsixEOJF3mJTF02eM1A6kN1bdEyX5mBM3y
 GOlMIRTDTWAA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Once a cell has started, no file descriptor and no identity should cross
its boundary. A unix socket can connect two cells, either because both can
see the directory that it is bound in, or because one end was given to a
new task. Such a socket can carry both.

Record in every skb the cell that it was sent from. The receiver gets the
files, the credentials, the pidfd and the security label only if it is in
the same cell.

This rule needs no state on the socket. So there is no marking that could
be forgotten, and no race with setsockopt(). It also covers a file that
was queued on a socket before the socket was given away.

Messages from different cells are never merged into a single read.
Otherwise the ancillary data of one message could be lost, or delivered,
because of the other.

The cell id fills skb->cb completely. Move the small members of struct
unix_skb_parms next to each other to make room.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/unix/af_unix.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 net/unix/af_unix.h | 14 ++++++++++----
 2 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 98fcfd7301f6..58fef56c0f7e 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -78,6 +78,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bpf-cgroup.h>
+#include <linux/cell.h>
 #include <linux/btf_ids.h>
 #include <linux/dcache.h>
 #include <linux/errno.h>
@@ -797,6 +798,37 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 	spin_unlock(&sk->sk_peer_lock);
 }
 
+/*
+ * Between cells a socket carries bytes and nothing else: no file, no
+ * credential, no pidfd, no label.
+ *
+ * The rule is enforced where ancillary data is received, and it keeps no state:
+ * every message says which cell it was sent from, and whoever receives it gets
+ * the ancillary data only if that is its own cell. However a socket came to
+ * span two cells, by a connect() through a tree both can see or by being given
+ * to a new task, there is nothing to forget to mark.
+ */
+#ifdef CONFIG_CELLS
+static inline void unix_skb_set_cell(struct sk_buff *skb)
+{
+	UNIXCB(skb).cell_id = current_cell_id();
+}
+
+static inline u64 unix_skb_cell(const struct sk_buff *skb)
+{
+	return UNIXCB(skb).cell_id;
+}
+
+static inline bool unix_skb_foreign(const struct sk_buff *skb)
+{
+	return unix_skb_cell(skb) != current_cell_id();
+}
+#else
+static inline void unix_skb_set_cell(struct sk_buff *skb) { }
+static inline u64 unix_skb_cell(const struct sk_buff *skb) { return 0; }
+static inline bool unix_skb_foreign(const struct sk_buff *skb) { return false; }
+#endif
+
 static bool unix_may_passcred(const struct sock *sk)
 {
 	return sk->sk_scm_credentials || sk->sk_scm_pidfd ||
@@ -1993,6 +2025,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	UNIXCB(skb).uid = scm->creds.uid;
 	UNIXCB(skb).gid = scm->creds.gid;
 	UNIXCB(skb).fp = NULL;
+	unix_skb_set_cell(skb);
 	unix_get_secdata(scm, skb);
 	if (scm->fp && send_fds)
 		err = unix_attach_fds(scm, skb);
@@ -2670,7 +2703,10 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 	}
 	err = (flags & MSG_TRUNC) ? skb->len - skip : size;
 
-	scm_recv_unix(sock, msg, &scm, flags);
+	if (unix_skb_foreign(skb))
+		scm_destroy(&scm);
+	else
+		scm_recv_unix(sock, msg, &scm, flags);
 
 out_free:
 	skb_free_datagram(sk, skb);
@@ -2929,6 +2965,8 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	size_t size = state->size;
 	int flags = state->flags;
 	bool check_creds = false;
+	bool foreign = false, glued = false;
+	u64 from = 0;
 	struct scm_cookie scm;
 	struct unix_sock *u;
 	int copied = 0;
@@ -3032,6 +3070,18 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 		unix_state_unlock(sk);
 
+		/*
+		 * Never glue messages from different cells: what comes with
+		 * one is not to be lost, or let through, on account of another.
+		 */
+		if (!glued) {
+			glued = true;
+			from = unix_skb_cell(skb);
+			foreign = unix_skb_foreign(skb);
+		} else if (unix_skb_cell(skb) != from) {
+			break;
+		}
+
 		if (check_creds) {
 			/* Never glue messages from different writers */
 			if (!unix_skb_scm_eq(sk, skb, &scm))
@@ -3113,7 +3163,10 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	if (msg) {
 		bool do_cmsg = READ_ONCE(u->recvmsg_inq);
 
-		scm_recv_unix(sock, msg, &scm, flags);
+		if (foreign)
+			scm_destroy(&scm);
+		else
+			scm_recv_unix(sock, msg, &scm, flags);
 
 		if ((do_cmsg | msg->msg_get_inq) && (copied ?: err) >= 0) {
 			msg->msg_inq = READ_ONCE(u->inq_len);
diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
index 402742895acc..d9c393ac58cd 100644
--- a/net/unix/af_unix.h
+++ b/net/unix/af_unix.h
@@ -13,13 +13,19 @@ struct sock *unix_peer_get(struct sock *sk);
 
 struct unix_skb_parms {
 	DECLARE_PIDS(pid, PIDTYPE_TGID);	/* skb credentials by pid type */
-	kuid_t			uid;
-	kgid_t			gid;
 	struct scm_fp_list	*fp;		/* Passed files		*/
+#ifdef CONFIG_CELLS
+	u64			cell_id;	/* of the cell it was sent from */
+#endif
+	/* This fills skb->cb to the last byte. Keep the small ones together. */
+	struct {
+		kuid_t		uid;
+		kgid_t		gid;
 #ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Security ID		*/
+		u32		secid;		/* Security ID		*/
 #endif
-	u32			consumed;
+		u32		consumed;
+	};
 } __randomize_layout;
 
 #define UNIXCB(skb)	(*(struct unix_skb_parms *)&((skb)->cb))

-- 
2.55.0

