Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20830391E64
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761718; cv=none; b=U9N4LM8ixnkbCJxPmhS4Oocz5lyMs3vlZrAAMlzAdjA7voAiDNIepuksoks+NwD+GD0K6GCptbvZnWu/VPYjJBcyctHn4tTPAAkA+nvXEi0Ff0ZDXJbz9nSwLMdKQ3dPdL3vrX1B924oiqg90+4ETMenM7aIetjNoR15kC3aoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761718; c=relaxed/simple;
	bh=O1v7h0Glt9tec5AHuLUy0WkK7jpV3Eob1sB7vRLAoEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kc2QculOVo1tTSA9zLBX2zIVv1kiiyjnDicnt2QQu56dqtXiIt+47r9B6/1FeqkNtXpYAz9ZM2PXYrJcyK8v6wq8mUgbX7RdrcACV0ya6ZZO4k7GkiiTz2ZOZ+zn+8NmRXRUt5qU/bF4bAgQV4x0uVtCA4dPihpF8Bir5mZsQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUYpZcHY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUYpZcHY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-855d2bfae95so4541874b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Sep 2026 23:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788761716; x=1789366516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XBOjAJZv7VoWT7HeRN3N+zGKpkHHnMAZ/hXhWpBPzzM=;
        b=QUYpZcHYmP1XqpvAX9edhGvDmrzD9h7wd3wliWV6JL4nyNmPLzt2EeeFa/lMdIrFyp
         F4xAFw1LlQe89pnVhZxmAx341XTO/cdRgIQUR3kMNFx/gOq/l/4OyhGz2JEOCjIJY+Kn
         fe6FvCgWNq1haUwvcamBb4M1+i7ZqDbEaWV+qGh7/GYrWvt5eX7u/IG7vAhGSmdXAibS
         rVAdfmhz6DNE9Sv8FGTxyjddAas8qINRPPcGrZ97M7T3R1oYeDRjAbpYAXGmEZxK/DHM
         7c4fJoacPZ+m0rCch/0q9KLVoxHhO1uAg0GHj/1aMuKmw70NhR+nj4Xuy/oXfhM7v7Jt
         wxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788761716; x=1789366516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XBOjAJZv7VoWT7HeRN3N+zGKpkHHnMAZ/hXhWpBPzzM=;
        b=AZXiMYA3hIbinJoMARjqn3JjjYN/AdtFZSQw5i2ddhD2DOTfQV4oS7wJCRg7v9JTtt
         +j0svCVfCK+NPETnIpgbjuPolCj+SDLYr2Kz0TaR8llB2jTAzpshOXGhXOpgGlb84Ccu
         43FKx1DarEfuqM6ZEJaj4MQHyFVRMcujA2IIaBpu7dBicPi4uR0M/Enh722BOeoF3A0n
         IEqc0Q3GItGl5lFfTK5sA1bcGk/4EbDmHs2Ju0ubmcGfN+lltimLHesrrKuSkVYRqaAJ
         grli9/lUyr6/Kkw/EmnCe/JO3KnGBhslSJcnfM1tIlTa7TxjDh7oIKlMDoM81YRHWyDo
         HrPw==
X-Forwarded-Encrypted: i=1; AKwUvBzdXoc+898mZqEe43nsIin6mqKISfjpwbd1kisorh6u/iCEeU96wZcnEjRuNwQBxHbvLDyXeHHnZyRlLXFB@vger.kernel.org
X-Gm-Message-State: AFuF++lBbScVgZ/n0VGpepdm9Eme1wgUDbVBcHEufqaPBWXA26NYpwd8
	WYoiPoYcgfQb5SW91XoGqHy86tjPCiMr9MwyruIZhnEuwe/pgMxsf8r/
X-Gm-Gg: AYBFou2AbuVoOchJ8x+ej+5OPb220qVrwjevgciZ3NM0sCc3crP8U0URbXYU6Jal8Hk
	+qFZjgvOmvbHWRlI7RHvSYsw6KSCMtPK6RfzEZRUKb6zCrEz4iTT7AHeKbQMg3WS+KJJO0SuFkr
	iSIJNiDGA1i4Gnd/WQOya/5pnTBUcZmQcD7dDspvhlBIQMEJ6h3oYpDLLhf+bW01WH8AXJZ2lDG
	FYv/FdWY4u7ZLPpP6RU/IQ7fznfVwXsJJ2EwVRl1Y2tZLUm42GZeWYOzTWVXbwbTSuq91RBmKzU
	CBIL9nXDHEr6J4QZUwnJfO9CNh+M66ZF3LjLPs1AlUCbfjUzVhD9Yd3ANoxmXeakdx5192D6ZuT
	dQ0TXwaVH4D9NLX2+3Qv1z6Z95rsgP1kaRng2JACaQYtmmUVhXlWZ8cLYjiRrF5my4Mx6/hqw1/
	Q0LgtPUIFxTRBh4eZlIUe+r3dOevKH8L3uL8q9nNDEq59q18H9NyixGevSZZ1tbaeLoyu0fYw9L
	TgPRZhwTbQh4w==
X-Received: by 2002:a05:6a21:3292:b0:3cb:b6b0:1b83 with SMTP id adf61e73a8af0-3da214199afmr26825240637.9.1788761716261;
        Sun, 06 Sep 2026 23:15:16 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14340a69666sm4657413c88.9.2026.09.06.23.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:15:15 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: fix repeated words in comments
Date: Mon,  7 Sep 2026 11:45:11 +0530
Message-ID: <20260907061511.35092-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop words accidentally written twice, reported by checkpatch.pl as a
possible repeated word.  Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 fs/netfs/direct_write.c | 2 +-
 include/linux/netfs.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index c16fbad286a1..634a860f3ebb 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -247,7 +247,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		/* If this is an async op and we're not using a bounce buffer,
 		 * we have to save the source buffer as the iterator is only
 		 * good until we return.  In such a case, extract an iterator
-		 * to represent as much of the the output buffer as we can
+		 * to represent as much of the output buffer as we can
 		 * manage.  Note that the extraction might not be able to
 		 * allocate a sufficiently large bvec array and may shorten the
 		 * request.
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index f837a501008c..fc6e76102642 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -627,7 +627,7 @@ static inline void netfs_write_zero_point(struct inode *inode,
  * @inode: The inode to access
  * @i_size: Where to return the local file size.
  * @remote_i_size: Where to return the size of the file on the server
- * @zero_point: Where to return the the point beyond which the server has no data
+ * @zero_point: Where to return the point beyond which the server has no data
  *
  * Read remote_i_size and zero_point safely without the potential for tearing
  * on 32-bit arches.
-- 
2.48.1

