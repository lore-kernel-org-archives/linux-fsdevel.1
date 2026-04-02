Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1935BDC2
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147410; cv=none; b=Hn8ESoWzcPuPMA2zQ3/2RC2rdjpsXG2MjGP59Kh0/NmlGBtt1PuO0HXk9z2qzY9Nmrh8uZE5IOQprTJlFTu+OMqNsL7T/q4wq+P0NfPmkHfk1OEoc3LA1hKnlhPhuo6tc6aCovg8Ss9a2kfuzTgLFZaWpvHapaNKWG06zWBImzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147410; c=relaxed/simple;
	bh=9kTt5SgnqZgD60Yxw2Gl9R33am0sa9SxV4nRJdPLzSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRTXb9sFwT37lJQjUzzm/v2alJFE3UY64cfGxd3XDu7DX7q29alKaT3UFXqetlfR0qDQfEo/aqkWw6JD2Ddu6vffer5Qdxwfp2eTFDEcXaG6/kU3AliefNdLxx9+sV4rapB+tAufh5fTLNpRoRQHkQ9Hku6qqNN6hKuTn8I86Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzG1lhO7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzG1lhO7"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35da8d037a5so473512a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147409; x=1775752209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8YTrPq5FaEKFHKOS7rvParM6QWr9Lz2OFLt1Vkz+DE=;
        b=qzG1lhO7zjKEXtpR8l7/dd0oXIwiVoPI8S5Kp0hTILHAd9TmZ9zfz7lnh/oE1PkvC3
         VDA9rM92aK/dlpPW0j+OI8sPvH5d22g21mWdH03LbyjRxeFqqxTod0t8r0tecIyDFXCm
         wd12Uo1bjzKQaqLwD221z/VAd1NcoamB5JtlIB7dAa85iWbsbvmRlxFDEC5ilIT9VYNE
         VQKsYcw3Ueux6wo7f24VncElHTKAHPUHoc+NOh/e/yzWQXWBhitIYEiaUp1z1uWCmm6q
         5ymCSVfyEHPVZxSjY2XIITFTVuOTCqpOo0xOJx3yzrZo0HlPkUW0r2cLyVjhJ0x36d0m
         hMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147409; x=1775752209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E8YTrPq5FaEKFHKOS7rvParM6QWr9Lz2OFLt1Vkz+DE=;
        b=D5AAHEwOK0v629wCc/JfjbqhBtlKLqwY9yrF1YiguKwwfxtqlqsZDX8u4cz9o9e/W3
         qPIqf2dH49FO/5DHONesQ2OySi/8u30yoJ3zoKkyp4zLAedh1H4Qz1uKtLXCadKbQnKV
         7FmkkNEhfVPa0pf/CN5KH48uWII2jSjApOzSVd5KbaI+zI3ZaJW9zHM7d/lt50zl7qyG
         OC54sDK66RTVeGvsB8mccX+Azof5c78odgYu8B2i7SEkbtXelozuYKWHq3CPsXkX0t4V
         W0UdKvZIE86vFQaQlcVl80bEb/xwp3RCNv8+/wJat75OeUikUFl/uEGO/3a1IwdO6Nn4
         odiw==
X-Forwarded-Encrypted: i=1; AJvYcCXvaLKAk0/5EY1S0/dm9zaWtGupGpN0V6BP6U8BgKkSPLEsYJYIqs3h0pferj/OWgxhcnkvK23SI2kwSdAH@vger.kernel.org
X-Gm-Message-State: AOJu0YySUgd1aAONE1jkXprY0CTESKqybYoylSDd/3v44ROWww22kGD8
	yjVNygEV6dm0Qt4HkiWkvX5VeQU67osUextDUqWjf4KK25WDMSwfrayk
