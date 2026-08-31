Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325813E49C7;
	Mon, 31 Aug 2026 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175300; cv=none; b=KmDPw7a7pWb6SvUNJTN1SLrCUHBU6CogltzUSVQTd1zfCJZqOtfESK3R/IZLTiwJpivFfLrVdI2ukG0olGfaL+HWhuyUkadjgr4sfxsHD8s62zZ/7LWSb3CenW72FJgwJ9TCS/0Sb45noVba1wyxYJ9K/J3xrddWv6pNOsIG0Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175300; c=relaxed/simple;
	bh=NLa8uilUxAnPii04OppmXTDEn9mgtxxJISrmS/dAGEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqswZuxvpiWhOtlXxShKJ4Ocd75LRR1QPqZYUzO8GilF51Zvf7Hc9y3a4VLJtZOf74xs4SYGpAoSqIL1j7FgUSFYzYikk6/GRbHWc+/I/u2ORM0j/5jAiWRNqU32uIVn2i1ez6i12JfAslgMAmqfQxzUoQEMOhwUOwk+WUHfIhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8UMdrYe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8UMdrYe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754B71F00A3D;
	Mon, 31 Aug 2026 11:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175297;
	bh=GiJ2hHOWnwnvPkGxLjwnC23vL+oGkNd/f/J0V6WYS1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=B8UMdrYeA+jyz+nwijxsaePMtHarhde97Ghwhp9N8p7JcuSwUpXmAy+8p2o1d9QtK
	 Eg6zGXp6BybUCY1lKCzIqz24c5wkn6ZkmRHmEzC9GQxDKvynOZzGCLk+fF3KVuu7V8
	 z5+WwEY7vObBj4q1xFWaYWoNCxNEYXQUz0nOndV9XTJmOGWjGEo5HQpw3dy0nlQJbx
	 SDllx3Dgqwur51qF0CadnUeUHJZsM1RJY/lvy7jr3nTg1M5HIIcMaay2KStAuSj4n3
	 QBxB3ByyskPZZBVarw/sA70FdQ/0DPs+fLIweJlCRZQ1zIoM6opOByDUQ5AckIlzL1
	 H2Su527Patdqg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 31 Aug 2026 13:21:15 +0200
Subject: [PATCH 03/10] net: add SO_PASSPIDFD_THREAD to get a
 thread-specific SCM_PIDFD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-work-unix-passpidfd-v1-3-70cbfda0c7ba@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9092; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NLa8uilUxAnPii04OppmXTDEn9mgtxxJISrmS/dAGEo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNTd7YV+Pv+rn0VsQT3/OpWUHfc4Ll2q89bd4516JR6
 /I+TotPHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5zMHwz9CpxNQmbs93K4ES
 VvO+Z45TIqT3M0+/d3fWX5HqqSevvmRkWBiU5/ZB4f/MTeemH5bkt/EyKF5Za81zRu//rmNFm/W
 FWAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently, SCM_PIDFD carries a pidfd for the thread-group leader. A
broker or the coredump server cannot learn the identity of the specific
thread that sent a given message. Now that both struct pids are recorded
a receiver can ask for the specific identity it needs.

So add SO_PASSPIDFD_THREAD as a sibling of SO_PASSPIDFD. Either option
makes recvmsg() deliver an SCM_PIDFD. SO_PASSPIDFD sends a pidfd for the
thread-group leader and SO_PASSPIDFD_THREAD sends a pidfd for the
specific thread.

The two options are mutually exclusive. Enabling one switches the other
off, so getsockopt() always reports which of the two is active.

On SOCK_STREAM sockets recvmsg() only stops merging data at a thread
boundary when the receiver asked for a thread pidfd. For SO_PASSCRED and
SO_PASSPIDFD receivers all threads of one process remain a single
writer.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/alpha/include/uapi/asm/socket.h  |  2 ++
 arch/mips/include/uapi/asm/socket.h   |  2 ++
 arch/parisc/include/uapi/asm/socket.h |  2 ++
 arch/sparc/include/uapi/asm/socket.h  |  2 ++
 include/net/sock.h                    | 10 +++++++++-
 include/uapi/asm-generic/socket.h     |  2 ++
 net/core/scm.c                        | 19 +++++++++++++------
 net/core/sock.c                       | 26 ++++++++++++++++++++++++--
 net/unix/af_unix.c                    | 11 ++++++++---
 9 files changed, 64 insertions(+), 12 deletions(-)

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
 
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 51185222aac2..fc09c92e8a83 100644
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
@@ -2986,6 +2988,12 @@ static inline bool sk_is_stream_unix(const struct sock *sk)
 	return sk_is_unix(sk) && sk->sk_type == SOCK_STREAM;
 }
 
