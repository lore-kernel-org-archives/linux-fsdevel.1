Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6253D3DDDBB;
	Mon, 31 Aug 2026 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175295; cv=none; b=aymOXKAfHDhE+4W1zuDwc1ta2Pu7wuFhFldCvwrpM3+1e4WDMmJCf7AhtT/ot4S9AVTx2+/YzP+ARX7vC2qXAEANUlLu9D5ITdWEMIqREMVPkM4Ar9lv1lq+Zo24eyj5YFcOtwFQAJHOVZj6A+YNqskgoL6lygUwz2pprlIhetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175295; c=relaxed/simple;
	bh=8y7i7XdLNk6YD1ieQIQKQPtW6EPU/d87CtG5vVgfh1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B09Gt1u2RCLBrsDCA23037hUQNXddjbM1Txx/OgSaQ7fed7Wkz27kGUJ1b8u8TLUnYSi93SD1RvRlty+UxW9N5NGoN9a+SvGq479TZXmZOWyzWnfV24HRpLXSDM+9Q7keTws2rJ2bzKh8I3KkppZTlIRwrWlStWpkeCeDXJXdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcYLf6t+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcYLf6t+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8ADA1F000E9;
	Mon, 31 Aug 2026 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175294;
	bh=f7vAua/SuxVzCWdPf5sdxe/QtAK3nj/ceXJVxPpgBGA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FcYLf6t+LlM1BO9qm87ob0a3d8IwchOV8AYH8r1W4Zs9l9g/A4bDil//1y8tkQsXi
	 gxPa0CsVXBy539tFp8UVMy095LDLpvrvXq+RidnHvadiVKRYDjOjb8Jpn4RfJltqSK
	 /FNdhJ3zN/03Zzvqiu2YX1/4vaW4mAaTafk10QVm36wmJFyUwVQQQrqHX2ZOYtp/pi
	 Z1Zeg5vnjM78BDbgx7S79JESiisWj62b0vFH7U4SLmnQH9o7UjTrM7BuABG2QrkX1g
	 UGEjnGNrZexDKSQoKSrseDXYSJdvCo0RyiFqaTz8RQKcpajriLs2j2zLmjmRfIBzBp
	 yQ+SWqWTG5yGw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 31 Aug 2026 13:21:14 +0200
Subject: [PATCH 02/10] af_unix: record the pid of the sending thread
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-work-unix-passpidfd-v1-2-70cbfda0c7ba@kernel.org>
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=6397; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8y7i7XdLNk6YD1ieQIQKQPtW6EPU/d87CtG5vVgfh1w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNTd6Y4/vmr6vwwQ0JtxdsMGh3PmKQdXJGaT6HhmgUz
 70naTvSO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby+gEjw/Ttf/nmsCy1rXZa
 tMmxyEVy84cdld+Kp5Z0Be+VddabGM7I8Mft7QKdvTemCU4IXZ/uYcnz9lGo/tF79b+znB74GdU
 7MwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently only the struct pid of the thread-group leader is recorded.
The identity of the actual thread that sent the message or is connected
to a given socket cannot be retrieved.

Add the plumbing to make it possible to retrieve a pidfd for the sender.
Nothing uses the thread-specific struct pid yet. No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
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
index 13f9926bf205..011af84e3626 100644
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
2.53.0

