Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892347;
	b=thmgvOjHQL1odRt2Nx5lfSIYWAPTovZzih9mUE8OW82DfAg7JACShA6lv8dLimq9ExXe
	 YgmDsxKwW/5fy0ePrZ6B1xohYkeAcNXnpeGknqVKDz7WrD2BNln29ZbS6Rvr95brYjEMZ
	 V1nBylzSVrd+sQUrlw20C+QNlGH+/FzX5I1GO+3m6aEACWsVSP3bdRbbcTKVSQCcW03ES
	 hmHKLvIslo8WCZjpqItqS0PBi2kRXT/TjgcR3YTy5lHe7pZRP/b5a/x7askzxLLkm2yY/
	 Mo58KfFqS1ZkFMYlkiZLc9gQ/i5f8AXap8Tc4fHqcHsPPxTexrsypp43ofr8qy8QC7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=hKxHGUslAarNQWqFnxVqWnqjb6lopyxJdeZR+xUedOo=;
	b=TF8atPifcZOBYaihhrYO0tcqLZ9uLVBQDSO1oMyFOkfNaVe92kZevekN/uHPhW0cuAdZ
	 E1NukkoqXOk+6d6oss7Nd0ZWmHAERnvXmEARwAcTfv9HYm6o1J+sFcIVw/zh37P6ENJON
	 5FykeRmArl7s5D0zx5KDNctVBnnnaNLh9qtOI9yTAIWAFaD6DjZ2MjyHbz39laM09MAv6
	 5g7auz6JtW5UxnOn5d84h6bwt9WCDB/hnkaSdpBbtyZq3nwpf64XPj05oHJAb2icr84KB
	 S/uRyUJ25UVa4ZR/j+9G/jjcYxwzofOvhRh0RuKv2/0rY6+EwZ+9VwRjv+owz7HRc6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=iMWwHhTF;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C382606A333
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C382606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=iMWwHhTF
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53397554beaso18930561cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892346; x=1794497146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hKxHGUslAarNQWqFnxVqWnqjb6lopyxJdeZR+xUedOo=;
        b=iMWwHhTFNUUgpdEZFPB35Glo0UKBW+QJgm3zBNtH8ANYAhVfTXKN3CqJ/XGeDqYkjC
         5ecckkS5ji1jkU4ifVEB1u1qRupDY+ADBE9u0cQw+x3nQTgaWyV25hH5YjQO98TrZjEP
         W7ReYLDr7YEkKs2ZCZYymNfqq1kuKWEf/Rn36M7vUO6XgMhMlps938Nd1+5ZkA90JZli
         NNB3ZAIldHzxiJvqsTrzQJHTvzdnOsi+OFFmUShi70TfBMBTeVQJqv1RCDZlwHQIOile
         LxVuyBhe8N43RS/l/c2jWpOSq3ZqxOBhDOWe6Ey4xevqAW1/Ch/S1KJOVI280FWZsMsI
         A+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892346; x=1794497146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKxHGUslAarNQWqFnxVqWnqjb6lopyxJdeZR+xUedOo=;
        b=LywQuBlDqe1CC4SJyrl1p1n4axsYCgOpG7Z0MHj7OTZBHAI8u20dEj5XMMyFsrEwuS
         aT4dZwLIn5skafczQFGMmkAZYrnazGP853nt721lLSbzZB1N9P2UcWYfi+y3Xu1UbMVJ
         pqu6S1/RBmExMAzeyt+qsizZqovWxeUTS6Ck0xlYpRXmW3vI2pMwPy32fDRxQYKXijfb
         fFktGDnA8JIr3kxT+kTHlHfqAjSo8C7jYR4DFljo8Q9YGAG9G3YOhVQWi0yebRqp4jZZ
         JCSsKWvha3YpApljIALlUFr/RA/8VVgNtpbAmeObBW1MCLO/9/nPrkvCwOXAD/boZoZL
         BzKg==
