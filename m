Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6B36CE10
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620175; cv=none; b=NKpKlirzjCyV9p1OfuAiuSyTuAbnm4nnGPBXdM93sKfV773fglfi4w+X7cI95FXDq/YpMcrtgokoZ0sCFVFdGevqsZpf+bWQFWK4xPPqXGWQPwWdnOT3QtKL684hCTjzPt32A1KeULoYdkPoa7zU9u6stGdX37u8MPiS6sbqFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620175; c=relaxed/simple;
	bh=wQlAUK8yb5O7tkDU7pSJ2qwqf7JbAv3RsZU7RkjUXhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBiGiX4Sl1SIAxJ+cdhRDkmO+GHVq/WVEN9axVUh6fI8vhGC7DzPuLsfkQs8wkBNl5XsjZNnFMxceLjJD/3stMbK8+ql/FDAiMmwMih3VqcwcK2GpjQ6QNDK3dn5F/h6rlNGlQE5IBphwaFtY3RAy2D4KJaIXLXZCpNypI8UL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=DbHG0a3F; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="DbHG0a3F"
X-KPN-MessageId: c8a905e0-698f-11f1-beab-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c8a905e0-698f-11f1-beab-005056992ed3;
	Tue, 16 Jun 2026 16:29:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=etSJLXtuXbFYY4p2xurfRhpzKgCv0tmCROn4H+X+ivg=;
	b=DbHG0a3F49OvcCFtDOyPSp1znqTmwUromr60kcbg1/fkEX3TOWLLLfd70jwhY6Iq8U3jcfqojHVmN
	 pVhK8NgcwISUt/2dbbapDv4EKjnFsLGP8qys0Ir+E9VXmec7mYuslgl1e+OyhrUG7iCGlyZJQN/l9Y
	 N4nLtiuFK5uPz3Hc7GExXcXYYMItffqCbj6uEUSOa03ENGBFNtfXwEjw6CK1mBItVYwwDX3c8w7Ztk
	 do3tBqiUL5fLRiUwi8sMCUWarKhkTfD7Ss13FnRTX/nJQJczcN3hc/Nh83z/jhtznMROrhBXcrtzb+
	 plTefDJdbtlyKWdJgF5E26quW4E37/g==
X-KPN-MID: 33|6pLfU2O9ZhGCLSx/eFP5XgK6eVOaeImzyet/9xFopyU6VfsA0AA+hI5BzGZAOX6
 ft1l2Uw3HJEbmIYFpe1CDZvFYyqeIUOI3dut0hfX85gQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|MB0ANrUBVF6lYEmrKZXbxai3w/4EWrB3fcAn10rsH2D+ryueRhsleeMiPnSivqF
 PN43KEZTw6vZyd1FlTbvoRg==
Received: from daedalus.home (unknown [178.230.193.174])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c5f136e7-698f-11f1-a77e-00505699772e;
	Tue, 16 Jun 2026 16:29:29 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: brauner@kernel.org,
	cyphar@cyphar.com,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/4] net: scm: move scm_detach_fds() from common path to scm_recv_unix()
Date: Tue, 16 Jun 2026 16:30:01 +0200
Message-ID: <20260616143020.3458085-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scm->fp can only be set when using UNIX sockets, therefore we should
move it out of the common path __scm_recv_common() into
scm_recv_unix().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 net/core/scm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/scm.c b/net/core/scm.c
index eec13f50ecaf..a73b1eb30fd2 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -523,9 +523,6 @@ static bool __scm_recv_common(struct sock *sk, struct msghdr *msg,
 
 	scm_passec(sk, msg, scm);
 
-	if (scm->fp)
-		scm_detach_fds(msg, scm);
-
 	return true;
 }
 
@@ -545,6 +542,9 @@ void scm_recv_unix(struct socket *sock, struct msghdr *msg,
 	if (!__scm_recv_common(sock->sk, msg, scm, flags))
 		return;
 
+	if (scm->fp)
+		scm_detach_fds(msg, scm);
+
 	if (sock->sk->sk_scm_pidfd)
 		scm_pidfd_recv(msg, scm);
 

base-commit: 6b5a2b7d9bc156e505f09e698d85d6a1547c1206
-- 
2.54.0

