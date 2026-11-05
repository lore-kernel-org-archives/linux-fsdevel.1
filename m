Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892326;
	b=rfdc2asfPgIrXlcEdjELDGlb2wAG5R0VWhuPZ8nBFpiE2M0iWc2QUqGmehf5/QpYNjBj
	 suvyFH5I/Z1OV5YVZ0Lb2aUpHcOq2z8Kq0GP1547agQN+iiYMcZvK/oNlnkWihYevmgS7
	 Xv3wiBgP4XXhEUJ0MKCFhJXHi6pqDXQOBFKgNbx1F56TT9E57O1JH6dvQgMUMrsJYDkfC
	 5fO0Bo9/iLmFECxbfH99G7YsRqnkV+grTeHNXnxzp0C9rdF6hmgU9HtmB5TgEDBZlsmdx
	 0Oh+bM8wW0a9S//Y61T7Sn/QYCSoemQIOBXkw0Q6yKa/rPPsWu+LmchexHrI00qjZww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892326;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=71wub0L05hM3JJpdorB68VmX5twzKf91AJhaOYI0rhg=;
	b=hkJ9ghQ07UTsRBF3kJfd5dQtNojpkUEHt3jLc/NHTJr33Mnix/J+H8za+eprmRsLyzeM
	 At9aKWYPmGsZPz6zz/tmehL+4qT46cXEvd4x4Tai40jhdY4qd8MyfZPlTAu2vMc/Xw3CR
	 XIS/yZGHkAx61AacBu2iEGJ4yOIfE1qngsjf4hio9imMlhL6GllbU0/s2J17PVBkX7I1e
	 IwSHZzCOh3FkyYv+vIp8eoezpmQbS2RCpHG3B/1zukjFmBKQA6V4jeAc1n7Ctpxz3LLfU
	 5L++BXRxAkq8Z0egfZfLLTZc6/LVXrG4D66+58hKdttKjkCmxeG4UCJWYo/KUJrHdow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=KKuLKpTz;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53061606D825
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53061606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=KKuLKpTz
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93e55db58cfso210796385a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892325; x=1794497125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=71wub0L05hM3JJpdorB68VmX5twzKf91AJhaOYI0rhg=;
        b=KKuLKpTzsitUYmLTDEd+Ap3fUkQ85mL3rOZwfff5NWbZWMx97AURL69JnbEqjt4Ma0
         TGCPMyx3RMQR8raXetCsDIGs1Us1yCEYnXbfF3TSNC71qZFRBEQzwjpyZ4If3CJ1lj5s
         5pZEpT0sbZ2bHTForcdlvlhXYti8N0f+wMm74cz3fDoee2Q3SVKtpmvIjoukI/MZl6yU
         BGQYRHuQfWnDstBf6emXbWChO8+xOB9ZThXEh0f+6duzXs85lywDz6PNz9aCPDEbf4Fx
         NKiE4Vu081KpG3nu888uiIqaUTcG8pkJBRc2w/gO1RnjqyBIoggEVScuyZDVrtL9UFe1
         Ajug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892325; x=1794497125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=71wub0L05hM3JJpdorB68VmX5twzKf91AJhaOYI0rhg=;
        b=fn2UdleFFqRT4B4LDJ0VdtcO2rUQO4grJJ6ysbKDprS0fFd9WqCNh5T6FcQ8M9nm44
         v2zU0/HelcL9zucdCuwGXrS0yp9ZKQyR92O3hGxLiNCJdAErhvI69VsCS10oEOSa89V7
         kUSiuCz3jmahVnYQ6q7g2Vgq9Vlv8VcuqSQkwMZOR8SBYR0B8GPeJLe9BIX2RMDns1Cb
         /t9JdVBpd3X8RwHVBitQ7U46BBLKAq1L0PMIx8h/NRgk0Ra+mYXZY5gaRb8X3nGc5CSj
         R8Eq1Dck3DvGiXEApcMa7ZGSx1Ee+dbbsCCLpYgFP0APur09SAoZEDNdo+H/o5GGp6A9
         HgXQ==
X-Gm-Message-State: APuU4Z+u67z2Qnhb25aVZh0zWUP2+I6W/VUcI383DcZBflHFFYaDKTC6
	cHe0stbfpbkQydOjxDe6mjGpexOftokidT+TyIsQIEf0GnPsEwfYDGjrpcm127SDIFA=
