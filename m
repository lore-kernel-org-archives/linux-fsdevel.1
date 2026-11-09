Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794192009;
	b=io459NFG897ozXHVD+8QJ8InZR3QOZeluNwWetnMnlHrxPFV0Lf/o/DDoIMLQrb2fL4D
	 F8Ac1D1WPyQ4DfaBD6gQSqpypjtLJmHeLZaXaPcfSfysyTc2xg2snFxZKWCs4zKxhnb0n
	 kdo0+Rl97Hly5kCl51nUTx8SMZj2QQGQvQy5JveFPcW2V4dIxAma4guBe+wUK70hBfhKi
	 YkZf3Q4gnQgFl1lg6jiEiwVlU1xACLDHk8WXX346VxcCONByEzQLYP2Rz8r/sdXi6dvbA
	 Vk3TkvgXpSRLuDi28C7rsi6KrcjllVoA07Hzn/DVGpYPMUV+LWzFN/Mmq60XRnY90+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hamfHniDHGCKRAw+vpTUWbv3vFb7E6pjHS73N4V1Z68=;
	b=QOVzZa+L+6NYpVSs7PRnlqneQHBSJLc4jIzMCNbc6dy2/kroSclnWzRiaYnCT6ILEzdx
	 8nE+5u435neIo///J+9RiJouWghp8i7LH1vYPF5FIgyxbOHCWBLkwiOAIHFI0C+SRqtK5
	 04qreq2BXGUAKb9iGKA8QdsQYNe17DqU2mTMCIcc3ESbQlXY2Um78ehQz02RkLHMe0Em6
	 vHfNsdWHmnmqaXE5Iu5ySXQJivkHUwtkIo9OHi/3rz3bePccW/BlWXtSzx7JD1t0QFtmu
	 ZUP/FxhFi8meBTi46rPYW1EChyJIBIW1gGgHfDHMSfda0/8hg1WHtRE3a6xawjQFSig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cS22eW3r;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F209606A332
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 02:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F209606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cS22eW3r
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ed3df47bc7so541935ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 18:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794192008; x=1794796808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hamfHniDHGCKRAw+vpTUWbv3vFb7E6pjHS73N4V1Z68=;
        b=cS22eW3rsIFu8ZM+yFqshxVxqi0YVotkEQOOqXilZqZjcCJ+1Fz14Tpw/77Tc2Hgb4
         C+65zfLGJkOkct+HclLyOm925z7l2mUHkgF6kahQYMLxdIzRL5g1UnshAA6beh3+Ef5/
         IglEBkWdkDDNSy7j285QqwCUV1uLeZgIK8q7g5Ko/9A9rZ4B22uSw81cTqQV36iezZpX
         OSfCMoe+H0Y0u3NGhorFQT7uz+RlS8I4cZH1d9jEhoUoXdSOHQbsfw1TNaMJjwKAQeI8
         OJRA2iJZ+3U5axF8+CfVMjPJW0+cu1t7ms20OJZdy3r+/aVNRBjiKFRIgiuD64fJ0nbn
         HwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794192008; x=1794796808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hamfHniDHGCKRAw+vpTUWbv3vFb7E6pjHS73N4V1Z68=;
        b=seoH9T+ac8w5qXh41qbopLnrLaydjIfxTbySEoioEco61FJpWRV7MAc4YOlzo7v7Dj
         iTwtEgTHD+EeWdc/+zVwilPKtuEXOYvxQ3OqQt5Q6dld00Q47AudQBFkltAQzuERWVGp
         mcl1BDBaCrhn4O/iZNKhTIaJorb17abUFSxVyZSKnpyXS6e77JGjzkgoyFfOkOab9nS6
         nyTiXijrXzRv8D3b9hP8p8udKczhh3Oh3UMzHslZbuD0v46tF3UjzrKmOzOB0vxUAets
         Pr6G0U6ex6k0dJUtkKauEE5ZJwCMPFBwaNgV7a9kzHMCEFP2XAo3JzoL8mjlC+JtWuV+
         D7NQ==
X-Forwarded-Encrypted: i=1; AL+hErE/YxvChQwu7+cxotsKVCv3HDeE8bK8nqfgM7Lc2zFuV0Mv5Zlc/RBbrGasC11oKsvhgmNg+DkpwTvhX34N@vger.kernel.org
X-Gm-Message-State: APuU4Z+jT99hmn7SfNdZ5654Up74q9n+cV6t3spNnsYQ2+OzgR0Hp/QA
	O3JWaDcGvnKflO57QV+9wAwpx4C9J6W0bMIG+4OT1Kxm7JnLEFQI5OPF