X-Gm-Gg: AeBDiesb1SA+2dlQMUSjG6LBNgIRCqvfmOuLeU8Ef3ZKnTniBDotGFRhGIuACfXqx7S
	VwrwCUa4tSLyN0GTxfQdOh9NiniVJ6NlsTy+g9UdIRxAnNz+ezR8lrsahG7evjW1w7zkaMjoTvy
	U95x6q/nZLjl6EVMur8YSBTxq+DRg16mNI7JuCMhvLJZSCOaVNr/2UEgrwV4spTZM/l3B1197Xc
	QfEjnrMIA5tOEZvN9jHYnp5SF9HwmV228RuMqmf6tgqhzYPLCPxz94PeJpRM2iVLoyerz+0e6xg
	lgW/UaA3agwo3E88nvTFiCxCfYcxzNpO4iDi/GiCLE0BHV4O8aPcv7PScq/OjJHMQwRZd+jFh7d
	ZpcXsyzcnhKXKP9CeXDUg/xgqLkn2LyAWvrkyjwWYmi/VvEfHKhZk+6rxUDrTyHblusnZurv0Te
	hKdD4tkLsbEc6PLQzU5w==
X-Received: by 2002:a17:90b:1350:b0:35c:b02:b5c1 with SMTP id 98e67ed59e1d1-35dc6e2d00dmr7429960a91.2.1775147408394;
        Thu, 02 Apr 2026 09:30:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe937925sm11588432a91.12.2026.04.02.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:30:07 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 11/14] fuse: add pinned headers capability for io-uring buffer rings
Date: Thu,  2 Apr 2026 09:28:37 -0700
Message-ID: <20260402162840.2989717-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402162840.2989717-1-joannelkoong@gmail.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow fuse servers to pin their header buffers by setting the
FUSE_URING_PINNED_HEADERS flag alongside FUSE_URING_BUFRING on REGISTER
sqes. When set, the kernel pins the header pages, vmaps them for a
kernel virtual address, and uses direct memcpy for copying. This avoids
the per-request overhead of having to pin/unpin user pages and translate
virtual addresses.

Buffers must be page-aligned. The kernel accounts pinned pages against
RLIMIT_MEMLOCK (bypassed with CAP_IPC_LOCK) and tracks mm->pinned_vm.
Unpinning is done in process context during connection abort, since vmap
cannot run in softirq (where final destruction occurs via RCU).

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c       | 228 ++++++++++++++++++++++++++++++++++++--
 fs/fuse/dev_uring_i.h     |  23 +++-
 include/uapi/linux/fuse.h |   2 +
 3 files changed, 243 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 9f14a2bcde3f..79736b02cf9f 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -11,6 +11,7 @@
 
 #include <linux/fs.h>
 #include <linux/io_uring/cmd.h>
+#include <linux/vmalloc.h>
 
 static bool __read_mostly enable_uring;
 module_param(enable_uring, bool, 0644);
@@ -46,6 +47,11 @@ static inline bool bufring_enabled(struct fuse_ring_queue *queue)
 	return queue->bufring != NULL;
 }
 
+static inline bool bufring_pinned_headers(struct fuse_ring_queue *queue)
+{
+	return queue->bufring->use_pinned_headers;
+}
+
 static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
 				   struct fuse_ring_ent *ring_ent)
 {
@@ -200,6 +206,37 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
 	return false;
 }
 
+static void fuse_bufring_unpin_mem(struct fuse_bufring_pinned *mem)
+{
+	struct page **pages = mem->pages;
+	unsigned int nr_pages = mem->nr_pages;
+	struct user_struct *user = mem->user;
+	struct mm_struct *mm_account = mem->mm_account;
+
+	vunmap(mem->addr);
+	unpin_user_pages(pages, nr_pages);
+
+	if (user) {
+		atomic_long_sub(nr_pages, &user->locked_vm);
+		free_uid(user);
+	}
+
+	atomic64_sub(nr_pages, &mm_account->pinned_vm);
+	mmdrop(mm_account);
+
+	kvfree(mem->pages);
+}
+
+static void fuse_uring_bufring_unpin(struct fuse_ring_queue *queue)
+{
+	struct fuse_bufring *br = queue->bufring;
+
+	if (bufring_pinned_headers(queue)) {
+		fuse_bufring_unpin_mem(&br->pinned_headers);
+		br->use_pinned_headers = false;
+	}
+}
+
 void fuse_uring_destruct(struct fuse_conn *fc)
 {
 	struct fuse_ring *ring = fc->ring;
@@ -227,7 +264,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 		}
 
 		kfree(queue->fpq.processing);
