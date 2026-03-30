Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD43822B9
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 06:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774851269; cv=none; b=o2MuZPDTtWLiYmQkeMxyRiA/tV0HuuZI54hGLX5Ta+KxKQCiLbjkN3ZQT3quIqFCQUInP1M5BABYwGC/7Qj4WEq7y4j1QOBn5TRgsbVRLtXSbBLv+rTNg3F8KuJezI2ttHfOWinTeV5ve+8rDhthXasocLa39ZW9d4Cfxoao/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774851269; c=relaxed/simple;
	bh=9fgysPvBWabCsD6O2oYm+Fg+iWURaSP7DDq+E70mb+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXtYGgEoz22KQTQT9yy32WRn44MGsth+84V2zBy7w/bTilc/nW0lnXM3BxTb7qKwinXt5f2W32GJ98SqetbI9geppfjLoYadU+CoSlN3pAFWacUlgHrUTdR02clSaJH/xrhywiO/X/pFJXN50A1PsZX9i7TuA+N3n4fR3Am5tL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQRPkz3i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nUibT5lY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQRPkz3i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nUibT5lY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774851266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxHaYeUBdIPS/fa9jwW1R5ghMh5QYA1uyVZQIaSk8kY=;
	b=QQRPkz3i6quLcDx1cac3qepLRzTX+0WZN4jQQ9Kg59r0csNY4rVF/JmeJ/iNj6sjJYV572
	84+J4Hg1QhC8XL+QNj9Zaw1HAV2saqMieQpkGGVExYvHdZKD3PpatF7Sk9w1P/37nfHfKM
	qrcb/hEPbsW7NOt0cBsrlJ3PzXue/t8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-keHLA7upM7KHhKh6PKelSg-1; Mon, 30 Mar 2026 02:14:24 -0400
X-MC-Unique: keHLA7upM7KHhKh6PKelSg-1
X-Mimecast-MFC-AGG-ID: keHLA7upM7KHhKh6PKelSg_1774851264
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89ce375c788so51995736d6.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 23:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774851264; x=1775456064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxHaYeUBdIPS/fa9jwW1R5ghMh5QYA1uyVZQIaSk8kY=;
        b=nUibT5lYwmzdfS07Jm9NLdJbSI95Z2lcQPhHn5+B1MfQH8I0bHyxkLzLzAwH4vWQSy
         lW+jtCeUf1s4mTMORcowQ7GJbwVY3sTPggRMTXb15VPTJTIpYuGOFDlOdY8PazkLhFIw
         c0AVmrqL1BD4qZMx7/l/8AZQ5voXmMIrl4va1cqovrsdnLFPr+GnjtVRr9+u5G4zfD6h
         bwO/myUhdsw+5CHGoLFBY/2cbSrfOVpy373Wg0xXN5gKonqvwnPUDYAS+2SLOWZu4nm1
         BPYsYDdKDWa/25hdSLhh5z5qHUFqcUu/vZdVySaUKGRTtJMeonTx2PL+5tXveT7xnGRs
         JXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774851264; x=1775456064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BxHaYeUBdIPS/fa9jwW1R5ghMh5QYA1uyVZQIaSk8kY=;
        b=bnDk6qpOQ/lh/dTOr7sM9Ff93G+6MzGwBTFUQbh/3I2TS/ft/3UWaQaVIgIo52YjNx
         Sbly1c814inZvHcgPaWnF2CDg+GAVIoIdapBJNdd4BEuJATVcC+7Can963UGDBxi0eUH
         q17shh5negfJovksQAKdpK3GvVox1FgeTfmjtbo2kRyy/eBmIDIxpxqIWO1c6E6N9Dct
         X0cJW4wtrMcKk8azWPGI7ynUkVOfL+HTlogn1LSu0iIB3ksjdyriuJN9dKeWN4m6qdaf
         DZ+XyCTjgFN1xW4+HmCKj3EldacsKy9cIMzLDZKHI+Og6bXA9QY4/4O7LHfEwDGn55n9
         L4SA==
X-Forwarded-Encrypted: i=1; AJvYcCUHIcHYMQI6AztJalIUHdaTnCFBlFAijqF+jNhH0KN3F7qzaxvSI7XuzeaCrMLliRzhY4SmD8f7rbCiv2Im@vger.kernel.org
X-Gm-Message-State: AOJu0YwGl5SPjbwE0MQPCcJYB2s4EAoyoNZhXv1q0j9YFuDlB88ycYhF
	01LJRzh6RpvQ2CbOUUne7pBV2Kdc51qzx2uKayO+RA+og1IuVxfOQhRYn7vmz9oEELGighRsJLQ
	bsStqSCYiuzLNVusN83ChhHYJqmD/T5CBfOugdrYyAUOmmi/Htkjj5UDtUSrNyqbe9JU=
