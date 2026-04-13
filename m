Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A813C661F
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083062; cv=none; b=IAsuWTat+2POM9naKqdnLg/y/CmZpZ3syJJTd/jG6srNmzl2zlfoniQQJ/2bLrZd8rESTZA/QWe9M3U3igN9CUlCG1qViPSAOvv6sF0oCdY0HYd3au4PRqEKtgJj7MChC5opw/2EoM1ew83OxvhHEDi1eDt9NpHT9ZYleUDKip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083062; c=relaxed/simple;
	bh=qpVfP6Csx5soTuewK6VWgGUXVpdq19dG8VZ9f4tI5kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pf/eYvHfVQuMZu0NuCFd1CkTquRHGfuIAmKr5VIClKmQe8funZnHuFXdxTE2H/wbfhbYyhVDERS6CswLzv6+4pjc/GySY03uCVpIY4qc/T/PZ4CxIfavgtV3XgNN4+96DtKjEwmDvcX07IbXOEQWozAv+DHGB6QdhP3E68BSUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cf7258875so293395f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 05:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083059; x=1776687859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1vodrXYeOranijZ6che0xv62AVq6wH7ifjeewL0qmt8=;
        b=EnlEnwwnN28XzzNkjsWPkgbFmj092vB10cALlXohtfhByGqLFS/ioY46ssnxBMzx5/
         3K2pKUO2CkKiwv5CSPTNZ1J2OYChbFDSiFtiQAkl8Z39oPs7K0z7yljHj6hgupQprveF
         YZ97932CZGfjqiVocXnyb8YFxqUwsGNw0ud2b59L7DfXTKyY0jZ7QVnt80h8yCXKHEbu
         fygG6fKs2iAuTmLDHSk+OyIhAtzzDV1DXDP+9ejXQb1aDmhoFO2tpRVLl3pTp2eL4RF2
         jVp6pb2wVVa4f/FwvFNzgLrlhxzv3jYzvnSegxZb+zolKu9dtATf/ImrGthDd9wtSKdf
         K4bQ==
X-Gm-Message-State: AOJu0YxjjZQdnDxuW63Ts08g9oWGW4l27yGPWH3VEvaQZSNVdKbXg6fT
	m91YWAXB8tSSkneCMevo6GscJisnivM4/oejAtWXP/30hy5RjMw7L/4+7IwYsI9TedE=
X-Gm-Gg: AeBDieuZH6Vfaahg9Z6/jW/YrtOAhZsK4po35WUx1vyG6Obi1OEk5o0Wji3JLnO8JDW
	BOAchpxFpM9cwkE2V2wy1+JGcpOvSXgeRK2LMUOSrFfNW+uSYI/ihUhwOl8umonvrV8DwItykBW
	1Fh9Up3a0Sd05t3b6xeLkMpziFLIfy3jMXYDdWEehxMIKkFDQeTQGkXc2sK2L7bzmTc4FyBUPWL
	7K0BbSS4UmM9sPDgxE4RKDwKg39YkOmhyv+UVTSJS/7eEmGendLjh01j4eAagVOL+4pYmmSSyhm
	6tNPnp3E7iS+65TnZKKOY5k7pgD1JUe3B9h6mXKwmejtJEj4IjGsbk/CGmuytxQ8NVr7VDO+qpP
	Czv536ba+SeknpIm//yjBE+3KFl77yRCP08CPiN3dL/sfOjI2HsCw3T2q2HR9WA+sredGh/FQHW
	n/XXNUKPbcKXgOQQ2dq6VF1LtntR0xvAmYRaLyZFczALgKjQyOUeuE1oz1H+wyVPDo4A==
X-Received: by 2002:a05:600c:4709:b0:488:ae6c:42cd with SMTP id 5b1f17b1804b1-488d6771b5cmr75264145e9.0.1776083058917;
        Mon, 13 Apr 2026 05:24:18 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm278260915e9.4.2026.04.13.05.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:24:18 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	aurelien@hackers.camp
Subject: [RFC PATCH 05/10] ftrfs: add file operations
Date: Mon, 13 Apr 2026 16:23:51 +0200
Message-ID: <20260413142357.515792-6-aurelien@hackers.camp>
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

Implement basic file read/write using generic VFS helpers:

- ftrfs_file_operations: generic_file_read_iter, generic_file_write_iter
- ftrfs_file_inode_operations: getattr via simple_getattr
- ftrfs_address_space_operations: readpage via block_read_full_folio,
  writepage via block_write_full_folio, bmap via generic_block_bmap

Read path delegates to the page cache via generic helpers.
Write path is wired but depends on the block allocator (alloc.c)
and write_inode (namei.c) for persistence.

Signed-off-by: Aurélien DESBRIERES <aurelien@hackers.camp>
---
 fs/ftrfs/file.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 fs/ftrfs/file.c

diff --git a/fs/ftrfs/file.c b/fs/ftrfs/file.c
new file mode 100644
index 000000000..ef121359b
--- /dev/null
+++ b/fs/ftrfs/file.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FTRFS — File operations (skeleton)
+ * Author: roastercode - Aurelien DESBRIERES <aurelien@hackers.camp>
+ *
+ * NOTE: read/write use generic_file_* for now.
+ * The EDAC/RS layer will intercept at the block I/O level (next iteration).
+ */
+
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include "ftrfs.h"
+
+const struct file_operations ftrfs_file_operations = {
+	.llseek         = generic_file_llseek,
+	.read_iter      = generic_file_read_iter,
+	.write_iter     = generic_file_write_iter,
+	.mmap           = generic_file_mmap,
+	.fsync          = generic_file_fsync,
+	.splice_read    = filemap_splice_read,
+};
+
+const struct inode_operations ftrfs_file_inode_operations = {
+	.getattr        = simple_getattr,
+};
-- 
2.52.0

