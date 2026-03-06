Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3D2D46A1
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757190; cv=none; b=QWY9H+ODe6GeL99rlu5Hem1p5crgF0YaCD6FiE+Ra50jCG2EuZGaIl7/h4SedZtPgFr+khBvvQ4Ax6PCnfdj1X1SaczI2xMo+mkFe2OvaWLC8utt1sPBrgC6cjpbmGNhyHYoMkToYiSuua8zYnvUTMMSp0vrpAvZ1WUzzqSCqkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757190; c=relaxed/simple;
	bh=7U86HvIAhhGhXSoWawp6Ysfbw1L8cF7LBpPXr+cUzy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNWxl9LrAEcFiC8UnNvEKCQI3K3+ulBJ9WyTsMJTZ39qSzTcZVPH0Ypb7EIVD79x69xhIwuq0LDvhbM79xZQ93mCG3yfe8m2K0mjX+QciEsNB8qLZnqD7nCLk4WgjBCItl1rJNXBaj1UOfYPNOxk/aYwDoubACbEhr1LtXFY3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctO0+n+V; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctO0+n+V"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3598cab697eso3037271a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Mar 2026 16:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757187; x=1773361987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YLhbQQZzpo60MAweyB3p56v5e9F4gE26cC0pj+WnE4=;
        b=ctO0+n+VpiTm+YKs5p1pjDnI/LAa0bZbugpX4eBotSANH+O7w9BajxsmjWK/GcCdQL
         89RNmnZqdAxaAz/MLaR8p1HNl2RkFu5YOIF/zlVB7ZStPz3u24FegYz+pOVprjRqipuh
         D5ebWnYO1K13PyGNh54ocWw+WLROgRlHtxJ5yuGaIG5znI43+ubQtL5WxXQUci2XxZJU
         DM6H9e48y0QiH7tyc+H8waPSNkgcHk7+Eue4GAPbzE2Z3WU9G9qh7IiSa+YdWzFMY1yq
         oR/X0XH7o7nGq/FEmAsdaQ6+zTZ/5gPQVDNErceqaE4X7fPTEaOKs30FOZOfB0xDFTF0
         92lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757187; x=1773361987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1YLhbQQZzpo60MAweyB3p56v5e9F4gE26cC0pj+WnE4=;
        b=TTJzq6++G8jnWyzUTH77Ugv16BaX8Bfn1bLlfuACyOnNvuMyslGC49nfiUfKxyyRkQ
         0aI5bTVqbEC4KDP9RK+jKWLnsfpo4XC8w3qFHT5pkxdS6+joBSN/1DQxkjRzovIy/n+E
         3eHntsxmteNsjWs4zA5FMQoID8IBsboR3LbZ+NrOL117ambVLNGgi2H5Wy0p6f/b61d2
         EeXxduboEwv79CI0M1/JA1xrgOpk6pDzIZ9zJZHXbdGzjsqIKiWzsQcmyJuyWhlp1oFU
         RFErGy+DGYJlVLxSHRtYBnVqRSkkNe8Yb1dlfgFv1ySbzsUjYVxCJdIVcB4o5ZHlMJ6F
         iZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxXdw1nH00dNsUXFqI8UxBK6/8Hg6TsKfepWPAfrtDQGZiqFXARMTxwi3iIKM9gR4VvcesUVTaDwLneR6k@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrvKUgW5tZCTL+ksiCQ7gxF8EY5airXiSJF2XWHZe1vl8jo9A
	cvCcMFGZp1i2DvhU4rGFF4pYEmd8BxZIgD0P5fvSbNBp19MlfOSc+CvlSXGV6Q==