X-Gm-Gg: AYBFou2uyuVa+ToEyN8ahfHSLhlRH04zmwBDndOiVzV9qpJ5o/sI7KGEWT8mT2PqQYi
	2PVWXZWpmbVYsO5gS35M5fI9TNn/hd9uK+6sSU+uIBGAWc0BQ2Vzg8dUExwkhqfMbsYTXIdULoh
	BulLUvOCbP2pTIuuH+3PtgzneRikxygKC4SeqVFUffIQbWuwB3t9/IMhfOgaH0a1BxF0fXYNlHV
	mfAAtnfNR6SqQpHUJn9g59BF8EhEqjqehNCwY4cExlF4EsrMyGO3miCXA4GejMr4Jafn2+a6/Zu
	w5I/NeAo6jGITQGAEtvm/E8H+X4SFwRAaeXFOA85Yz5sIWnDGZlwgO+0IzbIF7Zr+k6qvnCemt6
	xZuWg594HPmFJBIiZ8fyvN0H+lk9prArb9aJW/HAlMdK9SZ2MJDSCr6TMlIayRbsYhCEAQPYF8o
	CBDwhqxAUeFuoYVMye52TODyMzxljxTFtTGxV8Ffwwelksnv9LzrnElK5f3NHxrjdgAiYa3wpDc
	K///yrIw6utghi6MBNjjKdtuumofTxzWJx4QXMm959zNYpRNJefcDaeXS5wCvGxe4yHO5HKKoDR
	1LWfbYEC8q5g4OabINp27zefF7QlRtvolajE3pSbp8pdXf/YNtIxiFfMl9C4CTBQEmNXLCAk0Qc
	vI7rmG30fF14nvzeZ
X-Received: by 2002:a17:903:2289:b0:2df:8ab7:fe3a with SMTP id d9443c01a7336-2ed83786890mr43450945ad.4.1794192008326;
        Sun, 08 Nov 2026 18:40:08 -0800 (PST)
