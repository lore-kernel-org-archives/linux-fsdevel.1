Received: from cvsmtppost09.nm.naver.com (cvsmtppost09.nm.naver.com [114.111.35.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE83161A2
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784954078; cv=none; b=req8OwjSXAoNo+MtcMfJwhvGvKsNUHF/BkDBQj2NtwSEWlGMtiEFjlZfoKHg9gIiFh5jtNP2xQHOGtkISEyOSz8fJLapf49INdX3j+EpHB+Jl4vYuEPUBqBZ4Adzm5/qkDNluGqO92u6zcZgrCfNRMa/ZpwfmL9DJz7zFDk6M9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784954078; c=relaxed/simple;
	bh=sWmUbleJnz97/WRXbVIO7Snfbly2ab07fCGYRcR0CsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oya07gpM1LT6YAKervYYn45cfGrdMMEgEIXl21e3wID1GCtQygMnzXo8S1fqXqydyPjTZGPALyO7Az3cmU55aKI6GL9If8894FEtzTVN1PbuLXCYG2LCiLzEd0BbdVonF/U2tcSW3M67hhjzDuJsCWtV1TQICiNjxwxghHLaBbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=b52Wi5c/; arc=none smtp.client-ip=114.111.35.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="b52Wi5c/"
Received: from cvsendbo006.nm ([10.112.20.43])
  by cvsmtppost09.nm.naver.com with ESMTP id G4fHtilZTOi5MbyNCgXtNQ
  for <linux-fsdevel@vger.kernel.org>;
  Sat, 25 Jul 2026 04:24:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1784953467; bh=sWmUbleJnz97/WRXbVIO7Snfbly2ab07fCGYRcR0CsM=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=b52Wi5c/WZY6ZlcL79fj9WB0SLQcyF5mzADOA7f8b9UOfuTEtVePLxrro9pntUk78
	 ceJinZiVK4DyRYDmhTdzW4bW4IA7otDe3MhNvyshR7EvoKcnE+xJBMJlml+oD5WUeK
	 E5RH1J/ZOf1RxbuJlc5wXeW2y1gPS9J6XzhQNwAaXRpOwbz5m6Xs5V/Yi3wusVLkh9
	 wmfci5z9eL1fZI96/T6nMpW3aZ0GizwCoTDHuxVMBI9woTL1+LCwqXWtTciE4fW1Os
	 S5k6H8P/5GhIR5iPngPlVdcuyWE/OC0fP7m043tnSj2qjbbUiQbnB+BcmVToMFqxcL
	 kRqo6o539shAg==
X-Session-ID: VeMF1g16R2aHt74Uh1s66A
X-Works-Send-Opt: rP+8W4eXjHwYKBm9FAF9FNmwKo2mKqErKqb/jJIFjAJYKg==
X-Works-Smtp-Source: fZbZaxt/FqJZ+HmrFogw+6E=
Received: from bl4ckhyun.localdomain ([111.118.38.2])
  by cvnsmtp006.nm.naver.com with ESMTP id VeMF1g16R2aHt74Uh1s66A
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 25 Jul 2026 04:24:26 -0000
From: Hyeontae Lee <wonju345@naver.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: zzzccc427@gmail.com,
	baijiaju1990@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyeontae Lee <wonju345@naver.com>
Subject: [BUG] ntfs: data race on ni->mrec between resident read path and MFT record mutation
Date: Sat, 25 Jul 2026 13:24:21 +0900
Message-ID: <20260725042421.109599-1-wonju345@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

KCSAN reports a data race in fs/ntfs on base_ni->mrec between the resident
read path, which does not take ni->mrec_lock, and MFT record mutation which
does. Reproduced on mainline 7.2-rc4
(48a5a7ab8d6ab7090564339e039c421f315de912).

This is close to

  https://lore.kernel.org/all/20260626014706.2840003-1-zzzccc427@gmail.com/
  [PATCH] ntfs: serialize read iomap lookup with mrec_lock

but that patch targets a slab-use-after-free on base_ni->attr_list and
guards its locking with NInoAttrList(base_ni). The race here is on ni->mrec
itself and reproduces on a 16-byte resident file that has no $ATTRIBUTE_LIST
at all, so neither that guard nor the per-inode attr_list rwsem discussed as
its replacement would cover it.

The read path reaches the MFT record buffer via

  ntfs_read_iomap_begin_resident() -> ntfs_attr_lookup() -> ntfs_attr_find()

map_mft_record() only does atomic_inc(&ni->count) and does not take
ni->mrec_lock, so ntfs_attr_find() walks the record - reading each
attribute's ->length to advance the pointer - with no serialization against
a writer that holds mrec_lock and memmove()s the same buffer.

In fs/ntfs/iomap.c, all 15 occurrences of mrec_lock are in the write paths;
the read paths have none. The resident write path in particular holds it
from __ntfs_write_iomap_begin() through ntfs_write_iomap_end_resident(),
i.e. across the whole iomap operation, for the same IOMAP_INLINE pointer
into ni->mrec that the read path sets up without any lock.

The non-resident read path does take down_write(&ni->runlist.lock) around
ntfs_attr_vcn_to_rl(), but that protects ni->runlist.rl, not ni->mrec.
ntfs_attr_record_resize(), ntfs_attr_record_rm(), ntfs_make_room_for_attr(),
ntfs_resident_attr_record_add() and fs/ntfs/namei.c never take runlist.lock,
so those two paths hold disjoint locks.

KCSAN on 7.2-rc4 produced 40 reports in about one second, with three
different writers reached from both link() and unlink():

BUG: KCSAN: data-race in ntfs_attr_find / ntfs_attr_record_resize

write to 0xffff888100af1018 of 4 bytes by task 96 on cpu 1:
 ntfs_attr_record_resize+0xd2/0x130
 ntfs_attr_record_rm+0xad/0x530
 ntfs_delete+0x224/0x640
 ntfs_unlink+0x14d/0x280
 vfs_unlink+0x157/0x520
 filename_unlinkat+0x1d9/0x350
 __x64_sys_unlink+0x2f/0x50
 x64_sys_call+0x1d43/0x1fb0
 do_syscall_64+0xed/0x450
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888100af1018 of 4 bytes by task 95 on cpu 0:
 ntfs_attr_find+0x104/0x5b0
 ntfs_attr_lookup+0x39c/0x10c0
 ntfs_read_iomap_begin_resident+0xc6/0x230
 ntfs_read_iomap_begin+0x5d/0xa0
 iomap_iter+0x2e2/0x6e0
 iomap_read_folio+0x147/0x2a0
 ntfs_read_folio+0x108/0x170
 filemap_read_folio+0x35/0x100
 filemap_fault+0x993/0x1000
 __do_fault+0x65/0x110
 __handle_mm_fault+0xc06/0x1590
 handle_mm_fault+0x126/0x2e0
 do_user_addr_fault+0x173/0x680
 exc_page_fault+0x63/0x130
 asm_exc_page_fault+0x26/0x30

value changed: 0x00000250 -> 0x000001f0

BUG: KCSAN: data-race in ntfs_attr_find / ntfs_make_room_for_attr

write to 0xffff888100af1018 of 4 bytes by task 96 on cpu 1:
 ntfs_make_room_for_attr+0xaa/0xf0
 ntfs_resident_attr_record_add+0xd7/0x460
 ntfs_attr_add+0x3a7/0x850
 __ntfs_link+0x471/0x730
 ntfs_link+0x148/0x260
 vfs_link+0x23f/0x590
 filename_linkat+0x20e/0x350
 __x64_sys_link+0x58/0x80
 x64_sys_call+0x10ca/0x1fb0
 do_syscall_64+0xed/0x450
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888100af1018 of 4 bytes by task 95 on cpu 0:
 ntfs_attr_find+0x104/0x5b0
 ntfs_attr_lookup+0x39c/0x10c0
 ntfs_read_iomap_begin_resident+0xc6/0x230
 [ ... same reader stack as above ... ]

value changed: 0x000001f0 -> 0x00000250

BUG: KCSAN: data-race in ntfs_attr_find / ntfs_resident_attr_record_add

write to 0xffff888100af10e4 of 4 bytes by task 96 on cpu 1:
 ntfs_resident_attr_record_add+0x10b/0x460
 ntfs_attr_add+0x3a7/0x850
 __ntfs_link+0x471/0x730
 ntfs_link+0x148/0x260
 vfs_link+0x23f/0x590
 filename_linkat+0x20e/0x350
 __x64_sys_link+0x58/0x80
 x64_sys_call+0x10ca/0x1fb0
 do_syscall_64+0xed/0x450
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888100af10e4 of 4 bytes by task 95 on cpu 0:
 ntfs_attr_find+0x186/0x5b0
 ntfs_attr_lookup+0x39c/0x10c0
 ntfs_read_iomap_begin_resident+0xc6/0x230
 [ ... same reader stack as above ... ]

value changed: 0x00000068 -> 0x00000060

Reports were also produced with reads originating inside
ntfs_attr_value_is_valid() (offsets +0x20, +0x32, +0x106, +0x122), so the
bounds check that would otherwise contain a torn offset is itself reading
concurrently-modified fields. These 14 were reported as "race at unknown
origin" - KCSAN observed the value change but did not capture the writing
stack - so I am citing them as evidence that the validator reads the same
unlocked buffer, not as matched pairs.

Observed transitions on the raced length/offset fields include
0x00000010 -> 0x80040001, 0x00000028 -> 0x00040600 and
0x00000050 -> 0x01000000 (3, 3 and 1 occurrences respectively). The record
is about 1 KB. CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY was set, so these are
observed changes rather than merely concurrent access.

It is also visible without KCSAN. On a freshly created mkntfs image that is
not corrupt, the driver logs attribute corruption while the race runs:

  ntfs: (device loop0): ntfs_attr_find(): mft 0x40, type 0x80 is corrupt.
        Run chkdsk.
  ntfs: (device loop0): ntfs_attr_value_is_valid(): Corrupt 0x80 attribute
        in MFT record 64

Reproducer:

  # mkntfs -F -Q ntfs.img
  # mount -t ntfs -o loop ntfs.img /mnt
  # printf 'AAAAAAAAAAAAAAAA' > /mnt/f
  # gcc -O2 -o race race.c -lpthread
  # ./race /mnt/f /mnt/l 30

Adding or removing the extra $FILE_NAME attribute resizes the record, and
the attributes after it - including the $DATA attribute the reader is
walking to - are memmove()d.

---8<---
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>
#include <pthread.h>
#include <sys/mman.h>

static const char *path_f, *path_l;
static volatile int stop;

static void pin(int cpu)
{
    cpu_set_t s;

    CPU_ZERO(&s);
    CPU_SET(cpu, &s);
    sched_setaffinity(0, sizeof(s), &s);
}

/*
 * Fault the resident $DATA in, then evict the folio so that the next
 * iteration re-enters ntfs_read_folio() -> ntfs_read_iomap_begin_resident().
 * MADV_DONTNEED is not enough here: it only tears down the PTE and leaves
 * the folio cached, so filemap_fault() just re-maps it and the read path is
 * never re-entered.
 */
static void *reader(void *unused)
{
    pin(0);
    while (!stop) {
        int fd = open(path_f, O_RDONLY);
        char *m;

        if (fd < 0)
            continue;
        m = mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd, 0);
        if (m != MAP_FAILED) {
            volatile char c = *(volatile char *)m;

            (void)c;
            munmap(m, 4096);
        }
        posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED);
        close(fd);
    }
    return NULL;
}

