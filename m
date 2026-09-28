Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A3248FF99
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587664; cv=none; b=TGji2l8pazsHwqvyRgg+rW8GZES0Rr52e1LluOgdbDDUN6ZOCnPwFThQJD0UIEDbEBiBQS1OG0ZNAHpFDPa5w6SeQQaJ6A9qi0KEMKePjyz+SLqVcKXREmHgm2qno6J/unmaa4mjUGQHl9VFFPx0SlbGhhV2nQfT06MXiWwpdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587664; c=relaxed/simple;
	bh=F3JgndRGP4vo1GGpw/KaYJImDaGgXZpCOjibDp+7674=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LR3rW93Ixx+gl+HVaHuwzkJ0b9iJqK/mG3zZcCmKQ4VHbJLA6G2mBiJo32sTf3gQuLf4lzAj09U1VUFwOz82DuGqfdjZe83NmLgIZ9e71dWrUsMIB7wzsiVQyGuPXoEgIzjeRrRY8pd7vD41RFSJC8zgClwkM4OuasSLpRoQBAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=L6m72NXS; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="L6m72NXS"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c293c683202so391529266b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 02:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1790587657; x=1791192457; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6M/7+IJkn9gUh3ExK8xpExUSXWnuQ1H1aeQDM9UPKNY=;
        b=L6m72NXSCSedRL+CmTU52FELiL5opqY4pVBD596ngm4hgUtURrg4JLuZDImHFxerg1
         lcuWXVfq2yPA5HzclO+519m34div+7p4lrIqSn6QBneCNwtMv6i2qjrDlAS1iGrCv1eE
         tgrIIfz9iUgWA6tVQQLWfv+stbKKQaA7qehmC4XwfZdwomekYUDRkMKL7SskUeFOHl7G
         DX+hxu5JANR952259AEzKd3WXGp472nRLwzgxV8C+ZgQ/zbEyymNg42w7XtSteWYXWi1
         duRtqL1f3SA3ryByRR3fHC1OWj8H63glpAsgNHZM1WBeBHIWHBr1ymg9oEgygZjfUpp0
         zB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587657; x=1791192457;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6M/7+IJkn9gUh3ExK8xpExUSXWnuQ1H1aeQDM9UPKNY=;
        b=HGIZre9bNY8MceC7KdTNHYD/qSQJ3IMc390EG8MVj30G4AXkIqvPofoqgijiLcG141
         3HJhLzDZ21fLvXqDfn1/T/Ie9x4Pk7b0RKjYDgFJaSIzddGPz8vaDhqxJtTpdMZe2dB3
         afMvqdn2/c+GFS0TroCIvDfAW0MOMVlr4fm3mZtQrZn/O29d5DpFUiDkDVQtAcx28x2d
         Ct4Exj0nnOvpDptngHWI6y6aouuquadZZM2nkJ9Uf0TCNpuaXIOVAAdMtoG9LaAjQ2PD
         8WzCrKX3e5Wg5FLJ4sTgbuQDmVacT3znNKkRAK880Tx7RFdBibG23MXFj7yGbX8KSVPU
         chuw==
X-Forwarded-Encrypted: i=1; AKwUvByJkVGenR3vSgaPs41gMxaRKcSsjbGqCwqhjPBvH8PbG8qD5cjp5Lb7eSnKwwxhiBYzIdMWzVAYdF8ACpCC@vger.kernel.org
X-Gm-Message-State: AFuF++mfYXZel19GAr5esoaoO5NvRUk66dEp4Du5/nnTpSqLSwFayKks
	nnknLIG2pU2dnkgRRZ1IsSf6mWB/O9t6lxs9yNc4JzJR3DpOmfDUSRFIG3IldtzBNh5ZmKjVa4t
	lEIG//94A
