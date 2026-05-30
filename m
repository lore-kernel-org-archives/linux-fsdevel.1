Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2722425B
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151731; cv=none; b=O8PBF6c2AHMYyU9tA28e9dXu005azhTeuOsZFDit4rU94uQrA0meDWZWRd0deyf9OK1QdCBXljrMiIcbjoKb8aDVxkvYiaSQyDTiNt6IOXxkTvvOZyTgFBvkGQu3h7fIfurRdWTqArZR1b5A5LbKEE994aOT4Z3oTZCJoZjSee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151731; c=relaxed/simple;
	bh=9icizL+Sjs2p+zTleA2i7He+9Wrfoo5fQEGr1xgi4KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apFXTdYx8QlQRG/eo9e/YHY6oP9ff4GcyX4YYtM3Xjt22ws/whjd2TxtNfSLJ1jWSvLvnAhFbzT5nrLDrh4pdbHvLeQjz7SNIbNx4jN6HLqR6CkQJmaa+kYEoxTRoC7qK/zhe4uOff9Cdvn/zz+eHVNzQsTOSpr+dY8IyEcYJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGrlrdUg; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGrlrdUg"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c85640eaf62so247836a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780151730; x=1780756530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yl6ECZG8J6iHdI6eQPCRlThUPWfxjh8VpTkkklcQYXg=;
        b=OGrlrdUg3OB0d8p2aFaVQb9KkSSIjzBKU0eZV8d9uW25fuVHMmJOa2wUqxi8jMfGVa
         wCzrm8qxZr30xdY16/BFVCIeCsd/xIqbVE36W5DqMx+0aH0A/SGDgX7E78BhqqmKbabH
         tUV3ILGw3G0QVEY4yUBKT9O2peUL9F6dCeRwk1iVQkPrN4/YMRL7tSguELVx/UVweh4x
         iYRXyZNex2NFZUg4g/Vv0d7wPaHlFh9igapvJ7MShKycYR536UxRjtlv0vwMl9QzHcuJ
         +fIw4knkXBNgKRBeLTH4jy3N/3YXBnMPdxBaAeTnU6Xv2T6qHAZKgPf3+jSQ4kkPCbnW
         /2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780151730; x=1780756530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yl6ECZG8J6iHdI6eQPCRlThUPWfxjh8VpTkkklcQYXg=;
        b=lvdNeCx1I/XPRbRgOZu9egTL4nLZY68Jrb8uDdMschPKU2WCAgdtA7cvUDiD6MrPJW
         0J3UMQO+SSxD/LFW5AXrjuWU76N4ZS/nke7lEBQtQqN9OZvo9jY1UZct1JFDtIsgquGK
         I2Hdt8ill24z6FZXQeg+RXbaeRrBIS6atIntQmu46GWTeWfcMrp5f6wDzxeWWdXLsk8I
         3Ki8izlLk71QgCA/OtNVluarfZNk8dHuA5ApOCpx7nQXiABQVrCyJb5QCxzHKZJSh0FR
         mMaZhAra7DKGOJcQyTsvDmwtVzVXg+Lcg092PWnsLNMTpAnZelXMNepnPvRrAqFwUGtG
         +x5A==
X-Gm-Message-State: AOJu0YwRvnP4pjJ1lu5MZzJ/PwJOCojnwJFEM1MLb1gWymzwuHVqI4aJ
	fkCHVCIACfPeBaDj7SvQEX8Jd3J+Z574hGbwyu8QI2dWDX9i1Cr4ptrmp88qRw==
X-Gm-Gg: Acq92OH5usfBszxCNzD1CBpPDjDgvtDiUyXEZrPaz6Vtmh7Zb/bazHGPFvCTkEq1rU9
	e1hfbujgv8fk7SUhbnerQMiMI2aVsqlNz+icRYVcWIwFOD79i3WKXkxK96C1kDBjh10vahOkBI0
	zCm01WnBZL2MVd5aQdS6Jh4eJ+Zu3YdEPZWlIbpiIoB3ZNrTV8sDuieLoY3WomtDc9LBe6vkXhs
	myoIAZD3/ougsdijlnI3NQx8Bu78Yqr+VvrLhgLMa0K4IgWHOsPT2f3Bekril0c6zasaUPDf08F
	wpU7Zu5DmX2J3kqAIKsubWn9oIBCp4IFEOtC/9FFDIKZ1y/3jjI00GR2vdxzKZnpIVG72oDOl5F
	VXSOJnR5mqTypDnJnh4zOY+353M2lfgQ7TfKpBk2D6NQE3f/Jumt6jsOaA9/StYZT2bqTW2opNj
	ONNMLDyJhhvOP4bVHpv1IsXx5om/A=
X-Received: by 2002:a05:6a00:124b:b0:82f:6a82:4231 with SMTP id d2e1a72fcca58-8422533341amr1692669b3a.1.1780151729690;
        Sat, 30 May 2026 07:35:29 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b2acb7sm5832280b3a.13.2026.05.30.07.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 07:35:29 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v4 3/6] ntfs: reinit search context before volume information lookup
Date: Sat, 30 May 2026 23:35:11 +0900
Message-ID: <20260530143514.3083601-4-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530143514.3083601-1-charsyam@gmail.com>
References: <20260530143514.3083601-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On mount the volume inode is searched for $VOLUME_NAME and then, reusing
the same search context, for $VOLUME_INFORMATION. The $VOLUME_NAME lookup
is optional and its result is otherwise ignored.

Once lookup-time validation can reject a corrupt $VOLUME_NAME with -EIO,
the search context is left in an undefined state: ntfs_attr_find()
documents that on an actual error @ctx->attr is undefined. Continuing the
$VOLUME_INFORMATION search from that context is not contractually valid.

Reinitialize the search context before the $VOLUME_INFORMATION lookup so
it always starts from a well-defined state regardless of the
$VOLUME_NAME lookup outcome.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 140b8c8a811e..79b530280d87 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1537,6 +1537,7 @@ static bool load_system_files(struct ntfs_volume *vol)
 			vol->volume_label = NULL;
 	}
 
+	ntfs_attr_reinit_search_ctx(ctx);
 	if (ntfs_attr_lookup(AT_VOLUME_INFORMATION, NULL, 0, 0, 0, NULL, 0,
 			ctx) || ctx->attr->non_resident || ctx->attr->flags) {
 		ntfs_attr_put_search_ctx(ctx);
-- 
2.43.0

