Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB14D33DEF9
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147402; cv=none; b=Hvctu60QDzzmTYersg9AjMdJ3mx+mlNEcZs5QePPth8ONr1SZ7CewRrp/AkKqR7nt3xU9YthkMu98ewUQ4ge3AfMTDuD1He49ZpnoEC8Mwefys3iYsYg5xNgEMNR2dZ9RZ1bGsKWaPAnOvTCeZVaeBH+cnk39tD2O1dRyYeTB10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147402; c=relaxed/simple;
	bh=2Al2++Ps/6E9P/CWB1jkIarS4o0ncdap/SbUgq7+hHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cctn0OPBjqAo/OO7hPVygLaYdscn/YjwrfxXiAtL1ExEWl/7mNy99KY/qnp+Vw926+Rh9r1OX1PLR6ZBqPbErPUBleJpFhcfo3Zmb3RF8hTjt4r28X0IbNoMzDxH+lX0yYC7CT+lWtEIvLL7kPknuCnSSyVeF48MKHhanV2rcSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYSa+coz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYSa+coz"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82cf976ecacso466805b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147400; x=1775752200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOs4qdoe4Gfv7zPakYKllur+Aloi2g5a8Xgfl88GdjQ=;
        b=ZYSa+cozO1M8rZTXId2C6w8ecuRsF18U6GV/qXOH0EwunndMUoTz96Vrppcc0wYp/C
         zgC/1e4SRdCI93FVuW3CIKt3LrRK44jajhT0xuYXLTrqYcaXpQvaG9VWKoZQtgXpT/CV
         qEP6lVDP7ilWVYqgRJLMl7D4q+5FTzlUNF456Y8x5y8Ul9Be+ysKcDZ2E0VRcYpuyEoE
         X2IpOM0Vx53n9JeJYHx4wxtBpYEXAbX5qjvHzD9kDfJjWIgYVqzfE8VnrH6wCqH+ksF9
         6+13TVn9eRXFhqo42OAWlS//GdCWmsJcbzQC1b5Qx6VIya23y/v6egtdv0Xb2syR+6GH
         H+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147400; x=1775752200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fOs4qdoe4Gfv7zPakYKllur+Aloi2g5a8Xgfl88GdjQ=;
        b=aqgL1NatvggRob7s/rjK1rtIweer2CwlFQdzoGT20hnDCZnWfs4u7O09wo06huJ0ef
         cTBzLkaG/k5kAa3QsATbz8tTz8ad6Zo2KN/v/Twt/iYKQ3YPwraEk979KQIcJqenmFST
         5e04swwgaUijLf8uWn27FF0AA78wMvxB+ywMwuMuDLnOTq1tj0iRaymzgHaFZd+TGWcL
         mBODJfkLeGh1ACmkPIm+clmiqvTT2Sba3v3oCDZ7h5WhEYNP0zFbr5GT6Pz1d44HBUUJ
         lpOZmyErBPPRL7BPme7kyhS4MZn4+QwO5iqiMwP/cQa2zM77jPJVJLTxpTj3n4h7Cfvo
         Rhow==
X-Forwarded-Encrypted: i=1; AJvYcCVHJnT98GtSwNsv0PL5N0yQA9TX7L4cop+lqI/b1uTCQaeqRIgXP8SCl2YIlz+37fE1hb1eB8vtIOrI9vCc@vger.kernel.org
X-Gm-Message-State: AOJu0YxYag9uY/jKYTMUDieyCTJPK91y4kJNU9AHfEfioexP3Xpl9yxk
	s/Ar93Kj46cUOm68CypbuFH/dW+KPOb/aXxx23+2EJpLZjA8rqm+bRw7
