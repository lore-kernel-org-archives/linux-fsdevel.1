Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795021421;
	b=VQS3K3NTSxdlkIjaN4+USoTRtIs3doY6gTfCLHLv88wYPOsnNfO384LxFYv6k4bci/4S
	 3VeDSQPjNqdMtOFpBTLZ6XSU6SWRQHMOFhAidVauQ/iqx5h17Ce3kPbXtITPvxoXr5nJw
	 1iFtfK8XZne7HcXebzQS1hiIAQSUR+aAFqz2O4WzeOLHRnD9awbqLv0mh6nueMwg3+hcH
	 hBUwObPSYW+H0/SpdLjCges0c41E51oy+AEZhybZCcisVpPwk1jYrs4avg0EVLzS24n88
	 Yz3NSVAzYYqe+IxzYFX7Lygrh0cOK8SvWxFzbRVtq+Z5IaVcmVqTYoO0Dnh666Zg1zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=GLHuqACsTi6DOH91EEx2HMnXciRG7zk2OqldyJV4r9U=;
	b=MJDJFsdtboSj0LjWd0zzO0W60EBABT/CwQSVcu4U7wnqsGWiF21YVO+rQOdzx4lPZlj3
	 6rMj8FuIWI52ECk96SNt6CWIkJwSbEBBKTbAH5wYXGrGzOU2rDDCiBd8L0EGzXwgcndo9
	 W7QWXbAzviThplrco/OZfq7KcxYMWF6n9hDDprDA7pUszFgAJCmAiptQG2sPm/Nq0IaZ2
	 aFqnKXgelALsf9qXFou8zMQF0/5UfRfOPaKRRv0EAeNo7JH8QpxSt/+sf0A0YNe2AjrfB
	 BvnkB4AMtjagim0QbCdBlr/tSnM0DujdQ16P8oSyQnbrReclUUkyHI4QGm09ay9lU7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=AkgNh3ey;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43450606A334
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 17:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43450606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=AkgNh3ey
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0d126f631so11852787b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 09:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1795021420; x=1795626220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLHuqACsTi6DOH91EEx2HMnXciRG7zk2OqldyJV4r9U=;
        b=AkgNh3ey6Ev+lN7gotDHPUOV5RYD+TnT7qOwD5SaiKaH/vnC/VO8ghxeJvFSsJzwSJ
         3uDiXEZgeH+SHqH05FgLXOuFoUFD5Dj6tLrUjqutO+0+I8gynDymizv5b6uD1QFlgzQo
         xmPESuIK/GssqngbAJFlMVJROaQ8GIt1OtggTgYiMz0phUq47Z+4GjVhhTazzr5ETAGn
         7+uzgjCCb24Da8w/pFnYH7wsg7WyXbuwZY0eBdm5eISnT2XYUxqb21zHSOYhrvsvoIGs
         FrIwCPSqpgzSTp+2wdYc+xxgGr0nLdGL5kzVrFbYwl14O+v2XvfRMMlLq/gHLKsa8DMB
         hifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795021420; x=1795626220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GLHuqACsTi6DOH91EEx2HMnXciRG7zk2OqldyJV4r9U=;
        b=HQ8aOHKPTaMSpHk5f1rdg7OBmReg0laIOU52BWzSyN/m9zpls9Yp7zKVFv3Uhh56Bo
         2p+sKE2iifEPQt/z4bq9Vuq1LSC0I+UG36pf4pH/XOhtL5Irk/JEvzLvzuf61h8Dx1kA
         66Ph2O6pJBA3BxKAx9XVyBKtKl2iShk9nY9qGV0NTPljiTnM/pSjiaxFNBmsKGCjSM1f
         W+emFXnZfLvcPhA6l/fv1tGT3cb71vVevzDmWjWgi+W8O2rXzEe0ndlIS3LS8IhKCW3c
         H5M3y6K6J+hASpaLYxSue/IO4DNdJefYC6EyxXPrqxTHOSiLXkWhXH0z4vaNlxvjrWUH
         tcbw==
X-Forwarded-Encrypted: i=1; AL+hErEja2RVJfzAff07UPfmxHdI8bQbK/bw3YbWs/xp1PSmH4bFUnTmfE6aIUEg2wBfElAOJ8jii2XhuXxpX18z@vger.kernel.org
X-Gm-Message-State: APuU4Z+rTI0tE01tzgU5rFnKOvjXb5MUA5GX8E50ZnapQrmnHB6DjUJ5
	AJ+utZNBsfJtmGygpXcEYCReOV+EOdRIGexWxgZE/X51YP76df2/1YTfnqHXua2Znac=