Received: from localhost.localdomain ([139.159.170.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed81600c3esm6172515ad.34.2026.11.08.18.40.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 18:40:07 -0800 (PST)
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
Subject: [PATCH v3] fuse: virtio-fs: stop new requests before draining queues
Date: Mon,  9 Nov 2026 10:39:57 +0800
Message-ID: <20261109023957.34500-1-q.h.hack.winter@gmail.com>
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

virtio_fs_conn_destroy() drains the virtqueues and then calls
fuse_conn_destroy(), which aborts the connection.  The abort ends every
request the fuse device still owns, and each ended request is freed as
soon as its waiter wakes up.

The drain only covers the requests that were already counted in
fsvq->in_flight when it started.  A request submitted after it returns is
not covered, but is still handed to the device before the abort runs:

  CPU 0 (umount)                     CPU 1
  ---------------------------------  --------------------------------
  virtio_fs_drain_all_queues()
    /* in_flight drops to 0 and
       the drain returns */
                                     virtio_fs_enqueue_req()
                                       virtqueue_add_sgs()
                                       inc_in_flight_req() -> 1
  fuse_conn_destroy()
    fuse_send_destroy()
    fuse_chan_abort()
      /* ends and frees the
         request above */
    fuse_chan_wait_aborted()
                                     /* the device still owns the
                                        virtqueue descriptors and
                                        DMA-writes into the freed
                                        request and its argbuf */

Stop admitting requests on each queue before draining begins.  The flag
is set per queue, but that is sufficient: request admission,
virtqueue_add_sgs() and, on the submission path, the in_flight
increment are serialized by the same fsvq->lock.  A request is
therefore either rejected before the device can see it, or already
counted in fsvq->in_flight and covered by the drain.  There is no
window in between.

Rejected requests use the existing -ENOTCONN error path and are ended by
virtio_fs_request_dispatch_work() through end_reqs, so no new request
completion or ownership state is introduced.  Nothing has to be
discarded in the completion path, and fsvq->in_flight remains the only
per-queue accounting state.

The -ENOSPC path needs the same admission check.  virtio_fs_enqueue_req()
drops fsvq->lock before returning -ENOSPC, and the caller queues the
request in a second critical section; teardown can finish in between and
leave the request stranded on queued_reqs, which nothing drains.
Re-check connected/aborting before queueing, in both the submission path
and the dispatch worker.  After aborting is set, no request can newly
enter queued_reqs or the virtqueue, except the explicitly permitted
FUSE_DESTROY path.

Rejected requests are ended by virtio_fs_request_dispatch_work().  If
their end callback may block (a DAX release), ending them inline can
deadlock: the callback may issue a synchronous request that needs the
same worker.  Offload those endings to a separate work item, like the
device completion path already does.

The new state is not folded into fsvq->connected because the request
queues have to stay usable: fuse_conn_destroy() sends FUSE_DESTROY
through them, with args.force set so that fuse_simple_request() waits
for the reply.  Clearing fsvq->connected would make that request fail
with -ENOTCONN and the server would never see the destroy.

FUSE_DESTROY is the sole exception while aborting is set.  It is sent
only after the first drain, and its completion is waited for before
fuse_chan_abort() can end requests, so the destroy is the only request
the device sees after the drain.  virtio-fs exposes no userspace
/dev/fuse fd (and no_control disables the fusectl interface), so
userspace cannot inject another request.

virtio_fs_start_all_queues() clears the flag, so a mount that follows an
unmount starts with admission enabled again.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
V2 -> V3:
- re-check admission before queueing on -ENOSPC, in virtio_fs_send_req()
  and in the dispatch worker, so teardown cannot strand a request on
  queued_reqs
- offload may_block request endings in the dispatch worker to avoid a
  self-deadlock through fuse_simple_request()
- add Fixes: and Cc: stable
V1 -> V2:
- prevent new requests from reaching the virtqueue at teardown time
  instead of skipping completions of aborted requests
- keep FUSE_DESTROY working: it is the teardown request and is waited
  for before fuse_chan_abort()
- drop the per-vq aborted flag and the completion-skip branch
 fs/fuse/virtio_fs.c | 104 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ba8d79c4bcac6..a46536c9fdc8e 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -55,6 +55,7 @@ struct virtio_fs_vq {
 	struct work_struct dispatch_work;
 	struct fuse_dev *fud;
 	bool connected;
+	bool aborting; /* reject new requests except FUSE_DESTROY */
 	long in_flight;
 	struct completion in_flight_zero; /* No inflight requests */
 	struct kobject *kobj;
@@ -97,6 +98,11 @@ struct virtio_fs_req_work {
 	struct work_struct done_work;
 };
 
+struct virtio_fs_end_work {
+	struct work_struct work;
+	struct fuse_req *req;
+};
+
 static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 				 struct fuse_req *req, bool in_flight,
 				 gfp_t gfp);
@@ -348,6 +354,7 @@ static void virtio_fs_start_all_queues(struct virtio_fs *fs)
 		fsvq = &fs->vqs[i];
 		spin_lock(&fsvq->lock);
 		fsvq->connected = true;
+		fsvq->aborting = false;
 		spin_unlock(&fsvq->lock);
 	}
 }
@@ -551,6 +558,39 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 	spin_unlock(&fsvq->lock);
 }
 
+static void virtio_fs_end_req_work(struct work_struct *work)
+{
+	struct virtio_fs_end_work *w =
+		container_of(work, typeof(*w), work);
+
+	fuse_request_end(w->req);
+	kfree(w);
+}
+
+/*
+ * A request rejected during teardown can have an end callback that may
+ * block (DAX release).  Ending it inline in virtio_fs_request_dispatch_work()
+ * can deadlock: the callback may issue a synchronous request whose
+ * completion needs the same dispatch_work that is currently blocked.
+ * Offload it, like the device completion path does.
+ *
+ * virtio_fs_request_complete() cannot be reused here: it also consumes
+ * argbuf and drops in_flight, while a rejected request has neither.
+ */
+static void virtio_fs_end_req(struct fuse_req *req)
+{
+	if (req->args->may_block) {
+		struct virtio_fs_end_work *w;
+
+		w = kzalloc_obj(*w, GFP_NOFS | __GFP_NOFAIL);
+		INIT_WORK(&w->work, virtio_fs_end_req_work);
+		w->req = req;
+		schedule_work(&w->work);
+	} else {
+		fuse_request_end(req);
+	}
+}
+
 static void virtio_fs_request_dispatch_work(struct work_struct *work)
 {
 	struct fuse_req *req;
@@ -570,7 +610,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 
 		list_del_init(&req->list);
 		spin_unlock(&fsvq->lock);
-		fuse_request_end(req);
+		virtio_fs_end_req(req);
 	}
 
 	/* Dispatch pending requests */
