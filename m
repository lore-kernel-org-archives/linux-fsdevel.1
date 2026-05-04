Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2813E0C5A
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909738; cv=none; b=bzexyX3gKYy/q49tC3scC2TCgYEgm7kf0vkjEhgiVUjCyo4G2B0Isza60n3c3Y/csrs4AHxcoRp7gpPLGqHLxYCXJEM5hlska4diciRnpt1kAxlrMCDtzLOxWedHQHLScwpgIlsJcEWIIsbPVFHjSvYDI3G5oeLasfYAMJVkShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909738; c=relaxed/simple;
	bh=5/vDOvKX143o4bkcwZRwhWUVIvQHSk8KanTdcOtGZMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1wB3dCbEiU1zn3oaiF2RxYofXuYcK9OZj9r5dzL8rGLO0dGQ7n446VAvSRhpYj+ZAin7AHAOonAzixW9NOTVAz/oSiFk3abGXwcmAaEepfYR1gYV83TfLgB82r+wifNYB3Sjxz7+oLvtqCnV/0UYR3mWkv+Eu3MGwjEsL7qIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZqLUkBN; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZqLUkBN"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3538952a464so679591a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777909736; x=1778514536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+RcRbZcHkicOvIJqBSzYeaydyzLHDK7m5ufUcNjhB4c=;
        b=kZqLUkBNAjbjF0yArAQyRUBRwd+s8oMLU+3FwO8fnq3douyrlngVRSplnJ/E4wk+jV
         a3EV4QXgYATQGG4laLdltJYBHzVi7yXjbaXaFuei4DwzcpSwa8uQBOnUDsxq4eL7TBY/
         TWfCnTsliehG0jKaEmJXLG3r256stpk13rQw9R2XtoMIyTR91nS1z4WM2Um0rXdAEmMB
         sNkc03K+oRTXeJieKJqrdYTF+P64RTqFnL4Q5Ff9yLS3+oLnWBemllVlZwCkikPg687n
         iw5YqkmGWIvMMkUTNYLxBri1+m3DaXTYCrfhZ0KEriq6lv7AU+U9dPs+3DXo81Af/vNO
         3IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777909736; x=1778514536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RcRbZcHkicOvIJqBSzYeaydyzLHDK7m5ufUcNjhB4c=;
        b=RvywwySzjPR8jY15ry/38Ci45FJQcSA57Dwmdr/CZJNYwSyuYM66+fkdlkCBm4RVjv
         gDsJAp7VI7rYy81SZOCLSDyDKGM5WScx4FZSt/j6P5NQJD7mYpVPUYSKkyNKMLR8MBFz
         dXkiO9RrNKXNAg8m7extyq322pKIoZW+a54YxSzrL4YHeaUt+cYeTfN89AfOTk+eehiQ
         ROB5okd6uTbIR0/cZyd/MQeqc6/K9Z7RkUyXvEYrMlNdXynx58jmrU/1UkZOmB7F5/xO
         ToOuWTvquwp5lMHRd0DpgGIjT1vbFBnC/8072W8nzbq+8yrb2CA15SugnLWWqwUnjNy4
         /kzw==
X-Gm-Message-State: AOJu0Yxy0o1Jr2uoF9rureE0hkUqvWdqdtLspnGtzGJVEGrUVSEHEUam
	8w+qiaq1z/1cFjuRwB1lyvSgP+fLbs0FtEFRZcZ0ZoJ1UlCgxKa+qVZv
X-Gm-Gg: AeBDiesyufThfPjEHoC1toDr/bYaRsOG2QrjJ/fCKDRpze/okxbBIT12qryuyl63UBG
	EoWyNtKq8/vJyjuDs3Bb6qbIUWOkwbOob+gOHzEakYWdHxXTcYJ81douru3DsGOawqVMJ51tQSX
	42fbwy5vI3/BMQLxmaW+WEXewepN8EGr9Ibwek+9v8/ETTpBRUMDGsNGh5/rcoJ+bWzdxdBbn8n
	p3cpn/XSJBqii2iLwtg88k+X0o0x3CHuCfYeid/AS+kAeR4GroG1wkruobPrs5ZqMvPH5f1K59y
	6ygC2wG84QCTAfzvcS+zfnoNlfFunxU2NU9Wljypgav1eaYKVg+XwBDQVi1XBvxibU8mr7AF8Pl
	PDVKaJDPabkqWJyaVTDtpKFhI9Tp1eIKpchbJvYd5fGhemtisTFSa4f7YYbwgZr48CQ5QVGH8Jj
	ZXSBNLewg8INCImxcxdWWFS0VvFQs=