X-Gm-Gg: AYBFou2ijy88lPV8qUjSin5mi+hUKcrGbEAAMfrSmyRp6CGdk/ADvSFB05v90gx0tTW
	247LYxxfzkD9gdgsKw82MKbSp5ABcieM5m8IRVfqww5RcFe54eSPpU3/ZqLacaGo1OgcThULybU
	UE6yC0RrTpUEmu/D9EetTdUrTSHnfdzUCVglGPf4oDCE9mkIAhZccJkI3r2lZUerY1co4rGvAaG
	cPf/vTAH+ejqaW4VS8hEVOuqBVzabkju/dwg32CUGTOuo+mqy7qqhyy5ocyAZ6QB8CfEcWDAln/
	QYhgnG/7+2btIMlaHYiYdG1CTn982ZKwCTlpleVKlAmuWFkA1ARRbqa2ojuQ4dMQOkkAlF93zSj
	LtELRqvTrG5ZrMBJ0AB4wlMM6KCAtrgZP+IcGNgMUNtJGmZLuaWBhymycrTnNIBY2yBs3FCeZ5Q
	eFmMY3ImAIW6LhzWLv/X93otcYVenOb2xWdChnijaeNmJvLf9BLJYfqMXIfjBSgZrF07aGSGIst
	WJClDiPem5uO/yS570bqumQ6AjzK+j2xziupRU3jA==
X-Received: by 2002:a17:906:9fcc:b0:c2a:34fe:ea4d with SMTP id a640c23a62f3a-c2ae9f315a8mr705580566b.25.1790587657396;
        Mon, 28 Sep 2026 02:27:37 -0700 (PDT)
