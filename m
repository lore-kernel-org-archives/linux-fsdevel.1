Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825126;
	b=T6ohkQt5+fjVrPIfCGtC4A8DRA/YN2cT/HLunmahg8OF3OjkDPt/xPdV/qGzHq6NbruR
	 A82pbkQ7gJABpWpIpDSYuVrMw0ugoJbN/qpn8/cKdhl9cLxSHSBrfE9LexNYIZ5Hg0Eh/
	 hsgxIa6S/l33lMyjhyV7CrPugS48V2/01BS4rn1DWEMxaR2aPRZe6xTK0fwuowu5vhyQh
	 hmUsm0RFaHMO29Wl3ZRUsePKzDyyQnZ2W2kdvfUDVVJHedSEJfo7ZxHl9Tnc5HLaQ/iMz
	 ua3hjCemSR32CgYJFfx0hm9aQP0Auqk0LVgorLzAAho0RguSlPfESwN3IGI9wtlJ/8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=jwxSG6kxNQXfd3MBU5TUyTIg6qqJuNYboB40oYoca/M=;
	b=zd5AWs3DcvrCcWWQtPqH3AX+RJrF0fQXx4bf8A5CZlGEsA/SLPPwSxRLW3/kPwDbFeHm
	 QiI+lrWB4gOD5zy8mX3xYUlP1ZPtOylS+da3qH5ddXPJpSuoOqYXo4+b0wXV7Ujehi8h5
	 y1qpS3nlHmZ75scO5QdO+x2v1ckG23tdgbBr7d1XqfoVExaXdxnS+KliyYFguK3o54XF0
	 YptCgV7j/H4/ydZRPRN9H9dO7Z/URRRa/v98nOhaXl/AiK21rv4DSEdZn90/o/hDTqqpt
	 60lElFfLV4p6Hda38DPGtK0ePRAqrfZyFTqHJf6CrWzR3PoZ4TiNOfVV8bASU6Xwu0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ph5nNQSJ;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6236083634
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 20:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF6236083634
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ph5nNQSJ
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91c1f548f87so18160026d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 12:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825125; x=1794429925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jwxSG6kxNQXfd3MBU5TUyTIg6qqJuNYboB40oYoca/M=;
        b=ph5nNQSJNGhkwuPhD372JTXVjIV7yjnkzaElKB7gmlzAF3Ru8ismasdmKNc7H0L/Cs
         x5iV/ymbCytrpEdEX7bDMTBkdvA0h4aTfeZZCLYkjD9NyLOuYTj1wztps6dOYNo7wfwg
         mD4COroq6ETwLR1JjKQglPUJ/k26dp0teLWc0UHAXIfFU3U+LFZ2df6PjnHFY4L4JVNS
         m/kpQ5gVqWmPPEltXNbfNQIBU+h24CnvgQjVD/WwxvEBSGX1kw7MnHlkdejewxlyPGq6
         +Oq4CBjyUG2qNdVqeQ4yBY5uHTdH+smO819Ccl4VEzhthqfvbKgFX20I5rkjjsbs0qBS
         vWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825125; x=1794429925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jwxSG6kxNQXfd3MBU5TUyTIg6qqJuNYboB40oYoca/M=;
        b=f5OCERGvmuVYilk0IfQYLtz0mcWx7DK3y9LSRvqAu4Sx6rmvK3VfV9r+xsHK4221mM
         hWQLKdPrP4sFMPX7rM820GRf2bswxZy+6ajir7/mHDDxB999CVnH9Ovzl/UaEiHoHZuJ
         N4xWXxxqbnJ0pIC61XqbC9fUpPkNDTV8LVgQZid27IcdCJDC71l1mAIShd4+ztrlEv0R
         cRul81ZV/DqlVxcL8wii3kQlaR5l8UZKs1CkAjE4HO0Q9CJ7YSZMnMddxs1btp+xJ0kb
         8TQOzwp263/5XsATZuUNXf3LVISRxnO7N167Yc3Kn725Or1QxV8DkuOVYKRaDEVCrSba
         vaQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpqoGOcNAFIMZtbGoSW+PXlZeT9+5HYeit1h8kkg9xOoZbIKAUG8Lr4SHSRukiLqbmtRpe4prPzcClMS81@vger.kernel.org
