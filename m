Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CFB3B42E6
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884560; cv=none; b=i4szRPZeoSQ6fdVZcTtLRaqtl06bJCUpfEJ50utrU2/HKke+vZq5Cqdl1zfzC4tiyCKQXBTFbjdvOmeaERE2qt7KqMTWyRMmG7/FjiYnXU9CHmrF2S1NEI8Q5FxIeFPiBCMLDQ8jaMThaJUT1Hoc/F3BsJll7jXYXy0RBB2suwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884560; c=relaxed/simple;
	bh=5ew7vtkhCx25RA4Y2WYl4QUyM9+0YkTmdzM8NfLaeAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJDowwebh3MG0lhRJK7rjPa3zV+w1cDlh/ZyC+ryAdCdscBdTfawh8dvpGOJ/2bdmZKHCcY/hInG6xSszPUwyfWM6yD8bZDc6jkEQ/0aF+BUvn5czRbCMC00ZO76pR1JKqwYkptvedV7wkPmij0hc9E1FNZtRQQ+494oJ1dAHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Gm9nOCaT; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Gm9nOCaT"
X-KPN-MessageId: f8538e4a-7e27-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f8538e4a-7e27-11f1-bfba-00505699b430;
	Sun, 12 Jul 2026 21:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=sruf6qqqWXHR0y2gkzYFVTzl4Yid+EZNc8vc50uaFDI=;
	b=Gm9nOCaTocH34kkTad6D9C+INE9ynJWKupb+il9vysZD6BCYz9D5Z3MNPEchVjoVPtwTquBH+x9L6
	 5gZekx07UvMVF6K80Qwgz280Tu08zYsiAkDKsTJxwD8AKirD930bjOcVIjCfw++G5ZOcElSIgh0g7W
	 bplVh+mysVNApdNJWSMghHGHhQ6IEbbs5m7IBHzdwmzVwnHT9MoCQjZ6Rw2T5Hdi86TIl9uEkrBgPu
	 n6H2wH0uS97JxXwNIJwi/a5SW+KhUszN6I+EBVZ+8Knml2nEzqJ8uPYK5Xz6mImaVIF3axcWowEvt/
	 Zm8oBqqdRX/9Peus6JlJlZjFVI92lOA==
X-KPN-MID: 33|M8e36xt7EPf5XHLZwodcbpL9W7ImY4pamSmps8ikLZU7lWa7+afxr6nipI4TUx4
 Vf14q67qss1ClSkU/EmgGhYqFtUeMGOsWGyTln2kiEWg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|GMSnAkCdtfs8VFwbqjKfxL/MHcOEm9md99JjB8Sv1OIwCvejpp6RM3qI7nsPy3f
 Ywmc9/cxq1VLWglS3H8URdA==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f80febca-7e27-11f1-8dcc-00505699d6e5;
	Sun, 12 Jul 2026 21:29:15 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [net-next v5 3/4] net: af_unix: useful handling of LSM denials on SCM_RIGHTS
Date: Sun, 12 Jul 2026 21:29:57 +0200
Message-ID: <20260712192958.1631672-4-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712192958.1631672-1-jkoolstra@xs4all.nl>
References: <20260712192958.1631672-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Right now if some LSM such as Smack denies an AF_UNIX socket peer to
receive an SCM_RIGHTS fd, the SCM_RIGHTS fd array will be cut short at
that point, and MSG_CTRUNC is set on return of recvmsg(). This is
highly problematic behaviour, because it leaves the receiver
wondering what happened. As per man page MSG_CTRUNC is supposed to
indicate that the control buffer was sized too short, but suddenly
a permission error might result in the exact same flag being set.
Moreover, the receiver has no chance to determine how many fds got
originally sent and how many were suppressed.[1]

Add a SO_RIGHTS_NOTRUNC option to UNIX sockets to enable more useful
handling of LSM denials when receiving SCM_RIGHTS messages: instead of
truncating the message at the first blocked fd, keep every fd slot
and store the LSM errno in the blocked slot.

[1]: https://github.com/uapi-group/kernel-features#useful-handling-of-lsm-denials-on-scm_rights

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 arch/alpha/include/uapi/asm/socket.h  |  2 ++
 arch/mips/include/uapi/asm/socket.h   |  2 ++
 arch/parisc/include/uapi/asm/socket.h |  2 ++
 arch/sparc/include/uapi/asm/socket.h  |  2 ++
 include/net/af_unix.h                 |  1 +
 include/net/scm.h                     | 13 +++------
 include/uapi/asm-generic/socket.h     |  2 ++
 net/compat.c                          |  4 +--
 net/core/scm.c                        | 38 +++++++++++++++++++++++----
 net/unix/af_unix.c                    |  9 +++++++
 10 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index 5ef57f88df6b..946a5fad2691 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -155,6 +155,8 @@
 #define SO_INQ			84
 #define SCM_INQ			SO_INQ
 
+#define SO_RIGHTS_NOTRUNC      85
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 72fb1b006da9..f1641dde135f 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -166,6 +166,8 @@
 #define SO_INQ			84
 #define SCM_INQ			SO_INQ
 
+#define SO_RIGHTS_NOTRUNC      85
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index c16ec36dfee6..f3a3815c7dc2 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -147,6 +147,8 @@
 #define SO_INQ			0x4052
 #define SCM_INQ			SO_INQ
 
