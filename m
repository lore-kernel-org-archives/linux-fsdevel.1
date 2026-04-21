Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F42367F23
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795979; cv=none; b=VnrkbVJmUfqa9on2WxBBXgkUZrsjIPX/8w7bXKc2OL8aQ85oP+1TzqEvUOlQQN9Uzp3p/nBcoUEkDOZ9TgQCloNumSrsqLZVr150fDGXEjGidbspvFMrOJwsd2gg5ZkMp9pUPfqD8ZW2Vxhp/+NdAPSVhl/d3Ef6xTt+Cw6uYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795979; c=relaxed/simple;
	bh=z5eXgCfkQiBbuzBvjsC/+er1CqGE0uZNle1S/+mRCoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9+ZQE9UhmN/N90TEOSzvC31W2aAcVCNDi/YwnX/s+PXbWDM9j90XqXeaBRqtcExqRpg0TgDYiNbwXiCtoFGIEc5TZOVStYlf6bwgiqsPHCmLjjRbh5tA06rfXFNtDBrJ1YRFX1NaXKtvflMaStNbkmLtyJkyc1y04HWAwIrpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGV+7Jwk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGV+7Jwk"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d7650202fso3583651f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795957; x=1777400757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnjJZ3XipIhaoF0C2hZTVVvUz0isi+klnbzN+QxytNU=;
        b=tGV+7JwkO2D3t9YbIUzZFc5MMo1JpjpRyjQjwh3TplvH+LRdLPDOOy+18FX2wtltAm
         7b1PVG2jPwql/KJUP3IDCF3gXqssoZMumhw28VkbulIauuJw9v4xXEGx9RMXNOs6bcZm
         /NYCQnTEZKTXbJYUhppr67PvIwWjT6KEvQ3/CmyyiE1gyY6lot6m7P9u7RXER+WQMW0z
         fo6v3s4rv2sukkq9kiRDZ0bbikdkSvTaJsaOUcrAX3+hWZ+xM2TBT5DxaZH+6t4hpXN0
         Be5LhmZHjgzq5d4QEZMnkDkaTVsPNmltCwKxMKf/1KMCORzFd0kBfI7Dz3d1e4KTG96C
         YENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795957; x=1777400757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YnjJZ3XipIhaoF0C2hZTVVvUz0isi+klnbzN+QxytNU=;
        b=M8f9VSpidxXATV6ShwTFH+v23LWCksCpkKZk2At2oQ/oYbDGX2k92Eo3mTKS2y6KWc
         2Q5LlpNsmnP39g20qI38DBzw+PW5lG8iXuQ+7I20vJHpRWSIlUGZ8ehRU/HOx4rSsRxT
         okYtcCFZWt9YvgEy5vljGF6uB7oK4KoscBzRXT83Tp/ClhXj5/AN/ErUdRj9YuLJQbfX
         FlEl/Ed2xvQ4MwGncgY0t6B1CB3SjD8UJwVgSkJmCJYCdeo/EA6N/E0KvzkqpSk9sU/U
         GMmW++RlGnd0MLc1Hh8aELOoDN/im9IMHuXyY5KCsnQXfxAwuOrlc4GuqLRfXc7C6C0c
         XpWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ACu+9UWKv/ZYD/RYlyPJX84LisbgS5an85eDHd2kz1+Yk1S5COZh6RVDWsqrlJy5h6iPbeB4HivAICcwA@vger.kernel.org
X-Gm-Message-State: AOJu0YwMeZHVFGk5vzIjMcHYh2UJ3w0nzBEJnvgkONFVt8f8AKN1vLpA
	qtvvO0Sao1YgRxXXw9xnWkDAwGDzMeLLcTl+jwEShesqto2Q2zYeehDE
X-Gm-Gg: AeBDietIiAPSnpFh6X3LtKNZ4275qoYD1TuLPt6ui0jBZ2GGjaMRJJEn8z9j7KPPX40
	runKfxfzZgpnYtphnlqRxtspTmBQ3PcUejWI//IiGip8h63ufF54zH9qg4eoCzZYKUAhlhAppIZ
	7mO7/DxuZ6UzUaDMYwSiADSLd+j4BOVQlUXmRImYOO7Fc/oTX9Bh/voPeosRHaEnM85aw1UOpWe
	PI+7kMdFGlcJ/N7IfPpbDmPFlF8t+vV+Ag0o3KcH0FXp4wuCBvamXIlxuJLC8yoCk7QbAB311OS
	djZ4ZcvHi8GAeRWQw5YvNwVz74M/lo5ksM+FjRTRo4S+9W+eJN3EwbNaB0DQZLmyFx/u433hSpv
	3D8Nf9UzwlPZbyZSeNIolVAgrL5diZK5UVohXpKGaqjSu0dqllIVoZtiKNSHKFs98x+6rIe6s5I
	6aP2Vj2zeAVTfScbwN7zNHQuuFHToO/A1NKkNuEuGpEj5/c5QQMu7zvDELhAS4JitcIfq3QCBnh
	GOCW7D8cg==
X-Received: by 2002:a05:6000:24c3:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-43fe3dd33d4mr30768726f8f.14.1776795956948;
        Tue, 21 Apr 2026 11:25:56 -0700 (PDT)
Received: from f.. (cst-prg-4-152.cust.vodafone.cz. [46.135.4.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm38694053f8f.4.2026.04.21.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:25:56 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v6 2/3] fs: relocate and tidy up ihold()
Date: Tue, 21 Apr 2026 20:25:37 +0200
Message-ID: <20260421182538.1215894-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421182538.1215894-1-mjguzik@gmail.com>
References: <20260421182538.1215894-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The placement was illogical, move it next to igrab().

Take this opportunity to add docs and an assert on the refcount. While
its modification remains gated with a WARN_ON, the new assert will also
dump the inode state which might aid debugging.

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index e57873136093..17f0804b429c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -518,15 +518,6 @@ static void init_once(void *foo)
 	inode_init_once(inode);
 }
 
-/*
- * get additional reference to inode; caller must already hold one.
- */
-void ihold(struct inode *inode)
-{
-	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
-}
-EXPORT_SYMBOL(ihold);
-
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
 					    struct inode *inode, u32 bit)
 {
@@ -1572,6 +1563,17 @@ ino_t iunique(struct super_block *sb, ino_t max_reserved)
 }
 EXPORT_SYMBOL(iunique);
 
+/**
+ * ihold - get a reference on the inode, provided you already have one
+ * @inode:	inode to operate on
+ */
+void ihold(struct inode *inode)
+{
+	VFS_BUG_ON_INODE(icount_read_once(inode) < 1, inode);
+	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
+}
+EXPORT_SYMBOL(ihold);
+
 struct inode *igrab(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-- 
2.48.1

