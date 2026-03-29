Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C1386551
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774804826; cv=none; b=kuGBhxZnHqyVr6NGENfIRxBxDWTJytFgE229I/cZI9g/g9s4fynKHkS+azlUmVFpGFuM5qgdGXDjkGJyPQXvAP9k9LDyflfOD8pxTfRd+P+tIOg1hP/aqKtpohkISXO6yXrPZHRmKpdrXY/uHmmm8wCIZQxiScRXrGu7rVuk18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774804826; c=relaxed/simple;
	bh=aDru4qjl/iYVBfN5B5xn9JTcaAG/lsaOLojHF6nk8UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnqsvtjVEJvXFmZMi6TnfdNfLI/M8ZbsSaTuczTuyPH6AyCjU3KhfUE9YB/K/sPpHEjO2PpS+qpdZoIsNHPms+BU0PSFDl8/HguxqxUvOg08n/WKClV5XYB1QlVryGhyAX4B4pae9KMnIi9tpVdZ696/ertOM0Ioj5hjh3QX9y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2bYDMpU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2bYDMpU"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so49416545e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774804821; x=1775409621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEImE9v8UsSlxEU0A2Tuvpp3kv2Is3KLwcc3BUa1x8Y=;
        b=s2bYDMpUKTbn49VtJb3RwtATDdzh9MsfJewiHhG9t9nD5vFxp2KlbIQDX5X9TouXa/
         99tcpKJhrUZBY7im241ZlAFzOuWOf+QVYJZjRrI3VTK2hutlVb8qGKFOKIfdXy4GQPyr
         wR5HRH/WloKyfzTiUPJfDAvwI8RpNU5EDtxifvuQY938TPNdxrU510kTXu3yLyVBPLM1
         MIPsVBR8cowJyHuMhyl4tTQXV3aJrYowjgn22gwmey4UHHrOLw2JC94RPWZxx9Tbjy31
         SfmWsVRIJpHeA5iv72qWmX41OmoxiKcx6fc18h38W3XVZx4hCtg7cUmo7WP9is5ETQM+
         Xj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774804821; x=1775409621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tEImE9v8UsSlxEU0A2Tuvpp3kv2Is3KLwcc3BUa1x8Y=;
        b=plpHCau266BtEuHYcfPVlDZYAA/UyVFxJbO/RmzRSbVwhc7/X9YMUvHCDpUO9U/XN2
         w26j6BUEGAuvotvre45ji/M2+iEfejWGLi6L8dnJrMq62m7ht9NbtRhsxYqMpwpQJtKa
         iXJ73mCfjU6LFWeDxoJt+WUSqbZgfKFxp9Up/S3Qcv1TNCWmhNVNZLCh87rkYI+MF5Ry
         /znRAKmBFRYNdWSc/nxiYmspISVjKa1NYSMz9CFlUBrl84vKsTs1wO4DU1VR+mFTrmjq
         reVHDTUjq91+t1y9QW2FmtEbiEkSseus5oLC8yExLHImb3KM2H3F9siejxHqULbEShSr
         M99Q==
X-Forwarded-Encrypted: i=1; AJvYcCUV0hwwckRo198nmj41oZBSvDox4pX2Dwvo96wXyldL4Ho+JHjsmTjgk1DdXhDHQw9VWbskikf3HyH52M1V@vger.kernel.org
X-Gm-Message-State: AOJu0YwnOcD22A+ZWdDSen1HSjqb2Y/QzUSB+ah0yZ6JntyLaVqLu7gs
	5dtF4dUceyyKyQcgxer/PIpOaYKsclvgUwX7muYVfIchVbGAFsHZFpLU
X-Gm-Gg: ATEYQzyTgYfLUMDIdDLxl2/pEzo/7u7w3u2to8vCP30Vav60QlPP8yKZSodi0gx9OIe
	qYhWOPYbD00/HEGejrMl5G2XTzjp/zz0qW+fGWFUteCxoxcNU9OK6N1/hYCsnp8FJgKTNjF0/Tk
	U6NDU2m4dFdSGfGMtVDkPtHSfktooEyRdkuAlBVhi4+NPP6Ux5AONl6mSOF8TJf8f12b++JTRr7
	ahy3z/6639tNoWBxi8KWD0YkhN2TtC5Su6MC8dm2L0eoBUfSXQ6dX1tWP+4Jy1DA87ooQb7MiZ1
	wmu/B4+N0UHDwx2/cLM8t/1676gfjGzqH508fCZhZPIVZcp94J7tSzXlTR5j5yYH8qm2GcT/hbN
	ncpnChDC6XdZJHubpo8LEIvJdWSZ+5iKm/j1w+YuV+J4SMZecJVBuapc/kR2akB+IZP6OhzkrVi
	gigGJeU9ReNAnjogGpeQQP4+gf3eqvfMJ6un/C2vHPLnxFUD1iJbbzR30tgJK372RUuKAtj3gol
	g==
X-Received: by 2002:a05:600c:64c3:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-48727d59bb9mr164125175e9.7.1774804820679;
        Sun, 29 Mar 2026 10:20:20 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873cd7d039sm9776805e9.15.2026.03.29.10.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 10:20:20 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 6/7] fs: locklessly bump refs in igrab as long as it does not transition 0->1
Date: Sun, 29 Mar 2026 19:20:01 +0200
Message-ID: <20260329172002.3557801-7-mjguzik@gmail.com>
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

The bump is gated by I_FREEING | I_WILL_FREE, but these flags can only
legally show up if the count is 0. Consequently if the value is at least
1 and it succesfully CAS'ed to something higher, the flags must not be
there.

I verified all places which look at the refcount either only care about
it staying 0 (and have the lock enforce it) or don't hold the inode lock
to begin with. Thus the patch retains the invariant for correct consumers
and does not make things worse for the rest.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c         | 5 +++++
 include/linux/fs.h | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index a417abc64822..c7585924d5c8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1582,6 +1582,11 @@ EXPORT_SYMBOL(ihold);
 
 struct inode *igrab(struct inode *inode)
 {
+	if (atomic_add_unless(&inode->i_count, 1, 0)) {
+		VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_WILL_FREE), inode);
+		return inode;
+	}
+
 	spin_lock(&inode->i_lock);
 	if (!(inode_state_read(inode) & (I_FREEING | I_WILL_FREE))) {
 		__iget(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 07363fce4406..119e0a3d2f42 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2234,8 +2234,8 @@ static inline int icount_read_once(const struct inode *inode)
 }
 
 /*
- * returns the refcount on the inode. The lock guarantees no new references
- * are added, but references can be dropped as long as the result is > 0.
+ * returns the refcount on the inode. The lock guarantees no 0->1 or 1->0 transitions
+ * of the count are going to take place, otherwise it changes arbitrarily.
  */
 static inline int icount_read(const struct inode *inode)
 {
-- 
2.48.1

