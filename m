Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96F748EC86
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587666; cv=none; b=WPLsT0daByMhEh2tJWFRK5438SokYBiRYPK+iNOnpuVsPgeqOnCe23j83HZBbooPesin5Y9jeZcUu5p6w4n+JX5vpT4+BOx4eO2kSBMehEb+QyamECG2/6T/er3t7jjjS8MjD4AWpz5iBJntPgMYqJCWopzXtBkatmdf+dk9jJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587666; c=relaxed/simple;
	bh=B5tBly/lSR/XIauZZcyh5jcrpL0k36lZvT1kg/VJAyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BqKb3n3lmdf7aGj0R+WHg96Lm3nI9WDaBqr/Ii+vQW6+gBCHJbt0l79PcGRQECJ4LOjvzHNs1oUpe7G9kaPw4bUtNDhu8s0GDdsImu2ZrfMljbgfhLBF9j6KCTS2sCXJwOksj+BYOHAa8eeTOmdVBjZmuTYQnBdgEWBu6+QPLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=qRp77K6A; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="qRp77K6A"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2af43c5b0cso323201266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1790587658; x=1791192458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fli05GEVfaQ+VP3ZFKc94paSGoq/IPDKQzCQimdJV8c=;
        b=qRp77K6Av4YjT3qr3PXihtKGW5HhikWifjyKwUx1FCHrKSpatbmjLxCObBuN6azopV
         0dEAupCNu9EU/YmEBxpZJQEVzGNcQcnnAiC+o7gjjwQlf+Gr9OUjna4sSo5xQXcZkWo2
         HFH0Y4UGfAfXZL50Mb5SFTymyZDYjdmcS79XQ+wnyPlfsbrW+RHQ7VrQAy20UI3zJZbW
         eCQW6EAOC4F/CJjC4hJIl6/Db+pB/Ly9VJrbMKefOLltJFlRVhUYF6TDHKfUQrjVxTuw
         JKOsxYr6Vxi5jn4aQcyHIP6xjrekVUFOp9X1M6txak9xXZfSapapE1T3sKame+bU7ReL
         j6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587658; x=1791192458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fli05GEVfaQ+VP3ZFKc94paSGoq/IPDKQzCQimdJV8c=;
        b=q48wyrbFInanXBbSwlf7ZCmm/PlflyiGVVjgVFlrlj1U83DlJvK3v7ZYf/ebMoOO8s
         ScS2UQ/zDnGPQqnduW7zxC5IGJPeWIG+24ijgSQ+OSpZkhQynSZ0+HBG6+eNLkpMaRm8
         CSiQQQm0+EzbOZAqbPseEinS2Yo/2ZedFKaZnUix3g8nf4URVkiQqWamlLthcO8BSxCS
         Snju9hoWz8f99423DRQ9lz9HIkBidCP2Oh6jjYZIqQeF5nO3KFQqwy1zx/PL9lg2L37X
         EXeSDTct4KCJxAkA9c/K/zvymI3d0YBMktFfquft3EexUTbkY4YD0Lmer5t/8rZg/W3C
         CtyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzzEJG2SPZ0Rja5HCQJwhC7qQyx9A3a8lpvjvHuFTVISksw125/zyJoA28ylMDOJC+mvPf0VpsnaPFgrbCg@vger.kernel.org
X-Gm-Message-State: AFq9FYLsYKS7iINZB2Jvbk346s0j8zHr5n8dq5Gfna7Qvxpg2WBQZdEA
	YQ7F5YnebY4IWvoUjVym/NqLEAzkqX7j9DFwhx14kn62b+YVpzB+sKUZksWY+ziJQUER
