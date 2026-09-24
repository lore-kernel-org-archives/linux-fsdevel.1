Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D24E3DD51C
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790230731; cv=none; b=awXoSk8UUpZA6qlVIdlonMn283vW16UwW3TUuS4mueo4gn+hLKlhpUs3pUMeSi/c10sI78VCQp8BIciANmwIxtEhvwQttW/WhqKgENf9nRP0d2raZfEKVsZLGqGK/1W3crMMjnOFOmNoKiuyL9VfcVX5w6JkjgJlGtgLVoCFmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790230731; c=relaxed/simple;
	bh=b83+2lVbeQu4Jlvz4EJev7hmuGoJ+aXL0hdjrUishOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=co/ekWlHVmRwRuvYYlWu/N3/cZ1rVfUf1C9uXPTr2URihqIC/L+I3VXk+30jn8LKuIhmqqc7JdOjq8Ms8CeRaH4WfjIKBqnRJnykO6n9UvYvt2y+cpkBqUtZTh+Vfu8r+juCuAC+U27f4hp3bDawiJkLmaYEW5ompLa8TcEnclw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=modal.com; spf=pass smtp.mailfrom=modal.com; dkim=pass (2048-bit key) header.d=modal.com header.i=@modal.com header.b=YETSht64; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=modal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=modal.com header.i=@modal.com header.b="YETSht64"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25400so868446b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 23:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=modal.com; s=google; t=1790230729; x=1790835529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B5AtUb4a1oAHMSq5rmzd2HgfG+8wDisV0MJ3d9oqwKk=;
        b=YETSht64+m/B+0REPMLrLmNu50qGFwBeTd8I62ODplutwlQ/80MIASxyOcV0qmY9j3
         ebs6B9qv8y2Ef4qkRVWaKxX56ayEeN2TKTbggoeNHMp9BT43RmyiFhKMe/1HSABg0BOq
         R9L1RqQErBd27Th9tsz8wbBOvz5iWiX4u/vUeCh1ujtdr1KZle+oitwnubIk1KxDquPh
         KWPac3f5K+Q9KO3UXV44Cn4yG2aiCNcGqMzia169othknhNsH0ksprIT5EqTxKmpD+hE
         4SrZy1jXmxk2Cd5toz6i99viOULIUTMu6UUZqS5FGtG8gXNnYMWzm+mgSrNrg01jQ8WQ
         W1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790230729; x=1790835529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B5AtUb4a1oAHMSq5rmzd2HgfG+8wDisV0MJ3d9oqwKk=;
        b=dSXddfzjiELqsMkjKKtXWI55cvcMAynWgA/8XAOPwcBmRnu3KtdaxbtFPc6GAkn1M+
         V/912WOzifr6/geKJNxflAupMDVWYlbW+2bahfMu7LnP3gDE6EqSWGc12HwpUdkuvUT6
         sc0xVYyYqbU+456CILDZg5Dwd0tFvyRE76Xr0GE6+8l3ZeLWY9Plxb1d/XGT60FNz1Zo
         5heUgIgv42DB6MuuYuxzagSbxSdgEwKN/xTWRuq9EIiJy/OHjMjWVSujiKjLvP6RMRU8
         zz+V4O3OFZom6ldSiyy+UYs0EE69MXxpZSOsFSKGoecu8cLZ2+Fnc0l/D0fIjY6Hss1k
         Lsng==
X-Forwarded-Encrypted: i=1; AKwUvBxEPs6rnTAuanouu0TiOj+vzLyYE6ZL8FEqx5kLgnmFjf6mihYFKtuIQu2zvEZVDu+qrIYndJ9QCt9DWjQ3@vger.kernel.org
X-Gm-Message-State: AFuF++lEdtSASRwiNEZe5gqG4IlbT5HCUfajBPeTpt6YcPBidQlJo/GA
	x/ZsI1ohRvogvfRGAFYqomz3Qjmxlkzm3Fza2+uuoFBUZJfiKCKhcuYHmOdJQxbCQD4=