-		kfree(queue->bufring);
+		if (bufring_enabled(queue)) {
+			fuse_uring_bufring_unpin(queue);
+			kfree(queue->bufring);
+		}
 		kfree(queue);
 		ring->queues[qid] = NULL;
 	}
@@ -309,14 +349,131 @@ static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
 	return 0;
 }
 
+static struct page **fuse_uring_pin_user_pages(void __user *uaddr,
+					       unsigned long len, int *npages)
+{
+	unsigned long addr = (unsigned long)uaddr;
+	unsigned long start, end, nr_pages;
+	struct page **pages;
+	int pinned;
+
+	if (check_add_overflow(addr, len, &end))
+		return ERR_PTR(-EOVERFLOW);
+	if (check_add_overflow(end, PAGE_SIZE - 1, &end))
+		return ERR_PTR(-EOVERFLOW);
+
+	end = end >> PAGE_SHIFT;
+	start = addr >> PAGE_SHIFT;
+	nr_pages = end - start;
+	if (WARN_ON_ONCE(!nr_pages))
+		return ERR_PTR(-EINVAL);
+	if (WARN_ON_ONCE(nr_pages > INT_MAX))
+		return ERR_PTR(-EOVERFLOW);
+
+	pages = kvmalloc_objs(struct page *, nr_pages, GFP_KERNEL_ACCOUNT);
+	if (!pages)
+		return ERR_PTR(-ENOMEM);
+
+	pinned = pin_user_pages_fast(addr, nr_pages, FOLL_WRITE | FOLL_LONGTERM,
+				     pages);
+	/* success, mapped all pages */
+	if (pinned == nr_pages) {
+		*npages = nr_pages;
+		return pages;
+	}
+
+	/* remove any partial pins */
+	if (pinned > 0)
+		unpin_user_pages(pages, pinned);
+
+	kvfree(pages);
+
+	return ERR_PTR(pinned < 0 ? pinned : -EFAULT);
+}
+
+static int account_pinned_pages(struct fuse_bufring_pinned *mem,
+				struct page **pages, unsigned int nr_pages)
+{
+	unsigned long page_limit, cur_pages, new_pages;
+	struct user_struct *user = current_user();
+
+	if (!nr_pages)
+		return 0;
+
+	if (!capable(CAP_IPC_LOCK)) {
+		/* Don't allow more pages than we can safely lock */
+		page_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+
+		cur_pages = atomic_long_read(&user->locked_vm);
+		do {
+			new_pages = cur_pages + nr_pages;
+			if (new_pages > page_limit)
+				return -ENOMEM;
+		} while (!atomic_long_try_cmpxchg(&user->locked_vm,
+						  &cur_pages, new_pages));
+
+		mem->user = get_uid(current_user());
+	}
+
+	atomic64_add(nr_pages, &current->mm->pinned_vm);
+	mmgrab(current->mm);
+	mem->mm_account = current->mm;
+
+	return 0;
+}
+
+static int fuse_bufring_pin_mem(struct fuse_bufring_pinned *mem,
+				void __user *addr, size_t len)
+{
+	struct page **pages = NULL;
+	int nr_pages;
+	int err;
+
+	if (!PAGE_ALIGNED(addr))
+		return -EINVAL;
+
+	pages = fuse_uring_pin_user_pages(addr, len, &nr_pages);
+	if (IS_ERR(pages))
+		return PTR_ERR(pages);
+
+	err = account_pinned_pages(mem, pages, nr_pages);
+	if (err)
+		goto unpin;
+
+	mem->addr = vmap(pages, nr_pages, VM_MAP, PAGE_KERNEL);
+	if (!mem->addr) {
+		err = -ENOMEM;
+		goto unaccount;
+	}
+
+	mem->pages = pages;
+	mem->nr_pages = nr_pages;
+
+	return 0;
+
+unaccount:
+	if (mem->user) {
+		atomic_long_sub(nr_pages, &mem->user->locked_vm);
+		free_uid(mem->user);
+	}
+	atomic64_sub(nr_pages, &current->mm->pinned_vm);
+	mmdrop(mem->mm_account);
+unpin:
+	unpin_user_pages(pages, nr_pages);
+	kvfree(pages);
+	return err;
+}
+
 static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