+#define SO_RIGHTS_NOTRUNC	0x4053
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 71befa109e1c..7907f3b1f0ee 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -148,6 +148,8 @@
 #define SO_INQ                   0x005d
 #define SCM_INQ                  SO_INQ
 
+#define SO_RIGHTS_NOTRUNC        0x005e
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 34f53dde65ce..bb1b3dee02e8 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -49,6 +49,7 @@ struct unix_sock {
 	struct scm_stat		scm_stat;
 	int			inq_len;
 	bool			recvmsg_inq;
+	bool			scm_rights_notrunc;
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	struct sk_buff		*oob_skb;
 #endif
diff --git a/include/net/scm.h b/include/net/scm.h
index c52519669349..86ae6bc109ec 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -50,8 +50,8 @@ struct scm_cookie {
 #endif
 };
 
-void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
-void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
+void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc);
+void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, bool notrunc);
 int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm);
 void __scm_destroy(struct scm_cookie *scm);
 struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
@@ -107,13 +107,8 @@ void scm_recv(struct socket *sock, struct msghdr *msg,
 void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 		   struct scm_cookie *scm, int flags);
 
-static inline int scm_recv_one_fd(struct file *f, int __user *ufd,
-				  unsigned int flags)
-{
-	if (!ufd)
-		return -EFAULT;
-	return receive_fd(f, ufd, flags);
-}
+int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
+		    bool notrunc);
 
 #endif /* __LINUX_NET_SCM_H */
 
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 53b5a8c002b1..84ea7b92936e 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -150,6 +150,8 @@
 #define SO_INQ			84
 #define SCM_INQ			SO_INQ
 
+#define SO_RIGHTS_NOTRUNC	85
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/net/compat.c b/net/compat.c
index d68cf9c3aad5..6bdf4a2c9077 100644
--- a/net/compat.c
+++ b/net/compat.c
@@ -286,7 +286,7 @@ static int scm_max_fds_compat(struct msghdr *msg)
 	return (msg->msg_controllen - sizeof(struct compat_cmsghdr)) / sizeof(int);
 }
 
-void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
+void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm, bool notrunc)
 {
 	struct compat_cmsghdr __user *cm =
 		(struct compat_cmsghdr __user *)msg->msg_control_user;
@@ -296,7 +296,7 @@ void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
 	int err = 0, i;
 
 	for (i = 0; i < fdmax; i++) {
-		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
+		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags, notrunc);
 		if (err < 0)
 			break;
 	}
diff --git a/net/core/scm.c b/net/core/scm.c
index a73b1eb30fd2..f0d44ecdb11f 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -351,7 +351,31 @@ static int scm_max_fds(struct msghdr *msg)
 	return (msg->msg_controllen - sizeof(struct cmsghdr)) / sizeof(int);
 }
 
-void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
+int scm_recv_one_fd(struct file *f, int __user *ufd, unsigned int flags,
+		    bool notrunc)
+{
+	int error;
+
+	if (!ufd)
+		return -EFAULT;
+
+	error = security_file_receive(f);
+	if (error)
+		return notrunc ? put_user(error, ufd) : error;
+
+	FD_PREPARE(fdf, flags, get_file(f));
+	if (fdf.err)
+		return fdf.err;
+
+	error = put_user(fd_prepare_fd(fdf), ufd);
+	if (error)
+		return error;
+
+	__receive_sock(fd_prepare_file(fdf));
+	return fd_publish(fdf);
+}
+
+void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm, bool notrunc)
 {
 	struct cmsghdr __user *cm =
 		(__force struct cmsghdr __user *)msg->msg_control_user;
@@ -365,12 +389,12 @@ void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
 		return;
 
 	if (msg->msg_flags & MSG_CMSG_COMPAT) {
-		scm_detach_fds_compat(msg, scm);
+		scm_detach_fds_compat(msg, scm, notrunc);
 		return;
 	}
 
 	for (i = 0; i < fdmax; i++) {
-		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
+		err = scm_recv_one_fd(scm->fp->fp[i], cmsg_data + i, o_flags, notrunc);
 		if (err < 0)
 			break;
 	}
@@ -542,8 +566,12 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 	if (!__scm_recv_common(sock->sk, msg, scm, flags))
 		return;
 
-	if (scm->fp)
-		scm_detach_fds(msg, scm);
+	if (scm->fp) {
+		struct unix_sock *u;
+
+		u = unix_sk(sock->sk);
+		scm_detach_fds(msg, scm, READ_ONCE(u->scm_rights_notrunc));
+	}
 
 	if (sock->sk->sk_scm_pidfd)
 		scm_pidfd_recv(msg, scm);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3d256255085b..e7b3aab2f176 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -921,6 +921,7 @@ static bool unix_custom_sockopt(int optname)
 {
 	switch (optname) {
 	case SO_INQ:
+	case SO_RIGHTS_NOTRUNC:
 		return true;
 	default:
 		return false;
@@ -956,6 +957,14 @@ static int unix_setsockopt(struct socket *sock, int level, int optname,
 
 		WRITE_ONCE(u->recvmsg_inq, val);
 		break;
+
+	case SO_RIGHTS_NOTRUNC:
+		if (val > 1 || val < 0)
+			return -EINVAL;
+
+		WRITE_ONCE(u->scm_rights_notrunc, val);
+		break;
+
 	default:
 		return -ENOPROTOOPT;
 	}
-- 
2.55.0

