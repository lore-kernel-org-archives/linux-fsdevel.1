Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC6F3F1AB9
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296518; cv=none; b=QBRP65KrmneYwra7Q/k9C3K2pZueQOAcI6VQJ1HWm08EUX79IqhkeStMYYAAPY8+zVOcghNw2nsieLE1iLKRkBBK7VjkbgFmIARzJOJzFw9cVS5MkFmlLyXWbq907W413t2z1Rc1huuyFBKixsbB9+SAaiUORpR+KpsspcXIOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296518; c=relaxed/simple;
	bh=0uWX7BrhR8lyTmN8swbIV475LYsBo3E8Z7VRB2i+bvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nBk06SW/SJduO7hlU9xTGN/k9qfHoxBOI5san4sfWzJ/fKpALxcRWBeOZTkjA3xisrj8maSIKjaiAfAatBK39d+swyYdt3rX7jhXX8tSZRndK0sIqow9z6lNiwEiSUZ6isv4p9D9ED+5tK5ruy08gF+sR6xBeuaLcp4jwPBH174=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rECNGLYR; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rECNGLYR"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-83aea7d1fffso198009b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779296517; x=1779901317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9S0q1fXPQGKCNPYBpd55OELJCxoFX0UBX1J/3iB/9UI=;
        b=rECNGLYR+fsxargJ2lSG++amjIcbpDYRugNTUWhaSFjMJCHnlItyaoTIn5BHmXTh6F
         l0i/33Hbe/NSwl3fRORu8vu1GIi6f96waCGqt7ei1Ic/BflmqxR2LR5eTKg+f+1b/aKY
         /2C/t4pBGuoC7KzPK5FBvdoeaPhaHGUWvUGlI9j/tjG5jXSVvkvNK1e3r57Wgle2oX3n
         THq48gxNbUykX3U+9fRMy4WG//R6+mjwdfyA7Z9o63qR5BcVmDJMysO0O+f+diC0WTKJ
         FtYaYn9xYDAj6xFzQ2jU6jev27kOy8NkET9HSuiU4YfD/p/DkzZTjGzvpirAR7zcrK4O
         KJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296517; x=1779901317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S0q1fXPQGKCNPYBpd55OELJCxoFX0UBX1J/3iB/9UI=;
        b=mx3TRS8qSA+iGoHYuci/2TRsIXHht56UdO+SOBkPi1lUxfwZpS3SSwSCxYX+h+t4Wy
         4jDA2K0STM7elaOPvvbqIX2qFQ3q6BokYfk/6xV0u4pnl0195X0toihuSeCqKE2Vw/sy
         rn8vmpO7kNK5IrFUFOEAjNW2zhGm+F8oAMnlvRA2SvtyrKw9hGCdr6wPhSL0tl+eC653
         /fFLJp5W1q2KyVtXIxAYAI91/TGGVWG9KL6DKfO8x2MzW3KfFyBpFCbZ2PBoCN+iJovO
         W1HaIotBjxB94AYEUuk+S62UMlACX8DfADiduIowccEfLmuiilinFh4Vu5dUb0GEaB5d
         kIbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Secx5KLmRUJIO0w0JSSXxdhqIMkwi6K1lbHX8/ehwdm+Dt7vgDIAcytD4vGwy3nTxrMPlQtQ6o8wccRcB@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFMnXHP107XClJwu23ywTJVY0+C3dLlfx/doXHjTaP0w9huYv
	Zznxjv0UYFOoDblPH/Mx+pRGN63spz03eJiBfuz6BZ1gL66Gzp9nb7ax
X-Gm-Gg: Acq92OF8UbWIzwUHCop7gODEh+TQGSpc+AFNxm+c2B8BWUE1Q8AbcMexxB5F1LEqMSb
	3fyfUA2KPElrcRWCLCgfDUQpbdfP9Dz9CKOL4XTFUTr1Z5ajAn9l5gfvFCyt42HUg0nau9QGs9N
	nLkY9jxfmASzZ0g+VVeVVs7p6DMoLj9O9O2sXu0miV/zedtOKFTU8oJRwECrUZ79X9APgXU4Lwq
	hdSyb9ZppbjxCZWHLTx1NNNMa/p1xTW4OXHWOhJJnmXgLS9dgFALNAG7+qhlBcaYLLh8020xIUH
	qpgoKp5pwD2hBfGNGHCy3WVbgW6TJAjXpduPoOCoZd8HFf0kDPJ4e6FgUGTxcmjNhK+cQJrrOpU
	4iKyj77AWwUWR2bPtfWPjniCEh7J7pDz6nnQDYDbjw91tbrI9x1kxqHvMypYKQeliAFdM5SwU5j
	deHWTTKYjIHb0TCXR1tDDRV1BTnyQ=
X-Received: by 2002:a05:6a00:e16:b0:82f:1da:9781 with SMTP id d2e1a72fcca58-83f339b4397mr13360803b3a.0.1779296516256;
        Wed, 20 May 2026 10:01:56 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1942a83fsm22125954b3a.0.2026.05.20.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:01:55 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 0/3] ntfs: fix mount failure cleanup and free-count setup
Date: Thu, 21 May 2026 02:01:48 +0900
Message-ID: <20260520170151.4115308-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namjae,

This small series is based on current ntfs-next commit d8756162c6ca
("ntfs: remove unsupported quota handling").

The previous quota_ino reference leak fix is intentionally dropped
because that commit removes load_and_init_quota(), the $Quota/$Q state,
and the quota out-of-date marker path.

The remaining fixes cover mount failure cleanup, a free-cluster precalc
OOM path that can otherwise leave waiters blocked forever, and the
$UpCase default-table alias check.  The free-cluster patch also clears
the per-bitmap-page free counters on the conservative zero-free-count
path so later allocation heuristics stay conservative after the known
flag is published.

Testing:
- For patch 1, I built a DEBUG_KMEMLEAK/DEBUG_FS kernel and injected an
  ntfs_fill_super() failure immediately after load_system_files().  Before
  the fix, kmemleak reported the leaked volume label allocated from
  ntfs_ucstonls(); after the fix, the same failure path produced no
  kmemleak report.
- For patch 2, I used QEMU with a debug injection that forces the initial
  precalc readahead-state allocation to fail.  Before the fix, statfs
  remained blocked in D state in ntfs_statfs(); after the fix, the waiter
  woke up and statfs returned with the conservative zero free-cluster
  count.

DaeMyung Kang (3):
  ntfs: free volume-wide resources on fill_super failure
  ntfs: wake free-cluster waiters when precalc allocation fails
  ntfs: only alias volume $UpCase to default on exact match

 super.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)


base-commit: d8756162c6cab1ad4478539d33da6cab413af1ee
-- 
2.43.0
