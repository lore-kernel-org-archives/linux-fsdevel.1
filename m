Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923518;
	b=uJu/+2xxSjkSQ+WEbtPNRfWd7E/lS0l1DdWj9q9oksTeFS9flsQESGJZBthV+0ppof11
	 AkQDdTeAaMykPwKwO0zi7Y6uo6Va1QWSbvrbpycEdpuDv+s86n/l7QmXS/5PdqaoA24Ju
	 MxDmp1Ly156TjQObJfR5IFUpneAb4htq0wKmZ/0+zmgL/UHbmHEG8NmK80gjgzaO3PdTL
	 xSEAYOoMzCRb6J1HM8xpzYvth18TuEHqdSy99Ie8z/zvsWXuygqC7uoakUHbqB8k+3KfY
	 CQdGYAhEuXBzD00cr7XmZaXl+wpohF+puJeOXp/WLgY5zcB33U7IC3n9V9R4KFG4ZDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eboZ8wd57YYSCKF+wtcZCIsW/kuWa0Q77BxDUZ5VNSo=;
	b=ebwThOerFzPzPcM3mtGsywlztsiZIWA+jrUmLOyFpmvO72sSgoEOXkvnWdtLJIuHjJ4Z
	 Y0kew6sy3CeJfYr1ZAsCnTQHVsMhl6CBYoZPLP5RmQB/1R7YzByrwSAonuyCNa15CGrfJ
	 Dj4BZgaOyg2Kt5lCLktv0FVfjY9aKYaQFc8ARp+wseDXl+rtaYcV29Cj+DLWGdOA5W/Gj
	 OKy8/QqSzFa81pcJJrwwr5tMc2MA7Lc4n4kyDsGEitl4iczFrMt3vakAymG0zdhsbEyPg
	 b0KQFstwJj1f/EJhmSwLcAXHRBrSHyjrSmPQqbKbabrZ07jGav7gwS27fTjGV7uGd0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QXyGxRAb;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00060606A329
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 13:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00060606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QXyGxRAb
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2eff29ca765so272945ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 05:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794923517; x=1795528317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eboZ8wd57YYSCKF+wtcZCIsW/kuWa0Q77BxDUZ5VNSo=;
        b=QXyGxRAbPPpbsgRWmBLcuTwVo15oXwqkHupxVLTSdRtvZxcG5n9B6ynVkqfTK40jUK
         v4bif8x+jUXBQESQbOCyNfe7yVAC5daxCic7Pg+YdxKGPpSbH5kFxYARbszrdUvgh5GP
         sK1GWxaixWUiGJejZVNdQmr8rUSCzQUrkDFEOSYUMDi27NEtfE7J6n931VhIrG96AJyg
         8kaI7FUoTvB9tiODUXK4XiZ4+FwQozy3YnWb1CH43Yvtxffb+UEEGVe17v3nbs7QSto7
         MvXNzpcKDB3gVghHvMBw2tqGG+I/Ytne4gS2kO9TYhf5D4rEsEXHfdZ3EA637APPDRbv
         +G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794923517; x=1795528317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eboZ8wd57YYSCKF+wtcZCIsW/kuWa0Q77BxDUZ5VNSo=;
        b=E5tmRDrmgffkfYa8HkuSh+omt8D5mFVjtYxqogrn52XWCUIpUxyTZYdK+ckIFImWsR
         fPLcvxeGTokgYc/nK+Y4IZG02a5RIUZbeV7qM9KOnFoCOvF7NKXlfu2qjxEspVLhXLmU
         8XHsy7FNiYOroua5kSERvXDiZ7depE4sbpNTxjyu0dEniZpBsSDVuD8MyYsf6+X2SvVQ
         40T2HIVo83b5loIn/+mtbKRssrU8c2J7bN3u/qY7NELncXt7hTn5/I9xQAiBywLrrkIe
         /uBP5bptWbpM/jv7NrMiR3X319GhEPGDkwltnKSKLRHjyzU7z25On/A/yT2301+tzUHk
         UuhA==
X-Forwarded-Encrypted: i=1; AL+hErHKTzklYJogiYBHxIsiJ0bIiIjRitEUPK7NaTbUGDp91wT8KRhq0s/5HMPy5LNemgXDUQ+1eOviaf2pwrCi@vger.kernel.org
X-Gm-Message-State: APuU4Z9n2tekveQqp5nLiJNn7q5CTQIToa6sWpvtBYLLvjZvw7lUOEvl
	mm9Tm9I4jfkbFCa7lQzhySSBu+K969QIvfEYxdIC/RQ36s4w0YcDcoZv
