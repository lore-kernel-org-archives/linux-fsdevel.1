Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540445D5FE
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790756396; cv=none; b=eV6Fs2hKQ5WNg+88s2XSWMlA5qoNS8dF5Zb4N5V0Kyfc+Zf/+rqt99XTwjk5eVq0whBIBf6GDCWz/mHqO2VPsbdS9nB300WIlnBCgaycmv5oQorukyoWBjWcVTLOOF6Mt9/12te2gMR3Q20Gt1fNUkdae0CaPOMU3+GiYrXoyC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790756396; c=relaxed/simple;
	bh=pyQwwBfVun0BCNowwYL9j6bPPuuzNBChzVpGGKxs7L4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o5e6wlKdQ4PxG+B3k7IbF83VgOBSsrrMtqG4naxxJFnwaTt4xHX3vP2gRp6B38dpu/wK/lGSFJFvFq1jlQPAcYbxO2MwXNVHhGmCvLkVN7/6HNQYKEZC+3sSqX4EC1ou2dLxKt0uIv29aDqz4zvKai3GV26Vyuyt77/HVsugt+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7Yoia/h; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7Yoia/h"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86212a185dcso3502190b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790756390; x=1791361190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bR7uVOXUr6QRqbg1xRwBDWrPVdNqeU/9itJyUh6Zs9Q=;
        b=s7Yoia/hUOvUHbESitGo8zSs8cnVeil4NVgkW8RoR80SMfOnw6r+t+Zc3OmZHEhmj9
         CvOPqNIHwfhAFSUcxOK1Ng0aLmN6/tqIrmOPz0d8q9oo+VBi7MCeqE82KxGuXinZsdia
         yx+lOHE6cH58iEzWsjb9ME37kTH8o/y+sfcohWXvH6a9C8W875VyLdJ8EswtCYx81KaW
         VZCtbd52vsc675jtK575NQK1n0p5kSEC3wdvKWlFP/NLSgipSv55IVaMPeQ/DzcPLDB6
         WuETDwETwqq7Mva5GPrnBM/DfsFJ6ftDIAkogB8sl9FjOLYxCauK0tXnkJQGpYOSRh3Z
         +6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790756390; x=1791361190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bR7uVOXUr6QRqbg1xRwBDWrPVdNqeU/9itJyUh6Zs9Q=;
        b=LS4vHCEe+8FH7PYYBgjCzIsK7UB04WnD3TeBMDfYlLn/K1oj84EW5dGA1SXyVHkBTr
         ZJ+zGrsCfY9UFtj/ToV1ag9sq/ibE9k782eCasRZ0wjv95pY/3wKUAdXQvvWFOwcvRsw
         +XSkTFx3Q8PZ5AlLghWXA3q4Dhtu0CgnMewE8sv9R0IasORtb8sm7uAXzJHIfv6DaxCv
         OF4UccKrnscJj3TpP03/GpRlr1WZAWnGPOI66MOCxkp9gPvaFCE2xHaZBIkw921eAyEA
         thkiC8eo84aVig9O1jvpq7MNi0YUMG6N+W6DFCuv1p0wOsdsCOGW7hzD1cGaNLGuNfxO
         6Xew==
X-Gm-Message-State: AFuF++kUPR8mMNSIwR8+qwEavveLt8FEpN9mzKpEiRbdz7GE77efAMgj
	6fs7EoQjZoRTjH+0vXdPU4B6bInUru1ubBgiGO7ktmaoiIBWgPkJzBa1
X-Gm-Gg: AYBFou1v47lrfNlyFH2MOanGWEsr1uKrSic0mhaEQRqkVxmt4cFmsd6P9QXTR8nVjil
	0TdindeM1ho88NBObR2b3//T+oQhjHEZv4vf3gCsiTYGIGwNrm11+XyLJ/yXiaR/P0KwZfhQKtE
	k1lqdBs/1VLQAlktk9S8sO8YCA8yqPvDM3h6uKfRa7oGeFaZlOP9ZfeOeh/qqEti+Qf4AtwwCbJ
	hqXQLx+D6XI5XB7up7fUCeWIcA7ZwWEbLErfFptMgDydceAyEycrMmwyKG5W9bqesXjG+McBnZc
	2n4g5GpVTx53khS/lLlprGhF/oNRbGuGHVvSZcpUAEWpsfMqmiJx9Acaf3ktCrP+INYtA2kpA60
	W16r2KHRd6lqfGxQ6+lLIlimaiWK12nqbvwPSeZrFgRCu5dF+UyLDK2VOvDX3Whki8qtYh3n4f/
	DpmgyhyunPcZd15XHi2TNn1G1mryFBr8dwGZ5Ci8U7lQDPBNwevXStxTkDyTBSUwpNFkwQoBlzA
	h/RhFCid4+N/dtWGDaNhDFSG2KaOdkRx1HysJ9Y6pJmiSnB9lOMKT8cwycnr+3eR2NQ8Lifmdjd
	HTigdHaAbw==
X-Received: by 2002:a05:6a20:2591:b0:3dd:dcc1:f830 with SMTP id adf61e73a8af0-3de9e8f8427mr742877637.61.1790756389926;
        Wed, 30 Sep 2026 01:19:49 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7da126a49sm453319a12.7.2026.09.30.01.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:19:49 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>,
	Matthias Goergens <matthias.goergens@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v5 0/6] fs/qnx6: fix buffer head leaks, double free, and inode validation
Date: Wed, 30 Sep 2026 08:19:41 +0000
Message-ID: <20260930081947.511613-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses buffer head memory leaks, uninitialized pointer reads,
out-of-bounds array access, and superblock validation issues in the qnx6
filesystem driver.

All patches have been ported to the latest tip of mainline (551c722f4080)
and verified in QEMU KVM with CONFIG_KASAN=y and UBSAN enabled.

Changes in v5:
- 1/6: Restored commit description to accurately specify UBSAN
  shift-out-of-bounds reports at both shifts in qnx6_block_map() as
  requested by Matthias Goergens.
- 3/6: Used qs->sb_buf instead of sbi->sb_buf at label out: in
  qnx6_fill_super() to prevent reading uninitialized sbi when mounting
  mmi_fs images, fixing a general protection fault reported by Matthias.
- 4/6: Updated commit description to state that clearing sb_buf after
  brelse() is defensive cleanup.
- Collected Tested-by and Reviewed-by tags from Matthias Goergens.

Hui Peng (6):
  qnx6: validate di_filelevels in qnx6_iget() before accessing level
    pointers
  qnx6: release bh on error path in qnx6_block_map()
  qnx6: release bh on error path in qnx6_fill_super()
  qnx6: clear sb_buf after brelse in qnx6_mmi_fill_super()
  qnx6: abort mount on superblock magic mismatch when silent is set in
    qnx6_mmi_fill_super()
  qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()

 fs/qnx6/inode.c     | 18 +++++++++++++++---
 fs/qnx6/super_mmi.c |  7 ++++++-
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.47.3
