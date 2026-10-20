Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504441;
	b=j+9wX/Q0RPsxMK+1nJe87/qLs0yGJNpTVm6A66Yb7/kQ0HxB3KFPOwlln9S5GS/MkRIC
	 XCqhrbb+1lYbUxR6pT9FkKt/4Vq7ztJ6Lk74crNLCSbXuY3OCcbnlh/RMxxYbAltuUTbt
	 +ejpA19TdVC4usGbKiCzin7tDMuIgix9yU2cIqLNuhx/E2Uc+8Xbg45/ZZFFc8JQvN8t0
	 hOe5ve9zS/KCghn+DwfaDf3906+SGlYCheJzd8AcxY36c8cqHLHFBrxKSVST6I4k/IXsd
	 P/Vxul05j6MbECfKQdhoi+lJA686dEWb26yXVCmgkj9O0ACk9yzRLgC0WFRY51kq7EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eR7IAX7DYO3kX2lnFG0GVUYwCYi3YyU/eHHmvSkslxA=;
	b=YXDeQjOrKXYAmBLvnCaeNxLyO6mzjoPQ94+44hbtvCM+Zfna5JANKDwxQ2ZaSelV9JcW
	 Ekduar1TcErrwpLWmsXb7pW+RPFrN+Q6ue2fkKxJm8Of0wWFfz5fWYDR8GfqT9AepqnTm
	 tInhnqKJ33m/R3oLIks1v5+dONwc8EC8rDYmel/41xwFOR3YOO3+uYc7HNagjnw/vciGD
	 VM1n4tJDPIw4mO3wIzyDduNg9dKaWcgsIk3gDQGhwZWA0YGMsRfwq1/G9sV9GSMSqfXCN
	 kVO5gqgmZWbng322PCztyPSY9Dm1J0EmKB3KbXirM4dBa+7Bc/0TGAE7KEL9InlfvXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nWbANXlW;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49212606A322
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 13:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49212606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nWbANXlW
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac7538422bso413694a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504441; x=1793109241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eR7IAX7DYO3kX2lnFG0GVUYwCYi3YyU/eHHmvSkslxA=;
        b=nWbANXlWQV6gBS3I36OZtuQ3J7ShKPu0A3xfLkoy1HQ7XVHK4ie0qF3nnGlRmoNfmo
         f3tah0nHkKMQ9nV5vXrqWNqnuPpYW0tQy9G3qXgPtSGKI6YRss8KscXw5p37heaWVf+w
         Fc1fLzttSoGGPm+hm98N5DJWUt+tSVoCQDtt2gfZ/zVFdRQLBdbUtymthfVJZbf+cDYH
         RFHjXfKekZpEngZfHMKLGjRhIhCQsDLUyrtRLht21dkuH2j62ZOuw374o2hK0IoZ8GkO
         HhVnSRWjwd/yFc8ytzv5aJXXy4n0JgnDIMTcSgFL6RFYo4226vBsijX4J0qSjVPfC+Qc
         Q2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504441; x=1793109241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eR7IAX7DYO3kX2lnFG0GVUYwCYi3YyU/eHHmvSkslxA=;
        b=h+yM6EnxYOE/NRuo7ZtfWVqKFIdehjoiMjvt2wIMscWJd468K6zo8+bx808j3jSrCE
         +cRl8hzMy/x+PbmDLisxqLp6/jt+Rq9iR+DbzvMPmTZBq20yW1P79RHtNmudOdMuiYSN
         pDir94syYgPQKXJFtHQHezRydhIEP3XZLyWcf+S/LJkl0zl8EN4iKoNLKHxIXGCme1F+
         0zPriCPrZ8OxhI8x1FtIuFoho20o8QNkmsjngrt2+zaS584ZlGNvqblkYp25tF7FOBD2
         FGNNfDD4o2B43m4RX85mYFC7zxIQzkHK9/fLOUE4TlmcoQTy/zNeRkju1eJ+VOyuavA9
         ZFyg==
X-Forwarded-Encrypted: i=1; AKwUvBzFGw38Rnh08Em8jrjEMnYtMFeaDcdwS3gDlZEbklKRiMhPvYVey3ZW8S8/nCe7ru0pZ1ts+mlHSdg9aEP7@vger.kernel.org
X-Gm-Message-State: AFq9FYLt8ZpIWmr/0yLThKSYooxzFP9XRJgQ0o1/ATs14GWy7Kfq/s0U
	vEnaxaqC+HNdCPEufX/DDohhbOc5AthirYekIzeg2tV7Avkm9B5kunTH
X-Gm-Gg: AYBFou2NWk9XYFVG7E/PsWQWvrhLu76Ts9Et3wCngVPsRWB6nSlQ9qt4Co1bmw/fsnw
	G9hQnlfuTTiNAwOH8yZlYT52J9q0F8u6VmBBY83pGfb1jfgzg09MeF+5T+lsH+tajMnNfk89mcc
	/nsnkLQc48iBRN+gcylhnYAhPZ7WIcNttvgpYxdVjFHlQSN4IOl+9YLq8dbvyk8rY0w7FvzljWX
	+Kog1n6BtJHw16Y1fb/R/lR+slDaHTexRFrGu5ej2H9UVKNwC4Kaop6zmTNlahszLF2F4gh22T5
	IPQo+A3fKfp95qTw8ylnpbW1qIDqEd5StCGQrYEDZ2skUCkbz6eehOb+kpkQbfLi+jwLHNkvqlX
	dnY/NNM52C3dix1kkGZsa0A+6r6vO+12mGw9C73Y5+JzUAm+DhoccAaCpelCEIk1DEDCI9zulXq
	eiFlth7ODr1TaBARXgExoS7cuzjftmjgHw5ZSTPg6UJKyQFR2Pc6byD/HU/K/fu5xIu7+l0kN/V
	ab1H2NvL3SW6lS4C0SlmeVmVgt79QWWe8uYyykJLfUF3PS086rJ4ys7YjQ7ouu4fZExjN5CtDfN
