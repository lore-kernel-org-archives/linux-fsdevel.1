Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205387;
	b=EYwXD1Npnb2pCoDWbAb57riW2b9kHrdob71Kvllu986UyWQ2Y1GxyO6Ypdb4HRqfwFk8
	 7KFts3XWxp+uB9icpI2+f6rJqByYxA05B18UlETal5V7VaTePDT8KcNt/6naiABb/Po1g
	 eg7sk44wNPyB6G0x37/FloC8D2O7RpbNTsYZnoHMGe0o5TU2j4pNfJjE5dXcN2DA53yxz
	 BuybgIELuo9pU0CD2OYn8jKTAWdpGeY6NOFbnsmR5BL2ZDq8MPdXEQwKlN/GLAYMFwQaf
	 Bg1W4SNOPZ1vWmOUt/9qCAtRlfeZ6LQxBY1wK1Xh6ss4MP3XiSjD8NCHnOoHU7hY8yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205387;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NcLne8HCAtZCq9m+/P9Y1sEBarLH9DBl8jrMp3FLJ5g=;
	b=SFoVtqmZCsHUokyGnL9il9B4WiT3gVFIS6FOypJF900EhqEneUGjP4UxpCkX3H/DJqF4
	 mdkwrg3Ra4df6yhruqFbh5YTEBlhYAw/NHj7AsPUQn4QRFHANIKokSr4ZDwW/DAI6YsX+
	 gq/m7rfpULLx29ANcLmTnTiERpVFn+EMdZkllvNui9+2hDT/sAJKOcdp1qSxnZPa8YX43
	 lA4cXazagGZiKZsn7q7ZTPyYgcGcpYAWp3e4l9J+hbnjJOkQ4tSnU4GDujYhq1jegG+Pq
	 XBdrIuqvdPk2F5nQ0GKuQpnK2ez5mutrmaZVo7OZ26NDm2e7gs+7keDP9vEmvnY/Y+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZrSZRXug;
	arc=none smtp.remote-ip=91.218.175.20
Received: from mta0.migadu.com (out-20.mta0.migadu.com [91.218.175.20])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3D606A31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCB3D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZrSZRXug
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ilafpdra+kHUXQhpYmuDC5+KdKckKpZal84g7i1t7Qg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205385; v=1; x=1793810185;
 b=ZrSZRXugLe5HFp4W0WFWvhVMfhxj7w5wdq6qB3K7gmcMOSGnL5m2TjZaUgqetF/pqAJVPYoU
 lhzammLfQZNRws8M2hg0qvUyACSQ6+50kh+X28Qkj0elDLusbCm+bcZpqss3nKbqLSQ9cPRuJHv
 yOcWbH7zTQMDZXH0nCIh38io=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id e2ea6017dd03c013;
	Wed, 28 Oct 2026 16:36:25 +0000
X-Mizu-Trace-ID: e2ea6017dd03c013
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 08/39] sysctl: store crypto sysctl bounds by value
Date: Thu, 29 Oct 2026 00:34:47 +0800
Message-Id: <646572a0e7d9153484b103dadfbdd9161bf56b69.1793204511.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Replace crypto bound pointers with numeric limits.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 crypto/af_alg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index ab84c4488a15..8c7559c3fdca 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -38,8 +38,8 @@ static const struct ctl_table af_alg_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 };
 
-- 
2.25.1

