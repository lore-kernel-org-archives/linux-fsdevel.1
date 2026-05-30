Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8202D9ECA
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151737; cv=none; b=F/GEsSv7RYexFuP/YMwmxB98YzJDUaK0X7Wr6vP3EF2pjO7AkRP6xJN2F8Fe58+e+H4A+aEoP+s2Ah+Zx2q9PpsgLf+acF3yNC0F1el3qTTCh+YnOOz51QMv1/pE8lE4PaAs2mAbEFfMhUBQPezref8yngLrXAIhzfDjstYrTrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151737; c=relaxed/simple;
	bh=sVgzmvJrwwfRTA5jIT18ZQAVVs4t/EJoipsudjW5zlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoFMRgGYz8O8LFy21jeXqb0aea12mfG35Fervlmyf3fYq86zFQqyHKCifyVimRXjTFQ56tLtGzCq6DIiw/IgA/efbEMpWZjEXjV5gDlk4AMC9me2Wc++qYIQzHqh/kYpFLrrsltfTGlhHK45NVmxm3mmJpWAuGGqBj1PW1yGnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPNePyYG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPNePyYG"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8576ae4702so73079a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780151735; x=1780756535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0z7rLBKen5DM92a4OaucYeckexSO2wBy9x5XZ4xp3g=;
        b=pPNePyYG6N/9VS/yimSWKEuw6neIwiXrtXdYdB8DOSQNWqbzl1ayH2qeBE/jVnlpot
         pH78ObKsTiT1SDZ1dM7yJrWz/nV+YLNXw1c2qYFnUecp3H+pgEEnOPMTI5AUyNtjsNyg
         9JTbBPrcBZIH0jTMSYN7Gmy+Y9DieB+lwpytQ1SKf/zXqWEk2r756bMArSxIgbsdpKos
         voQz03DSD8RQII33t+pOSdOKaR9Of1MLDwEqplFapccn0sisyjUyTqGrz3O2GDtSsEBQ
         YgKOpJ3DOF7+T6wi6dtpfjGVopriKncJcfOBaNOpCzEcQzvVpQtu5Rm/T9PnNWcOh8yx
         p1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780151735; x=1780756535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P0z7rLBKen5DM92a4OaucYeckexSO2wBy9x5XZ4xp3g=;
        b=XXvH5eQzHT4Pnmw6ah5DTYpjxTQfTzFVCTHFAuVjwP2Kf3py4olmkWeo8QnKGOTeXk
         lbTkYDsnPIUeHAHZB2uVuBVkqsMXyp+V+3RFF/sWOea+1zX/P/rtWhp6ejZCPuqJFdfa
         Un0HZ46PJ27eOtgqrmFCmdvyjovGLh0c6hFtumWJzXjVaPb2z0nnEGAOmdHpezz2VI5i
         GEZEEH7PIdLLJydTykZC8sHuZuoda+lWmEGbCtlel+21ysWmWh7HAe5ZQn5Wqs9s1bKR
         ujB0l1Xo3RJzs+Yc9WGHCoY4nRdxxEJ4cDMp9Qvf6Ghyu7lpd7hKyre2VmMAyua7Hr8R
         30Qw==
X-Gm-Message-State: AOJu0YwV00Rgnw5+rFVIhj7Klnzuts2DbLJOf/4nVodoP2Ql30vDIXqh
	ZJAhLk8K9DS7Oj9bMUmO43ihpjyNP8cihlf7UDl6g11aB7/z1REvCPC4
X-Gm-Gg: Acq92OHypBFsbuOn7MPkgbRH5uk07fjzFWUKaxw+lfHvoCkFqOxCIcDQExH7k0U69i6
	Xt3CVjF6bfSBMdp1hN166un2N/2Df9+qHofNu6k34Fnqg7Mg3+gJHJuLw0fsVJ/G1UcH6NpGDia
	XGPQLTL4lDkQhUX9SJsqsBxFpZ4jEvUCD0AfmT91q2eB+fw6DrLRrU/iTRvDtFUVET7AwMN4kab
	4F8DJLF/nVSBt8OrnUQobOJNhfc5O8gc5TK29xx6iS0THOOT25Te/gJvo9i5hm3YvI+xxUFeiyy
	rL1PsG9hBAL8HIptNl/y2rkdOBAI06JO34tCN/wBd7pomlgEbFm34M1fNar3QwgJEw2/6aWYtIC
	OQTDFN1F3O5t+A8HTn/4XetUPrLP68ZR+F9XOdAvGtXFZwEeVya8KX5xHKlWzJLAeqBqLU9DId0
	hc1EPqyDL8biUTWpx/umwNoEJtNXo=
X-Received: by 2002:a05:6a00:124b:b0:835:41f3:f434 with SMTP id d2e1a72fcca58-84225333915mr1897126b3a.1.1780151734907;
        Sat, 30 May 2026 07:35:34 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b2acb7sm5832280b3a.13.2026.05.30.07.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 07:35:34 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v4 5/6] ntfs: update index root allocated size before shrink
Date: Sat, 30 May 2026 23:35:13 +0900
Message-ID: <20260530143514.3083601-6-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530143514.3083601-1-charsyam@gmail.com>
References: <20260530143514.3083601-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_ir_truncate() currently shrinks the resident $INDEX_ROOT value first
and only updates index.allocated_size after re-looking up the attribute.
During that relookup, the resident value_length can already be smaller
while index.allocated_size still contains the old larger size.

That leaves a transiently inconsistent $INDEX_ROOT layout and prevents
lookup-time $INDEX_ROOT validation from being enabled: validation can
correctly reject allocated_size extending past the newly shrunk resident
value.

When shrinking, lower index.allocated_size before shrinking value_length.
If the truncate fails, restore the old allocated_size. Keep the existing
grow ordering because the old allocated_size remains within the enlarged
resident value until it is updated after the relookup. The shrink path is
safe because the new value_length still covers struct index_root, so the
index.allocated_size field remains present while it is updated first.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/index.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 146e011c1a41..068c68a0f9cf 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -1280,9 +1280,16 @@ static int ntfs_ir_reparent(struct ntfs_index_context *icx)
 static int ntfs_ir_truncate(struct ntfs_index_context *icx, int data_size)
 {
 	int ret;
+	u32 old_allocated_size;
+	bool shrink;
 
 	ntfs_debug("Entering\n");
 
+	old_allocated_size = le32_to_cpu(icx->ir->index.allocated_size);
+	shrink = data_size < old_allocated_size;
+	if (shrink)
+		icx->ir->index.allocated_size = cpu_to_le32(data_size);
+
 	/*
 	 *  INDEX_ROOT must be resident and its entries can be moved to
 	 *  struct index_block, so ENOSPC isn't a real error.
@@ -1294,9 +1301,14 @@ static int ntfs_ir_truncate(struct ntfs_index_context *icx, int data_size)
 		if (!icx->ir)
 			return -ENOENT;
 
-		icx->ir->index.allocated_size = cpu_to_le32(data_size);
-	} else if (ret != -ENOSPC)
-		ntfs_error(icx->idx_ni->vol->sb, "Failed to truncate INDEX_ROOT");
+		if (!shrink)
+			icx->ir->index.allocated_size = cpu_to_le32(data_size);
+	} else {
+		if (shrink)
+			icx->ir->index.allocated_size = cpu_to_le32(old_allocated_size);
+		if (ret != -ENOSPC)
+			ntfs_error(icx->idx_ni->vol->sb, "Failed to truncate INDEX_ROOT");
+	}
 
 	return ret;
 }
-- 
2.43.0