X-Gm-Gg: AYBFou2kIKz08++zmlJhI43Cg6BEOY5Ymr7CmzBF4W1wnq4Gbta9pPi55xozZS4gI1T
	2QhiHdwbsyOfz3THjLo27ZpfXTn62YNA6uAUApVOkNTpHNRkEzSA0L8rOxpPZPVEGTM0LiDBFkJ
	4/EBiFuozUdZqbFMn62Hvg+QSDxuNj0fucjIsXsGx8W+skqvGlx/RAe2i3x+ZYejHu0g3n7t8CI
	4nB99VFXtYoifbcGVRHBplrE0oJL/1hlfNSHWWO4Y6wGTT07IQYkp+Hy4IYc0an46NBAGwM+vUa
	PsMmXdc96+xJXiL6OViMbqOJSFvs0BSYsNL4/ZmrDkA3pUZEa4ibZZEr6zSIXx5tI/cEpT7eb86
	NBOg0GP7czpPEut6Id9lGXMXYcmrrG+Edndv2MWAoJaM+II8F1o7WLrhcys2ZTJwtDh9AhCKuXN
	5zILPOBfm5StW2RiWld5/xM5Q2AlE/fA0ZL4CvObLYD7Kxf0Nt9DRQJ9xgde+gV0vx0i4okPbsX
	gAlvkjQHnOP0OXhSpuevlmXotj8UNbSO89qKkkfDLaMXh7lnIb2o5whk/hXECwpjpX34KafwzqK
	EYPuqmJBcZx+GOIfzfOOlQYq34NJl2lq15nVdeSyEdsuTA==
X-Received: by 2002:a05:620a:254a:b0:93a:10b0:aee7 with SMTP id af79cd13be357-9442175ae3cmr3373311285a.44.1793892325147;
        Thu, 05 Nov 2026 07:25:25 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d48316f4sm482776185a.25.2026.11.05.07.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:25:24 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:00 +0000
Subject: [PATCH RFC v3 68/90] af_unix: tell a sender that control data will
 not cross
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-68-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=6412;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=e0ueTuD4wsozKi3dIGbcQXO+SHMXvxKJN71+NrWZ6h4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAGenU2zm8o4+Ld+iWj14Ou3J8f5y+s2bIElOsfcRzi5ZUdSX7OPF+O2bzpq4kZ4OZ5oXHY8LeH
 RDOr3mLnuEw0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Control data that is sent to another cell is dropped on the receiving
side. It is better for the sender to find out.

Record in each socket the cell that holds it:

  - For a new socket, the cell of its creator.
  - For an accepted socket, the cell of the listener.
  - For a socket that pidfd_configure() gives to a new task, the cell of
    that task, once its exec has succeeded. If the task never starts, the
    socket stays with its current holder.

Sending control data to a socket that is held by another cell fails with
EPERM.

This is only a convenience for the sender. What is delivered is still
decided on the receiving side.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/net/af_unix.h |  4 ++++
 kernel/embryo.c       | 17 ++++++++++++++++
 net/unix/af_unix.c    | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index bb1b3dee02e8..10c1613b4d42 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -14,6 +14,7 @@
 
 #if IS_ENABLED(CONFIG_UNIX)
 struct unix_sock *unix_get_socket(struct file *filp);
