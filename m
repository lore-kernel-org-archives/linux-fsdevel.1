Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3142D3806A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358685; cv=none; b=o9ZSNgFhFt/1zaM9FQtj2pasyH09BDXUruc4LdDxp09f2u0PXl5mRF+2qJI9K0zHZJhO+OTXVOZ28F38C3UQ/SmBfVxq/fFJRopjBSorvPTwyF2cB2YJ6jWBx3hPu8/AFel088H7fmN0elYChx8wAd9s4UIpUb5UIjio0hcFVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358685; c=relaxed/simple;
	bh=akiy8XbXXAmzoEjb5CTW4EvpRBclQq/yv9STTM4bqds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RbsiqOw1oCN7P+GiLc/CJAqcPEYLEKOVIVRFaGWIVylYXyHnV2pJJl5Jk6BA5m9m6KbjYRG/mxCnmmuJcFT05q+JHv+fOoCLwsN90VDsD+dZVDzQLUA55ZJmgEYzzxrGDekcEFkwHU2xGfUrFyl5kaQIhRlh920lMZ5ZwUsdv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzCu3+JE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzCu3+JE"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c822d72b20cso471849a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779358682; x=1779963482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZYoe5azvMeyE1oweizu90sYcZTKsPgj4BdyeNWmQpc=;
        b=lzCu3+JEmYIJuXmYNrlgWNXDnyWv7mYFeSpjEAEaVIUajPG/Xvenn3MfIvHlFu1i5y
         zgJWOrG0Ax6RxGrIPg2/5bhu4+POJSKgxH2/Ixhg+8l5A3GQ1fsgCw/rP60Tr74YYkm2
         feL+Gl1M8EOPTSmpzLEYlTr+piPNIjSx85UdabxCIo9yAehgrthyj3dUW6V2i3HTdHtv
         EuxyPTVhL4g2zn+8wVpevk3Sv0VjZVpb5V8sM9T7E9A8oUYkTPqbBIwuA8rhnuZwJid2
         +prhOZJ4ip9So3IXktzo5yGjuvxqc5uGqUMFlYO9piF+JAVJFE/EwNBUUx7V11QzJFaA
         2+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358682; x=1779963482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZYoe5azvMeyE1oweizu90sYcZTKsPgj4BdyeNWmQpc=;
        b=hDYODpla68nB0U0kvLgOkdzBERc8w7uo+mXf0h+ie4TMOEreHFkf3+Zj9BWMgUwb15
         dJsAxXImeeRdLQqcRNo1IgvjJrzKR3pB+O0QZrM/WklL+p63K4UtCq1C5ofAxvXsnYPy
         OEXEi1JiPl0NX0ijYJ5Ft1iG09PXmdJEQluePN2YvKGOBv3fL1aG3dqLTh+BH34ZkJcc
         rxpWD9yNMbbCAtfELfcKM+5Zojj3Y14fOa9dKU6IBFp0hKpuly31QoOXXvQOftAawFPR
         IKcyZt/bzQMwWwJtdIVK3VMl8rzBlkewC08DuC4ZFjzhiHkmJAf7JGrf0l1x6AtBqQqx
         ayJg==
X-Gm-Message-State: AOJu0YwNQnbtIEuHiqd3ursDMXDS5r/O9lcMgA9SZPKW+Mac25ibS43v
	LgzR9wtr8x8IKhQKvPbcK1YhpMoCH6PZoXqBagR16YHn/Kmljr7QWC19
