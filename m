Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C853D6CA5
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368428; cv=none; b=hUze7FAeb0SfI1f/eaPMt30PkoccFv5XdRXRGc1mZ5J4JEAlYNxT9DR3MeWK0pIxan1p/qBcbABr9vDKLqtY12NgHt2LW0IcWqFL17+FsWyvCj42VkrDryAvBkS2Xj4o6nOpFAWGnrKbb/BLjZaJQLcKRARvDnhGFghHd8QTj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368428; c=relaxed/simple;
	bh=akiy8XbXXAmzoEjb5CTW4EvpRBclQq/yv9STTM4bqds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSHotb1fV7bcS51a73iS2WGytZy7ZjWpUmw/24sQEkrsmkqTLm0R3A/TfGmyjZHLMzBfK10zEibYFph1l18Kj6EBIDDTQc3KAQc7JJmw0oiysTCnJP5lTFUHoOvS8p/eRwTMaAJ9xOREVkyh1ttIqyPKYcNriznaOGtAeL/dF8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUWcenCm; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUWcenCm"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c826abde7d6so464467a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779368426; x=1779973226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZYoe5azvMeyE1oweizu90sYcZTKsPgj4BdyeNWmQpc=;
        b=YUWcenCm7I1RyO25qeVbe/xBMFq212XlxCxdtws6MInIi+GDiMznJcqVf9C/AjpWfa
         iTi/h0YOUv/h04hSYVbeeQFVWahpOzcSluzmr0QQn2Mi7oUvPO1DygaqH+Fs/QWKHz9u
         I4aBoXjTOc9U+n95NfOXYylMcgKo3meO1iBCTQLhNNQd3Gjtkdgjohuz4HwXDCAs4Miu
         aX7y1a1q3M7cMEh0crr2zbMezS+9Yb8JCRTwx6ztBXLIquTpf2fH15I+KChUT4wylnb4
         thGyh62PYZ3GcLrtsQ9zE9AtRiUNc/FAauMYwVhO/e9CZXgqj2Ons0qJojj8LfU9ls6Y
         /ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368426; x=1779973226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZYoe5azvMeyE1oweizu90sYcZTKsPgj4BdyeNWmQpc=;
        b=aWorAzNHnyn0bKkQSsOXVXZFEr7jn6wOZPn2AhwljQQB8TjzkAtyQ8Fuhjb8U95M+G
         ZM4uCkPOo7JS2XSujJ/bbekFs8ooL3Ly+CeV/kIVrH9DnQFRlvvcb4zMp9AtLCwQkQ+t
         /1FiofFqC3m6AlCgFF1+LjdihgzMRXYbUxekoiIHsykQaVcDY+mdA60GLvAtjpzgZkl3
         Q79pXkUT84Rw2E20zS8K1JsHGmTDbQf2N1lC2h/jtAYPGd1pvSEMEBuVCjY4uNSEPw3c
         PYfkS09hOHrs4GOLBgFuTB6m9oDaI7q37cv3qbj6FbkAHdtU1zkxowlwgYmxrFPS2/Di
         kjag==
X-Gm-Message-State: AOJu0YxTxt5bqwrWSW/nBjKuD+OFgmhPzblOof/YzR1Jm0YhC9f0wnO2
	4d3aKnAWIJuAuUDh3r/7DUWc8dSZqRW8tYHcoHbMpmuwk1SWKKIM92ug
X-Gm-Gg: Acq92OFXlwIiKWqBYLRknKy5pB89TYTiUlbgGYHU+KoKN5QQc97IgWlXLIncQadiPTS
	sR6gk5TBxoPbnSmn95bHQvXrsBIhJPjszhHPr0T4UoWYBGMMGHI6SxvOEDKMv4EB/VOr6x5nCmu
	M4N06S3skrb81E1QH3+rQ128JiOioOxifJL4ujpaPBU3LrF/r1Sa7NgweefORMCS4Lm2W6zkBiV
	u26vC8T149p1b5OTpCR2YvWSNDw6Vf+yFw02uDghjnQ77Q5TBBKcfaSK+utIxn72ZEX9CuEYrrd
	Oi4dbmc4wQp697rXZtml70OQy08kr7yznKs4YU+LymAcVMEN8qEN2lZdKJYWgrsNx+VVXHKDhr6
	P4ULEAvA3kyLSebuG+JMZJK0XepvdEZ2UA1iflDOC58yIvEagQrt5KXN7pim3+W6eKpWOUsMyzP
	A2oES07ROm4fHARtE1
X-Received: by 2002:a05:6a21:4c03:b0:3a1:6a7c:dba5 with SMTP id adf61e73a8af0-3b308789ba5mr1883422637.6.1779368426032;
        Thu, 21 May 2026 06:00:26 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c851993d8a7sm284340a12.27.2026.05.21.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:00:25 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v3 1/3] ntfs: free volume-wide resources on fill_super failure
Date: Thu, 21 May 2026 22:00:15 +0900
Message-ID: <20260521130017.713848-2-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521130017.713848-1-charsyam@gmail.com>
References: <20260520170151.4115308-1-charsyam@gmail.com>
 <20260521130017.713848-1-charsyam@gmail.com>
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