X-Received: by 2002:a17:902:f54c:b0:2b4:60cf:c94a with SMTP id d9443c01a7336-2b9f25e88c6mr53320755ad.4.1777909736274;
        Mon, 04 May 2026 08:48:56 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba38c02578sm26383395ad.79.2026.05.04.08.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:48:55 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: fix out-of-bounds write in ntfs_rl_collapse_range() merge path
Date: Tue,  5 May 2026 00:48:51 +0900
Message-ID: <20260504154851.3034915-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_rl_collapse_range() merges the run on the left of the collapsed
region with the run on its right when both are holes. The contiguous
check correctly clamps the index to 1 when @new_1st_cnt is 0:

	i = new_1st_cnt == 0 ? 1 : new_1st_cnt;
	if (ntfs_rle_lcn_contiguous(&new_rl[i - 1], &new_rl[i])) {

but the merge itself uses the unclamped value:

		s_rl = &new_rl[new_1st_cnt - 1];
		s_rl->length += s_rl[1].length;

When @new_1st_cnt is 0 this computes &new_rl[-1] and writes 8 bytes
before the kvcalloc'd runlist buffer. The path is reachable through
fallocate(FALLOC_FL_COLLAPSE_RANGE) starting at vcn 0 against an
attribute whose first run after the collapsed region is a hole. In that
case ntfs_rle_lcn_contiguous() returns true because both sides are
LCN_HOLE, so the merge path is entered with @new_1st_cnt still 0.

Use the same clamped index for the merge as for the contiguous check so
the write always lands inside the buffer.

The out-of-bounds write can corrupt an adjacent slab object. On a
non-KASAN kernel, it is reachable after a crafted NTFS volume has been
mounted read-write with the legacy fs/ntfs driver, by a local user that
has write access to the crafted file.

Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
Trigger conditions / reproducer notes:

  - subsystem: fs/ntfs (legacy NTFS runlist collapse path)
  - introduced by: 11ccc9107dc4 ("ntfs: update runlist handling and
    cluster allocator"), first released in v7.1-rc1
  - affected kernels: v7.1-rc1 through current mainline; also present
    in any branch that includes 11ccc9107dc4. Pre-v7.1-rc1 kernels do
    not contain this collapse-range code path.
  - local: yes
  - remote: no direct remote trigger
  - authentication required: no
  - special privileges required: yes to mount the crafted NTFS volume
    read-write in the normal case. After a privileged read-write mount,
    no additional privilege is needed for the fallocate trigger if the
    caller has write permission on the crafted file.
  - filesystem requirement: the legacy fs/ntfs driver must be mounted
    read-write against a crafted NTFS volume.
  - repeatable: yes, the crafted runlist geometry and collapse range make
    the sequence deterministic.

Reproducer summary used during verification:

  1. Prepare an NTFS volume containing a file whose runlist makes
     @new_1st_cnt equal to 0 and places a hole as the first run after
     the collapsed region.
  2. Mount the volume read-write with the legacy fs/ntfs driver.
  3. Call fallocate(FALLOC_FL_COLLAPSE_RANGE) on the crafted file,
     starting at file offset 0.
  4. Repeat with different crafted runlist sizes to place the temporary
     runlist allocation in different kmalloc caches.

Observed result without this fix:

  - KASAN reports a slab out-of-bounds write in
    ntfs_rl_collapse_range().
  - The write updates the runlist element immediately before the
    kvcalloc'd temporary runlist buffer.
  - On a non-KASAN kernel, the same trigger corrupts adjacent kmalloc
    objects.
  - The crafted runlist geometry can steer the temporary runlist
    allocation into different kmalloc caches.
  - Impact: local kernel heap corruption, reachable only after a
    privileged read-write mount of a crafted NTFS volume. Practical
    impact in the field is bounded by that mount requirement.

Verification with the fix applied:

  - "make M=fs/ntfs modules" succeeds.
  - The KASAN QEMU reproducer no longer reports an out-of-bounds write.
  - The non-KASAN QEMU observer object is no longer corrupted.

 fs/ntfs/runlist.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index da21dbeaaf66..e09bc86a7276 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -2058,8 +2058,12 @@ struct runlist_element *ntfs_rl_collapse_range(struct runlist_element *dst_rl, i
 	merge_cnt = 0;
 	i = new_1st_cnt == 0 ? 1 : new_1st_cnt;
 	if (ntfs_rle_lcn_contiguous(&new_rl[i - 1], &new_rl[i])) {
-		/* Merge right and left */
-		s_rl =  &new_rl[new_1st_cnt - 1];
+		/* Merge right and left.
+		 *
+		 * Use the clamped @i; new_1st_cnt - 1 would index
+		 * new_rl[-1] when @new_1st_cnt == 0.
+		 */
+		s_rl = &new_rl[i - 1];
 		s_rl->length += s_rl[1].length;
 		merge_cnt = 1;
 	}
-- 
2.43.0