X-Gm-Gg: Acq92OFiEaRZEkq1dnUPr/pQj2A23rRPsuqAoKladhIREXUXLDxVHb40A6C8JWnX3Wm
	/ffzwf6MnxuXBjqQDRy6P7Hutjqoi5T+t/zK5IX+6aHshuiYHGNzz1cekRf2CSVznGeoZxSbVqj
	oi3Jhxm2vWuvpCwzICdTOjPc+y6aAmSepQGwWBaTBJ/nyFbgcK9XRz04lymV8lciVhr2xDuvccZ
	fG95k5fRdZNzCjbtxV0F0U4vd/NubfaOAotB5rtLaeYCXHwwI1Y6f4F/0NK5R4OJdROWpvTM6eJ
	LqyKq5wWjOi5hY/qdpU3MG0eiraArcEniOqlswx2DTzWUlzGIIksHGn9il/qe9fiCWVdD/qR2Fe
	HhLUx41cLDtoahVGx2i69qsrHEk23LcnC4uFLD1LkomauuTLEr96Wi+G2CUuvKrdGlDQX90pFGB
	iH6jk5hlhRCDwbucNrjCPjoaJui3c=
X-Received: by 2002:a05:6a00:114a:b0:82f:6cd5:f6ff with SMTP id d2e1a72fcca58-8414ae99c52mr1240092b3a.7.1779358681555;
        Thu, 21 May 2026 03:18:01 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84154e1fc86sm1197799b3a.44.2026.05.21.03.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 03:18:01 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2 1/3] ntfs: free volume-wide resources on fill_super failure
Date: Thu, 21 May 2026 19:17:49 +0900
Message-ID: <20260521101751.591345-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521101751.591345-1-charsyam@gmail.com>
References: <20260520170151.4115308-1-charsyam@gmail.com>
 <20260521101751.591345-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_fill_super()'s err_out_now path frees only the volume struct via
kfree(vol), leaving several vol-owned allocations behind on every mount
failure:

  - vol->nls_map, loaded by ntfs_init_fs_context() via
    load_nls_default() (or replaced by an explicit nls= option in
    ntfs_parse_param()), is never unload_nls()'d.

  - vol->volume_label, allocated by load_system_files() through
    ntfs_ucstonls() once the $Volume name attribute has been parsed, is
    not released by load_system_files()'s own error labels nor by the
    fill_super() inline cleanup that only runs on d_make_root()
    failure.  Any later failure inside load_system_files() leaks it.

  - vol->lcn_empty_bits_per_page was kvfree()'d in
    unl_upcase_iput_tmp_ino_err_out_now without clearing the pointer,
    so it could not be folded into a single common cleanup.

Because the failure paths never call ntfs_volume_free() and never reach
the d_make_root() inline cleanup block (it sits above the label and is
jumped over by the load_system_files() / kvmalloc failure gotos), these
resources accumulate per failed mount attempt with no chance of
recovery short of unloading the module.  This is a silent leak: the
inodes loaded prior to failure remain hashed but generic_shutdown_super()
skips evict_inodes() when sb->s_root is unset, so no CHECK_DATA_CORRUPTION
warning is emitted either.

Move the per-volume frees down to err_out_now and drop the
lcn_empty_bits_per_page kvfree() from the upper label so the cleanup is
performed exactly once on every failure path.  Using unconditional
kvfree() / kfree() / unload_nls() is safe because they all accept NULL
and the upper labels that previously freed nls_map (the d_make_root()
inline cleanup) already clear the pointer.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 9e321cc2febe..7e3561265b47 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -2530,8 +2530,6 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	/* Error exit code path. */
 unl_upcase_iput_tmp_ino_err_out_now:
-	if (vol->lcn_empty_bits_per_page)
-		kvfree(vol->lcn_empty_bits_per_page);
 	/*
 	 * Decrease the number of upcase users and destroy the global default
 	 * upcase table if necessary.
@@ -2551,6 +2549,9 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* Errors at this stage are irrelevant. */
 err_out_now:
 	sb->s_fs_info = NULL;
+	kvfree(vol->lcn_empty_bits_per_page);
+	kfree(vol->volume_label);
+	unload_nls(vol->nls_map);
 	kfree(vol);
 	ntfs_debug("Failed, returning -EINVAL.");
 	lockdep_on();
-- 
2.43.0

