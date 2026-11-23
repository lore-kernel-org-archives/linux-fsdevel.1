Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795411015;
	b=Z5ukHmhcBS3fLdpKtAazqM7uMbN2eB2zM4LjGJuMtBEB9VANIlwms7iNQi8if/eQiIpm
	 XhN66zXRz/FW+jBCDIe+VTOiX3hrskcYeWVKUcshxwjxbbwMbzPdddl2rVdhRNTHTYD0j
	 kh6I49ht+jzvQaYP57nlt1Q7MXIKDSC/wVOr2m8UyjIGeTl+BxBt+LrBUhUOZMzYCY5ZF
	 hgwVwzLPKBt3SACMGEHKmIImkFwgWLw5ex7LHqJi8fOmVdXD5rfIy1gxFevd7BtJalaBn
	 xkqGDzqbPR/74ysepr2shrs+ivM1mIJBe2BhQHf3UIZ5Yv3cQ8JeaRUJCV6gqZx642Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411015;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zUa5uKi0VrDw4UA0BAsczrZyFuWjUpTgTE7iF1Q00ck=;
	b=sHY+XsbmzX+++SIcwmFOrqhEnYcUFLWJjKfR5XkIe1TYY4zNcfGM0cSIC1fziaZwwLCy
	 08BNNMi3Sn+gnP+rFkoHjmOoy7S+KHUP0ZgEZzRb9uB6g21mPBfdQFAiCD5L6B+s9kca/
	 txmR0Nn5vArqImHmSE8Yz2SstdcJ3gtCxrU6RtG7+uGuJLYUK1oDnyMfaoN2L5ddphjdB
	 9fVMWMz4kImvDfmp32ENjp53K7USRO+qhjvyQ6T/aRrM0EYIurTkKAxVdCfsdLeQuHMq5
	 rQFWmXsBkhTBa7r7SJ++veXOSGZTUPflipnZfxIbHEN1nO0fgeDFICYJHPU7MSr7d0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wAhSGHE5;
	arc=none smtp.remote-ip=91.218.175.40
Received: from mta0.migadu.com (out-40.mta0.migadu.com [91.218.175.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB1606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 05:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04CB1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wAhSGHE5
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AmAm6mxlSWJGoWywt8mEuBAs99e9NGK1yr/YzgW36PM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795411013; v=1; x=1796015813;
 b=wAhSGHE5/tzYzK08snun+0RY1ru0SAREMFedLQhbHkRQd5raTIU3Qtv1acmNi42tgUtB8Yq8
 NXWpZJhDQruy8HL7VGgLzXc62jymyZpYFfZPpgmZdpaapuvNQ+nh4pV216csvRq+kpT+U3JdKWQ
 d58sHTvxfgJ93ljHXhu605jw=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d908d048c329c710;
	Mon, 23 Nov 2026 05:16:52 +0000
X-Mizu-Trace-ID: d908d048c329c710
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: hughd@google.com,
	david@kernel.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	andrealmeid@igalia.com,
	krisman@suse.de,
	linux-fsdevel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 1/2] shmem: do not inherit FS_CASEFOLD_FL onto non-directories
Date: Mon, 23 Nov 2026 13:16:28 +0800
Message-ID: <20261123051629.2547645-2-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123051629.2547645-1-cui.tao@linux.dev>
References: <20261123051629.2547645-1-cui.tao@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

__shmem_get_inode() copies the parent's SHMEM_FL_INHERITED flags,
which include FS_CASEFOLD_FL, onto every new inode and ignores the
-ENOTDIR that shmem_set_inode_flags() returns for non-directories.
A regular file created in a casefold directory therefore reports a
phantom F flag via FS_IOC_GETFLAGS, and chattr, which writes the
full reported set back, then fails with ENOTDIR on every flag
change while dropping NOATIME/NODUMP from the same request.

ext4 and f2fs mask inherited flags by file type; mask
FS_CASEFOLD_FL for non-directory inodes here too.

Fixes: 5cd9aecbc72c ("tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs dirs")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 mm/shmem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1ecda28178e3..46e30b1f5ab8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3321,6 +3321,13 @@ static struct inode *__shmem_get_inode(const struct mnt_idmap *idmap,
 	info->i_crtime = inode_get_mtime(inode);
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
+	/*
+	 * FS_CASEFOLD_FL is directory-only; mask it for non-directories
+	 * like ext4_mask_flags()/f2fs_mask_flags() do, or the
+	 * shmem_set_inode_flags() call below fails with -ENOTDIR.
+	 */
+	if (!S_ISDIR(mode))
+		info->fsflags &= ~FS_CASEFOLD_FL;
 	if (info->fsflags)
 		shmem_set_inode_flags(inode, info->fsflags, NULL);
 	INIT_LIST_HEAD(&info->shrinklist);
-- 
2.53.0

