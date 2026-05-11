Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C200425CD9
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515599; cv=none; b=EJnyr0DaF/+SqWn7aAvXwzaoud2eAZZ4anL37Hl9LKENTRIwCbodYKbafjE5Bx01WLFAaFF98Ev75qI41UScevAJsPHAbe40i5+NRURtgWAonKct0pLW2DeVBM+nsAcLrglHNGAQxZ1HaF7Q0BEkpGZMcLftvtlbsxtxC8HBooU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515599; c=relaxed/simple;
	bh=ecIkuWz1WdckEtCiOyNKqYp5k/6uevV7IZoOGIaC+Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rE83ReOvbEeoNeVF3Gc4AvJWJKaCTF4EKdBwM3mjCttQW+x8EAj5uaZ0FYvpPb454mSJcSFXVm7YnikBr/l7rFu8kHd6l3m61b72aFMTeVTasiyyjaf99UUpcWEhcdyns3WiyLdvQWbzGD6UjutjhZ7bF9nPCyPnSmA+0ZQ+EL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sj27m9xk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sj27m9xk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ba21e7fb97so2343965ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778515596; x=1779120396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKIEyVTOjNsitHjzdLNLGjGFwGiysddgidr+ueXhPgU=;
        b=Sj27m9xkDD25Dv1XtVL8m9g6flNyqETkzq03YFtAVWo3CyR8Xuju1owxjvrIlZo5au
         Xg2Sm5UlqWMRYOirY+ZDJiLkvF1FFYkCaRt9sEn9ajAlYt2oPAbQ/kJYnyY5IieZHo1H
         pF3HAnQMekwY1PUo2N2pkiRhhQlb+8IzmEbWuvwh0d6vjyJjGjm7c8kHEAbXSpPQUELP
         hsNPFbAnUARG9hvgDJiy3XYSsETCWr2jo+CGng4X6fyEsu4ZAvMRjYDkSsPs/Zy/sYtI
         cwKJirF1oW9OSvMlYEjZ1QY+zohvsurTRd74HAHBgp0S8Ot551kiUUCGdQzWX/G1avab
         xXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515596; x=1779120396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fKIEyVTOjNsitHjzdLNLGjGFwGiysddgidr+ueXhPgU=;
        b=I3PXuJLVxcgpuhCLfoMTk9H3fhdO5rgwZZepTlDXwl7wVHP4Gxqf5BRIHHFZs7UG9q
         um1opLTdB6nZpIEbuYeEwIdlYdsgPcowY+0rbx6cfYqdMo9cT+fzgekF8VpDlqOMQZNm
         cklNVmmAt5OxrQvLFQBCjv8AX3M+Icd4FarA18PSPJN9JM+ubauPBwaduRBMEiGvkVjL
         QkW9tVGqxGxPYUU5dgcTEu2xvr/9KPx81Z5nTwGrgnDafu7+el59Mfh3XidP2LX32WLF
         l8fhAiH4tvn5QnOHLDVv0QFBTMSPisSsGZYjn6lL/hEMCumwZeaIcFHtexzOCILa7Gxl
         PuOw==
X-Gm-Message-State: AOJu0YzrxJ3x5TdwvLPXI5mQc0TC6+pTxSSbmEosW3+shNCzKjCRACoZ
	adMr9kKph5HIWNtctkOek+jHxIMMOZepW0H4dajcT/L7zU5mUBIh7k3H
X-Gm-Gg: Acq92OEiSVOslH7n5Rj5uU2xs0aa7mf37Ds4Z3EsSb5wi72ijZpbOkie4ptKgKvddoR
	JHHFyxH0trKgr3fnxxjz2EzJwOFYaznZLXUX1tHE+bfS4Ae472Mwuh3D8QbNsT8VovOooz5bBlr
	LKA1qqflM0URMC331KYvLG/7hRaTRtppweh9+OjaUAhkXS6zVb6tboFzOUosU0y3hEC4XNw5hY7
	yJyPXw0M42n3gUYpckCG7nt7q79OWnJK0vJIkw95uxLxA7JvsU2CN2TotGc5ZiYwh0iCkCL8Uxw
	c1Szb4s1eZIVcWhudUWBPnEP2Sp4VbS2LbOYxTwO8wbdsfCj0WYSf/hqkJubYZn03o3nob+5pxO
	zpb9CdXK3fy3B8Ycq5Til36JE65BBOGV4F2eOBKF+NmfnFPmSZfay7V5wbtS3RKb6WQ/2eNzAEZ
	NCodbuNi6DpGXPdgOP
X-Received: by 2002:a17:903:40d2:b0:2ba:7662:805d with SMTP id d9443c01a7336-2ba7b21d4f4mr130591975ad.2.1778515596306;
        Mon, 11 May 2026 09:06:36 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35ebesm112447045ad.43.2026.05.11.09.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:06:36 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 2/3] ntfs: use $Q when marking quotas out of date
Date: Tue, 12 May 2026 01:06:24 +0900
Message-ID: <20260511160626.1268612-3-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511160626.1268612-1-charsyam@gmail.com>
References: <20260511160626.1268612-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_mark_quotas_out_of_date() operates on vol->quota_q_ino, which is the
$Quota/$Q index inode opened by load_and_init_quota().  However, it creates
the index context with the $I30 name.

That asks the $Quota file for an $INDEX_ROOT named $I30 and fails before
the quota defaults entry can be looked up.  Use the $Q index name when
marking quotas out of date.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/quota.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/quota.c b/fs/ntfs/quota.c
index b443243..7086951 100644
--- a/fs/ntfs/quota.c
+++ b/fs/ntfs/quota.c
@@ -21,6 +21,7 @@ bool ntfs_mark_quotas_out_of_date(struct ntfs_volume *vol)
 {
 	struct ntfs_index_context *ictx;
 	struct quota_control_entry *qce;
+	static __le16 Q[3] = { cpu_to_le16('$'), cpu_to_le16('Q'), 0 };
 	const __le32 qid = QUOTA_DEFAULTS_ID;
 	int err;
 
@@ -32,7 +33,7 @@ bool ntfs_mark_quotas_out_of_date(struct ntfs_volume *vol)
 		return false;
 	}
 	inode_lock(vol->quota_q_ino);
-	ictx = ntfs_index_ctx_get(NTFS_I(vol->quota_q_ino), I30, 4);
+	ictx = ntfs_index_ctx_get(NTFS_I(vol->quota_q_ino), Q, 2);
 	if (!ictx) {
 		ntfs_error(vol->sb, "Failed to get index context.");
 		goto err_out;
-- 
2.43.0

