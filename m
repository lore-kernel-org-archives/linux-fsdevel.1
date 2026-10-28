Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.109
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205514;
	b=C8FR4083txbzE1AaQ463nl82fwqSGCVb4EjbXrbX4BeN+gqvzgeDhT3e3ehgSNL8YovY
	 XuaHoVP3aecs5w1K/dtBZuHQOk7R8VdJapXWtEyS88OfUsVz5hQUreBb/uTT982nJhSuR
	 UX0taNmP2I4i032Et7U0PJLxu6COFLx15BfCH06PnjL7tETOffpGbkCNnBtHn7AXXpjqa
	 PVCvwd1R7u0D0IL6TbUpMlYBLs5LhMPUM3iQIV/drSyXDxedFmfyckWJb467WDoTrIF+r
	 0SyG9K3Mp/o65n36t0oDTFccNepwWClLiH8Eu9yQDREliscvGd0xwJP6BA6sLYfwGoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205514;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A4M4CA1/ivm+/y/4APm41mU+7XvVnh0e98HKJAb7kkY=;
	b=Yao6BpLBeg1kCvFHy/K1BmPs3qAXvwU+zM81sH7aMmH3EuMPnP2LfRBkdrfjuGdFiGD5
	 o70baIFGRGsedWAVeywUCXmRDtGloWNPPE8GzyrKIgxEkRPTa4sBuKNl6thPooO9k8n2I
	 vXFaggHbEz/5VSZZr8YhybhO/mG6G3osnlTofrm5xaUq1QwSYJgpLUJMg2+5lvvjRoWPE
	 3lzdezfaHkUagHejATlDUnmt0yM9XF/5sd9/DoyEEh+6h6x32oHYtlBJYifgoqcmzefC2
	 U14F0UR+6ohC90Vfp36uSdg8AIL8fQ3J72zzysg+nH3tb46rREwg1IqiNPphyI2UnHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fdvMQ6PD;
	arc=none smtp.remote-ip=95.215.58.109
Received: from mta1.migadu.com (out-109.mta1.migadu.com [95.215.58.109])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF0E60A260D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEF0E60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fdvMQ6PD
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ytf8GDhKxlKYQtuGp4jKeY9k7F9u/WxBPUzGVjuIoiU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205512; v=1; x=1793810312;
 b=fdvMQ6PDLiU6NxFzreglDYFXuu8VXgekHBQSJs7sOugOZ/AjdOBLvCMoyfh5pk/oPIHWzkCY
 e0iOtNfIIWDpA1t7Q/Eg30dVlQs1WPNpZWfeJ1u2PMTnkcdJ43jHscEWd3j2oNDsexSC9RYyZNf
 fM+jvKPoFcWEQoCuOUDZACb0=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 19fcfe898c7d0645;
	Wed, 28 Oct 2026 16:38:32 +0000
X-Mizu-Trace-ID: 19fcfe898c7d0645
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 32/39] sysctl: remove obsolete nr_open bound variables
Date: Thu, 29 Oct 2026 00:35:11 +0800
Message-Id: <ad3dd012f6d5344d8ee94932fb8b8cfe8ded605a.1793204511.git.wen.yang@linux.dev>
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

Remove nr_open bound variables and declarations now that limits are inline.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 fs/file.c            | 5 -----
 include/linux/file.h | 2 --
 2 files changed, 7 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 4cd40dfa6129..25fc2de96e9b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -94,11 +94,6 @@ bool __file_ref_put(file_ref_t *ref, unsigned long cnt)
 EXPORT_SYMBOL_GPL(__file_ref_put);
 
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
-unsigned int sysctl_nr_open_min = BITS_PER_LONG;
-/* our min() is unusable in constant expressions ;-/ */
-#define __const_min(x, y) ((x) < (y) ? (x) : (y))
-unsigned int sysctl_nr_open_max =
-	__const_min(INT_MAX, ~(size_t)0/sizeof(void *)) & -BITS_PER_LONG;
 
 static void __free_fdtable(struct fdtable *fdt)
 {
diff --git a/include/linux/file.h b/include/linux/file.h
index 41c3c0be1064..634f1770e9a6 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -126,8 +126,6 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags);
 extern void flush_delayed_fput(void);
 extern void __fput_sync(struct file *);
 
-extern unsigned int sysctl_nr_open_min, sysctl_nr_open_max;
-
 /*
  * fd_prepare: Combined fd + file allocation cleanup class.
  * @fd: Allocated fd
-- 
2.25.1

