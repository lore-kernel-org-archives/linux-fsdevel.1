Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF213E5EF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031325; cv=none; b=N4nn7EYGlAg3NROjanyq39Pj1kRzb0OZ/X9DxZE7O14/GCat/c0QfloyXZ+YtMTxoAfErNf056FOTEEv0M73GIr5DBQq/Sx1bZO8ec/EL9XfIcT5TOL4Z3gJl58LMcBIYPEMp4UVzMcGI2o/7+suYhA0vESB7swqYWWMQ1Ni+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031325; c=relaxed/simple;
	bh=P5Hp8E3zfcxicKGpGG3E5XFkia4eFcFZGJyTqMBAIHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qFPe4aOWRG++PIRPLWNVtHF4Ha0/6jGiJUolyyeKadenaBZD/tL9NXW+z4mUgkc2yYworJDf5T4DDvGw5K/N7DJg/H4drhiKTUfB26kd4ugfuAVjIVKaI4YutYb/geyzImP0AJupVMf4Vp7nP0uLdiWf91YKpB7y1+KT7UuDJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/LYiVHX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/LYiVHX"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486507134e4so27317185e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774031322; x=1774636122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fisT1MxI/mh7qUk99d+V3DA8M3Q1UdGA67QDCcBAUE=;
        b=m/LYiVHXLL4+7oYfcDH4EavC5Y6Z0grAKkTmFiZWn4Z+gw9aRAu8M/XM+QBlK1d4Fe
         +aHqZryUn4qsEbOwLDHvCfTKdg82rRa7G2Xulq2/R71n4W094nNS7aisG3+an6N4YndT
         fiMitKfn/sUQ3p/+bkz6pQluR1sZGU48WxDGCCyIoGUzLK5eRLwIXFS7vzODdCCcsA5F
         W/6pLQDMdzLpxYdka6vXege2ibvErUG6GQNroF3DAVsi9sEPG816OOZykjgVAAbrjb3b
         pYVp9CbJQdXHQQ+bTs2T+RYsjuM7d3EXv5X9s+BCqScWTE/UuEjnIavvV4TbGY47VWPV
         q1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774031322; x=1774636122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fisT1MxI/mh7qUk99d+V3DA8M3Q1UdGA67QDCcBAUE=;
        b=KLOo/i+Wak4WVbOxBJNlihKhEjWF8ifEe51ii6pj/QS5Jyr4hn49L+wf+UpLHj8ram
         cR6uWg+6+Vp29rvEYCAdxMpuxneZoA14jiVId2xNSO2T+eB3tvotdcZURN/KbPQ/w4QA
         zj7m7f7iGtEXAQ20HYO0fhF8cPCcxZiAy34HkgfToVhSVNPkEWP1XpgZhpy9XShHQbGN
         eJonaZe8A6Zou9gtWBX2lgDbi69GZu9mhFhdbAnM9WRDltk6jzrCHB0S6hgMyyikAPrk
         K2rd/Ln2qAyI+OwmhcYV5GG9qB310Uk77LsKoAwsSJCsrORp3gPs1KS3WKrNGboa8pGU
         V3gA==
X-Forwarded-Encrypted: i=1; AJvYcCVodBKEx1DMzG15aJPItQnC5XFEbXXTy9p/DWsB8l9Fe4t3+HxhO6Uv/b0NOQpnsnPU5RaHyULKedmJJxL+@vger.kernel.org
X-Gm-Message-State: AOJu0YzEY8b3XbsZWxb21uU1WODzWjXv789B0JEWYx94MHG1LgqlLkx0
	TrnXXbpWxgRHP7O6ae9MSl0du/KbKayWouIp7t2zgtEQiiYIjKHhESZT
X-Gm-Gg: ATEYQzwDejJ3zROzJqy9KruvLEbwHoSRb0E2VXytFvO0iFud2UnGN6Ad70Dts5oTn/N
	8Fl+hkkn8teOS5KLg6Rr/Gomils/tiwQv0O1n/Gxf3e+IHWH9/dft64H2W0m9asE4H9OKiR1FGi
	4jHRJ4soLGqLxLpOTMw2kYigBPjB8UMGB3SbhZhBnHG41fTtZIdr6FA9kiWVoSvmE2pgFi6zbTv
	tPgecBU7eFQ5IPQDsgQPQSfA4DIYsZXMKx7m5rdWuXZZGIvsU84issosyWTP65FWwgbZzev7IBC
	6HW41zHqD5Xa9pgO5PrNixZ6wv5PMXZf+UtDtxOQmR0FpOW+milEiuMgKp5W4RltAW2wEyRL/l4
	xt//avdsLXhGd4JGTloPbqiz9jaiTAMZgZOmNgAqWN0Xs6K+kQztNEYvTJB44Dcv4Q3jrQy7vMS
	ESi3rjWicop1r0JyVSb4SF6vd/VrSEt3O3ZR/Y7UHfsixZNCBdYuex5jhlHw==
X-Received: by 2002:a05:600c:3483:b0:485:7f45:f71f with SMTP id 5b1f17b1804b1-486ff0293fdmr61652515e9.32.1774031322114;
        Fri, 20 Mar 2026 11:28:42 -0700 (PDT)
Received: from ddp-thinkpad.tail20b0d.ts.net ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7e2665sm92433725e9.6.2026.03.20.11.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:28:41 -0700 (PDT)
From: Daniele Di Proietto <daniele.di.proietto@gmail.com>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Daniele Di Proietto <daniele.di.proietto@gmail.com>
Subject: [PATCH v2 0/2] New IORING_OP_DUP
Date: Fri, 20 Mar 2026 18:23:39 +0000
Message-ID: <20260320182341.780295-1-daniele.di.proietto@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new operation is like dup3(). The source file can be a regular file
descriptor or a direct descriptor. The destination is a regular file
descriptor.

The direct descriptor variant is useful to move a descriptor to an fd
and close the existing fd with a single acquisition of the `struct
files_struct` `file_lock`. Combined with IORING_OP_ACCEPT or
IORING_OP_OPENAT2 with direct descriptors, it can reduce lock contention
for multithreaded applications.

Changes since v1:
* Implemented dup to direct descriptors as well
* dup from fd to fd is now atomic
* Punt to io-wq if the operation might sleep
* Removed prep() check on fd
* Avoided use of IOSQE_FIXED_FILE flag

v1: https://lore.kernel.org/io-uring/086190ca-1c34-448f-a565-aa41f671971f@gmail.com/T/#t

Daniele Di Proietto (2):
  io_uring: Extract io_file_get_fixed_node helper
  io_uring: Add IORING_OP_DUP

 fs/file.c                     | 102 ++++++++++++-------
 fs/internal.h                 |   5 +
 include/uapi/linux/io_uring.h |  17 ++++
 io_uring/io_uring.c           |  20 +++-
 io_uring/io_uring.h           |   2 +
 io_uring/opdef.c              |   8 ++
 io_uring/openclose.c          | 180 ++++++++++++++++++++++++++++++++++
 io_uring/openclose.h          |   4 +
 io_uring/splice.c             |   6 +-
 9 files changed, 298 insertions(+), 46 deletions(-)

-- 
2.43.0

