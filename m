Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205447;
	b=fScS/UNzc4SMfBgftibwTcxaaiPtu2UQlrx1/wf/Tp2TAj8fLreYSv9gy1FoNxkRh75B
	 hdNkWg5f1YYsgx0j/FSi+7X/5gTKTC3/te3vRDiYYIofMugdMGL+t2v2fqsCRJJo1h/1j
	 RjPCl/S0baJ9NavbGlM8zOtMMLO1LveTonBzHRQIXCpRVxpwmv6u+qDtvN50+NVs1CBKf
	 JJNtRv//0Ym7jOEnN/0ohz0YkjsZM0ZSXs0HQd5InvRaPf/dKhl64jKOT3WwGgxFLkmdB
	 ObKFEHVkv+bzkvjszKufosgHnZgfeSTIqB499frBqaEY0yWCpa5r4yQ6IYxfSkcOjBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205447;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ziTA5YyeX+ARWxi6+ZKerOzzoxnyIvGTm3FXaPm8avI=;
	b=raTvUn/+SgfzA+jsIo+tnYhoYkSQtPoqVcqmXWlIqTZux7LiAqj6xWHO/VPa6lJR3GSZ
	 QRsp2ABwx1luIt+mFUZEW6rxYOgmRoTxHFu4bed0tbIVDoerOrlP7XjXdkuno8oAr0wia
	 3ziAJT99nSzD+7G0zO4slW2vBR3B9B0s2Ok0ycvfkZQYmFxodftjpAuaDPGMSkDnEII/N
	 ahCI5I86RVe1x14RtKCw0TG2qCPtAys3s8SFeF2M4H2h6f0Q+iS/Furiah7yOKRbKb6fn
	 vW+IGTuU/KSTtE4c4PtGhBFum866GdZYEIXe/wquYoX3aKuUhYlpLFX4YUxGD9ihtvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u5AcJK6P;
	arc=none smtp.remote-ip=95.215.58.47
Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901E960A2628
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 901E960A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=u5AcJK6P
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wcqq7Xz1JG2ZSY/vCdYGSSzvFVRnKENm17H5OGY6WWU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205444; v=1; x=1793810244;
 b=u5AcJK6Pqbb4fy9KB3YtVP910kE4CpKe538ehpUHjPm9pvtPNOOR3IUAcOEq1vDcCvxMzRWU
 TkcnyTcVrKa27fV9mFlKgsj7RRM607JML5Kdn2/V4aOXQCuDWTv2nA1pAlYuEAikUaLbA7KXhFk
 o3Xep6aSjrJ4MMxeZC9l5vyw=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 8a18951985fddca6;
	Wed, 28 Oct 2026 16:37:24 +0000
X-Mizu-Trace-ID: 8a18951985fddca6
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 19/39] io_uring: store its sysctl bounds by value
Date: Thu, 29 Oct 2026 00:34:58 +0800
Message-Id: <1e4216f3c4e1971884be5a048c291077ce95995c.1793204511.git.wen.yang@linux.dev>
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

Replace io_uring bound pointers with numeric limits.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 io_uring/io_uring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8ffe0c9a4e29..48e03c3c066c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -138,8 +138,8 @@ static const struct ctl_table kernel_io_uring_disabled_table[] = {
 		.maxlen		= sizeof(sysctl_io_uring_disabled),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 	{
 		.procname	= "io_uring_group",
-- 
2.25.1

