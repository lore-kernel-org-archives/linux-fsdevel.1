Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905BA1B4138
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 21:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265888; cv=none; b=lO5vBYTr9PKPOBQ1EgCb9XY+7pGuNJWpS8inW9RBvAZVb6c01P7txRSqJdYjjfLF2pp+zq2JSmDKIBmszC5saClWs+nhGy7CXW+ruxgrzSy96CgKoBdESixLTGunraAcij+jjr9MTioZKnyy9npeACQewuqQA/G/XYsx1Yawpcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265888; c=relaxed/simple;
	bh=HhmWOYNaXpoL0mUloGTxEYCzr4/BINuEpsMT5Vdgxz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQoesS4nzIv1pyNyq3aBgEIvp31sg9BlCam45ue/pPTQYrHjtN4RN21tD8LL2AFuy4uCeRaAUMaULmaZFsUbUlpp9QrcUZ6btn6Cq82ao/1RD+CRLj5LeuRr1Zror3GlsJQYox6d89wnSBtuwbtJXHW0w+gK+x74GukdfL0XFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/fgEgF5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sRT3FdFy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/fgEgF5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sRT3FdFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773265886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EF2zUwpCzWZlEQ5usfdCVGW1cAo0u6ScaGwXu/9kPuQ=;
	b=L/fgEgF5PG/85PRsCMgeRPk9n++IOxqY30j96dzzKad2GFYMF9DrK59rVon0B4IGYJTrNV
	lIet+xVGEYo5slxPyT4bJMEoUE1l1XpYfmHKJvxZ3QCwXyCLbIVPFr+Yj+j42NG0zvRpRC
	LRIE2sH3dp3zXysI09Kx46y09Wvyg1E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-rCvlWUHTOnau8KNuCfmDmg-1; Wed, 11 Mar 2026 17:51:25 -0400
X-MC-Unique: rCvlWUHTOnau8KNuCfmDmg-1
X-Mimecast-MFC-AGG-ID: rCvlWUHTOnau8KNuCfmDmg_1773265884
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4852cf0318dso2853545e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773265884; x=1773870684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF2zUwpCzWZlEQ5usfdCVGW1cAo0u6ScaGwXu/9kPuQ=;
        b=sRT3FdFy49fmI/xz9J3l53AHrFcGNLUOHHnXQnlx9RCXXuwxNUEPNMbHfMKD/R3j+D
         ZkzbT1zzSkJvJAoWwsq+2khkyEPRPFOaiUBWPXXAywCdJ/QtTrakrgtxc9PcrtEcaHXH
         WybFXKffLMrjilX5EcMUiIKV60LV/jn4CKUo0t+lp6IoFz52QZzxIqDTl0aFykh4EJtQ
         +vvvI3Qe0LIsDYmfp7eNhKDJlFr1yZjse9F9o32nrXp/Yo7bki7BUxf019O/w+d5nXUx
         ZJ312V/GR1FV+kVuvSFJxOTT8W6FJ11sEPrAA91E+LvgKJQ6K0I1yQuPObJ1VYbS4xi3
         u6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773265884; x=1773870684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EF2zUwpCzWZlEQ5usfdCVGW1cAo0u6ScaGwXu/9kPuQ=;
        b=MPa9elSs4s2/VMSShrrDwmZvNszHPnELFjezfPyrQr5VhMKj6zxnREmptIUqDWpe6V
         yyvtLKqStUEo8ukq6KU/htwyZs5420ryn+V4LtEa0/ocjReNEPQc8qWNJiVMw/kvx7Va
         TiGWRPCu0PjtG0DgJH1D2J+JQ3HfSAJleCw83Y6ALmxumBFUuveToszlJpdOPqR+tFU1
         ELWQ7wmtI/YqPv1f31wKOIScs1i7vpTU/khc90BfviCHl+sMjboVb7nf0EzcddhxB5pd
         oQi/EgFPdazhaYBgnC1Et7qWJTqe9r51/kbyDCi9GtBQ6D8D5UnIPqe+khGNugeVd9Gb
         2cnw==
X-Gm-Message-State: AOJu0Yy939UU4L5+8I9a4J24R9lK6ww7Fi39LPO7YH5KV1G2nn2vQ4Oi
	wmd4DnOsly9fFFOmxvazAmCGzkMOkcWokb7aexCfIoOFVgCDr7cyOrLqGBInlXync+JNdg8oORH
	FmuSgZrJIWgCiKSAAhOZRxL5bL3GEGbODoaP7PMmrGdpcmA8pNmTW8YKgI/iDgrNcTAJygYLWPg
	UL5nwsA9T6B9nuL1I07O+NYxTWeh2o+DFg+UGxRW4S9yBGQcr54nM=
