Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165944C2272
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213006; cv=none; b=TIxwM3eB5t3heMyTudW/1akKnrjtj921hegyhIhgb64guGzH5ng5vOitj/P+oeDo5qIxkA++0mgExov/cThwmUHxYSAM7N/WPapM7yOWLgP0toHiV8Z2pjB1CgqHTsfWoFrjm7NcZYbhQXAjxdMGEHoB4TNWKNH19h8/a2+DgHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213006; c=relaxed/simple;
	bh=lh8Uj5/HTWmrM3098nwpRn0bWxzAmOxHCQsvzJebOiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4FAn4oowfVG5QTy4kpEmNg2hchV0P/1FNOPcncunFVR3Cr1uo1DfTgkM6Izo5b9H2oY5lIvN7OyzQgcvjeeglRZpmb/jL9Txck6w14paQLxHZXj9v7XSo19qi6vz6CD5oDzTLNqUxJG6rzny4vkUQedMKXAH4eLyfJwjXDD3K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=vpV7PLWg; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="vpV7PLWg"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab41af29caso13030477b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791212997; x=1791817797; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pt9qwQguxn5DjupE0KmFNfz1uVD//r//TW2Mkdp0NpU=;
        b=vpV7PLWg2kcdONdbUZjtU0L/SPgVq25puKeG5zzEI+BuukUFZjJi8f8DVhUGZZhduj
         iSU6Bz/2fGC6RWqZlz0IMVpqfswPEUXTJvwjOdGkEuJny1oiwaXizKB5Vh7j24xFGKuI
         IylKQZ5rT2C3qh055GH070NiSLb0AHe3T9kcTE9XrCyNtdlVIKv+8ARgZxyhxynMUw4u
         w8DjUTclyRUPq/gHAks9mercgnQXdFU5rElHp7COexlK1iF+5C5OykGnLuRk2JWz6JsI
         O8WkghEAOHhXPaE9rvKVyOQsiwDDP+e1Oth0z2pKDcJuhjp4HlQA2sSps9j/FToRvYEv
         pZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212997; x=1791817797;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pt9qwQguxn5DjupE0KmFNfz1uVD//r//TW2Mkdp0NpU=;
        b=JAhlCqj9gVCd2E+2jM5R4k4bIuN5R0opmNCLGW6h+XGpMmMUt3nTuPIszSSLUojNgQ
         ntTdNNQKZwR5zlPOMMAVo+ovsZPTkwlbWGckCi8XhB3wXCR4nvG6cB2Aoe/gGNQ4F5eL
         2Gz04HntTx+Xq0Oj5sxJgOxb9w9t2VqaCJQbe6CqJDOBCVe9ydaQBww+vD7Z6GbiHIJg
         ybs4tTf/2a/2mSZoPpoapgL5xm/LRfpe3TKGpjSVFaB+XgjsPDtfLuZFoP69tOkkgCJ4
         We1ggZS2QrpxOSThphTqwOiucEnzLpwYNvkCgZko4eLFwLS0Y5GXLmr8NBSRoMak+jMQ
         2hIg==
X-Forwarded-Encrypted: i=1; AKwUvBwsFNkp9cwi5wMWNhAW17mdxKz/+IBymQVikcYivA+h9lkTRS2UX5msmZPzkValgn46/1xgeWU/SY3V0u7J@vger.kernel.org
X-Gm-Message-State: AFq9FYJALn8dWdfEeH3TJJGUd5TWDqcWYwaVSn1jWt4OvKoqQxnW5YZc
	Jsb49o2PfQTAFU7f+yBF+WTCcP6Z1D0UBq8ETHiFGBFMC3cZXYcD9SOTE2Z+el7G7+gaW5Tw1MD
	9OzT+Sg==
X-Gm-Gg: AYBFou0w6RZLzZODPPWwWUcWKmpZwMqI3tVOAxl0uhnhtZHWDKFZPCMcDSijHRqcom/
	0KmLn9DJes7gJydH0jkySNj7vMlDzJDRVuF6tK3k8Mip9R2k8oi1Ook9pZhS3P+VpEXF1f0fYxC
	bq3pv8VPwzFE+hQhENmTWoJWZANsXqTCOjZEPdG5WrsT/kzrIT8K0VBhgO7FcIkg/G28JSgFosT
	ovO/0wSokC3Jb1RO60gihK0Hlzx0rFf771dWwkQTKhioMmdTEcR837puNfhBraV5SsY4PJOnI4M
	f7iyomeN3xZv9qxDrfvCyQZsKw7kCb0PQVzYAAac3evUDwUkYAfJb6M6eFf728zXCU/7OkRbrhl
	BASCRQEujrhBRV9CcP4LhQ1O8BtiPKBXP9fRhpSpjHpG7k0IfqHh7OsZSvKpKS/sTL8HXNTeZRv
	dIDbp7zpg0+QC0tCRPt8ZeNcHfzyQoKRBXLaTrTTAxsyhy+GA5JtWQDTCtHBnSfuAzvBRW9tB1+
	2+KvK/rxJKrdoa9bFtP7Jp7/YlZud4uELroZCw9+KxC9X5x6nq1X04=
X-Received: by 2002:a05:690c:660e:b0:88f:62ba:512b with SMTP id 00721157ae682-8ae39bc3c87mr49083867b3.42.1791212997199;
        Mon, 05 Oct 2026 08:09:57 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm41210467b3.47.2026.10.05.08.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:09:56 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 05 Oct 2026 10:09:37 -0500
Subject: [PATCH v4 07/10] net: add SO_PEERPIDFD_THREAD to get a
 thread-specific pidfd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-work-unix-passpidfd-v4-7-350183b6e02a@amutable.com>
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

SO_PEERPIDFD hands out a pidfd for the thread-group that called
connect() or socketpair(). Enable workloads such as the coredump server
or a broker to get a pidfd of the specific thread that connected to the
socket.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
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
index f8436e494138..3c25d66ba31a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1736,6 +1736,50 @@ static int groups_to_user(sockptr_t dst, const struct group_info *src)
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
+	 * with pidfs_register_pid() and only AF_UNIX is prepared for this.
+	 */
+	if (sk_is_unix(sk))
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
@@ -1931,45 +1975,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 	}
 
 	case SO_PEERPIDFD:
-	{
-		struct pid *peer_pid;
-		struct file *pidfd_file = NULL;
-		unsigned int flags = 0;
-		int pidfd;
+		return sk_getsockopt_peerpidfd(sk, PIDTYPE_TGID, optval, optlen, len);
 
-		if (len > sizeof(pidfd))
-			len = sizeof(pidfd);
+	case SO_PEERPIDFD_THREAD:
+		/* Only AF_UNIX records the peer's connecting thread. */
+		if (!sk_is_unix(sk))
+			return -EOPNOTSUPP;
 
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
-
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
-
-		fd_install(pidfd, pidfd_file);
-		return 0;
-	}
+		return sk_getsockopt_peerpidfd(sk, PIDTYPE_PID, optval, optlen, len);
 
 	case SO_PEERGROUPS:
 	{
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index b7d62e61d9c4..a78e8ef3e0b0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1057,6 +1057,7 @@ static bool unix_bpf_bypass_getsockopt(int level, int optname)
 	if (level == SOL_SOCKET) {
 		switch (optname) {
 		case SO_PEERPIDFD:
+		case SO_PEERPIDFD_THREAD:
 			return true;
 		default:
 			return false;

-- 
2.55.0

