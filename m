Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302C438C2CB
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114387; cv=none; b=iWYUK5Xj76ffXUDw232c+fnRI1CfX/kY76fV6gbzQ2RjBB6++wKleMpZ7+WWoECpvZqzkbdo3eAZov7W+XAaVNC/nVvYbdpW0AJJuMBgHDda2n1A7IlVFfJweaMEu8gywXDXjGT4ynHe5f0QVINrsDsPNIODBb4Z38xMWxrp0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114387; c=relaxed/simple;
	bh=ESRzkVvOWER4qlZIiaT0hCchCEOjI9Koyz6YvBEQsqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOvjbz/6brLmRDzYiPwXfuT8fboy55uc9X0UeJRviTaJRDACZyDNpe11QgpFuV+YLnP3EVhedcJG/z+1S2oR1Ffrwfdi/5xdc4V79/fOGiZtQlRXl0maqBB/AzlUyde060OiRpW+n6vk/QS+DaGJhtirO5rCY3hEjQat7Aa9mOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cf5ba9b93so365835f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114384; x=1776719184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=efycFkVlY38OPi/zLUsHHPWsJjhRjzXk7nam0qEsQhs=;
        b=p/WBQmDk9EizZRkTAz7fENgnGMZ6StsPx74Y+LGFyKy/pra2XeBjrCQFdHj6MHWX2u
         r73+DsfkqEqRTLVPfgTW3x73nyvQo+wr5ckBi6uqzDmnhpvezXr3R9WekiazZrwk+hX1
         4pdaV714psizbUeFW92/8aFRRiePdOiRBpkT/ZIYp4dCIupjx14Kt152rjYqF1JpttAc
         ySl4iXL+HwgpEcLmfbeuYbjpiDmWCq6Nif6vBi44E4FS+rtDqDpwbDDXxnuQsw4mOoaE
         TWQj2KuW408giakIN3zbHYtdTQzFwXUEYBVxa4w6z+sNkPWsWeRtBJ2weTYoF3vrRa8X
         tdig==
X-Gm-Message-State: AOJu0YzPvgVg6I1RRoe7LhCWHXL8kxNlpvlyh/noAzUfMRm8XbMOUbfS
	yr8w+G28svvRdipXcVO5UpxIgGxB5GXsaoPG57/A4cAeKLxAvZ/x9baa5lemff6FzRo=
X-Gm-Gg: AeBDieuClQb0XFOk4Ka9gNvufWl9gqUCN2NPkBAxSqcy5tGFL3R2JcQXsXQR0V9/MQr
	dJOVOJmSJY9KY/odTPzhTmDjTsoYSLbLJr32ROy02u+Sx+NCFbS0UBxITFQNtL+TUTyT9fd9kEZ
	3F9tWMH62ewLXCpelW/Qvl60QkUZwE6ErSo456YZpFYh7qXiKnPme3D0mvO2wNVoi5THApAeNuY
	p9C97hwea3PSgpLYulhUFiGUky8NUifuqRQKY+amBQQbTo3eyeiwtVVnj3hDO2T6yTuRnPfKU7g
	xgSdEfehw4r2V6wMN3Rvr7g73jz0GTekd6F7Vum5WkYMu5gYpT6mFj4DsEJv/Lz1tQ5osyAaIu3
	aO/NdmrbaZGFvHC4ezqDPTJXWp8ZFxkeCp/MwjowP9Te1qS5ih/M8gJayYukz0UcgwW9auaklbW
	028Tes1WN+4M9hkywhNy3FjRSF1RLLTwzbis8TctptJnIiLpMnvMqJBqE2IhX2wJz9t6SwckI76
	rju
X-Received: by 2002:a05:6000:481e:b0:43d:64c6:1765 with SMTP id ffacd0b85a97d-43d65267229mr9435381f8f.2.1776114384316;
        Mon, 13 Apr 2026 14:06:24 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm35130020f8f.35.2026.04.13.14.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:06:23 -0700 (PDT)
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
Subject: [PATCH v2 05/11] ftrfs: add file operations
Date: Tue, 14 Apr 2026 01:05:46 +0200
Message-ID: <20260413230601.525400-6-aurelien@hackers.camp>
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

Implement basic file read/write using generic VFS helpers:

- ftrfs_file_operations: generic_file_read_iter, generic_file_write_iter
- ftrfs_file_inode_operations: getattr via simple_getattr
- ftrfs_address_space_operations: readpage via block_read_full_folio,
  writepage via block_write_full_folio, bmap via generic_block_bmap

Read path delegates to the page cache via generic helpers.
Write path is wired but depends on the block allocator (alloc.c)
and write_inode (namei.c) for persistence.

Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
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