+void unix_file_cross_cell(struct file *file, u64 cell_id);
 #else
 static inline struct unix_sock *unix_get_socket(struct file *filp)
 {
@@ -50,6 +51,9 @@ struct unix_sock {
 	int			inq_len;
 	bool			recvmsg_inq;
 	bool			scm_rights_notrunc;
+#ifdef CONFIG_CELLS
+	u64			cell_id;	/* of the cell that holds it */
+#endif
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 	struct sk_buff		*oob_skb;
 #endif
diff --git a/kernel/embryo.c b/kernel/embryo.c
index 657ce07441e0..1f8d0b14e6a4 100644
--- a/kernel/embryo.c
+++ b/kernel/embryo.c
@@ -78,6 +78,7 @@ struct embryo {
 
 	struct pid		*pid;		/* the reference alloc_pid_struct() returned */
 	struct cell		*cell;		/* where the task is going to be */
+	u64			cell_id;	/* of that cell */
 	struct user_namespace	*user_ns;	/* likewise */
 
 	int			result;
@@ -126,6 +127,19 @@ static int embryo_install_fds(struct embryo *e)
 	return 0;
 }
 
+/*
+ * The exec went through, so these ends are the cell's from here on. Not any
+ * earlier: a socket that was to go to a task which never started stays with
+ * whoever has it.
+ */
+static void embryo_fds_crossed(struct embryo *e)
+{
+	unsigned int i;
+
+	for (i = 0; i < e->nr_fds; i++)
+		unix_file_cross_cell(e->fds[i].file, e->cell_id);
+}
+
 /*
  * What was configured has been used, or never will be. The pidfd may be around
  * for long, and must not keep the other end of a pipe from seeing the last
@@ -241,6 +255,8 @@ static int embryo_main(void *arg)
 
 	/* @started is set, so nobody changes anything any more. */
 	ret = embryo_exec(e);
+	if (!ret)
+		embryo_fds_crossed(e);
 	embryo_drop_config(e);
 	/*
 	 * A signal to the embryo is no signal to whoever started it. Whatever
@@ -356,6 +372,7 @@ int embryo_pidfd_open(int cfd, unsigned int flags)
 	}
 	e->pid = alloc_pid_struct(cell_nsproxy(cell)->pid_ns_for_children);
 	e->cell = cell_get(cell);
+	e->cell_id = cell_id(cell);
 	e->user_ns = get_user_ns(cell_user_ns(cell));
 	cell_fork_finish(cell);
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 58fef56c0f7e..198898b86c1c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -829,6 +829,49 @@ static inline u64 unix_skb_cell(const struct sk_buff *skb) { return 0; }
 static inline bool unix_skb_foreign(const struct sk_buff *skb) { return false; }
 #endif
 
+/*
+ * A sender is told right away that control data will not arrive, where that can
+ * be known: each socket records the cell that holds it. That is a courtesy. The
+ * rule above is what counts.
+ */
+#ifdef CONFIG_CELLS
+static inline bool unix_sk_foreign(const struct sock *other)
+{
+	return READ_ONCE(unix_sk(other)->cell_id) != current_cell_id();
+}
+
+static inline void unix_sk_set_cell(struct sock *sk, u64 cell_id)
+{
+	WRITE_ONCE(unix_sk(sk)->cell_id, cell_id);
+}
+
+static inline u64 unix_sk_cell(const struct sock *sk)
+{
+	return READ_ONCE(unix_sk(sk)->cell_id);
+}
+
+/**
+ * unix_file_cross_cell - a file is being given to a task of another cell
+ * @file:    any file
+ * @cell_id: the id of that cell
+ *
+ * If @file is a unix socket, it is held by that cell from here on. This only
+ * serves to tell a sender early that control data will not arrive. Whether it
+ * does is decided where it is received.
+ */
+void unix_file_cross_cell(struct file *file, u64 cell_id)
+{
+	struct unix_sock *u = unix_get_socket(file);
+
+	if (u)
+		unix_sk_set_cell(&u->sk, cell_id);
+}
+#else
+static inline bool unix_sk_foreign(const struct sock *other) { return false; }
+static inline void unix_sk_set_cell(struct sock *sk, u64 cell_id) { }
+static inline u64 unix_sk_cell(const struct sock *sk) { return 0; }
+#endif
+
 static bool unix_may_passcred(const struct sock *sk)
 {
 	return sk->sk_scm_credentials || sk->sk_scm_pidfd ||
@@ -1146,6 +1189,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sock_init_data(sock, sk);
 
 	sk->sk_scm_rights	= 1;
+	unix_sk_set_cell(sk, current_cell_id());
 	sk->sk_hash		= unix_unbound_hash(sk);
 	sk->sk_allocation	= GFP_KERNEL_ACCOUNT;
 	sk->sk_write_space	= unix_write_space;
@@ -1777,6 +1821,8 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr_unsized *uad
 	newsk->sk_state = TCP_ESTABLISHED;
 	newsk->sk_type = sk->sk_type;
 	newsk->sk_scm_recv_flags = other->sk_scm_recv_flags;
+	/* It is the listener's end, whoever made it. */
+	unix_sk_set_cell(newsk, unix_sk_cell(other));
 	init_peercred(newsk, &peercred);
 
 	newu = unix_sk(newsk);
@@ -2284,6 +2330,11 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_unlock;
 	}
 
+	if (msg->msg_controllen && unix_sk_foreign(other)) {
+		err = -EPERM;
+		goto out_unlock;
+	}
+
 	if (sk->sk_type != SOCK_SEQPACKET) {
 		err = security_unix_may_send(sk->sk_socket, other->sk_socket);
 		if (err)
@@ -2456,6 +2507,11 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	otheru = unix_sk(other);
 
+	if (msg->msg_controllen && unix_sk_foreign(other)) {
+		err = -EPERM;
+		goto out_err;
+	}
+
 	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 		goto out_pipe;
 

-- 
2.55.0