@@ -593,9 +633,17 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 		if (ret < 0) {
 			if (ret == -ENOSPC) {
 				spin_lock(&fsvq->lock);
-				list_add_tail(&req->list, &fsvq->queued_reqs);
-				spin_unlock(&fsvq->lock);
-				return;
+				if (!fsvq->connected ||
+				    (fsvq->aborting &&
+				     req->in.h.opcode != FUSE_DESTROY)) {
+					spin_unlock(&fsvq->lock);
+					ret = -ENOTCONN;
+				} else {
+					list_add_tail(&req->list,
+						      &fsvq->queued_reqs);
+					spin_unlock(&fsvq->lock);
+					return;
+				}
 			}
 			req->out.h.error = ret;
 			spin_lock(&fsvq->lock);
@@ -603,7 +651,7 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
 			spin_unlock(&fsvq->lock);
 			pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n",
 			       ret);
-			fuse_request_end(req);
+			virtio_fs_end_req(req);
 		}
 	}
 }
@@ -1226,6 +1274,28 @@ static void virtio_fs_stop_all_queues(struct virtio_fs *fs)
 	}
 }
 
+/*
+ * Stop admitting new requests before draining the queues.  Admission and
+ * virtqueue submission are serialized by fsvq->lock, so a request is
+ * either rejected before reaching the device or accounted in in_flight
+ * and covered by the drain.
+ *
+ * FUSE_DESTROY is exempt because fuse_conn_destroy() sends it after the
+ * first drain and waits for its completion before aborting the channel.
+ */
+static void virtio_fs_stop_new_requests(struct virtio_fs *fs)
+{
+	struct virtio_fs_vq *fsvq;
+	int i;
+
+	for (i = 0; i < fs->nvqs; i++) {
+		fsvq = &fs->vqs[i];
+		spin_lock(&fsvq->lock);
+		fsvq->aborting = true;
+		spin_unlock(&fsvq->lock);
+	}
+}
+
 static void virtio_fs_remove(struct virtio_device *vdev)
 {
 	struct virtio_fs *fs = vdev->priv;
@@ -1479,7 +1549,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 
 	spin_lock(&fsvq->lock);
 
-	if (!fsvq->connected) {
+	if (!fsvq->connected ||
+	    (fsvq->aborting && req->in.h.opcode != FUSE_DESTROY)) {
 		spin_unlock(&fsvq->lock);
 		ret = -ENOTCONN;
 		goto out;
@@ -1551,12 +1622,22 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 			/*
 			 * Virtqueue full. Retry submission from worker
 			 * context as we might be holding fc->chan->bg_lock.
+			 * Re-check admission under the same lock that
+			 * increments in_flight: teardown may have started
+			 * between enqueue_req() dropping its lock and here.
 			 */
 			spin_lock(&fsvq->lock);
-			list_add_tail(&req->list, &fsvq->queued_reqs);
-			inc_in_flight_req(fsvq);
-			spin_unlock(&fsvq->lock);
-			return;
+			if (!fsvq->connected ||
+			    (fsvq->aborting &&
+			     req->in.h.opcode != FUSE_DESTROY)) {
+				spin_unlock(&fsvq->lock);
+				ret = -ENOTCONN;
+			} else {
+				list_add_tail(&req->list, &fsvq->queued_reqs);
+				inc_in_flight_req(fsvq);
+				spin_unlock(&fsvq->lock);
+				return;
+			}
 		}
 		req->out.h.error = ret;
 		pr_err("virtio-fs: virtio_fs_enqueue_req() failed %d\n", ret);
@@ -1669,6 +1750,9 @@ static void virtio_fs_conn_destroy(struct fuse_mount *fm)
 	spin_lock(&fsvq->lock);
 	fsvq->connected = false;
 	spin_unlock(&fsvq->lock);
+
+	/* Nothing may be queued after the drain below */
+	virtio_fs_stop_new_requests(vfs);
 	virtio_fs_drain_all_queues(vfs);
 
 	fuse_conn_destroy(fm);
-- 
2.54.0 (Apple Git-157)

