Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4C4C33D1
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212999; cv=none; b=DCLVgC7jVhacpF05yCoLkdK2fnSseDN5oKdYvYvAVV3hIEepc4y8kMEZ3bm/HXjxPWCTxNVTa/YNqpm+qnE4QhFjWdSbMRu8kEjHfG/5AApGU9RvVEJ4Oec8gpc8DAqJ5lCetDXvIGhwlzUslL78c+ZsxnaBz0lkzDlK86A3SBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212999; c=relaxed/simple;
	bh=BMqojRjNhkYSxwyUudbPmPVtVxwSAowRsnpmA8uGJIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b01TD3fkDxPz4XA0++uWwXIJ6kkF4ISkufH4KPumw40VlqsJ+3F5ZGFPVLcxJ6MuhnWGxV5WLJZ4xBDBcam388aCBu8ErnxlhnbIOAYA2K+UoqznuU4E2r5FCn0aWZ/38H5hqX6iG22tQX0F2WB7xX45T4UxOP6xmsrj2dQmU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=Duq8xjZw; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="Duq8xjZw"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8accbaa1c11so12105327b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791212993; x=1791817793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C2aSa/qLzQIOUn8l0PqY1ok2qCL0S/A2InzYJfPEi2k=;
        b=Duq8xjZwUo71QOND6gNpVnUQbOdNK2lYC9bx1HK894cQG8x113Wb/yLCO9p5ZFuIf3
         CY8sEjMQH6I0iRxkgZBy4p2KUxJHzb6u9x+A0mupAoRuCj25VnQ/eM+8xvxn633uQ2kf
         mFjoxOrsdbFMHFZAehbGonh1WVvBwLvFq2s0eF3bqynVShHzJczKKF7P0OCYwzTV/OyM
         G453F+xUaNlwgvZv5Uha1hZFGEoU416dMz+9b1ktLA7jyS+WJgEDuxI4yVet4jqadgP+
         XUg68LBXWKOgh9WVy7dO3g6qXc4MaqsMiaoG1vumCv6hXS+eSvN9n1j8JFRqbtaCDI+p
         mFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212993; x=1791817793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C2aSa/qLzQIOUn8l0PqY1ok2qCL0S/A2InzYJfPEi2k=;
        b=0GR/R5Z1Qp1tq2pXJFmy/S1h38b1/XURJdY8a0PEGU/9uUhIAks9TRMl6tWS/5LdJ1
         xc3JWhuEPHP792xWoKqxakLVOlppwleoaIYexAW3pZSHDYQhe1GUc0JLuK5OvxJ1auJ8
         8ywMTf4Kf/6cM6FNI1cXMGqyXJb5iuXGV/O7RMrzS+bp9AEZk0IKoTl8z4+MSobyuhsf
         noJYGy9Ahq9ZgwSELq6LCkxcQFL9zwJRkgLH3Pee+UXbpHLsl2pDppF09uslN54WjOBg
         KLe5vygrY8ljAyHB6q+p7NePmSixcwbz/hKlYw0q6fujCc8ECbCqfAZDOJ0D4X4FV6gu
         HSiA==
X-Forwarded-Encrypted: i=1; AKwUvBw8H6lDoKYsWyE9kzTfHpY78Grck8NE9HyE6KW5qW9SzXI80vl3ysAcDN9SiGB1+Mw+lz2Ab7MwRe4WW52f@vger.kernel.org
X-Gm-Message-State: AFq9FYK8nI1wJGytjRu7w/k6uzGQRU8lFQflTUsnz7Q4kUEaosg66RZk
	9fL794OeAQlTJctTlpnQJoJiN/pnW2vCbGK4+WETB2DoNbgFZpax9565aHKAQ/rT8jY4
