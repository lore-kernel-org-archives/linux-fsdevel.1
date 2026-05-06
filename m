Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1314B08A
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 09:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059494; cv=none; b=iKpM7OBl/o5G24BpmuuAxqifMl9gwe4IKsNq98QjAhF6hPXQ2Tp0DoMOcWvAKJ9nYMgjYme2CshASN4Pfq0DQ2ddk6Xyy+QWkL7Uh5HGUG0RmgCppboGrJN+I2w48Vzo8MsJGmNNo91lK/FYraz0izKEd2ALnnz886moQYOlFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059494; c=relaxed/simple;
	bh=OV7kw/pGisRe9JOuNhKKAFp1urzMk+K+3mO5rR+o9CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrdoGHg0+14OVpkOB4qWZgJkXOFV+kBb1rO1rViLbIEEnYrsVf83n9Ux5abMxCAyPQfYj5qBotDAPjG2tl8Ooo/YgRVMG6aSam3e/Hm/4XOt3U+6bHOeyXb0q+L/Ym0WMCLTJbK/DS6et16humrTFcPavLQmnU3NENGeSo24MxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFfCSmAT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFfCSmAT"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36526b81c21so421753a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 May 2026 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778059493; x=1778664293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVw4UQ1Otw6PPSYzAZJJw/x+RLkMIP+IcH6IHhLdhuQ=;
        b=DFfCSmAT2g1FMDV/A69vtN7FzMYztdQVCTbrkR3fU+/s1pn8pe7LYeMbhFW0hR7Zz7
         kfi0YcVDY3VhqUBwj8FhYGdkvKbRnHhI/1da2OapfCwzAimdz5mHp0NKcosjQMXFhOpW
         4eeOxT7EN9j354U4cJu4nXh37zUgalxLOUAQAl7S9w1hkMhO3KLzu56/uNmjQ1c/zGxV
         9QKp8zSjZZcChprz4HvPhUkFc+l2/d7agY1V4zVkDVlkWYOQQLKKjITzbyQYG2m1Wfzg
         cewCruCaCDLJpx7HmmQEL8l6M9MFZfZ8i++rQqYc5X1eZZMav0q4L1nv/DevadiG2VES
         T2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778059493; x=1778664293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IVw4UQ1Otw6PPSYzAZJJw/x+RLkMIP+IcH6IHhLdhuQ=;
        b=gNZ9irvlahgmb8pH6BGm1IW9NhC8XAwIB891vQ4St/uE2Aji8JYZVOdr1NM9TA3kc/
         Cj/N1opo7fr/b6tocnvFoQYwhaUUM3LOUDYJgUKt7pt60DKsI81sDKeZCq8zcqwVS/wx
         /xLOdUAOnX5bKPiDsfdoTBBKL5bb69f4L0KEVmCPj4oNE9qvKQdOwkqxQNfphpqzIipS
         t10agRMjItNyJCFfjLFsJKS0rzxTuvPTy5a2DhRHGGXQ1Ee7ZIFOZ0L/DzktB9639dNi
         w3SpJ1sSqC+AXNQYW3om3rNhpLs+Qwjsm4XGxcpZO4xghG59M9O5rWlgQctNsNYaXfQ9
         0L4g==
X-Gm-Message-State: AOJu0Yxc9JOR35C2kY22QkUmY/VVlLwIBL0ztdTMEVZlAvsbfnY2f6sk
	gK1pMmp60TDQ+/yKfnHu1XJvqwRyeXTgvk2PwhzwDM9vhzF5adUqS2F4
X-Gm-Gg: AeBDietxifgdvMNLhESDur52Q1EN0LGDhgGARXzjsTgRzYWwO9fA/w8xs81OogL+1hE
	houPmKY8UYef6jfh0M4ErE/6LWvZef8sk2eeRsEPFZD3mHaookHtZmSBR4gjFQ1x6MgPxgSNaZ7
	HgrRpAQXSPZASpo2F1dw40m8WOjxdrfy7qbT0DIH5VGqgV3YWbHeaPNGzCTX6YL/ZGoK4xW7Eme
	rG4Z9at/D+PB1oCJEOmfTgxVqxqWDaksLGqNRlE5LoevF9sTCPy8PGCkXfGp3XLstPpZgyyIa5I
	CIzGdu519sDfzo06ndpOyZUqArgPUhKmYlE6kYar1jsAcdijHXOQZxWKmycoXiYmTM37Qs5o8I5
	uvQ+RzC0d0TCm0QnDGxkBqXh1BcmS6JCQv/NHcyrHwEHsMnhZM1EGdYBDpANylXCFB5rdK2DZ5f
	igiMCo6yDPh+kfJgbE8YoAFylvP+k=
