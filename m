Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484463C09F7;
	Sun, 27 Sep 2026 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790502538; cv=none; b=ucTSZtwFSyX2dmEBabjl/2W82MJVKE/zqBaLmbAG1Diig1+9iP7BOKK2SR6OFXKYb92og6PgynGU12BJH34Q3UGUGEhoB+MmVpndZIzBoY79iKa6RSEx3zMtx0/C9k7h0u+Fl5c8uTHWODaX+/TszfYu/Ps83yB07JD8pC2zJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790502538; c=relaxed/simple;
	bh=0N09YfjQnytfrMmqji3ExZ4+D2Biz5G2uK3SgMkwFnI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ukCvYm99I4LAuwgpazA2JH58UvIva5ShaDSV6Ctkpz+D+rQetHkPmxJgpyr7BqeqHxN/2MR5diwHOHj5I67kvYgg6qHKJYxLql3DLDxh8RjwgGkkrGORFgRxVSCOnvZupUcJDdZyzgdUCjG+UPyvcuaEs0c8pCTCEeQ6Ptz3zz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaHG2EPc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaHG2EPc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97ABFC2BCB3;
	Sun, 27 Sep 2026 09:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790502537;
	bh=0N09YfjQnytfrMmqji3ExZ4+D2Biz5G2uK3SgMkwFnI=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JaHG2EPc2JDja1JrDblw01EeC6ifrHk4Qe6H+OIqITBVjCASUWn3wPXXsaFpAAi8g
	 rSYedDMguEc9sEtUagUtu4wf0NHfFJc94fIs07m9U+LGqJw0X713yP/AW5arCOqsPM
	 NLdMSHcIf6cj9ltm0inIta+dD0PqbYZOXtwWqGs6XmXX+FYqZdj1hRuRHUFzlLWmQ8
	 43VBMyYqicixTRfVWjHSyergkX6QRUkeIsXh7JmaYbWXpZh2gE2KTXtUPiGGxNUh+G
	 X/EVkwHw4i27rU6TTjACnfkd9NngtZ83ghCzkkR+VpaLY161lKlUdrMmUOLX2cMiJW
	 T8xk6upSCGzjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFB3C9832F;
	Sun, 27 Sep 2026 09:48:57 +0000 (UTC)
From: Henrik Ma Johansson via B4 Relay <devnull+dahankzter.gmail.com@kernel.org>
Subject: [PATCH RFC] io_uring: add IORING_OP_COPY_FILE_RANGE
Date: Sun, 27 Sep 2026 11:48:56 +0200
Message-Id: <20260927-cfr-rfc-v1-0-5b9ddbe0490f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyNz3eS0It2itGRd41RDY7PE5MQ0M5NUJaDqgqLUtMwKsEnRSkFuzkq
 xEMHi0qSs1OQSkBlKtbUAphQPf3AAAAA=
X-Change-ID: 20260927-cfr-rfc-3e136acaf64e
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Henrik Ma Johansson <dahankzter@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4464;
 i=dahankzter@gmail.com; h=from:subject:message-id;
 bh=0N09YfjQnytfrMmqji3ExZ4+D2Biz5G2uK3SgMkwFnI=;
 b=owGbwMvMwCXG83nVLZlv8sKMp9WSGLJ2POt4o3KH8QV/mvbRZTFcFw6aCWq6XFtS69Ancfv2h
 4iHi67XdZSyMIhxMciKKbJcqnFdeI7hRq5jyocEmDmsTCBDGLg4BWAi/cYM/93M/p6NSuZmWRvu
 wHSkLmUe9zunf81fmoTmbIuSZFaaLMLwP1/voLGa6OIfj60OcpUkMHTdMlqxkS+tb7OM1yfWPVP
 msQIA
X-Developer-Key: i=dahankzter@gmail.com; a=openpgp;
 fpr=D27C45A1CE00D86D4164F0600CF3AADA1CF61F13
X-Endpoint-Received: by B4 Relay for dahankzter@gmail.com/default with
 auth_id=1067
X-Original-From: Henrik Ma Johansson <dahankzter@gmail.com>
Reply-To: dahankzter@gmail.com

Hi,

This adds IORING_OP_COPY_FILE_RANGE, a thin io_uring front end for
vfs_copy_file_range(). A liburing helper, man page and test follow
separately.

