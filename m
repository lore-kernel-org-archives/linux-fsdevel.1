Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498C73C7E1F
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083065; cv=none; b=QirNBCSPhdmCMtFmuxuAPRYjAhnqDLbUKXDxK6QZeSR7+KWMZHWV828cDg4EmZV+sfaGX/GoAYnjAMIj96HZYhf3ikdxuhDfsd8Xmt40ejNRCGMt538BtzkRvwioYpWYvqUVHfOCOhb6p8MCF8yl5ohv5R94b2FQNkPtOGXaI3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083065; c=relaxed/simple;
	bh=9MwpuvspxgM9S1xocdqxhpnC1LkHwHjGUtwBjeGYgN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8sJL0IutmBWwK6jwrKgX2L4H9olSAftJAz1RgQg59x6WLERURpMxMbdSRbeSKKnAq5DLpJKGMH4tkaKAboV5db7VnZp2bf4zY4W4jeZWvffAHIUyVLRmO550SGjAW+NBaOGU2LdP4+M2e4Uoo1RRHQDh3tIi5CeYMiS5bE+48s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a8f97f6bso8168315e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 05:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083062; x=1776687862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xV2ei1Pjz1ktH8bmxRjBSR/qLLc+Wvu9ssskTBPD/gg=;
        b=UvUZ/9fNW/uLYIpmX8ysA1QwatY6fYfKKHCNo+vJdjh4Sy49Qb8ivVpufoQa2vFcCX
         T7VHmXQW8wfwS40ZSJlst9sNatE792HQxgVI1oBLlqDgSSpm8z8LMX1+FQltkE/clzZA
         cD2rDQBLMOQ8MJHlGxTA3L0kZIGRl7BWG1/nHPiZSMLeoqogYHJSf1OSUNy3ugTIo+8G
         LLS0Dt3NDgKe7zllG0uYdZ7oorJrSBdbezzAPHqHiM9sOpznEfJU3P/mN5dq8opmwdYX
         XlRNErDms22xOfNKF6Zhv5SfP0pIbVefFdEonQeuL3O7vVJFp1FycKpvwy4dIqBg8zuQ
         DmMw==
X-Gm-Message-State: AOJu0YxYsWZLBEArtmokiR+jEnJi1updp22HIp0uOdt/sLdO0bwVpqFR
	xMlRQvQL4aTMCZP3tiy9+TfJb5w8epjclERFc1HEtskN9fj3gx9IgQ+ROWq1NEyqIiE=
X-Gm-Gg: AeBDies28h8TaN4suF+2/UDAAQsi6HLI53gkFpZjcnq4Fmo/UwypmIIO76PSRwBlMuo
	FDQ0Nplq/5lmD3GekVG2G7PzcWc9obb74loNORS3HT9K/oBCkqOS1GS7fAxWy4P7q+ZhhIQXRkY
	rxeeUjL7YWtzCQffYuSpfggUh6L3wot8hIv1jFUYKaTcj6CQ+YkZdvkZp+xIZ/u9HIznvvyKYi/
	Jp0CvGDVhYrRpSS7lB8rsDQbZAZ8xSjAEnaKoIZF8UcQ5tMmBiXboYVDfxA4bzXNCw1913dJEy6
	YguasX2Odhyaz22Tp5jbdGPknjHec1Sp6xGjnNSIYCptvQ3FOsqE5t/l7qxw0SKj8K2/QK/y/1F
	Fi6e9bn2lowvOAGAFTYxr1c0c49qPZl+14LqauJ7Rl8zj6LFeigYcQXqc5WhV7WfXYYO/6LvmbJ
	tc17qhoISd9HUlKdHJGwB5uRIDfnRa9m6eNp5VJw2fZw55X1AsOo1In0rmsgx38wsFecD1DGBNO
	EA7
X-Received: by 2002:a05:600c:b85:b0:486:fb8a:fed with SMTP id 5b1f17b1804b1-488d68a0975mr96731605e9.8.1776083062284;
        Mon, 13 Apr 2026 05:24:22 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm278260915e9.4.2026.04.13.05.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:24:21 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	aurelien@hackers.camp
Subject: [RFC PATCH 08/10] ftrfs: add CRC32 checksumming and Reed-Solomon FEC skeleton
Date: Mon, 13 Apr 2026 16:23:54 +0200
Message-ID: <20260413142357.515792-9-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413142357.515792-1-aurelien@hackers.camp>
References: <20260413142357.515792-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aurélien DESBRIERES <aurelien@hackers.camp>

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

Signed-off-by: Aurélien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/edac.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 fs/ftrfs/edac.c

diff --git a/fs/ftrfs/edac.c b/fs/ftrfs/edac.c
new file mode 100644
index 000000000..ebe676c98
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

