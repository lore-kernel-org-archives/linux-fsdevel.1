Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43976344DA0
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 01:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785031198; cv=none; b=dfaIF08D3Z5XoAl7kM84gf9orn+iE1cEKs43l+wahHI8m47FwctVcfi0EcbrexdkTMDpG1E9LIpyqI60Qsd8VHLkxGOAkypz5IH007EV8IvHypbIfmMMf1qGir2tqlHZl87T/r/Q4YDSpcX1QAswg0nKRoiEeNj/9JbwOwotAZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785031198; c=relaxed/simple;
	bh=B4IYYuGph/em9rYUeyTrjgFnY/FPWkD9+tX1J0lcrvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hnr/rCR4HeKwH/U+HIPirCaAKFju3QxQ//6/e7/9J8XoWcmS+920J7dwF2uzurxmpqxl47jSiU8csiNkm0EGDedYTRCpEFqXLuw2T/OgLrgGVWtik+96nzchRrYUgC4INU1eWvVhrm0mJdSMtwGLv1v7ORUD9Zouw/eJGRw1Hl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBlkG3SL; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBlkG3SL"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e9ecb1e13bso604758a34.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 18:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785031196; x=1785635996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dp1m+he2iASF586QKTRoFR35aZ7KbKPACpgwKYAXwl8=;
        b=IBlkG3SLhcxdbNKay4J36gniVsEKrjjMJ+KVis26n1LtuFQ1PhoGJcqMV+GsjCPALH
         qgVB68v4RsJiKUbCQVyVNlviYIgjT3hYAT8whXTQZY/rIZvlKDyz1XKPYp/0NGT2Say/
         ILQL54GqDgWlPrzpB4eNt/ozLt/3t3CwAblQ04SEiu1ris0r9yEA+taMsaCwFxvK2VPO
         F2AJ6yac58XbG/LL8stlASsDsd5q3gUOmtVyigDT74gOBrII0YxcQVH2RrDjlZNO5h08
         T/1jaxqhxSsyyUgKfVgdq2Tab9bP7Ja+E0d17iieJrJ3/LvqXGFKrEHhj3ohixjWr2z3
         Dqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785031196; x=1785635996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dp1m+he2iASF586QKTRoFR35aZ7KbKPACpgwKYAXwl8=;
        b=rraEuePXrR38Y8iyZ0SSp9bG1eopaz3e2SpnWAYCNiMGikBwnoly3TeFCJBJl5AvXQ
         i86H8a2HkhNuZr0jiM5xUev/l8DcuBcTAI6v56sv6MWnYYCisi7XzVUXT0WLp1cCkIB1
         /IsDEIbIZLJuki4ohjFPrHXcQwINUxsq6YCD6z4Op2Dkkx7lgmdsZE0a1F0eTcjbAvI5
         EmK+MOjJby9KzD7Km4Z1YlxmrbKpDdUb05ztKAjHmEhrPPpGKn+X+crsy0c2kFkwlbTA
         QlHgjcC+5/Q5Deu+fsjrHhsoEYb24iqpLg0IJGvVUIy4rYB9iQW18IyaKn85f6o5p/uW
         QuUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr4ciUHIl36lSqQVEziKmvP6dRgJl0/iv5+LUH+a7HMTWjaOmHxshIjQpbJcUDxyBlLHLyTugqb0gWvpXKB@vger.kernel.org
X-Gm-Message-State: AOJu0YwQLybGrROHZZjPuS+z4UGakT2VW6NKPgTZgFAPLYeTAYUayk5+
	E95z6y6ZOyaxvGu+1SeFLwbWTJzOSFMpczeFDtKxAPKN+2fjBtarymeq
X-Gm-Gg: AR+sD13pOyq8iuynGye1ahd7wZwSDEpL//W6O7iZuPmqfxup8S3NF+W9eb/FCEobtjT
	nP2ZDVBpT4nE5qSyv3KY7/YVNXypnCwcqcV6fkMXwxuc392SkRnBqDiGlxSgDW/x9VZWt7+6B44
	SrTrDyaiOb4uezOMPcSrUWcOzPWcRJGYxU5h3INnG7vkaI1c20+EwurmXVMKi7gxhKRqwfoj9cN
	WEvSuKsxhv/FS7T12aeEcOeAV4WZMPHmHL156nmBnPF8y523UrUqvoKcc5dlbqVuU2jYe9WPYjg
	pv+R4p8wP7g2MedZIzlr3g/xajfpsGExG56IftfLaT3ga2BIhY9ftUC9RoFtP/cMHzKvkMZPux6
	OjtjxMxBD/PnLLlZhGAKfoDYnNlGzljVlo2x+WiR15oHMGIZv0VH8FbhbSLa82o3LCcWQkTG+0B
	6vhsCpyp31umyDRYOi0Ns8FFtxKL1dbHrzUnV8G7wA1hWNnV5Da8hXWfLr/RchCoTUTevyUCiDh
	kCf8xLHf4fpQdHEW680F2RMVKMCB6q0sw==
X-Received: by 2002:a05:6830:2405:b0:7e9:b4d0:53af with SMTP id 46e09a7af769-7ee78e4e3fdmr3203784a34.32.1785031196089;
        Sat, 25 Jul 2026 18:59:56 -0700 (PDT)
