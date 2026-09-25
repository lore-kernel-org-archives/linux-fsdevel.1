Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58DC418346
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 06:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319020; cv=none; b=X66ut1XLph2szPNXMR/RAdkznVFPxXswBsGkOnd4adZeOCzXAHTFMreWCbhEZo2D2VDDItyfXrVsKOwun3FHEL1Zy/uESk8/ZTdGl5AzNciwKzzvS6BWfl3TKr07UBOYicrAY27tX5L5e2j4cW1ocM8ZvKumhWybiyd7Z8qAidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319020; c=relaxed/simple;
	bh=GvReiu1FlNVvKhKU781NY+wh2lMMcZAHeXJ40l8/fPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAEeZK0iGK8kmDFY/cKrbo/y7cIU113GUoywEhF7uefNnBaWUh4N7LXqlMkn2T6Zyw0+ykxtVTUD7yag60JzId9iLD83v2fa2yYsmczVijxA3NHFJBRe92Adj/9Ejx9VdyMlI+/bHzZFzN5anTBjY0tboDkRw5WY78Yc/WfMDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=modal.com; spf=pass smtp.mailfrom=modal.com; dkim=pass (2048-bit key) header.d=modal.com header.i=@modal.com header.b=NMMDAR/F; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=modal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modal.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=modal.com header.i=@modal.com header.b="NMMDAR/F"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bec20a6fso107506a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 23:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=modal.com; s=google; t=1790319018; x=1790923818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o2MOlqC3CqQeIkJJQSE5ZBko91IuDQ76O2zDmJDbjzA=;
        b=NMMDAR/FpIzHnVu1/XFC3hYr1J59i9lVBCB7g+Kr3B/8GZN7ICGt84VvoQNXcxWInZ
         IZEF7CEWi540vtBXIybqY6FC348JHwdp5Zy/j7Z6UU4FEEi62rl2rOcal9oebrG9g0eA
         iAwjAg8gO0V3gajK1HJRqYvHihJaCfNKXJBDOCGOC/1VhTHrtWbjgQDp7N3/0xmGHNJX
         vNgoFR7s5ktupCXR0bi22ZZIA0iYv1UyfvlAjSopouY/TzFWTyBuy+y3mpKfgLCYOZ7J
         0zxKzV+5WqnAmXBc3i8sbAeawRWvSBIWBDs3w03iNOeFNFgY9E55yEMkmD32+JFeM2jW
         kzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790319018; x=1790923818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o2MOlqC3CqQeIkJJQSE5ZBko91IuDQ76O2zDmJDbjzA=;
        b=P3UYWK5790x1HO0A2gtxT+XN4SyFk9qEzAeA5o3+n++5tnZYkRwor3PLNV4Omwu0XG
         6DliT8rEnEDyUgQbTh1sC4B9h4E+VnJXEgnCljcObFhi0Bys4hUNb50xIYiFljT1n5RM
         c6iKgsO4WOemPtLQtBVZgcSNw6UJRfGK4JDqbCFaKwPo954vS7q3Ki2XGfiRA7bdAOwN
         +ucgOl0tvx53in7PwvPdoTdyKxs4R0nXXRwtt+O6Jullu3QgsF/0+tjS1w6aisccM4ma
         ZtAr6FXiTo2SV1roxnmRMWq/J4G+lqhwphwdneznTmHdRIuHl9kGrl8oYXAjx02diHWk
         hViA==
X-Forwarded-Encrypted: i=1; AKwUvBwlML0d3ichAVQ9/lSQas9chQU+nXNLSNju/rnx078fyhWUpamze/iMsA3fDgteIjlgodpYxi8mvY4G8y9Q@vger.kernel.org
X-Gm-Message-State: AFuF++nYKHfkRWVWjTstgP0WdNqXtXJvB4IiN9HP/SYt1csLwoztL7aD
	U7MGmf5HFwLyBAE0ATNgV1e2WPCkvZOMREMNp8cg9R1H8USfV/o40lkLDSrR78BU/l4=
