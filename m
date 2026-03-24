Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5EF3A3E67
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392378; cv=none; b=oeyTT+c85ZjCEDmg4+tnNGMdD6xr1spXUqRHMB+au6d30nqktTuHGKvOgwSPI3NRqeE5EbVBtOi2UVI5i1bBPfiVwvjvuR4aLqMvrutmODlzAVxMWGsU06hL0YoLopXjZsGztVmOqNy1WQEEjr7HJr3rsnjJqX/an6HZcHnRfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392378; c=relaxed/simple;
	bh=ZiBuNfCeKfbw7SRjrz54Fz3XNoeFRwNZeeoFnsR1NJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q12ljZErOqXJufUWY+GsGDNTKn6WtsAeiMIBZgV3hHogyNVlOnbx0FmbGSTe3rt3Ap1tHb92D/oh+7hGzYT8nssVUrruTg9n4gGGzF42wZeFascR3Q9H+EiLUI1MANp98M9/1BeJFacFhl2TG8JyCXLN2rTq9mFatF39VOs0KHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTUkbno2; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTUkbno2"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c6e2355739dso731225a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392377; x=1774997177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G53i4OLMLqo5+qEy6R2dIStuOReJRAbVzCVQ3wIDd+o=;
        b=UTUkbno24hfmXCvpa8ZqmegfxSk7hfb37ZIJsHeWToRhuNw5A4dGeAu9C4MzZQFXwJ
         dNMcryXsO2zV+B5WX62n3vxWmXle3zvcXYgUdUxBsI9INX+dJrrgwOiUVSbZ6U8uG8K2
         loDB9X7bR7zEgvP8DIIr3ZIAp7YLk4fKHQjKwpNFc9lBIZF0MWZyY7DJ0Z+7haNQoVW7
         zxOyIIkYyFKbBimMuprewSLtclLnv7r5y+WmpjY622A7MXYxqtYrjwtSg1JhX/Rr7MhL
         3OQXTsqxYTdZpIlHVCsrp7Xh+9e5CHuNKa2D36eQ5YcxLqCXt5wiWmN2CSZeDt3+TQuE
         B/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392377; x=1774997177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G53i4OLMLqo5+qEy6R2dIStuOReJRAbVzCVQ3wIDd+o=;
        b=fliSqurpIHuFeSbj+jTFp3XdOe9gngiIjLykjb2yRzg8pjukJw/THYXQgBTjVeYb1S
         kR279Sxp4DHhKsTVyT50FfBw5Z/eAuR5hok1afYMO7xV92CQYbb98jdf6xREvvRmqEAi
         eIcs+hGypfduI6L3k93t2NHHAf8h45Ux5KRcjFTqz2/4sRAfCi76xR/X0LOoTyiDskAm
         IVZZNEZqOJbLJUU/+qhXUT5kcnsAYdDaoj+Ia1sS+sJNAfcMC4pgowD678tFcxAAvMKR
         KGrRnk7etEklSYQb6/veP9KoE18DRYDEdCfn9/vXnmGQnSPGklOiybHfux7sHSQhh6H7
         X3rg==
X-Forwarded-Encrypted: i=1; AJvYcCWpLacNnzzbwUP1F6NPZbDQQg7we3tdGcoLsdNrzf0cYPgAJnbH2Nyri8aD3hN6H7EBK/A8NWeDD+u3cBi2@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbLLPzzjJRVOnqe1V8AoqoyfStPv8kiC04n/DaGqxI1Z4nZBy
	lFTL90R4LIWyEUJjyVMBdVGjNO7AqBwtarg+jHnvwJWlDBg6lUdsxNzN3mw0aA==
X-Gm-Gg: ATEYQzwXDho/0UZhQZ0SIJNOfpQ5lo8rwhgxNaRMisAd5OVxyFTW7BpLgWBga+xkxku
	9uqJwCqCV0fCOXYwJ/j8oxnXmGSxXWtN6707Nue+kn5vPUf0y5yqu5Mffc1PS+euAaoPrLSJMd5
	Yf/+LzHuOFPvdkKFadURyXg5WPWHeFryeeALu1mcUPEz7LOLXoTTD+mh+NWupLYyeHZW3XQeG7g
	vxpzTCN6AuA02gDlolQ9Hl+iubfuoeNfZeUnTkhm1NabSYMgR5Cvdf4cVk8tSkU457Z24Yugi6D
	qPbyen7qgpvRAEdshwKq6NvtisszWbhhJ75R18TZnlwSZzLQN216M433QdpQPXJGHrr0Uo4u4vI
	n1t8FIXoUZH5sSu4rbXUHQRR0NMqY2WxfuJiintNwmLvk5/LTkXPGZTp8TpICrJ042coFI4DGDq
	LKBNialwSWEm4I57KQQmrsYNv9Ow+2