X-Gm-Gg: AYBFou02JyVkSV+X0P6ZsmJoLnhTaEbo3XpI9LSsP9V3Vp0+uuCoUIDcNVoo5psZsma
	PNfgmOkJuLCbhE1kSktaqILFYmb9J5/OzqxD0mc4QhnYBTMRXBYkCPgv539IbqCBZxsZK7wos56
	yYZu5dU8nP2jDVoQ+WfTqzgfSBi/ZfJ9fpKSlCbi5V/NQsNF24dpRbU6enz6J+QAbfQklOuv3Oh
	sskjjZKLmXh8s1NTSPqvyL4ZHf60rzV/0fv8xlJ7wWCzzJYBeUxv6nrIVt0hzKMb7LK6nOQvR6C
	L3F+d5qxD++I3EhERhyBKwx/IXSJV5uMHXCJDV0b7V2nfJSESOvnycIXl+oxx73v7cfvZbebH9q
	03UNv7WDcSLBegr2mzuthCC6SMwk5RqxeCDbdjKVlN/gxw3xvDlFV4ariukUfYxWp3vNmnV1wsC
	WU2gO2izwqL7Jyan8JBB5skHxA8vUpAu+rtmnF4OfHHz933c5B76tftOhnXP3pPEuJk8iwG4JDj
	8ZTqu3UWmAybdx2dSl/i6+Y32pSrjnr56kYgOCMzw==
X-Received: by 2002:a17:907:3f1b:b0:c29:d487:bdfa with SMTP id a640c23a62f3a-c2ac23dc46emr1044633666b.20.1790587655862;
        Mon, 28 Sep 2026 02:27:35 -0700 (PDT)
