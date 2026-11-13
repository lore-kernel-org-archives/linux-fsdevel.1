Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794561561;
	b=06dG44SsW48Uf3tPHuexHjisw5s500ivAKCF9ROkTEoTeV/ULxPQ23Y6UWdZENbwn7jT
	 eu03K4ynTN7VWQiDq2Bw9wsfRR1euw8qFOXJV8+SIBaoQXO0klETPF2Bkd4K45ghROyjP
	 xY30smCxAH8rwMUrxRc+zobLp17PN1gdSETsvAAUFhbjNPDAVgiFAzheKueJtJvC2jP22
	 UeJjt+YJlEWpFd24WzqAl8g7b+fISADSvg8lGn3cVYkhxXxsDWulo/Z/8axPuLv9JrevH
	 sLkM/MEgqt9CAFat3YHZ1a1yDiwDtH4quP5Gh4BVaXB+IICuRDT/PRTMkmDWOdzKWBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794561561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z1LQUshJLGbDwVy+51FQZk6WUkcWSvGfBiCbiuDiBL4=;
	b=ouulOoh1OxIpTKezFqpPeiPnOQ8bOC92jvY5X1lm1w7jstJjA/FcfkYPaxLbfEMtjnOE
	 p6Ey8M/9t+xRpGufNAeQCDkRIvcqY1tGOEmHlDo1e/nhdOmc/VNrbs6NZK1mUjM2+KU7z
	 eUtQ46h2+dx/bJkSbN6wHpelA5FGkqgj5V0nC1oncEZpihqdAnv9h/w0zHIY1vKJRBtzc
	 q3QeDVPt/CE5/QfH4YGGxr/C9PWdNAqLYhqiUlPFZd2NKj/Nn2tgPGAhqYyoOO9Clt+Mg
	 hQ7fBMLyPnno2gr2tA7E9mVUSiuHAaoxyKgOvtot+rz/GVEmqO8d5z0EdW0cU2EIa4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="PLWbQ/v1";
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDAF606A327
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 09:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDDAF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PLWbQ/v1
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd5e295c8a6so83680a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 01:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794561560; x=1795166360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z1LQUshJLGbDwVy+51FQZk6WUkcWSvGfBiCbiuDiBL4=;
        b=PLWbQ/v1klXC8S4HpgHOKDqMqtb1cJMHOyN4erLefZyDJbTBfnJhI78vwsS8asWzDX
         CILDdPI+K0mxx37jh0q0XoE7Zbpj5W4JzHG+vnjcdZJ26SsGw+Cxz0OdMxNG+lPfTMJi
         ZRD2/meZLh3C8ndCBr9bGuwdE9qwjRoJuAC92CQLX2f3pZBwzDlcEF+kJO+At6m0AhSY
         Ekk0RTMH8urE37+YxmrKy2wHD9QAcRogxc0Y+raJheFcxa1/WeQZEgTApYEZ7KvrS9a1
         XfSLKg5cLI4Q03PMXyCsxjO2ljo//YbnE1topsPkPwgRbedK4RN6vRMtC5vpYOxQaCJs
         WDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794561560; x=1795166360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z1LQUshJLGbDwVy+51FQZk6WUkcWSvGfBiCbiuDiBL4=;
        b=s5upjsDN+3XhrxUlasn1EdM+MrLIkkdolTK1ski17dIGMXqqCxVCRhsuqXFAx0bVTA
         FC5QKXQPmfRfhujbp9q6DImTpzrOlOPR3s61WAWMo0mnBjWS9GDv0ZD28JlSH3Vl3mxD
         YTM0fcSJf2aOYMD5hDhT+Wl+2ULuKVTR93TfPP7Q6DaGsE1AwW+K2eLbqev+MIwEYN8u
         0R/MmXoHOKpwhuUcOX/v0RajhTNgw1pFw4B/z7F6ANCXBdxZN69unk3+0rnWn2BIGA84
         9Y+cjVmJuKOyF3pIX7zQVA7sxjjTe5q1tt1ETSfv5SIWrNGYYgtBZoCvkta6KOmWoBXC
         I1PQ==
X-Forwarded-Encrypted: i=1; AL+hErEJbTmhL6YISwVD4N01uIKGtXgvqvikWorjMTLMoSKVTlat3CCElQ83TKLnv0XNtmKCnT/X4vSvBGn1vqzT@vger.kernel.org
X-Gm-Message-State: APuU4Z/EADo3mUYON1jVDWc+ZBCuwJtfdwtG9FRs+pyQ0KcD/M/JSVki
	Boz3zeYzp74hqg3lgq5ojhjHhZfXxG/eq71XHCy88N1GM55IMKbPuORn
