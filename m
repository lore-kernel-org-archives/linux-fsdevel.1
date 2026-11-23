Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415779;
	b=SajduHBzCHzfkV7sP5jAMMf2jnP2bQUZvRxDtM7BFy9o61ccnl2Q8ufN8nZ4URfysKQl
	 KGYCmsBT4CtKtXWPRcU7L1u4yiqjeF84sPP+ZjW5GaRHdj7eZuwUFIex727myuG2KzTZ8
	 zO9lCqcuwckUBhNrmMB9UATyX1n7eGlDG8fFkVTd0BwUBeahdEeeh7lxGfFwbl0d4G4xF
	 5O1XvwlN2OCsmW06ULV5p7VmmUIdXF8RAwisUpNUsTQBlgcLy1hgUcvmC6o7xmHocC7Aj
	 pB9S2+NXGaPGN3r5iU3ZspPqEOcWiBy+UdQY37S5bYkiBpH7bgVYKgVLz/aK6TTHgTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QhvI4EcrcVWaHsYhZmDudDFBhnWCIbKlWCXMmkXssF4=;
	b=OlawDnJiA98N/7qneVr42R7vlvHZXuGyK/VKXGzEKwlPNQKe649urziIP5Ovgdn1YHbL
	 3dUeF88WjwdlzDcoK/mvVKCFzksbMYWjebC2QXc9oFTsYg5dv+DpDDSs5oVdFGEkRK/K0
	 nDuosAnfi8IiPNgZzhoPYo81wCNuxiIuE7Bxgik5JHAyWnah95PYPLWyCeXq/OywQ0ZIe
	 8n0PKrEwOrI8IG2c2F6mk2THgSyhkJeuqgoye9QR/RdQ2wQ8NS8PegFj/XEpn8Np+uaao
	 kXPlfAuJ6ZqLuLjQ0BxKkkQAkyWvhFarFO+SKVf2ELe+OXUBZ6jGew/DaPv2R5ufvIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hhm0AkSU;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A6606A321
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 06:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA9A6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hhm0AkSU
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b5e147f101so257128b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 22:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795415778; x=1796020578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QhvI4EcrcVWaHsYhZmDudDFBhnWCIbKlWCXMmkXssF4=;
        b=Hhm0AkSUUa+Z/fHjxiMfsCHJXzOyXPfkaLLLIfSST7VLKaAWLPm7Hpiq1C1/k7IS4T
         4DI7WG/V0FJut0sFk0hARo6tSTpwlSXNlRkVbe+3FLm72R/dmivobmzTC5y0W7NjvYh4
         bkeLcp0b6ucPMFYKAog51kVYCbugTIirC5Vha6tNjsSLpNuABv/3halzbyo7EFqPugUr
         rJuBvSBOekQKA5Oc495UW17RrC/dBnyuSwlW5NbWfRqieoRw0OwoxEQHpu7gDbERGt2a
         uf6FvcsjtplNqoaor55/vU2lZWSUwWlgNd84nxKlUDWQWq7gn+uQwuwcfItDMH+kRK1G
         rdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795415778; x=1796020578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QhvI4EcrcVWaHsYhZmDudDFBhnWCIbKlWCXMmkXssF4=;
        b=LbbR99WZt7u7wgRjHV7f6cGwKJ8QnS5JG4SDkdZjA0XpJY23x4Qu8tkhpPGPzkSde9
         Aw1zD6ChKrYpv+BSAGtU10lNk9VASmaJkdnKiuHwzYKL61UdQywMweT2Fi0k3gTwpE+q
         H53ZOmJkEKisw6rHP1dcze2yrjZZf6R2QKj3lj1uI132pM5flm7qcgG20cMzYzFJJBZh
         YnyQFl0m9lYHFbS2zuclMjT0i+2X96p6i8kU5UZhvpwpnzbV/4+CycLDvi7s+/h7/xIA
         mF1ns1bJf5YIUAO03UlKPuLVmH7i6tkRQBPwpJBa7BtapE7RobzTafbVG1tKg7sDDDWO
         Oh1g==
