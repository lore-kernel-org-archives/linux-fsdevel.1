Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283D381EB6
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Oct 2026 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791598222; cv=none; b=iHNvRRcN0MIZVTQ0+5uDSnd+iZwFl4euwxnzUOZK+r/5F5x7Xhmueyq0TFSqhEjSXphYY/sL7Ld+DBTA2iEZaxvf63l8f3s9RQrK6JR/HZy6VReIiv57voL98Qkdh/ob8syU5bmy0zXnE4EywEIk/cWLURxObmgkagDmNFBt3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791598222; c=relaxed/simple;
	bh=mXKTkYmURmAwcHDWL9qil/wt8AN1KXlNWVYThfkScHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XdMU7qBA8OGzCUgrpk0RsNaNLScJX5q5s0I00oxdjPco3XoKlcsMURSpgQBSLCZZ+eJIXs6RlVohvcf8VwnMYWXYL5Tj6VfEYk//bZQ8rhNL7w0nfqcn5mgnYvCDRhbFmvbIQ70fsqph1lL+WzowNe5RyvgFGGp4c0PxqjZP03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBzHkxEc; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBzHkxEc"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3a7adbf1b3fso71632a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2026 19:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791598221; x=1792203021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X/Fh/Ja5bkpUIakz4GwSffeo/Fel3d9ODnCNeZEyn5Q=;
        b=gBzHkxEc/uIS59nsMOji5o+sSmSzZmmFemCcLjFedsJeQ5XOGuJbEvLm29hrTa6Yk1
         6jzlwn/rUJasiQUnuzLDt4/bFO8EwuiEG3qpHiSjTReLsLrUOY/OYiorfTv7c67Ogizm
         jp+J1ddnOsIHDI9neo+ijypTPjUcaqQEPj4jhnHqTBaY6zKpPWn3WhJJA3NpKRJIIsrn
         i5ccUtcaTIPkJZyMuYYygs4Ur3ykZoqBrLLZ4XGkDSS0h86lCGMD6ALWnN7YoSlaYk4Q
         1Oz05HwtzNvTHRuOxS+i6et0+SG7qxL4q/YDuYP8chqDVFQWb3dK53JzSCEQTkT6C7ol
         CB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791598221; x=1792203021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X/Fh/Ja5bkpUIakz4GwSffeo/Fel3d9ODnCNeZEyn5Q=;
        b=0cjSvZZxPGde3XIGYxAts8T1cMf5/XxPKAlctOWr+gxPAu0PkfVTPbBwTqIylQrG+G
         kCvqr7NavjYDfNnZpLSNvY6aHKIFN4p2gRX7b/kCU5KYxL0lJkndetl1QTA0YsWtHbPU
         bysqzawGydJgFaSz2sPGLmwo+oPj8uf98bmnTd5giXXJnHZTBcIFO165fQet/92cPevh
         pklCfWYI5FYLzf9sFOK/+DgMECkN5FFlGwrS/sIBKFl0eacF71gqnzCUkHPdpylE9hJj
         7Yn5JGQSdMHZz+ceOwOocD6bROdYzM/AWWuIOeTvKxxLorN4DxCyg6Go/wRwsL2LsOb4
         iGEw==
X-Forwarded-Encrypted: i=1; AKwUvBy0lGInv1AAOHfH6x7EI3JkgJS3UpVzgwuvU5dDT54TPVaeYLTEHgnK07ke8NXSm/hXQZcc934twd63UPoc@vger.kernel.org
X-Gm-Message-State: AFq9FYIXRRJrumNFNjr4G+HRnF4B+6qixBlPh8OeFcgpsayuxjULH5kK
	qKV9gttfvt/S8FHQOsu/IIK7neh/mpABPMqqmrUQ5ddzLdp0fkl8oAmY
X-Gm-Gg: AYBFou2Q9aLq+WVfuJhd8DYQexXTxYZyF+B+RvzDd4kW8jUpInynjRilApWkbREDWi+
	l8ID3VSxbgILW6cp/OlzS+QzXLoEmWMc4rFt42rIY2FAifO2BJovJ+ptSoq7Jk3YqxJ09fRFz0R
	rFgZ4I3h2yBzMkUMFwcFw84aItcXGduSvKYHvI5iIFXVCz/+IeLoerHzUPFcS5MQ1ESszZNX2bt
	NVZhWQBtnn/O53DZVe+ocx5ec4JGQKGLoA8S8+ktIqaFuUONUjT37GO18M7OKeXyuAgY2jvvKm5
	DvaPUPX8v4Q1NclVklhZQylQnOTLpq3rOUk256wZUFxL5J+nV0xSJPHtC1gSo5t1qRIS+nPRIeo
	kBXOgbZl/FvK5FqDhENyHduzB9lXcVjBkkiW6h7/im/2ppEYYMIX2gyDfSQgF6Q5bM3m8OEJ9TM
	6DMjnIskivyoA5gUvnH2DrSJoX6pvhaRBgLNZAxMrxzoF9a+ZlXkcuTH3bnacbaZC/SiSmtnsbW
	JcV5RsjjyrzaAXxhnIevfsQGAksqyD1mrYMd/bLeEthdHvoxEPAZWqPkwsWPg==
X-Received: by 2002:a17:90b:2681:b0:3ab:189b:6981 with SMTP id 98e67ed59e1d1-3ab3a92f9f3mr2946771a91.48.1791598220531;
        Fri, 09 Oct 2026 19:10:20 -0700 (PDT)
Received: from localhost (ec2-13-124-149-247.ap-northeast-2.compute.amazonaws.com. [13.124.149.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab421566acsm3027977a91.3.2026.10.09.19.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:10:19 -0700 (PDT)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEM DIRECT ACCESS (DAX)),
	nvdimm@lists.linux.dev (open list:FILESYSTEM DIRECT ACCESS (DAX))
Subject: [PATCH] dax: fix wrong error code returned from dax_dedupe_file_range_compare()
Date: Sat, 10 Oct 2026 10:10:09 +0800
Message-Id: <20261010021010.19575-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

When dax_range_compare_iter() returns a negative error code (e.g. -EIO),
dax_dedupe_file_range_compare() incorrectly returns 'ret' which holds the
positive return value from iomap_iter() indicating more iterations remain.
This positive value leaks to the caller, where vfs_dedupe_file_range()
interprets it as success (bytes_deduped = len), causing userspace to
incorrectly believe deduplication completed.

Return 'status' instead to propagate the actual error code.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 6ba50142eeb2..1f6a4fbb97bd 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -2261,7 +2261,7 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		status = dax_range_compare_iter(&src_iter, &dst_iter,
 				min(src_iter.len, dst_iter.len), same);
 		if (status < 0)
-			return ret;
+			return status;
 		src_iter.status = dst_iter.status = status;
 	}
 	return ret;
-- 
2.34.1

