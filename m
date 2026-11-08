Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146320;
	b=rPPt+D3enyjB7ZnisPFvBlRZ9soywXjUjrFRY+Q5FNnLNgN5Se6yRZHU0b7f2aLUIntj
	 G2YDgxwz75Vin92Ujs1mVm7njLCrFXgCQ6k1YOHvFbbBq0vGEYPURdsH0/wnoJgEIdNAc
	 yXaReOhIqX/n9bdyj9ajAR9B3vecno0zZ5JGXEgbn594AefhssyiFGzd8NzOVVQyL5Qu1
	 +UBWqcqK3jtSp+6Kes0OJQrOs32oe+Wc1I8tt7G9geEBH2bSHytKmi0cgAkXgP9ASxywD
	 HmM0Z6/QuPwAedoXLwfqKNri3D7zgR6ORIhDOuNMR79fz6tFdyp/Efmp/Q+7IJYqM7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nIt2c7TgqELjjufCcZKCuw1pwzNN3kz5J9LhJ3UcC28=;
	b=V7iJBZzaRk0d9RkP3KHJv9aMDv5TJ3Qkx/qT1VBg++Jag01hmUAcsRC+JmaTUckkTqer
	 E++R7qlGyEwQZzxzO4jT3owRq2RGGYsRI5bWuh8TNhK5Ks6kCFs7Mdy6kMr1NS8luLFzk
	 WPw/Pxhbmhv4/sr81egTkn9dwICduT+iFW4+/qHWRazYBbcLcG4zwkDhBLfCWsKM81AjV
	 4+nNTPwxSIrDMXzH8fgMCb+y2P2r9CzM4Y5o1SCygxqb/dxGbwBVypvHU9YNBXrrIKSRW
	 Ne1Ol/YvFEjVqNi/r5M7YQHYnVqs7720sJbMAFhkclXhBRHISdtlGcqJW8XdPo8h6pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0i37DeW7;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75E606A320
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 13:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB75E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0i37DeW7
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd63b18598dso7702a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 05:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794146319; x=1794751119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nIt2c7TgqELjjufCcZKCuw1pwzNN3kz5J9LhJ3UcC28=;
        b=0i37DeW7F7ijdAe6j2C3R/w+pFVCb93CjlA/x6VQo1I24BFE/OoyOItIB2StpGwEWR
         nhkLAjwIY5STqm0DDn+MDoqFyQwAMYbTJyZaXyJgiQ7z3kg8jzD8vMFFiXi/04r/wno1
         mpB9eleAXplTOSYSzPoKXnBFFjc/git3iHEBCdiQE4eSkgDprqPNpa6lxfcgXg2tdiof
         1sqMUPSK6X50YEnG1xsUsn6cQJaav5YnnlkTtwwVp+U+w4Jk9u2g1tjuYJC7dICvrW+a
         vNo4ErOl1RlMTLkWZExFufz1le/lWoT3KQS8iqWpfQQqZ7wASv0CLGv5ZDkkwC7Z3rfS
         IpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794146319; x=1794751119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nIt2c7TgqELjjufCcZKCuw1pwzNN3kz5J9LhJ3UcC28=;
        b=Y3B/85lknOThGGTOeIOmCT0FWxRr9cuaCSaKfRYBlMCSKYfb7YgENT7Q0XBeCw+K/8
         7FBTqYL58WTh+IrpmYmCxHsxSc/OPQ/vPWB38TPubjiPoh1JTrqyF6InACzoW5hrPp6Z
         Rwz0s+CoMfCTPYZVUrKhfsaicmjdqp+Xr/XDvq4bytGyFugttUJ9s17J8tTZ1nq1BX8Z
         FHHl9oKpoRLMgDloENHUSXqV3U61mWkS5zTc/TDh0X/GlgIGiDskZlWx5+kNx1Idy/lr
         XSaCIsUFnAPcdjcZinTVDFgJMC+18duArKDVnu9jcjUXSEZq8vC+hgp/O1oFbRUWP/Z+
         v4ug==
X-Forwarded-Encrypted: i=1; AL+hErFQDQ/jlSgxSbL/4I8R/AtBJShCr0ieaWWkbPMEJ26v/tbYAvpvjHqsmtfy56lspei0pnofh7E8/0K0HYvf@vger.kernel.org
X-Gm-Message-State: APuU4Z/zOzQiu53nTvNwZb8CFT7BgK3MQooBm2c4Z9cAJ6jHPYR2Uxez
	hkrz/etNb2hhhiO+dKNDfnGd7yLHXzQNDk/pm9Q1COrdDjzf1EZTCQg/
