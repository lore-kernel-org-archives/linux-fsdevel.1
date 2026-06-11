Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206C36CE03
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781213237; cv=none; b=sL+Td/rJ72bK65JB85cja9NWJIlk/Ynj2vY8R1FU7lImeorZQ1yvbvKbwQeEH3wLuPp35FW8zIVouEGWZKQhUV6pNQOvknM9JITDC/+M3Ldqf0ZnZMp4KPNunMNmHee8xS3zR3N55DYFhqXhTnsNb7nyRafCZXk38BtHftpOE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781213237; c=relaxed/simple;
	bh=C6j3x5WYRRV6ciwLPPZ8nA7aPINWU6dJHmIiSTjVJHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joT1uUNIjvQUZqs5WKJTMLjrfdKS4caD3gGRlOfK1Ow63VJVpMgeNjUOzRL7+cYaVlb8SZAgOqjVTlHypyUN9/JTxM491rNqIoQUgzgVo5o3dNSyg7bPLvXaAcVDlZBRg0v7msWkK9tf1ScorvqV2e2vU08FI1LvOUUEkbnsAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=A8Fl0Gc2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="A8Fl0Gc2"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ccf18ef922so4466006d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781213235; x=1781818035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2uVyCKJxMa4TJzaUAXJP9RjvhqBIOc1qSJCsvifbc2k=;
        b=A8Fl0Gc2rkMygUOSVpZyDvRwtdDAD4T8fIsjjP5oMeZxHy+W6BfmQ+xKorHOsOLdKJ
         T8dGTYUyItRQGLnMAPcXVTepU5KpsZlusYV9Y1CfCg6XdjM+fyTn8uh8cMXtZyhTikYK
         MAnSxUKifk/uq/r7ea1ic+9p6y9RBci3WQFQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781213235; x=1781818035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uVyCKJxMa4TJzaUAXJP9RjvhqBIOc1qSJCsvifbc2k=;
        b=ETbmo4gq11XMEvS4mzw2U5izhV2lbbmBJ9Q6/1Nmt7UDwF0n6e2xGGntiU08sJDKzs
         V6DH71kkcXLr5Y/5SkICPiNDFpnf0FPqz7q1QndfOWqqFg7Vy9mMHSdkZnx44HkoTHdw
         YgnkLClZwuf71YaZkk0zdWcEexXNONPi/5dTsrSagQ6qzO6vFfCgHnXyeR0EALx3vRFj
         RobGYM/1xJFDtGmN22NaA7Nq/lozL5Dilbsr/XavityZnZTTTx0a+E6qsAWvzptDMPCW
         So8I55MxA6+mWxAoN0RpPhKTvL2ZYrjlZwrbQ1KG8KfDYmMlq+46/MlBvakoC/wmvL+V
         ANdg==
X-Gm-Message-State: AOJu0YySqwZ/e3NDQ5sGDzPKFGK6V3Ib0Cb3KJW4vZE4GhJx5CHTZlaq
	XghIHX9ueAALpOiDqZmZbZ1BpN8rIrD6tVDq/Wvc2oTQZ7fDy4ZGrgD6C7V15/lIYXbQOiqmsEO
	yiwTo8jo=
X-Gm-Gg: Acq92OEOF778XQM90GMgVADXPvi2l+2RVNr1AhTx1L2y+Fv0sXYAsplT6pYpMI0ceqQ
	UufYY+uddlueoEVW/12UfZrqoPjPpPy/XqB5fQpOmkB8rwwjJm7nX8+8V5Sz5ipK+Arkfs+q/3k
	Rvav2tzRlAvlY3/LFIP7oCO5pPNQ0ZjH9C7bJAB/fdr60SJZBARKA7uQTRra5y6kZjpTJoc0WME
	1/pNPp1xgLnUJhRwvk/6ahTWPL/mHGoNMtf02rf/2iGvJ2kiQEPdl6dscP0QpbtqofCnzQLqt5f
	nmmhH05SbBs2LBQSx/tmcw/HbzAYg5qRupEskLMG3ySlsyJGxqqGKnjgXYxRESXgFjUkXe64C6h
	HHygRZG3WGmr8v5L5fjs/MyNz++dZCSKxaHOgOhYYaWYojKWu0tH2ld1VakQcuqxVhTbP0YbE42
	Y/tMva6QCRGWsx8/ylgcXxR3M3li9SYl9QYcq11RkExcVsgv/2gVpm/l33InChegs3m8U++/8vp
	lG4aByHSuIVD0JHq6bSXz+NKafnrHdWqMcRCnF+Jx43rQ==
X-Received: by 2002:a05:622a:4a0a:b0:50d:6b06:a453 with SMTP id d75a77b69052e-517ede809c0mr72346601cf.18.1781213235116;
        Thu, 11 Jun 2026 14:27:15 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7ec47asm3717861cf.24.2026.06.11.14.27.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 14:27:14 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-fsdevel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] hfsplus: terminate xattr names before listing them
Date: Thu, 11 Jun 2026 14:27:10 -0700
Message-ID: <20260611212710.5134-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsplus_uni2asc_xattr_str() returns the converted byte count but does not
append a trailing NUL. hfsplus_listxattr() then passes the reusable
conversion buffer to string helpers such as can_list(), name_len(), and
copy_name().

If a shorter converted xattr name follows a longer one, stale bytes after
the new byte count can make strscpy() fail with -E2BIG. The caller adds
copy_name()'s return value to the running output offset, so a negative
return can move the next write before the listxattr buffer.

Explicitly terminate the converted name at the returned byte count before
treating it as a C string.

Fixes: 127e5f5ae51ef ("hfsplus: rework functionality of getting, setting and deleting of extended attributes")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/hfsplus/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 452a1f9becb2..35fcbc397b62 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -870,6 +870,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			res = -EIO;
 			goto end_listxattr;
 		}
+		strbuf[xattr_name_len] = '\0';
 
 		if (!buffer || !size) {
 			if (can_list(strbuf))
-- 
2.54.0

