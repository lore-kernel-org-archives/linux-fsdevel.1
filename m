Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22A4DA52F
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353412; cv=none; b=kbozSv4nMhpL4UiJe3b5z0N66ZeSbuEPGHiok+9WhuP2Xxw9PjI8mExD96CTtvCES8nkpYG7Icl3A9NPmF4QCbk60IDgl/BX4+XhjM25X4ppN7pQ2UXkIFXpp29Ic3Pt1Q+oGYtqeXwGWqzIYInQJNBgUVlEsAFekhMeAv0+ikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353412; c=relaxed/simple;
	bh=U/rckYROPBe6b5K0Y/8tt470oUNqTpGawesJbxo/iRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPzjh6bM8Q4sSWQmjpIumGqwoRfwepR8TBgk3sLuqCEcLR7uCcvuqq7tkn2IYEvy3TAd/IqzUjG2v8WQGorJLUES1p61l4CvT08CK2y8gBdfOpvbvbqFSKMgOh8F0XXN9PEraj6dRvNnCHX8bVeQ+1OfO+EN1X/1uEVt3uWFm98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqCtwt97; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqCtwt97"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84e0688b859so916922b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353399; x=1785958199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BvkbA25OGT8gs7alZHVVlBMx4s9jhvYzzcPoZrf679g=;
        b=TqCtwt97HFDak/L7IUpHUs52nEX/Qa7tx7/T8UQks1G692H5lgUhL9u/NAyamrxc08
         xw+oX7kN0d2z8OL2LF/BJO8zaQwy3d6ihjfHIltvMuFekVc7et556dureb5RiPvkNrUg
         avbFHTUHj9KBy5exJD3BERvxBZWOKOgu8/LrXKH1q9mybhYh01EFi/FXpornTeT6csfH
         imsBXKte31+qSpEOR/Nxb/8BzDk75UX3YAOoJsqu5ayT/+Mayv6mPVtvcv/CNF44IDAc
         4gAXcK8ebIF7tizbN32qu4XIYRTY8kc6rF7dqt2H4VV3Hjg8mxlndgdVuhS5zZQmzMIY
         NTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353399; x=1785958199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BvkbA25OGT8gs7alZHVVlBMx4s9jhvYzzcPoZrf679g=;
        b=SbsgC7D+u88F1ecVVWxYZKXfCt5gezXXVVAOG78MuJBAZ7trwJhOGdYdyuA2tJO3sA
         VVLraggXP/dVZ3zr+9kZ7CYpTOw78ArpRUBWPOX8lkt5D1iEy7gMN7Pf6vsfJTDdE4GN
         gZxoExHS/A6W0iTOuplOjgC7Kr241EcyYqw2dSR7yLwAIihdb3pKCXZuVM/nbDwwt3Te
         sDT+Fh8hv+N8EQNCPJO6nNf1sq4xMnhXB75fD2KAWDsBLjPEq8BdeFtCmGb39Qq1C6vV
         LTX9wnv6kwCZ7bDg3Fu2Dq42/mKxqJ8OFGp6y2ibxOSJ//7ltpBbGfQoLrtVtq8aL3yK
         XyLw==
X-Forwarded-Encrypted: i=1; AHgh+Rom7AMJIgfqWvn/TB2djBAO9ocig8KbNnTctmb8zh2WPThoCCwm1Sznt1RmfhNJk753CgH6AnwDR2GH1LIz@vger.kernel.org
X-Gm-Message-State: AOJu0YykHakbY7us9G6TK+po7NvYa+NZCYDfmFRAqoAYMsAmGjLNbgqX
	1FgQK9tYzFJ8hoR6JxssQYkKkzanbljhQzLKfcyJmPyrX6QMYKCBGnTA
