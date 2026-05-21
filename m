Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF5D37E310
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358677; cv=none; b=lo8A6aprr+8p0jFlbJPHHyO1XyVqB3ULLa6jdVItVM7cnfPpToEHFqAQnVTYU4r07HDrw311/RpaKXsWda0iUfz58XeX5mfpdJmltkUM9gc3QQLeOGyoRhyViYHi+rb7Ux6Cis/9sTt5C6PS5aupFOCVH6aXALYRlDbANSsrzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358677; c=relaxed/simple;
	bh=Q9VydSV+XdrtmFQ92ahtHUfrgLbJCnGhDjV29GYwgO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcARLvOnip7D4UQwn+sDe1YULKz4DKqqxcPZAdBg/AEKRDhTEXT/m/uzBNs3bN4JDv60HK5oMLUmWQDOnqS9IxjYvlRr80gVxTLm/a9N4fUPaC0KaoRSoTqKHnlMQ/Kb0BSr/pIwjM/mWJTVO4uafIAqNsARAUSdNIdpinopNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQZ8wrAD; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQZ8wrAD"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c830268c37cso264336a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 03:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779358676; x=1779963476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUq/VZ0EvZ3mOtr2Ff9TemlHUvqeWnmfG6EoGwdn/9g=;
        b=WQZ8wrADBYH2PKit9RWSUfy9GTKz0VL5ICElcSuilR+90h4nwdZSiII+m3d2v1qsk+
         KmmLNz7j1Zl747VTGaqPNTr9s8qB47ihhmkymjG7blf+PfS8bPO4mqG6r7bLpeJaPIf1
         64ugZFBqpzMEuUpkWjIrx1hc5500LQRqTSi2jQsTGltvd02BLBAep+XDrvBMly3koxci
         gDzFQyMDox4kg8AyOSPwBivSFOYOfoDsosU3lVXyJpLFfkV10cEnTt4vfOASmUhRRrHk
         jo0DLZjywBtq02qFvd9pB9UyOxyKmetuwoDjgoBNMFJKx911TqNa3ImGrD6J9jstHWJR
         KFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358676; x=1779963476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VUq/VZ0EvZ3mOtr2Ff9TemlHUvqeWnmfG6EoGwdn/9g=;
        b=kiDtCdkUpb5oTVY7Tv0Sgj/FFEuMo2uclcfRuSeuBuV/5jKRJgzc/Fg2Y69wdsJqrN
         lM2qSYtvCBO7ASReiPnaG8FMmRZSqIU5IXlZTX94XwDMgIZIUYOZg42xaoesEW5h/MzX
         HW3V3BFgrwu7472VcL9u4FJK4JwTs8tF6m0Uy+vHyPcXzu+9J1qU5ZfQjee8ExLS9h94
         855k6qObpxqHc6dkjHv9Ln+YRkw4sdLJ9HHJWn2rByo1qbk19nGyNhgvpGfjmH/RYr10
         H0jwHIOB+WrBGxDMeNEeUP0/OngMyiKPF//R73m/X9XXJ//XWnRKSbSUIRL7sb71jOaN
         /FYQ==
X-Gm-Message-State: AOJu0YzGqn8vUxRDQNVDY5yWF+8b17D4jRTC7Ywfs2no571qh3z5gn5y
	Ht4Y0+GaVyElLJlzOOzO1vERFhkCHM8UvWNcGYmlDuul3NwpMbvUPZ8/HlzSRA==
X-Gm-Gg: Acq92OFSLfgBG7vpyGVa28qTspNdC/51aLHR99Vzvlk6K5OJQ/VlQOaumEmCBYfd9tT
	DuCqiTfjtZORyOr4QgQx31rK8P9KApuQev6wtFxCScbLAhjNTDid+sUw5x9PTuQQg0954cS8Nlr
	4o0nkbjTCHeOABhMFHIRY2ND8Fx+xpg0qDjELpWQO8ixwpB6xJtJjFZIhgw8MgCqb1BjctcXbR/
	FGEen2lxFwWWjw/4Al6ZO5oOy+At8nTf7H6XOqL9DOAAXieSEuxh5pEJ4XK5AQ426M153FPeUEL
	cvnYg3+Dij//5b1ted59gM+nEFDFKu3mtCbOjgEZJzPCboXSx/Lp04JrwU8cShTEncZmP/sKhp8
	IwSl8JRTNnu+NJs7NxEUnCyjlqIF3K2hvC75RniaZBMDQJd967o1hqGEyGHTbmwpmCjKux3KJ/3
	6iV/VNUBkDR0bw+xKBVDyY31UqhrI=
X-Received: by 2002:a05:6a00:3986:b0:82f:99c5:868d with SMTP id d2e1a72fcca58-8414af17c74mr1214787b3a.4.1779358675797;
        Thu, 21 May 2026 03:17:55 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e1fc86sm1197799b3a.44.2026.05.21.03.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:17:55 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2 0/3] ntfs: fix mount failure cleanup and free-count setup
Date: Thu, 21 May 2026 19:17:48 +0900
Message-ID: <20260521101751.591345-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520170151.4115308-1-charsyam@gmail.com>
References: <20260520170151.4115308-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namjae,

This v2 is ported to the Linux kernel tree and is based on current
mainline commit 8bc67e4db64a ("Merge tag 'erofs-for-7.1-rc5-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs").  The
patches now modify fs/ntfs/super.c rather than the out-of-tree Github
layout.

The fixes cover mount failure cleanup, a free-cluster precalc allocation
failure path that can otherwise leave waiters blocked forever, and the
$UpCase default-table alias check.  Per review, the free-cluster patch
now avoids the temporary file_ra_state heap allocation entirely by using
a stack variable for the synchronous bitmap scan.

Testing:
- For patch 1, I built a DEBUG_KMEMLEAK/DEBUG_FS kernel and injected an
  ntfs_fill_super() failure immediately after load_system_files().  Before
  the fix, kmemleak reported the leaked volume label allocated from
  ntfs_ucstonls(); after the fix, the same failure path produced no
  kmemleak report.
- For patch 2, I used QEMU with a debug injection that forces the initial
  precalc readahead-state allocation to fail.  Before the fix, statfs
  remained blocked in D state in ntfs_statfs().  This version removes
  that heap allocation and therefore removes the injected failure point.
  I also mounted a fresh NTFS image with the stack-backed state and
  verified statfs reported the same free count as ntfsinfo -m.

Changes since v1:
- Rebased and regenerated the series for the Linux kernel tree
  (fs/ntfs/super.c), instead of the Github out-of-tree layout.
- Changed patch 2 to declare the temporary file_ra_state on the stack,
  as suggested by Hyunchul Lee, instead of adding an OOM fallback path.
- Zero-initialized patch 2's on-stack file_ra_state because
  file_ra_state_init() only initializes ra_pages and prev_pos.
- Reworded patch 3 to avoid overstating user-visible name comparison
  effects, and used memcmp() for the exact $UpCase table comparison.

DaeMyung Kang (3):
  ntfs: free volume-wide resources on fill_super failure
  ntfs: avoid heap allocation for free-cluster readahead state
  ntfs: only alias volume $UpCase to default on exact match

 fs/ntfs/super.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)


base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
-- 
2.43.0
