Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7854C14EA
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212994; cv=none; b=Ev6ckogEop9LFRTkM6t0oEbNejanjp3znYvUyNik8LzFmTfkgil0ngTVRbLIgfHASqDcxnutv/XeK5J2BLefEU33x3blrKSRt+veyPwGOSgQG15fvJwX5DkLT96DjgnfWzDEfY+mYb+rgfb0s9nDJMKPVeNIxHZR2/pWpO+gHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212994; c=relaxed/simple;
	bh=JqdhYArLfQMq1mboPKSJjgurXFhylbSgNQRp7J5U3IA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZLm0hbAFUclFakgPI236b0JAe85QQA7/RIZtsTt9wJmh4bQJ7kCyNSsAuQS74tOYohjilQnh7izsv+iz2xZlXFYOvj1WEnDwPIsXneSHp5QCbodBn0dbYI2ykwHqhHHPPNzcXYK1EfXLOzGnKCI6fY3WdFG5qMUCBFG2qbS1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=xkYIJyvV; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="xkYIJyvV"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ac9d666d4eso17116107b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791212990; x=1791817790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9eqsrwslFJI2AH2PY+QHhIr0sWb1wdjAmFsW2YT3Y0=;
        b=xkYIJyvVSsrL2Q3Y9YFXx5aLkiqFt4P8PjbpbT/HjiNu99J80///PSqxOcvTYMIn4n
         ZYj1vjhJOR6quX8l9IFT50DhaQfZOS+omYFvEKywSAdfYmz55OX98Sg38eBmwd2j0pjD
         +ycTNwwnpiIb1gQRGIK4b03NFkT7Qu3nJvy+hdH9WEIq9jH03DPf8cXjzeQKYiUwBT7H
         Mi8XDLF6Er77YJi9U6KOzZOm59smdJ6quxijdveQuKYZ/baYi1LW4+455bYzjTB4Jx+/
         E2c0ueTAgZrd9jwhPGa1Xp9gqpZD+So86eQ1bnSrFu7oAgMufZRlIuAi/VqHIgkLDKaI
         JvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212990; x=1791817790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K9eqsrwslFJI2AH2PY+QHhIr0sWb1wdjAmFsW2YT3Y0=;
        b=0f+Tt/yrYSdx/VzgOspjaWMNjBJnbNM1LHNMY2aFGP/covnQHgGfUs/M1pD+LtL4NP
         tvSdE5AKO0k7fAN9N4LgqY6gunYcxa0JR6c/1U9mZ/nclAiOAJVYbMGdUjXhhye2ydB9
         5zaiR6jTVNjIyPs2T3j0fwJF+MVmBphTMqJkbTxK38Dhl9SCE7Vbfk/5AOONwOtkUPAa
         p+m/aeXyDdjmQAzt4RGvxnn6v5h8rLUEJv31nEOLZn7L2hTTGkIpNB9ZSvU1JzLJErD6
         27q3WPT2OV70pYsFRMmePe7RYSt5X8i0KNPiwO3ODiWp5QucTkazkskt28mIbkKlP2WF
         lBlQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwEivabfqYsEIb58XdL33RExVjETf/bJJaWvP8b8Lji26UBt215QIMhjWICQtB7lY08f/+N97b6UH/4lB3@vger.kernel.org
X-Gm-Message-State: AFq9FYL57a/FJHplJzXlM6SDzLjnve037TGylF3j7jAbHW4PwmFRp4i/
	YgIt1LKKF+7W18djiS0l14IM6Ch7xysKr5Cl2zy0VuBnLgJvPvRuqEBSzB0hhlF5dzg1