X-Received: by 2002:a17:902:da91:b0:2b0:4a1c:b847 with SMTP id d9443c01a7336-2b0b0aff14amr12090575ad.52.1774392376909;
        Tue, 24 Mar 2026 15:46:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0aa622677sm31161475ad.74.2026.03.24.15.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:46:16 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: miklos@szeredi.hu,
	bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 0/9] fuse: add io-uring buffer rings and zero-copy
Date: Tue, 24 Mar 2026 15:45:23 -0700
Message-ID: <20260324224532.3733468-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds buffer ring and zero-copy capabilities to fuse over io-uring.

Using buffer rings has two benefits:
a) eliminates the overhead of pinning/unpinning user pages and
translating virtual addresses for every server-kernel interaction

b) reduces the amount of memory needed for the buffers per queue.
Incremental buffer consumption, when added, will allow non-overlapping
regions of a buffer to be used simultaneously across multiple requests.

Using zero-copy (only for privileged servers) eliminates the memory copies
between kernel and userspace for read/write/payload-heavy operations by
allowing the server to directly operate on the client's underlying pages.

This series has a dependency on io-uring kernel-managed buffer rings [1] and
the io-uring registered bvec buffers changes in [2]. It contains the fuse
changes carried over from the larger series in [3]. Because of the heavy
dependency on the io-uring changes, this series is submitted against Jens's
io-uring tree instead of Miklos's fuse tree.

This series has the following changes from [3]:
* uses a registered memory region for headers instead of a fixed buffer.
  This avoids the overhead of fixed buffer lookups and having to do a
  refcounting dance on every i/o
* adds folio reference acquisition for pages registered into the bvec (and the
  corresponding release callback) to account for the case where a server is
  forcibly unmounted while non-fuse io-uring requests using those pages are
  in-flight

Benchmarks for zero-copy showed approximately the following differences in
throughput for bs=1M:

direct randreads: ~20% increase (~2100 MB/s -> ~2600 MB/s)
buffered randreads: ~25% increase (~1900 MB/s -> 2400 MB/s)
direct randwrites: no difference (~750 MB/s)
buffered randwrites: ~10% increase (950 MB/s -> 1050 MB/s)

The benchmark was run using fio on the passthrough_hp server:
fio --name=test_run --ioengine=sync --rw=rand{read,write} --bs=1M
--size=1G --numjobs=2 --ramp_time=30 --group_reporting=1

The libfuse changes can be found in [4]. This has a dependency on the liburing
changes in [5]. To test the server, you can run it with:
sudo ~/libfuse/build/example/passthrough_hp ~/src ~/mounts/tmp
--nopassthrough -o io_uring_zero_copy -o io_uring_q_depth=8
Once this series is merged, the libfuse changes will be tidied up and
submitted upstream.

Thanks,
Joanne 

[1] https://lore.kernel.org/linux-fsdevel/20260306003224.3620942-1-joannelkoong@gmail.com/
[2] https://lore.kernel.org/io-uring/20260324221426.3436334-1-joannelkoong@gmail.com/
[3] https://lore.kernel.org/linux-fsdevel/20260116233044.1532965-1-joannelkoong@gmail.com/
[4] https://github.com/joannekoong/libfuse/tree/zero_copy
[5] https://github.com/joannekoong/liburing/commits/pbuf_kernel_managed/

Joanne Koong (9):
  fuse: separate next request fetching from sending logic
  fuse: refactor io-uring header copying to ring
  fuse: refactor io-uring header copying from ring
  fuse: use enum types for header copying
  fuse: refactor setting up copy state for payload copying
  fuse: support buffer copying for kernel addresses
  fuse: add io-uring kernel-managed buffer ring
  fuse: add zero-copy over io-uring
  docs: fuse: add io-uring bufring and zero-copy documentation

 .../filesystems/fuse/fuse-io-uring.rst        |  61 +-
 fs/fuse/dev.c                                 |  32 +-
 fs/fuse/dev_uring.c                           | 696 ++++++++++++++----
 fs/fuse/dev_uring_i.h                         |  50 +-
 fs/fuse/fuse_dev_i.h                          |   8 +-
 include/uapi/linux/fuse.h                     |  20 +-
 6 files changed, 707 insertions(+), 160 deletions(-)

-- 
2.52.0