X-Gm-Gg: AYBFou1K7qJbdu5rzLMqHMk3bycA4Eez2fGF/9nMCtz+T4ABHMnIJlbCEoKIutsVFOb
	vrYCfv2uADXR62hgqY5OmUkJpeKABbMXjejxoSSPkGyj4l+Y2gye/SETaSfaD26EnBDluGF+7tJ
	sAWrS4WCAAbskOVHhAsWIg+MidIA9AWKABsYnN8tnR9O49OoD0He/Fs6u4RtvncI7q6WRvJmHvu
	U2iJTG0Ye8yyJTfXE83DYBNyiv8doyiQIb9TqJT6Ao7HPEgjX4V9nbUqqVz2Va396yYb+rsqZ82
	7MZ1DPQ8ZVy2LHc4T43Qh7XaGeyNuU+4T+NKQFvwEmcxxGH+nT5Tz5Zhyfm5X1BSjUyVmv8o5Gb
	35rcfSjPIilLTPZjeY6M71J7TEKXbr/GhNr2tRWeiPEx3izo0UmC5yBgIcv6TLZsFK76yj+wELQ
	X1D5lkoIlbHZAgfuLFGJR0AuLLt0l9tk8maEmWp3o7XncUV3H6vqqCj505M+ngqlG6XNu1tIlgx
	LRt7XrsWOH6B1gbGpfRatKTnoUcKmZ/POVxus5HzzZzekO+RcekB9pPipY9fn/z0yufa4hquRgC
	RU2FDpgfzGkf5HuJrdKfGXcZpzZLuHDHGZbvVSzsWF0=
X-Received: by 2002:a17:90b:1b06:b0:3a4:c895:570 with SMTP id 98e67ed59e1d1-3b1b0a0e7c9mr2734651a91.4.1794561559965;
        Fri, 13 Nov 2026 01:19:19 -0800 (PST)
Received: from localhost.localdomain ([139.159.170.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb17042sm3567991a91.6.2026.11.13.01.19.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 01:19:19 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: "Eugenio Perez" <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] fuse: virtio-fs: fix lost wakeup on a full virtqueue
Date: Fri, 13 Nov 2026 17:17:58 +0800
Message-ID: <20261113091758.77678-1-q.h.hack.winter@gmail.com>
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
Content-Transfer-Encoding: 8bit

When virtio_fs_enqueue_req() returns -ENOSPC, completion processing
can run before the caller adds the request to queued_reqs. If no
further completions arrive, dispatch is never scheduled and the
request remains counted in in_flight, hanging queue draining.

Track completion progress under fsvq->lock and sample it when
submission fails with -ENOSPC. After queueing, schedule dispatch if
the sequence changed; otherwise completion processing will see the
queued request and schedule it. Each failed submission keeps its own
snapshot, so concurrent submitters cannot consume each other's wakeup.

Fixes: 106e4df1206b ("virtio-fs: improved request latencies when Virtio queue is full")
Cc: stable@vger.kernel.org # 6.11+
Link: https://lore.kernel.org/all/sashiko-outbox-204365@kernel.org/
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
Changes since v3:

- Only the lost-wakeup fix is included here.  v3 also carried teardown
  admission control; that is a separate change, not part of this patch,
  and nothing here depends on it.
- Add a completion sequence sampled per failed submission to close the
  window between -ENOSPC and queue insertion.

Runtime tests used an arm64 kernel with the separate teardown
admission change also applied.  The request scenarios ran before
admission was stopped, with fsvq->aborting remaining false.  The
standalone patch was not run on its own.

- Filled the request virtqueue and held the submitter between -ENOSPC and
  queue insertion while real device completions ran.  The unpatched
  kernel hung in virtio_fs_drain_queue(); this change finished the drain.
- Held the dispatch worker in the same place.  The unpatched kernel
  stranded the request; this change rescheduled dispatch once more and
  every request finished.
- Kept the queue full without completions: dispatch did not reschedule
  itself in a loop.

 fs/fuse/virtio_fs.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index e445398..68aeaa6 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -55,6 +55,7 @@ struct virtio_fs_vq {
 	struct work_struct dispatch_work;
 	struct fuse_dev *fud;
 	bool connected;
+	u64 completion_seq; /* completion progress under lock */
 	long in_flight;
 	struct completion in_flight_zero; /* No inflight requests */
 	struct kobject *kobj;
@@ -99,7 +100,7 @@ struct virtio_fs_req_work {
 
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight,
-				 gfp_t gfp);
+				 gfp_t gfp, u64 *completion_seq);
 
 static const struct constant_table dax_param_enums[] = {
 	{"always",	FUSE_VDAX_ALWAYS },
@@ -348,6 +349,7 @@ static void virtio_fs_start_all_queues(struct virtio_fs *fs)
 		fsvq = &fs->vqs[i];
 		spin_lock(&fsvq->lock);
 		fsvq->connected = true;
+		fsvq->completion_seq = 0;
 		spin_unlock(&fsvq->lock);
 	}
 }
