Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC03CE498
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161257; cv=none; b=k893iGdfN78W6tWvHRjO1nrYNNDnU/b8n9NpJpyh37LmxVlOBbkrTRaowxg1jv6sqGUzlNQ/MQPv/isVsrBuKG6/B/roFReIVqAy61AU3D8MVP4lnvWfUaIZb6CSpKbZIYHqFo0pyo7otiTVdIhFw4C9xoRrLx3+ywCYwih+pYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161257; c=relaxed/simple;
	bh=MZhLO5vOeUNINP+HUF/YokkPpYoIjLJem7XwEBcHXDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIuG/KXrgAgKxMP/5Yb38dQALTj/o/LOgjObBA2KUaZjS4AjdWbJSopbBXXMNLXgmLJ5eLF2TA/oFOpvLLCOdWIwDmFhqKa7iTeXFtEnxYVS6qMeJUHxHPic2U6s3rMJTad4gwGXl2djvjri2aJ8CUA1sDIfAulc/uN0yUBZqVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48880947b7dso7320905e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 03:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776161254; x=1776766054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x31a9VYuI8ziW8OcLILmPawSpu3o6edqbX2Sgd95MQs=;
        b=VRFLj9uvPqPNkzwGkXgjiR++B+EdFeCKzKBwnYlG6ollsj5wyejIhGUA+rMtj5oJJU
         GmU58gFyoJuXXvU0w33ZMTV9h89JNOix9qbFPuhKmfu7qLPSGatQvafvGuj3aEew4HZw
         IQrGa5uOjIDaboRIFqCGchbCrxQw3jXYqPAUfIPRwkMU2feDOakasw3H7dAfO+vbq/Z9
         DHxl1CK6zsCsgPdFLKUN/p6NEn6PQpMvkrQ9WtvgR94aIjheqjyK2Pwzugwg49iS+ekU
         K1j8iTijfg3YfsZ1liWYjQql1vbP0DR5lRgxpAbhWdxHSl5LTOLRHK8SFlPG7MJRUrs8
         vlug==
X-Gm-Message-State: AOJu0YzyvmuQeJ31wVYqi8Oja7JJiSu1/zJjW1Y3jZ6C0qSEmjr2mAN+
	6pyf82kpffWgJxRZ74m3Yff07/2XkJfphFZbYkdSJ7caYIBHrKAXMJHwhB/ii8mI
X-Gm-Gg: AeBDietVEPBEjh43zcJUizTJi15BgeZz34jhy/jDEqdNDKbq1ACbDipzDy1DFpAYda+
	4bbV81bndUKKBoxdKzLWP3QLgWoSJNXDwLkfwGxwMGiIVWlW2L9EJtfHZaIEEAe7ATQtEDuQBaK
	cHkAjqRdfOLh+JyHBk7hgl/kryu/f077FjDV/eZfqr7lq1YAuK+zsr3swb89tyL2nfvhkJlQgNo
	lFJkvvXOxtbnEb3Vug+G6onjSXtqttibG5+lEutYZe00SxTHk4p77QhwqT8xJch3g1bwrL3tC20
	vANSZEwt3opqYEOih+ecWJzxyU4jaZlQ6Clhv3s9/OWhr6Tt8P1dWs97BqovRh71wm8dCyWLHog
	Bsb+xQG0cc9pp/SM9Njd80SA+UTycH+nU4rSjWykr7s5aIRhSQPWCOUPsqYeqLI3zYl1JrP4Wxg
	m7vvcdbklUAwCI6e630dPLntuhq9NG2c/1FdSCCvFTD4XUKH/BXPSZrU46rH/itPIkKWUppooBD
	++UwbKCKIcHsw==
X-Received: by 2002:a05:600c:3ba8:b0:488:7fd3:5cd5 with SMTP id 5b1f17b1804b1-488d7eac3bemr128539225e9.1.1776161254482;
        Tue, 14 Apr 2026 03:07:34 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e050sm65870545e9.5.2026.04.14.03.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:07:34 -0700 (PDT)
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
Subject: [PATCH v3 05/12] ftrfs: add file operations
Date: Tue, 14 Apr 2026 14:07:18 +0200
Message-ID: <20260414120726.5713-6-aurelien@hackers.camp>
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
index 000000000000..ef121359be77
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

