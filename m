Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46B39A064
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783884557; cv=none; b=Zs7Vbqg5d6SSuF4VJZxQewnITNqyXwnY/PqaRErtsjtWv5FRdDwx72uOn6op3BIDmqAIMBlT/x4e84FPjek1OG+/BxsKKHyN1NQwGTQWxC6BFpbRHuqXG/dJYYkHpLcx/1V4UVJGnzYp/iKZCep0xf2J0SWSdH0NokYakDH16Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783884557; c=relaxed/simple;
	bh=/hwMuqFPbV2RXCxBKoN/ZEHNqijXQT8Lwh9RVoeAq9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBX2zI/Tab3XerH1asj+7/wMOlDxwNnPe5jx/LMTly1N7MRXRMSnLrz1FAbikbitAzrvgNarAkuHlaJCEXcb3cHV9Ad8U9gA1p6O9gmPZ5juwkbSuimENxgn5g2CcotuHEZIJfk4ct/CNEeYr4n+A3ykXKwvViN+tGbItZRGF3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=odHs2vLg; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="odHs2vLg"
X-KPN-MessageId: f6b53a40-7e27-11f1-a59f-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f6b53a40-7e27-11f1-a59f-005056994fde;
	Sun, 12 Jul 2026 21:29:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=x7uJpPkF3ZQUrVWrgYFqwWsVpOjT67/X4ytnP1oLCCo=;
	b=odHs2vLgRLPOqLbKwyekwuvOqYahbKcL+JC65XHkWeAIM0Y0hgqya7YQAoRyV99weSkYZnjEYslyL
	 ZFGankDxkO5LbgcmvUfaRJqecVAE788dMFPbkSZ5rooGV2McHnx7s7plh7UPShzQ+xz7pEa9wK6ZuD
	 mouaZ4GZmpVq4yzUA38NjeYzF9pY+3Sr/GrQ9wVHN+zX8bXOzJpzADx3Yk6l/VEQyjo0fw5sKDR4tX
	 PAN+OQ5Ytubh8eGsvWZgT0oWkNyXaFv6N1LkSPGcYH0Q6ad0SDr8mQE1jn6z3RoPF8FRSoFIX3/P0d
	 +uypT3d65g29wao4T+WYvWMgznhiQgg==
X-KPN-MID: 33|aCmUk9DR42MJvYEnNg0Xnbr6u00Xeqlc/Tdp34eeaQa8IIp64EU9sbHhMeiG2xO
 r7yi8bYDYCCzm6sdMbu1pWbo95qSfEMna1AuwxTxxLGw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|hch6RI3T8pEZhkRaOvP0IjHnMogfJP0PF8nk8jIHnZM6qrB+mgTlOC+83Uc670Z
 Pj9ZBYjWhSCx3VmwHCrsPHQ==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f6757dc1-7e27-11f1-8dcc-00505699d6e5;
	Sun, 12 Jul 2026 21:29:13 +0200 (CEST)
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
Subject: [net-next v5 1/4] net: af_unix: enable custom setsockopt for all socket types
Date: Sun, 12 Jul 2026 21:29:55 +0200
Message-ID: <20260712192958.1631672-2-jkoolstra@xs4all.nl>
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
---
 net/unix/af_unix.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..3d256255085b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -949,7 +949,7 @@ static int unix_setsockopt(struct socket *sock, int level, int optname,
 	switch (optname) {
 	case SO_INQ:
 		if (sk->sk_type != SOCK_STREAM)
-			return -EINVAL;
+			return -ENOPROTOOPT;
 
 		if (val > 1 || val < 0)
 			return -EINVAL;
@@ -1005,6 +1005,7 @@ static const struct proto_ops unix_dgram_ops = {
 #endif
 	.listen =	sock_no_listen,
 	.shutdown =	unix_shutdown,
+	.setsockopt =	unix_setsockopt,
 	.sendmsg =	unix_dgram_sendmsg,
 	.read_skb =	unix_read_skb,
 	.recvmsg =	unix_dgram_recvmsg,
@@ -1029,6 +1030,7 @@ static const struct proto_ops unix_seqpacket_ops = {
 #endif
 	.listen =	unix_listen,
 	.shutdown =	unix_shutdown,
+	.setsockopt =	unix_setsockopt,
 	.sendmsg =	unix_seqpacket_sendmsg,
 	.recvmsg =	unix_seqpacket_recvmsg,
 	.mmap =		sock_no_mmap,
@@ -1142,9 +1144,10 @@ static int unix_create(struct net *net, struct socket *sock, int protocol,
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
@@ -1864,8 +1867,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
-	if (tsk->sk_type == SOCK_STREAM)
-		set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
+	set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);
 
 	/* attach accepted sock to socket */
 	unix_state_lock(tsk);
-- 
2.55.0