X-Gm-Gg: AYBFou2EA7p/ucB+yBkWrvFd90jh44OjfMUcvoiEb1T+xu8FIR8SHnjEZq4Sr2o/tC6
	X6zkllT1zkaHXSW9JtHPm2GytoJsrN6VNz8cEGrU9Fyzzv9Gmlmj2b9jJuegQADsInP+PngjoQp
	8D728xRM8qBrsvvXi/mk62jmY087yVaWn6EhOULzj2bWzDbqEGDS5jLYJBrHM/i2iCAX5krFc6M
	/QGHcONufieWr0zE+ytGP3ACWkUAfHIA4U9TTxk4CdPMPwG6NirRbX2fCRKXRVSgpqD4c/NFbYM
	SabYgRRSg3HVKSUG1D/ueRBV6aLVDsLKKsKwt2nfjIspFC0LVcYMPDZSV93OekfIIZfSzHPg/2i
	cHfaZP5hNxDj0B6AlMLdZlch8oNCkuRoRlZK/w4CniX2uuIaNCHAV1V6ZjZxhfwhkHulT0AuS5T
	6uiGm5Mg151/yLRkQ/TNiIfPWHZnxYBhY8c0n2ltXRyuqm2PrIuOlSSq3/ueFPljVQrOfr7EHnE
	gg5T3n4WPp7/AeSD8IJsBGcUNKRJUotGqfVC7vulCfCerNbUmSBnDn788AhMArcRqZxWObkMc0J
	rmaiOS3+/5uNOjJos0aXyXTS1U8CxRFumwRN4kSV1KOVevmR
X-Received: by 2002:a17:90a:da8e:b0:3a0:34a4:187e with SMTP id 98e67ed59e1d1-3a09865216bmr2874283a91.15.1790319017911;
        Thu, 24 Sep 2026 23:50:17 -0700 (PDT)