-				     struct fuse_ring_queue *queue)
+				    struct fuse_ring_queue *queue,
+				    u64 init_flags)
 {
 	const struct fuse_uring_cmd_req *cmd_req =
 		io_uring_sqe128_cmd(cmd->sqe, struct fuse_uring_cmd_req);
 	u16 queue_depth = READ_ONCE(cmd_req->init.queue_depth);
 	unsigned int buf_size = READ_ONCE(cmd_req->init.buf_size);
 	struct iovec iov[FUSE_URING_IOV_SEGS];
+	bool pinned_headers = init_flags & FUSE_URING_PINNED_HEADERS;
 	void __user *payload, *headers;
 	size_t headers_size, payload_size, ring_size;
 	struct fuse_bufring *br;
@@ -354,7 +511,17 @@ static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
 		return -ENOMEM;
 
 	br->queue_depth = queue_depth;
-	br->headers = headers;
+	if (pinned_headers) {
+		err = fuse_bufring_pin_mem(&br->pinned_headers, headers,
+					   headers_size);
+		if (err) {
+			kfree(br);
+			return err;
+		}
+		br->use_pinned_headers = true;
+	} else {
+		br->headers = headers;
+	}
 
 	payload_addr = (uintptr_t)payload;
 
@@ -385,8 +552,15 @@ static bool queue_init_flags_consistent(struct fuse_ring_queue *queue,
 					u64 init_flags)
 {
 	bool bufring = init_flags & FUSE_URING_BUFRING;
+	bool pinned_headers = init_flags & FUSE_URING_PINNED_HEADERS;
+
+	if (bufring_enabled(queue) != bufring)
+		return false;
+
+	if (!bufring)
+		return true;
 
-	return bufring_enabled(queue) == bufring;
+	return bufring_pinned_headers(queue) == pinned_headers;
 }
 
 static struct fuse_ring_queue *
@@ -423,7 +597,7 @@ fuse_uring_create_queue(struct io_uring_cmd *cmd, struct fuse_ring *ring,
 	fuse_pqueue_init(&queue->fpq);
 
 	if (use_bufring) {
-		int err = fuse_uring_bufring_setup(cmd, queue);
+		int err = fuse_uring_bufring_setup(cmd, queue, init_flags);
 
 		if (err) {
 			kfree(pq);
@@ -437,8 +611,10 @@ fuse_uring_create_queue(struct io_uring_cmd *cmd, struct fuse_ring *ring,
 	if (ring->queues[qid]) {
 		spin_unlock(&fc->lock);
 		kfree(queue->fpq.processing);
-		if (use_bufring)
+		if (use_bufring) {
+			fuse_uring_bufring_unpin(queue);
 			kfree(queue->bufring);
+		}
 		kfree(queue);
 
 		queue = ring->queues[qid];
@@ -605,6 +781,25 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
 	}
 }
 
+static void fuse_uring_unpin_queues(struct fuse_ring *ring)
+{
+	int qid;
+
+	for (qid = 0; qid < ring->nr_queues; qid++) {
+		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
+		struct fuse_bufring *br;
+
+		if (!queue)
+			continue;
+
+		br = queue->bufring;
+		if (!br)
+			continue;
+
+		fuse_uring_bufring_unpin(queue);
+	}
+}
+
 /*
  * Stop the ring queues
  */
@@ -643,6 +838,9 @@ void fuse_uring_abort(struct fuse_conn *fc)
 		fuse_uring_abort_end_requests(ring);
 		fuse_uring_stop_queues(ring);
 	}
+
+	/* unpin while in process context - can't do this in softirq */
+	fuse_uring_unpin_queues(ring);
 }
 
 /*
@@ -758,6 +956,11 @@ static int copy_header_to_ring(struct fuse_ring_ent *ent,
 		int buf_offset = offset +
 			sizeof(struct fuse_uring_req_header) * ent->id;
 
+		if (bufring_pinned_headers(ent->queue)) {
+			memcpy(ent->queue->bufring->pinned_headers.addr + buf_offset,
+			       header, header_size);
+			return 0;
+		}
 		ring = ent->queue->bufring->headers + buf_offset;
 	} else {
 		ring = (void __user *)ent->headers + offset;
@@ -785,6 +988,11 @@ static int copy_header_from_ring(struct fuse_ring_ent *ent,
 		int buf_offset = offset +
 			sizeof(struct fuse_uring_req_header) * ent->id;
 
+		if (bufring_pinned_headers(ent->queue)) {
+			memcpy(header, ent->queue->bufring->pinned_headers.addr + buf_offset,
+			       header_size);
+			return 0;
+		}
 		ring = ent->queue->bufring->headers + buf_offset;
 	} else {
 		ring = (void __user *)ent->headers + offset;
@@ -1399,7 +1607,13 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 
 static bool init_flags_valid(u64 init_flags)
 {
-	u64 valid_flags = FUSE_URING_BUFRING;
+	u64 valid_flags =
+		FUSE_URING_BUFRING | FUSE_URING_PINNED_HEADERS;
+	bool bufring = init_flags & FUSE_URING_BUFRING;
+	bool pinned_headers = init_flags & FUSE_URING_PINNED_HEADERS;
+
+	if (pinned_headers && !bufring)
+		return false;
 
 	return !(init_flags & ~valid_flags);
 }
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 66d5d5f8dc3f..05c0f061a882 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -42,12 +42,29 @@ struct fuse_bufring_buf {
 	unsigned int id;
 };
 
-struct fuse_bufring {
-	/* pointer to the headers buffer */
-	void __user *headers;
+struct fuse_bufring_pinned {
+	void *addr;
+	struct page **pages;
+	unsigned int nr_pages;
+
+	/*
+	 * need to track this so we can unpin / unaccount pages during teardown
+	 * when not running in the server's task context
+	 */
+	struct user_struct *user;
+	struct mm_struct *mm_account;
+};
 
+struct fuse_bufring {
+	bool use_pinned_headers: 1;
 	unsigned int queue_depth;
 
+	union {
+		/* pointer to the headers buffer */
+		void __user *headers;
+		struct fuse_bufring_pinned pinned_headers;
+	};
+
 	/* metadata tracking state of the bufring */
 	unsigned int nbufs;
 	unsigned int head;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 8753de7eb189..e57244c03d42 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -244,6 +244,7 @@
  *  7.46
  *  - add FUSE_URING_BUFRING flag
  *  - add fuse_uring_cmd_req init struct
+ *  - add FUSE_URING_PINNED_HEADERS flag
  */
 
 #ifndef _LINUX_FUSE_H
@@ -1306,6 +1307,7 @@ enum fuse_uring_cmd {
 
 /* fuse_uring_cmd_req flags */
 #define FUSE_URING_BUFRING		(1 << 0)
+#define FUSE_URING_PINNED_HEADERS	(1 << 1)
 
 /**
  * In the 80B command area of the SQE.
-- 
2.52.0

