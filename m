Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072074;
	b=x2tvw90FU7kEqEowAj/Oa9X19yOOXtgzlA3yoHUTxbi4Np9HSR/nOxXNq2D2KzviaSBK
	 G3HvvOe8FKAuCqJOgFG2qINuU7x34+hg0ynqB/f9RDwiqYtQl0EwOvLQQFaVeWyXchyQL
	 sWFpnNPWmRIbM65hRjqY/P0hZmNR57q5kCyg6BzQ23fAxiXy9Q5yYBdq2zR6uym3HHZWI
	 vDN3pPUz6nR/5tN0HtyDOtmubkHEvuflbmhd8x3uwfIv1cgnwQKgWjeDYRMRXxszJ+UZc
	 rtv77yoMHx7VCqJ8GYFuN39WLQSzu+fFe4o5kCPckIbSPfWinz5H2GLFGovjhUqTXVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=JJLvmVV2iFndDkwChBmGVao/pICrf/b8G6/BBv8WQzs=;
	b=QSPw6nfVTeF2tBZSpRk3tjz0Hympz4JphyxxXKziCqujkxxZqEXmHxZdfFKh9a4ajyux
	 j8UP03PrZLFqdqbo1OYuouq/++q4DQY3eAUkDSryCWQEQ+9ooSXatMGrDoQD+wGg6wNoh
	 MzLUku98YbMqscMP0AzyRQ5ClvqUW56RS4DM5ZX1eWoj2fRyA2M8szhqz3kPbZBm++6s3
	 YvQWd0tDt+uKAr0WAo7P6P4wkVqUY6imTYK2fg9DT/Qp6HlzHp5R5JgyoZYPCXgAXCdgG
	 59/lbrH4sytTw1nv/jO0LvoLJDC6vV64hhlclcLwP1pAUbZ8xSgXM8LHxncRQNQ1ptA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=PrPhYdj4;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7209606A31A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 03:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7209606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=PrPhYdj4
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c40e30c26a4so82113966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 20:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072071; x=1793676871; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JJLvmVV2iFndDkwChBmGVao/pICrf/b8G6/BBv8WQzs=;
        b=PrPhYdj4lsl6WY1eRcIYnVNPzLWRrynHcUVj9I5xsoprzRZAeOt6ayDDiUc/trGUDU
         zEEtUvahpwB3yfKrXVSGtn1hq0c5++9cTKlzb4K/mtZ/zEv0TH4Zg99KXDJ6dOs2oshB
         yFYwXMyC++79nRfPELlLKzOVJtcZEkNU0o3Xlqfv3VUoiVDmgy5KolN5DO/PO8U61iqf
         qbx+2TKjQL21JW1lRhafU6DB6bMJdJgrDtJvkKE8E1cIupVnc0ERW7WH6J78ESjGgh+m
         bOFvg+UcxByPQ0Z60FqDar+JfOxEjjKQlAudE0UvBAO84v60l1P9/uoWoeogBgdVcpi4
         WtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072071; x=1793676871;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JJLvmVV2iFndDkwChBmGVao/pICrf/b8G6/BBv8WQzs=;
        b=rnk+BYpbKuGaVoW4BvP6FwFXq2Ni4pRhtAyd+wK4Saj9wNfoBAzUgBukC0Dl70CPLY
         yvDXFv/bMig43ZWExCwa0a7OzcwynUPCbfnlnIh80u5hiBBv0OlKtmwgLlYBoLfkqcrY
         sSx1qVbvZ3L2ZKf5aov4isbimhFDt2UMexYDpBRZdtnCqCruB+ZbEj03RdvdBzvRnqm4
         Dog85ubp/txUyC44TGZqYcbezvj+ZuS5yI3jvl/OjOTYGJSNFMkzUMtQikJj97ApYrZ1
         Lm2VKc+Q5HH2T6qREdLkkKtXR/77UAxiA9OyhPCY8EvUasJIXHYb0b9jcKWi5JazUwW/
         bmtw==
X-Forwarded-Encrypted: i=1; AKwUvBw+D6ys9CwZmWa2v7oGd/AAOGeaeG8NkF00FLguCDtVXLk3NwE6qH8i6M7eIYeEXOG3PCErT+zA4mlL+QlH@vger.kernel.org
X-Gm-Message-State: AFq9FYL8K4aPD7NjOvfoyxUubIpKIndhAELkvxl9E3gubtgtwFaFsfxi
	gcbWgr+/vQJlfN2YX5C2L9kODknNJIUT1PfIiD8BxTRPQos/MQb+rjuaIzJC/kHKW3w=