Received: from devbox-ayushr-01ed.tail5292b.ts.net (ec2-44-242-192-44.us-west-2.compute.amazonaws.com. [44.242.192.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b898cabesm2713563a91.0.2026.09.24.23.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:50:17 -0700 (PDT)
From: Ayush Ranjan <ayushr@modal.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Ayush Ranjan <ayushr@modal.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jan Kara <jack@suse.cz>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts page cache / rss counters
Date: Fri, 25 Sep 2026 06:50:10 +0000
Message-ID: <20260925065013.3682431-1-ayushr@modal.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260925053027.1998394-1-ayushr@modal.com>
References: <20260924061708.1645968-1-ayushr@modal.com> <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net> <20260925053027.1998394-1-ayushr@modal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Sep 25, 2026 at 05:30 +0000, I wrote:
> The standalone reproducer, however, has so far only triggered the
> rss-counter one, and only on the UEK8 kernel. Not on our 6.18.46
> hosts, and it has never triggered the "Bad page cache" one for me.
> So it clearly does not capture everything the production workload
> does.

Following up: a reworked reproducer (at the end of this mail) now
triggers the "Bad page cache ... still mapped when deleted" bug on
6.18.46 (plus 31c1d19ead2c "writeback: use a per-sb counter to drain
inode wb switches at umount"). The new reproducer typically works
within 2 minutes on a 128-CPU box. It also still produces the
rss-counter imbalance when the process exits.

Two changes over the previous version made the difference:

  1. Every punch now forces a partial-folio split: it punches
     [pmd_start, pmd_start + k * PAGE) with 1 <= k < 512 (PMD-aligned
     start, mid-PMD end), which sends the straddling huge folio
     through truncate_inode_partial_folio() and a folio split.

  2. Fault-around is steered at just-punched ranges: the punching
     thread publishes the PMD index it just punched into a small
     shared ring, and the faulting threads preferentially read across
     those PMDs, so filemap_map_pages() keeps re-installing PTEs over
     the range being torn down.

Two data points from this version:

  - fork() is not needed: a single-process variant (one memfd, one
    MAP_SHARED mapping, faulting threads plus one punching thread)
    trips it as well, so the dup_mmap() angle can be ruled out
    entirely.

  - it still strictly requires shmem_enabled=always plus aggressive
    khugepaged (scan_sleep_millisecs=1, pages_to_scan=4096,
    max_ptes_none=511); with default khugepaged settings it does not
    trip within 150s. The constant re-collapse of punched ranges back
    into PMD folios is essential.

Pedro: I think this is consistent with your folio-lock point. Both
mapping and truncation do hold the folio lock, but not across the
whole punch: on a partial punch, truncate_inode_partial_folio()
splits the straddling folio, and the sub-folios inside the hole are
only removed by shmem_undo_range()'s subsequent lookup pass. In
between, they sit unlocked in the page cache, where
filemap_map_pages() -- which, unlike shmem_fault(), knows nothing of
the shmem_falloc guard -- can lock and map them; the later removal
then finds them mapped.

Baolin: given the above, this version may be worth another try on
v7.3-rc1 with the khugepaged settings applied; I would expect the
same behaviour there but have only verified 6.18 so far.

Run recipe (same as before, plus alloc_sleep_millisecs):

  echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
  cd /sys/kernel/mm/transparent_hugepage/khugepaged
  echo 1    > scan_sleep_millisecs
  echo 1    > alloc_sleep_millisecs
  echo 4096 > pages_to_scan
  echo 511  > max_ptes_none

  cc -O2 -pthread -o repro shmem_punch_fault_race.c
  for i in $(seq $(( $(nproc) / 4 ))); do ./repro 120 & done
  # watch: dmesg -w

Thanks,
Ayush

---- shmem_punch_fault_race.c ----

// SPDX-License-Identifier: GPL-2.0
/*
 * Reproducer: shmem/tmpfs hole-punch vs fault-around race on huge
 * folios ("BUG: Bad page cache ... still mapped when deleted").
 *
 * One memfd, mapped MAP_SHARED. The punching thread punches
 * [pmd_start, pmd_start + k * PAGE), 1 <= k < 512, to force a split
 * of the straddling huge folio, and publishes the punched PMD index
 * to a shared ring; faulting threads read across recently punched
 * PMDs so fault-around re-populates them. Peer processes only
 * accelerate the race: a single process suffices.
 *
 * Usage: ./shmem_punch_fault_race [seconds] [file_MiB] [peer_procs]
 */
#define _GNU_SOURCE
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

#define PAGE		4096UL
#define HPAGE		(2UL << 20)		/* PMD-order folio */
#define PMD_PAGES	(HPAGE / PAGE)		/* 512 */

/* Shared across all peer processes; steers faulters onto just-punched PMDs. */
struct ctl {
	_Atomic uint64_t hot[64];		/* recently punched PMD indices */
	_Atomic uint64_t seq;
	_Atomic long n_punch;
	volatile int stop;
};

static unsigned char *map;
static int fd;
static size_t file_sz, n_pmd;
static struct ctl *ctl;

static inline uint64_t xs(uint64_t *s)
{
	*s ^= *s << 13; *s ^= *s >> 7; *s ^= *s << 17; return *s;
}
static uint64_t seed(void)
{
	struct timespec t;
	clock_gettime(CLOCK_MONOTONIC, &t);
	return (t.tv_nsec ^ ((uint64_t)getpid() << 20) ^
		(uint64_t)pthread_self()) | 1;
}
static void push_hot(uint64_t pmd)
{
	uint64_t i = atomic_fetch_add(&ctl->seq, 1) & 63;
	atomic_store(&ctl->hot[i], pmd + 1);		/* 0 == empty */
}
static uint64_t pick_hot(uint64_t *s)
{
	uint64_t v = atomic_load(&ctl->hot[xs(s) & 63]);
	return v ? v - 1 : (xs(s) % n_pmd);
}

/* Read across a (recently punched) PMD so fault-around re-populates it, then
 * drop it to force the next touch to fault in again through map_pages. */
static void *faulter(void *a)
{
	uint64_t s = seed();
	while (!ctl->stop) {
		uint64_t p = pick_hot(&s);
		size_t base = p * HPAGE;
		volatile unsigned char sink = 0;
		for (size_t o = 0; o < HPAGE; o += PAGE)
			sink += map[base + o];
		(void)sink;
		if (xs(&s) & 1)
			madvise(map + base, HPAGE, MADV_DONTNEED);
	}
	return NULL;
}

/* Keep PMD folios present and dirty so the puncher always has one to split. */
static void *writer(void *a)
{
	uint64_t s = seed();
	while (!ctl->stop) {
		uint64_t p = xs(&s) % n_pmd;
		memset(map + p * HPAGE, 0x5a, HPAGE);
	}
	return NULL;
}

/* Punch [pmd_start, pmd_start + k*PAGE), 1 <= k < 512: forces a folio_split()
 * of the trailing partial PMD folio. Occasionally drop a whole PMD to keep the
 * allocator/khugepaged churning fresh huge folios. */
static void *puncher(void *a)
{
	uint64_t s = seed();
	while (!ctl->stop) {
		uint64_t p = xs(&s) % n_pmd;
		size_t off = p * HPAGE, len;
		if (xs(&s) % 4 == 0)
			len = HPAGE;
		else
			len = (1 + (xs(&s) % (PMD_PAGES - 1))) * PAGE;
		fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
			  (off_t)off, (off_t)len);
		push_hot(p);
		atomic_fetch_add(&ctl->n_punch, 1);
	}
	return NULL;
}

static void peer(int secs)
{
	pthread_t t[4];
	pthread_create(&t[0], NULL, faulter, NULL);
	pthread_create(&t[1], NULL, faulter, NULL);
	pthread_create(&t[2], NULL, faulter, NULL);
	pthread_create(&t[3], NULL, writer,  NULL);
	sleep(secs + 2);
	_exit(0);
}

int main(int argc, char **argv)
{
	int secs   = argc > 1 ? atoi(argv[1]) : 120;
	file_sz    = (argc > 2 ? (size_t)atol(argv[2]) : 256) << 20;
	int peers  = argc > 3 ? atoi(argv[3]) : 3;

	file_sz = (file_sz / HPAGE) * HPAGE;
	n_pmd = file_sz / HPAGE;

	ctl = mmap(NULL, sizeof(*ctl), PROT_READ | PROT_WRITE,
		   MAP_SHARED | MAP_ANONYMOUS, -1, 0);

	fd = memfd_create("runsc-memory", MFD_CLOEXEC);
	if (fd < 0) { perror("memfd_create"); return 1; }
	if (ftruncate(fd, file_sz)) { perror("ftruncate"); return 1; }
	map = mmap(NULL, file_sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if (map == MAP_FAILED) { perror("mmap"); return 1; }
	madvise(map, file_sz, MADV_HUGEPAGE);
	memset(map, 1, file_sz);

	pid_t pid[64];
	if (peers > 64) peers = 64;
	for (int i = 0; i < peers; i++) {
		pid[i] = fork();
		if (pid[i] == 0) peer(secs);
	}

	pthread_t t[5];
	int n = 0;
	pthread_create(&t[n++], NULL, faulter, NULL);
	pthread_create(&t[n++], NULL, faulter, NULL);
	pthread_create(&t[n++], NULL, faulter, NULL);
	pthread_create(&t[n++], NULL, writer,  NULL);
	pthread_create(&t[n++], NULL, puncher, NULL);

	sleep(secs);
	ctl->stop = 1;
	for (int i = 0; i < n; i++) pthread_join(t[i], NULL);
	for (int i = 0; i < peers; i++) { kill(pid[i], SIGKILL); waitpid(pid[i], NULL, 0); }
	while (waitpid(-1, NULL, WNOHANG) > 0) {}

	fprintf(stderr, "pid %d: punches=%ld\n", getpid(),
		atomic_load(&ctl->n_punch));
	return 0;
}
