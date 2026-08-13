Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2D338F651
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638552; cv=none; b=hm7Dm1lnu87no1I8GECyL6Pgl7UoGBL91jEOVR4RRu9RFyAnKj5iVIsMq/mABva1FIevE6LD8lCKy0zbaK+E+WJPnh1ZBam38g+c0t16jQNimAOHWyI/lQBVgU/bcfykqKGlwjSJupNZJRut1NYqyxd/hG5b7IJVXMg9yG6OwOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638552; c=relaxed/simple;
	bh=6uL/fcMuXtkPICOYB8J42aD/5O5ueWcn9u4PGTRpS3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzZpPtdEspMl7USpnWcb+4Cljlta7v56JZ2L/lc+wpkEBuJ4oyzxKUwLWu0MMkD7w06TIPOnoXXakxshAir64MqTOUg4bDDVF4fOXHjPzDXeYnO0S0wHjXlhHYsA4pb6NCrP1uKF8TNTJ9R7s2xqAZK/jRmqbrmGzLT2WFjLUDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=K+fv5kJb; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="K+fv5kJb"
X-KPN-MessageId: 19cc7cfb-9734-11f1-83b3-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 19cc7cfb-9734-11f1-83b3-005056ab378f;
	Thu, 13 Aug 2026 18:29:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=xjSiY7CwFEzTBp15J3jfhjr7XplKvsglGkeWNI/XNN4=;
	b=K+fv5kJbIKBpPOiFIRpcWEVBeOl6fwFbeldAkzFTSnKvd+G0sPRWNSTSr4k7DqazVwKvVwBs55bek
	 U8UL9KmTgt9OmL9rfGBKc6v4eOy/tqICPi/CqBulhhhFLJe/P4saAJAV2wrdCKBrAci5bWhQk22V37
	 1xM+XDlQYN5CxRcc6O7fzLXL//IgsNsDTPbZ5zPy0ixHbQ67NZrK9hhphAHXBxnaHWDc3msrNrVj0y
	 E40G3QgfWe6MxOcHOKYkVqNbHX0MpoaUkldSKFFHwQMUcDOZwUytReBCFRO6Xpkvf9LzkWzFAvi/DI
	 tPMuZTBSxufwXOD/kDRozqc65+5Ho6A==
X-KPN-MID: 33|RD+tCzaHEQ80tYDhw98zz5D4Kivv614fLVKWTC9XAV8bE08X7BNddDDK1FyRGwO
 21VZa+2/KUbQlnTQnJk7bYflpO3VLpgBEj1EGmEt4gqs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Qr+J+ApZ0m9A0AEChGBwy1KJDxdAB7qnH9vGDkwq69kW4lAYKmkyOtTmmSvQ9Zz
 OztFN5WHmxVOOjXLxXo/SQA==
Received: from fedora (unknown [223.38.86.53])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1530837f-9734-11f1-a8bc-005056ab7447;
	Thu, 13 Aug 2026 18:29:04 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: brauner@kernel.org,
	cyphar@cyphar.com,
	kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jkoolstra@xs4all.nl
Subject: [PATCH net-next v7 1/4] net: af_unix: enable custom setsockopt for all socket types
Date: Thu, 13 Aug 2026 12:28:15 -0400
Message-ID: <20260813162818.149248-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813162818.149248-1-jkoolstra@xs4all.nl>
References: <20260813162818.149248-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unix_setsockopt() and the SOCK_CUSTOM_SOCKOPT flag were only wired up
for SOCK_STREAM (introduced along with the stream-only SO_INQ).
Consequently custom AF_UNIX options are unreachable on SOCK_DGRAM and
SOCK_SEQPACKET: those setsockopt() calls bypass unix_setsockopt() and
fall through to the generic sock_setsockopt(), failing with
-ENOPROTOOPT.

Set SOCK_CUSTOM_SOCKOPT for every AF_UNIX socket type in unix_create(), and
also for accepted sockets in unix_accept() (reachable for stream and
seqpacket).

This is a prerequisite for making SO_RIGHTS_NOTRUNC settable on all AF_UNIX
socket types.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 10ed9421e43a..51cbf920130d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -950,7 +950,7 @@ static int unix_setsockopt(struct socket *sock, int level, int optname,
 	switch (optname) {
 	case SO_INQ:
 		if (sk->sk_type != SOCK_STREAM)
-			return -EINVAL;
+			return -ENOPROTOOPT;
 
 		if (val > 1 || val < 0)
 			return -EINVAL;
@@ -1006,6 +1006,7 @@ static const struct proto_ops unix_dgram_ops = {
 #endif
 	.listen =	sock_no_listen,
 	.shutdown =	unix_shutdown,
+	.setsockopt =	unix_setsockopt,
 	.sendmsg =	unix_dgram_sendmsg,
 	.read_skb =	unix_read_skb,
 	.recvmsg =	unix_dgram_recvmsg,
@@ -1030,6 +1031,7 @@ static const struct proto_ops unix_seqpacket_ops = {
 #endif
 	.listen =	unix_listen,
 	.shutdown =	unix_shutdown,
+	.setsockopt =	unix_setsockopt,
 	.sendmsg =	unix_seqpacket_sendmsg,
 	.recvmsg =	unix_seqpacket_recvmsg,
 	.mmap =		sock_no_mmap,
@@ -1143,9 +1145,10 @@ static int unix_create(struct net *net, struct socket *sock, int protocol,
 	if (protocol && protocol != PF_UNIX)
 		return -EPROTONOSUPPORT;
 
+	set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
+
 	switch (sock->type) {
 	case SOCK_STREAM:
-		set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
 		sock->ops = &unix_stream_ops;
 		break;
 		/*
@@ -1865,8 +1868,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
-	if (tsk->sk_type == SOCK_STREAM)
-		set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
+	set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
 
 	/* attach accepted sock to socket */
 	unix_state_lock(tsk);
-- 
2.55.0