Why not splice: copy_file_range lets the filesystem choose how to copy.
XFS and Btrfs share extents (reflink); NFS, CIFS and Ceph copy server
side. IORING_OP_SPLICE needs a pipe on one end, so today's io_uring
alternative is two linked splices through a pipe, which always moves
every byte. It has been asked for in liburing issues #831 and #1383.

4 GiB copy + fsync, virtme-ng guest (relative numbers only):

                  this op            two linked splices
  xfs             0.010 s, 0 MiB     3.17 s, 4+ GiB written
  btrfs           0.010 s, 0 MiB     2.29 s, 4.0 GiB written
  ext4            3.27 s             3.22 s   (no reflink; both copy)

On loopback NFSv4.2 the copies show up as nfsd COPY operations.

Semantics are the syscall's: the SQE is packed like splice, -1 offsets
use and advance f_pos, and all checks are vfs_copy_file_range()'s, so
there are no fs/ changes. The length is clamped to MAX_RW_COUNT since
cqe->res is 32 bits.

There's no nonblocking path, so it's always punted to io-wq, like
splice, fallocate and ftruncate. This is not a throughput win: for
cheap reflinks it is 1.6x (xfs) and 1.2x (btrfs) slower than a
synchronous call in my runs, because of the punt.

The point is what the punt buys a userspace runtime. Thread-per-core
runtimes (I'm working on glommio) keep a per-shard blocking thread for
syscalls the ring can't express, and copy_file_range is one of the last
runtime-internal users of it, so user work queues behind runtime copies.
Modelling that with 30 queued 16 MiB copies and a probe task:

                  probe wait, p50     p90
  thread pool     51-83 ms            52-87 ms
  this op         28-40 us            45 us - 0.6 ms

Userspace could split its queues instead (Seastar did), but on the ring
the copy also links with open/fsync/close, completes on the same CQ,
works with fixed files and can be cancelled: queued copies get
-ECANCELED, a running byte copy stops early with a short count. One
caveat: io-wq workers inherit a pinned submitter's CPU mask, which shows
up as ~3 ms tails, so pinned runtimes want IORING_REGISTER_IOWQ_AFF.

Questions I'd like opinions on:

 1. Should a short copy break an IOSQE_IO_LINK chain (as read/write/
    splice do, and as this patch does), or only errors? EOF on the
    source gives a short count in normal use.
 2. audit_skip: set as for the other data transfer ops, since the
    syscall is in no audit class. Right for an op that can allocate
    blocks?
 3. How should this fit with the thread identity handoff RFC? The issue
    path works inline or from io-wq unchanged; cheap reflinks look like
    a good fit for blocking inline issue, long byte copies less so.
 4. Only -ERESTARTSYS is mapped to -EINTR (as in net.c). Would you
    rather reuse rw.c's io_fixup_restart_res()?

Testing: the liburing test passes on xfs, btrfs, ext4, tmpfs and
NFSv4.2, on release and KASAN+lockdep kernels, and checks error parity
with copy_file_range(2). No new failures in the liburing suite. Base:
for-7.4/io_uring at 8dc68de64261.

AI assistance (Documentation/process/generated-content.rst): the patch,
test, man page, benchmarks and this letter were drafted with an LLM
(Claude) in a long interactive session: prior-art research, design,
implementation, and running the tests and benchmarks above. I reviewed
all of it, and I'm responsible for it.

This is my first time submitting a patch to the kernel and while I have
been coding a long time this is still a major milestone. I got the idea
to implement copy_file_range when I was working on glommio that uses
io_uring heavily. We are currently using a thread pool for this and it
works but it kept nagging me in the back of my head until finally I
decided to give it a try.

---
Henrik Ma Johansson (1):
      io_uring: add support for copy_file_range

 include/uapi/linux/io_uring.h |  1 +
 io_uring/opdef.c              | 11 ++++++++
 io_uring/splice.c             | 58 +++++++++++++++++++++++++++++++++++++++++++
 io_uring/splice.h             |  3 +++
 4 files changed, 73 insertions(+)
---
base-commit: 8dc68de64261e599631aa7ed6cdf3aec07c7ae3d
change-id: 20260927-cfr-rfc-3e136acaf64e

Best regards,
--  
Henrik Ma Johansson <dahankzter@gmail.com>


