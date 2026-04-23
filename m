Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE4B38B143;
	Thu, 23 Apr 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942660; cv=none; b=eYs60hlrDx0xfyigRj40BgiN5YuQ/WvpxKRbnaKZ4vDAeCc/Yv9Dp1Iega6FQUw3yFGed/tld8WSpLn22IU7i+ULQ93rVgNBoIkmhel5WlUMTjCJfDX2/cto0zJ+k+5JiMOJ1NjidcWyz8xa0QzhKkKP0IJUegbptVS5e56fllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942660; c=relaxed/simple;
	bh=nK68Md/tPPDnqL6Y77QLEVsXKgkRAH/cO603dBpWKPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCD2WB35LtZ3lg11q2DgoqdLEOk6np/js2ijrlWIeukjg3UH0VJnxM/NBin/FvZfDgm3HG9IvIjvJl2EnmPaXuqPB9ujFAPWRXtBCiPG6TCJtfB09EuHzUjRkadlr1MwBaquYt1TecUssa4U+TtK/YpcgEghfXJ0OowvBpEUuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 14215cfa3f0511f1aa26b74ffac11d73-20260423
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, UD_TRUSTED, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:445d7046-7e57-47a1-b02d-1776602383d9,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:445d7046-7e57-47a1-b02d-1776602383d9,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:1e702eed97aeb50cd54b1dd77f2c7a50,BulkI
	D:260423191050DQB64OBI,BulkQuantity:0,Recheck:0,SF:17|19|66|78|81|82|102|1
	27|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 14215cfa3f0511f1aa26b74ffac11d73-20260423
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 275568183; Thu, 23 Apr 2026 19:10:47 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH v3] fuse: optional FORGET delivery over io_uring
Date: Thu, 23 Apr 2026 19:09:54 +0800
Message-Id: <20260423110954.2676-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403035752.20206-1-liwang@kylinos.cn>
References: <20260403035752.20206-1-liwang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deliver FUSE_FORGET through fuse_uring_queue_fuse_req() when the io_uring
is ready and userspace has opted in by setting
FUSE_IO_URING_REGISTER_FORGET_COMMIT in fuse_uring_cmd_req.flags on
FUSE_IO_URING_CMD_REGISTER. Until any REGISTER
carries that bit, FORGET continues to use the legacy 
fuse_dev_queue_forget() path even while io_uring is active, so unmodified 
userspace (e.g. libfuse that does not issue a completion SQE for FORGET) 
does not wedge ring entries.

Benefits:
- FORGET can share the same commit/fetch loop as other opcodes.
- Reduces split transport for high-volume forgets when the ring is primary.
- Reuses existing per-queue io-uring machinery and noreply/force 
  request setup.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
Tested with passthrough_ll, based on the latest fuse 
git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next, 
and the latest libfuse patched with 
https://github.com/libfuse/libfuse/pull/1487.

Changes since v2:
- Introduce a flag that allows libfuse to inform the kernel 
  during registration that it supports receiving and processing 
  FORGET requests via io_uring.
- Keep FORGET requests in the processing queue until the kernel 
  receives the completion SQEs for them.
Changes since v1:
- Single forget enqueue entry: fuse_io_uring_ops.send_forget stays
  fuse_dev_queue_forget(); when fuse_uring_ready() call
  fuse_io_uring_send_forget(), else use the legacy list.  v1 wired
  send_forget to fuse_io_uring_send_forget() directly.
- Move fuse_io_uring_send_forget() and fuse_forget_uring_data from dev.c
  to dev_uring.c; declare fuse_request_alloc, fuse_adjust_compat,
  fuse_force_creds, fuse_args_to_req, fuse_drop_waiting in fuse_dev_i.h.
- Split list-only enqueue into fuse_dev_queue_forget_list(); use it on
  fallback paths inside fuse_io_uring_send_forget() to avoid recursion.

 fs/fuse/dev.c             | 110 +++++++++++++++++++++++++++++++++++++-
 fs/fuse/dev_uring.c       |   3 ++
 fs/fuse/dev_uring_i.h     |  13 +++++
 fs/fuse/fuse_dev_i.h      |   5 ++
 fs/fuse/fuse_i.h          |   1 +
 fs/fuse/req.c             |  10 ++++
 include/uapi/linux/fuse.h |  23 +++++++-
 7 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6fe0d8c263df..0006951e3954 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -26,6 +26,7 @@
 #include <linux/seq_file.h>
 
 #include "fuse_trace.h"
+#include "fuse_i.h"
 
 MODULE_ALIAS_MISCDEV(FUSE_MINOR);
 MODULE_ALIAS("devname:fuse");
