Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF13CB2DF
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089033; cv=none; b=TQo9ULFgW1iKPDZQuEphawv1gbYq8kSbtQCvXLH6WKDy0RymV3PIBaZW/kGIyaQUBl1ARMfx3QwXS14euv5gzDbhF0AA1yW/6brC5bUWo50CEYXVsRkB5aC5Z4YI+RTDpFZwWKkiS3hNEqr/wYET78TNweTIlmupftYQdemNrpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089033; c=relaxed/simple;
	bh=3n45xZfSKVIDlFM6Kgn6HXK1Qa6b66QdRPNOzH/dCMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j0hESUAXTEfAOAEn+ejXPBAP7ckg0M4u7vYvtfUQDAbgUGmhZNMRK/IEnwjeuNg9H+8+P7gURmHitDr0lUvTh5/fswEIs/2dafC44c7Kgz5EYkby06wtpjN2dFGO61r6KXui730/nx7P7YlY2HPZURTLaP6xB3HYP373+T+r8eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2BenqPd; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2BenqPd"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-605b3b6c4dcso2604966137.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776089028; x=1776693828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FxnO/umNBngoNT0kCEAoae6kj6gwTy259ZD1rGH+vQM=;
        b=o2BenqPdk5hUhOl+ICYWn4veKZg4da0NGC9kpa+1dYjS6FXx17J8Vzlg0RRRMuFdo0
         F5H0OUkNihu7Vw6WQq+1CHr+eq1aWU7hFfCqOk0Py9UVTn5Ur42abqCyqmxv0lN5gaUN
         J97BXB2duT91lY/6IrgDQDAdzrrC905JiwIYlBMl+RgtWCHQnkf3JpuxlAA1L8paIVG0
         b5GRHCOieprvXwtfwxFznIUBEJKGRs+FpzXHIzU6pbvZZTRAAF5QrWaPU9wtxJ8J7V3O
         xwpbPwcHJEsUmcgrw2q6ltR+FPxPpBWmvhDzkffBCkZcsSooeAzuaihtseMqDhNfPGji
         Gliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089028; x=1776693828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxnO/umNBngoNT0kCEAoae6kj6gwTy259ZD1rGH+vQM=;
        b=tTjQa2AVHLFtZvLU6f02zKuauCt0Gxg4a6b1hWR2uSnTT9zLK8bfyELoxpPGU8R0eG
         cg+jB6tfl5AuR9+Kg3IH35BUcQ0Yo42NEDEl8cwYCjGLPTk/VgXyOD7KjA+HHSCtEjnQ
         WWBglQ9TWeUWKUwdurt4s0g+MsHdnlyQW4Oxr3cwi1ax7AZzeKUHgH9AN2xffPdxBpV0
         sr+oHFDta0Y8DYGfmpoddfiB/Wj7uMaXKbs3vsC8WZGbti8yWgknZmL1sH/xrrrlAQUN
         Q7gyHKqlVLb5udffOEkXRClLuuu48HRz/TCMn1YgQfZyRBwjh/SLm5+JA5kIoXelqo0N
         lCKQ==
X-Gm-Message-State: AOJu0YxPyheE6yddbh+Sr3qQwRXXc88jXQCxcBz9Ca2z9nP/RVwDa2bk
	cf3s0GuSJIgCr9GUoCEwGEdvAmMNkuRWddyAxMHSjTpwAwHEpxDEaeDF
X-Gm-Gg: AeBDievM5jHEpfizeRfwZysopOHfpxIzVE5B8Ve/LnzYRw64VxOQJoO/k9WEow9Bp2i
	elinogLC1u1nUki4Wio1415SFtxHmOSb9lzpWxpyCeULNZMG5kkLf42WnPFZQYTUhGlqzzl4I1C
	1NnGDaaN32jmEX1rYdfle94g9WQhKCPUGSnJtbA2x2iZoXhwL9J5P1MAOZ6yPuzxzyTq4KUCR8y
	bPkOqlbK/EIpI/IhLiIELyivRpvmtX6QSdAbacziNa5hp7/xgyZa7/vBXWG3F2ox+292jm+EVW6
	t4wNP9k3CyfCf9TXPYo4ag7lLBXRrs36PLaY2RXqeCiwT1eknE54IbiwBNc+9DJoSnIdxkCLfoP
	2ym28IBog9dRy6PywdvgHxrUTrGO3Sz3NOQBQIQfLMTa5yHwTvvO9g0VuxnojZXLW3ZbF9xfYYb
	Pcpbn2UBGHTcsCBnoEmjF+Tq7MZ6TkcpsR3CE=
X-Received: by 2002:a05:6102:3e02:b0:608:e69f:a443 with SMTP id ada2fe7eead31-60a08c173e7mr4009694137.2.1776089028461;
        Mon, 13 Apr 2026 07:03:48 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d77:aa::11:15d])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-609d8c5b741sm6301514137.3.2026.04.13.07.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 07:03:47 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: greg@kroah.com
Cc: linux-fsdevel@vger.kernel.org,
	security@kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH] jfs: fix missing bounds check in __jfs_setxattr()
Date: Mon, 13 Apr 2026 08:03:28 -0600
Message-ID: <20260413140328.173446-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop in __jfs_setxattr() iterates over EA entries without validating
that NEXT_EA(ea) stays within the ealist buffer. A crafted filesystem
image with a manipulated EA valuelen field can cause NEXT_EA() to land
inside the buffer but past the last valid entry, leading to out-of-bounds
reads in the subsequent memcmp() call.

Fix this by adding the same bounds check already present in
__jfs_getxattr() and jfs_listxattr().

Reported-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
 fs/jfs/xattr.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 11d7f74d2..320659bb8 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -688,8 +688,14 @@ int __jfs_setxattr(tid_t tid, struct inode *inode, const char *name,
 	new_size = sizeof (struct jfs_ea_list);
 
 	if (xattr_size) {
-		for (ea = FIRST_EA(ealist); ea < END_EALIST(ealist);
+		struct jfs_ea *ealist_end = END_EALIST(ealist);
+		for (ea = FIRST_EA(ealist); ea < ealist_end;
 		     ea = NEXT_EA(ea)) {
+			if (unlikely(ea + 1 > ealist_end) ||
+			    unlikely(NEXT_EA(ea) > ealist_end)) {
+				rc = -EUCLEAN;
+				goto release;
+			}
 			if ((namelen == ea->namelen) &&
 			    (memcmp(name, ea->name, namelen) == 0)) {
 				found = 1;
-- 
2.43.0

