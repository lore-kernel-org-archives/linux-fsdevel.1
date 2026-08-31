Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9993DA7DC;
	Mon, 31 Aug 2026 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175306; cv=none; b=jJ5q+UHPtWonZwvRuT1HYVow/rJkenaSOytEtnX7BH0Y8Gz2FGl6pnoAdoteHm9KqMQBjxgFIwTZEqfspelBoRm28kvz3xZdsLfPHob5NFsX+Y8mMbmwCPd+gwG6YJxoqfHfPbSfu1mbDDqqGwccZRF5sGn8VdEEa6OIE0KTN5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175306; c=relaxed/simple;
	bh=HEybP9kYZLYh95nXQVU4Ro2ZoH8yWd91e11nBo+cWPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ugLaZj/apN6VjlPQtkTMh4YgrH0WvyYlbDXs/fuE5VvnFKUeawUhuESGHUeNP4VGO/jkn31KUbM7h4QY+EXh0ENvS9Hw6ArCyKEZQg4QgvLrL+KA473/YHDSAgm7PepO9QFKchnBpNIxqbON3z0FpKwE3kLmLHl071XFeeCpr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLk/CHkr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLk/CHkr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116F91F00A3D;
	Mon, 31 Aug 2026 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175305;
	bh=PiV5BA+QJHtOFjV1KLxuRRKTBzeVLodZTa8VggNpLEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FLk/CHkrDGvPG8oCcoDtYwJDIX9UZzH3sXhtzSg7fkg6klfKR1l6cb+eBzQrGW0ui
	 hl2/tpDfpMNJApn9RVeuB1eWZoaoo0OcGGS3Jkl7QV/Z4vsBFKn0uqALelLoZ7CyXN
	 9W52q2eH6cav+MLtR3/+iP9h3drcTe/WZ4ahijFW3cQHh49y+ua47yd5VKs8WJO2qZ
	 B/Z+UyE8Ikx6StzdZVov0TtLPTavXqAwDKoXAxa/NQb5GP6OTDHKeCEHJHypGL7Rsu
	 Tf6a3+jh+7UXyYx/+PXko4FdXtBkWgeOSn9wwxEQNYziyiBnTr3349Fz2HI//IlKYQ
	 eYwfnUuqaYXkw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 31 Aug 2026 13:21:17 +0200
Subject: [PATCH 05/10] net: turn sk_peer_pid into an array indexed by pid
 type
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-work-unix-passpidfd-v1-5-70cbfda0c7ba@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8395; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HEybP9kYZLYh95nXQVU4Ro2ZoH8yWd91e11nBo+cWPU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNTd4ocO5KvKvSvnuhalM+l7ztlK0/VLtHljUwZxHf1
 DuK2Qs+d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkfDojwy+bNX38O65GHeVi
 e71nUWpBZ8DcHPHS3LqU1oQnKz1yyxkZTtW2HnZ7wXNm5mf3KhVRlvyTm8LldH1DhKc0vPHcM6W
 YHwA=
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
 fs/coredump.c                |  2 +-
 include/net/sock.h           |  4 ++--
 net/bluetooth/af_bluetooth.c |  6 +++---
 net/bluetooth/hci_sock.c     |  8 ++++----
 net/bluetooth/l2cap_sock.c   |  2 +-
 net/core/sock.c              |  9 +++++----
 net/unix/af_unix.c           | 14 +++++++-------
 7 files changed, 23 insertions(+), 22 deletions(-)

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

