Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBBD427F85
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708031; cv=none; b=sK1+H3pO4Wt1L+9Nu8AsNBIXzw7AgpIc4HKa+vjzf3jC1XMftBfYQ2+JplE8MhYlfMIs1SkkJEp9jpqdQAoxz4Kqe8HZAVnMrJZYHmXu36fVPaSJZikB8osRnm/5XJK8eaVeZlUe+R9+S/6DMKWi5CiayVeEuIlyJncs5buTPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708031; c=relaxed/simple;
	bh=VO2yLfzSLmMaYW9bXlGe7RAs1ThpIK7rKaLFhEEFtwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auwiTkyIHbOpE9F2fN2ByhUcpNTTPNXnUuBlCyl722ZiFK9W1XsB5+aqHRQtzfVH+/QkCEMbGdwcl20jq1/Hw+zy9LL0yrsJZe5tQd3E9wcvlkqf9qAmfU+SoFC/w26HEUSANf18a0UQzqMIJo0stuqygwFF0L3OSKEcZglLOBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOjzj2YY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOjzj2YY"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso541417a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 04:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786708029; x=1787312829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3LwVqpB2dcFP1kfnn5N55VXaVAN5Cf9mnID9lWYeK8=;
        b=fOjzj2YY8vnXxh88edeGMt/B2kHcmQ97etJcojbxmDXEgg3Z0lhfgkbI7DBjKQoU1o
         TiTdtKlL3OhR7WITUF+szdY2KC//Lya2wlHhvKhIEfitRhNSh+BHfFcQg4SQj6lIF7af
         1R1vCgiFZaAtZ+IYC3dKR/nJi7KmA7PRIibXX6Ws4en56TWNtlpPpEC9CYx+usk794SS
         /LviqCeIgtVwYbAFMlW/haOSRhcEZ08U9NI8iY146twGZgHAG3iWKNBcT2UiA4u+GVyo
         kVgre0Q20qwm1+cETDokd5LiF+LmLB+Gef33zPeCV5DtkHzwIpXdNzlnThe2g2F8hq18
         cHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786708029; x=1787312829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u3LwVqpB2dcFP1kfnn5N55VXaVAN5Cf9mnID9lWYeK8=;
        b=sqoscrpzjY0kq5BCgFThsgSM+ffR8537lB2aatb9I1+emSkXlGgS0pmgZ9L3EzCcSW
         sTrzu5OlEQRGGY2bSatcb6vuI32EjgdM3z/47QnSVC8kGyfwzyztT9OBYsLWNuF70h6U
         rri1oInPfzjS5Gv8WjEMxBDnL4DdooDsQcs4NetkuaN7mB/cEps7wMlseeTuC+FGc81w
         YJhVyrpkXqs4CiDfbZhmI4uSJlNLcSibMOjFGAkqyUd5gWFWF9U3kqQ9C6QBTbGfN3U9
         WlwO/2SciGN3btuZtda/Lto1/qXjo20pzKvyxezxBV/Rj66LTtcNblIKZjywDm7T82Qg
         X8ww==
X-Gm-Message-State: AOJu0YyaZroGK+kLEJCMOoURy5VIfnPE2kSJtPDyD3qbOSPT0WEucWi3
	JKXBifZCM0uBddMPEi0AAZ93YjNnMZnH7OqA+axtJ8hE2LFheq+NW9+Y