X-Gm-Message-State: APuU4Z8QmG9wpAhi/cCzbijMXAgIlD0psAkLRI8w3r6b8JV1ec1VzZv+
	nFV5jmOFl353/TKm9f2gKgMIm62LiHcRSi7rvOqwGXjtrXmzgHFtjK/1zgIRjjoBD94=
X-Gm-Gg: AYBFou30DoLan/IC1WH3TLsXZ0ekWaGhwXvw2DU0LvINn/qy9dhU4siDTRVx6gxTGP+
	GMaxLKKt8ZRRVoh8+h1wsyDwCi2V41onqsKaPPgaLEQoQOZpV9AwMJ6mFEKg9QgGb87VNlJ6JaY
	uqESf+fKyVEc4+maRLV9+wLJMYIlJM0wzai7/W+1NHppI0e/kxP8tfgn92glx+AN1po78IKIPUw
	9UYNWLCH/sHk47X3IP8y8AZInZdsS+pGDvrDgWZPbWDm5VWFQrxJjq4F81bkIFIZ4CDVFOuleOS
	/FoErIj4pGk8fI4THtnWIKktatPI79941qKktDcpkVyPW9M5Tpt97Vfdm6JA19L6tkejBfh4Y2Q
	GTmTg4jfopHN+MSaViPwNTp5iydVC/C0p6rsLYzjo262xYfY7BdnfjPERgWuxR1LMxnjJfcYUqy
	m/IT/dbc7IsPVa8JbyY7DsYtj0PI99ldWnNQC7VKQiLFWj133JEWVvkKAiCy+v+srvTmQPkQC2O
	N3blhHNRs7ZnFXJrrZl6HyHyZdx7OlAA1tdSFCq8fNqwiUyE8AwNaoyxdgpJNgBxu3kg1JeJGia
	z5rP5urDgReDS1liEIW6+FTZdQclgdyBX79zj1Z267OjTg==
X-Received: by 2002:ac8:5d8c:0:b0:535:bfc:329 with SMTP id d75a77b69052e-542b85e356dmr310565771cf.61.1793892346415;
        Thu, 05 Nov 2026 07:25:46 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10962a29sm52862011cf.12.2026.11.05.07.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:25:45 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:01 +0000
Subject: [PATCH RFC v3 69/90] net: do not identify a peer in another cell
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
Message-Id: <20261105-b4-cells-v3-69-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890935; l=4895;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=M8E24wZZki1Edb85Rp9EGJlvkFn5UAacTo8RqOOfUsk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEjJpMe4nAt+c/k/Z8MzRGt5H6Nb7tzjajcAJ87SqUVUv3PHeRWf2tSaDLHD7keGH71bR15n3v7
 oYpe8dpPVUwI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

SO_PEERCRED, SO_PEERGROUPS, SO_PEERPIDFD and SO_PEERSEC report who is at
the other end of a socket. No identity should cross the boundary of a
cell.

Fail with ENODATA if the credentials of the peer belong to another cell.
Reporting the overflow ids instead would be wrong: 65534 is an ordinary
uid inside of a cell, and a server that accepts peers with its own uid may
well be running with it.

The peer can change while the option is being read, because a connect() on
another thread sets it under sk_peer_lock. So the check is made in the
same critical section that reads the value, or on the very reference that
was taken. With a separate check ahead of the read, a connect() that was
waiting for the lock got in between about one time in five.

The label that SO_PEERSEC reports is not protected by that lock, and
connect() lets the LSM set it before the peer credentials are set. So a
task of a cell only gets the label once the peer is known to be in its
cell. After that point the peer of a stream socket does not change. As a
consequence, SO_PEERSEC does not work in a cell for a socket that has no
peer credentials at all, such as a labelled TCP connection.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/sock.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index e7405be8941f..cac93cba3c84 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -87,6 +87,7 @@
 
 #include <linux/unaligned.h>
 #include <linux/capability.h>
