Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3114C10F1
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212996; cv=none; b=gbeL6rd+wrSWbfWxDojM4T6fGghTsDvCFe07cnqnFTVfjH/m7OvXb+K6XTVEfCFfJYQiZPdo0GqFsawfnjB11IaH1trOuP6O24w1DAwdjBtDm/FxjWWUVsPp+3HJaxY0aZMxyg0kvtKH+LSUJu4BEDFckD84nrWePw9qP91q+UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212996; c=relaxed/simple;
	bh=XyVR6Z39eA5zyjac0UsK09fwwnAKlUDpWY2E2WEE91c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGbO48ZVeJPum0cqBclbrKsHL6sHWJlDQULA+rI+k3kZspZM802IQ39QuopLw8IpAk+Y/1CvarMTdeOBSwjr0pAQKp9ubw3spjLE2EE5H2bOHh1lx8zLNL1fhPufIS9JksGGPexuBkhOKMo74uf70/oPhZx9R/X/JLth8Kz7YiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=aHGLU/Lu; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="aHGLU/Lu"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8a83d2706fdso14895847b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 08:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791212991; x=1791817791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vlXzFGZotE9UMMZtn0AdDxO1akAHhbmhs0KxtWboHE0=;
        b=aHGLU/LuWwxbroKB1zrfzRGCdPQmk/7oFDjXLr2iog2SLAccQGFAFi8NypKqKS+lQw
         xT6/FQ0kKvDfIwdCLxxoUberjL/tt//2BGo60xvqBeThM7bPhfv5hGdH6oyxs9ZflDzh
         gi/lY5QWTb1dirt6QOzVQhxo138Kkvcxa42sBIcpevL/w2IPH8DhxK4HPutZAQSltcQt
         joww1z2v3aktuSUHzzFpob8cMLQzay4cHXrXcQp6Q26WUF4BkzMeSzDlEpG4w3aWPbfs
         JYfERj5ecqqKILO1TJvg5czl2FvdsYHxaIL0m16XbNQ6dAnkok5DPdxvp5VTfoBAMqS3
         zh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212991; x=1791817791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vlXzFGZotE9UMMZtn0AdDxO1akAHhbmhs0KxtWboHE0=;
        b=17lMeboLICcalZK3JTA3Zy8VV+2Azi3F8pHLd9/ofqjNtVW7ucMIKXrBAGl6XYahq7
         PsRekckGOpFb7ojkUDnZodX1Pe2P1gb48U9YOb391D1QGXJmg1lDguoSblmvDbNhMwYn
         TDXrMzf634tnfJd+AyS1Ew/7uJWk67y8qaulRFUBDG87NR+YlD7l3+m6PhoOHiUOnDCS
         p7NWl51ZFsG3V/0WQ0jtgHDEj05om7Af+Waq4tv7K8BzgT27Wwo0K+UnWQSy1UcQeJ/7
         vyOTbnZ7H27le7IWHS22piGQR36O/ZvC1oP8cfYz8jYAZqGSk74GUgBEMRytToArmOzs
         GCBw==
X-Forwarded-Encrypted: i=1; AKwUvBw4d93iA0h0Y0T83MBy38Sh8n0zP7Zw1ugB9qH4setpmxkmAyyXDP95YMj7iMOiMPha4IG8gPCa8FTT7QUo@vger.kernel.org
X-Gm-Message-State: AFq9FYJDWM3polWgN5NlFLuAYwFXf5c62bxdEP2xfg7vhvNfp1+sNUck
	zILr51hW/VuLJGCNAVOEsWwQHeCee/OaHd9Jsj58O4ZmlJQLbxvMDTeIUzwtcPenfePl
