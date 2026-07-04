Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713EB2E2663
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783163483; cv=none; b=lZSVDmc/VS2NEoZVPAadaRx0hHucf5Oh5xAsS5i59LvHmhEDgviELYBQLAuPA26WM9V+Ghd7NH62qovIiwMsp2md/7PBzwmfzCaGEQqn7BKvYKUmyoT1jVfXiu0biPOPWDkeJyC1JlaNSI/pqSv3bxychgWV8u3/T2QOtclv1j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783163483; c=relaxed/simple;
	bh=lI04ZQUKahw75zIM8C4klSzCTtmR11ZJA6K/keIiiv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OUnser9Fzao5giCWRzSkuNsVBZPiMrnNtzG3WwP75KSQSR3DSdbS5WYRVzqZweKZbTlrfpMNIxA09fD6JVDJSzc89ZthezlSjM2d+AoE/v21M3I01YBFPlFgVroMKAp3qFMFSZT/Krg5L7X1sexHAmmunxw6rOzHiDYw6l1D7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b98f6CWv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b98f6CWv"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381065a7a03so1034497a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jul 2026 04:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783163482; x=1783768282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GCK+oncUKNOX6lhkOj6L4mSHBvEYFKVkwKqfBGA5JCo=;
        b=b98f6CWvsjAClRuSOOljtzxUbBfhu1q8YDjt6vkp2BNj0NJDf9PqpxWQFViExxYiWF
         piocDnMoanHd19zhPw8Vm6M2Z1Q9LkfSSyHKSr/UIPuUr5NcjFCvwJhzSxApQvVPkxsG
         ef9Z6TpQ7gO7pCMQ4YoBNEMMr4bdAhMsPhiPzS0OPSIq1kejhCdxusNT3yZDUASZ6oUp
         nb9Wb6XIVGIlbPYpWCDiA4xoNixp92hJQ+DHO0C+hMXf1zHmFN7HJ+JCIRztkq1xlXfx
         CuNnC+35X9+Lgwn7MKRWioOs7ag+MnpKNYbVgIIhBv+UKDnehq6MXiCQhTx/LzER0fPk
         o38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783163482; x=1783768282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCK+oncUKNOX6lhkOj6L4mSHBvEYFKVkwKqfBGA5JCo=;
        b=SO9Lq5iAIkMc40VQiW1bmDCaU9r+fNhiCdeb4fuColfJpEcukKa3uz0qGQZq1YXBaY
         95flFZwHoA9IDD+QZUj2iQVeXSOeEdBrig0FK7dVKJGIJSf3VvMf2LMFsjOk0YAWGBql
         JHQikB+iXOfL9aKHT+S4A6bbNOltgE39yWM3PlqULMur0/Uk07+ngzLXBrHUNboruX85
         EH2vRm7VYQ/EojblFQfUcgKzDTQw3Y7s44VGqZU1u3uTGX4Uoclicvf98b9ygZ0M1nVr
         GNfI91hq04xicbWA9E4pjyGvar//BzxN9pKjRvYZArayrt4SmnnWUGYQXdsep5CXHarB
         c3Bg==
X-Gm-Message-State: AOJu0Yz7IBD+88/1dVrsKanvRsMEidzcFuXeuEUh8PEf8Cc8NvxVciD2
	GF6cqIIu5t8+a8JCzvEA7lEAdZ70/iUVTbFOrTzgSCkz/4eTayi9YNwS
X-Gm-Gg: AfdE7cm1aIqLIixXaxOdJH7es2D/dcsWtsbjfFh4YBYDmVIzttKLwgwfzTwiQUe1EgG
	gx+VKTLUxCNrn2rt74TPkHPL0nefHpaa0crR7VLsbCqWpeCTZaou04d1HbuWuNDNa5BWklrzGWm
	YtGpgqiXYm9bT7DqeZmwmR2mwkLq05a3awARJGS2/R7+D1Iu5C2Scoy7IGp9SkLi+hDt3dibvNQ
	t8A/Kli6nTXSNsVupLHyxAm4IQ9jMUnYX39FsR9EB4TgHaied6jb1HJL1pkv8e6oEXG9zkxIW+n
	8irtAiAUGRrYNZUX0GwrzPOvhmXLkj8WkPS6tUOkRvUlvot0001LZ76KR9Po9XQmS06bGht/0MN
	GClGEECMd7CICQB/K5/Mp8Z+KlDh0EH4wLYgeJZS1etqG5xfIlVnpakeQDqoWkQTrsSD+43cVuZ
	iSaq2Ufl6yU1E=
X-Received: by 2002:a17:90b:2243:b0:380:ced0:ecf9 with SMTP id 98e67ed59e1d1-382802bbe2dmr3234795a91.4.1783163481544;
        Sat, 04 Jul 2026 04:11:21 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:6162:d178:1f74:3068])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc2e119sm30335125eec.28.2026.07.04.04.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 04:11:20 -0700 (PDT)
From: mdshahid03@gmail.com
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH] ntfs: mft: use kmemdup() instead of kmalloc() and memcpy()
Date: Sat,  4 Jul 2026 16:40:57 +0530
Message-ID: <20260704111057.114173-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Use kmemdup() instead of a separate kmalloc() and memcpy()
pair, simplifying the code while preserving the existing
behavior.

This issue was reported by memdup.cocci.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 fs/ntfs/mft.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index a5019e80951b..fd07d41c2741 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -2420,7 +2420,7 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, const int mode,
 		 * record.
 		 */
 
-		(*ni)->mrec = kmalloc(vol->mft_record_size, GFP_NOFS);
+		(*ni)->mrec = kmemdup(m, vol->mft_record_size, GFP_NOFS);
 		if (!(*ni)->mrec) {
 			folio_unlock(folio);
 			kunmap_local(m);
@@ -2429,7 +2429,6 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, const int mode,
 			goto undo_mftbmp_alloc;
 		}
 
-		memcpy((*ni)->mrec, m, vol->mft_record_size);
 		post_read_mst_fixup((struct ntfs_record *)(*ni)->mrec, vol->mft_record_size);
 		ntfs_mft_mark_dirty(folio);
 		folio_unlock(folio);
-- 
2.43.0