@@ -576,6 +578,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 	/* Dispatch pending requests */
 	while (1) {
 		unsigned int flags;
+		u64 completion_seq;
 
 		spin_lock(&fsvq->lock);
 		req = list_first_entry_or_null(&fsvq->queued_reqs,
@@ -588,12 +591,15 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 		spin_unlock(&fsvq->lock);
 
 		flags = memalloc_nofs_save();
-		ret = virtio_fs_enqueue_req(fsvq, req, true, GFP_KERNEL);
+		ret = virtio_fs_enqueue_req(fsvq, req, true, GFP_KERNEL,
+					    &completion_seq);
 		memalloc_nofs_restore(flags);
 		if (ret < 0) {
 			if (ret == -ENOSPC) {
 				spin_lock(&fsvq->lock);
 				list_add_tail(&req->list, &fsvq->queued_reqs);
+				if (completion_seq != fsvq->completion_seq)
+					schedule_work(&fsvq->dispatch_work);
 				spin_unlock(&fsvq->lock);
 				return;
 			}
@@ -902,6 +908,8 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 
 	/* Try to push previously queued requests, as the queue might no longer be full */
 	spin_lock(&fsvq->lock);
+	/* Record progress for submitters not yet on queued_reqs. */
+	fsvq->completion_seq++;
 	if (!list_empty(&fsvq->queued_reqs))
 		schedule_work(&fsvq->dispatch_work);
 	spin_unlock(&fsvq->lock);
@@ -1418,10 +1426,15 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 	return total_sgs;
 }
 
-/* Add a request to a virtqueue and kick the device */
+/*
+ * Add a request to a virtqueue and kick the device.  On -ENOSPC, return the
+ * completion sequence under the same lock as the failed submission.  If it
+ * changes before the caller queues the request, the caller must schedule
+ * dispatch itself: done_work may have run before the request was queued.
+ */
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight,
-				 gfp_t gfp)
+				 gfp_t gfp, u64 *completion_seq)
 {
 	/* requests need at least 4 elements */
 	struct scatterlist *stack_sgs[6];
@@ -1488,6 +1501,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	vq = fsvq->vq;
 	ret = virtqueue_add_sgs(vq, sgs, out_sgs, in_sgs, req, GFP_ATOMIC);
 	if (ret < 0) {
+		if (ret == -ENOSPC)
+			*completion_seq = fsvq->completion_seq;
 		spin_unlock(&fsvq->lock);
 		goto out;
 	}
@@ -1529,6 +1544,7 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	unsigned int queue_id;
 	struct virtio_fs *fs;
 	struct virtio_fs_vq *fsvq;
+	u64 completion_seq;
 	int ret;
 
 	fuse_request_assign_unique(fiq, req);
@@ -1545,7 +1561,8 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 		 queue_id);
 
 	fsvq = &fs->vqs[queue_id];
-	ret = virtio_fs_enqueue_req(fsvq, req, false, GFP_ATOMIC);
+	ret = virtio_fs_enqueue_req(fsvq, req, false, GFP_ATOMIC,
+				    &completion_seq);
 	if (ret < 0) {
 		if (ret == -ENOSPC) {
 			/*
@@ -1555,6 +1572,8 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 			spin_lock(&fsvq->lock);
 			list_add_tail(&req->list, &fsvq->queued_reqs);
 			inc_in_flight_req(fsvq);
+			if (completion_seq != fsvq->completion_seq)
+				schedule_work(&fsvq->dispatch_work);
 			spin_unlock(&fsvq->lock);
 			return;
 		}
-- 
2.54.0 (Apple Git-157)

