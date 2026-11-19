Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=63.250.43.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795060705;
	b=J6zYUYdWPUDhHzLC1GhHzJFpO9Lm0OEostUKLIoZkJy/jNQx3BWRU11V/PjepP7OatZH
	 ABHiSyDPxRTbvg/6P7ek8VnQeYWuiQZkxrETiXq/hjuBjELcysnLfxCARIbi9vMTdLF1u
	 PF0r78xh0qPrG7Zz7K/KOWucYcOgsfSKQa4yDBqRM/LdZlEF7p8zOWocH6CHo5V57yOgs
	 3GSNcR4lc+/fDrpBif2P79+w50kUXkAVW3WboiJ5WZuzyU4Fl7OPNvJ/WJVMiWy3yDeyx
	 +KwSJjtmWQpNZurB1S727JqvEs76SjumXcdJEg8ZWwt+zgGmu4+jArz+uEfrc7M0kwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795060705;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=3ZgBWWFyiN7Y7ggxmL9phbyLLGbEvqOZM9Wb7bl0Q2Q=;
	b=3FI1QAaG7/t+1OaINdgGZyoDXogIK0LFGloKgv5cvKmDdXIqrlS+H8e/Ps6urzXihneu
	 PMvNGtoLNze521buYA+EVOTK9xIHB/JEEoVbsb/iFXReU3LzZ1stM5Yh3BFP1GCgCkDF5
	 F7onHldPLHrIkwIfIVPIDXVFbRT3pmToB0VeOXod7bfZ1Xr/EyL9zDBQ/4LYFSB+2ZeSK
	 FNmQcq4c5+lcMFZZGj61lhhPhy3O4HN7Th/AuMt3dLrZTcdnwMiDNmvGSLMKBZ2EmOBwT
	 kkvpgQvQ9jvpf3HAIvpo7ABfYdTwnQaxGe8mh+DH4/hTA+re0wyMxFOG8apyJwEA5JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=BE0J9RGv;
	arc=none smtp.remote-ip=63.250.43.97
Received: from out-2uec-a97.jellyfish.systems (out-2uec-a97.jellyfish.systems [63.250.43.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95A606A320
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 03:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A95A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=BE0J9RGv
Received: from fedora (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jVPnz3HtXz6tkK;
	Thu, 19 Nov 2026 03:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1795060697;
	bh=3ZgBWWFyiN7Y7ggxmL9phbyLLGbEvqOZM9Wb7bl0Q2Q=;
	h=From:To:Cc:Subject:Date:From;
	b=BE0J9RGvC7X0KzuOzUjkcXuSN9kIukq2QpfEtdjBfS0+XzjFGa3r23AGKuJFzDss9
	 inlPVDaPfxPXDb+hBPQkwMGyEcme0lUSq1/5yTGV/NegE0RM8l0CPUHv/IDLX/mh+f
	 Fpy7l7Lgx3GWiI5Z3CuP/yIBXfZWyizr84Hy8e0TSa0aaC9fbswFsQ8fu3ipAv2U47
	 i1N35DQjg9FjCHaQgP0G0dJtAvYpIia340wrdo6zi/McFheZOagkj46mKuRV2Zkk6q
	 KjErmKQPiisfEuNlCjIFJtyZ6N5JZ3Gu+2eI+tj2LvCs2GHxQedtPh94LhFTqrdeYp
	 NswBz/z+e2s4w==
From: Tianyi Chen <hi@tychen.cc>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	hi@tychen.cc
Subject: mm/filemap: plain buffered read evicts a folio left by RWF_DONTCACHE
Date: Thu, 19 Nov 2026 12:58:08 +0900
Message-ID: <20261119035808.431204-1-hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Envelope-From: hi@tychen.cc

Hi Jens,

On current mainline (4405c18c95d2, after v7.4-rc3), a plain pread() can
evict the page it just read if another reader brought that page in with
RWF_DONTCACHE.

On ext4 I opened a cold file twice. A read the first 64 KiB with
RWF_DONTCACHE and closed its fd. B then read the next 4 KiB, which
readahead had brought in for A but A never read. The page was resident
before B's read and gone afterwards, so B's next read of it went to the
device again.

As a control, A did a plain read and then FADV_DONTNEED on the 64 KiB
it had read, so both runs had the same mincore() bitmap before B
started. In that case B's read left the page in the cache.

When B read the 48 prefetched pages sequentially three times, its
second pass over those 192 KiB issued 432 KiB of device reads (5
requests), against none in the control. The third pass did no I/O in
either case. The results were the same in five runs in an x86-64 KVM
guest. Pages that were cached before the uncached reader started were
not affected in my tests: with a warm SQLite query running next to an
RWF_DONTCACHE scan, the query thread did no extra reads.

On a cached lookup, __filemap_get_folio_mpol() clears dropbehind unless
FGP_DONTCACHE is set. filemap_get_read_batch() doesn't, and
filemap_read() still calls filemap_end_dropbehind_read() on the folios
in the batch. In the v8 FGP_DONTCACHE patch you noted that when there
are competing uncached and cached users of a folio, "it should not get
pruned":

  https://lore.kernel.org/all/20241220154831.1086649-13-axboe@kernel.dk/

Should a plain buffered read hit clear dropbehind as well?

A reproducer is below. Run it with python3 in a writable directory on
ext4 with 4 KiB pages. On this tree it prints after=0 for the
RWF_DONTCACHE run and after=1 for the plain run.

Thanks,
Tianyi

Assisted-by: LLM

---8<---
#!/usr/bin/env python3
"""Use an empty temporary file per arm on an RWF_DONTCACHE-capable regular filesystem."""
import ctypes
import mmap
import os
import tempfile
import time

P = os.sysconf('SC_PAGESIZE')
assert P == 4096, 'example uses 4 KiB pages'
count = 1024
libc = ctypes.CDLL(None, use_errno=True)
def resident(m):
    v = (ctypes.c_ubyte * count)()
    addr = ctypes.addressof(ctypes.c_char.from_buffer(m))
    if libc.mincore(ctypes.c_void_p(addr), ctypes.c_size_t(len(m)), v):
        raise OSError(ctypes.get_errno(), 'mincore')
    return bytes(x & 1 for x in v)

def run(flag):
    with tempfile.NamedTemporaryFile(dir='.') as f:
        f.write(b'x' * (P * count)); f.flush(); os.fsync(f.fileno())
        os.posix_fadvise(f.fileno(), 0, 0, os.POSIX_FADV_DONTNEED)
        with open(f.name, 'rb', buffering=0) as b, mmap.mmap(
                b.fileno(), 0, access=mmap.ACCESS_COPY) as m:
            assert not any(resident(m)), 'fixture not cold'
            with open(f.name, 'rb', buffering=0) as a:
                buf = bytearray(16 * P)
                assert os.preadv(a.fileno(), [buf], 0, flag) == len(buf)
                if not flag:   # Match residency, without advising the target.
                    os.posix_fadvise(a.fileno(), 0, len(buf), os.POSIX_FADV_DONTNEED)
            time.sleep(.05)
            before = resident(m)
            target = before.find(b'\1', 16)
            assert target >= 16, 'no prefetched target outside A read'
            assert os.pread(b.fileno(), P, target * P) == b'x' * P
            after = resident(m)
            print(f'A flags={flag:#x} page={target} before=1 after={after[target]}')
            return before, target

dc = run(0x80)  # RWF_DONTCACHE
ordinary = run(0)
assert dc == ordinary, 'initial page-cache residency or target did not match'