+#include <linux/cell.h>
 #include <linux/errno.h>
 #include <linux/errqueue.h>
 #include <linux/types.h>
@@ -1737,20 +1738,37 @@ static int groups_to_user(sockptr_t dst, const struct group_info *src)
 	return 0;
 }
 
+/*
+ * Who the peer is, is nobody's business in another cell. The question fails
+ * rather than be answered with a nobody: 65534 is a uid like any other in a
+ * cell, and a server that lets in whoever has its own uid may well run as it.
+ *
+ * The caller holds sk_peer_lock and goes on holding it until it has read what it
+ * is going to hand out. A connect() on another thread may be waiting for that
+ * very lock to say who the peer is.
+ */
+static bool sk_peer_foreign(const struct sock *sk)
+{
+	lockdep_assert_held(&sk->sk_peer_lock);
+
+	return sk->sk_peer_cred && cred_cell(sk->sk_peer_cred) != current_cell();
+}
+
 /* Hand out a pidfd for @type of the socket's peer via SO_PEERPIDFD*. */
 static int sk_getsockopt_peerpidfd(struct sock *sk, enum pid_type type,
 				   sockptr_t optval, sockptr_t optlen, int len)
 {
 	struct file *pidfd_file = NULL;
 	unsigned int flags = 0;
-	struct pid *peer_pid;
+	struct pid *peer_pid = NULL;
 	int pidfd;
 
 	if (len > sizeof(pidfd))
 		len = sizeof(pidfd);
 
 	spin_lock(&sk->sk_peer_lock);
-	peer_pid = get_pid(sk->sk_peer_pid[type]);
+	if (!sk_peer_foreign(sk))
+		peer_pid = get_pid(sk->sk_peer_pid[type]);
 	spin_unlock(&sk->sk_peer_lock);
 
 	if (!peer_pid)
@@ -1962,13 +1980,20 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 	case SO_PEERCRED:
 	{
 		struct ucred peercred;
+		bool foreign;
+
 		if (len > sizeof(peercred))
 			len = sizeof(peercred);
 
 		spin_lock(&sk->sk_peer_lock);
-		cred_to_ucred(sk->sk_peer_pid[PIDTYPE_TGID], sk->sk_peer_cred,
-			      &peercred);
+		foreign = sk_peer_foreign(sk);
+		if (!foreign) {
+			cred_to_ucred(sk->sk_peer_pid[PIDTYPE_TGID],
+				      sk->sk_peer_cred, &peercred);
+		}
 		spin_unlock(&sk->sk_peer_lock);
+		if (foreign)
+			return -ENODATA;
 
 		if (copy_to_sockptr(optval, &peercred, len))
 			return -EFAULT;
@@ -1993,6 +2018,11 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		cred = sk_get_peer_cred(sk);
 		if (!cred)
 			return -ENODATA;
+		/* What was taken is what is looked at. */
+		if (cred_cell(cred) != current_cell()) {
+			put_cred(cred);
+			return -ENODATA;
+		}
 
 		n = cred->group_info->ngroups;
 		if (len < n * sizeof(gid_t)) {
@@ -2038,8 +2068,24 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_PEERSEC:
+	{
+		bool unknown, foreign;
+
+		spin_lock(&sk->sk_peer_lock);
+		unknown = !sk->sk_peer_cred;
+		foreign = sk_peer_foreign(sk);
+		spin_unlock(&sk->sk_peer_lock);
+		/*
+		 * The label is not under sk_peer_lock, and a connect() has the
+		 * LSM note it before it says who the peer is. So a task of a
+		 * cell gets it only once the peer is known to be of its cell.
+		 * From there on the peer of a stream socket does not change.
+		 */
+		if (foreign || (unknown && current_cell()))
+			return -ENODATA;
 		return security_socket_getpeersec_stream(sock,
 							 optval, optlen, len);
+	}
 
 	case SO_MARK:
 		v.val = READ_ONCE(sk->sk_mark);

-- 
2.55.0