X-Received: by 2002:a17:90a:c886:b0:35d:ab8b:abe6 with SMTP id 98e67ed59e1d1-365ad70d711mr1408222a91.4.1778059492859;
        Wed, 06 May 2026 02:24:52 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b4bc8fb9sm2101888a91.4.2026.05.06.02.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:24:52 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2] ntfs: fix out-of-bounds write in ntfs_rl_collapse_range() merge path
Date: Wed,  6 May 2026 18:24:48 +0900
Message-ID: <20260506092448.521995-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504154851.3034915-1-charsyam@gmail.com>
References: <20260504154851.3034915-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_rl_collapse_range() merges the run on the left of the collapsed
region with the run on its right when they are contiguous. The contiguous
check chooses a clamped index when @new_1st_cnt is 0:

	i = new_1st_cnt == 0 ? 1 : new_1st_cnt;
	if (ntfs_rle_lcn_contiguous(&new_rl[i - 1], &new_rl[i])) {

but the merge itself uses the unclamped value:

	s_rl = &new_rl[new_1st_cnt - 1];
	s_rl->length += s_rl[1].length;

When @new_1st_cnt is 0 this computes &new_rl[-1] and writes 8 bytes
before the kvcalloc() runlist buffer. The path is reachable through
fallocate(FALLOC_FL_COLLAPSE_RANGE) starting at vcn 0 against an
attribute whose first run after the collapsed region and the following
run are holes. In that case ntfs_rle_lcn_contiguous() returns true
because both checked entries are LCN_HOLE, so the merge path is entered
with @new_1st_cnt still 0. Such consecutive holes do not occur on a
well-formed runlist (NTFS keeps runlists coalesced in memory), so this
OOB path is only reachable from a crafted volume.

A normal runlist has no element to the left of vcn 0, so the left/right
merge is not valid when @new_1st_cnt is 0. Require @new_1st_cnt to be
positive before checking or performing the merge. This skips the merge
entirely in that case instead of clamping the merge target.

The out-of-bounds write can corrupt an adjacent slab object. On a
non-KASAN kernel, it is reachable after a crafted NTFS volume has been
mounted read-write with the legacy fs/ntfs driver, by a local user that
has write access to the crafted file.

Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator")
Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
Changes since v1:
  - Skip the merge entirely when @new_1st_cnt == 0 instead of using a
    clamped index, per review feedback. The clamped form silently
    changed the operation's semantics from "merge the run left of the
    collapsed region with the run right of it" to "coalesce two
    right-side runs"; the new form closes a path that is only
    reachable on malformed runlists. Behaviour on well-formed runlists
    is unchanged.

 fs/ntfs/runlist.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index da21dbeaaf66..e7de3d01257e 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -2056,10 +2056,11 @@ struct runlist_element *ntfs_rl_collapse_range(struct runlist_element *dst_rl, i
 	 * consists of holes.
 	 */
 	merge_cnt = 0;
-	i = new_1st_cnt == 0 ? 1 : new_1st_cnt;
-	if (ntfs_rle_lcn_contiguous(&new_rl[i - 1], &new_rl[i])) {
-		/* Merge right and left */
-		s_rl =  &new_rl[new_1st_cnt - 1];
+	if (new_1st_cnt > 0 &&
+	    ntfs_rle_lcn_contiguous(&new_rl[new_1st_cnt - 1],
+				    &new_rl[new_1st_cnt])) {
+		/* Merge right and left. */
+		s_rl = &new_rl[new_1st_cnt - 1];
 		s_rl->length += s_rl[1].length;
 		merge_cnt = 1;
 	}
-- 
2.43.0