X-Gm-Gg: ATEYQzxnzqbl/v4pbg5O69Pxkpv0xD+jetqYC1RvBVPVwHm/9kwe+A5yB4Y/+Pc5CN+
	4Uz4XfTdwnQrjd+1bAqt7LMpwtQAbJa0hUfy75PAx1VeVJlr68EpL00zSEqoVMpEGm49c1vqQUi
	vnmgbtFGTlntcjYvv8Lv7HGAIJR54H5eJRLyON2sda2HA2SGhW2IOYrGIb9VOEACwAKYzs/8Zdj
	R55PYpacIkCYmFyqkGjnM+gXGPHY4j0UPR1/68Md/YDsIydiN/pp2JXwAGxg9CCgUEPi6UrxnS5
	BlVQ6UiaTtEZRgcTVBVgc0K0bfaSb6eZCypUefl+Q3E1IpcjbgARZYwHhiQGKCK9kgnlGGbWu16
	B6POmqwFt823lDdsd7vwYjz7g3y2uiw3SwBwSlWer9mmjrTVaRd6sVyfQwpfrt0eDs5vhdM3cWI
	jKPJ390ZeX6l/NOoVi
X-Received: by 2002:a05:6a00:600e:b0:829:7d31:dd99 with SMTP id d2e1a72fcca58-82ce8ad166cmr8117036b3a.38.1775147399728;
        Thu, 02 Apr 2026 09:29:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:b::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm4834030b3a.41.2026.04.02.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:29:59 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 06/14] fuse: support buffer copying for kernel addresses
Date: Thu,  2 Apr 2026 09:28:32 -0700
Message-ID: <20260402162840.2989717-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402162840.2989717-1-joannelkoong@gmail.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparatory patch needed to support pinned buffers in
fuse-over-io-uring. For pinned buffers, we get the vmapped address of
the buffer, which we can directly use with memcpy.

Currently, buffer copying in fuse only supports extracting underlying
pages from an iov iter and kmapping them. This commit allows buffer
copying to work directly on a kaddr.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
---
 fs/fuse/dev.c        | 23 +++++++++++++++++++----
 fs/fuse/fuse_dev_i.h |  7 ++++++-
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0b0241f47170..a87939eaa103 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -848,6 +848,9 @@ void fuse_copy_init(struct fuse_copy_state *cs, bool write,
 /* Unmap and put previous page of userspace buffer */
 void fuse_copy_finish(struct fuse_copy_state *cs)
 {
+	if (cs->is_kaddr)
+		return;
+
 	if (cs->currbuf) {
 		struct pipe_buffer *buf = cs->currbuf;
 
@@ -873,6 +876,12 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 	struct page *page;
 	int err;
 
+	if (cs->is_kaddr) {
+		if (!cs->len)
+			return -ENOBUFS;
+		return 0;
+	}
+
 	err = unlock_request(cs->req);
 	if (err)
 		return err;
@@ -931,15 +940,21 @@ static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 {
 	unsigned ncpy = min(*size, cs->len);
 	if (val) {
-		void *pgaddr = kmap_local_page(cs->pg);
-		void *buf = pgaddr + cs->offset;
+		void *pgaddr, *buf;
+
+		if (!cs->is_kaddr) {
+			pgaddr = kmap_local_page(cs->pg);
+			buf = pgaddr + cs->offset;
+		} else {
+			buf = cs->kaddr + cs->offset;
+		}
 
 		if (cs->write)
 			memcpy(buf, *val, ncpy);
 		else
 			memcpy(*val, buf, ncpy);
-
-		kunmap_local(pgaddr);
+		if (!cs->is_kaddr)
+			kunmap_local(pgaddr);
 		*val += ncpy;
 	}
 	*size -= ncpy;
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 134bf44aff0d..aa1d25421054 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -28,12 +28,17 @@ struct fuse_copy_state {
 	struct pipe_buffer *currbuf;
 	struct pipe_inode_info *pipe;
 	unsigned long nr_segs;
-	struct page *pg;
+	union {
+		struct page *pg;
+		void *kaddr;
+	};
 	unsigned int len;
 	unsigned int offset;
 	bool write:1;
 	bool move_folios:1;
 	bool is_uring:1;
+	/* if set, use kaddr; otherwise use pg */
+	bool is_kaddr:1;
 	struct {
 		unsigned int copied_sz; /* copied size into the user buffer */
 	} ring;
-- 
2.52.0