Received: from [169.254.24.37] (tmo-085-169.customers.d1-online.com. [80.187.85.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm205609466b.1.2026.09.28.02.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:27:35 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 28 Sep 2026 11:27:09 +0200
Subject: [PATCH v3 02/10] af_unix: record the pid of the sending thread
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-work-unix-passpidfd-v3-2-532018a91b21@amutable.com>
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

Currently only the struct pid of the thread-group leader is recorded.
The identity of the actual thread that sent the message or is connected
to a given socket cannot be retrieved.

Add the plumbing to make it possible to retrieve a pidfd for the sender.
Nothing uses the thread-specific struct pid yet. No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 include/net/scm.h  |  7 +++----
 net/core/scm.c     | 21 +++++++++++++++++----
 net/unix/af_unix.c | 23 +++++++++++++----------
 net/unix/af_unix.h |  3 ++-
 4 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 86ae6bc109ec..aa7d15c5fc27 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -42,7 +42,7 @@ struct scm_fp_list {
 };
 
 struct scm_cookie {
-	struct pid		*pid;		/* Skb credentials */
+	DECLARE_PIDS(pid, PIDTYPE_TGID);	/* Skb credentials by pid type */
 	struct scm_fp_list	*fp;		/* Passed files		*/
 	struct scm_creds	creds;		/* Skb credentials	*/
 #ifdef CONFIG_SECURITY_NETWORK
@@ -69,7 +69,7 @@ static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_co
 static __inline__ void scm_set_cred(struct scm_cookie *scm,
 				    struct pid *pid, kuid_t uid, kgid_t gid)
 {
-	scm->pid = get_pid(pid);
+	scm->pid[PIDTYPE_TGID] = get_pid(pid);
 	scm->creds.pid = pid_vnr(pid);
 	scm->creds.uid = uid;
 	scm->creds.gid = gid;
@@ -77,8 +77,7 @@ static __inline__ void scm_set_cred(struct scm_cookie *scm,
 
 static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
 {
-	put_pid(scm->pid);
-	scm->pid = NULL;
+	put_pids(scm->pid);
 }
 
 static __inline__ void scm_destroy(struct scm_cookie *scm)
diff --git a/net/core/scm.c b/net/core/scm.c
index f0d44ecdb11f..9b9e119c353a 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -149,6 +149,7 @@ EXPORT_SYMBOL(__scm_destroy);
 
 static inline int scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
 {
+	struct pid *thread_pid;
 	int err;
 
 	/* drop all previous references */
@@ -158,7 +159,18 @@ static inline int scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
 	if (unlikely(err))
 		return err;
 
-	scm->pid = pid;
+	/* A sender naming its own thread-group sends from the current thread. */
+	if (pid == task_tgid(current))
+		thread_pid = task_pid(current);
+	else
+		thread_pid = pid;
+
+	err = pidfs_register_pid(thread_pid);
+	if (unlikely(err))
+		return err;
+
+	scm->pid[PIDTYPE_TGID] = pid;
+	scm->pid[PIDTYPE_PID] = get_pid(thread_pid);
 	scm->creds.pid = pid_vnr(pid);
 	return 0;
 }
@@ -207,7 +219,8 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
 			if (err)
 				goto error;
 
-			if (!p->pid || pid_vnr(p->pid) != creds.pid) {
+			if (!p->pid[PIDTYPE_TGID] ||
+			    pid_vnr(p->pid[PIDTYPE_TGID]) != creds.pid) {
 				struct pid *pid;
 				err = -ESRCH;
 				pid = find_get_pid(creds.pid);
@@ -504,10 +517,10 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
 		return;
 	}
 
-	if (!scm->pid)
+	if (!scm->pid[PIDTYPE_TGID])
 		return;
 
-	pidfd = pidfd_prepare(scm->pid, PIDFD_STALE, &pidfd_file);
+	pidfd = pidfd_prepare(scm->pid[PIDTYPE_TGID], PIDFD_STALE, &pidfd_file);
 
 	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
 		if (pidfd_file) {
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 42cffeafc8c1..c7d423465859 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1973,7 +1973,7 @@ static void unix_destruct_scm(struct sk_buff *skb)
 {
 	struct scm_cookie scm = {};
 
-	swap(scm.pid, UNIXCB(skb).pid);
+	swap_pids(scm.pid, UNIXCB(skb).pid);
 
 	if (UNIXCB(skb).fp)
 		unix_detach_fds(&scm, skb);
@@ -1991,7 +1991,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 {
 	int err = 0;
 
-	UNIXCB(skb).pid = get_pid(scm->pid);
+	get_pids(UNIXCB(skb).pid, scm->pid);
 	UNIXCB(skb).uid = scm->creds.uid;
 	UNIXCB(skb).gid = scm->creds.gid;
 	UNIXCB(skb).fp = NULL;
@@ -2005,7 +2005,10 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 
 static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
 {
-	scm_set_cred(scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
+	get_pids(scm->pid, UNIXCB(skb).pid);
+	scm->creds.pid = pid_vnr(scm->pid[PIDTYPE_TGID]);
+	scm->creds.uid = UNIXCB(skb).uid;
+	scm->creds.gid = UNIXCB(skb).gid;
 	unix_set_secdata(scm, skb);
 }
 
@@ -2025,20 +2028,20 @@ static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
 static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
 				const struct sock *other)
 {
-	if (UNIXCB(skb).pid)
+	if (UNIXCB(skb).pid[PIDTYPE_TGID])
 		return 0;
 
 	if (unix_may_passcred(sk) || unix_may_passcred(other) ||
 	    !other->sk_socket) {
-		struct pid *pid;
 		int err;
 
-		pid = task_tgid(current);
-		err = pidfs_register_pid(pid);
-		if (unlikely(err))
+		get_task_pids(UNIXCB(skb).pid, current);
+		err = pidfs_register_pids(UNIXCB(skb).pid);
+		if (unlikely(err)) {
+			put_pids(UNIXCB(skb).pid);
 			return err;
+		}
 
-		UNIXCB(skb).pid = get_pid(pid);
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
 
@@ -2048,7 +2051,7 @@ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
 static bool unix_skb_scm_eq(struct sk_buff *skb,
 			    struct scm_cookie *scm)
 {
-	return UNIXCB(skb).pid == scm->pid &&
+	return UNIXCB(skb).pid[PIDTYPE_TGID] == scm->pid[PIDTYPE_TGID] &&
 	       uid_eq(UNIXCB(skb).uid, scm->creds.uid) &&
 	       gid_eq(UNIXCB(skb).gid, scm->creds.gid) &&
 	       unix_secdata_eq(scm, skb);
diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
index 8119dbeef3a3..402742895acc 100644
--- a/net/unix/af_unix.h
+++ b/net/unix/af_unix.h
@@ -2,6 +2,7 @@
 #ifndef __AF_UNIX_H
 #define __AF_UNIX_H
 
+#include <linux/pid_types.h>
 #include <linux/uidgid.h>
 
 #define UNIX_HASH_MOD	(256 - 1)
@@ -11,7 +12,7 @@
 struct sock *unix_peer_get(struct sock *sk);
 
 struct unix_skb_parms {
-	struct pid		*pid;		/* skb credentials	*/
+	DECLARE_PIDS(pid, PIDTYPE_TGID);	/* skb credentials by pid type */
 	kuid_t			uid;
 	kgid_t			gid;
 	struct scm_fp_list	*fp;		/* Passed files		*/

-- 
2.55.0