+/* SO_PASSPIDFD or SO_PASSPIDFD_THREAD asked for an SCM_PIDFD. */
+static inline bool sk_scm_pidfd_wanted(const struct sock *sk)
+{
+	return sk->sk_scm_pidfd || sk->sk_scm_pidfd_thread;
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
index 9b9e119c353a..d69768414af4 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -499,9 +499,13 @@ static bool scm_has_secdata(struct sock *sk)
 }
 #endif
 
-static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
+static void scm_pidfd_recv(struct sock *sk, struct msghdr *msg,
+			   struct scm_cookie *scm)
 {
+	enum pid_type type = sk->sk_scm_pidfd_thread ? PIDTYPE_PID : PIDTYPE_TGID;
+	struct pid *pid = scm->pid[type];
 	struct file *pidfd_file = NULL;
+	unsigned int flags = PIDFD_STALE;
 	int len, pidfd;
 
 	/* put_cmsg() doesn't return an error if CMSG is truncated,
@@ -517,10 +521,13 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
 		return;
 	}
 
-	if (!scm->pid[PIDTYPE_TGID])
+	if (!pid)
 		return;
 
-	pidfd = pidfd_prepare(scm->pid[PIDTYPE_TGID], PIDFD_STALE, &pidfd_file);
+	if (type == PIDTYPE_PID)
+		flags |= PIDFD_THREAD;
+
+	pidfd = pidfd_prepare(pid, flags, &pidfd_file);
 
 	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
 		if (pidfd_file) {
@@ -539,7 +546,7 @@ static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
 			      struct scm_cookie *scm, int flags)
 {
 	if (!msg->msg_control) {
-		if (sk->sk_scm_credentials || sk->sk_scm_pidfd ||
+		if (sk->sk_scm_credentials || sk_scm_pidfd_wanted(sk) ||
 		    scm->fp || scm_has_secdata(sk))
 			msg->msg_flags |= MSG_CTRUNC;
 
@@ -586,8 +593,8 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 		scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc));
 	}
 
-	if (sock->sk->sk_scm_pidfd)
-		scm_pidfd_recv(msg, scm);
+	if (sk_scm_pidfd_wanted(sock->sk))
+		scm_pidfd_recv(sock->sk, msg, scm);
 
 	scm_destroy_cred(scm);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 1ad41904db25..f9615b0de10e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1571,10 +1571,25 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PASSPIDFD:
-		if (sk_is_unix(sk))
+		if (sk_is_unix(sk)) {
+			/* Mutually exclusive with SO_PASSPIDFD_THREAD. */
 			sk->sk_scm_pidfd = valbool;
-		else
+			if (valbool)
+				sk->sk_scm_pidfd_thread = 0;
+		} else {
+			ret = -EOPNOTSUPP;
+		}
+		break;
+
+	case SO_PASSPIDFD_THREAD:
+		if (sk_is_unix(sk)) {
+			/* Mutually exclusive with SO_PASSPIDFD. */
+			sk->sk_scm_pidfd_thread = valbool;
+			if (valbool)
+				sk->sk_scm_pidfd = 0;
+		} else {
 			ret = -EOPNOTSUPP;
+		}
 		break;
 
 	case SO_PASSRIGHTS:
@@ -1892,6 +1907,13 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
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
index 011af84e3626..468a9c479b87 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -803,7 +803,7 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 
 static bool unix_may_passcred(const struct sock *sk)
 {
-	return sk->sk_scm_credentials || sk->sk_scm_pidfd;
+	return sk->sk_scm_credentials || sk_scm_pidfd_wanted(sk);
 }
 
 static int unix_listen(struct socket *sock, int backlog)
@@ -2048,9 +2048,14 @@ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
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
@@ -3029,7 +3034,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 		if (check_creds) {
 			/* Never glue messages from different writers */
-			if (!unix_skb_scm_eq(skb, &scm))
+			if (!unix_skb_scm_eq(sk, skb, &scm))
 				break;
 		} else if (unix_may_passcred(sk)) {
 			/* Copy credentials */

-- 
2.53.0