X-Gm-Message-State: APuU4Z9o8xt1lc/OQPNG0G3UtmjwenZ6hmRn4PpXc76UM91zwayivvrp
	m7EunjrI7EqqkhlIJ4QJ0SDDyvSX/MTUmBkxOP0uoDn6AqRj17hcC3ptjGxsRBgn+m8=
X-Gm-Gg: AYBFou2poRGGiN6zCVP8xPurEQ/orpah/HMt//MBwAUHVMUIysOYB5fH10BQZ5/M3iN
	9dnbHal9JxAbziw1xMnm+6CUdxLDwJyGlsS1GOgUAFaN3v9u6nCWHWWmFOUUwHIE3oXmBwfkRte
	XXy9jBMomXLFQtxuzLWu1GZuMh6DMfVBXK83I9vDKmx4u2RYA1UKe8+Ni3UFOmHrN0MUO1PZMyV
	b16wWfnsfv0IjpaTzLILAHQ/Zj9n2YIaVANc4QLdv1BW9vNY/bmG2GZUDJv5tySLUdfaVcHRKjW
	VPPpaOR7it7X2sK4ljLhI08KXy0X3DGlnDxKIKsTq52xm0tiw0jSF5t3vcIHU8P3beBuupoaCPE
	IqWWG5FlqZkIVDLUbvMh05ddyeVG/XGqBbbz4J4J0MI3hfOginLjY97HwHfABe9uyyVkYRoFQMs
	JoQOcVD95UHHSfqibX8xPFKnzmqbvywoAL9ZyUbYr3KBRSTHs2HDL5gvwNli+x7q5jUdEotbNfS
	dwcLmiot4Vlr9h7ioh9WlHxonXVy1JdRyarK62bAjgGJxOcVEpF3RvLp9bz/fq+2SYiEojisd0s
	QvSO8FP4HcUR0ZWkCsEGimhlglMf39H+1i+D6TU33yT03g==
X-Received: by 2002:a05:6214:5504:b0:91e:7f01:f95a with SMTP id 6a1803df08f44-91e7f0200b4mr45796446d6.46.1793825124629;
        Wed, 04 Nov 2026 12:45:24 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e76a9c8sm28500416d6.40.2026.11.04.12.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:45:24 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:45:03 +0000
Subject: [PATCH v3 6/8] ovl: cache dirty overlayfs' inode
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
Message-Id: <20261104-b4-ovl-containerized-sync-v3-6-8daa20144f53@toxicpanda.com>
References: <20261104-b4-ovl-containerized-sync-v3-0-8daa20144f53@toxicpanda.com>
In-Reply-To: <20261104-b4-ovl-containerized-sync-v3-0-8daa20144f53@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825112; l=1773;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=Fb/8suIHH0v3scMIhqAM6fg69jtShxcacWyi5TFUHZA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGdUBvUWtNGstE1DzXnIADs8qyDyHOogJZqYtkTAGjfXl8ErwjvmPk6vrDGBONd2cS1RDBTY9zK
 qQz2aLRS+kAo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

From: Chengguang Xu <cgxu519@mykernel.net>

Now drop overlayfs' inode will sync dirty data,
so we change to only drop clean inode.

The purpose of doing this is to keep compatible
behavior with before because without this change
dropping overlayfs inode will not trigger syncing
of underlying dirty inode.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
[josef: also keep an inode that is under writeback, rebase]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/super.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index c1bd70972519..fe626e9d78a8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -387,11 +387,27 @@ static int ovl_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return ret;
 }
 
+/*
+ * In iput_final(), clean inode will drop directly and dirty inode will
+ * keep in the cache until write back to sync dirty data then add to lru
+ * list to wait reclaim.
+ *
+ * An inode under writeback has had its dirty flags cleared, and only I_SYNC
+ * pins it.  Such an inode is not clean.  ovl_write_inode() may be about to mark
+ * it dirty again, and marking an inode dirty that is being freed has no effect.
+ */
+static int ovl_drop_inode(struct inode *inode)
+{
+	if (!(inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC)))
+		return 1;
+	return inode_generic_drop(inode);
+}
+
 static const struct super_operations ovl_super_operations = {
 	.alloc_inode	= ovl_alloc_inode,
 	.free_inode	= ovl_free_inode,
 	.destroy_inode	= ovl_destroy_inode,
-	.drop_inode	= inode_just_drop,
+	.drop_inode	= ovl_drop_inode,
 	.put_super	= ovl_put_super,
 	.write_inode	= ovl_write_inode,
 	.sync_fs	= ovl_sync_fs,

-- 
2.55.0

