Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D889530E17;
	Wed,  9 Sep 2026 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950611; cv=none; b=B2/lFSsJK0T8d64Tx342ll/pWB4wrf5IUcT15HKgy8gD5e0DjFxkaAcb1/xgDbXGXQB2bx5G5EW0qQ6DxaBKOR+3npO+dAkB0HCy5tP32n9xTNYNRP0wvDDO5vnb09fJY7MRmgKjeG25BG5Mq6UneBe1ZDyaLOpJYPfNI6UUZEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950611; c=relaxed/simple;
	bh=trmlci8ytu5GtClHy2fE/8jjzJ54lgp57DpFWz7F3U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n8lwQyTIijJgl7Fn3R2DjZD9kMWt06B4tzXuXz3Mq6rm1xfZX1Dh7eQkExIJ6hY4dYfymM5UK8VVV3QDK5MjQIB5/GgovcHKybNicN9c8S8yeocgZv2Wf/XmrUMSDFMe8pdZNGKqDdIFftpnTI8SxxEhshi7e0NWCt1zJUyvAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPs916Xi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPs916Xi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687F41F00A3E;
	Wed,  9 Sep 2026 10:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950610;
	bh=/PpvRThi6XFIVO4bLU1C9lPev50SJCiayR4l2shNQMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lPs916XiI/YpwFvHAOX5aTsQNEMIMQWqATsmox7H+BY6n3csTh0WmS0VGlT6I486K
	 6whL1pBKUZfP/nJJJqORqz/vINsjiRGyLt27Z4xKTykcFf+2N632rFre+QMeGm6BDQ
	 zkmiFJNGeEJJNqX9x48Rqsa+Ce4Rthbb22kZTWNCQ4l+CGAx+mkz/5VmM5f3SUIwEu
	 1U+JNU5ERULDX5ohGw022XDVCScJPlgFXKUUQO4lzybUYWsQV5pZWbZaNZbMOSYrYF
	 of1BsLRRMCOHi1KX4lhjnGk0CmOtPclYvi1RzYF2341HC3qJjtozpFIthCfnR8HeGq
	 DNVHYwqbCOLsw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 12:43:04 +0200
Subject: [PATCH v2 05/10] net: turn sk_peer_pid into an array indexed by
 pid type
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-unix-passpidfd-v2-5-7bd342abb2d1@kernel.org>
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
In-Reply-To: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9030; i=brauner@kernel.org;
 h=from:subject:message-id; bh=trmlci8ytu5GtClHy2fE/8jjzJ54lgp57DpFWz7F3U8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQttLB+6FbhorVzUroV24VFwQ/edt68df/8zAvP/Xh3m
 e6ovOR2tKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiwgyMDO9OWotcZ8/Q3yOf
 2mfhaHPSQfe8193K0FUZHLd0V+VN+8rIcKJT/n1Dv6Ho272GSWL6MRxPb63dv7Zs29E/RhuXqz+
 OYQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently only the struct pid of the thread-group leader is recorded
for a socket's peer. To make room for the struct pid of the thread that
called connect(), listen() or socketpair() turn sk_peer_pid into an
array indexed by pid type. All users, including bluetooth and the
coredump socket, keep using the PIDTYPE_TGID slot.

Nothing fills the PIDTYPE_PID slot yet. No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                   |  2 +-
 include/net/sock.h              |  4 ++--
 include/trace/events/landlock.h |  2 +-
 net/bluetooth/af_bluetooth.c    |  6 +++---
 net/bluetooth/hci_sock.c        |  8 ++++----
 net/bluetooth/l2cap_sock.c      |  2 +-
 net/core/sock.c                 |  9 +++++----
 net/unix/af_unix.c              | 14 +++++++-------
 8 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ac3cd74808c6..71a0093ada1b 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -722,7 +722,7 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
 	}
 
 	/* ... and validate that @sk_peer_pid matches @cprm.pid. */
-	if (WARN_ON_ONCE(unix_peer(socket->sk)->sk_peer_pid != cprm->pid))
+	if (WARN_ON_ONCE(unix_peer(socket->sk)->sk_peer_pid[PIDTYPE_TGID] != cprm->pid))
 		return false;
 
 	cprm->limit = RLIM_INFINITY;
diff --git a/include/net/sock.h b/include/net/sock.h
index fc09c92e8a83..67b743bab220 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -301,7 +301,7 @@ struct sk_filter;
   *	@sk_type: socket type (%SOCK_STREAM, etc)
   *	@sk_protocol: which protocol this socket belongs in this network family
   *	@sk_peer_lock: lock protecting @sk_peer_pid and @sk_peer_cred