X-Gm-Gg: AYBFou2WcT3oPQ7eq2hu5CSvmMMXl8flwOa2pH3OxhaSCg6wT/LTPLaC5x20BhASmD/
	f3m67YR6iAGFCiz9kPB8Yo3oUJfQZMPVougHEImwb/SRMp1EMYGeCeTYwtWnNZa24AdduPfBH7o
	1BWu3/AiDHZe6JvttEMdVmzrefzuurURJXb9+dhHSwe3zxGYZbdOsLm1QCXHgK8Dx6PSxoOkOd1
	4FtYQnxrizfXhzVTPlD0nRyP4JfnxHMSAPDbYu9M8h93xlS2m7A4xl4QlhWIz90InJCvEvRQ6NF
	mw3TmpqEE0Izqat+FFTlU7RhEar4tyNh00kx1PGJsxVu7sTvCLGuCWxV4wn7ikf+ubnIeVYhmi2
	tFgZCeLaxlMfUfhrgE9g92lf0rhj3E9fiv74mrPUWHOGmsJWyOMD1qnpBtueX1GweGXwe0OboBS
	Gs9d6CEomCpmcGuGw+NULvIAlqe2tnesH7Wi8QXCHa7zy5AVmKGzIWTsA90fgzPJRIRjd4fOwV8
	OrTS6zlvRgSkCbqwyEF0YfA3QMGnU5klCVbt1JsIrYtfQ==
