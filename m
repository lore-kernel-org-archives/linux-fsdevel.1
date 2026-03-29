Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CA37CD53
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774804820; cv=none; b=huXYC9rBEezg7ppFckORhU+ccnxfncPUVTcJV7swGhQJxWHxUbrz5/7rUnWWEMNz965zX1U4WELxFez1jsj9EjRZmmy/j2xxzm6IXmzyhhGx5PVu15qM3PjCLCwkOl9ylmqZs/eW3u8TlKGwfrDHqopiEpyoMFeDqRLHve99o5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774804820; c=relaxed/simple;
	bh=HZYHztId16pgGQ1AA2UfRM6DJRt8s7EcWewCjcgDwxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuzrUQyCCMinyLS6dsIAKkGC9bZE7gfR7uVWpBHlBfio20t53K7fWAPDg5q1KMPjJZut2NDv9yEa24dIsfBMclvbFWVl4N9w6wtXba5VayFBoFLrSL3kibM1j6s/wJTtfQMYF3g+DMcZuECiS0WhG0fz8NnFEzuks1zCEcST5Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niFPxUXC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niFPxUXC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48541edecf9so47483085e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774804817; x=1775409617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqq43BIgVMA1uE3zJr5f2QtdxqeDEFGIZU0biEFlpEg=;
        b=niFPxUXC/63chZUq+K34EG3QtUOVNXVlgdYPHjrBa8ngLmDm6bQak9thHc5kGYqhgh
         gCgsQwhOu40Wb3SmYD/qxSgcMlmidwlLD96+rO55faYzrpFBe6uoei+/pK5rzUa+OJGI
         V9faHJ678PgPTWy6SPazkJdL1XPygDKbS/D3u9Stjcsy/35J7IYkAWaIXR26fcdfSIdG
         OyzBIYt/IYROOGfg2+tWrM5EodpHYa5qzsfBGJI2Tx643b4A5LUbv5Ee5VJRnilRArCo
         DmHSPSXr4Cfx82Une3NckzzqieQVqYGJNjZG3iPPb15QLzjweH2sAUQTZF+TWFqxmJzA
         LX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774804817; x=1775409617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wqq43BIgVMA1uE3zJr5f2QtdxqeDEFGIZU0biEFlpEg=;
        b=fQm+y1ufZH1ODLlBgooY9BOA+KJeksxVfcoHO8KxFs79x7pP1g310/1mSppLvqA0wg
         N5hQeK4C1EvfRm2DYis0lHn2CM5fY26f3WidBvBoG0KwZXJ7D6d0ey/jiHy/MvTtN+XW
         cydDF7VdIcRssXh3UeKGT0i8ElsX03Oai7JHCiMI5Upo9BhPwKjdEtvgFxORAP9UdWa/
         mUwxRQCwn/vxTHLl2hUKiJOCdQFj5AXq4KeZrFv652dhgOsClBXojQWxtj7rSn1sj6Ph
         +DWGjkiiWzFayDYldgBklbjmRyMu4jHREm7+krtQI9J/2zG7dBLU/rtRENwLsO1fU8rZ
         4Z/w==
X-Forwarded-Encrypted: i=1; AJvYcCXuhufWYN4jYwf5CAWKkXQZ0HWPc2NMHNXTisJfXm6ru6HPBydW9KrMpew11rmlB4f8H0ROpgf0t3XeZ7iW@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9xWHBAI4pFc5ACKE0iTJZYaBK6ZetLXIiooG5yjlixM/LD6Ls
	b4//KLQiAu3CSwmbClLEzXF/ogQGtMQLN6fltfk50j31EISil9dcQ5Qu
X-Gm-Gg: ATEYQzxQSbgTgmjkFzgOHa+ZgzRSxfajc/gVC3qJwozL0v5N8Ldlh3aUvnDmzMCmLIE
	pNJxuQRiqNG9CMJ7bJdyPlMBy2F6NxT0+ksdtrIiVyJ9nEa/X0beSMqyl19obaSgVkHdPAi1wtl
	24JpQXykyj3OfWWviuk99jCL68uxyjVLnzxTS7qH7RTgA12fc+kwLbnWeyqyZ0eLQ8c5BOfYkIJ
	mWbDyouKe5E71Jdpe0GGpBJqDGkfFNn76cDGi6MUZtFe+lixaGJlgICuydLd+COr88ojatTzBWU
	acQWiv/YZs08gWFCaAo6eiQubdnqb+sXOaU3L6XkV+oAEZDEjyk1aYcMqP0Ck2b+EFxlYVFLHI1
	uXkPY7ADvIErTR7hjnHc1jlmIzYzqvV7+fEQrNc8SAYF1pPAGq+5GKDcAfILZcZP9WXpzc/Tu1M
	d8Ze8xx4VrPnHcNwjpQMnvo3YpfDP/TAnfYmg22j8lGSlU3u7YWOnAh0xqrcwUDXOtNuUkGQkAd
	g==
X-Received: by 2002:a05:600c:45c4:b0:486:fe45:483 with SMTP id 5b1f17b1804b1-48727efbed2mr164015635e9.22.1774804817218;
        Sun, 29 Mar 2026 10:20:17 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873cd7d039sm9776805e9.15.2026.03.29.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 10:20:16 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 3/7] fs: enforce locking in icount_read(), add some commentary
Date: Sun, 29 Mar 2026 19:19:58 +0200
Message-ID: <20260329172002.3557801-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329172002.3557801-1-mjguzik@gmail.com>
References: <20260329172002.3557801-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0cf27085a579..07363fce4406 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2225,13 +2225,21 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+/*
+ * returns the refcount on the inode. it can change arbitrarily.
+ */
 static inline int icount_read_once(const struct inode *inode)
 {
 	return atomic_read(&inode->i_count);
 }
 
+/*
+ * returns the refcount on the inode. The lock guarantees no new references
+ * are added, but references can be dropped as long as the result is > 0.
+ */
 static inline int icount_read(const struct inode *inode)
 {
+	lockdep_assert_held(&inode->i_lock);
 	return atomic_read(&inode->i_count);
 }
 
-- 
2.48.1