X-Gm-Gg: AYBFou1sSLAOwDTVfDDL7YDtpIIjHlmZiH78pa2pRgK6Xzw2R+GjSkgDf22DKQCb1lG
	G0H2trg5H3ennlsENc+B+403YrWwk0jN9i1SDA7Vwn9b7dBbWNUrv773FZg/v3CAfY8W0Cgq/eU
	hF4EHD5RCpoVj9CqlvCDQdlke/FntBZz0IAoCDe6mdTSkqNmzIe2euIqe6S64UEIOY/GTgq3idx
	3N78W45A7bdC8wun8q2bKYCDnva5yw4jI0oHCCjScgi9NpuXajSmaFITJCk0YGtrw8mu9GDCX/x
	OrUYOGyjIR4ueLQzJ5bApXpa/GlkTUCbv7ECuj4q+esqpPGSBtV1+HNmOkbJ+iMS7iCQP8VUEEs
	gdCrKukAZqPfmFK7U3hU7o8yOxyO2TM2f/+QyS5cx6udxfpTH1tHTSQFrD3vPU9PMaGT16oeyr1
	oyJ159DNQHwj3Ynf6Gp39Su36HWcS1dPDGs2LzngTxfDqOZdZmK7xXK2B6Qh/qWGpr+ot94ABtr
	boqAlpHBkh9IT1jc2pQQYB+9NjuELjFcxYPdVHk2QFrpfGGfsHqzLmb90fJy2lwTA==
X-Received: by 2002:a05:690c:386:b0:8ab:4a67:71a8 with SMTP id 00721157ae682-8ae94ca2e24mr23162597b3.38.1791212989741;
        Mon, 05 Oct 2026 08:09:49 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm41210467b3.47.2026.10.05.08.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:09:49 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 05 Oct 2026 10:09:32 -0500
Subject: [PATCH v4 02/10] af_unix: record the pid of the sending thread
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-work-unix-passpidfd-v4-2-350183b6e02a@amutable.com>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Eric Dumazet <edumazet@kernel.org>, 
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
 include/net/scm.h  | 10 +++++-----
 net/core/scm.c     | 21 +++++++++++++++++----
 net/unix/af_unix.c | 21 +++++++++++----------
 net/unix/af_unix.h |  3 ++-
 4 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 86ae6bc109ec..b68a143f42de 100644
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
@@ -69,7 +69,6 @@ static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_co
 static __inline__ void scm_set_cred(struct scm_cookie *scm,
 				    struct pid *pid, kuid_t uid, kgid_t gid)
 {
-	scm->pid = get_pid(pid);
 	scm->creds.pid = pid_vnr(pid);
 	scm->creds.uid = uid;
 	scm->creds.gid = gid;
@@ -77,8 +76,7 @@ static __inline__ void scm_set_cred(struct scm_cookie *scm,
 
 static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
 {
-	put_pid(scm->pid);
-	scm->pid = NULL;
+	put_pids(scm->pid);
 }
 
 static __inline__ void scm_destroy(struct scm_cookie *scm)
@@ -94,8 +92,10 @@ static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
 	memset(scm, 0, sizeof(*scm));
 	scm->creds.uid = INVALID_UID;
 	scm->creds.gid = INVALID_GID;
-	if (forcecreds)
+	if (forcecreds) {
+		scm->pid[PIDTYPE_TGID] = get_pid(task_tgid(current));
 		scm_set_cred(scm, task_tgid(current), current_uid(), current_gid());
+	}
 	unix_get_peersec_dgram(sock, scm);
 	if (msg->msg_controllen <= 0)
 		return 0;
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
index 42cffeafc8c1..64e720bd289b 100644
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
@@ -2005,7 +2005,8 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 
 static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
 {
-	scm_set_cred(scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
+	get_pids(scm->pid, UNIXCB(skb).pid);
+	scm_set_cred(scm, UNIXCB(skb).pid[PIDTYPE_TGID], UNIXCB(skb).uid, UNIXCB(skb).gid);
 	unix_set_secdata(scm, skb);
 }
 
@@ -2025,20 +2026,20 @@ static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
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
 
@@ -2048,7 +2049,7 @@ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
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

