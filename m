Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E334B4024
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722069; cv=none; b=gDD3SViTJuCtzXX2w0QgCbCOHfyM6Fp2SDDRE3Ip7SDTzljy8cnDX9Puwc8Os68kb54MobT+/FmM7byrNZO9wbeqi/h6KMZT0iGkPxoOaLCTmz2x0GO3wbLtr0/VgWpQVrCwPxU+gIRpucefm+aPj0Gh25a8iEygAEqqpFMtYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722069; c=relaxed/simple;
	bh=bMJFRmdnLPXYtrjEx1nV5nf2l/FTPz1aLAsSpp17h98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnEXfn43Sz8QYLWU2n6I4kr4aruKBVQUgAHfeadSATKRHbfKSjPYv/JhEo06zG/vtozfE/Sbt6XUT0cMMX2/5DSwV+c3DKoHCIwRDWPQM45dbjy5gs4ursgkwcNACQFeQxZRoxPTS8rrY+sk5kOH5YAI87CwRKdg8Mlo2HSvUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s8Ql37JT; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8Ql37JT"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8623e5d435cso149084b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789722066; x=1790326866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DKN6mAbBKXAcNUEd6MfrwZbsB8lgRRtFF8qERhqBIgc=;
        b=s8Ql37JTN9XLmr4jBoodfiRHVdoWWfop/qApka2JBocOng1RGY8qZbrK837ErYDo9I
         3wuuFF4NCgv4RqXVk93TtA6PaXZ6a3O1ACwdOkb/ECthswx0UDVXLxZIr3a4d+4J74+H
         W6RK/8ccUq2GBeL1Y+m+hrBEuBJghWk0plfnWPlwjBHLvvf1GcduhSNYTFSVRaqL8POp
         FESGYcH8E1DqJhAiy049TutvQfBGxtOlRu8cJjJq0aTwmG+x5sq++s5DfqeVoer7ODUJ
         Aw9/eH0CwqvEwOp2FlGOpztK9EztrZEC7bhX0T1k2JpWlwDSpSpquxGOj/6j0S+P04ho
         2n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722066; x=1790326866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DKN6mAbBKXAcNUEd6MfrwZbsB8lgRRtFF8qERhqBIgc=;
        b=e/nTuvU8e067snU3NaS4WkgJXoMXJHffVL45jnjN9PnYjS7CwD/EVwjvWDWp/tziuB
         HOmOFxb1qEkG8eRxVoYppskGbOW2nhhU1QKabWsaeZKiXkeUrmvFsuAOEbw6HPcOrHtH
         gjCzBokOVXI6fsor7khzUKISKdXuK3tYEwVUFSpPS9N46ETop+q3VGTcQ8wrfPyQ2YTc
         q+CGWqvKa9lQDfxLmd1kwLp/pIzWhGwXt7WpUKK7RzpUaHXPg9Q9L8BCsHbrOlr8s8cM
         oIKR9V4r0CGQFPOPAi+LuZbihbvLTOoA9RmvnyoQvtwNOu5Snz3ho2WG+AVXs1RVsAMY
         cWpg==
X-Forwarded-Encrypted: i=1; AKwUvBwPdOMc0IavnW9rjFt0+wPgHYgyEbQTyhVBgRrOOF5MLu3Kx3adYGfzzfYhzVdC/cYnbFepfYcpj/mHo+iY@vger.kernel.org
X-Gm-Message-State: AFuF++lTbsKoD3xKGr2FbuZhyi3148a8+lZI1wmF7plI68yx1ZX9xSw5
	q0SA+Jm/t7L+wezi9vX17HCoDZt/RnIaK9HXAJ6qg/JpGZn98uU/iUZsN5gdL59EvRaQkw==
