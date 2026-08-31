Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D23CC7EA;
	Mon, 31 Aug 2026 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175314; cv=none; b=tHQkcCg8o54i8gqEzSZWXWi64RSdpOskyXAwi+yyX2EA/hMBTCqFAIGFUgVHYOnGsHXMoPtDRNXu0zUu6ICZOdKF7Mv4Rz1cnTk+1unYRWcMKDKyLNgDeHPeF4EM34b6TvcUXjPWaiqcDHwTVhXg/8aTQ13pdkvSEfiZtNBYlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175314; c=relaxed/simple;
	bh=qlgstd7gjMVLDTmM6iuC7d3Y90wNHKV1PsuqEuP5Q0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RgNaKM58EzLuyDqPFdwmYWBZHbUVxPi+LgfhfCYpXTggPFChnXqBjW7pezde7xGXCSSIUulGqJkKhk5pwfKqNe4nu/cHazZ6KFlekN129C/FfzF+zMNa657m2SWBfPnf82crAOMo9GEYVRipU/J/XbqSo+P/9uiyojF3hsOC82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csUqez2o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csUqez2o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6721F00A3D;
	Mon, 31 Aug 2026 11:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175312;
	bh=3fCLdlzZ/S81TJajr8WSen6qbEgo3zYGkQoCY1jFZCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=csUqez2ozgqbRZc9ECjkfpHWc63h/cj5nBR794aKxzyUoyXaR/8d/5pko+ZGhJyfk
	 nCOWMzhdfz2lwv6FWgzqZ2zVO3LYiwdnBCYFIIhZvdjDdIXokgHn0HDncSPcpaBSPG
	 KtxN0Nm3KN/8F9gL4k4UUu2eL2PS2zmO1NlC5O0wA9rHuqLKKqyJcBBqcgt5DVJG+L
	 XuEOGn174a6F14Ng1gPgOBMAmriW+ysEaPnEAnFxvKJF/5i1mC/2uRxkV8K+sZ+McQ
	 XYasMUOw1OJMBzy0sjy9mrc/BBHBP+nAxqeyPbZ2npg/kzAyVWuAWCfABliM5NE1FN
	 GX2pen6/WHfNg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 31 Aug 2026 13:21:19 +0200
Subject: [PATCH 07/10] net: add SO_PEERPIDFD_THREAD to get a
 thread-specific pidfd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-work-unix-passpidfd-v1-7-70cbfda0c7ba@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5888; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qlgstd7gjMVLDTmM6iuC7d3Y90wNHKV1PsuqEuP5Q0k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNTd547nvDu1LbKktDlY6jZq+l/a6/0/OMtmmNZHkb0
 LSjlL2mo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCK/LBn+afOWr2rT+eavKPt9
 Xxib2ze/nG6G0nv5NuLTlFwXxxw9wshwzFNnzh0DrZac3m62TzM1cqYWmDfZnT3w5EbEvsMWHJL
 MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

SO_PEERPIDFD hands out a pidfd for the thread-group that called
connect() or socketpair(). Enable workloads such as the coredump server
or a broker to get a pidfd of the specific thread that connected to the
socket.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/alpha/include/uapi/asm/socket.h  |  2 +
 arch/mips/include/uapi/asm/socket.h   |  2 +
 arch/parisc/include/uapi/asm/socket.h |  2 +
 arch/sparc/include/uapi/asm/socket.h  |  2 +
 include/uapi/asm-generic/socket.h     |  2 +
 net/core/sock.c                       | 87 ++++++++++++++++++++---------------
 net/unix/af_unix.c                    |  1 +
 7 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index bb3d534826bb..5d3524c26b2b 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -159,6 +159,8 @@
 
 #define SO_PASSPIDFD_THREAD    86
 
+#define SO_PEERPIDFD_THREAD    87
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 269badcaa086..245a43f52fb1 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -170,6 +170,8 @@
 
 #define SO_PASSPIDFD_THREAD    86
 
+#define SO_PEERPIDFD_THREAD    87
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index 313aee10a52c..f23710e1c671 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -151,6 +151,8 @@
 
 #define SO_PASSPIDFD_THREAD	0x4054
 
+#define SO_PEERPIDFD_THREAD	0x4055
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index bd3e69bcce7a..b35b25bdefc2 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -152,6 +152,8 @@
 
 #define SO_PASSPIDFD_THREAD      0x005f
 
