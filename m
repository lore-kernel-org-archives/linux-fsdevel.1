Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE83A3CFF46
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161261; cv=none; b=PpIFPdubHLjhXIGh47xevLeidl12t0nEDc3UnjbWHTRxdqS5J41gVxoB12+m+JT70V0QlMOSCDvPv7HBKmO2Oy97AcUwE6XJiQBZF5l02XAMxLcJ1S7T2erqqJoIEkRSLzhDPbGtXVc8Wl7W0rMGDGAbFW9zi5/+UlzKz6Ky5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161261; c=relaxed/simple;
	bh=yxOwe+ZAi8eq+GEsp/IgrfQcj8tR/cps95A8fxqnPMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wmixjgx0Ak0TcotyifiGSTQpRGbb0h+zG3jRWzUs+UMtsuIcsYS2ZBvr92ttRgYMaTs6LXGZ+pkvtJ6UKKNdlw4wZhtF9FKYNiQ5wEAtxOqycKRJ9qMIf1zYf4PpJrPHO5noiu1UQAeWgqg7PSos8bOaI+iFlpJFpUfCjN8MDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488822b93c7so6003865e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 03:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161258; x=1776766058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a465pWOyvoZU05HiIIPl0LD4EBbwLj19TV803zaD4aE=;
        b=A0dRwaP/AxnyvYtodQmenP6g6/LkLDwTby9cwivygk/lyyY97E81hnZmRinR2UuR4q
         mxgL0T7f9sB4gxj+Im5kOFx0meRYUGLpb76WK2L1g5VMd5JDwAa+jXK06D/vBmbuiHNR
         9IcorIigH9h/b4FwIdvbdpE3tIYjW68+owykSDICAhaL15IVRETngypA6LgjV7v7mHqm
         QChGzJafRgpM+7hvVzRvgJkQJr/Hq77mVSbzGbOq/Vora3dIFBBMJ0pnDQy53SVDR3zj
         rOPQ+DhW2a52oEcCtlPJEvDBa6PSvG8EWyTUv/hE+vp289InPohn8W3YhRLhmYntfeau
         pzuw==
X-Gm-Message-State: AOJu0YyNvp3GCEkgcrsIyS1rBVhQFX8nlQPmhACN2caT9pm7zKjVQoMW
	QKvw9IiFOfW+Dl+eiwyMmsuiGOjCJfAHhGhPx8FarnMfcvjyeAS5JCXEXIO0gMkA
X-Gm-Gg: AeBDiesoMg9cRU2uIvSryqB1oaKLkRC+JT4NWWXL0GqPd1QpdL8bwW9h06rksag/ZI7
	wDaRVmDKXV5T1d5/ln5Ztvi+yH2rUyH+fTyzUl1yaX38kQb/nHi9Ndew2/AoiGZsuh3N14Pg/Vi
	AtwcrgyOlJrrN3x0b5MiXxiL3D3mTP3jPgGB0M+jpaHojb+YGOhx3NWVXQLj7IorwIYbCd1DuXd
	QDu/AcxN9pReWObkkA0LF3eVm8l0ATKyglnU4jIaGxi2QGedEaEZOfgKOxglVeNDR+Md61g7cNq
	T/5TgFd+md34HaaizEeljOIjfssVgjR6lNJnaK8DgOAzknt8l6zOqn8w0Eqf4wbpDSxNluY6VoJ
	lyGtgJb/noq/sbpeQmlutYlQ2oyJ6W8+j169EsfUme+epY57Bn+k3v10+d5JtmRi2gDqzoXm8ug
	5ew+zOrO17eNx1uoZm8i6IrGHJUapxiAUvZ6wqsqbaKaHI1+azbYfHBx0i0UiFdKDrptoQAfMhi
	4o=
X-Received: by 2002:a05:600c:524a:b0:488:926e:3ccd with SMTP id 5b1f17b1804b1-488d7f24014mr120661015e9.4.1776161257764;
        Tue, 14 Apr 2026 03:07:37 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e050sm65870545e9.5.2026.04.14.03.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:07:37 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger.kernel@dilger.ca,
	pedro.falcato@gmail.com,
	xiang@kernel.org,
	Aurelien DESBRIERES <aurelien@hackers.camp>