static void *writer(void *unused)
{
    pin(1);
    while (!stop) {
        link(path_f, path_l);
        unlink(path_l);
    }
    return NULL;
}

int main(int argc, char **argv)
{
    pthread_t r, w;

    if (argc < 3) {
        fprintf(stderr, "usage: %s <file> <linkpath> [seconds]\n",
            argv[0]);
        return 1;
    }
    path_f = argv[1];
    path_l = argv[2];
    unlink(path_l);

    pthread_create(&r, NULL, reader, NULL);
    pthread_create(&w, NULL, writer, NULL);
    sleep(argc > 3 ? atoi(argv[3]) : 30);
    stop = 1;
    pthread_join(r, NULL);
    pthread_join(w, NULL);
    return 0;
}
---8<---

I did not observe an out-of-bounds access under KASAN. The full dmesg with
all 40 reports is available if it would be useful.

Given the above, protecting attr_list alone would leave this case open. It
may be worth deciding whether ni->mrec needs its own serialization on the
read side, mirroring what the write path already does. I have the reproducer
and a KCSAN build set up, so I am happy to test a candidate fix against it.

The asymmetry is present in b041ca562526 itself (0 mrec_lock in the read
paths, 17 in the write paths), so it dates from v7.1.

Test environment:
  Kernel:  7.2-rc4 (48a5a7ab8d6ab7090564339e039c421f315de912)
  Config:  x86_64_defconfig + CONFIG_NTFS_FS=y + CONFIG_KCSAN=y (non-strict),
           KCSAN_SKIP_WATCH=500, KCSAN_UDELAY_TASK=200,
           KCSAN_REPORT_VALUE_CHANGE_ONLY=y
  Guest:   QEMU/KVM, 4 vCPU
  Volume:  64 MB image, mkntfs -F -Q, mounted -t ntfs -o loop

Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
Reported-by: Hyeontae Lee <wonju345@naver.com>

Thanks,
Hyeontae Lee
