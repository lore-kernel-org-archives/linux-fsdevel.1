Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CCB366068
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774127207; cv=none; b=I8OMZjAIRvq3u41Z2s4GbQt5gBfjyqQgmZ3druvMZrIVHNMbwdWuxcgqPeXQ09MckGYYM8Dwliu3l43wPdTCX6QFryDmYasD+qlMykr+fuk53floYRZv3JGvitiu1BPjaF2xNjMPr6A8B6sONRtvHt9npD4q7RfyyKRfcZATwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774127207; c=relaxed/simple;
	bh=PbDyHHg+NjQxGlO/CtdZmeUhNeGr3LmODkDDK/afMZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtsrU1Dp5qBYuNYz9HNgsmoRnaTantRlZ0gIbb1372j3cnZ4YDd/VUMRHpjX3MaKcLxIJ8rv7RzYnWjsLDmu1JKu+KGJJ54PeiLuKqb/X6G2qy9qGOOevo8JyPJLq9FZ+zKVg4zOJFkbQH1phyGpW5IcEWZjS6L3Ud/lxCqa3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OE4hOH6X; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OE4hOH6X"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774127203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xX545N/wPXYLjYwvH9ZvJG1Qb9H1COfqtEUVC4IauDM=;
	b=OE4hOH6XE2W0MjVivXs7Dti8Hs9MDOvm+PA1E68sBk8l0eZnm8n8nId0Wuihb/fAyaDIsB
	D9d3v119F/4X7dAhsOc8Tthn3w4ANAKwNYeYll8enVDClSoJWW+HyBX8opnL2kM6/h3o9K
	Jub9bt1TQzoc8ETtR5PyqMOv4eOS3yM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fanotify: replace deprecated strcpy in fanotify_info_copy_{name,name2}
Date: Sat, 21 Mar 2026 22:05:47 +0100
Message-ID: <20260321210544.519259-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=thorsten.blum@linux.dev; h=from:subject; bh=QCdh4GSg6Hu34nAaRCGxcKSwZBxZhtHGrZw7LDbhfFM=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJn7OTR+cpZk2+sctVoobtvBtENFtrKcabeU1I1fuf9qw rrmfFnTUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABOZcZaR4Xll10n7y+cL9Nv2 G/XdW6b3db7p+x1dPi6X9uxWX/1s5SqGP7xL560K4wiwD3vg3hpQ25LfwDr3XPjaFS92rxQ8xLT wCSMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() has been deprecated [1] because it performs no bounds checking
on the destination buffer, which can lead to buffer overflows. Replace
it with the safer strscpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/notify/fanotify/fanotify.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 39e60218df7c..a0619e7694d5 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -2,6 +2,7 @@
 #include <linux/fsnotify_backend.h>
 #include <linux/path.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/exportfs.h>
 #include <linux/hashtable.h>
 
@@ -218,7 +219,7 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
 		return;
 
 	info->name_len = name->len;
-	strcpy(fanotify_info_name(info), name->name);
+	strscpy(fanotify_info_name(info), name->name, name->len + 1);
 }
 
 static inline void fanotify_info_copy_name2(struct fanotify_info *info,
@@ -228,7 +229,7 @@ static inline void fanotify_info_copy_name2(struct fanotify_info *info,
 		return;
 
 	info->name2_len = name->len;
-	strcpy(fanotify_info_name2(info), name->name);
+	strscpy(fanotify_info_name2(info), name->name, name->len + 1);
 }
 
 /*