X-Gm-Gg: AYBFou3RGh00iGdsLDQcR5jtp3dUCZN20G2UawpVZffo85t0gUq6a1lPkJcLWBdbl24
	C+PWAwlEW6s7dQY5mEP7Tg6gFCYFn7huewMe5Ksyo2TW4ytHQ0K8KxpblRif6IbQ98RVSkbSQ3J
	uCi6u58UULDU4dPSQaCW/3OTkIMlcXZ8JTc7+7ejHgVt8iZwSE/Zr74Ryoyo+QluS69l90KKjKi
	zAMfUgwdyKKF6x8d0jly96pJix8IH+W3zxXM4wNGhgheW38268rFQOfEq9d7w/+osnyg4FF5f8h
	21Y7HCtMNFEPtcrY6BvoqGWwl9iIuzMHNuUKJjGNh+xMgp7mlMEwPJ/73W6dlJyaPPaN9BdLstI
	o1pQLmyzMoYWxAvIoH+ceePbh6SE6BSIVOSMtpsPb7SSQSQkEi1PTkxZTGWuE1dNH7C7hpyIxU9
	e8pXOCt8/9LoXvZ/UuGxy3CKtxsD6lIGEY0/Fa3BTYTspUx5KLXeS5AsYIJEeZW0Nvo0njLnBjk
	MlBLhTIRRSg1XCbvjjS+nXY2S/qZABEf+VZOKhlhbkd/VuxSjPI7BJaPQjzd4QPXHXQGmIPZ9Vn
	HJSBCtE2wcLmz4KyGdMRSKh8LlcSPK1S+GJNug==
X-Received: by 2002:a05:6a00:1da5:b0:85f:ae00:9e68 with SMTP id d2e1a72fcca58-87e99e414c3mr1186530b3a.26.1790230729239;
        Wed, 23 Sep 2026 23:18:49 -0700 (PDT)