Received: from [169.254.24.37] (tmo-085-169.customers.d1-online.com. [80.187.85.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm205609466b.1.2026.09.28.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:27:36 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 28 Sep 2026 11:27:10 +0200
Subject: [PATCH v3 03/10] net: add SO_PASSPIDFD_THREAD to get a
 thread-specific SCM_PIDFD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-work-unix-passpidfd-v3-3-532018a91b21@amutable.com>
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
 Andrew Halaney <andrew@amutable.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

Currently, SCM_PIDFD carries a pidfd for the thread-group leader. A
broker or the coredump server cannot learn the identity of the specific
thread that sent a given message. Now that both struct pids are recorded
a receiver can ask for the specific identity it needs.

So add SO_PASSPIDFD_THREAD as a sibling of SO_PASSPIDFD.
SO_PASSPIDFD_THREAD delivers an SCM_PIDFD_THREAD, i.e. scoped
to the specific thread sending. This is completely independent of
SO_PASSPIDFD, meaning you can use both options and get both cmsgs.

On SOCK_STREAM sockets recvmsg() only stops merging data at a thread
boundary when the receiver asked for a thread pidfd. For SO_PASSCRED and
SO_PASSPIDFD receivers all threads of one process remain a single
writer.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Co-developed-by: Andrew Halaney <andrew@amutable.com>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  2 ++
 arch/mips/include/uapi/asm/socket.h   |  2 ++
 arch/parisc/include/uapi/asm/socket.h |  2 ++
 arch/sparc/include/uapi/asm/socket.h  |  2 ++
 include/linux/socket.h                |  9 +++++----
 include/net/sock.h                    | 14 +++++++++++++-
 include/uapi/asm-generic/socket.h     |  2 ++
 net/core/scm.c                        | 27 +++++++++++++++++++--------
 net/core/sock.c                       | 14 ++++++++++++++
 net/unix/af_unix.c                    | 12 +++++++++---
 10 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 946a5fad2691..bb3d534826bb 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -157,6 +157,8 @@
 
 #define SO_RIGHTS_NOTRUNC      85
 
+#define SO_PASSPIDFD_THREAD    86
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index f1641dde135f..269badcaa086 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -168,6 +168,8 @@
 
 #define SO_RIGHTS_NOTRUNC      85
 
+#define SO_PASSPIDFD_THREAD    86
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index f3a3815c7dc2..313aee10a52c 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -149,6 +149,8 @@
 
 #define SO_RIGHTS_NOTRUNC	0x4053
 
+#define SO_PASSPIDFD_THREAD	0x4054
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 7907f3b1f0ee..bd3e69bcce7a 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -150,6 +150,8 @@
 
 #define SO_RIGHTS_NOTRUNC        0x005e
 
+#define SO_PASSPIDFD_THREAD      0x005f
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 5a5eb1250103..b17fdb7d38a7 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -189,10 +189,11 @@ static inline size_t msg_data_left(const struct msghdr *msg)
 
 /* "Socket"-level control message types: */
 
-#define	SCM_RIGHTS	0x01		/* rw: access rights (array of int) */
-#define SCM_CREDENTIALS 0x02		/* rw: struct ucred		*/
-#define SCM_SECURITY	0x03		/* rw: security label		*/
-#define SCM_PIDFD	0x04		/* ro: pidfd (int)		*/
+#define	SCM_RIGHTS		0x01	/* rw: access rights (array of int) */
+#define SCM_CREDENTIALS		0x02	/* rw: struct ucred		*/
+#define SCM_SECURITY		0x03	/* rw: security label		*/
+#define SCM_PIDFD		0x04	/* ro: pidfd (int)		*/
+#define SCM_PIDFD_THREAD	0x05	/* ro: thread pidfd (int)	*/
 
 struct ucred {
 	__u32	pid;
diff --git a/include/net/sock.h b/include/net/sock.h
index 60ea55dc1885..14df0fb68259 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -356,6 +356,7 @@ struct sk_filter;
   *	@sk_scm_security: flagged by SO_PASSSEC to recv SCM_SECURITY
   *	@sk_scm_pidfd: flagged by SO_PASSPIDFD to recv SCM_PIDFD
   *	@sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
+  *	@sk_scm_pidfd_thread: flagged by SO_PASSPIDFD_THREAD to recv a thread SCM_PIDFD
   *	@sk_scm_unused: unused flags for scm_recv()
   *	@ns_tracker: tracker for netns reference
   *	@sk_user_frags: xarray of pages the user is holding a reference on.
@@ -562,7 +563,8 @@ struct sock {
 				sk_scm_security : 1,
 				sk_scm_pidfd : 1,
 				sk_scm_rights : 1,
-				sk_scm_unused : 4;
+				sk_scm_pidfd_thread : 1,
+				sk_scm_unused : 3;
 		};
 	};
 	u8			sk_clockid;
@@ -2988,6 +2990,16 @@ static inline bool sk_is_stream_unix(const struct sock *sk)
 	return sk_is_unix(sk) && sk->sk_type == SOCK_STREAM;
 }
 
+static inline bool sk_scm_pidfd_wanted(const struct sock *sk)
+{
+	return sk->sk_scm_pidfd;
+}
+
+static inline bool sk_scm_pidfd_thread_wanted(const struct sock *sk)
+{
+	return sk->sk_scm_pidfd_thread;
+}
+
 static inline bool sk_is_vsock(const struct sock *sk)
 {
 	return sk->sk_family == AF_VSOCK;
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 84ea7b92936e..d1e5c6de146d 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -152,6 +152,8 @@
 
 #define SO_RIGHTS_NOTRUNC	85
 
+#define SO_PASSPIDFD_THREAD	86
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/scm.c b/net/core/scm.c
index 9b9e119c353a..ba43d76027af 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -499,11 +499,16 @@ static bool scm_has_secdata(struct sock *sk)
 }
 #endif
 
-static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
+static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm,
+			   enum pid_type type, int cmsg_type)
 {
+	unsigned int flags = PIDFD_STALE;
 	struct file *pidfd_file = NULL;
+	struct pid *pid;
 	int len, pidfd;
 
+	pid = scm->pid[type];
+
 	/* put_cmsg() doesn't return an error if CMSG is truncated,
 	 * that's why we need to opencode these checks here.
 	 */
@@ -517,12 +522,15 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
 		return;
 	}
 
-	if (!scm->pid[PIDTYPE_TGID])
+	if (!pid)
 		return;
 
-	pidfd = pidfd_prepare(scm->pid[PIDTYPE_TGID], PIDFD_STALE, &pidfd_file);
+	if (type == PIDTYPE_PID)
+		flags |= PIDFD_THREAD;
 
