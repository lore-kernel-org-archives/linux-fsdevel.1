Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0D19A2A3
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711920; cv=none; b=Lv/ggEDyDF+wll1ppqekIZyLyN+Keg5iTrUiMcd7FUYaTYjG9OscXDlRIpgziNJY7n9HiPixlQ9Pqu3ay5t8ebIBqZITDupkQyDy23uiWCM+wKw/dixaHwUX8PZGuQme5rjlmrEhA2qBA2XjuuDHGcrPNvqY8PcseVf3Dla+c9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711920; c=relaxed/simple;
	bh=0F7j9rUuiWlBNk8YVlJPt64MaBp5s5MausN3CBgy3rM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVUx2yOzeP0teBEiBfhZBlQeY+Y2pYOVL3whS1E6RFQvlTM4D/3QmQxGv+lC7aWPb6D/swQjpzyOtcji8ZzagMOqelIJAQfRIsxHA+QYOyt8M9QpnvhCRuwu6xxruVWhvwR74bVarjqTBSkORtD+PmbgqZ8eIsLvgLhbm3lJQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5PnOZGl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5PnOZGl"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b9f43a1feso1207324f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774711918; x=1775316718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u7mQPIC0ps2Jv1aGIJBEdjAFDdHo2SlLPn6PZfFqoiY=;
        b=b5PnOZGl7F4N4e2QALbzE6BGiFQqkaUhbCbpLtAkggoDUR9LiGC5O9/nB68r4bHgOt
         jWR7UHsQDMAOXanbgFuAsKBiTy2vU1KJwmpuLSukZ7C1nM4ZKUHp2GlOsZuio1N+dFL9
         bGYe2c3QKYFIu72dbsVHmBJgtoS0xLd7TV7TBxNi20FRPHibxZL1mTSByJ0/SHmt3Sr9
         8IylnffV23FMF32b1/+wXQz1JH85/8aTbczssmvPjcRsv+5otAdov3h0rFzw7D8/cwLn
         4Ua4npl5Rex9FX8mZiH7XoXtV6aIdI85y/stNkr9N/75DV1pamEScQsjCniOOthrxyJI
         wgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774711918; x=1775316718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7mQPIC0ps2Jv1aGIJBEdjAFDdHo2SlLPn6PZfFqoiY=;
        b=YPGyRJYDyKvrTeJ8hcrQHoxl5mD8kwrU2jx1ZlTuceCZkYcxq9AshNGiVVGXBaqJSc
         1nfta+tlUjkqXOGlqiSexT0MToLyJTXefTouxsy9z9eBlbbsje/y0twi8c7wQRRQnBwM
         KQtKDRwIlSiq1s0ptgW4wcyERKCoXJWcASqvvzrgx33E2ZbRmhvIf1Ws4Enn+BnQ8Bo7
         ZAYFXhMpUBE9uxk6oFofBwXm67GmGDM8RrNVp6nlcB3uj+Wfzm9/BvUsHNGwLe04PxDR
         WDj6owzTjJY83sw6KpT9yYhb8CfnXyCxB+goESA1JcVyfSQyp2vyc9yI+dlU7gO/bbGD
         LhAw==
X-Forwarded-Encrypted: i=1; AJvYcCWIcACnEwweTdSb0PSWyb2TrTqXQlRrMl/LwYYOZs8Ghft5sTRsqfhxhis23XRamckp3xQOSNzG+IrK9VsE@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4TCy4AFFmirHkEJ4/G+F3mSIVjnArNS7dnanx8O/nDbvzoJ4
	Ss34zBTwimVbuFpnQaxoct7+uU5BfLgnQZprpet+aKqY2VX4OEwhUw66x8qhpg==
X-Gm-Gg: ATEYQzya8mg45sk9VY/SsomPPXm2a4Q5i/LB4L/QatMPZB0QXk9pjJax6UMV1Aby1F7
	j7q9S0Qww/Ypuwh62imtkQAUdjZ9OtPZT7ABCwEoMkvbSeGdNQEiZ5Q8sVenrL5SFavQGGIE9Ho
	R0BL4QlIIDgBOc/J0lntMXI0Du/imJ0L6s2K6sE9/zksIgSVyQvy8/zcv8t7HlVrVlmRqEuMovK
	KC8Rcx4EJSSJFrlkxUTtQbmaDPr9L0ZQCN9Wod8BznVmdl9wzees2L8sIYSwHfbP5SHuS5Bf56U
	L+jY1r0ZfrKtq25gIIJi4sTc8H8HOBq3g8KGHv4vDpXPg9BdNLd4T6Dc9Ouf8dRG1ot4QZjtRLY
	PXxa9c7FDaBJMzh3LGpZKAWNFnuDMGacpLC69OQO5ZMb7zjQq8eEfIYftbcCp8oVVQ900uC4F+F
	kNEqyDVoa486aFJsVICmjd3iYXrci9ISIKIOdqg7JbZ1R2Bfz/wdxCv1/Ieraj90b92TOWn7zBt
	A==
X-Received: by 2002:a5d:584f:0:b0:43b:54c9:7d1b with SMTP id ffacd0b85a97d-43b9ea638c4mr11428917f8f.41.1774711917400;
        Sat, 28 Mar 2026 08:31:57 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f8a3sm6725310f8f.24.2026.03.28.08.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:31:56 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 0/5] assorted ->i_count-related changes
Date: Sat, 28 Mar 2026 16:31:40 +0100
Message-ID: <20260328153146.3368470-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The icount_read_once() stuff lines up with inode_state_read_once().
The prefix is different but I opted to not change it due to igrab(),
ihold() et al.

There is a future-proofing change in iput_final(). I am not going to
strongly insist on it, but at the very least the problem needs to be
noted in a comment.

Finally, igrab() gets lockless treatment. I verified btrfs likes to call
into it in writeback code with the count > 1, same with procfs during
process reaping. Grep shows nfs also calls there, but I have not checked
how often that happens. This is a minor single-threaded speed up at
least as a lock trip is avoided in the common case.

Mateusz Guzik (5):
  fs: add icount_read_once()
  Use icount_read() and icount_read_once() as appropriate.
  fs: enforce locking in icount_read(), add some commentary
  fs: handle hypothetical filesystems hich use I_DONTCACHE and drop the
    lock in ->drop_inode
  fs: locklessly bump refs in igrab as long as it does not transition
    0->1

 arch/powerpc/platforms/cell/spufs/file.c |  2 +-
 fs/btrfs/inode.c                         |  2 +-
 fs/ceph/mds_client.c                     |  2 +-
 fs/ext4/ialloc.c                         |  4 +--
 fs/hpfs/inode.c                          |  2 +-
 fs/inode.c                               | 42 ++++++++++++++++--------
 fs/nfs/inode.c                           |  4 +--
 fs/smb/client/inode.c                    |  2 +-
 fs/ubifs/super.c                         |  2 +-
 fs/xfs/xfs_inode.c                       |  2 +-
 fs/xfs/xfs_trace.h                       |  2 +-
 include/linux/fs.h                       | 13 ++++++++
 include/trace/events/filelock.h          |  2 +-
 security/landlock/fs.c                   |  2 +-
 14 files changed, 55 insertions(+), 28 deletions(-)

-- 
2.48.1