-  *	@sk_peer_pid: &struct pid for this socket's peer
+  *	@sk_peer_pid: &struct pid for this socket's peer, by pid type
   *	@sk_peer_cred: %SO_PEERCRED setting
   *	@sk_rcvlowat: %SO_RCVLOWAT setting
   *	@sk_rcvtimeo: %SO_RCVTIMEO setting
@@ -546,7 +546,7 @@ struct sock {
 	u64			sk_ino;
 	spinlock_t		sk_peer_lock;
 	int			sk_bind_phc;
-	struct pid		*sk_peer_pid;
+	DECLARE_PIDS(sk_peer_pid, PIDTYPE_TGID);
 	const struct cred	*sk_peer_cred;
 
 	ktime_t			sk_stamp;
diff --git a/include/trace/events/landlock.h b/include/trace/events/landlock.h
index f82588f6f90e..762e721b1d9c 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -943,7 +943,7 @@ TRACE_EVENT(landlock_deny_scope_abstract_unix_socket,
 		 * these hooks, so this READ_ONCE() is safe; sun_path is the
 		 * reliable identifier.
 		 */
-		peer_pid		= READ_ONCE(peer->sk_peer_pid);
+		peer_pid		= READ_ONCE(peer->sk_peer_pid[PIDTYPE_TGID]);
 		__entry->peer_pid	= peer_pid ? pid_nr(peer_pid) : 0;
 		__assign_str(sun_path);
 	),
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 411d66f24393..7758e9ea3848 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -161,7 +161,7 @@ struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 	/* Init peer information so it can be properly monitored */
 	if (!kern) {
 		spin_lock(&sk->sk_peer_lock);
-		sk->sk_peer_pid  = get_pid(task_tgid(current));
+		sk->sk_peer_pid[PIDTYPE_TGID]  = get_pid(task_tgid(current));
 		sk->sk_peer_cred = get_current_cred();
 		spin_unlock(&sk->sk_peer_lock);
 	}
@@ -235,9 +235,9 @@ void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
 	 * socket is allocated by the kernel.
 	 */
 	spin_lock(&sk->sk_peer_lock);
-	old_pid = sk->sk_peer_pid;
+	old_pid = sk->sk_peer_pid[PIDTYPE_TGID];
 	old_cred = sk->sk_peer_cred;
-	sk->sk_peer_pid = get_pid(parent->sk_peer_pid);
+	sk->sk_peer_pid[PIDTYPE_TGID] = get_pid(parent->sk_peer_pid[PIDTYPE_TGID]);
 	sk->sk_peer_cred = get_cred(parent->sk_peer_cred);
 	spin_unlock(&sk->sk_peer_lock);
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 070ca388f9ac..91e4738eabdb 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -273,21 +273,21 @@ static void hci_sock_copy_creds(struct sock *sk, struct sk_buff *skb)
 	creds = &bt_cb(skb)->creds;
 
 	/* Check if peer credentials is set */
-	if (!sk->sk_peer_pid) {
+	if (!sk->sk_peer_pid[PIDTYPE_TGID]) {
 		/* Check if parent peer credentials is set */
-		if (bt_sk(sk)->parent && bt_sk(sk)->parent->sk_peer_pid)
+		if (bt_sk(sk)->parent && bt_sk(sk)->parent->sk_peer_pid[PIDTYPE_TGID])
 			sk = bt_sk(sk)->parent;
 		else
 			return;
 	}
 
 	/* Check if scm_creds already set */
-	if (creds->pid == pid_vnr(sk->sk_peer_pid))
+	if (creds->pid == pid_vnr(sk->sk_peer_pid[PIDTYPE_TGID]))
 		return;
 
 	memset(creds, 0, sizeof(*creds));
 
-	creds->pid = pid_vnr(sk->sk_peer_pid);
+	creds->pid = pid_vnr(sk->sk_peer_pid[PIDTYPE_TGID]);
 	if (sk->sk_peer_cred) {
 		creds->uid = sk->sk_peer_cred->uid;
 		creds->gid = sk->sk_peer_cred->gid;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1194c37e466f..872d8fb31b6f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1890,7 +1890,7 @@ static struct pid *l2cap_sock_get_peer_pid_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
 
-	return sk->sk_peer_pid;
+	return sk->sk_peer_pid[PIDTYPE_TGID];
 }
 
 static void l2cap_sock_suspend_cb(struct l2cap_chan *chan)
diff --git a/net/core/sock.c b/net/core/sock.c
index f9615b0de10e..6ada7e7eb7d7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1928,7 +1928,8 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 			len = sizeof(peercred);
 
 		spin_lock(&sk->sk_peer_lock);
-		cred_to_ucred(sk->sk_peer_pid, sk->sk_peer_cred, &peercred);
+		cred_to_ucred(sk->sk_peer_pid[PIDTYPE_TGID], sk->sk_peer_cred,
+			      &peercred);
 		spin_unlock(&sk->sk_peer_lock);
 
 		if (copy_to_sockptr(optval, &peercred, len))
@@ -1947,7 +1948,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 			len = sizeof(pidfd);
 
 		spin_lock(&sk->sk_peer_lock);
-		peer_pid = get_pid(sk->sk_peer_pid);
+		peer_pid = get_pid(sk->sk_peer_pid[PIDTYPE_TGID]);
 		spin_unlock(&sk->sk_peer_lock);
 
 		if (!peer_pid)
@@ -2401,7 +2402,7 @@ static void __sk_destruct(struct rcu_head *head)
 
 	/* We do not need to acquire sk->sk_peer_lock, we are the last user. */
 	put_cred(sk->sk_peer_cred);
-	put_pid(sk->sk_peer_pid);
+	put_pids(sk->sk_peer_pid);
 
 	if (likely(sk->sk_net_refcnt)) {
 		put_net_track(net, &sk->ns_tracker);
@@ -3797,7 +3798,7 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	sk->sk_frag.offset	=	0;
 	sk->sk_peek_off		=	-1;
 
-	sk->sk_peer_pid 	=	NULL;
+	memset(sk->sk_peer_pid, 0, sizeof(sk->sk_peer_pid));
 	sk->sk_peer_cred	=	NULL;
 	spin_lock_init(&sk->sk_peer_lock);
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 468a9c479b87..335abd23c9bf 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -737,7 +737,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 }
 
 struct unix_peercred {
-	struct pid *peer_pid;
+	DECLARE_PIDS(peer_pid, PIDTYPE_TGID);
 	const struct cred *peer_cred;
 };
 
@@ -749,7 +749,7 @@ static inline int prepare_peercred(struct unix_peercred *peercred)
 	pid = task_tgid(current);
 	err = pidfs_register_pid(pid);
 	if (likely(!err)) {
-		peercred->peer_pid = get_pid(pid);
+		peercred->peer_pid[PIDTYPE_TGID] = get_pid(pid);
 		peercred->peer_cred = get_current_cred();
 	}
 	return err;
@@ -762,7 +762,7 @@ static void drop_peercred(struct unix_peercred *peercred)
 
 	might_sleep();
 
-	swap(peercred->peer_pid, pid);
+	swap(peercred->peer_pid[PIDTYPE_TGID], pid);
 	swap(peercred->peer_cred, cred);
 
 	put_pid(pid);
@@ -772,7 +772,7 @@ static void drop_peercred(struct unix_peercred *peercred)
 static inline void init_peercred(struct sock *sk,
 				 const struct unix_peercred *peercred)
 {
-	sk->sk_peer_pid = peercred->peer_pid;
+	sk->sk_peer_pid[PIDTYPE_TGID] = peercred->peer_pid[PIDTYPE_TGID];
 	sk->sk_peer_cred = peercred->peer_cred;
 }
 
@@ -782,12 +782,12 @@ static void update_peercred(struct sock *sk, struct unix_peercred *peercred)
 	struct pid *old_pid;
 
 	spin_lock(&sk->sk_peer_lock);
-	old_pid = sk->sk_peer_pid;
+	old_pid = sk->sk_peer_pid[PIDTYPE_TGID];
 	old_cred = sk->sk_peer_cred;
 	init_peercred(sk, peercred);
 	spin_unlock(&sk->sk_peer_lock);
 
-	peercred->peer_pid = old_pid;
+	peercred->peer_pid[PIDTYPE_TGID] = old_pid;
 	peercred->peer_cred = old_cred;
 }
 
@@ -796,7 +796,7 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 	lockdep_assert_held(&unix_sk(peersk)->lock);
 
 	spin_lock(&sk->sk_peer_lock);
-	sk->sk_peer_pid = get_pid(peersk->sk_peer_pid);
+	sk->sk_peer_pid[PIDTYPE_TGID] = get_pid(peersk->sk_peer_pid[PIDTYPE_TGID]);
 	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
 	spin_unlock(&sk->sk_peer_lock);
 }

-- 
2.53.0