@@ -224,8 +225,9 @@ struct fuse_forget_link *fuse_alloc_forget(void)
 	return kzalloc_obj(struct fuse_forget_link, GFP_KERNEL_ACCOUNT);
 }
 
-void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
-			   struct fuse_forget_link *forget)
+
+static inline void fuse_dev_queue_forget_list(struct fuse_iqueue *fiq,
+					      struct fuse_forget_link *forget)
 {
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
@@ -238,6 +240,21 @@ void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
 	}
 }
 
+void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
+			   struct fuse_forget_link *forget)
+{
+#ifdef CONFIG_FUSE_IO_URING
+	struct fuse_chan *fch = container_of(fiq, struct fuse_chan, iq);
+
+	if (fuse_uring_ready(fch) && fuse_uring_forget_via_ring(fch)) {
+		fuse_io_uring_send_forget(fiq, forget);
+		return;
+	}
+#endif
+	fuse_dev_queue_forget_list(fiq, forget);
+}
+
+
 void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	spin_lock(&fiq->lock);
@@ -800,6 +817,95 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 		__set_bit(FR_ASYNC, &req->flags);
 }
 
+struct fuse_forget_uring_data {
+	struct fuse_args args;
+	struct fuse_forget_in inarg;
+};
+
+static void fuse_forget_uring_free(struct fuse_args *args, int error)
+{
+	struct fuse_forget_uring_data *d =
+		container_of(args, struct fuse_forget_uring_data, args);
+
+	kfree(d);
+}
+
+
+#ifdef CONFIG_FUSE_IO_URING
+void fuse_io_uring_send_forget(struct fuse_iqueue *fiq,
+			       struct fuse_forget_link *forget)
+{
+	struct fuse_chan *fch = container_of(fiq, struct fuse_chan, iq);
+	struct fuse_conn *fc = fch->conn;
+	struct fuse_mount *fm;
+	struct fuse_req *req;
+	struct fuse_forget_uring_data *d;
+	int err;
+
+	if (!fuse_uring_ready(fch)) {
+		fuse_dev_queue_forget_list(fiq, forget);
+		return;
+	}
+
+	down_read(&fc->killsb);
+	if (list_empty(&fc->mounts)) {
+		up_read(&fc->killsb);
+		fuse_dev_queue_forget_list(fiq, forget);
+		return;
+	}
+	fm = list_first_entry(&fc->mounts, struct fuse_mount, fc_entry);
+	up_read(&fc->killsb);
+
+	d = kmalloc(sizeof(*d), GFP_KERNEL);
+	if (!d)
+		goto fallback;
+
+	atomic_inc(&fch->num_waiting);
+	req = fuse_request_alloc(fm->fc->chan, GFP_KERNEL);
+	if (!req) {
+		kfree(d);
+		fuse_drop_waiting(fch);
+		goto fallback;
+	}
+
+	memset(&d->args, 0, sizeof(d->args));
+	d->inarg.nlookup = forget->forget_one.nlookup;
+	d->args.opcode = FUSE_FORGET;
+	d->args.nodeid = forget->forget_one.nodeid;
+	d->args.in_numargs = 1;
+	d->args.in_args[0].size = sizeof(d->inarg);
+	d->args.in_args[0].value = &d->inarg;
+	d->args.force = true;
+	d->args.noreply = true;
+	d->args.end = fuse_forget_uring_free;
+
+	err = fuse_prepare_force_args(fm, &d->args);
+	if (err) {
+		kfree(d);
+		fuse_put_request(req);
+		fuse_drop_waiting(fch);
+		goto fallback;
+	}
+
+	__set_bit(FR_WAITING, &req->flags);
+	if (!d->args.abort_on_kill)
+		__set_bit(FR_FORCE, &req->flags);
+	fuse_adjust_compat(fch, &d->args);
+	fuse_args_to_req(req, &d->args);
+	req->in.h.len = sizeof(struct fuse_in_header) +
+		fuse_len_args(req->args->in_numargs,
+			      (struct fuse_arg *)req->args->in_args);
+
+	kfree(forget);
+	fuse_uring_queue_fuse_req(fiq, req);
+	return;
+
+fallback:
+	fuse_dev_queue_forget_list(fiq, forget);
+}
+#endif
+
+
 ssize_t fuse_chan_send(struct fuse_chan *fch, struct fuse_args *args)
 {
 	struct fuse_req *req;
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e467b23e6895..6f55f0ad59f2 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1114,6 +1114,9 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 	if (IS_ERR(ent))
 		return PTR_ERR(ent);
 
+	if (READ_ONCE(cmd_req->flags) & FUSE_IO_URING_REGISTER_FORGET_COMMIT)
+		ring->forget_ring_commit = true;
+
 	fuse_uring_do_register(ent, cmd, issue_flags);
 
 	return 0;
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 368f4d0790eb..258486422586 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -133,6 +133,12 @@ struct fuse_ring {
 	atomic_t queue_refs;
 
 	bool ready;
+
+	/*
+	 * Set when any REGISTER SQE sets FUSE_IO_URING_REGISTER_FORGET_COMMIT.
+	 * Until then, FORGET stays on the legacy forget list.
+	 */
+	bool forget_ring_commit;
 };
 
 void fuse_uring_stop_queues(struct fuse_ring *ring);
@@ -170,6 +176,13 @@ static inline bool fuse_uring_ready(struct fuse_chan *fch)
 	return fch->ring && fch->ring->ready;
 }
 
