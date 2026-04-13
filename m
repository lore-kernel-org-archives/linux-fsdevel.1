Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919939524C
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114394; cv=none; b=OP/nMWKt/F0DYqEH/wZl8+ivXMnnzULJvtQO5LyByZRDTAAC0kENIXEQp2jfMhxVhUOpXK0cuAsrxtiJfzzJnA4l3n+irgViO1s8ES7l5dk32wb0f5OlXMy5MttCvOwh7ZHOEt2v6a2ly/vokAUPgDKOTPNEmyksZsZFxGSKSRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114394; c=relaxed/simple;
	bh=y3X4Q1wuaiYro/3UQY7swAXd4RhfbzRFT9BkiQ88xho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7wJDcYrvsQ300ILa/nOERlrUjt4Is2MLuIBYS6M9wJO7WTXWQCaQ8wiY2HBRUJQvgkdRidlTjMGJebUjP6E4JhLtWSf9FJ8rJ8V1wtGPSbnNBIDCc+3CtW1N+nAeZoJWo6g8Qe+cC26CFMi6OzqALy+daACLv/fpMJhv8aHwWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488debfa07bso2393615e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114388; x=1776719188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDFE/x9etytc+EWBgqwOsTxdVZ9Oqe0zFdU+mEte1zQ=;
        b=S/Ab783eKuDQqP3n29kk0HNH4Y1ivbtG6eBpVnuh91lmJdsXTHx6jPA7fZOOS9cFUO
         ePMH9nsksjwsnqVG8ebKKwyD0SucbOP9lIpN8e/TbqG+wPdUWupSsrbk5nMeEytZKAZi
         DpNa8+LXpRlDCZCyIlrHdVcGTz7iAPlEUyVQtteP/kv1IwdR9OsG0DHiiAKflDIdXxPB
         uCgnsDJsYU1dRmO9FH6vKUyBhxidqJYQ6Zg+xOAhAHnzqDp1LQjWFYckEHRRE3R+kPti
         EGkjrHqRQhiDGg+GWwMb8UDtRRZhWpdXY8HB1babum6tyG8np3mZzctxkuVWO9/IhjL5
         0pxg==
X-Gm-Message-State: AOJu0YzSvaaSVyklplhFwaFIJJMgd5lT1/JcYc+HNSsue7AMCN8MxLMO
	tkbg0ls3DpGoZdo4RnrsnwCUvQIzETwjhA5e0jl3mqSZP6yjSh/yORV/4HbwqLEEe7o=
X-Gm-Gg: AeBDietFozIqk/dTN2zHDFsIPR58TP2fZ/ELW3/1jl/mYsGuzp4tD7iaawJsgsavzbc
	CMVEiMu4OdoQ9UEy0rHw9oUFinpYp+uMU4rWX0x4HFx+J/jYSgF0DOrzsuEt89RnvSb/z27xu+3
	QSswzEHUEJAHdBBAS+9NSIjb1yTnpV+uFiRRG2JrsQ2Jj3LLlOKoWBjMEZrZ0YTbQTTBerR5gIf
	NpdH+fCE5vt7fDB9itwNya0ikzEHEaqcNDQh9kP0M1mAPDlFk6A26zSrC2KEmADMgF+hrr02AK8
	6OXlF+4dvIG2iJsac+kynRstEGqGUi2RWAjCdL+9pkGM/CbdMdm6EJgt8C0AXGM5yUj8hmWz/gS
	qv5W5ndqingFoAS4InNPkDu+KKbOw77G/kZgaJEjoAlZhrD4xkJ4HSDEqwoNtGSf9tjaMTFpy26
	YaVMxU2rk/2kAJ0YwsSnCHiI2nf9WRAcovJ/Sq2rqLzZjxhfUUjftcFzYPdcrsgrAhLAHv2k3Nc
	KlD
X-Received: by 2002:a05:6000:161a:b0:43d:55b3:a200 with SMTP id ffacd0b85a97d-43d642c97e0mr6616599f8f.4.1776114387967;
        Mon, 13 Apr 2026 14:06:27 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm35130020f8f.35.2026.04.13.14.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:06:27 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aurelien DESBRIERES <aurelien@hackers.camp>,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger@dilger.ca,
	pfalcato@suse.de
Subject: [PATCH v2 08/11] ftrfs: add CRC32 checksumming and Reed-Solomon FEC skeleton
Date: Tue, 14 Apr 2026 01:05:49 +0200
Message-ID: <20260413230601.525400-9-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413230601.525400-1-aurelien@hackers.camp>
References: <20260413230601.525400-1-aurelien@hackers.camp>
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