X-Gm-Gg: AYBFou08hT4uHlw+AK/f6W32kFhM+KYIeeYvCXl3m3MAxt6JQz+oRwB9J8XbAntIThM
	KcfV034M6pzxKZUbR0oHyvYJXcLJe3qHhkX8GzvuCZZurtSOoVLtmdKkwy7ogDmkhmDbzeSmk1U
	rWBaZGiFB8axNO8/P/isn/R6y2lPAxLRgt3obKpdQKFxPc0c0QFZsLCVz3ZaooVVBQ3lCCFYu7W
	7Zdxgk7J4NNNr0le+VVkZ6LsVRHf82KJzE9FpbNw/lCmzZSJtL9JK8/rTU9NvhH0R5/pJFy8APK
	ket0OTdD1nRRdfG9AnPm5j/fgLYKD5Tv85lDSC8EYmfx6ZbkKY02zxJVHxIzDerSVHAGJ9tZoxs
	/zdTBOSWcwD0Hm4C0ye/VyJVes2qj+n/hYEFdXzw7uvozxA5FhlSsRK+8ODhF30Xac3YZDbF67o
	o9YtLsZLC//pWGs2Z749Mw1QguAYCyrFKHYHdnff0jyPkukkqpsyc9nQatY2Flciy56XOx1BOLU
	zpWRS6dV/GBiHMMt2fFJXBN/7EZxswPpgmSqqxnQ22GQ4tLSKwiQl8=
X-Received: by 2002:a05:690c:480c:b0:8ab:415c:d733 with SMTP id 00721157ae682-8ae948ab9f8mr27618037b3.7.1791212990698;
        Mon, 05 Oct 2026 08:09:50 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm41210467b3.47.2026.10.05.08.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:09:50 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 05 Oct 2026 10:09:33 -0500
Subject: [PATCH v4 03/10] net: add SO_PASSPIDFD_THREAD to get a
 thread-specific SCM_PIDFD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-work-unix-passpidfd-v4-3-350183b6e02a@amutable.com>
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
 Andrew Halaney <andrew@amutable.com>, Eric Dumazet <edumazet@kernel.org>
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
 include/net/sock.h                    |  4 +++-
 include/uapi/asm-generic/socket.h     |  2 ++
 net/core/scm.c                        | 23 +++++++++++++++++------
 net/core/sock.c                       | 14 ++++++++++++++
 net/unix/af_unix.c                    | 12 +++++++++---
 10 files changed, 58 insertions(+), 14 deletions(-)

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
index 60ea55dc1885..2c4f754b498b 100644
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
index 9b9e119c353a..00025579d53e 100644
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
@@ -540,7 +548,7 @@ static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
 {
 	if (!msg->msg_control) {
 		if (sk->sk_scm_credentials || sk->sk_scm_pidfd ||
-		    scm->fp || scm_has_secdata(sk))
+		    sk->sk_scm_pidfd_thread || scm->fp || scm_has_secdata(sk))
 			msg->msg_flags |= MSG_CTRUNC;
 
 		scm_destroy(scm);
@@ -587,7 +595,10 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (sock->sk->sk_scm_pidfd)
-		scm_pidfd_recv(msg, scm);
+		scm_pidfd_recv(msg, scm, PIDTYPE_TGID, SCM_PIDFD);
+
+	if (sock->sk->sk_scm_pidfd_thread)
+		scm_pidfd_recv(msg, scm, PIDTYPE_PID, SCM_PIDFD_THREAD);
 
 	scm_destroy_cred(scm);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index e8551df8330f..c6f33fcbea43 100644
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
index 64e720bd289b..e44afb059abf 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -803,7 +803,8 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 
 static bool unix_may_passcred(const struct sock *sk)
 {
-	return sk->sk_scm_credentials || sk->sk_scm_pidfd;
+	return sk->sk_scm_credentials || sk->sk_scm_pidfd ||
+		sk->sk_scm_pidfd_thread;
 }
 
 static int unix_listen(struct socket *sock, int backlog)
@@ -2046,9 +2047,14 @@ static int unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
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
@@ -3031,7 +3037,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 		if (check_creds) {
 			/* Never glue messages from different writers */
-			if (!unix_skb_scm_eq(skb, &scm))
+			if (!unix_skb_scm_eq(sk, skb, &scm))
 				break;
 		} else if (unix_may_passcred(sk)) {
 			/* Copy credentials */

-- 
2.55.0

