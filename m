Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAB62D3EF2
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779509691; cv=none; b=bv46cGE4CQtWvZdVkMECH970Emou6V0W7o4T3u6oEU3cB/NSO8EUHpO44kK6DElANZd/UDk9Wjq8FMicWpAjFbF5Qe9P6WAtLOnBQLqORB6sYFBQQzDFlrZs0TskORp3wi3LueN29Tpi0ZgbDLA4kgPzg8AFXdDPBBARboeACro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779509691; c=relaxed/simple;
	bh=f+azTK6QXMqtmyRQTS3y8fuUyrnaRmJnLJzr9mzdhjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dk1mdYN9xaRRgS15EORai5SVV1SIi7D09MflLPIed+wqK/g/v/Cd1U99fNcozkYEO53Q3rgdy9xxnj2OBNS+UHuMvjjzLT06HTSMD5tIr+QtZvSrLXRFq5f1VvSYnXLQEv+S4Yx7b8GESUe+Ht1EpDbojyrKA3e3jU8aJfE6rh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JN2pi2WZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JN2pi2WZ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3697c35eab7so4802098a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 21:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779509690; x=1780114490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+sM2ABwWONuJIwpZXzmEyG7dDsY6RptZTNrjOe2u9CI=;
        b=JN2pi2WZbL45E/rLc+PHxjv+a660Qt1cMAe9Zx6S9raDe3esHmFLgeP9kjOy1s2FZb
         LjDuWVCDw0TFzLTFCRJ+FugRGzdWkLPvXmt+d50rmDXd0nLpTnFBqbXjnVQSGuroFXq7
         5CwFvRzP1KtW/0EQZnAyqOjTrFp6aE/X2K/jcofym99145KsKPSgsDfAwUEOzZ2/oKEG
         7Os6JzKU0TyeSnIkgR0o0BXeGJpmB8HB3a2XZsuV0ERA+TYOc0WU0FhmNZpPj9YG/TBR
         ENAm+5k+wLj84CH0KrLdwftpc9O4/0J6qdwEiTycGoGdqbnZg04MOI6/4Gny9RaqcC0X
         U6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779509690; x=1780114490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sM2ABwWONuJIwpZXzmEyG7dDsY6RptZTNrjOe2u9CI=;
        b=BMmAOUToA3eI9lf805MplkffJfmrO0HcTxNCJklAFEt0E4t6xsA5IQDUYR3IX9M7Lh
         sE/vx0TKK5t+HvEf3u0/g11yoA7JU+QFAqiFYBvrfTYOFFTnwSsUmEp2Nj146Lh/8Mgc
         8a2ybfAiqFcr0X51d17tjiMZVq1ngZ5Ho5uAZwBOdWgZbTSh4o3liyTne7Lj5JriL8uD
         2w1SKSoMSNSkj6b/luhMrLfIeMHle9qPr/XyDyCBtPhfzyM6XCXrUO34fnV9dYWo2s2A
         3DCkl1rKTJykfLO72KX40YJiX+K9hFjQmCOu/r3IibvDkykTtqDIi/Pckyf062OLRnQN
         wycw==
X-Forwarded-Encrypted: i=1; AFNElJ/cW+0q73ivKEW53nkDu/9982SmppOfFaOggm/zpLxb4jghbMeg7rqtOG/e1CSgY2TfCjyFFsLMZkuUYO+K@vger.kernel.org
X-Gm-Message-State: AOJu0YwcFI3ZorjRs1ZFKZajh61QvgRxkTM8Xms6PzNQK4tQv0qhA0ir
	5RDrRH6J47ZyL01geRb8BDE49n+a0ykc1jNPug2SZwURjt1V5j9DurRf
X-Gm-Gg: Acq92OFa8r8Sx3HnaBrehk12R5ldvcZYk16aQ1DXmwhtUqVkrqAkfHFFZvxwI8zlYYD
	q5/or1YYpV5nzlR9zggtCZDU6w22wZ81TAaDIh55SMeDD0IgAFzv44sve/w3ej1v8S9XslfJpmr
	CJKaIzPFEjiNwznRRe3iypx7D6AlJCu2wOkPjPOayeF/L6akrAntEy2deEw/PaXlMPo8UQpm08M
	nwEwKLDV7KMHotgOWau3gpUgGZWzA6YvECWyy0NfMUn3cerSwKE/qRGCES0+AVEoKg32XCWDvLS
	5yAol+F2B9WZm/KC3Iz2FbUqIF/rb6Qi/bF2cV68TCIe7lIB9I1tcI95gBBKzUmCbnZqZ3kuows
	KI75cwR/w1YXh7qz02I9pdKtfh22KOn5PwzASWmZUYoMWAqUL7PT2xtXjVoQyqVdVIvtiWEWJ7C
	fNjnDYEeNpDDPDOtoP5GpQCvLNOGutgw==
X-Received: by 2002:a17:902:e88b:b0:2ba:5e44:ce8f with SMTP id d9443c01a7336-2beb02460fcmr63880165ad.0.1779509689515;
        Fri, 22 May 2026 21:14:49 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb591a277sm31887675ad.80.2026.05.22.21.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 21:14:48 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	charsyam@gmail.com
Subject: [PATCH v2 0/4] ntfs: tighten EA and index metadata validation
Date: Sat, 23 May 2026 13:14:19 +0900
Message-ID: <20260523041423.2726275-1-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series tightens validation of on-disk NTFS metadata in the read path.

The first four patches move index validation closer to the point
where index metadata is read and tighten the structural checks for both
$INDEX_ROOT and INDX block headers. The last patch adds a missing bounds
check before accessing fields in an EA entry.

To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: charsyam@gmail.com
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>

Hyunchul Lee (4):
  ntfs: validate index block header more strictly
  ntfs: centalize $INDEX_ROOT header validation
  ntfs: validate index entries on reading
  ntfs: add bounds check before accessing EA entries

---
Changes in v2:
  - Added a Tested-by tag.
  - Addressed comments by DeaMyung Kang.
    * Patch 1: Moved changes to make make ntfs_index_block_inconsistent()
      return -EIO from patch 3.
    * Patch 1: Made ntfs_index_header_inconsistent() verify the remaining
      space before accessing index_header fields.
    * Patch 4: Removed a redundant pre-loop check.

 fs/ntfs/dir.c   |  64 +++-------------
 fs/ntfs/ea.c    |  16 ++--
 fs/ntfs/index.c | 197 ++++++++++++++++++++++++++++++++----------------
 fs/ntfs/index.h |  12 ++-
 fs/ntfs/inode.c |  15 ++--
 5 files changed, 165 insertions(+), 139 deletions(-)

-- 
2.43.0