X-Gm-Gg: ATEYQzyJBiQAV2o/Hlt8Z+wdUJQxPQgBzMYNllcKhrDaRqDAe7UB3BePIRPZ/QXCyhi
	6PLVGe1uyDe1/dFLS4CP9m+S5B5S8AK05uLcXwLUcaJdqm+tD8dJnn/mDGBOP1icv4Ihga/BfFB
	v87g57dJ9C7GvMCSu4xVWuh9+pHGdQq/wIqd30Sr2L3cp/GSJBOnQzCtVN0w2oarzJ0Chf9oMKY
	KiJNaORdKZqf0T19TNB+NNmQtWRuWOG7FEdk6UplPYd8Fl60y6SEzC6hjBvk93NeQC/7zntglgV
	c7ukqYPN7NfkMhmUprnvXrgIazmEta0GP7+m21ugfMAaRXZk8AxVYsXbII4MuTNj8tnqcTVHeWF
	WnSzq8IEWoSTDVrEE36tkrNvRXGI7AymDEMLS+2PDBc8JaTTtfrwTjCsdrPFaRaz9u+j5IZjT/t
	wPFl9pJnpQ4iDHBrqfzg==
X-Received: by 2002:a17:90b:48cd:b0:356:21e9:73ff with SMTP id 98e67ed59e1d1-359be354bc7mr199485a91.11.1772757187014;
        Thu, 05 Mar 2026 16:33:07 -0800 (PST)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d3922dsm3132115a91.2.2026.03.05.16.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:33:06 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: hch@infradead.org,
	asml.silence@gmail.com,
	bernd@bsbernd.com,
	csander@purestorage.com,
	krisman@suse.de,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v3 2/8] io_uring/kbuf: support kernel-managed buffer rings in buffer selection
Date: Thu,  5 Mar 2026 16:32:18 -0800
Message-ID: <20260306003224.3620942-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306003224.3620942-1-joannelkoong@gmail.com>
References: <20260306003224.3620942-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow kernel-managed buffers to be selected. This requires modifying the
io_br_sel struct to separate the fields for address and val, since a
kernel address cannot be distinguished from a negative val when error
checking.

Auto-commit any selected kernel-managed buffer.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/io_uring_types.h |  8 ++++----
 io_uring/kbuf.c                | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 3e4a82a6f817..36cc2e0346d9 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -93,13 +93,13 @@ struct io_mapped_region {
  */
 struct io_br_sel {
 	struct io_buffer_list *buf_list;
-	/*
-	 * Some selection parts return the user address, others return an error.
-	 */
 	union {
+		/* for classic/ring provided buffers */
 		void __user *addr;
-		ssize_t val;
+		/* for kernel-managed buffers */
+		void *kaddr;
 	};
+	ssize_t val;
 };
 
 
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 0e42c8f602e1..13b80c667881 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -155,7 +155,8 @@ static int io_provided_buffers_select(struct io_kiocb *req, size_t *len,
 	return 1;
 }
 
-static bool io_should_commit(struct io_kiocb *req, unsigned int issue_flags)
+static bool io_should_commit(struct io_kiocb *req, struct io_buffer_list *bl,
+			     unsigned int issue_flags)
 {
 	/*
 	* If we came in unlocked, we have no choice but to consume the
@@ -170,7 +171,11 @@ static bool io_should_commit(struct io_kiocb *req, unsigned int issue_flags)
 	if (issue_flags & IO_URING_F_UNLOCKED)
 		return true;
 
-	/* uring_cmd commits kbuf upfront, no need to auto-commit */
+	/* kernel-managed buffers are auto-committed */
+	if (bl->flags & IOBL_KERNEL_MANAGED)
+		return true;
+
+	/* multishot uring_cmd commits kbuf upfront, no need to auto-commit */
 	if (!io_file_can_poll(req) && !io_is_uring_cmd(req))
 		return true;
 	return false;
@@ -200,9 +205,12 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	req->flags |= REQ_F_BUFFER_RING | REQ_F_BUFFERS_COMMIT;
 	req->buf_index = READ_ONCE(buf->bid);
 	sel.buf_list = bl;
-	sel.addr = u64_to_user_ptr(READ_ONCE(buf->addr));
+	if (bl->flags & IOBL_KERNEL_MANAGED)
+		sel.kaddr = (void *)(uintptr_t)READ_ONCE(buf->addr);
+	else
+		sel.addr = u64_to_user_ptr(READ_ONCE(buf->addr));
 
-	if (io_should_commit(req, issue_flags)) {
+	if (io_should_commit(req, bl, issue_flags)) {
 		io_kbuf_commit(req, sel.buf_list, *len, 1);
 		sel.buf_list = NULL;
 	}
-- 
2.47.3