X-Gm-Gg: AYBFou1WAd5AeXuMJ/jlEE4JmbJ5ccB894TcyCSskAs3yKK+tjnhpSlyhG0Y8Bkj946
	NVoI2d/pecDdQ6yxmDpVjJj6sxiVomSTyua1cRMbSeqoTex8MhuPOmMZRjbTnQ9fhrrUtZHyNzL
	u6Nq2F3YFWOfSz3W+M8fr1OK8aKYkhQF/0ShjIJwBeWoGMLe6cm78YVUXftQ4V1b1BO2/Cwg1JD
	3zYIbO5X/3PUAjcDHHdRs8hBvU+aRM2t9k/vi9q4WnjXGx+7/EEOPgPNQe2XtN7pRA/MC8FZnsK
	GKq1qlkgV3hpr3mEkRdQz1rDXa3XQ3TCk/GudE+1ynsR4kf4Xmm1Q/pCGHvMYJZpaH+iOzAoxK/
	TkbUPI1mCBinfHMTFqRK6Q5PGCTY8DMn1+guqYPoQE0mf1sYXLJcqmgOmG/XaLDLalJg71nNdio
	hjvG7loc3HZTwg4/9j8hrn5kOh6Jyit0rQOkzDkRz/CJdPnArns0ysRXaF10ba5CECJrXojNb4P
	kzBDOvGmxcPrr5a5xZ7HEc1JtMB6wUAQP232e4X3bpI+Wt5OPn44aT/YT1tT9cB9xnibOAmtYW5
	cmXQ/q0qFDdIs9NK0x+PFK0lx3WWHAYi7DIQf9gWQ88Xi3b2XrD7DaCxPaf4itrO0wct3bITXQz
	swDUziQ==
