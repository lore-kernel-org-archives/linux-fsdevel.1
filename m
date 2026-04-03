Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981A1DF27D;
	Fri,  3 Apr 2026 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775188719; cv=none; b=MkLlrQ31IzQnIifbBCDPA8xbEkgIVGmngk3Yxpu/xJ8lTCaLi4/0f6/hgK4gjxOhCj0pJYb+2RqOumML90G4Ly4+J0paFg1YFfk+v8I8UgQq/izBNgmFCKAtxIUiXRxVPjkd9xaAB9G626w9D4X7qf0as4GOKW4liZLhMISpFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775188719; c=relaxed/simple;
	bh=Ia49qWM0aLjD4d/NXfYNBqt9v3v38NOOix7YzvFo+Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OZakHLgj54eY8t2wwaL3TtPy25aJum3d8dFf1AOXMD3Raam0znFBtQYfvdJtxGmT+SJGaFBhAfsgsphc6kRiDOdaFdXp9cHd/LFkqcKEqmj12qSjq4B81nav/UgDCRROIXNifhtqgK+NZLQx0Adc3egsTBsDCHFv4tqQzLsS1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5ae481d42f1111f1aa26b74ffac11d73-20260403
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:8e96dfda-0a47-467b-a0d4-f0ffad8b3775,IP:15,
	URL:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.3.12,REQID:8e96dfda-0a47-467b-a0d4-f0ffad8b3775,IP:15,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-10
X-CID-META: VersionHash:e7bac3a,CLOUDID:b5fb56d1ddabc85324c6c1255d88174c,BulkI
	D:2604031158244AQMXFBT,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_AEC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5ae481d42f1111f1aa26b74ffac11d73-20260403
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1399895716; Fri, 03 Apr 2026 11:58:21 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH v2] fuse: Send FORGET over io_uring when ring is ready
Date: Fri,  3 Apr 2026 11:57:52 +0800
Message-Id: <20260403035752.20206-1-liwang@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once the FUSE io_uring is registered and marked ready, most request
types are delivered through io_uring, while FORGET notifications were still
queued with fuse_dev_queue_forget() and only consumed through the legacy
path on /dev/fuse.

Deliver single FORGET operations through fuse_uring_queue_fuse_req() when
the ring is ready. Otherwise, fall back to the legacy forget list path so
behavior matches the previous implementation.

Benefits:
- While io-uring is active, the daemon can handle forgets in the same
  commit/fetch loop as other opcodes instead of also draining a separate
  /dev/fuse read path for forget traffic.
- Reduces split-brain transport for high-volume forgets (eviction,
  unmount) when the ring is already the primary channel, which simplifies
  userspace and keeps teardown forgets on the same completion path as
  other uring-backed work.
- Reuses the same per-queue io-uring machinery and noreply/force request
  setup (creds, FR_WAITING/FR_FORCE, etc.) already used for similar
  kernel-initiated traffic.

Signed-off-by: Li Wang <liwang@kylinos.cn>
---
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

 fs/fuse/dev.c        | 28 +++++++++++----
 fs/fuse/dev_uring.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_dev_i.h | 15 ++++++++
 3 files changed, 119 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b212565a78cf..558c05862f68 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -137,7 +137,7 @@ static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
 	req->create_time = jiffies;
 }
 
-static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
+struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
 {
 	struct fuse_req *req = kmem_cache_zalloc(fuse_req_cachep, flags);
 	if (req)
@@ -175,7 +175,7 @@ static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
 	       (fc->io_uring && fc->connected && !fuse_uring_ready(fc));
 }
 