X-Received: by 2002:a17:907:9303:b0:c46:7de7:e41d with SMTP id a640c23a62f3a-c49a7417cabmr116191366b.18.1793072071043;
        Mon, 26 Oct 2026 20:34:31 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd52435asm380825966b.36.2026.10.26.20.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:34:29 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 04/46] mm/memfd: make f_pos accesses atomic
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:34:28 -0700
Message-Id: <179307206859.1171062.6841971971647864368.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX") made
> read(), write() and lseek() on a shared open file description of a regular
> file serialize on ->f_pos_lock.  The flag that asks for it,
> FMODE_ATOMIC_POS, is set in do_dentry_open().  A memfd is a regular file
> too, but its struct file comes from alloc_file_pseudo() and never passes
> through do_dentry_open(), so it does not get the flag:
> 
... snip ...
> 
> Fixes: 9183df25fe7b ("shm: add memfd_create() syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: minor description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

This one arguably should have at least a trivial selftest.

Test attatched
-- >8 --
From: Gregory Price <gourry@gourry.net>
Subject: [PATCH] selftests/memfd: test shared file position atomicity

Without FMODE_ATOMIC_POS, concurrent reads or writes on a shared memfd
can use the same file position. Two writers can overwrite each other's
records:

    CPU 1                         CPU 2
    pos = file->f_pos
                                  pos = file->f_pos
    write a record at pos
                                  write a record at pos
    file->f_pos = pos + size
                                  file->f_pos = pos + size

Add separate shared-read and shared-write tests using the kselftest
harness. Check the final offset, file size and exactly-once record delivery
rather than requiring a particular interleaving.

Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 tools/testing/selftests/memfd/.gitignore  |   1 +
 tools/testing/selftests/memfd/Makefile    |   3 +-
 tools/testing/selftests/memfd/memfd_pos.c | 136 ++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/memfd/memfd_pos.c

diff --git a/tools/testing/selftests/memfd/.gitignore b/tools/testing/selftests/memfd/.gitignore
index dd9a051f608e2..574ab97ebd982 100644
--- a/tools/testing/selftests/memfd/.gitignore
+++ b/tools/testing/selftests/memfd/.gitignore
@@ -2,4 +2,5 @@
 fuse_mnt
 fuse_test
 memfd_test
+memfd_pos
 memfd-test-file
diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 163b6f68631c4..67a95c34541cd 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -2,7 +2,7 @@
 CFLAGS += -D_FILE_OFFSET_BITS=64
 CFLAGS += $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := memfd_test
+TEST_GEN_PROGS := memfd_test memfd_pos
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
 TEST_GEN_FILES := fuse_test fuse_mnt
 
@@ -22,6 +22,7 @@ include ../lib.mk
 
 $(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
 
+$(OUTPUT)/memfd_pos: LDLIBS += -pthread
 $(OUTPUT)/memfd_test: memfd_test.c common.c
 $(OUTPUT)/fuse_test: fuse_test.c common.c
 
diff --git a/tools/testing/selftests/memfd/memfd_pos.c b/tools/testing/selftests/memfd/memfd_pos.c
new file mode 100644
index 0000000000000..5f3749d13f561
--- /dev/null
+++ b/tools/testing/selftests/memfd/memfd_pos.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <pthread.h>
+#include <stdatomic.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define THREADS 4
+#define RECORDS 16384
+#define TOTAL (THREADS * RECORDS)
+
+struct worker {
+	int fd;
+	unsigned int id;
+	bool reading;
+	pthread_barrier_t *barrier;
+	atomic_uint *seen;
+	int error;
+};
+
+static void *transfer(void *arg)
+{
+	struct worker *w = arg;
+	unsigned int i;
+
+	pthread_barrier_wait(w->barrier);
+	for (i = 0; i < RECORDS; i++) {
+		uint32_t value = w->id * RECORDS + i;
+		ssize_t n;
+
+		do {
+			n = w->reading ? read(w->fd, &value, sizeof(value)) :
+				write(w->fd, &value, sizeof(value));
+		} while (n < 0 && errno == EINTR);
+		if (n != sizeof(value) || value >= TOTAL) {
+			w->error = 1;
+			break;
+		}
+		if (w->reading)
+			atomic_fetch_add(&w->seen[value], 1);
+	}
+	return NULL;
+}
+
+FIXTURE(memfd_pos) {
+	int fd;
+	atomic_uint *seen;
+};
+
+FIXTURE_SETUP(memfd_pos)
+{
+	self->fd = memfd_create("position", MFD_CLOEXEC);
+	if (self->fd < 0 && errno == ENOSYS)
+		SKIP(return, "memfd_create unavailable");
+	ASSERT_GE(self->fd, 0);
+	self->seen = calloc(TOTAL, sizeof(*self->seen));
+	ASSERT_NE(self->seen, NULL);
+	for (unsigned int i = 0; i < TOTAL; i++)
+		atomic_init(&self->seen[i], 0);
+}
+
+FIXTURE_TEARDOWN(memfd_pos)
+{
+	close(self->fd);
+	free(self->seen);
+}
+
+static int run_workers(int fd, bool reading, atomic_uint *seen)
+{
+	pthread_barrier_t barrier;
+	pthread_t threads[THREADS];
+	struct worker workers[THREADS];
+	int ret = 0;
+	unsigned int i;
+
+	if (pthread_barrier_init(&barrier, NULL, THREADS))
+		return 1;
+	for (i = 0; i < THREADS; i++) {
+		workers[i] = (struct worker) {
+			.fd = fd, .id = i, .reading = reading,
+			.barrier = &barrier, .seen = seen,
+		};
+		/* The harness isolates this test in a child; abort on setup failure. */
+		if (pthread_create(&threads[i], NULL, transfer, &workers[i]))
+			abort();
+	}
+	for (i = 0; i < THREADS; i++) {
+		if (pthread_join(threads[i], NULL) || workers[i].error)
+			ret = 1;
+	}
+	pthread_barrier_destroy(&barrier);
+	return ret;
+}
+
+/* Concurrent writes sharing an open file description must not overlap. */
+TEST_F(memfd_pos, shared_write)
+{
+	struct stat st;
+	uint32_t value;
+	unsigned int i;
+
+	ASSERT_EQ(run_workers(self->fd, false, self->seen), 0);
+	ASSERT_EQ(fstat(self->fd, &st), 0);
+	ASSERT_EQ(st.st_size, (off_t)(TOTAL * sizeof(value)));
+	ASSERT_EQ(lseek(self->fd, 0, SEEK_CUR), st.st_size);
+	ASSERT_EQ(lseek(self->fd, 0, SEEK_SET), 0);
+	for (i = 0; i < TOTAL; i++) {
+		ASSERT_EQ(read(self->fd, &value, sizeof(value)), sizeof(value));
+		ASSERT_LT(value, TOTAL);
+		atomic_fetch_add(&self->seen[value], 1);
+	}
+	for (i = 0; i < TOTAL; i++)
+		ASSERT_EQ(atomic_load(&self->seen[i]), 1);
+}
+
+/* Concurrent reads must consume every record exactly once. */
+TEST_F(memfd_pos, shared_read)
+{
+	uint32_t i;
+
+	for (i = 0; i < TOTAL; i++)
+		ASSERT_EQ(write(self->fd, &i, sizeof(i)), sizeof(i));
+	ASSERT_EQ(lseek(self->fd, 0, SEEK_SET), 0);
+	ASSERT_EQ(run_workers(self->fd, true, self->seen), 0);
+	ASSERT_EQ(lseek(self->fd, 0, SEEK_CUR), (off_t)(TOTAL * sizeof(i)));
+	for (i = 0; i < TOTAL; i++)
+		ASSERT_EQ(atomic_load(&self->seen[i]), 1);
+}
+
+TEST_HARNESS_MAIN

-- 
Gregory Price <gourry@gourry.net>
