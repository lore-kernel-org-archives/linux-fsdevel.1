Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084C33CB56F;
	Sun, 20 Sep 2026 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889544; cv=none; b=WZOG+Shzj5grdHtU3Wz1cz9EtxkLLBgmVnarnt1JNYKrYvJkFDSh1M4kv/Zx7vEqEC8ZguRRJFV2DcjgtIZM7XqA4RgzY2pYQlentvjfFcUr6HA4pJzFNRxUnJkD1qCyMsGV5KystvfDxJETSVvEy4gJM+3J+V7+/JnieDBIjFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889544; c=relaxed/simple;
	bh=T+5+dqdAyAzrONNyBf6pIH6zZmTMzQ+XFmCxvUTtTUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ttoLT+do7G8ChJGnJVtYDdoNpskQv1kw3GbdfDX5xwfHj0dTGnh2ifwN2RYCiTiysgHZNRBKgT08TiDPAsHcgmAHoG25Wl/9+fz8f0iKVwTVC+Cw/scstyB7FMeJqOlKbUBONOEMTv3imWGIoH2ESMMEgNPY9yW5NB1/BR4Yiko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hndNN1Kt4zTSdl;
	Sun, 20 Sep 2026 15:32:04 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hndNM4wCxzTSdl;
	Sun, 20 Sep 2026 15:32:03 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id DDDE93027FCF;
	Sun, 20 Sep 2026 15:27:38 +0800 (CST)
Received: from hsj-2U-Workstation.hygon.cn (172.19.24.226) by
 cncheex04.Hygon.cn (172.23.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sun, 20 Sep 2026 15:32:01 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>
CC: <zhongyuan@hygon.cn>, <fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>,
	<jack@suse.cz>, <dev.jain@arm.com>, <ljs@kernel.org>, <adobriyan@gmail.com>,
	<akpm@linux-foundation.org>, <hpa@zytor.com>, <ryan.roberts@arm.com>,
	<mjguzik@gmail.com>, <joel.granados@kernel.org>, <jannh@google.com>,
	<oleg@redhat.com>, <aleksa@amutable.com>, <legion@kernel.org>,
	<kees@kernel.org>, <joannelkoong@gmail.com>, <tj@kernel.org>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <sandeen@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Shijie
	<huangsj@hygon.cn>
Subject: [RFC PATCH v2 2/3] fs/super: introduce a helper sb_inodes_empty()
Date: Sun, 20 Sep 2026 15:28:10 +0800
Message-ID: <20260920072811.2064247-3-huangsj@hygon.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920072811.2064247-1-huangsj@hygon.cn>
References: <20260920072811.2064247-1-huangsj@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

Introduce a helper sb_inodes_empty() which is used to
detect if the inodes list is empty.

Signed-off-by: Huang Shijie <huangsj@hygon.cn>
---
 fs/super.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 9d4025213521..e25ded0bc9a2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -710,6 +710,11 @@ void retire_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(retire_super);
 
+static bool sb_inodes_empty(struct super_block *sb)
+{
+	return list_empty(&sb->s_inodes);
+}
+
 /**
  *	generic_shutdown_super	-	common helper for ->kill_sb()
  *	@sb: superblock to kill
@@ -760,7 +765,7 @@ void generic_shutdown_super(struct super_block *sb)
 		 */
 		fscrypt_destroy_keyring(sb);
 
-		if (CHECK_DATA_CORRUPTION(!list_empty(&sb->s_inodes), NULL,
+		if (CHECK_DATA_CORRUPTION(!sb_inodes_empty(sb), NULL,
 				"VFS: Busy inodes after unmount of %s (%s)",
 				sb->s_id, sb->s_type->name)) {
 			/*
-- 
2.53.0