X-Gm-Gg: ATEYQzz1jo7sO3D9T4ji9bMx5OJ55BJ0yzKRSL3fMDQizpvdzv1JWRZ7668D41fZwne
	0YVnR+6ciQqMOKCDQNhqXCI1p/6eYBTC14qTJtJQ6iZ9ldc6P6KV+zDN9weDa1XLonu5gdVyDJL
	jbsuQjgANc19kKdpObRnMgu0+GoL46dHDp7hnTiVgbBC4QPpzC3BBNgW2RU+w/DPkIE3L4x8VdW
	q2bXTNvgOAZcsYMgeKmXVSnTmdPapBrMVe4IvmQtUFAuh3+udp9JSLCHp8lb5hIqjIB5kUyvRMU
	j8H3E55ksweY8BbpHnBqr9i6D0BbItff3pizq/D9dBI3AungaVdslfUabf0cn8fkuCk+Dgn8e+Y
	1VPWy2XjCd7LAOBR9
X-Received: by 2002:a05:6214:2b82:b0:8a1:3aa8:9141 with SMTP id 6a1803df08f44-8a13aa89af5mr32494036d6.28.1774851263878;
        Sun, 29 Mar 2026 23:14:23 -0700 (PDT)
X-Received: by 2002:a05:6214:2b82:b0:8a1:3aa8:9141 with SMTP id 6a1803df08f44-8a13aa89af5mr32493776d6.28.1774851263391;
        Sun, 29 Mar 2026 23:14:23 -0700 (PDT)
Received: from fedora.. ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89ecbc9e086sm57348246d6.12.2026.03.29.23.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 23:14:22 -0700 (PDT)
From: Ravi Singh <ravising@redhat.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: adilger@dilger.ca,
	jack@suse.com,
	cem@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	ravising@redhat.com
Subject: [PATCH v3] xfs: return default quota limits for IDs without a dquot
Date: Mon, 30 Mar 2026 14:14:14 +0800
Message-ID: <20260330061414.1190802-1-ravising@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260317065947.306954-1-ravising@redhat.com>
References: <20260317065947.306954-1-ravising@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an ID has no dquot on disk, Q_XGETQUOTA returns -ENOENT even
though default quota limits are configured and enforced against that
ID.  This means unprivileged users who have never used any resources
cannot see the limits that apply to them.

When xfs_qm_dqget() returns -ENOENT for a non-zero ID, return a
zero-usage response with the default limits filled in from
m_quotainfo rather than propagating the error.  This is consistent
with the enforcement behavior in xfs_qm_adjust_dqlimits(), which
pushes the same default limits into a dquot when it is first
allocated.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ravi Singh <ravising@redhat.com>
---
 v3:
  - Return -ENOENT when no default limits are configured
    instead of returning a zero-filled response (Darrick)

 v2:
  - Moved fix from VFS (fs/quota/quota.c) to XFS
    (fs/xfs/xfs_qm_syscalls.c) per review feedback
  - Return default limits on ENOENT instead of granting
    unprivileged access to ID 0's dquot

 fs/xfs/xfs_qm_syscalls.c | 43 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_qm_syscalls.c b/fs/xfs/xfs_qm_syscalls.c
index d50b7318c..21a784986 100644
--- a/fs/xfs/xfs_qm_syscalls.c
+++ b/fs/xfs/xfs_qm_syscalls.c
@@ -391,6 +391,38 @@ xfs_qm_scall_setqlim(
 	return error;
 }
 
+/*
+ * Fill out the default quota limits for an ID that has no dquot on disk.
+ * Returns 0 if default limits are configured
+ * and were filled in, -ENOENT otherwise.
+ */
+static int
+xfs_qm_scall_getquota_fill_defaults(
+	struct xfs_mount	*mp,
+	xfs_dqtype_t		type,
+	struct qc_dqblk		*dst)
+{
+	struct xfs_def_quota	*defq;
+
+	defq = xfs_get_defquota(mp->m_quotainfo, type);
+
+	if (!defq->blk.soft && !defq->blk.hard &&
+	    !defq->ino.soft && !defq->ino.hard &&
+	    !defq->rtb.soft && !defq->rtb.hard) {
+		return -ENOENT;
+	}
+
+	memset(dst, 0, sizeof(*dst));
+	dst->d_spc_softlimit = XFS_FSB_TO_B(mp, defq->blk.soft);
+	dst->d_spc_hardlimit = XFS_FSB_TO_B(mp, defq->blk.hard);
+	dst->d_ino_softlimit = defq->ino.soft;
+	dst->d_ino_hardlimit = defq->ino.hard;
+	dst->d_rt_spc_softlimit = XFS_FSB_TO_B(mp, defq->rtb.soft);
+	dst->d_rt_spc_hardlimit = XFS_FSB_TO_B(mp, defq->rtb.hard);
+
+	return 0;
+}
+
 /* Fill out the quota context. */
 static void
 xfs_qm_scall_getquota_fill_qc(
@@ -451,8 +483,17 @@ xfs_qm_scall_getquota(
 	 * set doalloc. If it doesn't exist, we'll get ENOENT back.
 	 */
 	error = xfs_qm_dqget(mp, id, type, false, &dqp);
-	if (error)
+	if (error) {
+		/*
+		 * If there is no dquot on disk and default limits are
+		 * configured, return them with zero usage so that
+		 * unprivileged users can see what limits apply to them.
+		 */
+		if (error == -ENOENT && id != 0 &&
+		    !xfs_qm_scall_getquota_fill_defaults(mp, type, dst))
+			return 0;
 		return error;
+	}
 
 	/*
 	 * If everything's NULL, this dquot doesn't quite exist as far as
-- 
2.49.0