-	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
+	pidfd = pidfd_prepare(pid, flags, &pidfd_file);
+
+	if (put_cmsg(msg, SOL_SOCKET, cmsg_type, sizeof(int), &pidfd)) {
 		if (pidfd_file) {
 			put_unused_fd(pidfd);
 			fput(pidfd_file);
@@ -539,8 +547,8 @@ static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
 			      struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
-		if (sk->sk_scm_credentials || sk->sk_scm_pidfd ||
-		    scm->fp || scm_has_secdata(sk))
+		if (sk->sk_scm_credentials || sk_scm_pidfd_wanted(sk) ||
+		    sk_scm_pidfd_thread_wanted(sk) || scm->fp || scm_has_secdata(sk))
 			msg->msg_flags |= MSG_CTRUNC;
 
 		scm_destroy(scm);
@@ -586,8 +594,11 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 		scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc));
 	}
 
-	if (sock->sk->sk_scm_pidfd)
-		scm_pidfd_recv(msg, scm);
+	if (sk_scm_pidfd_wanted(sock->sk))
+		scm_pidfd_recv(msg, scm, PIDTYPE_TGID, SCM_PIDFD);
+
+	if (sk_scm_pidfd_thread_wanted(sock->sk))
+		scm_pidfd_recv(msg, scm, PIDTYPE_PID, SCM_PIDFD_THREAD);
 
 	scm_destroy_cred(scm);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index d23333bb4f3f..3b5f28573752 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1578,6 +1578,13 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			ret = -EOPNOTSUPP;
 		break;
 
+	case SO_PASSPIDFD_THREAD:
+		if (sk_is_unix(sk))
+			sk->sk_scm_pidfd_thread = valbool;
+		else
+			ret = -EOPNOTSUPP;
+		break;
+
 	case SO_PASSRIGHTS:
 		if (sk_is_unix(sk))
 			sk->sk_scm_rights = valbool;
@@ -1893,6 +1900,13 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		v.val = sk->sk_scm_pidfd;
 		break;
 
+	case SO_PASSPIDFD_THREAD:
+		if (!sk_is_unix(sk))
+			return -EOPNOTSUPP;
+
+		v.val = sk->sk_scm_pidfd_thread;
+		break;
+
 	case SO_PASSRIGHTS:
 		if (!sk_is_unix(sk))
 			return -EOPNOTSUPP;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index c7d423465859..6cc2873d9a4f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -803,7 +803,8 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 
 static bool unix_may_passcred(const struct sock *sk)
 {
-	return sk->sk_scm_credentials || sk->sk_scm_pidfd;
+	return sk->sk_scm_credentials || sk_scm_pidfd_wanted(sk) ||
+		sk_scm_pidfd_thread_wanted(sk);
 }
 
 static int unix_listen(struct socket *sock, int backlog)
@@ -2048,9 +2049,14 @@ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
 	return 0;
 }
 
-static bool unix_skb_scm_eq(struct sk_buff *skb,
+static bool unix_skb_scm_eq(const struct sock *sk, struct sk_buff *skb,
 			    struct scm_cookie *scm)
 {
+	/* Only a thread pidfd receiver can tell threads of one process apart. */
+	if (sk->sk_scm_pidfd_thread &&
+	    UNIXCB(skb).pid[PIDTYPE_PID] != scm->pid[PIDTYPE_PID])
+		return false;
+
 	return UNIXCB(skb).pid[PIDTYPE_TGID] == scm->pid[PIDTYPE_TGID] &&
 	       uid_eq(UNIXCB(skb).uid, scm->creds.uid) &&
 	       gid_eq(UNIXCB(skb).gid, scm->creds.gid) &&
@@ -3033,7 +3039,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 		if (check_creds) {
 			/* Never glue messages from different writers */
-			if (!unix_skb_scm_eq(skb, &scm))
+			if (!unix_skb_scm_eq(sk, skb, &scm))
 				break;
 		} else if (unix_may_passcred(sk)) {
 			/* Copy credentials */

-- 
2.55.0