X-Received: by 2002:a05:6a00:e1b:b0:872:a4fa:381a with SMTP id d2e1a72fcca58-874d259e679mr2291303b3a.2.1789722065357;
        Fri, 18 Sep 2026 02:01:05 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-a.c.t54fbfa9bf0658dcb-tp.internal (96.177.21.34.bc.googleusercontent.com. [34.21.177.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-875dc8fa40fsm504491b3a.15.2026.09.18.02.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:01:04 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH v4 1/3] tools: sync io_uring.h UAPI header
Date: Fri, 18 Sep 2026 09:00:08 +0000
Message-ID: <20260918090010.1688-2-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918090010.1688-1-aditya.ansh182@gmail.com>
References: <20260918090010.1688-1-aditya.ansh182@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync tools/include/uapi/linux/io_uring.h with the main kernel
include/uapi/linux/io_uring.h UAPI header to ensure they are
perfectly aligned.

Additionally, correct a minor space-before-tab checkpatch.pl warning
in the comments of both headers (no functional change).

Suggested-by: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
 include/uapi/linux/io_uring.h       |   2 +-
 tools/include/uapi/linux/io_uring.h | 340 ++++++++++++++++++++++++++--
 2 files changed, 325 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 909fb7aea638..1f300f6b85d7 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -426,7 +426,7 @@ enum io_uring_op {
  * IORING_RECVSEND_BUNDLE	Used with IOSQE_BUFFER_SELECT. If set, send or
  *				recv will grab as many buffers from the buffer
  *				group ID given and send them all. The completion
- *				result 	will be the number of buffers send, with
+ *				result	will be the number of buffers send, with
  *				the starting buffer ID in cqe->flags as per
  *				usual for provided buffer usage. The buffers
  *				will be	contiguous from the starting buffer ID.
diff --git a/tools/include/uapi/linux/io_uring.h b/tools/include/uapi/linux/io_uring.h
index f1c16f817742..1f300f6b85d7 100644
--- a/tools/include/uapi/linux/io_uring.h
+++ b/tools/include/uapi/linux/io_uring.h
@@ -10,6 +10,8 @@
 
 #include <linux/fs.h>
 #include <linux/types.h>
+#include <linux/io_uring/zcrx.h>
+
 /*
  * this file is shared with liburing and that has to autodetect
  * if linux/time_types.h is available or not, it can
@@ -50,7 +52,7 @@ struct io_uring_sqe {
 	};
 	__u32	len;		/* buffer size or number of iovecs */
 	union {
-		__kernel_rwf_t	rw_flags;
+		__u32		rw_flags;
 		__u32		fsync_flags;
 		__u16		poll_events;	/* compatibility */
 		__u32		poll32_events;	/* word-reversed for BE */
@@ -71,6 +73,9 @@ struct io_uring_sqe {
 		__u32		uring_cmd_flags;
 		__u32		waitid_flags;
 		__u32		futex_flags;
+		__u32		install_fd_flags;
+		__u32		nop_flags;
+		__u32		pipe_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	/* pack this to avoid bogus arm OABI complaints */
@@ -85,17 +90,26 @@ struct io_uring_sqe {
 	union {
 		__s32	splice_fd_in;
 		__u32	file_index;
+		__u32	zcrx_ifq_idx;
 		__u32	optlen;
 		struct {
 			__u16	addr_len;
 			__u16	__pad3[1];
 		};
+		struct {
+			__u8	write_stream;
+			__u8	__pad4[3];
+		};
 	};
 	union {
 		struct {
 			__u64	addr3;
 			__u64	__pad2[1];
 		};
+		struct {
+			__u64	attr_ptr; /* pointer to attribute information */
+			__u64	attr_type_mask; /* bit mask of attributes */
+		};
 		__u64	optval;
 		/*
 		 * If the ring is initialized with IORING_SETUP_SQE128, then
@@ -105,6 +119,18 @@ struct io_uring_sqe {
 	};
 };
 
+/* sqe->attr_type_mask flags */
+#define IORING_RW_ATTR_FLAG_PI	(1U << 0)
+/* PI attribute information */
+struct io_uring_attr_pi {
+		__u16	flags;
+		__u16	app_tag;
+		__u32	len;
+		__u64	addr;
+		__u64	seed;
+		__u64	rsvd;
+};
+
 /*
  * If sqe->file_index is set to this for opcodes that instantiate a new
  * direct descriptor (like openat/openat2/accept), then io_uring will allocate
@@ -114,7 +140,7 @@ struct io_uring_sqe {
  */
 #define IORING_FILE_INDEX_ALLOC		(~0U)
 
-enum {
+enum io_uring_sqe_flags_bit {
 	IOSQE_FIXED_FILE_BIT,
 	IOSQE_IO_DRAIN_BIT,
 	IOSQE_IO_LINK_BIT,
@@ -164,7 +190,8 @@ enum {
 /*
  * If COOP_TASKRUN is set, get notified if task work is available for
  * running and a kernel transition would be needed to run it. This sets
- * IORING_SQ_TASKRUN in the sq ring flags. Not valid with COOP_TASKRUN.
+ * IORING_SQ_TASKRUN in the sq ring flags. Not valid without COOP_TASKRUN
+ * or DEFER_TASKRUN.
  */
 #define IORING_SETUP_TASKRUN_FLAG	(1U << 9)
 #define IORING_SETUP_SQE128		(1U << 10) /* SQEs are 128 byte */
@@ -198,6 +225,33 @@ enum {
  */
 #define IORING_SETUP_NO_SQARRAY		(1U << 16)
 
+/* Use hybrid poll in iopoll process */
+#define IORING_SETUP_HYBRID_IOPOLL	(1U << 17)
+
+/*
+ * Allow both 16b and 32b CQEs. If a 32b CQE is posted, it will have
+ * IORING_CQE_F_32 set in cqe->flags.
+ */
+#define IORING_SETUP_CQE_MIXED		(1U << 18)
+
+/*
+ * Allow both 64b and 128b SQEs. If a 128b SQE is posted, it will have
+ * a 128b opcode.
+ */
+#define IORING_SETUP_SQE_MIXED		(1U << 19)
+
+/*
+ * When set, io_uring ignores SQ head and tail and fetches SQEs to submit
+ * starting from index 0 instead from the index stored in the head pointer.
+ * IOW, the user should place all SQE at the beginning of the SQ memory
+ * before issuing a submission syscall.
+ *
+ * It requires IORING_SETUP_NO_SQARRAY and is incompatible with
+ * IORING_SETUP_SQPOLL. The user must also never change the SQ head and tail
+ * values and keep it set to 0. Any other value is undefined behaviour.
+ */
+#define IORING_SETUP_SQ_REWIND		(1U << 20)
+
 enum io_uring_op {
 	IORING_OP_NOP,
 	IORING_OP_READV,
@@ -253,6 +307,17 @@ enum io_uring_op {
 	IORING_OP_FUTEX_WAIT,
 	IORING_OP_FUTEX_WAKE,
 	IORING_OP_FUTEX_WAITV,
+	IORING_OP_FIXED_FD_INSTALL,
+	IORING_OP_FTRUNCATE,
+	IORING_OP_BIND,
+	IORING_OP_LISTEN,
+	IORING_OP_RECV_ZC,
+	IORING_OP_EPOLL_WAIT,
+	IORING_OP_READV_FIXED,
+	IORING_OP_WRITEV_FIXED,
+	IORING_OP_PIPE,
+	IORING_OP_NOP128,
+	IORING_OP_URING_CMD128,
 
 	/* this goes last, obviously */
 	IORING_OP_LAST,
@@ -262,9 +327,13 @@ enum io_uring_op {
  * sqe->uring_cmd_flags		top 8bits aren't available for userspace
  * IORING_URING_CMD_FIXED	use registered buffer; pass this flag
  *				along with setting sqe->buf_index.
+ * IORING_URING_CMD_MULTISHOT	must be used with buffer select, like other
+ *				multishot commands. Not compatible with
+ *				IORING_URING_CMD_FIXED, for now.
  */
 #define IORING_URING_CMD_FIXED	(1U << 0)
-#define IORING_URING_CMD_MASK	IORING_URING_CMD_FIXED
+#define IORING_URING_CMD_MULTISHOT	(1U << 1)
+#define IORING_URING_CMD_MASK	(IORING_URING_CMD_FIXED | IORING_URING_CMD_MULTISHOT)
 
 
 /*
@@ -274,6 +343,10 @@ enum io_uring_op {
 
 /*
  * sqe->timeout_flags
+ *
+ * IORING_TIMEOUT_IMMEDIATE_ARG:	If set, sqe->addr stores the timeout
+ *					value in nanoseconds instead of
+ *					pointing to a timespec.
  */
 #define IORING_TIMEOUT_ABS		(1U << 0)
 #define IORING_TIMEOUT_UPDATE		(1U << 1)
@@ -282,6 +355,7 @@ enum io_uring_op {
 #define IORING_LINK_TIMEOUT_UPDATE	(1U << 4)
 #define IORING_TIMEOUT_ETIME_SUCCESS	(1U << 5)
 #define IORING_TIMEOUT_MULTISHOT	(1U << 6)
+#define IORING_TIMEOUT_IMMEDIATE_ARG	(1U << 7)
 #define IORING_TIMEOUT_CLOCK_MASK	(IORING_TIMEOUT_BOOTTIME | IORING_TIMEOUT_REALTIME)
 #define IORING_TIMEOUT_UPDATE_MASK	(IORING_TIMEOUT_UPDATE | IORING_LINK_TIMEOUT_UPDATE)
 /*
@@ -348,11 +422,24 @@ enum io_uring_op {
  *				0 is reported if zerocopy was actually possible.
  *				IORING_NOTIF_USAGE_ZC_COPIED if data was copied
  *				(at least partially).
+ *
+ * IORING_RECVSEND_BUNDLE	Used with IOSQE_BUFFER_SELECT. If set, send or
+ *				recv will grab as many buffers from the buffer
+ *				group ID given and send them all. The completion
+ *				result	will be the number of buffers send, with
+ *				the starting buffer ID in cqe->flags as per
+ *				usual for provided buffer usage. The buffers
+ *				will be	contiguous from the starting buffer ID.
+ *
+ * IORING_SEND_VECTORIZED	If set, SEND[_ZC] will take a pointer to a io_vec
+ *				to allow vectorized send operations.
  */
 #define IORING_RECVSEND_POLL_FIRST	(1U << 0)
 #define IORING_RECV_MULTISHOT		(1U << 1)
 #define IORING_RECVSEND_FIXED_BUF	(1U << 2)
 #define IORING_SEND_ZC_REPORT_USAGE	(1U << 3)
+#define IORING_RECVSEND_BUNDLE		(1U << 4)
+#define IORING_SEND_VECTORIZED		(1U << 5)
 
 /*
  * cqe.res for IORING_CQE_F_NOTIF if
@@ -367,11 +454,13 @@ enum io_uring_op {
  * accept flags stored in sqe->ioprio
  */
 #define IORING_ACCEPT_MULTISHOT	(1U << 0)
+#define IORING_ACCEPT_DONTWAIT	(1U << 1)
+#define IORING_ACCEPT_POLL_FIRST	(1U << 2)
 
 /*
  * IORING_OP_MSG_RING command types, stored in sqe->addr
  */
-enum {
+enum io_uring_msg_ring_flags {
 	IORING_MSG_DATA,	/* pass sqe->len as 'res' and off as user_data */
 	IORING_MSG_SEND_FD,	/* send a registered fd to another ring */
 };
@@ -386,11 +475,30 @@ enum {
 /* Pass through the flags from sqe->file_index to cqe->flags */
 #define IORING_MSG_RING_FLAGS_PASS	(1U << 1)
 
+/*
+ * IORING_OP_FIXED_FD_INSTALL flags (sqe->install_fd_flags)
+ *
+ * IORING_FIXED_FD_NO_CLOEXEC	Don't mark the fd as O_CLOEXEC
+ */
+#define IORING_FIXED_FD_NO_CLOEXEC	(1U << 0)
+
+/*
+ * IORING_OP_NOP flags (sqe->nop_flags)
+ *
+ * IORING_NOP_INJECT_RESULT	Inject result from sqe->result
+ */
+#define IORING_NOP_INJECT_RESULT	(1U << 0)
+#define IORING_NOP_FILE			(1U << 1)
+#define IORING_NOP_FIXED_FILE		(1U << 2)
+#define IORING_NOP_FIXED_BUFFER		(1U << 3)
+#define IORING_NOP_TW			(1U << 4)
+#define IORING_NOP_CQE32		(1U << 5)
+
 /*
  * IO completion data structure (Completion Queue Entry)
  */
 struct io_uring_cqe {
-	__u64	user_data;	/* sqe->data submission passed back */
+	__u64	user_data;	/* sqe->user_data value passed back */
 	__s32	res;		/* result code for this event */
 	__u32	flags;
 
@@ -409,15 +517,33 @@ struct io_uring_cqe {
  * IORING_CQE_F_SOCK_NONEMPTY	If set, more data to read after socket recv
  * IORING_CQE_F_NOTIF	Set for notification CQEs. Can be used to distinct
  * 			them from sends.
+ * IORING_CQE_F_BUF_MORE If set, the buffer ID set in the completion will get
+ *			more completions. In other words, the buffer is being
+ *			partially consumed, and will be used by the kernel for
+ *			more completions. This is only set for buffers used via
+ *			the incremental buffer consumption, as provided by
+ *			a ring buffer setup with IOU_PBUF_RING_INC. For any
+ *			other provided buffer type, all completions with a
+ *			buffer passed back is automatically returned to the
+ *			application.
+ * IORING_CQE_F_SKIP	If set, then the application/liburing must ignore this
+ *			CQE. It's only purpose is to fill a gap in the ring,
+ *			if a large CQE is attempted posted when the ring has
+ *			just a single small CQE worth of space left before
+ *			wrapping.
+ * IORING_CQE_F_32	If set, this is a 32b/big-cqe posting. Use with rings
+ *			setup in a mixed CQE mode, where both 16b and 32b
+ *			CQEs may be posted to the CQ ring.
  */
 #define IORING_CQE_F_BUFFER		(1U << 0)
 #define IORING_CQE_F_MORE		(1U << 1)
 #define IORING_CQE_F_SOCK_NONEMPTY	(1U << 2)
 #define IORING_CQE_F_NOTIF		(1U << 3)
+#define IORING_CQE_F_BUF_MORE		(1U << 4)
+#define IORING_CQE_F_SKIP		(1U << 5)
+#define IORING_CQE_F_32			(1U << 15)
 
-enum {
-	IORING_CQE_BUFFER_SHIFT		= 16,
-};
+#define IORING_CQE_BUFFER_SHIFT		16
 
 /*
  * Magic offsets for the application to mmap the data it needs
@@ -478,6 +604,9 @@ struct io_cqring_offsets {
 #define IORING_ENTER_SQ_WAIT		(1U << 2)
 #define IORING_ENTER_EXT_ARG		(1U << 3)
 #define IORING_ENTER_REGISTERED_RING	(1U << 4)
+#define IORING_ENTER_ABS_TIMER		(1U << 5)
+#define IORING_ENTER_EXT_ARG_REG	(1U << 6)
+#define IORING_ENTER_NO_IOWAIT		(1U << 7)
 
 /*
  * Passed in for io_uring_setup(2). Copied back with updated info on success
@@ -512,11 +641,15 @@ struct io_uring_params {
 #define IORING_FEAT_CQE_SKIP		(1U << 11)
 #define IORING_FEAT_LINKED_FILE		(1U << 12)
 #define IORING_FEAT_REG_REG_RING	(1U << 13)
+#define IORING_FEAT_RECVSEND_BUNDLE	(1U << 14)
+#define IORING_FEAT_MIN_TIMEOUT		(1U << 15)
+#define IORING_FEAT_RW_ATTR		(1U << 16)
+#define IORING_FEAT_NO_IOWAIT		(1U << 17)
 
 /*
  * io_uring_register(2) opcodes and arguments
  */
-enum {
+enum io_uring_register_op {
 	IORING_REGISTER_BUFFERS			= 0,
 	IORING_UNREGISTER_BUFFERS		= 1,
 	IORING_REGISTER_FILES			= 2,
@@ -558,6 +691,38 @@ enum {
 	/* register a range of fixed file slots for automatic slot allocation */
 	IORING_REGISTER_FILE_ALLOC_RANGE	= 25,
 
+	/* return status information for a buffer group */
+	IORING_REGISTER_PBUF_STATUS		= 26,
+
+	/* set/clear busy poll settings */
+	IORING_REGISTER_NAPI			= 27,
+	IORING_UNREGISTER_NAPI			= 28,
+
+	IORING_REGISTER_CLOCK			= 29,
+
+	/* clone registered buffers from source ring to current ring */
+	IORING_REGISTER_CLONE_BUFFERS		= 30,
+
+	/* send MSG_RING without having a ring */
+	IORING_REGISTER_SEND_MSG_RING		= 31,
+
+	/* register a netdev hw rx queue for zerocopy */
+	IORING_REGISTER_ZCRX_IFQ		= 32,
+
+	/* resize CQ ring */
+	IORING_REGISTER_RESIZE_RINGS		= 33,
+
+	IORING_REGISTER_MEM_REGION		= 34,
+
+	/* query various aspects of io_uring, see linux/io_uring/query.h */
+	IORING_REGISTER_QUERY			= 35,
+
+	/* auxiliary zcrx configuration, see enum zcrx_ctrl_op */
+	IORING_REGISTER_ZCRX_CTRL		= 36,
+
+	/* register bpf filtering programs */
+	IORING_REGISTER_BPF_FILTER		= 37,
+
 	/* this goes last */
 	IORING_REGISTER_LAST,
 
@@ -566,7 +731,7 @@ enum {
 };
 
 /* io-wq worker categories */
-enum {
+enum io_wq_type {
 	IO_WQ_BOUND,
 	IO_WQ_UNBOUND,
 };
@@ -578,6 +743,31 @@ struct io_uring_files_update {
 	__aligned_u64 /* __s32 * */ fds;
 };
 
+enum {
+	/* initialise with user provided memory pointed by user_addr */
+	IORING_MEM_REGION_TYPE_USER		= 1,
+};
+
+struct io_uring_region_desc {
+	__u64 user_addr;
+	__u64 size;
+	__u32 flags;
+	__u32 id;
+	__u64 mmap_offset;
+	__u64 __resv[4];
+};
+
+enum {
+	/* expose the region as registered wait arguments */
+	IORING_MEM_REGION_REG_WAIT_ARG		= 1,
+};
+
+struct io_uring_mem_region_reg {
+	__u64 region_uptr; /* struct io_uring_region_desc * */
+	__u64 flags;
+	__u64 __resv[2];
+};
+
 /*
  * Register a fully sparse file space, rather than pass in an array of all
  * -1 file descriptors.
@@ -638,6 +828,32 @@ struct io_uring_restriction {
 	__u32 resv2[3];
 };
 
+struct io_uring_task_restriction {
+	__u16 flags;
+	__u16 nr_res;
+	__u32 resv[3];
+	__DECLARE_FLEX_ARRAY(struct io_uring_restriction, restrictions);
+};
+
+struct io_uring_clock_register {
+	__u32	clockid;
+	__u32	__resv[3];
+};
+
+enum {
+	IORING_REGISTER_SRC_REGISTERED	= (1U << 0),
+	IORING_REGISTER_DST_REPLACE	= (1U << 1),
+};
+
+struct io_uring_clone_buffers {
+	__u32	src_fd;
+	__u32	flags;
+	__u32	src_off;
+	__u32	dst_off;
+	__u32	nr;
+	__u32	pad[3];
+};
+
 struct io_uring_buf {
 	__u64	addr;
 	__u32	len;
@@ -670,9 +886,17 @@ struct io_uring_buf_ring {
  *			mmap(2) with the offset set as:
  *			IORING_OFF_PBUF_RING | (bgid << IORING_OFF_PBUF_SHIFT)
  *			to get a virtual mapping for the ring.
+ * IOU_PBUF_RING_INC:	If set, buffers consumed from this buffer ring can be
+ *			consumed incrementally. Normally one (or more) buffers
+ *			are fully consumed. With incremental consumptions, it's
+ *			feasible to register big ranges of buffers, and each
+ *			use of it will consume only as much as it needs. This
+ *			requires that both the kernel and application keep
+ *			track of where the current read/recv index is at.
  */
-enum {
+enum io_uring_register_pbuf_ring_flags {
 	IOU_PBUF_RING_MMAP	= 1,
+	IOU_PBUF_RING_INC	= 2,
 };
 
 /* argument for IORING_(UN)REGISTER_PBUF_RING */
@@ -681,13 +905,57 @@ struct io_uring_buf_reg {
 	__u32	ring_entries;
 	__u16	bgid;
 	__u16	flags;
-	__u64	resv[3];
+	__u32	min_left;
+	__u32	resv[5];
+};
+
+/* argument for IORING_REGISTER_PBUF_STATUS */
+struct io_uring_buf_status {
+	__u32	buf_group;	/* input */
+	__u32	head;		/* output */
+	__u32	resv[8];
+};
+
+enum io_uring_napi_op {
+	/* register/ungister backward compatible opcode */
+	IO_URING_NAPI_REGISTER_OP = 0,
+
+	/* opcodes to update napi_list when static tracking is used */
+	IO_URING_NAPI_STATIC_ADD_ID = 1,
+	IO_URING_NAPI_STATIC_DEL_ID = 2
+};
+
+enum io_uring_napi_tracking_strategy {
+	/* value must be 0 for backward compatibility */
+	IO_URING_NAPI_TRACKING_DYNAMIC = 0,
+	IO_URING_NAPI_TRACKING_STATIC = 1,
+	IO_URING_NAPI_TRACKING_INACTIVE = 255
+};
+
+/* argument for IORING_(UN)REGISTER_NAPI */
+struct io_uring_napi {
+	__u32	busy_poll_to;
+	__u8	prefer_busy_poll;
+
+	/* a io_uring_napi_op value */
+	__u8	opcode;
+	__u8	pad[2];
+
+	/*
+	 * for IO_URING_NAPI_REGISTER_OP, it is a
+	 * io_uring_napi_tracking_strategy value.
+	 *
+	 * for IO_URING_NAPI_STATIC_ADD_ID/IO_URING_NAPI_STATIC_DEL_ID
+	 * it is the napi id to add/del from napi_list.
+	 */
+	__u32	op_param;
+	__u32	resv;
 };
 
 /*
  * io_uring_restriction->opcode values
  */
-enum {
+enum io_uring_register_restriction_op {
 	/* Allow an io_uring_register(2) opcode */
 	IORING_RESTRICTION_REGISTER_OP		= 0,
 
@@ -703,10 +971,33 @@ enum {
 	IORING_RESTRICTION_LAST
 };
 
+enum {
+	IORING_REG_WAIT_TS		= (1U << 0),
+};
+
+/*
+ * Argument for io_uring_enter(2) with
+ * IORING_GETEVENTS | IORING_ENTER_EXT_ARG_REG set, where the actual argument
+ * is an index into a previously registered fixed wait region described by
+ * the below structure.
+ */
+struct io_uring_reg_wait {
+	struct __kernel_timespec	ts;
+	__u32				min_wait_usec;
+	__u32				flags;
+	__u64				sigmask;
+	__u32				sigmask_sz;
+	__u32				pad[3];
+	__u64				pad2[2];
+};
+
+/*
+ * Argument for io_uring_enter(2) with IORING_GETEVENTS | IORING_ENTER_EXT_ARG
+ */
 struct io_uring_getevents_arg {
 	__u64	sigmask;
 	__u32	sigmask_sz;
-	__u32	pad;
+	__u32	min_wait_usec;
 	__u64	ts;
 };
 
@@ -743,11 +1034,28 @@ struct io_uring_recvmsg_out {
 /*
  * Argument for IORING_OP_URING_CMD when file is a socket
  */
-enum {
+enum io_uring_socket_op {
 	SOCKET_URING_OP_SIOCINQ		= 0,
 	SOCKET_URING_OP_SIOCOUTQ,
 	SOCKET_URING_OP_GETSOCKOPT,
 	SOCKET_URING_OP_SETSOCKOPT,
+	SOCKET_URING_OP_TX_TIMESTAMP,
+	SOCKET_URING_OP_GETSOCKNAME,
+};
+
+/*
+ * SOCKET_URING_OP_TX_TIMESTAMP definitions
+ */
+
+#define IORING_TIMESTAMP_HW_SHIFT	16
+/* The cqe->flags bit from which the timestamp type is stored */
+#define IORING_TIMESTAMP_TYPE_SHIFT	(IORING_TIMESTAMP_HW_SHIFT + 1)
+/* The cqe->flags flag signifying whether it's a hardware timestamp */
+#define IORING_CQE_F_TSTAMP_HW		((__u32)1 << IORING_TIMESTAMP_HW_SHIFT)
+
+struct io_timespec {
+	__u64		tv_sec;
+	__u64		tv_nsec;
 };
 
 #ifdef __cplusplus
-- 
2.47.3

