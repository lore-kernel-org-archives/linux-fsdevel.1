Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7BA201004
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683520; cv=none; b=VI5OJIn6Xnx4WlYjCNIHmeVl5AmF7xJ0NlJoGYm2tut3g0Lt9gkeruHsM4ndbUjYbExM4nVei1hTYsshDi9wl83QTCFPl79gZ78q74UyyuG1xwV5T9UF0q/0zDfMGpKIWkTciMDxSB5+u7/5aWwnEHZzVExIU5eDWeGBMSrDOyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683520; c=relaxed/simple;
	bh=QGNJ0nQNwT/2Xhj5X47IZwQEmRNeo0omf8RhJnDgWj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekUzIxspVUiqwruSvodiypynnzuXki7MCL/ENpzWcgc4EFYadNdLuwQLTUATin+ftEvMlUT8/nNpT4JSI6PMYRo20CYpHX+A8DeskzJYqnT6t062IgZmufDJzVQoAKW1nu5AnBf/Usc+fIChuAgrGxmQkQis7jXnoLjF68qlBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjOfdSf9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjOfdSf9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aad9b03745so9703315ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Feb 2026 16:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770683517; x=1771288317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxTLhehX+HeveXFCHQu2LEA+jkrjd1h7v3RTfPHoVvg=;
        b=EjOfdSf9yJXp7SLGfU7rW1lzrpB5q8iMsRYbAROKATCNHN/IseKYJIgXI8iUIwTwkl
         joFTm1yzdf1i/4YnzfHPQ4M9Zt4YwmxsXAulR29NQiiBZL2IcVtpR0sa/0uqqwo3wQEC
         mopMP2Nn2Bn1JvfMtaOhDiApSntmRTCI42o17pGW32BnLQCqa4y1KhcUQV9zX0sxBhjt
         nG30CNqErVSwanrUeuTO11uEKtFcs047FAO51jp726KP/s4rONLtHBFnBYEMs0cyFcp9
         axyYFd2OscnrYePuE8yH1WNiSqV0SAIc7ELmh+SbDirR2HL9eI5qp0Va0sxvGOjAc9tw
         FYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683517; x=1771288317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FxTLhehX+HeveXFCHQu2LEA+jkrjd1h7v3RTfPHoVvg=;
        b=Y/2Q4+FrHY9+JTYYE4761A0r5azJkSu3QMWhLTdzgbRt106aUBNx9w+cNLWMXDhuYi
         iog3ctLBFjHc9+pPq4T2Pv3wktMgSAq0Krg/IJmHuzIhgrEjErgx0jinOSNdvrK8Mhxa
         dO4muOlSpKnM3y4TMhwYII3uZa0JOoK8QrOe1bNUOZvU3RNpArPmVYiV5ShxvYfDQ+Jc
         OV9/c0A2Y3cou+QtZmNvcpmlZTd7jSLvUyi06JaXVyLSeAG2rtL6mjbIgaKavK8qdgwp
         DzRhlGXkgU8cKuFfe1gm3wbGge+k14C/2A3NkjyotikK2bviT1IFe/yZT7uxCn7+PIuP
         uMkg==
X-Forwarded-Encrypted: i=1; AJvYcCVno98TmvJXtkdIZDq07rFwtmK1BCxk82p9H6Ye8HTWxnt1Q34YwaKdOCyLj98WcXHVAXYKWuTFPq6HpjyT@vger.kernel.org
X-Gm-Message-State: AOJu0YzpG2njYeFHPHm2dHD4Kebr6UYykX/g086nlcT+x7XgGza2KHZP
	5W4qfA3t9ggTay46zeyD++LeLF7RbiWmzH72q8LmPQGAKHhmyaLBMG84
X-Gm-Gg: AZuq6aJGsbhpDYGCSYL5iKFTQ1KHfblp30mxWsBOl0gT5OV1iMKBciYP+WiGnHIWTRJ
	pKG372WnEYc4Fus52MkbO2n1cY400Yxl9hukVC/w6hrpsKGhpg3SvTPUZi+h2K3Gs10RGi3ILYo
	+9dR5Ru/7wRrJ0bvLBRunfwzrNPjL+rfh65rmN/ug/TTaE4m6R9xRgmX4aDfpr1HYzZqncRk0Y8
	m1vtSgBw+hdDd4qXdzsEo43ZYtKvOUpIVlBRuHxeiwzIRKa5XS0XSlJqAoEhU2jK2rCXWoGY6la
	jbU6ZNms0qQZIno7tMpW/tnK+9A4S00Nv3Q3AWZJa6xICvCwJ4fzX/jbz9hvhV4nFU/Zd9x1+W8
	wqXgoKGQy7+LIu5gdwLqQ6N12PieXQAGAQH2OonpMK4EqQp7vSzwrd8HzhbNcJ2XcC0TCykCnsB
	tXi/9Z5FQPBIsZb708bg==
X-Received: by 2002:a17:902:db10:b0:2a7:80bf:3125 with SMTP id d9443c01a7336-2ab100a36b6mr4925465ad.13.1770683517125;
        Mon, 09 Feb 2026 16:31:57 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a95dce24f0sm101233175ad.32.2026.02.09.16.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 16:31:56 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk,
	io-uring@vger.kernel.org
Cc: csander@purestorage.com,
	krisman@suse.de,
	bernd@bsbernd.com,
	hch@infradead.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 11/11] io_uring/cmd: set selected buffer index in __io_uring_cmd_done()
Date: Mon,  9 Feb 2026 16:28:52 -0800
Message-ID: <20260210002852.1394504-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210002852.1394504-1-joannelkoong@gmail.com>
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When uring_cmd operations select a buffer, the completion queue entry
should indicate which buffer was selected.

Set IORING_CQE_F_BUFFER on the completed entry and encode the buffer
index if a buffer was selected.

This will be needed for fuse, which needs to relay to userspace which
selected buffer contains the data.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 io_uring/uring_cmd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index ee7b49f47cb5..6d38df1a812d 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -151,6 +151,7 @@ void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
 		       unsigned issue_flags, bool is_cqe32)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	u32 cflags = 0;
 
 	if (WARN_ON_ONCE(req->flags & REQ_F_APOLL_MULTISHOT))
 		return;
@@ -160,7 +161,10 @@ void __io_uring_cmd_done(struct io_uring_cmd *ioucmd, s32 ret, u64 res2,
 	if (ret < 0)
 		req_set_fail(req);
 
-	io_req_set_res(req, ret, 0);
+	if (req->flags & (REQ_F_BUFFER_SELECTED | REQ_F_BUFFER_RING))
+		cflags |= IORING_CQE_F_BUFFER |
+			(req->buf_index << IORING_CQE_BUFFER_SHIFT);
+	io_req_set_res(req, ret, cflags);
 	if (is_cqe32) {
 		if (req->ctx->flags & IORING_SETUP_CQE_MIXED)
 			req->cqe.flags |= IORING_CQE_F_32;
-- 
2.47.3

