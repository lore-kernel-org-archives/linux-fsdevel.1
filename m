Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F1482D4
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683543; cv=none; b=jKo0m37uCG2qm+tLHHRLxNBF81DDN3b22mASWGEqKeM2f6zK84RL86qQBvLWYP52ZUS1HS98X9hDrZqcDvSGU4wrGHwVxymFklY1FsVDjhgKYo3+1MI8v13pEs65LmWYyhgbGxrB3oBOGR15L5cXkGyOdHqgGkggOAKPNMUdEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683543; c=relaxed/simple;
	bh=uebmrdO726M/0/iuX5n71P0XdwlTyQsg+h1LBxPskhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHCnRWh1nY5oHc25N2QZPp4tcfzqX5DwmLoLyWypwnxtbskRvXX2MCAf844FQu1RcpshSpuuc3/Rv1E+Y9jaG6wbxjtKgQDXwpvSjglnSlIC2ayoMsXyRC6SFZEjKX7xz/V45T2k38+pMuTKcka+zsJjLg9vknilphZ0HKnioRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=rbs1XBob; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="rbs1XBob"
X-KPN-MessageId: 65d02c06-8e84-11f1-bfbb-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 65d02c06-8e84-11f1-bfbb-00505699b430;
	Sun, 02 Aug 2026 17:11:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=swyk2Wat8XpdbQyrWHp5Wc6kVSbJWh/6yWVhAjXf1/M=;
	b=rbs1XBobVTWh1WEcYeegYfdrg6fcU+XkIBNVenUOBPbfochNCDvuHRnHsGNlrcW+1LrUCuXvrZH5r
	 jhjq1kcvlzFY0BdDm7LYn/QBSgBqe2p4EvaY4yJHwE0eG2/1dAsKMAjOMoPNL4Dm1Hr+Wzu0qMRKjC
	 zj2E3gZXp/0+ck3UWStNNiW1y0yWRxMe1h2F2okjq6GsBBrofNsMiiC6sDtM2iDeJJzE2yDuDLL0GX
	 MTM7480ndaDXCzZLoTgEzcloLhpRuwWYy/ctWZlFD77mssMOVlGJ6tMw2PZlhaPQWP6N49bSHG+2fk
	 YHcDfirBK6KK5TPusHDiXCIN+sAwakw==
X-KPN-MID: 33|i81rmitsSRCWfOtngpyvkRCP2uRYk5HJFWNppFhSDkjYZYvL3dUUaHjvAi+LDBD
 UdLhget/lQxaXL9iVD40/fsKCwd0b/2/LSbpNFAztz/Y=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|p8QGx7iaaA/16JwmbpzmnEycFsNBIe9AR/G2ARBZ0dxMNA8AMMu8P4cAt0tfun8
 je3qubDa2nn8BJFoh48aaRA==
Received: from daedalus.home (unknown [178.231.250.148])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 659015b6-8e84-11f1-8dd8-00505699d6e5;
	Sun, 02 Aug 2026 17:11:11 +0200 (CEST)
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
Subject: [PATCH net-next v6 1/4] net: af_unix: enable custom setsockopt for all socket types
Date: Sun,  2 Aug 2026 17:12:09 +0200
Message-ID: <20260802151212.3294591-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802151212.3294591-1-jkoolstra@xs4all.nl>
References: <20260802151212.3294591-1-jkoolstra@xs4all.nl>
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

