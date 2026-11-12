Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460934;
	b=mGyFhyp5/7/KjNXGOuZeSAma1e8gI4wnncEQ+lYnw5h9GjNLpkOuVf8ZIzLVveOjs9yv
	 tKcCThhkokI1/WQltytNgM3OEOZoxEZ1+K9uwxeAD6wDYnlr5f+TtJE2l2wcchK+IlGpg
	 E1IOJ6my5MyiSwIyvG8WjPs4xR0vDJ7ojgBEEp6Of52xA5eDZ7lkEIOxSyhcr6Kiwy5Yb
	 xQ3/CJpdUy666DZW7E2QFZ5fYKr/tHIwHAbUWKkXt0VPKs+vMVLE58knu3Yx7uGkLRxKN
	 P81xMBHQmiYaHWz3VDG5jjxm7CaT38OXKUQ8QCzlucnMDI3XCqEoVMFxt9CCy3NRlCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YIZv27tuCpRFyRmf/qdRg8hV9PDLwYKkb+ennGTxSNE=;
	b=M0IfYZ5DnkxrYadWkv91QNqQLgS+YfsR05P+rjEIPzbikBEgMREl1QrIOaq3YZ/1rvPV
	 3/+NxMv4axQ7jZ8jh6uaVGX1mLV3AgH/Rm9VLE0eHdXr6Jq01I1858DaXlfs8KSbT1kNu
	 BAMpP54emDoUa9vMHTodOkFo1XEfGhCTDONe0aSlf6h1clPC7K0yw4Z9ZPyc2ZejlN49H
	 Gzn9Vmco7GIeznA7hRmxKZy4TvR5ImKuMzjhAtO6Kc9L5tnxzDi/41E8NyYNaRG5lNomB
	 sO45f8rFPbLmXiGRuesnv+4pTCE/NfrArzRali3BhSt4cMVGW6+4a8KtgQOFm3opJoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eyvD7j/7";
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DF2606A327
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 05:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21DF2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eyvD7j/7
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f30660e69so323475885a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 21:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794460933; x=1795065733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YIZv27tuCpRFyRmf/qdRg8hV9PDLwYKkb+ennGTxSNE=;
        b=eyvD7j/7GP//UsvMrOm0nhkwnqG5mMKw2OYHo4hgzwLwQfXdKabVriJGWT1HxKeXNz
         sfxjnKjMrhmXIcNtdSeQczcTiL2CSEeIgQFRAkz8lGwfL3GGEh2UwBoM7gaCFeItaQQ4
         bcY1MPUwRciFPDYTeTnQreRAeY1Pmfwfk9xJmnNy7fBDrQiKHp6Ul6UYGAcR2WSjnSnP
         xSSti1CqcDSmI/GKgczNTyjPx2xGIuRRu07giKAU+sd0ElQr8G2Impbg45ySoAffBSfR
         uDhLwuCDZd9Dytg84ltCLZhI3vNGE820+dIkyFUeUhtKVP5j1sZy20rnT5PrZ+XcFpYn
         eY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794460933; x=1795065733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YIZv27tuCpRFyRmf/qdRg8hV9PDLwYKkb+ennGTxSNE=;
        b=2cecwiRLZ2MOh0LpCMAn46TmmP/w1XjZtVmMr/QtmWdymAF9z+uHoDBfIwHZmo8mHL
         us8EAkGJyDLVA7lSzgLcrr9SWZsNyeza8hZzbB+HHQT7JFgQTRC80cZ/kLP/3ELBxGKx
         GqICJ0qQ1/YZ2GlCG9vPgirYn9YtkrKSpwM+vdBtdr8bTKrpY+F7OI33e/peJe8iLa7F
         XlPRpW7h2qQP1mXJUZ//bJyjDxFuovs8k4kUsOoKLDp/ZrEVNbU+gO6EcW8FhFahfoU+
         1V9y2soM6ce5p2tnCuTN+4n52osb1hCfpYgokh3UIAjkALYgRC0/jK0iUudfck42uybR
         sDxg==
X-Forwarded-Encrypted: i=1; AL+hErHnVgrqFR6hKDu4buIeYUtLZmF1IrGxTEMe7Ms37WLbsZ8w4CHZgRQK8Vq83RwP9ku0U9o17FWIsna70lAS@vger.kernel.org
X-Gm-Message-State: APuU4Z/nsXgHuo+7aJNyA8arN6XSjBV63VowWVvpAJyQ5Xv2WRedxdI4
	fjlaB5cix7n6ZsJKXHGrGXMv4HjrvFiYQDkI+tFxDHz791dR01n1lNxp
X-Gm-Gg: AYBFou1QBIRqHA2/XrujMY3U17YddEtouZvpiNlXSZv1KLnRY98diX7vWtxTaMhCdn+
	uTg7LyP5OKjxY/+4JgozE3mBS1PvgglRzxLMZMv1+szy2f75faSbVoJPA3xxWDH5q4ltN2FpArB
	kIef322DhlDlBLCXBQchetKdHBMqJQTjpxmPNckafl5EEOE/aJFVJhKMym5MXDKwYDG3923KGNz
	mpE1AWdErpmnTf3Ejuh049p/0MZZ/A0Otglk/PaKx1nkTzvQ/UH6lUq1JiNRxpj0XSLaBnzU2hl
	LAv+xGqgUIbj0vUJEHJmAUOm+bAZyVikI2Dkm4qJM67KIhFEW19dyBFaeUkI5xq9+bfnI4WUdVO
	wMu5kWZu76kx+CdysXOuYRE8HnRD6eQsh7LXM7po1EsgxW2+sdu1zV5N6wFZDbym0NC3BPAS7E8
	jodzHcZC5AoKO3yP4FYBLYUHKW040waoG5EYf7OeLJzs2iim6NmOSIwvpuylYn+nL4EkfLN3zy9
	cm15A6M3gAa41jiUdvy5AX0Nxa68W/ruphyZ3Fo4tJS+ZiI6mcMo8k7Q5LriATflSfWTuDnWdeY
	60Q02tCaBvl/xyJ2xNKX6mqhhd7YHlaDcZNGilD1+ioLu8VlUhwP