X-Forwarded-Encrypted: i=1; AL+hErFTrH+w1b5qgpUCexRV3rnazAGls0gahxgR0GortzgZdtzfkw6GJ+kIFfdgjUwScocHpykm6DHZ8kP3f6u9@vger.kernel.org
X-Gm-Message-State: APuU4Z/zVUrOwlCWEEbrkm+15w2sXzWb/rfQ6m5U3K8I7W0KBrNyq7Q9
	bL5uyadign+1xXVQcVaHNnNR/z79W57HND0KQQCCMf25e+RqoNYQcgpz
X-Gm-Gg: AZFdTZcTS/RLkfRv0JG05q58tvzlIA6/29MwfwBZ4WDoIltyHDuGCGUvPwW7/Nrco5q
	zaf2vVBk5ppITohUZ3atE42O0CIUOXOhOsLPwbbiAA8Vr1Vk74qCEm76P2lf1mJQGpaAnnTXBbb
	Ju7vyeKY10AcfgMt/tlHHW8CA3soTz1W/jJ/YosCQ8L6SAM45e9MoAhzLVwgcC80wyyK2AxgQY0
	GQv7kzVaHK88lbS8+A5bTxrVm1CFv7XoWnMmuXGr+kIEMiGXk49U2XS8rrSAPE17AB0tEYIpzCY
	nJ76oWSkOG6/5Oj/ynmwiV00GOAa3XLL2jNyFlddDDCWSr90J5ZU4oy53YQA2td5itqPOB4s6Ev
	EEkjlC76kGymO3ogLHoOBvtUUV60EB4KggptdirdjgCBLrNLs7++0FhUWa0wUjKViBNPUF3jxyO
	dCTPjPw0FsiQU5aOvc17+b0WQwGB1JIfgx185wkSbCcLaOSO2wy4kRO0Y/YEmrYU/jIF1ODipBf
	UgoPVn6/4prY+xLK4Wm59H41o7hF4bRiF3gB+b0arvlGWrvPqsxctvWmIzuvf2lGA21wiBueRL5
	KkKCSpNItAmwDNU74VMd/DxTfWzsK2qEU7lBtbKXgZjOgeSXXXwmiz/PbXTp02RmIKoKZ5rmtWB
	sfNFg25O/o7SF/JJ+
X-Received: by 2002:a17:902:e38b:b0:2f0:7707:227c with SMTP id d9443c01a7336-2f0770728c8mr46065645ad.4.1795415777889;
        Sun, 22 Nov 2026 22:36:17 -0800 (PST)