X-Gm-Gg: AYBFou1ybI2pL+7Plcshvjoc8gpT/yYSgkbIhueV7jOxG761xCtfMrnpdSv+vc875dF
	jIIKCUTodIDKHMlrSeaqy5zJJ2qCZfvuJ12pIljEIH4aJtbl9trwKoRn6vt14icROitirEsgE0i
	dUgNXTf2od6tsiizEd8QXi/v68SZG85LJSS+Kp8NcwCV4CmhT66RvekQoszUpX2zRgRGvZIOneM
	Df7COfjqemyNXEvhncdutWhPheU2QuNrWxrywKCzHhG12H5zwf5jSQk2+2Lhl9qE/eS7/qya3e8
	hDZJwQxtKdwH/PEaF5goJt2Gl9oXngbtmi3zUxSCvIOqTmtvrFWD0bqLm37F4dUMvaZGACP262C
	ct7Sz67Oz2p94WiMUki+TxQ2bfq+y2j15YVPCoUcKBT4sKkdiLCe35CAial/J//QsnRGNewi0ns
	hTI87W9KHga0J+bQzB5ZYFCgKCmnDlupCZUQ3/EMVwyurXqvmxb2FqfELj6/Sdia2t/Zm1fJR+C
	ySiHs7wWepN8XeprZ7o1Ci0LMaRuscuMGKfgeioYgqTpo8X18sRCn58HGFNta/ZOA==
X-Received: by 2002:a05:690c:e647:b0:8a8:7fda:15ee with SMTP id 00721157ae682-8ae3a1093b2mr26723677b3.50.1791212992728;
        Mon, 05 Oct 2026 08:09:52 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm41210467b3.47.2026.10.05.08.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:09:52 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 05 Oct 2026 10:09:35 -0500
Subject: [PATCH v4 05/10] net: turn sk_peer_pid into an array indexed by
 pid type
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-work-unix-passpidfd-v4-5-350183b6e02a@amutable.com>
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

Currently only the struct pid of the thread-group leader is recorded
for a socket's peer. To make room for the struct pid of the thread that
called connect(), listen() or socketpair() turn sk_peer_pid into an
array indexed by pid type. All users, including bluetooth and the
coredump socket, keep using the PIDTYPE_TGID slot.

Nothing fills the PIDTYPE_PID slot yet. No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
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
index 6114839f5178..9b267d3c0ed7 100644
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
index 2c4f754b498b..77dfb170d3c8 100644
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
index 3a43638c9bc2..9e172ea22d95 100644
--- a/include/trace/events/landlock.h
+++ b/include/trace/events/landlock.h
@@ -1037,7 +1037,7 @@ TRACE_EVENT(landlock_deny_scope_abstract_unix_socket,
 		 * updates.  The peer socket keeps a reference to sk_peer_pid
 		 * through pid_nr(); sun_path is the reliable identifier.
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
index 6d56c77741e1..4c40068ba5fb 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -284,21 +284,21 @@ static void hci_sock_copy_creds(struct sock *sk, struct sk_buff *skb)
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
index c6f33fcbea43..f8436e494138 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1921,7 +1921,8 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 			len = sizeof(peercred);
 
 		spin_lock(&sk->sk_peer_lock);
-		cred_to_ucred(sk->sk_peer_pid, sk->sk_peer_cred, &peercred);
+		cred_to_ucred(sk->sk_peer_pid[PIDTYPE_TGID], sk->sk_peer_cred,
+			      &peercred);
 		spin_unlock(&sk->sk_peer_lock);
 
 		if (copy_to_sockptr(optval, &peercred, len))
@@ -1940,7 +1941,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 			len = sizeof(pidfd);
 
 		spin_lock(&sk->sk_peer_lock);
-		peer_pid = get_pid(sk->sk_peer_pid);
+		peer_pid = get_pid(sk->sk_peer_pid[PIDTYPE_TGID]);
 		spin_unlock(&sk->sk_peer_lock);
 
 		if (!peer_pid)
@@ -2394,7 +2395,7 @@ static void __sk_destruct(struct rcu_head *head)
 
 	/* We do not need to acquire sk->sk_peer_lock, we are the last user. */
 	put_cred(sk->sk_peer_cred);
-	put_pid(sk->sk_peer_pid);
+	put_pids(sk->sk_peer_pid);
 
 	if (likely(sk->sk_net_refcnt)) {
 		put_net_track(net, &sk->ns_tracker);
@@ -3799,7 +3800,7 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	sk->sk_frag.offset	=	0;
 	sk->sk_peek_off		=	-1;
 
-	sk->sk_peer_pid 	=	NULL;
+	memset(sk->sk_peer_pid, 0, sizeof(sk->sk_peer_pid));
 	sk->sk_peer_cred	=	NULL;
 	spin_lock_init(&sk->sk_peer_lock);
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e44afb059abf..4e571c5a0e16 100644
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
2.55.0

