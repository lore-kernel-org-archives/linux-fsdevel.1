Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE00384CDF
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620182; cv=none; b=WZv+H4zHUWSBYLBXn/aOPk+r3WT7nvbkf1sGSsYN3uYP/JePvDF2nwWXelORj57Rei9t/GyuMK/hyJghI6dxZqua9yPdEAyD+HDNt9lqIaBCJjW5ydygDMc+3UBwgQ2ZCqqnNr1kNQk50k1N9xs3xcavcvs/2F1Nf/G2COISAW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620182; c=relaxed/simple;
	bh=Qqh2kYR5AnndYSSSbCw524nQrS4BOLBstcnsQoCxirk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUiiicYyBypnW65EVsD2OG2bWIRbQEkPbywm2gm5u5qsLAkJ8VOwttJ3LlSOa3xytFI7SMKtuMLUQa3lE0POR3sBQEu0NbLfRKx7am/DkDh6aZUfBRBAbWFiGqFntbtBwNciG0dhJK9EKvT5vMKHwSk4zyHnBE8S9ay379Y4qR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=KdKWavUt; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="KdKWavUt"
X-KPN-MessageId: cb46390c-698f-11f1-8ff8-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cb46390c-698f-11f1-8ff8-005056999439;
	Tue, 16 Jun 2026 16:29:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=oUFyyFB8ReNjnGZAg5IYXFWboSBSWEg1wqQRR6CgHAw=;
	b=KdKWavUt0IY8WAwNt8yjhsfVR+RUMQadpdQQNP5CnGQs180xWepbqP0rKLzRFcZ0lH2XSj+Vtperm
	 +/bfCjK2QZEM2X+Ei9U6lXrdt0Epfl8ZuCK/EAqvGEnApDzE/VHMAXJelUAWn+df3SPNlvdh0AvZMi
	 uJHvuqCcC++HOgzTNu040vJepZI+Y/drQKfng1HM3hSaPJhdgLpGAdlZR/2O87An8yBAgiJVHClVCs
	 rhXvk+60z5W2G7W3b+ZRYSksMDRqTDUYuDvMT7TvoXp8QM44dnXn8tYROVAw9aDasU9vT6heoOU1R8
	 sqwJ5uiY6J21ZggaudxxXxRm6aw6fZg==
X-KPN-MID: 33|Zn1HwyGZC67ZdL3UJijwOHmQ6zqjaCPSsuW1Kb+RTKtjB/p3eZUI1MRh/mDHlBf
 T+6+5CDxyI37ddRpwArk5KN4HVVyJKl8RQoeD1cMIHBI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|wXGn/3ZPgfboUacRCHaajdPhZN5xsyoB/yLW9fIbQCChZCruUcanpqndrrafo4p
 jOT+m4ixXbpv1905sc/Gu5w==
Received: from daedalus.home (unknown [178.230.193.174])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id cb00c67f-698f-11f1-a77e-00505699772e;
	Tue, 16 Jun 2026 16:29:33 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: brauner@kernel.org,
	cyphar@cyphar.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/4] net: af_unix: replace copy_from_sockptr() with copy_safe_from_sockptr()
Date: Tue, 16 Jun 2026 16:30:03 +0200
Message-ID: <20260616143020.3458085-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616143020.3458085-1-jkoolstra@xs4all.nl>
References: <20260616143020.3458085-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated call to copy_from_sockptr() with
copy_safe_from_sockptr().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 net/unix/af_unix.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4e1463ee2815..eb4051f3aae7 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -933,6 +933,7 @@ static int unix_setsockopt(struct socket *sock, int level, int optname,
 {
 	struct unix_sock *u = unix_sk(sock->sk);
 	struct sock *sk = sock->sk;
+	int error;
 	int val;
 
 	if (level != SOL_SOCKET)
@@ -941,11 +942,9 @@ static int unix_setsockopt(struct socket *sock, int level, int optname,
 	if (!unix_custom_sockopt(optname))
 		return sock_setsockopt(sock, level, optname, optval, optlen);
 
-	if (optlen != sizeof(int))
-		return -EINVAL;
-
-	if (copy_from_sockptr(&val, optval, sizeof(val)))
-		return -EFAULT;
+	error = copy_safe_from_sockptr(&val, sizeof(val), optval, optlen);
+	if (error)
+		return error;
 
 	switch (optname) {
 	case SO_INQ:
-- 
2.54.0