X-Received: by 2002:a17:90b:1f8f:b0:3ac:a11a:7c88 with SMTP id 98e67ed59e1d1-3aceec4ba18mr14269919a91.3.1792504440611;
        Tue, 20 Oct 2026 06:54:00 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([188.253.120.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad5d6df894sm3604548a91.10.2026.10.20.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:54:00 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: German Maglione <gmaglione@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH] fuse: virtio-fs: don't process completions of aborted requests
Date: Tue, 20 Oct 2026 21:53:50 +0800
Message-ID: <20261020135350.7751-1-q.h.hack.winter@gmail.com>
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

fuse_chan_abort() ends every request on the processing lists with
-ECONNABORTED, but virtio-fs keeps the request itself as the
used-buffer token of the virtqueue.  When the host stalls a request
until the request timeout aborts the connection and then completes the
descriptor, virtio_fs_requests_done_work() gets the already freed
request from virtqueue_get_buf() and moves its list node
(list_move_tail()) and reads its arguments (copy_args_from_argbuf()),
a use-after-free in the guest kernel.

Let the transport know about the abort and skip completions of requests
that the abort has already ended.  This is safe because any request
still represented by a virtqueue token when the abort starts must have
been queued before virtio_fs_abort() set aborted:
virtio_fs_enqueue_req() checks connected, adds the request to the
virtqueue, and puts it on the processing list while holding fsvq->lock.
virtio_fs_abort() takes the same lock before setting connected = false
and aborted = true, and fuse_chan_abort() only splices and ends the
processing lists after the transport callback returned.  A racing
enqueue therefore either completes before the abort and is subsequently
ended by it, or observes connected == false and returns -ENOTCONN
without creating a token.

in_flight is transport-owned accounting: it is incremented when a
token is queued and must still be dropped when the virtqueue completion
is consumed, even though the FUSE request itself has already been ended
by the abort.

Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 fs/fuse/dev.c        |  4 ++++
 fs/fuse/fuse_dev_i.h |  5 +++++
 fs/fuse/virtio_fs.c  | 26 ++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4fec31fc0b84..90b30c5034c4 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2178,6 +2178,10 @@ void fuse_chan_abort(struct fuse_chan *fch, bool abort_with_err)
 		spin_unlock(&fch->bg_lock);
 
 		fuse_chan_set_initialized(fch, NULL);
+
+		if (fiq->ops->abort)
+			fiq->ops->abort(fiq);
+
 		list_for_each_entry(fud, &fch->devices, entry) {
 			struct fuse_pqueue *fpq = &fud->pq;
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 4b412a76225f..47697adf0eb6 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -148,6 +148,11 @@ struct fuse_iqueue_ops {
 	 */
 	void (*send_req)(struct fuse_iqueue *fiq, struct fuse_req *req);
 
+	/**
+	 * @abort: Abort transport-specific state
+	 */
+	void (*abort)(struct fuse_iqueue *fiq);
+
 	/**
 	 * @release: Clean up when fuse_iqueue is destroyed
 	 */
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f15e516ebcb5..2db5faf5d865 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -55,6 +55,7 @@ struct virtio_fs_vq {
 	struct work_struct dispatch_work;
 	struct fuse_dev *fud;
 	bool connected;
+	bool aborted;
 	long in_flight;
 	struct completion in_flight_zero; /* No inflight requests */
 	struct kobject *kobj;
@@ -842,6 +843,15 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		virtqueue_disable_cb(vq);
 
 		while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
+			if (fsvq->aborted) {
+				/*
+				 * fuse_chan_abort() ended every request this
+				 * queue still owns; the token may already be
+				 * freed, do not touch it.
+				 */
+				dec_in_flight_req(fsvq);
+				continue;
+			}
 			if (!virtio_fs_verify_response(req, len)) {
 				req->out.h.error = -EIO;
 				req->out.h.len = sizeof(struct fuse_out_header);
@@ -1541,10 +1551,26 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	}
 }
 
+static void virtio_fs_abort(struct fuse_iqueue *fiq)
+{
+	struct virtio_fs *fs = fiq->priv;
+	int i;
+
+	for (i = 0; i < fs->nvqs; i++) {
+		struct virtio_fs_vq *fsvq = &fs->vqs[i];
+
+		spin_lock(&fsvq->lock);
+		fsvq->connected = false;
+		fsvq->aborted = true;
+		spin_unlock(&fsvq->lock);
+	}
+}
+
 static const struct fuse_iqueue_ops virtio_fs_fiq_ops = {
 	.send_forget	= virtio_fs_send_forget,
 	.send_interrupt	= virtio_fs_send_interrupt,
 	.send_req	= virtio_fs_send_req,
+	.abort		= virtio_fs_abort,
 	.release	= virtio_fs_fiq_release,
 };
 

base-commit: ac86e1112a6a
-- 
2.51.0