X-Gm-Gg: AYBFou11KdJpgV9kisjkIrvJJdeg77L46AoemJ0AGOc8khxo6MmUpWvMEAHfqrkk/Ds
	AaCKnk0ukxm7Uan30ZiEcm257yuXtrUtynVRypRH1MG9DouXibPLz5I5D+P/P3qIdPXtCjkl4RK
	00D76cm7KQacefCXGBqxaX38YQe2axY+XekboXnDimVDgFsHAmJs0pYqrA/OEpXTmA+EoX+so0c
	bhpMoqWNI7VacfL8wNKMUDIMU2QVvquJwr8LGUHkSJ4TvdJoJuNC2LeqYyOfy26jHv9dObls+Jw
	J72Ou0IncdGCplB60caW8inf86RHCWbt3cUNBIq2Ol8KZYYVeHUa5ZmWZB3en1WwH6fXVpRS0oG
	Bese6NDMbmt9HaciZt7HvAo86BJQ3nC6fVsbCPMtJmErDs7furd10wMnunH4eiOrcLHpSgH2lY7
	McKR3pkB+czfHzDwrApE19hiLQ3wcfXMqN9qdbHYFKYuu69IbahzWMpyz+sOkJ+1v1RJZz0mNfi
	FY0NMO+GcjzkT7j9JQg+2FNBmC/nAoPkgxwIUWEHQ/HbMTVtLyulMjxATjsY1aX7m/svuPrpkG2
	mq3k/Zvapf8DqXR46jbWDiT1BuqEw02EYFiTSKm1Fz6u/N+x7VcRgzhBr3N4MYLNl/58G+uXw8J
	h9XdKnb2qJ3cYy2OMocgSXVg=
X-Received: by 2002:a17:90b:3912:b0:3b0:9a3e:bf8b with SMTP id 98e67ed59e1d1-3b12d4c5f3cmr2106208a91.6.1794146318912;
        Sun, 08 Nov 2026 05:58:38 -0800 (PST)
Received: from localhost.localdomain ([14.150.132.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb96969220sm647168a12.27.2026.11.08.05.58.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 05:58:38 -0800 (PST)
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
Subject: [PATCH v2] fuse: virtio-fs: stop new requests before draining queues
Date: Sun,  8 Nov 2026 21:58:30 +0800
Message-ID: <20261108135830.29924-1-q.h.hack.winter@gmail.com>
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

Stop admitting requests on each queue before that queue is drained.
The flag is set per queue, but that is sufficient: each queue is
drained after its own flag is set, and request admission,
virtqueue_add_sgs() and, on the submission path, the in_flight
increment are serialized by the same fsvq->lock.  A request is
therefore either rejected before the device can see it, or already
counted in fsvq->in_flight and covered by the drain.  There is no
window in between.

Rejected requests use the existing -ENOTCONN error path and are ended by
virtio_fs_request_dispatch_work() through end_reqs, so no new request
completion or ownership state is introduced.  Nothing has to be
discarded in the completion path, and fsvq->in_flight remains the only
state that has to be tracked.

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

Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
V1 -> V2:
- prevent new requests from reaching the virtqueue at teardown time
  instead of skipping completions of aborted requests
- keep FUSE_DESTROY working: it is the teardown request and is waited
  for before fuse_chan_abort()
- drop the per-vq aborted flag and the completion-skip branch
 fs/fuse/virtio_fs.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index ba8d79c4bcac6..c6d2120157340 100644
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
@@ -348,6 +349,7 @@ static void virtio_fs_start_all_queues(struct virtio_fs *fs)
 		fsvq = &fs->vqs[i];
 		spin_lock(&fsvq->lock);
 		fsvq->connected = true;
+		fsvq->aborting = false;
 		spin_unlock(&fsvq->lock);
 	}
 }
@@ -1226,6 +1228,28 @@ static void virtio_fs_stop_all_queues(struct virtio_fs *fs)
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
@@ -1479,7 +1503,8 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 
 	spin_lock(&fsvq->lock);
 
-	if (!fsvq->connected) {
+	if (!fsvq->connected ||
+	    (fsvq->aborting && req->in.h.opcode != FUSE_DESTROY)) {
 		spin_unlock(&fsvq->lock);
 		ret = -ENOTCONN;
 		goto out;
@@ -1669,6 +1694,9 @@ static void virtio_fs_conn_destroy(struct fuse_mount *fm)
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

