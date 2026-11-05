Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906725;
	b=OhmS+r8V6tJhXFW1HJmWQ/pTR/hjtKfWkKSS+CUXMZUEw59uXNlb+DAfmKTXbZnK+U2j
	 dBonfCop7y/xncxt4O9nkKlAVmonLH9QyaH9JDJMK2/ULIBfXrqpKPx6s0sP4temmF+6W
	 Ks+iKJg9xJftLFiPCidj31oNZNgUXp2Oesi0z7oew1zxK0xYMhmxp6hDCbj5Cbs5+JKjE
	 9z7KXJy+MzcD+VTHWpB8opYg23WwhStojyDCnCX/REh7IbsF1gUG4cqnbb2scd+IRNL04
	 fpqeyJcbBwnYmPVw4yPAf/1nCXaWebind7udWXHORXmufP35cGNE8sbuAPA+QljseeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=s4FZg8DsfWmRP296oRW8/FWLLuk54fxztQ3Y/s+Qjl4=;
	b=uHqIMkVGiIjIcF31DwtK9HuPrNV8UiHW3jgAzf98J+iyYTttrfq8NvA1heXN5Luge//8
	 b4Tn3mPIr2PaJl26F+P2H2AdahLKb5lWuMwp5qRtltf53guEhNtL+7apQdbapUDXR8BT9
	 epprIsnGf6fsWaSP5hH0n4yf2kUWRPWmuRGiimKaueBUtIV7gKnButTIc/nTE7Batpmxg
	 azwyyqc6ujIHsFQmmid5ioCzEvfHwKY7gSY/qg57qvTmW8u3SWlHnOy0Qciu/g2nFMIr2
	 XnX2VCxgJuV40h9CZDsF9M1ymCGd3hbFXZBHc4VoZqJ6lgNl/9PoXum00HfApvHHtdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bLCqWOUa;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991C606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 19:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6991C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bLCqWOUa
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso1534301e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 11:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793906724; x=1794511524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4FZg8DsfWmRP296oRW8/FWLLuk54fxztQ3Y/s+Qjl4=;
        b=bLCqWOUaX0uq6AQj9rJdrFqH2vW/Qsze0/0lF8jRGMesKwa0bSZpycJVLKIcb/sZ8F
         1RZ6Nz7ottsGm6HJGlbx8/fvf22sNQCDA1W3XnIFeFQKVgk4CJmIZWET0Td45RHDXHwa
         3QUR8NmaWtgdE0Xxa4jz1R4qXQ/mhnc7UT1efxLctlYvq2/yzTrfFZJqhPaFFDsjjgK1
         tXxafuDjQa0bLv7eth8kQBmoiAvWRA/AIo75VkO37SfPIK9Irqw+HaiEXysotEqTzbft
         /KcsGjO+Ls3W5HUnFjviVg4EzuvJO1Xh3CQVJsYukwla890cgnRJtj071VhKmDsH54GQ
         svTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906724; x=1794511524;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s4FZg8DsfWmRP296oRW8/FWLLuk54fxztQ3Y/s+Qjl4=;
        b=maPTLc74vwyXYoDir3yoS24fbyfa6vR8Cg/l6BFVACZjOaTvAJtAfZR77NafbmfZVF
         zHfou9+mg/WKURlV4XXBp4Bsf/VDG7wJpS2lzxDvyQx4eCun4nOViiB8b4aTctzjRCfw
         0nLSoJM2K7qB+Lb+hAnmejciiK7rC7d0YuHLONUyl7mx9SUFiEJGl+5bi6yPkNPfxWhC
         69wr7xg9l/Zylm29R4BcYM2JsIayYB2cP2eXz4y17MJtvZZ2DFBZ1HDoC2mIWKixRrPb
         zicWIHRSKK4g9RvrtbNaa1whSoDn+o0prlMp4yDSeTeJE5/q9S7G71j4GYwx3H2aV1dJ
         lLGw==
X-Forwarded-Encrypted: i=1; AKwUvBx/uF1nCDZqDilMj8cQCJ1AtIbkctMRY8+NS5W+RreqyspYVQ9mXj5R7mKizZnTOIr6AYFRoxkiOosU5lF8@vger.kernel.org
X-Gm-Message-State: APuU4Z++mV6aOYWNDVhYzlu/dIFHjKKL4vroPjnBaAe0UT91aUZOjwja
	TeKZVlYOUu1HVVd4ni7Zrb9kwVf2WLsuUX08HdH7E6lL6Oam1wMCJayM
