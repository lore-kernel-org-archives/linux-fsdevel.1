Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273A6388378;
	Wed,  4 Mar 2026 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613524; cv=none; b=UvMSlu6QMOKdqJKiGryFoHWw52b6pdBLqiZqy1CMzomCXlVCdvI/ZYjmNPgmcpVuIHzQTJlB/J8EtbVprGBWrWGzRwneaQpXNTFc1HYRp17AiAQoUI46G0sVUrRYZrtOUbLBW9AafU7/lKeAqQ2FUulMGxXtbvfSipXCED0Fadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613524; c=relaxed/simple;
	bh=S3FKeLJehBe81qRPExJNZyRgTXmTTbPArbuSCG3HEiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hOVgdtB3nrw9GwoZoBWz3P0HooGfyXcgBXF3M3fIpEOT4xFjrwJ0sx5uI5UnHdOBoBIlEvwpcqNeu5IRVFTGOuUHQo8uYF3Ks52ANao1axYkVqBkFB+G0z7ELLy7Kj/oBn+5A0InCkUhl8kMLTJBRuOjxYs3OHcAWfMWAmT/3sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUxYGkJI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUxYGkJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95323C19423;
	Wed,  4 Mar 2026 08:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772613524;
	bh=S3FKeLJehBe81qRPExJNZyRgTXmTTbPArbuSCG3HEiw=;
	h=From:To:Cc:Subject:Date:From;
	b=mUxYGkJI1+hRwFoyWujKXAaSzvRN76NAEu0OtEFbA6uP+JsZnQk83M9IrcrVuLprc
	 gtcnYWn+0pZ0qyhcYX0rWrxDtYtMaCE6F67hLebG+G8SNQWLYXx7skD+YsR3iao3R2
	 looK8gDkz+fSsiET3+uGcIAhUwx7ZYAQ9JGzINr6npN2JaAzpTP9UpRYKNKAIW9vIn
	 1m/T53e/OWL9JapGSASnJGIdkhmKttZdoqQytcnH3vLhlxpABW0AiLxGarayuguogZ
	 TiuGLAObUdcJQAD3YhQNjPlfhHviq0lnUwYwO+jC2DQH9zbjwvjN4z33y55BrFAflK
	 VCZRlgBVT46Zw==
From: Arnd Bergmann <arnd@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: reduce stack usage in ntfs_write_mft_block()
Date: Wed,  4 Mar 2026 09:38:32 +0100
Message-Id: <20260304083839.725633-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The use of two large arrays in this function makes the stack frame exceed the
warning limit in some configurations, especially with KASAN enabled. When
CONFIG_PAGE_SIZE is set to 65536, each of the arrays contains 128 pointers,
so the combined size is 2KB:

fs/ntfs/mft.c: In function 'ntfs_write_mft_block.isra':
fs/ntfs/mft.c:2891:1: error: the frame size of 2640 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

Use dynamic allocation of these arrays to avoid getting into dangerously
high stack usage.

Unfortunately, allocating memory in the writepages() code path can be
problematic in case of low memory situations, so it would be better to
rework the code more widely to avoid the allocation entirely.

Fixes: 115380f9a2f9 ("ntfs: update mft operations")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ntfs/mft.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 6d88922ddba9..b313793a397c 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -2704,9 +2704,11 @@ static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *w
 	struct ntfs_inode *ni = NTFS_I(vi);
 	struct ntfs_volume *vol = ni->vol;
 	u8 *kaddr;
-	struct ntfs_inode *locked_nis[PAGE_SIZE / NTFS_BLOCK_SIZE];
+	struct ntfs_inode **locked_nis __free(kfree) = kmalloc_array(PAGE_SIZE / NTFS_BLOCK_SIZE,
+							sizeof(struct ntfs_inode *), GFP_NOFS);
 	int nr_locked_nis = 0, err = 0, mft_ofs, prev_mft_ofs;
-	struct inode *ref_inos[PAGE_SIZE / NTFS_BLOCK_SIZE];
+	struct inode **ref_inos __free(kfree) = kmalloc_array(PAGE_SIZE / NTFS_BLOCK_SIZE,
+							      sizeof(struct inode *), GFP_NOFS);
 	int nr_ref_inos = 0;
 	struct bio *bio = NULL;
 	unsigned long mft_no;
@@ -2721,6 +2723,9 @@ static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *w
 	ntfs_debug("Entering for inode 0x%lx, attribute type 0x%x, folio index 0x%lx.",
 			vi->i_ino, ni->type, folio->index);
 
+	if (!locked_nis || !ref_inos)
+		return -ENOMEM;
+
 	/* We have to zero every time due to mmap-at-end-of-file. */
 	if (folio->index >= (i_size >> folio_shift(folio)))
 		/* The page straddles i_size. */
-- 
2.39.5