X-Gm-Gg: AZFdTZdiX0bYjW/DozYST+CQSKx/uVbco41smPR78XvSs58k6zChPuOLqPzc6N3clkn
	72yWZ3bqQWeXv6hRtc4T70gc2p6WBpEjiwVhSpy2HDy0IrIDhHWhq4HKmIAiwIZQlDAb8b7CjJ4
	r0wd+a2/zl84Uv6YB8uq8yLvhnDCg8/ibo1TVHqAIXnzXLUZ+269vYsh7S3UjRMF/DY9O0rghmt
	uVmUexpuf1rdjpLibIS2yKW5ST/csQN4GDhnQb7RPGcU5xg1k3ecMXqhuG+hokt9JZhOp0qucqX
	XtnLB74beldDh4q12XSa88zEFNzo/Pk8km8El7jprIs8mkTVihQUzXWvgySxKeyndYz8yWBQikY
	NLOhoeSLyCGHubeBkDsq+RcVhZhCnFOLugz6O0/S5Cnht0GQxEJdtal5DsiFJA+X9B3dTjOSWrd
	a2t9vxFB98xrhZZ5iFWj/fs/9Y8TgiGcqqteUsnCKa1dLwyMfj55yfIOrNeP9UQuOl09gvvQ7H1
	zatNsgVW9Zj+Jba166W0epJtmuMacqNQq54wQU+GZxYD6A6d0bLC3J6HjsXnWd3mu1O8Hjoj+Po
	wLzFHDjKKsUuVKu3WSpaeHfslvpVplkJ+sgsoMrnYlVV6g==
X-Received: by 2002:a05:690c:3507:b0:8b2:bb94:8cb2 with SMTP id 00721157ae682-8b4fed735damr13715107b3.35.1795021419607;
        Wed, 18 Nov 2026 09:03:39 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b721861sm224672485a.11.2026.11.18.09.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 09:03:39 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 18 Nov 2026 17:03:27 +0000
Subject: [PATCH v7 4/7] fs: add write_inode_for_sync()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-b4-ovl-containerized-sync-v7-4-54f45743fe55@toxicpanda.com>
References: <20261118-b4-ovl-containerized-sync-v7-0-54f45743fe55@toxicpanda.com>
In-Reply-To: <20261118-b4-ovl-containerized-sync-v7-0-54f45743fe55@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1795021413; l=3205;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=p0YhEkTdw0npTy+LdFTgBjMgbpJBL9rcoMEF9LbcE8g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNW37LsNkBnQAFJvjEqEnn2YU8K4cQtYudIaa6RXFHOIT4DwIBxZFAEYqnEqCYymrGX2bhK02K8
 bR1zva27ngQ0=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

sync_inodes_sb() has the flusher write every dirty inode of a superblock
with WB_SYNC_ALL and for_sync set.  That writes the pages without waiting
for them, hands over the timestamps that lazytime has deferred while it
holds I_SYNC, and calls ->write_inode() in a way that tells the filesystem
that ->sync_fs() follows, so ext4 does not commit a transaction for every
inode.

overlayfs is about to sync some of the inodes of its upper filesystem, and
none of the exported functions does that for one inode.  write_inode_now()
and sync_inode_metadata() either do not wait for somebody else who is
writing the inode and leave deferred timestamps alone, or they wait for the
pages, clear the error flags of the mapping and make ext4 commit.

Add a function that writes one inode the way a sync does.

Nothing calls it yet.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c       | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/pagemap.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 15260cf2a29b..d265466f12a8 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -3103,6 +3103,42 @@ int write_inode_now(struct inode *inode, int sync)
 }
 EXPORT_SYMBOL(write_inode_now);
 
+/**
+ * write_inode_for_sync - write an inode like a sync of its filesystem does
+ * @inode: inode to write to disk
+ *
+ * This does for one inode what sync_inodes_sb() has the flusher do for every
+ * dirty inode of a superblock.  It writes all dirty pages, the timestamps that
+ * lazytime has deferred and the inode.  It waits for somebody else who is
+ * writing the inode, but not for the pages it writes, and it does not ask the
+ * filesystem to commit anything.
+ *
+ * This is for a caller that syncs some of the inodes of a filesystem.  It has
+ * to wait for the pages with filemap_fdatawait_keep_errors(), like
+ * wait_sb_inodes() does, and to call sync_fs_and_bdev() in the end.
+ *
+ * The caller must have a ref on the inode.
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+int write_inode_for_sync(struct inode *inode)
+{
+	struct writeback_control wbc = {
+		.nr_to_write = LONG_MAX,
+		.sync_mode = WB_SYNC_ALL,
+		.range_start = 0,
+		.range_end = LLONG_MAX,
+		.for_sync = 1,
+	};
+
+	if (!mapping_can_writeback(inode->i_mapping))
+		wbc.nr_to_write = 0;
+
+	might_sleep();
+	return writeback_single_inode(inode, &wbc);
+}
+EXPORT_SYMBOL_GPL(write_inode_for_sync);
+
 /**
  * sync_inode_metadata - write an inode to disk
  * @inode: the inode to sync
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 73af18a37367..172c0fe0453f 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -35,6 +35,7 @@ int filemap_invalidate_pages(struct address_space *mapping,
 			     loff_t pos, loff_t end, bool nowait);
 
 int write_inode_now(struct inode *, int sync);
+int write_inode_for_sync(struct inode *inode);
 int filemap_fdatawrite(struct address_space *);
 int filemap_flush(struct address_space *);
 int filemap_flush_nr(struct address_space *mapping, long *nr_to_write);

-- 
2.55.0

