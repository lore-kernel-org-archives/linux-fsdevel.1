Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB09489880
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638627; cv=none; b=O8VzeP71RJnHcvNyJPC5zukvHILbT0XADLv3vkn8pPDE/8V2v+YAx+xgh70sk6u69ge6gagli7xSS0958j+/5cgkKrukkYyBz5W+TvVwY6E8R4ACOFANQ5J2j9CK3xtEFgQEsezpVnHEfbdUJEkQ6MQbfgadntU9acuJkrKblJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638627; c=relaxed/simple;
	bh=QJQE/GXd0K169a8mwkplKKdkmQ5sBJfTjp2LDq9OYG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GcrnuhmD7iwG247Q+IxOdj+xDUTqs1wNlEdX80NKzr5B68flO3LJvB8G2iDeIJGCpEezIRXJ2DiUcadH6NHYNb9Vm5BgtOUHtf8NahoEOWwXHnCTYloh2EFYbTSbcO6iR1OqG1g/af8HQamrYo5fVQKWwwly4hzFtcI4+4Esqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Ui8VzVTV; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Ui8VzVTV"
X-KPN-MessageId: 2086fad7-9734-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2086fad7-9734-11f1-861c-005056aba152;
	Thu, 13 Aug 2026 18:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=jTewONXvFxgGhvbpYUlhsacZJwkbZKyIKe17J6I4b48=;
	b=Ui8VzVTVYXoSx4gljpDJhVvy0r0YXSYtKCq1OzhXDJUUZS2r9vU8Mmsv/NeoKsbpEEJK7LJrgbUkR
	 sewS/9pSm0C/sJ74U63UpcRL9cVGWzFtAIjNyxzoOPut+LaUI+1PRQdB2Q6fshQZTfVmVSCHNYyaIc
	 VNywoJyglO/kjpV/Swm2L2onM2L0C43Yj2ZMxfxTYgimT3QUN7LOzbUVQEdW5X0UO0fkKFR7Zr3gvd
	 W4Q3bXRH/cItClrLnjeUKfYtzEEkxp30pHlg9X3bSPyWyIB6syR6hXnhKX9W2tgtuqC07vt2BqR058
	 3EwkTjNmm9wlI5v67MUuSnC9OgT0gbQ==
X-KPN-MID: 33|/TCCuN7hhmGA3NIotZ7mGUrPFVguPZBlcytE2VY1H+fBBaNzJJ/qgToCc5mc5jz
 R5tL1fe8/VQJRmodjIbnqe7yJ5MnDFu9Jkw/pRYpXVY4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|SUsaept8WAFZMntZOpPXVEVPMCkNMqQMUNLNMl52nPuS26v5dKxCmHODWAv1dXY
 5dN1kWD9Bmc/WYSRLm7puXw==
Received: from fedora (unknown [223.38.86.53])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1b71ed0b-9734-11f1-a8bc-005056ab7447;
	Thu, 13 Aug 2026 18:29:15 +0200 (CEST)
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
Subject: [PATCH net-next v7 2/4] net: scm: move scm_detach_fds() from common path to scm_recv_unix()
Date: Thu, 13 Aug 2026 12:28:16 -0400
Message-ID: <20260813162818.149248-3-jkoolstra@xs4all.nl>
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

