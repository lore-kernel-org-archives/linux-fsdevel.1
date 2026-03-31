Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2620E423A61
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973350; cv=none; b=lV+ynuoHPZM7IToBKhUmPorYZNX38N9jw0Hll5j9T+yaxDpuq6uM41CoK0hJmzrMhUoRhGeuKJGqNG2a8ftyLPwPTGSygi/55+f/pk3KwbOoC+3C5ICw6zqoCfTw/R1Ek72ySBT4J2nj32RBJRWPGlBkBrU0M0G6IG06n5up8Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973350; c=relaxed/simple;
	bh=Kx0hCzlQLvB2ZwWtgXSqQFrn1UOzjSBANutOmgJEla8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBvzIwPtC6qDv39ji/gDOdC47aiZGIlhzPtRAvxA/iu/mCTnC+okFS2Dw+K/OqAJyCVkxYtMt7m2F3MRyqTM25uFxILYZTZsbkO/4M1CuTU5oWD7R5v1CCeGXBIojAebXsdzhtQABfpleyqStNkjs4mSYnyT82tJhbEQS3qt0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8FSt3T0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8FSt3T0"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cfbd17589so2536769f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774973347; x=1775578147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAjANhRSSjFG14Tt4RrpUuJ/1k05o3tXfxT9ZI8DWb4=;
        b=g8FSt3T02fI/YQZMCiL5sHjiSYS2HMRjztBx5W9JznBNx/qYnBk0AATWFKwcc7kVoQ
         Rxl7Hf3I9MEWXJESRL8MhAXh57z+yulRFzlaRvHrk1ZHewV3XwtMxZYaXAzp/6WIwaR/
         riGP2hMDgOKPHhaVA/c2ytOSiwQAlyM5UHC/dvCkSNM9nEU21U4G60PehDoKYtY8LMtq
         QCOtQcuAuUC9+IB47OUMJg9+/MpAGhRnm49aiaZyy3sseYbumsGTfInqKV13N2zzxU8z
         CHzH6YXHeBtmsDG1ChFMO4IbJSLKoyvhZgt1hWhq7zOTX8XmJQTlw0Bq2s5IwnebK/lF
         R+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774973347; x=1775578147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IAjANhRSSjFG14Tt4RrpUuJ/1k05o3tXfxT9ZI8DWb4=;
        b=ndgCaoMkOBbtL3ljEEiaNNJR+itD7dsBigdW+Pl2yfHW44aFGYWr9Cnf18CwtDYJ52
         N4e4w0gJUBRa5moL26qfP3iEO1DwyyfoczizLynKs9E2QbRRuFpsLkBWLc5xifpun2NU
         lseEvjRCqqDGNTmjWduO8T+DJDka7Y5uEy1nIf/+2QpDl8aT0bpZuobiIuIUwQ3A+w7d
         rfiar9OCXm99F4NYgWrJfltm0+VEaL8J1YNBqkskKTAVyjbGjSSTmOESDkz62pfQlzwR
         Ap6vMEKXCqjxvSTjYcWOMQ3aDKAgrBWC0Nrv2bewYfXUgNUMSZSKn6xiCssiW8SQMJoU
         gR2w==
X-Forwarded-Encrypted: i=1; AJvYcCVsVtHfTJ7RCa6mTuoMXxMeLyccepmeE801FFmB1gDbb+K02WDmQ7rbEN7H+INHYkBNugcLsTSYkv1obOKP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hLm0P9ydyWkjvcPemDoQWYIjf6/i9LWfGQpufCNYl77B+syU
	aHIgn/mLTXmsUX3195eWLJElvYxuhTjdLuUTYo4WjeHmYQRqjm+A5Bm6
X-Gm-Gg: ATEYQzw5COVVPYx43E1OLgsSZzor1/1s7Uzs34xqNZ5AKt4W4IDQClZfeoOMkEDqjpo
	gYxWMxocyZa+RDRB1DUKgGUvxbDIJqIBv5nIXejT+HccrBDMLjkp8z6oHIbF3t/p+wtRak/z0Ze
	KZY18AP1Rtm2iqqmkpjhUWkSwjoUkIPR259pS+qcHQ3GPJKs6ZkBr+lN6t5YAQqag1nAQW8iQPu
	PDh+G0UqaKLkQTlN40HA0HX+cYW0RdDMT7t6dGlZIJNt9GJo3sfOnzcMNCIc918uZzT870tEE1K
	iMbfZYoiMKAuxlDAQoTmtAqTjo71U9KZvrx8ASo/qrUiRaaaqZlk43zWKdA56Yq9VMiuhX9cusL
	Mo7IpOOxRVTXmeKSET4DHJi1ZenN6yP3+uW9AEusXu0lhr1xfhobJXLESssQmzQ6KqC6yiBsXPI
	YLjarUloApnhaHFlfclFMBO9rr1WEhYTpC9y6R1rfeRtQJ7ax7bzQoUv5aTJuSVIRwnuNAdm0DN
	g==
X-Received: by 2002:a05:6000:3106:b0:43b:45f5:eec with SMTP id ffacd0b85a97d-43d1504d2c0mr401055f8f.4.1774973347360;
        Tue, 31 Mar 2026 09:09:07 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e3602sm28792632f8f.4.2026.03.31.09.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:09:06 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v5 3/4] fs: handle potential filesystems which use I_DONTCACHE and drop the lock in ->drop_inode
Date: Tue, 31 Mar 2026 18:08:50 +0200
Message-ID: <20260331160851.3854954-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331160851.3854954-1-mjguzik@gmail.com>
References: <20260331160851.3854954-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs and ntfs play games where they transitioning the refcount 0->1 and release
the inode spinlock, allowing other threads to grab a ref of their own.

They also return 0 in that case, making this problem harmless.

However, should they start using the I_DONTCACHE machinery down the road
while retaining the above, iput_final() will get a race where it can
proceed to teardown an inode with references.

The easiest way out for the time being is to future-proof it by
predicating caching on the count.

Developing better ->drop_inode semantics and sanitizing all users is
left as en exercise for the reader.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index e397a4b56671..013470e6d144 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1935,20 +1935,29 @@ static void iput_final(struct inode *inode)
 	else
 		drop = inode_generic_drop(inode);
 
-	if (!drop &&
-	    !(inode_state_read(inode) & I_DONTCACHE) &&
-	    (sb->s_flags & SB_ACTIVE)) {
+	/*
+	 * FIXME: there are ->drop_inode hooks playing nasty games releasing the
+	 * spinlock and temporarily grabbing refs, in turn opening a possibility
+	 * someone else will sneak in and grab a ref while it happens.
+	 *
+	 * If such a hook returns 0 (== don't drop) it ends being up harmless as long
+	 * as the inode is not marked with I_DONTCACHE. Otherwise we are proceeding
+	 * with teardown despite references being present.
+	 *
+	 * Damage-control the problem by including the count in the decision. However,
+	 * assert no refs showed up if the hook decided to drop the inode.
+	 */
+	if (drop)
+		VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
+
+	if (unlikely(icount_read(inode) > 0) ||
+	    (!drop && !(inode_state_read(inode) & I_DONTCACHE) &&
+	    (sb->s_flags & SB_ACTIVE))) {
 		__inode_lru_list_add(inode, true);
 		spin_unlock(&inode->i_lock);
 		return;
 	}
 
-	/*
-	 * Re-check ->i_count in case the ->drop_inode() hooks played games.
-	 * Note we only execute this if the verdict was to drop the inode.
-	 */
-	VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
-
 	if (drop) {
 		inode_state_set(inode, I_FREEING);
 	} else {
-- 
2.48.1