Received: from devbox-ayushr-01ed.tail5292b.ts.net (ec2-44-242-192-44.us-west-2.compute.amazonaws.com. [44.242.192.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dff9778sm2333101b3a.49.2026.09.23.23.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 23:18:48 -0700 (PDT)
From: Ayush Ranjan <ayushr@modal.com>
To: Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kara <jack@suse.cz>
Cc: Ayush Ranjan <ayushr@modal.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Pedro Falcato <pedro.falcato@gmail.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts page cache / rss counters
Date: Thu, 24 Sep 2026 06:16:21 +0000
Message-ID: <20260924061708.1645968-1-ayushr@modal.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We are seeing shmem/tmpfs page cache corruption on production hosts
running a workload that punches holes in a memfd (hole-punch based
memory reclaim) while other threads and forked children fault the
same MAP_SHARED mapping. The kernel taints but does not oops:

  BUG: Bad page cache in process ...  pfn:...
  page dumped because: still mapped when deleted
  ...
  dentry name(?): "memfd:..."

and, more frequently, a paired rss-counter imbalance when the mm is
torn down, always exactly one PMD-order folio (512 pages):

  BUG: Bad rss-counter state mm:... type:MM_FILEPAGES  val:-512
  BUG: Bad rss-counter state mm:... type:MM_SHMEMPAGES val:512

Seen on 6.12 and 6.18, x86_64, bare metal and VM, with
/sys/kernel/mm/transparent_hugepage/shmem_enabled = always.

This looks like the same corruption Gregory reported in March, which
as far as I can tell stalled without a fix; that report needed ~100
ballooning VMs to reproduce:

  https://patchew.org/linux/20260326162611.693539-1-gourry@gourry.net/

The reproducer at the end of this mail trips it with a single memfd,
no VMs or ballooning, within a few minutes on a large machine, so
hopefully it makes the race easier to confirm (and to test a fix
against).

Here is my best understanding of the race -- corrections welcome:

shmem guards faults against an in-progress hole punch with
inode->i_private: shmem_fault() -> shmem_falloc_wait() waits while
shmem_fallocate(PUNCH_HOLE) holds i_private. But shmem's .map_pages
is the generic filemap_map_pages() (shmem_vm_ops /
shmem_anon_vm_ops), which does not consult i_private and does not
take invalidate_lock, and shmem does not use invalidate_lock to
serialize faults against truncation the way regular filesystems do --
the i_private + waitq scheme stands in for it, but only shmem_fault()
participates in that scheme.

So while shmem_fallocate(PUNCH_HOLE) is between
unmap_mapping_range() and shmem_truncate_range(), a concurrent
fault-around can (re-)install PTEs for folios that are about to be
truncated:

  - filemap_map_pages() samples mm_counter_file(folio) once per batch
    and applies it with add_mm_counter() after mapping; if the
    folio's swapbacked state changes while it is concurrently torn
    down, the map-time counter (MM_FILEPAGES) and the zap-time
    counter (MM_SHMEMPAGES) disagree by exactly one folio -- the
    +/-512 imbalance above.

  - a folio re-mapped in this window (by fault-around directly, or
    via a child VMA whose PTEs copy_page_range() installs after
    unmap_mapping_range() has already walked the i_mmap tree -- the
    dup_mmap() variant discussed in the earlier thread) can be
    deleted from the page cache while still mapped -> "still mapped
    when deleted".

Reproducer
----------

The race is on PMD-order folios, so khugepaged needs to scan
aggressively (with the default 10s scan interval the punched ranges
are not re-collapsed fast enough to reproduce quickly):

  echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
  cd /sys/kernel/mm/transparent_hugepage/khugepaged
  echo 1    > scan_sleep_millisecs
  echo 4096 > pages_to_scan
  echo 511  > max_ptes_none

  cc -O2 -pthread -o repro repro_shmem_punch_race.c
  for i in $(seq $(( $(nproc) / 3 ))); do ./repro 60 & done; wait
  # watch: dmesg -w

On a 112-CPU host this trips within ~2-5 minutes; this capture is
from 6.12.0-204.92.4.4.3.el9uek.x86_64:

  BUG: Bad rss-counter state mm:0000000078314ee0 type:MM_FILEPAGES  val:-512
  BUG: Bad rss-counter state mm:0000000078314ee0 type:MM_SHMEMPAGES val:512

The rss-counter form is the most frequent. The "still mapped when
deleted" form is what we mostly see in production but is rarer under
the reproducer (as in the earlier thread); I do not have a fresh
capture of it to paste here and will follow up with a full splat if I
catch one.

For background: we originally hit this under a memfd-backed sandbox
runtime (gVisor), which reclaims memory by punching holes in a
MAP_SHARED memfd while it is being faulted -- hence the "memfd:..."
dentry in the splats. The reproducer below has no such dependency: it
only uses memfd_create + mmap(MAP_SHARED) + fallocate(PUNCH_HOLE) +
madvise, so this appears to be a plain shmem issue rather than
anything specific to our setup.

Thanks,
Ayush

---- repro_shmem_punch_race.c ----

/*
 * Race FALLOC_FL_PUNCH_HOLE against fault-around on a MAP_SHARED
 * memfd mapping.
 *
 * One memfd is mapped MAP_SHARED into the main process and several
 * forked peer processes. All of them fault (and MADV_DONTNEED,
 * forcing re-fault via fault-around) random windows of the file while
 * the main process punches holes at random offsets. Short-lived
 * fork() children exercise the dup_mmap()/copy_page_range() variant.
 *
 * Usage: ./repro [seconds] [file_MiB] [peers]
 */

#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <stdatomic.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>
#include <linux/falloc.h>
#include <linux/memfd.h>

#define PAGE 4096UL
#define HPAGE (2UL << 20)        /* PMD-order folio */

static unsigned char *map;
static int fd;
static size_t file_sz;
static volatile int stop;
static _Atomic long n_punch;

static inline uint64_t xorshift(uint64_t *s) {
	*s ^= *s << 13; *s ^= *s >> 7; *s ^= *s << 17; return *s;
}
static uint64_t seed(void) {
	struct timespec t; clock_gettime(CLOCK_MONOTONIC, &t);
	return (t.tv_nsec ^ ((uint64_t)getpid() << 20) ^ (uint64_t)pthread_self()) | 1;
}

/* Read a random ~128 KiB span (spanning several fault-around batches), then drop
 * it so the next touch faults again through filemap_map_pages(). */
static void *faulter(void *arg) {
	uint64_t s = seed();
	size_t span = 32 * PAGE;
	while (!stop) {
		size_t off = (xorshift(&s) % ((file_sz - span) / PAGE)) * PAGE;
		volatile unsigned char sink = 0;
		for (size_t o = 0; o < span; o += PAGE)
			sink += map[off + o];
		if (xorshift(&s) & 1)
			madvise(map + off, span, MADV_DONTNEED);
	}
	return NULL;
}

/* Keep folios present for the puncher to race against. */
static void *writer(void *arg) {
	uint64_t s = seed();
	size_t span = 64 * PAGE;
	while (!stop) {
		size_t off = (xorshift(&s) % ((file_sz - span) / PAGE)) * PAGE;
		memset(map + off, 0x5a, span);
	}
	return NULL;
}

/* Punch holes at random offsets, mixing PMD-aligned and unaligned/sub-PMD
 * ranges. */
static void *puncher(void *arg) {
	uint64_t s = seed();
	while (!stop) {
		size_t len, off;
		if (xorshift(&s) & 1) {                    /* unaligned, 4K..2M */
			len = ((xorshift(&s) % 512) + 1) * PAGE;
			off = (xorshift(&s) % ((file_sz - len) / PAGE)) * PAGE;
		} else {                                   /* PMD-aligned, 2M/4M */
			len = ((xorshift(&s) % 2) + 1) * HPAGE;
			off = (xorshift(&s) % ((file_sz - len) / HPAGE)) * HPAGE;
		}
		fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
			  (off_t)off, (off_t)len);
		atomic_fetch_add(&n_punch, 1);
	}
	return NULL;
}

/* dup_mmap()/copy_page_range() variant; bounded to one child per thread. */
static void *forker(void *arg) {
	uint64_t s = seed();
	size_t pages = file_sz / PAGE;
	while (!stop) {
		pid_t p = fork();
		if (p == 0) {
			volatile unsigned char sink = 0;
			for (int i = 0; i < 16; i++)
				sink += map[(xorshift(&s) % pages) * PAGE];
			_exit(0);
		}
		if (p > 0) waitpid(p, NULL, 0);
		else usleep(200);
	}
	return NULL;
}

/* A peer process: maps the same memfd and faults/forks it concurrently. */
static void peer(int secs) {
	pthread_t th[4];
	pthread_create(&th[0], NULL, faulter, NULL);
	pthread_create(&th[1], NULL, faulter, NULL);
	pthread_create(&th[2], NULL, writer,  NULL);
	pthread_create(&th[3], NULL, forker,  NULL);
	sleep(secs + 2);
	_exit(0);
}

int main(int argc, char **argv) {
	int secs  = argc > 1 ? atoi(argv[1]) : 60;
	file_sz   = (argc > 2 ? (size_t)atol(argv[2]) : 64) << 20;
	int peers = argc > 3 ? atoi(argv[3]) : 2;

	fd = memfd_create("repro", MFD_CLOEXEC);
	if (fd < 0) { perror("memfd_create"); return 1; }
	if (ftruncate(fd, file_sz)) { perror("ftruncate"); return 1; }
	map = mmap(NULL, file_sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (map == MAP_FAILED) { perror("mmap"); return 1; }
	madvise(map, file_sz, MADV_HUGEPAGE);   /* request PMD-order folios */
	memset(map, 1, file_sz);

	pid_t pid[64];
	if (peers > 64) peers = 64;
	for (int i = 0; i < peers; i++) {
		pid[i] = fork();
		if (pid[i] == 0) peer(secs);    /* child shares the memfd + mapping */
	}

	enum { NFAULT = 3, NFORK = 1 };
	pthread_t th[NFAULT + NFORK + 2];
	int n = 0;
	for (int i = 0; i < NFAULT; i++) pthread_create(&th[n++], NULL, faulter, NULL);
	for (int i = 0; i < NFORK;  i++) pthread_create(&th[n++], NULL, forker,  NULL);
	pthread_create(&th[n++], NULL, writer,  NULL);
	pthread_create(&th[n++], NULL, puncher, NULL);

	sleep(secs);
	stop = 1;
	for (int i = 0; i < n; i++) pthread_join(th[i], NULL);
	for (int i = 0; i < peers; i++) { kill(pid[i], SIGKILL); waitpid(pid[i], NULL, 0); }
	while (waitpid(-1, NULL, WNOHANG) > 0) {}

	fprintf(stderr, "pid %d: punches=%ld\n", getpid(), atomic_load(&n_punch));
	munmap(map, file_sz);
	close(fd);
	return 0;
}