X-Received: by 2002:a05:620a:4693:b0:93b:d7a3:45cf with SMTP id af79cd13be357-947affc2972mr765476985a.56.1794460932899;
        Wed, 11 Nov 2026 21:22:12 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f03ca6548sm37340956d6.9.2026.11.11.21.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:22:12 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	German Maglione <gmaglione@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	fuse-devel@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] fuse: Don't use request timeouts on virtiofs
Date: Thu, 12 Nov 2026 00:21:50 -0500
Message-ID: <20261112052208.1248312-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

virtiofs cannot abort a request once it has been added to a virtqueue,
because the device owns its buffers until it returns them on the used
ring. This is why virtiofs sets no_control and no_force_umount; see
commit 15c8e72e88e0 ("fuse: allow skipping control interface and
forced unmount"), which says that "virtio-fs does not support aborting
requests which are being processed".

The request timeout added by commit 0f6439f61a6e ("fuse: add
kernel-enforced timeout option for requests") aborts them anyway. When
a request takes longer than the timeout, fuse_check_timeout() calls
fuse_chan_abort(), which moves the requests on each virtqueue's
fpq->processing list to its end list and ends them, so they are freed.
The device can then still write the reply into the freed request and
its pages, and virtio_fs_requests_done_work() later gets the freed
request back from virtqueue_get_buf().

The timeout is armed when the server sets FUSE_REQUEST_TIMEOUT in its
INIT reply, or when the fs.fuse.default_request_timeout or
fs.fuse.max_request_timeout sysctl is set, for example for other FUSE
mounts on the same system. A slow host is then enough to hit it.

Don't arm the request timeout, and don't offer FUSE_REQUEST_TIMEOUT, on
connections that set no_force_umount.

Fixes: 0f6439f61a6e ("fuse: add kernel-enforced timeout option for requests")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
I used no_force_umount to tell these connections apart, since virtiofs
sets it for the same reason. A separate flag would work as well if you
prefer that.

Tested on x86_64 under KVM, on top of v7.4-rc1 (6628e7d4c6b2) with KASAN
enabled, using QEMU's vhost-user-fs-pci and the C virtiofsd from QEMU 6.2:

  1. In the guest, set fs.fuse.default_request_timeout=15 and mount
     virtiofs.
  2. On the host, stop virtiofsd with SIGSTOP.
  3. In the guest, cat a file on the mount.
  4. After 50 seconds, resume virtiofsd with SIGCONT.

Without this patch, the cat fails with ECONNABORTED after about 26
seconds. Once virtiofsd resumes, the guest reports:

  BUG: KASAN: slab-use-after-free in virtio_fs_requests_done_work+0x7be/0xbc0
  Read of size 8 at addr ffff888005176020 by task kworker/1:1/29
  Workqueue: events virtio_fs_requests_done_work
  ...
  Allocated by task 81:
   fuse_request_alloc+0x19/0x200
   fuse_get_req+0x153/0x2d0
   fuse_chan_send+0x4cf/0x840
   fuse_do_getattr+0x23a/0x4b0
  ...
  Freed by task 81:
   kmem_cache_free+0xbc/0x3e0
   fuse_chan_send+0x4af/0x840
   fuse_do_getattr+0x23a/0x4b0
  ...
  Oops: general protection fault, probably for non-canonical address 0xe012fc11a000000a
  RIP: 0010:virtio_fs_requests_done_work+0x25a/0xbc0

Setting fs.fuse.max_request_timeout=15 instead gives the same result.
With this patch, under either sysctl, the cat waits until virtiofsd
resumes and then returns the file contents, and the mount keeps working.

I could not test the FUSE_REQUEST_TIMEOUT part, because this virtiofsd
does not know about flags2.

The tests above were run with help from an AI agent.

 fs/fuse/inode.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1341b681d0ed..f1aae9b5475c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1451,7 +1451,14 @@ static void process_init_reply(struct fuse_args *args, int error)
 			fc->no_flock = 1;
 		}
 
-		fuse_init_server_timeout(fc->chan, timeout);
+		/*
+		 * A request timeout aborts the connection, which ends the
+		 * requests that are still in flight. A transport that cannot
+		 * take back requests it has handed to the device, such as
+		 * virtiofs, sets no_force_umount for the same reason.
+		 */
+		if (!fc->no_force_umount)
+			fuse_init_server_timeout(fc->chan, timeout);
 
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
@@ -1502,8 +1509,10 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
 		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
 		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
-		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
-		FUSE_REQUEST_TIMEOUT;
+		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP;
+	/* See process_init_reply() */
+	if (!fm->fc->no_force_umount)
+		flags |= FUSE_REQUEST_TIMEOUT;
 #ifdef CONFIG_FUSE_VDAX
 	if (fm->fc->vdax)
 		flags |= FUSE_MAP_ALIGNMENT;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