X-Gm-Gg: AYBFou2Qv312x4SuftMY43Yg818YYEgTasByGzsFp4As4KOhpzyx1WANholm75GHMI4
	gjmWuxNP5jaOsh79L07MeY5pnF409U2U+SFK4JrzTKeG+OLuPzK80jLck86WYLBTs1nodGyXTZK
	NOUOsOhiVZVCTUZXPC15kXj4kNrCTu0xzvqcn1vkm4dKnl4fIvBDaszfn88nuhbn+MqrxkvX0ju
	KSaGMg6s45OnAAK5oPyU/oxxoB2UJhCtmgLzo6UBNTjJGggE8Xf79cpOBohAWGfBBaMkt4nFJHW
	YPw9/1MpTSoMPMC5D0LuI3rTfB4HyyIaBs0rY4qkPx4jtsq6g560nhzg32fLXE5xmF9M2URGdXA
	l/RmoMT99cDugnar3AstsEH7SkauSoIfnJYHZDNfq9YxDzruJoS6r/xd+zSwnbKYOrj5SZ5OeqJ
	EFZxM2/igCvvrjfCFIIP4KxSxKq/RLLsOLgDcbLCkSK0likOXMnVsXNJjDZDwVXsCp3i2AHW19D
	6QNVk4e2P34GQu5SauM4JnwbaDpSUlTCNC+Y8+G2x/bxkeGPgRX4+gwP8X4UlJ1QYsw7yv9Gm3j
	F7Ue2X+iJm4+chZxypOGDwqVoIZsOLzHTfU4WY0h2TA=
X-Received: by 2002:a05:6512:104d:b0:5ba:356b:5a85 with SMTP id 2adb3069b0e04-5c003ae0858mr15497e87.43.1793906723445;
        Thu, 05 Nov 2026 11:25:23 -0800 (PST)