Subject: [PATCH v3 08/12] ftrfs: add CRC32 checksumming and Reed-Solomon FEC skeleton
Date: Tue, 14 Apr 2026 14:07:21 +0200
Message-ID: <20260414120726.5713-9-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260414120726.5713-1-aurelien@hackers.camp>
References: <20260413230601.525400-1-aurelien@hackers.camp>
 <20260414120726.5713-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement data integrity layer:

- ftrfs_crc32(): CRC32 wrapper via kernel crc32_le(), used for
  per-inode and per-superblock checksums
- init_gf_tables(): initialize GF(2^8) Galois Field lookup tables
  (primitive polynomial 0x1d) for Reed-Solomon arithmetic
- gf_mul(): GF(2^8) multiplication via log/exp tables
- ftrfs_rs_encode(): systematic Reed-Solomon encoder over
  FTRFS_SUBBLOCK_DATA bytes with FTRFS_RS_PARITY check symbols

The RS encoder operates on sub-blocks within each 4096-byte data
block. Decoding (error correction) is not yet implemented.

Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/edac.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 fs/ftrfs/edac.c

diff --git a/fs/ftrfs/edac.c b/fs/ftrfs/edac.c
new file mode 100644
index 000000000000..ebe676c98be6
--- /dev/null
+++ b/fs/ftrfs/edac.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FTRFS — EDAC layer: CRC32 + Reed-Solomon FEC
+ * Author: roastercode - Aurelien DESBRIERES <aurelien@hackers.camp>
+ */
+
+#include <linux/kernel.h>
+#include <linux/crc32.h>
+#include <linux/slab.h>
+#include "ftrfs.h"
+
+/* Reed-Solomon FEC context */
+static uint8_t gf_exp[256];
+static uint8_t gf_log[256];
+static bool rs_initialized;
+
+/* Initialize Galois Field tables */
+static void init_gf_tables(void)
+{
+	uint8_t x = 1;
+
+	for (int i = 0; i < 255; i++) {
+		gf_exp[i] = x;
+		gf_log[x] = i;
+		x = (x << 1) ^ ((x & 0x80) ? 0x1d : 0);
+	}
+	gf_exp[255] = gf_exp[0];
+	rs_initialized = true;
+}
+
+/* Galois Field multiplication */
+static uint8_t gf_mul(uint8_t a, uint8_t b)
+{
+	if (a == 0 || b == 0)
+		return 0;
+	return gf_exp[(gf_log[a] + gf_log[b]) % 255];
+}
+
+/* Reed-Solomon encoding */
+int ftrfs_rs_encode(uint8_t *data, uint8_t *parity)
+{
+	uint8_t msg[FTRFS_SUBBLOCK_DATA + FTRFS_RS_PARITY];
+
+	if (!rs_initialized)
+		init_gf_tables();
+
+	memset(msg, 0, sizeof(msg));
+	memcpy(msg, data, FTRFS_SUBBLOCK_DATA);
+
+	for (int i = 0; i < FTRFS_SUBBLOCK_DATA; i++) {
+		uint8_t feedback = gf_mul(msg[i], gf_exp[FTRFS_RS_PARITY]);
+
+		if (feedback != 0) {
+			for (int j = 1; j <= FTRFS_RS_PARITY; j++)
+				msg[FTRFS_SUBBLOCK_DATA + j - 1] ^= gf_mul(msg[i], gf_exp[j]);
+		}
+	}
+
+	memcpy(parity, msg + FTRFS_SUBBLOCK_DATA, FTRFS_RS_PARITY);
+	return 0;
+}
+
+/* Reed-Solomon decoding (simplified for now) */
+int ftrfs_rs_decode(uint8_t *data, uint8_t *parity)
+{
+	if (!rs_initialized)
+		init_gf_tables();
+
+	/* For now, assume no errors (full decoding to be implemented) */
+	return 0;
+}
+
+/*
+ * ftrfs_crc32 - compute CRC32 checksum
+ * @buf: data buffer
+ * @len: length in bytes
+ *
+ * Returns CRC32 checksum. Uses kernel's hardware-accelerated CRC32
+ * (same as ext4/btrfs).
+ */
+__u32 ftrfs_crc32(const void *buf, size_t len)
+{
+	return crc32_le(0xFFFFFFFF, buf, len) ^ 0xFFFFFFFF;
+}
-- 
2.52.0

