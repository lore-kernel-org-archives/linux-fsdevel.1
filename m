Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3902989B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368425; cv=none; b=FnyTcn7Ek1xfRdIKVFv7cJkuHrv4DIbD0PUBABM/Ql5XxVyv64gL9hZY4J/fc0ruuyMdjlKCVkg4BnLacS8jlAlBKgTmJ3NGEzoBkOM/21lVRoFbPY2W+dwti1z+b7IN/Wa0Q+f/9Jpqf0pm7oXCeZdiYSC01RnGgQWj6j0MNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368425; c=relaxed/simple;
	bh=LhD75nHZEknel0Wtc1hUU+oGbQEDH64D5mahZjdeVZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3v8iBKC6NoURSMcx6XD0q6XnLRgyV4E0K8o/VQllqGM2D2BUIxdeG0D1Onbjgm3yd/XNBMBxvH3Jwy+hAhv5SH/VkwKRwbDNGwXvG3QqDg2zThUlT60Hf8uhqE6RgGRxJ42FtFWWBVcicujAskD0L1/3XMkJYEjLVXNTEoqB4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oxozSqQn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxozSqQn"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-83f8f377876so407552b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368423; x=1779973223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jysZaOsjDwX5f/p00tbuFB9BJf63zxKVw0gwxzAqdmk=;
        b=oxozSqQn/xaOisMzPFUVLhV+6saSCo7xO1ZHCcvDAgWT09NU1//aMPuFGAe3bKpXSR
         ikpRz2NGqTITeZeyTn/Z1bnc0q9erFeeo6XpEYV3XTdlMdUY5ZYNNcZ99NMGQKYMiDdP
         hWEdlHbkTMz7MWZumZDYXIYamgqUGE42TUc7lDhq1OLu8CtfI3E7R5kDkIMf6DhDKKqD
         OyysgoKoJA79yYBGswgmdRM2Yntx9uSZO50B9bl7/FwmIfyjmeTHp3wsmQGsusOfF3e2
         i4d4GzI735RQMIF/kCD/XEa8HCZL3LwXzDIs8T1kRiJiSWl8781QHOI+DfHiuK3nTOQD
         4vKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368423; x=1779973223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jysZaOsjDwX5f/p00tbuFB9BJf63zxKVw0gwxzAqdmk=;
        b=EsUyqmJldzCtvLJNFrQXNcX882kk6SdY82f9ckaiqODvznG8LFJjpKAnO3423rXXaR
         811Ad4VkI7fA42mry+FtiRLAIMybQEXupC/qQdTVOnwDMx4f8T/Qvuwt/B7wx4eXEkkM
         76pFSmEppLfpjZEs17s/8u0sw9CAeDgTdjpJKju9a/UL/rYTmhwY/L9oUaX2oG9bCpt7
         MDZ9d9GENFCqqnnJ/TIeDKWPk6M+CVTZ6SK/PswxH5uZJhe5y31aI4FL7fVkrSTrkan1
         n6RbTq45TwRlZiZvf5oBDBs2CH0lWToaCvuYcMVTs7Xx3wMng+EmSsMrQgM/x+1eUkCH
         /L2w==
X-Gm-Message-State: AOJu0Yz/GgsJJ2BranCCZHb9Ho7jKdJ/onA1+GYgX9CB8KjHKAxTLaE+
	T6GJGt+VtATNxUpAABcV9q1Be0pu0rOMuaTiu7lUY2zwnmikW4WwE4ew
X-Gm-Gg: Acq92OF0wypTFOJd4QUolV4BCgwHGl92WBHgJcLZaKC24uouSlD+VArDlBGnOrfn2Q4
	PR93O93fPxNMgwUkcNcawicmV5TQNsD1YsyBoxcbQKyL4e61M7c8pgds56WefEnP6OHJaeE7HIZ
	9IJIyZLH2TKHzpmxOPoyL9V3vIZvbzlByIcTxA+f+9UFCtR0sFoBP0HAsGWyTLeDluifxPNurRv
	/Fpmux6xacPlvY9+YACQrfIDwAA9RIKNrZ46Mb82keOu5YXv6pbk8qXN7N1s+QQxNAOSWkJYPiH
	1Vj+wqFWDGvyhOtm9saNyu3ZpKesqYfnF4dsXPW9mPGvlBtYDB05r3dpZ4ar4SfFHcMEUfAg3gI
	O1thmO/ElpVOougJKQjl9zcMkHYGkMXW+wrjn5QObALmBfY7YR7AAq5Zdv95NYiDrFB9Q+u2TFF
	o497++mBDshbIDblky+A+qZNpupRM=
X-Received: by 2002:a05:6a20:2448:b0:39e:df5e:edc2 with SMTP id adf61e73a8af0-3b308702bc7mr1814981637.2.1779368422903;
        Thu, 21 May 2026 06:00:22 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c851993d8a7sm284340a12.27.2026.05.21.06.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:00:22 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v3 0/3] ntfs: fix mount failure cleanup and free-count setup
Date: Thu, 21 May 2026 22:00:14 +0900
Message-ID: <20260521130017.713848-1-charsyam@gmail.com>
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

This v3 is based on current mainline at 8bc67e4db64a.  The patches
modify fs/ntfs/super.c in the Linux kernel tree.

The fixes cover mount failure cleanup, a free-cluster precalc allocation
failure path that can otherwise leave waiters blocked forever, and the
$UpCase default-table alias check.  Per review, the free-cluster patch
now avoids the temporary file_ra_state heap allocation entirely by using
a stack variable for the synchronous bitmap scan.

Testing:
- Built fs/ntfs/super.o and fs/ntfs/ntfs.ko with gcc 13.3.0.
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

Changes since v2:
- Changed patch 2's on-stack file_ra_state initializer from the empty
  initializer to { 0 } to avoid build failures with stricter compilers.
- Re-tested patch 2 alone and patches 1-2 on a clean mainline tree.

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
