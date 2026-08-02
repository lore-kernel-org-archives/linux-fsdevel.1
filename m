Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F97257824
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683544; cv=none; b=LGR46i8ZGBqx862MdLItDzH4wUMLcOIR//hIRcM1Jc0ol1LfqXUEo4BlyxBMxpEquS91+lFUx4TLv7RQk5f3U9myq4iw3WOc0KoJdRwVGcrr+B3S/N4wpMgvhITcGkEdS83A8djO8PqjYmGgeG5IgrSCqiqJdz+8lvlw6UKmCQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683544; c=relaxed/simple;
	bh=QJQE/GXd0K169a8mwkplKKdkmQ5sBJfTjp2LDq9OYG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxJMmHGfAdkju5nlB8IX1kPKo0KqeiJZ1S5vnB9jbXsfk2HLHAeHasb4/+DQMQBW2PXrMbv6wVmdtEp1FcvOo+DEhWXIN+rawo/a2PGtPxxUrRK0G2I1t6RHyvgdikZC6YBxj2KdHSjAbG/iiO7d0fcAJ0D+8R4HYbjLWN+xUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=MRZvH9Rx; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="MRZvH9Rx"
X-KPN-MessageId: 66a32409-8e84-11f1-bfbb-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 66a32409-8e84-11f1-bfbb-00505699b430;
	Sun, 02 Aug 2026 17:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=jTewONXvFxgGhvbpYUlhsacZJwkbZKyIKe17J6I4b48=;
	b=MRZvH9Rx8Y0g2COwAqqnN125q2SRh/fJjSZvePIYbvcrAUN/3ua2LpiGKN4nEllla5OOS5ZsrM9wc
	 c893flL0ao7dqziGl69sgIk/siQSXUTtfjz6L2lTzNHQ9EHFGuGlC58zqCH9pxhId4xqNAioY5Uwvw
	 S6ApgEaa8riLq8u5Wp6f0rNgySwj+gbinr7YFS1GI1zFX1yETTCOcCF7dYT3zi09gT3Wj3X8GBOQzP
	 dCU1DjzTnAxWE/LZQwObI8uPIM1fO9P9I0ksF/T+go1ZC1T80nwBl950CidOKUEgjuqY2PLmOiIBj+
	 EbrhdC3KClCCap+6K3ZxuEHnyS3JYeQ==
X-KPN-MID: 33|jSuzH86cAJNe1Iz6sXCEb2kNMqo9R0wqyPcEK5oNZajBa8w27djMri6gepBkzzy
 nfvdAoGg65NuYeWxMXMYGT/7Z5neC87Xcx/DhUBjtryo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|CvTqvkdA8ILHys7BKxwQ9dmrJRxQU9oIwQJeC0KsUB9/mxFnJQvPOtlMd5LobTt
 xJoOEsZ+aFCWkmAeWDvZMfQ==
Received: from daedalus.home (unknown [178.231.250.148])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 66612416-8e84-11f1-8dd8-00505699d6e5;
	Sun, 02 Aug 2026 17:11:13 +0200 (CEST)
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
Subject: [PATCH net-next v6 2/4] net: scm: move scm_detach_fds() from common path to scm_recv_unix()
Date: Sun,  2 Aug 2026 17:12:10 +0200
Message-ID: <20260802151212.3294591-3-jkoolstra@xs4all.nl>
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

scm->fp can only be set when using UNIX sockets, therefore we should
move it out of the common path __scm_recv_common() into
scm_recv_unix().

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
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
 
-- 
2.55.0

