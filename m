Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338343802E
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381887; cv=none; b=YILrKtJStKLESx//oTTHi0dgds0SpO8kb3mF5WkskanZ7u2bmqJ66L1hh32rc1a8Zp8Wrag4/Bf7vvWPwVk+u8K+ZVWV2CgMogLEGgan8qQD/Pjvf7Fe4LFtVbgg3/MOMbMKhK9bK0tht/Rq+HIBHvj2KEYzigWFLHj8PR/vmsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381887; c=relaxed/simple;
	bh=rdZAz7cRFj3PdwDON/U2rLzIrTQddJNCfUz4fMn1Cgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cSbKb5Xmk0AF3EGh44uRKlrJVkmjegSfuXwFRaLDWNGgGVTLhz1GXze+CUZf1cW7Q25UQ0q7q0Ud+HKVF8ZjvMBNqtt84OnrzbBClfcIndP2Uut87oqqa/KkxrqSGSlj97VW/wTGyntq3TYN3syj3SxZoVVboxc6r+JUOW+gBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KViTsalb; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KViTsalb"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so1964792a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789381883; x=1789986683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ARAL3oS9Pm8E23aBV6jU2rxP85qSTEkId7/k0Cw8UTQ=;
        b=KViTsalbXH6bgmEF6t60cJrv7a+HuvUdDkqqXGRa6iyeOlUPPkZmyrJrPVmgzwsX/l
         XNpFTInsrTFjpWYHKCM5/wiW0h0ugjwtuJm2vkgmIKg4OmBcafSUNUPR1839kEoiqDDe
         BomAzM2WIfXRF0zivOoVWK2UeO7C7liDgJoKgYoCpOSqQoyNIp7MYY7e6xdAlSkRydlC
         eYdzuJXz41hL1Ec33L6ne+V+Dr2CZ+tT8nEq88em7Pbmth2FX7dS+A/E2Ubg3pKmMVk5
         pzk/omJS9Uu4aH4SugTdmjrq0+x/eVYYqCuVPiTEffaEZaretdcE4txKQoBbZlFlMJOK
         t9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789381883; x=1789986683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ARAL3oS9Pm8E23aBV6jU2rxP85qSTEkId7/k0Cw8UTQ=;
        b=I+jy9rRpHeNYCLefXDVrkjD5okT7FgnzpbfbD3xsqtgP2FEzVODZi055GhIEerspuT
         xCmTT5n9xmMedg9ZVgpEnXAPV2RCyrFkN5SnBDySc8WA58hPYcp/wptog3Mj7rwwbfi6
         GatAfTR4xau5qTyhG2c/qV1VoqU5r6SQ3IcDQBZbHAHYSW7om+43ZQB5QA8RClwIVkaB
         pc3bZKaTFaQPSTMeYrHRXZfnWFuz1hEWlmUy4dcYop37rZIQRUCEuaqZNB4E5GfKDZro
         CM+jiiuxhHV0S4FYueJMpaX3gNfcYrvdtwpsQwy2GYgZMZarQ6ThZo9R+HAkXuFyLCaU
         WKlg==
X-Forwarded-Encrypted: i=1; AKwUvBwW00EMByhBavLXdB1687Ssd83d8NoD22aG0ooGw9wy76IcJKXv78mepXEokumzDSSxMJP7DH1GJHrBUcJ+@vger.kernel.org
X-Gm-Message-State: AFuF++mDVp0g/tap+eQJdZBoZG1MN373a1Ymk/sCarusRdGlux1yEoJw
	ak37w2ui6jSWX6C/n2wC1eQR6KlTo1Y9LAKFN3Fo/LB5+LE3U7Ymg54MxounZk41C9s=
X-Gm-Gg: AYBFou3pwfYrfYiMyG7WbPb8KJVyQpzbDdKQ83y1xBoRlCC9PlXS0sVcNeej89kXUAj
	MgwqfwqtfbBLujMX1vpEprqIZ5EAJ3Zx0SbJc1d8DeyoXM185a4ruHioCKgkNLXrjowIhCZzTlC
	d+CiCm2f0yxZbDNMJv6yUzVXL4k/IjLiYibG7txshflJLOSBN5NpHOTv1NdaN4+X+d6P9abrRsl
	hb8qba/8vE9J5FSXGbgigvn3OONDUzJ75CXAwGLCheWLIm8vaZulYbgQ5YO9kPHfbFiaaW2WhwO
	rdh3nlj41UsU60vLuexod7LKtTRULdd4MN1pU7IkLtREnJjTu7PpsaRKKp3WvOKlO1CmF1Egrse
	oIaw4KcTJPbW/yEwl0xL6jK+ZABcJ5gAZJ4IKtZn9chvS9vp0BVydO6kH60ulGPsJ1zNopqpY3n
	Z69hJIwO3e5qoYDfYTUURrS83xz+mMeaHXCMm4AXyHWzWPAIIsmzpOjhWzo9Ovb7w0Pg1piL+Ub
	Q==
X-Received: by 2002:a17:90b:1c90:b0:39d:f660:fa9c with SMTP id 98e67ed59e1d1-39df660fademr1021701a91.10.1789381882933;
        Mon, 14 Sep 2026 03:31:22 -0700 (PDT)
Received: from localhost ([106.38.226.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9587c157sm20168973a91.16.2026.09.14.03.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:31:22 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	willy@infradead.org,
	jack@suse.cz,
	rostedt@goodmis.org,
	tj@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v4 0/3] memcg,writeback: flush foreign bdev mappings separately
Date: Mon, 14 Sep 2026 18:31:16 +0800
Message-Id: <20260914103119.1708452-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bdev inodes are routinely shared by multiple memcgs. Recording their
owner wb as foreign can cause dirty throttling in one memcg to trigger
writeback of unrelated file data belonging to that wb.

On one production machine, bdev mapping snapshots showed as little
as about 10 MiB of dirty data. A queue snapshot of its owner wb showed
599 foreign-flush works, with an average requested writeback budget of
43 GiB per work.

In other words, a small amount of foreign dirtying in the bdev mapping
can trigger owner-wide writeback requests, whose budgets averaged
43 GiB in this queue snapshot.

Following Jan's suggestion, this series records foreign bdev targets
separately and flushes their mappings instead of their owner wbs. This
preserves a way for dirty throttling to initiate bdev writeback while
avoiding owner-wide writeback triggered by these records. The existing
foreign-wb mechanism remains unchanged for other inodes.

Tracking is best effort: each memcg keeps a bounded set of device
numbers without persistent device or inode references. Closed devices
and devices with a busy open_mutex are skipped. Device removal and
device-number reuse may race with lookup.

Flushes run asynchronously on a dedicated workqueue to isolate these
frequently triggered tasks from existing workqueue users. If workqueue
allocation fails, the existing foreign-wb mechanism remains in use.

Julian Sun (3):
  block: introduce bdev_flush_by_dev()
  memcg,writeback: flush foreign bdev mappings separately from owner wbs
  writeback: record bdev targets in foreign writeback tracepoints

 block/bdev.c                     |  24 +++++++
 include/linux/blkdev.h           |   1 +
 include/linux/memcontrol.h       |  15 ++++
 include/trace/events/writeback.h |  22 +++---
 mm/memcontrol.c                  | 113 ++++++++++++++++++++++++++++---
 5 files changed, 157 insertions(+), 18 deletions(-)