X-Gm-Gg: AR+sD11yWmTcBAGqJFKreb6YbB3eVYjowJ/vMBi8ku/peBqBnLfETzBeS+7o8SlXQJn
	0pbUDYhtrD3Kg6cYp23xBebrPW6Z/Fhy8K9Fr4g/t5OKAfapo1EnrOc4rHVuSQchEdHxIN/FCGk
	g7OZOwImfa+NltVjXlWWucXbzUJT2xgXjn1HbAobEhz+aFQs0qrkBcbI2IbbBfqX+bJHh/xfGxd
	8adrZ+q4xLfbsLG/iwiHvXUItt79lqw8HfC85N1qgJhgUw5KpSfzHoHbMDM/KJdwDI7xu5+zwIc
	klRhdHGs2TXZ5r8VH7ZnLY+w2FfOpvRtp5Q2whX4eqhF1gUah2m4OFKdAKHSOb3Pd/ExdgNctAH
	GMfgHm7ivIJTQpsDusHPyqciwhHGTEdyr8loJD5yG5bNiOm5M4OolR0QSl3C3Ezx8qXK7mEKaEz
	pYMF0kKJ0ITIaVVJf950ctSFVsYclqhNAjejw7m/wyKJm1ksxKETVY9sIRGc7bRyHT+ZGaCu3EH
	oUN6PjYbM4fkLg=
X-Received: by 2002:a05:6a00:4f88:b0:848:700d:c950 with SMTP id d2e1a72fcca58-84fde7d054cmr5303714b3a.37.1786708028898;
        Fri, 14 Aug 2026 04:47:08 -0700 (PDT)
Received: from localhost.localdomain ([219.251.253.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d223e4bsm339450b3a.30.2026.08.14.04.47.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 04:47:08 -0700 (PDT)
From: Kitae Yoo <kitaeyoo777@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kitae Yoo <kitaeyoo777@gmail.com>
Subject: [RFC PATCH 2/2] quota_v2: persist DQF_ROOT_SQUASH
Date: Fri, 14 Aug 2026 20:46:49 +0900
Message-ID: <20260814114649.51253-3-kitaeyoo777@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260814114649.51253-1-kitaeyoo777@gmail.com>
References: <20260814114649.51253-1-kitaeyoo777@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c119c5b9749e ("quota: Don't store flags for v2 quota format")
stopped persisting dqi_flags because no v2 flag was supported and
on-disk flags could contain unvalidated garbage. Now that
DQF_ROOT_SQUASH is settable on v2, losing it across quotaoff/quotaon or
remount would silently re-enable the CAP_SYS_RESOURCE exemption - a poor
property for an enforcement policy.

Store the flag in the existing on-disk dqi_flags field and mask on read
so only the supported flag is ever accepted from disk, which also keeps
pre-existing garbage bits out of the in-memory flags.

An older kernel rewriting quota info still clears the stored flag;
strict enforcement then needs to be set up again after booting back.

Signed-off-by: Kitae Yoo <kitaeyoo777@gmail.com>
---
 fs/quota/quota_v2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index a24fab5f9f..814db61681 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -142,8 +142,7 @@ static int v2_read_file_info(struct super_block *sb, int type)
 	}
 	info->dqi_bgrace = le32_to_cpu(dinfo.dqi_bgrace);
 	info->dqi_igrace = le32_to_cpu(dinfo.dqi_igrace);
-	/* No flags currently supported */
-	info->dqi_flags = 0;
+	info->dqi_flags = le32_to_cpu(dinfo.dqi_flags) & DQF_ROOT_SQUASH;
 	qinfo->dqi_sb = sb;
 	qinfo->dqi_type = type;
 	qinfo->dqi_blocks = le32_to_cpu(dinfo.dqi_blocks);
@@ -209,8 +208,7 @@ static int v2_write_file_info(struct super_block *sb, int type)
 	info->dqi_flags &= ~DQF_INFO_DIRTY;
 	dinfo.dqi_bgrace = cpu_to_le32(info->dqi_bgrace);
 	dinfo.dqi_igrace = cpu_to_le32(info->dqi_igrace);
-	/* No flags currently supported */
-	dinfo.dqi_flags = cpu_to_le32(0);
+	dinfo.dqi_flags = cpu_to_le32(info->dqi_flags & DQF_ROOT_SQUASH);
 	spin_unlock(&dq_data_lock);
 	dinfo.dqi_blocks = cpu_to_le32(qinfo->dqi_blocks);
 	dinfo.dqi_free_blk = cpu_to_le32(qinfo->dqi_free_blk);
-- 
2.50.1 (Apple Git-155)

