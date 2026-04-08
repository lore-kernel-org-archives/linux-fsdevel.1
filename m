Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD1F3D75B4
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669138; cv=none; b=ljU26IIusS8/lyF6A79R4L6Rf4326RjsOqwHcIMSi5J0GHV0jrcZ6YoTaRHgvFlJUBVwF2vp9NT0nNsc7EAP+LtnM2idCQ4Md+XKbiDybqAWNSFTsZ7CqcnX5YhGg/0TvJqg930ktuKItz8zjPMY6OQ5L9/ajzDQbpdYFtH4g6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669138; c=relaxed/simple;
	bh=klDIGLxPksO+Nq31HN/9+vzyWU74qoFWf8Dtr89mjG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oXKaBOhnsPqfJQYzZeodc+ZyOj4yh1OU7yrLKLeSxjB9EQWxf2t993RciPVDYi/uaScF89T8YjyaVIjfcDCxD9WuYBzmL91b0fVgeoE3AzOmJGxmNDhzVKxVcfrCcnIQTvnsxHRrLwzut/qFSv4r35qXvDC8oNA7Gqg5h/ttboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eg6Bwk+I; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Eg6Bwk+I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775669123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=11g+9T08hIogH95VpfXi+p60A1Z7j8o7HvO99QmmDAk=;
	b=Eg6Bwk+In8E9+3c0OdXhVABPfQzfqdxxhQuvT3Th6UdfnfL2LX74OXMCgdjXsp8BPeSxee
	ugMUODUr0C8DUPyxjUs9z8tRtASJA15ZNtWvu+y3P4eFvC8BGBf3pd+Rp3bR0MHsZoK6K2
	wabh0SwW/shwataxG/c5Ql9K2/L7a6M=
From: wen.yang@linux.dev
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v5 0/2] eventfd: add configurable maximum counter value for flow control
Date: Thu,  9 Apr 2026 01:24:47 +0800
Message-Id: <cover.1775668339.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

eventfd's counter is bounded only by ULLONG_MAX (~1.8x10^19). In
non-semaphore mode a fast producer can write continuously while a slow
consumer falls behind: the producer never stalls, the counter grows
without limit, both sides burn CPU at 100%, and consumer lag is
invisible. There is no mechanism to apply back-pressure.

Add EFD_IOC_SET_MAXIMUM and EFD_IOC_GET_MAXIMUM ioctl commands that
set a configurable overflow threshold. A write(2) that would push the
counter to or beyond maximum blocks (EAGAIN for O_NONBLOCK fds). The
kernel-internal eventfd_signal() path may still raise the counter to
maximum (EPOLLERR), preserving the original overflow semantics. The
default is ULLONG_MAX, preserving backward compatibility.

This follows the back-pressure pattern already established in the
kernel: pipe(2) writers block when the buffer is full, capacity is
tunable via fcntl(F_SETPIPE_SZ); mq_send(3) blocks when the queue
depth reaches mq_maxmsg. EFD_IOC_SET_MAXIMUM applies the same
pattern to eventfd.

Measured on a 4-core x86_64, writer and reader pinned to separate CPUs,
reader sleeps 1 ms between reads to simulate processing time:

  Bench 1 - burst/CPU (5 s, blocking write)
  maximum      wcpu_ms  rcpu_ms      EAGAIN      writes    reads
  --------------------------------------------------------------
  ULLONG_MAX      5002      132           0     6517388     4506
  10               133      150           0       40456     4496
  (O_NONBLOCK+spin bypasses flow control; use O_NONBLOCK+poll(POLLOUT)
   to avoid wasting CPU on EAGAIN retries while still multiplexing fds)

  Bench 2 - latency tail (EFD_SEMAPHORE, 10 K/s writer, ~8 K/s reader,
            5000 events)
  maximum      p99_us   p999_us    max_us
  ----------------------------------------
  ULLONG_MAX   141218   142477    142588
  10             1719     2378      2381

  Bench 3 - coalescing (non-EFD_SEMAPHORE, 10000 writes, 125 us/read
            reader; each read drains the full counter)
  maximum      writes    reads   avg_batch
  -----------------------------------------
  ULLONG_MAX    10000       79       126.6
  10            10000     1121         8.9

With maximum=10: burst CPU drops >97% (5002 ms -> 133 ms); latency p999
drops ~60x (142 ms -> 2.4 ms); coalescing batch bounded to 9 vs 127,
so the consumer always knows the backlog is small.

Notes:
- Magic 'J': 'E' conflicts with linux/input.h and xen/evtchn.h; 'J' is
  unregistered, added to ioctl-number.rst.
- Command numbers 0/1: explicit distinct numbers are clearer than
  relying solely on direction bits to disambiguate SET from GET.
- .compat_ioctl = compat_ptr_ioctl handles 32-bit user pointers.
- Writers woken on SET_MAXIMUM: a raised limit takes effect immediately
  without waiting for the next read(2).

Changes since v4
  (https://lore.kernel.org/all/20250310051832.5658-1-wen.yang@linux.dev/)
- Use ioctl magic 'J' instead of 'E' (conflict with input.h/xen).
- Add .compat_ioctl = compat_ptr_ioctl.
- Expose eventfd-maximum in /proc/self/fdinfo.
- Return -ENOTTY for unrecognised ioctl commands (was -ENOENT).
- Remove the unnecessary !argp guard in eventfd_ioctl().
- Register magic 'J' in Documentation/userspace-api/ioctl/ioctl-number.rst.
- Add kselftest correctness tests.

Wen Yang (2):
  eventfd: add configurable per-fd counter maximum for flow control
  selftests/eventfd: add EFD_IOC_{SET,GET}_MAXIMUM tests

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 fs/eventfd.c                                  |  74 +++++-
 include/uapi/linux/eventfd.h                  |   6 +
 .../filesystems/eventfd/eventfd_test.c        | 238 +++++++++++++++++-
 4 files changed, 306 insertions(+), 13 deletions(-)

-- 
2.25.1

