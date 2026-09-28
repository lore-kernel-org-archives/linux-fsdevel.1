Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5A48F85A
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587669; cv=none; b=YhShuCiV3b0DOILWrrH6oyy1mNeipoVgkcj+6uOEe05xFO6Zp1AXwyWNviCiLUWaxWHwnj/tP2E/qVwCYHFAHVw85VCJsZrDwZOPhalbrbLQmK5iNDJzGpMsM5uu2e/x3KdyEyl85Yu8ZNZGcgcA6um3rcTzGgzMRYV+gAEBls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587669; c=relaxed/simple;
	bh=c1qhLL0thzNwLIlM1QYszVXFAVtnDo+nY3WMBxk8jRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcZOm8Tk8iJFbUpI8oCi8WjZbHxpCzn3AM5527bK8s2mvuIbnxcLtZ0qnoYnTGt56gddO1LgCvHQjevxGq0c/i9xmmyEWTzHH/0LUkN5MtmaWf5uK44VliOkES62ikRzo+vBUKOe75UgARub1PpjXP97HHecfuDwcJQRQBiCftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=zaCzK2fr; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="zaCzK2fr"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2dc50c6eccso138676566b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1790587663; x=1791192463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C1t18H5a7fnu/1Aac6tNpx9pwjEGhHPfRk234flruY8=;
        b=zaCzK2frgoD8gXPylRA1NVkeXlcGny/7NdgdJvl8KJC//CFzPuDBzf4nG6EYUttNc6
         6lphYiUWXmuvthgEfwLHXaAhdeI8lTdL9OF9Zfjv54hvtTk7xbS364cmtkJ6yoIoXjlN
         Lj7XIPYOlvrVOR+swb3kLdeu72e0FuvvyO3WQ7ehwJiQ9M/0Js35+DYPzN9FwQzd0gIS
         XYed6iFjw81CmU6mYUnV4bVM8ZYz1QI4IsFlT8A5eNXbYroDO+voSzo6mx8G2rvVa16L
         ZU7ZEven+ydINacwqcQ6cSSDxTetvQOxP+hwGu2yJZqtg07KgE6dql/8D8zp0zng8icf
         hUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587663; x=1791192463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C1t18H5a7fnu/1Aac6tNpx9pwjEGhHPfRk234flruY8=;
        b=piHJOMmAB2zpTm3XABfWeZfFeaLJ9NWSR5Y9RJvHGgkSLtfzq7DKqvPsBVNoht1iRc
         E4bAI5buWwuNexUhCpoZx/Z1tX215FfkhqyOVoOg5hXHtisI2It8ykFa2hN5u2IrryK2
         WudAHdsVIXAArQ41ky2ULJqWs4dMw2vzDsUmmTszjIIfcthWoUOqUFMGkzvkteBA5Z1h
         wiBBxfWFUqSFlUhkWUIFWlAiRTeFJMhUEfjdw8eM1bMYa43AuFi5QY1GuEUZt6sXmrbz
         O5YrgG9Q6T8Q9lNUP1QnFP8EOWxzLRycmnb0t6e1JQj5oAUhLPw0C0UDy2MUIwuEY5C5
         +ZOg==
X-Forwarded-Encrypted: i=1; AKwUvBw9Mxqq/mo+AARli8VgjqND6ZYMeNy55QWE/50+YYbfUfc/BJ4TgF3yctW4PymjSByCtvuRHH97UKcYzxyC@vger.kernel.org
X-Gm-Message-State: AFuF++lp5RQlDWuOs+A9zuCtoyp5xvR9rTSehpASvNd2DPVpnvjmwfiI
	jsI4zS90/saHvc0O8VMyGskdkYqkGAjmblYYF6qTzFPg9P0EqUga2WHYWp+m/1kFghNK8be2hjW
	vv2Y7Hvnu
X-Gm-Gg: AYBFou1w88NgJKns/TMps6QcRq9xbX4Ssr2cvhF4KXyx6+N03mHF0Guhggwo5WTHZWC
	lcK8AGBIIj517r7vvRlkTxwFi4jEfDyhNuMO3XWOjaHaKqiVjSDaYNCntmfcIqEn4K66dRl8NH8
	WZiRbIhjLSvGFV5kyP80JizNPkJP63XIyqTAsrLtNyAKSjfT8PgCJlsLHzzB2/e7/5LHF3OUAZ9
	uaKVVy/rVXQawlpME4Nj/FqIUMh01GgOYn2Eh/KFaLiWIOKZhqruAXwnvUo1YocBXHVABq1liGY
	ID10UZl9RTttTITxYqaoSLehcuFSmx9KMswpBh33uAvs3KlZsK8me50KjeY1uB4/dxT0BKl9VbQ
	HhRSaYH4vdLitppiRAF34d9GeUIK9tprEqvesb4RQKu6awe0OHGAO+7FrEaOw1YCruhK67VvytJ
	98ySbfGi4MdZ3x7upC8YrNXtZ/5/0aySOI6afrEqnVhy/Y55mJvo0+VSokkAS+29s89tDbvRgZb
	YtpNWOxdra0Hl3tmp8S1G3FR1c8PWIQ+B3X9iYgWw==
X-Received: by 2002:a17:907:1c9e:b0:c29:53eb:9919 with SMTP id a640c23a62f3a-c2ac256d4f5mr1002327466b.40.1790587662789;
        Mon, 28 Sep 2026 02:27:42 -0700 (PDT)
Received: from [169.254.24.37] (tmo-085-169.customers.d1-online.com. [80.187.85.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm205609466b.1.2026.09.28.02.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:27:42 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 28 Sep 2026 11:27:14 +0200
Subject: [PATCH v3 07/10] net: add SO_PEERPIDFD_THREAD to get a
 thread-specific pidfd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-work-unix-passpidfd-v3-7-532018a91b21@amutable.com>
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

SO_PEERPIDFD hands out a pidfd for the thread-group that called
connect() or socketpair(). Enable workloads such as the coredump server
or a broker to get a pidfd of the specific thread that connected to the
socket.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
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
index dfe98463ad0e..c970f8beae3b 100644
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
index 634db1b40ecb..54f122952979 100644
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