Received: from localhost.localdomain ([185.65.135.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c0030a3b50sm25897e87.79.2026.11.05.11.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:25:23 -0800 (PST)
From: Trace <tracekotae@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	regressions@lists.linux.dev,
	fujunjie <fujunjie1@qq.com>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Vishal Moola <vishal.moola@gmail.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [REGRESSION] mm/filemap: mmap read-around stays off for an open file after sparse faults, since 7.2
Date: Thu,  5 Nov 2026 20:25:17 +0100
Message-ID: <20261105192517.228523-1-tracekotae@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

since 7.2, once an open file has taken more than MMAP_LOTSAMISS mmap
misses, it gets no more mmap read-around, even if the access then turns
sequential. For a reader that does not run into pages an earlier
read-around brought in, it stays that way until the file is opened
again. Each later page is a synchronous 4 KiB read, which on NFS is a
round trip.

I think it comes from this series:

  0b9c0aeba938 ("mm/filemap: count only the faulting address as a mmap hit")
  9b0fcac3cfe7 ("mm/filemap: do not count FAULT_FLAG_TRIED retries as mmap hits")

I have not bisected or built a revert. By reading mm/filemap.c, v7.1
and the current 6.18.y have the old accounting and v7.2 onwards the new.
I measured 7.3.1 and 6.18.60, and the program below also gives 16384
on 7.2.14 (with the zen patches) on a SATA SSD. do_sync_mmap_readahead()
and do_async_mmap_readahead() are unchanged from v7.3 in next-20261103
and in mm-unstable, mm-hotfixes-unstable and mm-new of 2026-11-03.

As I read it: above MMAP_LOTSAMISS, do_sync_mmap_readahead() returns
without reading, and mmap_miss only goes down on a hit. With no
read-around the next page is not in the cache, so the next fault is
another miss, and nothing lowers the counter again. Before the series,
the retry after each read-around counted the pages it had just brought
in, so a sparse reader did not reach the limit. The series' tests run
random, stride and sequential access each on its own, not one after
another on the same open file.

The program below writes a 2600 MiB file, drops it with
POSIX_FADV_DONTNEED, touches 2000 pages 1 MiB apart through a private
mapping, then reads 64 MiB sequentially and counts major faults. x86_64,
4 KiB pages, read_ahead_kb 128, ext4, plenty of free memory (7.3.1 on
NVMe, 6.18.60 on a SATA SSD):

                                          7.3.1   6.18.60
  sequential only                             1         1
  sparse pass, then sequential            16384         1
  sparse, MADV_SEQUENTIAL, sequential       512       512
  sparse, close and reopen, sequential        1         1

The same pattern in a Python version, on 7.3.1, on NFS v4.2 over 1 GbE
through WireGuard: 80-90 MiB/s with no sparse pass, 5.7 MiB/s after it.

How I met it: PyTorch loading a model from safetensors on NFS, on a
Radeon AI PRO R9700 with ROCm, where the driver faults in the mapping:

  folio_wait_bit_common
  nfs_do_read_folio
  nfs_read_folio
  filemap_read_folio
  filemap_fault
  __do_fault
  do_fault
  __handle_mm_fault
  handle_mm_fault
  hmm_range_fault_locked
  amdgpu_hmm_range_get_pages
  svm_range_validate_and_map
  svm_range_set_attr
  kfd_ioctl

safetensors maps the whole file (torch.UntypedStorage.from_file,
MAP_PRIVATE) and builds one tensor view per entry, which takes one
read fault per tensor, mostly on its last page. A model file holds
hundreds of tensors spread over the file, so mmap_miss passes
MMAP_LOTSAMISS within a few seconds of the mmap, before any weight is
read (bpftrace on filemap_fault, reading file->f_ra.mmap_miss). The
GPU driver then faults the weights in through the same mapping, every
page a synchronous 4 KiB nfs_read_folio, about 1800 a second.
Read-around came back only when the GPU's walk happened to continue
through a window that one of the first hundred faults had read around:
async readahead restarted there, and about 900 hits later mmap_miss was
under the limit again. With the page cache cold, one model's first
picture took 700 s on 7.3.1, 512 s of it below 10 MB/s, against 239 s
on 6.18; a larger model's first run took 54 minutes against 13.

Is read-around meant to stay off for the life of the open file once the
limit is passed? I have no patch to offer.

#regzbot introduced: v7.1..v7.2

Thanks,
Trace

---8<--- mmap-ra.c
/*
 * mmap-ra.c: does a sparse first pass turn off mmap read-around for the
 * rest of an open file?
 *
 *   gcc -O2 -o mmap-ra mmap-ra.c && ./mmap-ra /path/on/a/disk/testfile
 *
 * Writes a 2600 MiB file (removed at the end), drops it from the page
 * cache with POSIX_FADV_DONTNEED, and counts major faults for a 64 MiB
 * sequential read through a private mapping.
 */
#define _GNU_SOURCE
#include <err.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <unistd.h>

#define MIB	(1UL << 20)
#define SIZE	(2600 * MIB)
#define SPARSE	2000		/* single pages, 1 MiB apart */
#define SEQ_OFF	(2100 * MIB)
#define SEQ_LEN	(64 * MIB)

static long majflt(void)
{
	struct rusage ru;

	getrusage(RUSAGE_SELF, &ru);
	return ru.ru_majflt;
}

static char *open_map(const char *path, int *fd)
{
	char *m;

	*fd = open(path, O_RDONLY);
	if (*fd < 0)
		err(1, "open");
	m = mmap(NULL, SIZE, PROT_READ, MAP_PRIVATE, *fd, 0);
	if (m == MAP_FAILED)
		err(1, "mmap");
	return m;
}

static void run(const char *path, const char *name, int sparse, int advice,
		int reopen)
{
	long page = sysconf(_SC_PAGESIZE), before;
	volatile char sink;
	unsigned long off;
	char *m;
	int fd;

	fd = open(path, O_RDONLY);
	if (fd < 0)
		err(1, "open");
	if (posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED))
		errx(1, "posix_fadvise");
	close(fd);

	m = open_map(path, &fd);
	if (sparse)
		for (off = 0; off < SPARSE; off++)
			sink = m[off * MIB + 37 * page];
	if (advice && madvise(m, SIZE, advice))
		err(1, "madvise");
	if (reopen) {
		munmap(m, SIZE);
		close(fd);
		m = open_map(path, &fd);
	}

	before = majflt();
	for (off = SEQ_OFF; off < SEQ_OFF + SEQ_LEN; off += page)
		sink = m[off];
	printf("%-40s %6ld major faults\n", name, majflt() - before);

	(void)sink;
	munmap(m, SIZE);
	close(fd);
}

int main(int argc, char **argv)
{
	static char buf[MIB];
	unsigned long i;
	int fd;

	if (argc != 2)
		errx(2, "usage: %s FILE", argv[0]);

	fd = open(argv[1], O_WRONLY | O_CREAT | O_EXCL, 0600);
	if (fd < 0)
		err(1, "create");
	memset(buf, 0x5a, sizeof(buf));
	for (i = 0; i < SIZE / MIB; i++)
		if (write(fd, buf, MIB) != (ssize_t)MIB)
			err(1, "write");
	if (fsync(fd))
		err(1, "fsync");
	close(fd);

	setvbuf(stdout, NULL, _IOLBF, 0);
	run(argv[1], "sequential only", 0, 0, 0);
	run(argv[1], "sparse pass, then sequential", 1, 0, 0);
	run(argv[1], "sparse, MADV_SEQUENTIAL, sequential", 1, MADV_SEQUENTIAL, 0);
	run(argv[1], "sparse, close and reopen, sequential", 1, 0, 1);

	unlink(argv[1]);
	return 0;
}