Received: from rdf-gcp2.us-central1-b.c.storage-xlrait-66065.internal (163.80.112.136.bc.googleusercontent.com. [136.112.80.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee29e0ec5bsm9335656a34.10.2026.07.25.18.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 18:59:55 -0700 (PDT)
From: Russ Fellows <russ.fellows@gmail.com>
To: miklos@szeredi.hu
Cc: amir73il@gmail.com,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Russ Fellows <russ.fellows@gmail.com>
Subject: [PATCH v4 0/2] fuse: allow parallel direct writes for passthrough
Date: Sun, 26 Jul 2026 01:59:53 +0000
Message-ID: <20260726015955.319132-1-russ.fellows@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260616231325.16788-1-russ.fellows@gmail.com>
References: <20260616231325.16788-1-russ.fellows@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4, about six weeks after v3 [1] -- apologies for the delay.
Thanks to Amir Goldstein for the detailed review of v3 and for the
suggested patches; this revision implements that feedback.  The v3
thread [1] has the full context and Amir's comments.

The series is also available at:
  https://github.com/russfellows/linux-fuse-passthrough-patches

FUSE passthrough writes are fully serialised on the inode lock, even when
the server advertises FOPEN_PARALLEL_DIRECT_WRITES and the write is a
direct, non-append, within-EOF overwrite.  Native FUSE direct-IO writes
already take a shared lock in that case; there is no reason passthrough
cannot do the same.  With a passthrough backing file on XFS, this is the
difference between serialised and fully parallel 4K random-write O_DIRECT
throughput.

Patch 1 stops fuse_file_io_open() from stripping
FOPEN_PARALLEL_DIRECT_WRITES on passthrough opens (which bypass the page
cache without FOPEN_DIRECT_IO).  Patch 2 lets fuse_passthrough_write_iter()
take the shared lock for eligible writes by sharing the existing direct-IO
write-lock helper rather than duplicating it.

Rebased onto v6.18.39 (LTS).

Changes since v3:
 - Patch 1: keep only the FOPEN_IOMODE_CACHED() helper (drop the
   IS_DIRECT / IS_PASSTHROUGH macros, which described how I/O is performed
   rather than the ff->iomode state and were misleading); fold the
   O_DIRECT/fcntl note into the FOPEN_PARALLEL_DIRECT_WRITES comment; and
   simplify fuse_file_io_open() so a pure direct-IO open needs no early
   return.  (Per Amir's review and suggested diff.)
 - Patch 2: instead of duplicating fuse_dio_lock() into passthrough.c,
   generalise it: fuse_io_wr_exclusive_lock() now also handles passthrough,
   the uncached-io refcount is factored into fuse_parallel_dio_start/end()
   (no-ops for passthrough's permanent uncached iomode), and
   fuse_dio_lock()/fuse_dio_unlock() are renamed fuse_io_wr_lock()/
   fuse_io_wr_unlock() and shared by both write paths.  (Per Amir's review
   and suggested diff.)

Testing (fstests / xfstests)
----------------------------
Run with the libfuse passthrough_hp server under xfstests (FSTYP=fuse),
'./check -fuse -g quick' (642 tests), on v6.18.39, backing XFS on a
RAM-backed null_blk device.  An unpatched v6.18.39 baseline was captured
first, then the same tree with this series applied; results were diffed to
isolate any patch-induced change.  Two server configs were exercised, as
suggested by Amir:

  passthrough (default):    unpatched 25 failed / patched 25 failed
  passthrough --direct-io:  unpatched 27 failed / patched 27 failed

In both configs the failing set is identical with and without the series
(the --direct-io set is the default set plus generic/355 and generic/362).
Every failure is pre-existing on the unpatched kernel and is a known
passthrough_hp / fuse limitation (permission/ACL/atime/mmap-coherency
tests), unrelated to this change:

  => zero regressions introduced by the series in either config.

No kernel warnings, lockdep reports, or splats were observed in any run.

Performance
-----------
Custom FUSE passthrough daemon advertising FOPEN_PASSTHROUGH |
FOPEN_PARALLEL_DIRECT_WRITES, XFS on a RAM-backed null_blk device, kernel
v6.18.39.  fio 4K random write, O_DIRECT, libaio, iodepth=64, single shared
file:

  numjobs | unpatched (IOPS) | patched (IOPS)
  --------|------------------|---------------
        1 |         352,000  |       352,000
        2 |         440,000  |       648,000
        3 |         429,000  |       951,000
        4 |         423,000  |       987,000

Unpatched write throughput is flat regardless of job count (the exclusive
inode lock serialises all writers to the file); with the series it scales
with concurrency, ~2.3x at 4 jobs, up to the backing device ceiling.
Single-job is unchanged (no lock contention), and 4K random *read*
throughput is unchanged (~1.37M IOPS with and without the series), since
reads never took the exclusive lock.

[1] v3: https://lore.kernel.org/all/20260616231325.16788-1-russ.fellows@gmail.com/

Russ Fellows (2):
  fuse: preserve FOPEN_PARALLEL_DIRECT_WRITES for passthrough opens
  fuse: allow parallel direct writes in passthrough write_iter

 fs/fuse/file.c        | 53 ++++++++++++++++++++++++++++++++++---------
 fs/fuse/fuse_i.h      |  2 ++
 fs/fuse/iomode.c      | 23 ++++++++++---------
 fs/fuse/passthrough.c |  6 ++---
 4 files changed, 59 insertions(+), 25 deletions(-)

--
2.51.0
