Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CCE3AA4F6;
	Wed,  1 Apr 2026 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040064; cv=none; b=JoCxJlJFErrbXl/KyurLA05Fdn7xElSLcSLFtN1g2toTJuoGb5JSWX3QfHipfZpotKCseibdNIkfmpJv35K9ihAN++MuYaikXsM/ARIaG+srIpEAujxJx6fJrQdvfOQ1r0OID/xhyy61THLpk2P1xk+536A3SIdqPDY/71qZIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040064; c=relaxed/simple;
	bh=zxEYZUOZeW2oRPAVKSuPYLsDGRhpw96sZBrh73WaNcc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KQYm+RmIWTm1Mkw+iwyBQB7HWQBTBAovNV0BM24ARoNtFsNo4bD26P9/1YaiJP5iLjPiewKZZ532K4Oryj2FNIT41Y5MmzkzCIe9PFci6yQqbExWAOdLlMHWNjTQ2RDOdrnA8Rbi2Tt4q7n5/Fa4B8wvIXkO9+c25WmGhSqkmao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 42d91aec2db711f1aa26b74ffac11d73-20260401
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:215b2493-3bdd-451f-b0c8-ec1a0e85e66a,IP:15,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:215b2493-3bdd-451f-b0c8-ec1a0e85e66a,IP:15,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:8c327c976b551aa80324836e7f0189be,BulkI
	D:260401184057ZG8JMK9L,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|898
	,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 42d91aec2db711f1aa26b74ffac11d73-20260401
X-User: liwang@kylinos.cn
Received: from computer.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1267948543; Wed, 01 Apr 2026 18:40:54 +0800
From: Li Wang <liwang@kylinos.cn>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Wang <liwang@kylinos.cn>
Subject: [PATCH] fuse: Send FORGET over io_uring when ring is ready
Date: Wed,  1 Apr 2026 18:40:08 +0800
Message-Id: <20260401104008.8827-1-liwang@kylinos.cn>
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
the ring is ready. Otherwise, fall back to fuse_dev_queue_forget()
so behavior matches the previous implementation.

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
 fs/fuse/dev.c        | 84 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring.c  |  2 +-
 fs/fuse/fuse_dev_i.h |  4 +++
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b212565a78cf..f58abc80fd7b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -665,6 +665,90 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 		__set_bit(FR_ASYNC, &req->flags);
 }
 
+#ifdef CONFIG_FUSE_IO_URING
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
+		fuse_dev_queue_forget(fiq, forget);
+		return;
+	}
+
+	down_read(&fc->killsb);
+	if (list_empty(&fc->mounts)) {
+		up_read(&fc->killsb);
+		fuse_dev_queue_forget(fiq, forget);
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
+	fuse_dev_queue_forget(fiq, forget);
+}
+#endif
+
 ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 			      struct fuse_mount *fm,
 			      struct fuse_args *args)
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 7b9822e8837b..a96539ea400a 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1360,7 +1360,7 @@ bool fuse_uring_remove_pending_req(struct fuse_req *req)
 
 static const struct fuse_iqueue_ops fuse_io_uring_ops = {
 	/* should be send over io-uring as enhancement */
-	.send_forget = fuse_dev_queue_forget,
+	.send_forget = fuse_io_uring_send_forget,
 
 	/*
 	 * could be send over io-uring, but interrupts should be rare,
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 134bf44aff0d..264a25d7e47a 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -70,6 +70,10 @@ int fuse_copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
 		       unsigned int nbytes);
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

