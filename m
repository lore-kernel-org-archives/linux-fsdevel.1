Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2501A348458
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711936; cv=none; b=pqlwj8h7O0Xsi7RUXmrI3ZG/0rYgzIln/SpqBcMQ2BmVAZcUWahouFXzgRq99OFjoZ83VQjPwfMASwYzNbA3y0JyGXnwkwZo0+wfIAwTZxsfbsdckxuWVuW8VM7lHlxJgoc1GxAP1JSlEZrmLzeC4LBByNAXlKi9DN++1V56jcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711936; c=relaxed/simple;
	bh=gmOLacFBLCNj5VvdypSCbBb3+/owFsIUDBdTNEiM7QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+SS8TWfqZ6aR67aj2uqwc5cLsW2WLuGT+HGNxAEO7ku39D/Q0u7qNnjt5hP+TNh+3wla54q/63ZDRcd1mO2eV9ln+N17GSjMSRXeef2VRgwZkOvkOSNyTLGDnsI4xvm0oJO6CC+z/1KHI+SmeL+mMNoTU5prE7v/ij0iRNP9iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKtJNYy0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKtJNYy0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so2619582f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774711930; x=1775316730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQLr+3qAuCwpPc4ueOptHqyuEcLu/FKN06xV1u7l/MM=;
        b=JKtJNYy091Ew3hS08qXDYPtAFUqHbPfMtU2JUA+4i+29AAk76nsZeVURnHc7cX2D+D
         Sfq5aDmo0AH9Wp4cs25DZo+rrFrq6OJhTajCg7NCwoXELxpU9sBermHLGpbXQ971NSKA
         pzZZfgQPv293FV9sVnZKmXarftUQ7NcwKk89eeNtJHy85eGTBWnqLBx3rhb2nJ8nPBqZ
         6nnGDaWxugl+qgxRPyfRGl+Fc2U16PDGGBsAj3NA7DFHKVeZdp3wWDWuZ8mhVMXaX5/m
         dcF8q3njesLARMymAK6E9VE2GdUTUD96x6lK11FhqpUnZYakexirlJKOV98kIwlojUIn
         FlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774711930; x=1775316730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KQLr+3qAuCwpPc4ueOptHqyuEcLu/FKN06xV1u7l/MM=;
        b=mPXhYzVDld5y1E2k2I4magajIH1/fyy7C51WdJUKz5ifjdDCgIe2UPV7SSyCpQEqrU
         cCwj6h+wEoO9lcIvp47xU/7NzPgl6ApMp/5eX+lOF5e2FJVjBLIsOYcO/VXqK7HTvQ/9
         OWa3G5NWQzU7vAOcaNKbzD06xoDCLsIouHGQp1G4HYiY6xMHt3qlkpYUXdAkJgVqmjsx
         32uRo68giWb0KIkoNA92HZGIVcMDTSqm97maufd7PZSKSB3DK9yBynIj/OBtYr3MVK2P
         yJiGCm9Vblr5dFiE0B7Tb3/mRXbcfxn8blncYGRU1bIp0G7iwHJOa0cEuWbX+zk8e7yB
         Joow==
X-Forwarded-Encrypted: i=1; AJvYcCU0s/jAi3tffHIZrmVrc4BftGYTCbK39DK0qBsfo0L6Bptq+0aSVyRC4QYcnKhCSvUyEd2JwJDjS8LDIVSz@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzu5wV+FCOSYTqSsfM0VAUijEqFQ3+XVcFtnSLuTH0LeVLjxRv
	atNd542ygxVPhozvufc6XBX0jbc27PRC6YOnRXGl5FV0IeJSfzXnDDVk
X-Gm-Gg: ATEYQzyr3ierjeYjxcyUPwdkd1vbxs7Nut0D2H2T/3nCKTi9ULR1fmp24M79gx0D2Nx
	4clhnjJSvmGeTH2yPP6OPILdPZrFEdnHUIMyeAFnnvaxvm8mTeYalNSqBVwc44Msf7ZvvBixPpI
	MEzlSS6KtBGj2Kss37pXNrW+046qcq4CK8WHc8ax0gxJJIktIeEdoj9SwXdEXBcpIgGre+6pS+r
	LVPdPZfTIAE3WShismgLrYfltQJQXf0LEZ3Yjg9oa3DpQWBJOAOqdUlrOYRzXCK420Yl0BUnDrZ
	C79uxPLfyfx4cibjdlqzOD/COMEP3xsQ4gQqJDEnUvRdpahqJenJDLRiUiyhMmLAdkXa3yMRQHu
	Ye6pRwh2h7M1/YaSNqgSWss39ZZjsh7SUXQY81+Mxk4PgK5iy3TkPfASO09r88cSr5vXX6dUfJ3
	DhKQaft/WmD4ek78920VhsaqG+Sl6GONOc7zkJM63MdYDTtC+DrVfZuiszhzYsHCS8RnXMBTUIi
	A==
X-Received: by 2002:a5d:5402:0:b0:43c:ef4f:79cd with SMTP id ffacd0b85a97d-43cef4f7b47mr3752356f8f.48.1774711930452;
        Sat, 28 Mar 2026 08:32:10 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f8a3sm6725310f8f.24.2026.03.28.08.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:32:09 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 5/5] fs: locklessly bump refs in igrab as long as it does not transition 0->1
Date: Sat, 28 Mar 2026 16:31:46 +0100
Message-ID: <20260328153146.3368470-7-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328153146.3368470-1-mjguzik@gmail.com>
References: <20260328153146.3368470-1-mjguzik@gmail.com>
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
index fc6045e6d43f..17b925887382 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1580,6 +1580,11 @@ EXPORT_SYMBOL(iunique);
 
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