X-Gm-Gg: AR+sD10XZs887vWkciOC3dheHfc82qnDlOwb1k9y9xVJ0wXMMIXsMjW7pJwGnhpv4EM
	d8rZS7VryzjY384fPk28mrJgy1H0RD+MVP5KMhYhhrpPQos0yvZUC8OuY/a1G/94eXbOluLSbqi
	Djonnf1D4kspVMwHbV+EwOLDH4vz3GbLjg/xRRxZ732sXBRRKQJBFdTY4jP6iXDb090zID2bmL4
	QQiu0BzkrchfJlL7Lm9LE6mQypbYQStECOFozjGubd0mkBsV+qe3EQhrX9T1Idma3LQm8R52Iox
	XPcD/OJK0FF6gvuicGnLsut237iTg6Cfqw4F7La/5pqPRQUwziAZXaXac/AwWDL78Nin8MJUBVQ
	LAfoaX+Af58btkYgTYdkmLS8mfOFpqV6GxGoKJkVnr7fJzp+z9a8mbmZEC4ILd13wBODxFTcSW2
	EE32PWXfJv9LEFFTh15Wiyd0vTmm/qkjDYEb36uCaqtokKIS2VRU7uSOrDt5qpo7Suopcy+6lwW
	oNySCoUFBKfoMXmoj3HHQ9snltaQ4fG/5R235c+/X8vt1MCQlo=
X-Received: by 2002:a05:6a00:139d:b0:848:31fb:43d9 with SMTP id d2e1a72fcca58-84eba1d3555mr65509b3a.45.1785353398841;
        Wed, 29 Jul 2026 12:29:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02f8461sm1842019b3a.28.2026.07.29.12.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:29:58 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	bfoster@redhat.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v5 05/22] iomap: add ->iomap_next()
Date: Wed, 29 Jul 2026 12:27:20 -0700
Message-ID: <20260729192737.3190206-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260729192737.3190206-1-joannelkoong@gmail.com>
References: <20260729192737.3190206-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have one ->iomap_next() callback instead of ->iomap_begin() and
->iomap_end(). ->iomap_next() finishes the previous mapping if needed,
and produces the next mapping.

Collapsing to a single callback lets a performance-critical caller
inline its iteration loop and pass its ->iomap_next() function as a
compile-time constant, so the compiler can devirtualize that callback
into a direct call instead of an indirect call through a function
pointer.

iomap_iter() uses ->iomap_next() when the filesystem provides that
callback and otherwise falls back to the ->iomap_begin()/->iomap_end()
path, so filesystems can be converted one at a time.

Suggested-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/iter.c       | 8 ++++++--
 include/linux/iomap.h | 9 +++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index bf7d4cccc1a7..c445a38b6285 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -118,8 +118,12 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 
 	trace_iomap_iter(iter, ops, _RET_IP_);
 
-	ret = iomap_iter_next(iter, &iter->iomap, &iter->srcmap,
-			ops->iomap_begin, ops->iomap_end);
+	if (ops->iomap_next)
+		ret = ops->iomap_next(iter, &iter->iomap, &iter->srcmap);
+	else
+		ret = iomap_iter_next(iter, &iter->iomap, &iter->srcmap,
+				ops->iomap_begin, ops->iomap_end);
+
 	iter->status = 0;
 	if (ret > 0)
 		iomap_iter_done(iter);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 80832edc7ec2..d203d9fe0f89 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -231,9 +231,18 @@ typedef int (*iomap_iter_begin_fn)(struct inode *inode, loff_t pos,
 typedef int (*iomap_iter_end_fn)(struct inode *inode, loff_t pos, loff_t length,
 		ssize_t written, unsigned flags, struct iomap *iomap);
 
+/*
+ * Produce the next mapping (finishing the previous one if needed).
+ * Return 1 to continue iterating, 0 if the range is fully consumed, or a
+ * negative error on failure.
+ */
+typedef int (*iomap_iter_next_fn)(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap);
+
 struct iomap_ops {
 	iomap_iter_begin_fn iomap_begin;
 	iomap_iter_end_fn iomap_end;
+	iomap_iter_next_fn iomap_next;
 };
 
 /**
-- 
2.52.0