Received: from localhost.localdomain ([139.159.170.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c88sm47430695ad.56.2026.11.22.22.36.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 22:36:17 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: Li Wang <liwang@kylinos.cn>
Cc: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Eugenio Perez <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtio-fs@lists.linux.dev,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH v5] fuse: virtio-fs: fix lost wakeup on a full virtqueue
Date: Mon, 23 Nov 2026 14:36:09 +0800
Message-ID: <20261123063609.82014-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <6c6cea56-1af2-4a37-b081-83244d5e09cd@kylinos.cn>
References: <6c6cea56-1af2-4a37-b081-83244d5e09cd@kylinos.cn>
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

virtio_fs_enqueue_req() drops fsvq->lock when virtqueue_add_sgs() fails
with -ENOSPC, and the caller requeues the request in a second critical
section.  Completion processing can run in between: it reaps a
completion, finds queued_reqs empty, and does not schedule dispatch.  If
the queue then goes idle, the request can remain on queued_reqs and keep
in_flight above zero.  A subsequent virtio_fs_drain_queue() can wait
indefinitely.

On -ENOSPC, add the request to queued_reqs before releasing fsvq->lock,
as send_forget_request() does.  This prevents
virtio_fs_requests_done_work() from checking queued_reqs between the
failed submission and the insertion.  Both callers can then return
immediately on -ENOSPC.

Free req->argbuf before adding the request to queued_reqs.  Once
fsvq->lock is released, the dispatch worker may already have taken the
request, so the -ENOSPC return path must skip any further access to req.

Count the request in in_flight on its first submission.  A retry keeps
the existing count.

Fixes: 106e4df1206b ("virtio-fs: improved request latencies when Virtio queue is full")
Cc: stable@vger.kernel.org # 6.11+
Link: https://lore.kernel.org/all/sashiko-outbox-204365@kernel.org/
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---

Since v4, queue the request under fsvq->lock on -ENOSPC, as Li Wang
suggested, and drop completion_seq.

 fs/fuse/virtio_fs.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index d247a02..4d4f2e3 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -596,12 +596,8 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 		ret = virtio_fs_enqueue_req(fsvq, req, true, GFP_KERNEL);
 		memalloc_nofs_restore(flags);
 		if (ret < 0) {
-			if (ret == -ENOSPC) {
-				spin_lock(&fsvq->lock);
-				list_add_tail(&req->list, &fsvq->queued_reqs);
-				spin_unlock(&fsvq->lock);
+			if (ret == -ENOSPC)
 				return;
-			}
 			req->out.h.error = ret;
 			spin_lock(&fsvq->lock);
 			dec_in_flight_req(fsvq);
@@ -1433,7 +1429,11 @@ static unsigned int sg_init_fuse_args(struct scatterlist *sg,
 	return total_sgs;
 }
 
-/* Add a request to a virtqueue and kick the device */
+/*
+ * Add a request to a virtqueue and kick the device.  If the virtqueue is
+ * full, queue the request on fsvq->queued_reqs for the dispatch worker and
+ * return -ENOSPC; the caller must not queue it a second time.
+ */
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight,
 				 gfp_t gfp)
@@ -1503,6 +1503,20 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	vq = fsvq->vq;
 	ret = virtqueue_add_sgs(vq, sgs, out_sgs, in_sgs, req, GFP_ATOMIC);
 	if (ret < 0) {
+		if (ret == -ENOSPC) {
+			/*
+			 * Queue the request before dropping fsvq->lock, so
+			 * virtio_fs_requests_done_work() cannot check
+			 * queued_reqs between the failed add and the
+			 * insertion.  Release argbuf first, as dispatch may
+			 * retry the request as soon as the lock is dropped.
+			 */
+			kfree(req->argbuf);
+			req->argbuf = NULL;
+			list_add_tail(&req->list, &fsvq->queued_reqs);
+			if (!in_flight)
+				inc_in_flight_req(fsvq);
+		}
 		spin_unlock(&fsvq->lock);
 		goto out;
 	}
@@ -1527,7 +1541,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 		virtqueue_notify(vq);
 
 out:
-	if (ret < 0 && req->argbuf) {
+	/* On -ENOSPC, dispatch may already have taken req. */
+	if (ret < 0 && ret != -ENOSPC && req->argbuf) {
 		kfree(req->argbuf);
 		req->argbuf = NULL;
 	}
@@ -1564,13 +1579,9 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	if (ret < 0) {
 		if (ret == -ENOSPC) {
 			/*
-			 * Virtqueue full. Retry submission from worker
-			 * context as we might be holding fc->chan->bg_lock.
+			 * Retry from worker context: we might be holding
+			 * fc->chan->bg_lock here.
 			 */
-			spin_lock(&fsvq->lock);
-			list_add_tail(&req->list, &fsvq->queued_reqs);
-			inc_in_flight_req(fsvq);
-			spin_unlock(&fsvq->lock);
 			return;
 		}
 		req->out.h.error = ret;
-- 
2.54.0 (Apple Git-157)