+#define SO_PEERPIDFD_THREAD      0x0060
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index d1e5c6de146d..56fed7ab27ab 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -154,6 +154,8 @@
 
 #define SO_PASSPIDFD_THREAD	86
 
+#define SO_PEERPIDFD_THREAD	87
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/core/sock.c b/net/core/sock.c
index 6ada7e7eb7d7..cb2ffd329bc6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1743,6 +1743,50 @@ static int groups_to_user(sockptr_t dst, const struct group_info *src)
 	return 0;
 }
 
+/* Hand out a pidfd for @type of the socket's peer via SO_PEERPIDFD*. */
+static int sk_getsockopt_peerpidfd(struct sock *sk, enum pid_type type,
+				   sockptr_t optval, sockptr_t optlen, int len)
+{
+	struct file *pidfd_file = NULL;
+	unsigned int flags = 0;
+	struct pid *peer_pid;
+	int pidfd;
+
+	if (len > sizeof(pidfd))
+		len = sizeof(pidfd);
+
+	spin_lock(&sk->sk_peer_lock);
+	peer_pid = get_pid(sk->sk_peer_pid[type]);
+	spin_unlock(&sk->sk_peer_lock);
+
+	if (!peer_pid)
+		return -ENODATA;
+
+	/* The use of PIDFD_STALE requires stashing of struct pid on pidfs
+	 * with pidfs_register_pid() and only AF_UNIX were prepared for this.
+	 */
+	if (sk->sk_family == AF_UNIX)
+		flags |= PIDFD_STALE;
+	if (type == PIDTYPE_PID)
+		flags |= PIDFD_THREAD;
+
+	pidfd = pidfd_prepare(peer_pid, flags, &pidfd_file);
+	put_pid(peer_pid);
+	if (pidfd < 0)
+		return pidfd;
+
+	if (copy_to_sockptr(optval, &pidfd, len) ||
+	    copy_to_sockptr(optlen, &len, sizeof(int))) {
+		put_unused_fd(pidfd);
+		fput(pidfd_file);
+
+		return -EFAULT;
+	}
+
+	fd_install(pidfd, pidfd_file);
+	return 0;
+}
+
 int sk_getsockopt(struct sock *sk, int level, int optname,
 		  sockptr_t optval, sockptr_t optlen)
 {
@@ -1938,45 +1982,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 	}
 
 	case SO_PEERPIDFD:
-	{
-		struct pid *peer_pid;
-		struct file *pidfd_file = NULL;
-		unsigned int flags = 0;
-		int pidfd;
-
-		if (len > sizeof(pidfd))
-			len = sizeof(pidfd);
-
-		spin_lock(&sk->sk_peer_lock);
-		peer_pid = get_pid(sk->sk_peer_pid[PIDTYPE_TGID]);
-		spin_unlock(&sk->sk_peer_lock);
-
-		if (!peer_pid)
-			return -ENODATA;
-
-		/* The use of PIDFD_STALE requires stashing of struct pid
-		 * on pidfs with pidfs_register_pid() and only AF_UNIX
-		 * were prepared for this.
-		 */
-		if (sk->sk_family == AF_UNIX)
-			flags = PIDFD_STALE;
+		return sk_getsockopt_peerpidfd(sk, PIDTYPE_TGID, optval, optlen, len);
 
-		pidfd = pidfd_prepare(peer_pid, flags, &pidfd_file);
-		put_pid(peer_pid);
-		if (pidfd < 0)
-			return pidfd;
-
-		if (copy_to_sockptr(optval, &pidfd, len) ||
-		    copy_to_sockptr(optlen, &len, sizeof(int))) {
-			put_unused_fd(pidfd);
-			fput(pidfd_file);
-
-			return -EFAULT;
-		}
+	case SO_PEERPIDFD_THREAD:
+		/* Only AF_UNIX records the peer's connecting thread. */
+		if (!sk_is_unix(sk))
+			return -EOPNOTSUPP;
 
-		fd_install(pidfd, pidfd_file);
-		return 0;
-	}
+		return sk_getsockopt_peerpidfd(sk, PIDTYPE_PID, optval, optlen, len);
 
 	case SO_PEERGROUPS:
 	{
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d01ee76c8026..563d9827c5cc 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1056,6 +1056,7 @@ static bool unix_bpf_bypass_getsockopt(int level, int optname)
 	if (level == SOL_SOCKET) {
 		switch (optname) {
 		case SO_PEERPIDFD:
+		case SO_PEERPIDFD_THREAD:
 			return true;
 		default:
 			return false;

-- 
2.53.0