-static void fuse_drop_waiting(struct fuse_conn *fc)
+void fuse_drop_waiting(struct fuse_conn *fc)
 {
 	/*
 	 * lockess check of fc->connected is okay, because atomic_dec_and_test()
@@ -335,8 +335,8 @@ __releases(fiq->lock)
 	spin_unlock(&fiq->lock);
 }
 
-void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
-			   struct fuse_forget_link *forget)
+void fuse_dev_queue_forget_list(struct fuse_iqueue *fiq,
+				struct fuse_forget_link *forget)
 {
 	spin_lock(&fiq->lock);
 	if (fiq->connected) {
@@ -349,6 +349,20 @@ void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
 	}
 }
 
+void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
+			   struct fuse_forget_link *forget)
+{
+#ifdef CONFIG_FUSE_IO_URING
+	struct fuse_conn *fc = container_of(fiq, struct fuse_conn, iq);
+
+	if (fuse_uring_ready(fc)) {
+		fuse_io_uring_send_forget(fiq, forget);
+		return;
+	}
+#endif
+	fuse_dev_queue_forget_list(fiq, forget);
+}
+
 void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	spin_lock(&fiq->lock);
@@ -606,7 +620,7 @@ static void __fuse_request_send(struct fuse_req *req)
 	smp_rmb();
 }
 
-static void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args *args)
+void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args *args)
 {
 	if (fc->minor < 4 && args->opcode == FUSE_STATFS)
 		args->out_args[0].size = FUSE_COMPAT_STATFS_SIZE;
@@ -639,7 +653,7 @@ static void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args *args)
 	}
 }
 
-static void fuse_force_creds(struct fuse_req *req)
+void fuse_force_creds(struct fuse_req *req)
 {
 	struct fuse_conn *fc = req->fm->fc;
 
@@ -654,7 +668,7 @@ static void fuse_force_creds(struct fuse_req *req)
 	req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
 }
 
-static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
+void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 {
 	req->in.h.opcode = args->opcode;
 	req->in.h.nodeid = args->nodeid;
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 7b9822e8837b..75579e488937 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1358,6 +1358,89 @@ bool fuse_uring_remove_pending_req(struct fuse_req *req)
 	return fuse_remove_pending_req(req, &queue->lock);
 }
 
+struct fuse_forget_uring_data {
+	struct fuse_args args;
+	struct fuse_forget_in inarg;
+};
+
+static void fuse_forget_uring_free(struct fuse_mount *fm, struct fuse_args *args,
+				   int error)
+{
+	struct fuse_forget_uring_data *d =
+		container_of(args, struct fuse_forget_uring_data, args);
+
+	kfree(d);
+}
+
+/*
+ * Send FUSE_FORGET through the io-uring ring when active; same payload as
+ * fuse_read_single_forget(), with userspace committing like any other request.
+ * Called from fuse_dev_queue_forget() when fuse_uring_ready().
+ */
+void fuse_io_uring_send_forget(struct fuse_iqueue *fiq,
+				struct fuse_forget_link *forget)
+{
+	struct fuse_conn *fc = container_of(fiq, struct fuse_conn, iq);
+	struct fuse_mount *fm;
+	struct fuse_req *req;
+	struct fuse_forget_uring_data *d;
+
+	if (!fuse_uring_ready(fc)) {
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
+	atomic_inc(&fc->num_waiting);
+	req = fuse_request_alloc(fm, GFP_KERNEL);
+	if (!req) {
+		kfree(d);
+		fuse_drop_waiting(fc);
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
+	kfree(forget);
+
+	fuse_force_creds(req);
+	__set_bit(FR_WAITING, &req->flags);
+	if (!d->args.abort_on_kill)
+		__set_bit(FR_FORCE, &req->flags);
+	fuse_adjust_compat(fc, &d->args);
+	fuse_args_to_req(req, &d->args);
+	req->in.h.len = sizeof(struct fuse_in_header) +
+		fuse_len_args(req->args->in_numargs,
+			      (struct fuse_arg *)req->args->in_args);
+
+	fuse_uring_queue_fuse_req(fiq, req);
+	return;
+
+fallback:
+	fuse_dev_queue_forget_list(fiq, forget);
+}
+
 static const struct fuse_iqueue_ops fuse_io_uring_ops = {
 	/* should be send over io-uring as enhancement */
 	.send_forget = fuse_dev_queue_forget,
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 134bf44aff0d..0e6bd08c421f 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -68,8 +68,23 @@ int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numargs,
 		   int zeroing);
 int fuse_copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
 		       unsigned int nbytes);
+struct fuse_mount;
+struct fuse_conn;
+
+struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags);
+void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args *args);
+void fuse_force_creds(struct fuse_req *req);
+void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args);
+void fuse_drop_waiting(struct fuse_conn *fc);
+
+void fuse_dev_queue_forget_list(struct fuse_iqueue *fiq,
+				struct fuse_forget_link *forget);
 void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
 			   struct fuse_forget_link *forget);
+#ifdef CONFIG_FUSE_IO_URING
+void fuse_io_uring_send_forget(struct fuse_iqueue *fiq,
+			       struct fuse_forget_link *forget);
+#endif
 void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req);
 bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock);
 
-- 
2.34.1