X-Gm-Gg: AZFdTZfg0wZBhItwn3srSaDFkzapN4a8W3kUdTMQ6v32DkQUySdO1/6QMuNr4vh8Mg3
	yr81dVIwbdIezjWM+FB/zQOar1VFldLCz39La8bLAwVERSAj0roZbK0q7psPt09QyLaLGpyMR8n
	U/sFqs/NACWmPLvMVytgRswc9NG7W/b4dzGGnK9eCNwHHDIVs8l2iCwoD8lMwkaLhQXvHISKBgV
	QMaisEBesq9qTtGK5id/Zg9yGyPfBDK8XV33YAQXiJH5rkNexLoHYhunxaKvH9D2z7XoczaxTEO
	9VJ/6WZhNxGL0qF58ua+/OvEkRJA6Fa445tAAm06dREzQGBREzEW9mKg7ectlXD9RICzLLbeJ5z
	UHMNZaUcU8QipuSrBnt4tIWm9skLNmX66qIMKJUvfOfTqZdtmIUigbc8sXgMYvdupHGEV82qwn0
	GqdccG7ShwmNIGVhD9YEKX2XtZ/aGcJWu+ZjKfOIuX7eA2+L+NkrYIWqICqoWPSigEeS/VzoRFu
	TzAp78KUn97Nd3EemX8wp60OcnIKSORbUE9IH1+3Q2/jg30Wlo7F7O46eZ1LfjKzwij7DEjYRXc
	qwa+BkDT7zyxtJydAPN4BhfTNDvDs9JFKP+vY6HFO8du6c0eZA==
X-Received: by 2002:a17:902:fc84:b0:2ef:eaa8:9b59 with SMTP id d9443c01a7336-2efeaa89dc6mr10152485ad.48.1794923516856;
        Tue, 17 Nov 2026 05:51:56 -0800 (PST)
Received: from localhost.localdomain ([112.170.44.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a586c1sm15937035ad.43.2026.11.17.05.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:51:55 -0800 (PST)
From: Junyoung Jang <graypanda.inzag@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>
Cc: Junyoung Jang <graypanda.inzag@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Matt Bobrowski <matt@bobrowski.net>,
	Gwanhyun Lee <gwanhyunlee@gmail.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] fuse, fsnotify: handle embedded NUL names safely
Date: Tue, 17 Nov 2026 22:51:34 +0900
Message-ID: <20261117135146.3174252-1-graypanda.inzag@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FUSE READDIRPLUS can instantiate a dentry whose length-bearing name
contains an embedded NUL.  The fsnotify name-copy paths then stop at
that NUL while retaining the original qstr length, allowing event-name
buffers to expose uninitialized bytes.

Patch 1 skips dcache instantiation for these READDIRPLUS entries while
preserving getdents() behavior.  Patches 2 and 3 copy the full qstr name
into inotify and fanotify events.  Each patch applies independently to
the base commit.

Link: https://lore.kernel.org/linux-fsdevel/20261115210952.2140036-1-graypanda.inzag@gmail.com/

A custom LLM agent assisted with initial discovery and reproducer
setup; all root-cause analysis, patches, and runtime tests were
manually reviewed and verified by the authors.

---
Changes in v2:
- Follow Amir Goldstein's review: preserve FUSE readdir output and skip
  dcache instantiation only for invalid READDIRPLUS names.
- Replace the event-name strscpy_pad() calls with length-based memcpy()
  and explicit terminators in inotify and fanotify.

Tests on 23c62304dde2 in QEMU:
- Patch 1 alone: READDIR and READDIRPLUS getdents64() returned normally;
  the embedded-NUL entry was not instantiated, and FUSE_FORGET returned
  its unused lookup reference.
- Patch 2 alone: the FUSE READDIRPLUS/inotify reproducer returned the
  original qstr bytes after the NUL, with no stale slab bytes detected.
- Patch 3 alone: tmpfs FAN_REPORT_DFID_NAME creation and FAN_RENAME
  reported the expected names, NUL terminators, and zeroed alignment.
- All three together: the above FUSE and tmpfs regression probes passed.

Junyoung Jang (3):
  fuse: skip dcache instantiation for readdirplus names with embedded
    NUL
  inotify: copy full qstr length for event names
  fanotify: copy full qstr length for copied event names

 fs/fuse/readdir.c                    |  2 ++
 fs/notify/fanotify/fanotify.h        | 12 ++++++++++--
 fs/notify/inotify/inotify_fsnotify.c |  6 ++++--
 3 files changed, 16 insertions(+), 4 deletions(-)


base-commit: 23c62304dde29abe92013d85910d03a77dada35d