+static inline bool fuse_uring_forget_via_ring(struct fuse_chan *fch)
+{
+	struct fuse_ring *ring = READ_ONCE(fch->ring);
+
+	return ring && ring->forget_ring_commit;
+}
+
 #else /* CONFIG_FUSE_IO_URING */
 
 static inline void fuse_uring_abort(struct fuse_chan *fch)
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 9ce987826ded..f410e124be6b 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -383,8 +383,13 @@ int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numargs,
 		   int zeroing);
 int fuse_copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
 		       unsigned int nbytes);
+struct fuse_mount;
 void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
 			   struct fuse_forget_link *forget);
+#ifdef CONFIG_FUSE_IO_URING
+void fuse_io_uring_send_forget(struct fuse_iqueue *fiq,
+			       struct fuse_forget_link *forget);
+#endif
 void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req);
 bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 3a7ac74a23ed..0f41e70c06b6 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1017,6 +1017,7 @@ static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
 
 int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 			   gfp_t gfp_flags);
+int fuse_prepare_force_args(struct fuse_mount *fm, struct fuse_args *args);
 int fuse_simple_notify_reply(struct fuse_mount *fm, struct fuse_args *args, u64 unique);
 
 void fuse_dentry_tree_init(void);
diff --git a/fs/fuse/req.c b/fs/fuse/req.c
index a01ee743d31e..bfb26a71cc5c 100644
--- a/fs/fuse/req.c
+++ b/fs/fuse/req.c
@@ -97,3 +97,12 @@ int fuse_simple_notify_reply(struct fuse_mount *fm, struct fuse_args *args, u64
 
 	return fuse_chan_send_notify_reply(fc->chan, args, unique);
 }
+
+int fuse_prepare_force_args(struct fuse_mount *fm, struct fuse_args *args)
+{
+	WARN_ON(!args->force);
+	WARN_ON(args->nocreds);
+
+	return fuse_req_prep(fm, args, &invalid_mnt_idmap);
+}
+EXPORT_SYMBOL_GPL(fuse_prepare_force_args);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..737eb06f00fa 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -240,6 +240,12 @@
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
  *  - add FUSE_NOTIFY_PRUNE
+ *
+ *  7.46
+ *  - add FUSE_IO_URING_REGISTER_FORGET_COMMIT (fuse_uring_cmd_req.flags on
+ *    FUSE_IO_URING_CMD_REGISTER): optional delivery of FUSE_FORGET via
+ *    io-uring with FUSE_IO_URING_CMD_COMMIT_AND_FETCH completion; default
+ *    keeps FORGET on the classic /dev/fuse queue.
  */
 
 #ifndef _LINUX_FUSE_H
@@ -275,7 +281,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 45
+#define FUSE_KERNEL_MINOR_VERSION 46
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -1298,6 +1304,10 @@ enum fuse_uring_cmd {
  * In the 80B command area of the SQE.
  */
 struct fuse_uring_cmd_req {
+	/*
+	 * Bit FUSE_IO_URING_REGISTER_FORGET_COMMIT is interpreted for
+	 * FUSE_IO_URING_CMD_REGISTER; other commands ignore it.
+	 */
 	uint64_t flags;
 
 	/* entry identifier for commits */
@@ -1308,4 +1318,15 @@ struct fuse_uring_cmd_req {
 	uint8_t padding[6];
 };
 
+/*
+ * fuse_uring_cmd_req.flags (FUSE_IO_URING_CMD_REGISTER)
+ *
+ * When FUSE_IO_URING_REGISTER_FORGET_COMMIT is set, the kernel may deliver
+ * FUSE_FORGET through the io-uring ring; userspace must complete each
+ * request with FUSE_IO_URING_CMD_COMMIT_AND_FETCH. When unset (default),
+ * FORGET uses the legacy forget list even if io-uring is active, so
+ * unmodified userspace (e.g. libfuse without FORGET completion) stays safe.
+ */
+#define FUSE_IO_URING_REGISTER_FORGET_COMMIT (1ULL << 0)
+
 #endif /* _LINUX_FUSE_H */
-- 
2.34.1