X-Gm-Gg: ATEYQzzMBq9fIgJKr8xPs+Ul7+vK6sliy27Y3zAQ8i3W6GVj0Le2i0chkSiYAq8i7YE
	xe4ezsPPH0iEr5WV6DC0eTukS3PIguO9ERkUsKSCwwpf6LC+cJ+jspuzymmJZAcoBQgNurA7YBi
	PWKW4l2aNQSyAs2I8v/m0uFpmz1P4b9ciXwbE/Ply3dQMEdF93nxKlNQ+A1wRv+WsceYI/p9dNN
	bbMhi/w8DxiTrT5p14HA6mjl3mlpmtZLB9YuhPM8+be6BKRNPqokynulBu2FCNAszd5QyCk1STa
	4RMYYL4alMzJASnJXGOKAgUpCs2n2LbcyEK4YJI1OEKgPDikqhbunHfFM2wDlni6HKLQEsSFY1W
	I79l82WztFKi87g+QbZxENQoTtfuqVcSqTS9QeJy5spHf5e718Kt6ivRWgIChmIvpgxeXxtgpC4
	be9fU=
X-Received: by 2002:a05:600c:1da1:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-4854b0be170mr79826275e9.14.1773265883889;
        Wed, 11 Mar 2026 14:51:23 -0700 (PDT)
X-Received: by 2002:a05:600c:1da1:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-4854b0be170mr79825925e9.14.1773265883374;
        Wed, 11 Mar 2026 14:51:23 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-127.pool.digikabel.hu. [176.241.63.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e9179sm79881205e9.3.2026.03.11.14.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:51:22 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [RFC PATCH 2/3] fuse: add refcount to fuse_dev
Date: Wed, 11 Mar 2026 22:51:16 +0100
Message-ID: <20260311215118.2891117-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311215118.2891117-1-mszeredi@redhat.com>
References: <20260311215118.2891117-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/cuse.c      |  2 +-
 fs/fuse/dev.c       |  2 +-
 fs/fuse/fuse_i.h    |  4 +++-
 fs/fuse/inode.c     | 11 ++++++++---
 fs/fuse/virtio_fs.c |  2 +-
 5 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index dfcb98a654d8..174333633471 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -527,7 +527,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	cc->fc.initialized = 1;
 	rc = cuse_send_init(cc);
 	if (rc) {
-		fuse_dev_free(fud);
+		fuse_dev_put(fud);
 		return rc;
 	}
 	file->private_data = fud;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index d114869d6900..69868f851e13 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2548,7 +2548,7 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 			fuse_abort_conn(fc);
 		}
 	}
-	fuse_dev_free(fud);
+	fuse_dev_put(fud);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fuse_dev_release);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 739220d96b6f..0817fbe3ba43 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -576,6 +576,8 @@ struct fuse_pqueue {
  * Fuse device instance
  */
 struct fuse_dev {
+	refcount_t ref;
+
 	bool sync_init;
 
 	/** Fuse connection for this device */
@@ -1342,7 +1344,7 @@ void fuse_conn_put(struct fuse_conn *fc);
 struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
 struct fuse_dev *fuse_dev_alloc(void);
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
-void fuse_dev_free(struct fuse_dev *fud);
+void fuse_dev_put(struct fuse_dev *fud);
 int fuse_send_init(struct fuse_mount *fm);
 
 /**
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 92f56bd6ac23..5a823b574634 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1622,6 +1622,7 @@ struct fuse_dev *fuse_dev_alloc(void)
 	if (!fud)
 		return NULL;
 
+	refcount_set(&fud->ref, 1);
 	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
 	if (!pq) {
 		kfree(fud);
@@ -1657,10 +1658,14 @@ struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
 
-void fuse_dev_free(struct fuse_dev *fud)
+void fuse_dev_put(struct fuse_dev *fud)
 {
-	struct fuse_conn *fc = fud->fc;
+	struct fuse_conn *fc;
+
+	if (!refcount_dec_and_test(&fud->ref))
+		return;
 
+	fc = smp_load_acquire(&fud->fc);
 	if (fc) {
 		spin_lock(&fc->lock);
 		list_del(&fud->entry);
@@ -1671,7 +1676,7 @@ void fuse_dev_free(struct fuse_dev *fud)
 	kfree(fud->pq.processing);
 	kfree(fud);
 }
-EXPORT_SYMBOL_GPL(fuse_dev_free);
+EXPORT_SYMBOL_GPL(fuse_dev_put);
 
 static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
 				      const struct fuse_inode *fi)
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f685916754ad..12300651a0f1 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -486,7 +486,7 @@ static void virtio_fs_free_devs(struct virtio_fs *fs)
 		if (!fsvq->fud)
 			continue;
 
-		fuse_dev_free(fsvq->fud);
+		fuse_dev_put(fsvq->fud);
 		fsvq->fud = NULL;
 	}
 }
-- 
2.53.0

