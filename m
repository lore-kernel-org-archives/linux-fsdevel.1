Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702D282F31
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774135353; cv=none; b=QvxX2cgtJIQai6dNy1ntw1eQ5o9KgwM94AlOrU27ZoPNAR5X5cf555q/tlOVeDePv61mxdiN1m94PVijhi1AGoW30My7dr+Ce1dsZ9jtV1vlg59OHW0h4V3E096zmkV/xgf+suB8Zywy2vffcu4m5ta4mWLNKj2ppS1p3xxmHTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774135353; c=relaxed/simple;
	bh=UaxvNqszre9c0sz3+btyqg9Gq0GYUJG2+7kup9nE+OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oxq4F3a9ux8FhhC/RvFk9UgSp1qXrpXEPNAZzyZnemLpd6vPlyS2vRXn0jdFn1iMLFZZTtQvagnt/qGzSI1ukm1UwTy9BeY+Nt6NWjjTG5vI27Xxp9qHB3ab/9hJR7EKnCYXtMCUOR1VxZ8eSLWs0cpz8qH0i0tzu/KDaSVwMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXs3Brlt; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXs3Brlt"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439bcec8613so1100758f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 16:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774135350; x=1774740150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nv4o2v3uHPxntCmHjgj3+r2/LEn9pVdHbSqfA14Nq34=;
        b=XXs3Brlt86ETZyJY+FB2jX8oExdzhpYtIQXXqop0zKNXBNEfZDsB2fxMjkCpAZKlie
         pogmOSiEIVPXnW10cCy66Ifb+BTKzGzQHXgYhItFER8HQuGz9luXuh0RJWbA9K7LBghw
         x38PkwGk+qPzgvgewnMjPagzz4DeTBOmLwaHA/XC7v4BCbW1MoX8hwgDxnu8rNd5YPYY
         S4rZfoD/yZTH/3WPKtieqO2VWsm4IyyEolkNa4+tQj/GPcYMZsimSv5SgJd5z5AAmtzc
         fIrymVKeMYYAjckFSorFjJDzqdp01lCq/SX01WVEsB/nHUT3iTm4jUyyigl3Fg9Suker
         r3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774135350; x=1774740150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv4o2v3uHPxntCmHjgj3+r2/LEn9pVdHbSqfA14Nq34=;
        b=BBnQvH8nDkoo3GOcSc8M3/OTK0mPusKIOVa2j4GvcEXEqRYRSinHuOPEdQCgkA/AO6
         KXY5SeQAlGpYJ7DLqpJyn8uo3I7XTHqanEVfrcqz5Ohlr5iBuyQCUSTL0cYfp2YwLAcu
         nce1kSZPwfEQaoX0BWfPtmyVVymrNWH9BRMQSSX7c99H3H3XDevKxfF5T++iuM89oa5s
         uVnWJF8cxl5fmZZ8rzREr7SCwcurGq5bzrL1opH+/eA5q0q4dCEmD39kae56yxx/YvUK
         gn2jPYl6yumizBvdWZiHWwJRUe6bVNuNQzXi2YppljEDAf298IpJqI86+EPLIBrBELnp
         3K4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfJHNCS4vsC0h1lLtShCkRtWUpBFw21s33zLUycrEqr7TOImHFpzHaBZ9SWb1S5HEvVmv9Rss2m9eeZdFM@vger.kernel.org
X-Gm-Message-State: AOJu0YyZcIwdRU4N6soy0j+FDS6rpn09mJiT/rFTTwuvs5f1w0MKuSrR
	jipDd0Zvh9Vn2/3cR6S7LXrWaf0uNUsnz4VCnaL1ewyTrIr3Z4DhV5Ze
X-Gm-Gg: ATEYQzwTY+aL1gKYVitywfH3JVErzAdz+ld58cqQLQYh6ITaFOd8C77d8B0sTCWXlvH
	1ig7UuHqG2vQsKuwIKWK7HNCBfA8Dv3ZZHvBvTu5aILrm6XYdNg5oClGYpeI8bx6pmmNZA6k7HC
	CFurivAqdJ0oP/p8iT6qzSPct6h64ACiqDdVrdjg3DgCFBUfRuYebl5VGLplkIcu60Gl/tbV48x
	6HBDampc13hFpa7UkANGkWpBkV2PaLBK/sMKxaj01kYUjEGiU6hiFdhekF5ie84aUSiVpg1pGgn
	g23vphZAzpuwvM/BTvLLkEnZVQMyge4FDskUCtNoqTr/BOrjhHSpXfFSoa/2DQgyRQ7W6X7b519
	sGRW/TGtBKCtB98FniqN3q1D6XEfyUg0YrrZ/jBPGMKOapV9eDtd0hgyVXnvFtc30pmIReSUhR/
	x6JOPvLmSiJytwdYwza0ExhGoyi2SQ1jCWJm5Qz59+OO2Ol+OqY9DnvF1nb8U=
X-Received: by 2002:a05:6000:a8e:b0:43b:3cdc:9429 with SMTP id ffacd0b85a97d-43b64243307mr9698070f8f.1.1774135350250;
        Sat, 21 Mar 2026 16:22:30 -0700 (PDT)
Received: from ddp-thinkpad.tail20b0d.ts.net ([95.141.20.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6425eeb4sm15609897f8f.0.2026.03.21.16.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 16:22:29 -0700 (PDT)
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
Subject: [PATCH v3 0/4] New IORING_OP_DUP
Date: Sat, 21 Mar 2026 23:21:38 +0000
Message-ID: <20260321232142.911280-1-daniele.di.proietto@gmail.com>
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

Changes since v2:
* Split the fs/ changes into separate commits
* Minor fixes, as suggested
* Avoided use of gotos in io_dup_to_fd() with guard(), as suggested

v2: https://lore.kernel.org/io-uring/20260320182341.780295-1-daniele.di.proietto@gmail.com/T/#t

Changes since v1:
* Implemented dup to direct descriptors as well
* dup from fd to fd is now atomic
* Punt to io-wq if the operation might sleep
* Removed prep() check on fd
* Avoided use of IOSQE_FIXED_FILE flag

v1: https://lore.kernel.org/io-uring/086190ca-1c34-448f-a565-aa41f671971f@gmail.com/T/#t

Daniele Di Proietto (4):
  io_uring: Extract io_file_get_fixed_node() helper
  fs: Export expand_files()
  fs: Export new helper do_replace_fd_locked()
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

