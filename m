Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0273BFE50;
	Mon, 11 May 2026 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493094; cv=none; b=Y+tJ8Tu1Cjb4bgidkFyBlN3cmvKkz0Zo7cJqAhHVmfFO+613T6BGldy4txZK+sXYrewefp0s6waCjIk/GdcdnuhqlBILBOm7a3dCf6sXLAWq7fF/jMysO+LAS4Y7ezNp7MGXddXcKZZHB8KekoxXi7RSy2B8A1EuadunWzfxT4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493094; c=relaxed/simple;
	bh=BP88EZOsXq1auTaDhjRrI1ZFrIxSW408tbTGb8hkocE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=phIBx8Q8D6KXPVCIHJAHKG2fASFdTofPO74K/L58HwyFalShC8CX1xN0kPLDLuHhdzwtgXNSVubAHODnQqPN+O6Ei5ktcxzwSwW2f7zY5bqYBerslORvmyIXTSUmeUFgW7rWD8KGv5hm/iN9JZUnBjD83gXKuq608AtoFKUgsEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BHZVwKhJ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BHZVwKhJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778493089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xtQwg/QyF54IZkOcBvD26Jy4jbiDtoADO6UcGMxJJgU=;
	b=BHZVwKhJwzYlZ6k08pJ80vGnvPecMFyS2fyPZaQXLcjM/PL8+dFLqzRWZO0BBrbJ0Agf/w
	gBO1qTUUacNPNwyWua4M4vgDB65gCGzwC9ySBgiweAir9Xj5cBN/erUz+OPF5GpUKrehOc
	u1x5JGAYp9n+o9Tc9ejxuMFtJ/FdpkE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: use str_plural in ntfs_attr_make_non_resident
Date: Mon, 11 May 2026 11:50:33 +0200
Message-ID: <20260511095032.155854-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=899; i=thorsten.blum@linux.dev; h=from:subject; bh=BP88EZOsXq1auTaDhjRrI1ZFrIxSW408tbTGb8hkocE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmMyzIOJ/iKafw5kP4lb0drt/Rh5+UBj1M2npvlHPDB6 tsTsdmRHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRL5MY/rsp3NEKLfx0Sy2c 5/DBn18UtrL61Afs2ellos319sWxWbMZGV51T2zLnjGPp3aVp+CdY/YJXfvfdankrBRfdXdKldZ TJzYA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the manual ternary "s" pluralization with str_plural() to
simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ntfs/attrib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 97b660eaa00c..162aad2cd08e 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -16,6 +16,7 @@
  * Copyright (c) 2010 Erik Larsson
  */
 
+#include <linux/string_choices.h>
 #include <linux/writeback.h>
 #include <linux/iomap.h>
 
@@ -1857,7 +1858,7 @@ int ntfs_attr_make_non_resident(struct ntfs_inode *ni, const u32 data_size)
 		if (IS_ERR(rl)) {
 			err = PTR_ERR(rl);
 			ntfs_debug("Failed to allocate cluster%s, error code %i.",
-					ntfs_bytes_to_cluster(vol, new_size) > 1 ? "s" : "",
+					str_plural(ntfs_bytes_to_cluster(vol, new_size)),
 					err);
 			goto folio_err_out;
 		}
