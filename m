Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4437267E
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284837; cv=none; b=VCpLCC1paeiIFaB51izGZcIUBelr8Ix2jbQS5fw43/mEE/HldlE49bnkM2NJ0xOOdX5wXg7foNL1xhIPXQLUBg3xfRRkeEqDsysDfavKUyrGjS6g/aEN83AybPe3s6jjkENb96dIqE2S/9bPMRWUubjNuPzGuxbJSUUNzCR9FqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284837; c=relaxed/simple;
	bh=EVMh4EJnBmbgwEy5VQ90Q076Mfc9GXnTaanW3sM92JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j6wP24t3vq6McVNfRyvi3VLk68LAsKPK2ethDu2FJt5LENCRdcgQhkEtBcbigh4VAsJOrE5Y8GB13BPWegdDmfkRXKzgMmpYogi2jaBgPcvuR0ik548CHhQZ0b0WJTtHHpifd73qgOcYe/d+u9kBVwforjjgKnA9T+AdP86nPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Qfxa00C8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Qfxa00C8"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92c7a0a701aso584301485a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1784284835; x=1784889635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=henLu2wLIlaVqokG1wD2FoMayR14wq1gWRo/m1wfX/M=;
        b=Qfxa00C88YvKhdO+kX07CrmZWwOYJGZW2fjBOcJcWB8FCd5aDOGFhEx6vt9rYF4PRN
         zUjxW25xJvCWMWVnmd+XqJKeqcBP64aGxFW6VwnltXQDdtsNd+7AHoJeFuAuaPqlQF+B
         /b2sEA5hImp6T0s/DVqBkRzZ7pQZ3E0OWocf06tuJ6Kfk1YYb+MlkRrNNDrGI5JNyKmP
         EjXsDgOn0n5eq0/AE1PJHpuDf1BGoGDohWseMPMTroxj8y8NBZc+Cir7hJLqA3RwhTr6
         WDzo7yJ/t1BgX6rz5MPZj660byZjX8gbCEjvxfuJX5zXyPm5mvlsvge17fZstzVnofeU
         QuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784284835; x=1784889635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=henLu2wLIlaVqokG1wD2FoMayR14wq1gWRo/m1wfX/M=;
        b=Zr827zg+XYpSlPJN0bW9Ac9Jtk5USfQnT65JlRAq/rQs5wDoTR+Xr4CmcLJ5fIjncB
         KAMV44j67ANz80gKEejLevJHTAGVs+ztnBv0U83oBYvWSVocDUfgJzbnmW1ZOvI/a7Vu
         46NHVVGSGqqkLA/SAL8SjjlL/sk7tr88C815KrCKZ4FbcO6V4CtBvKPrHuCRynl8f0OI
         XHc9ENs0aKXJabChKkhwFztonn2LMywuXuA3fSGuwFABucFsOsOTOoeHivZ5VhYGLKZt
         0Py4lTKiWlhg1UU5BCsHAG6yRiX73m2b3SliqR+rS+ltMM0EDw8YABKRUg+6Sm8ACMMe
         PdFw==
X-Forwarded-Encrypted: i=1; AHgh+RoC2X3X4xvnM+7S0D0iJbm0pz6p6E1jWLafPIKhwuVb/kOsXXi019qmxXpufjLUgE3d5yKOqOpFsORd7kWj@vger.kernel.org
X-Gm-Message-State: AOJu0YyyEP0v13ykAZi8D6v4LhSNlouQUHoBO15ySYMkDFAgaYwPj++5
	KxB+5H+yJ4DEkEYeqs4Iee7jFBPTqU9xRMhFJDvGngHdL5DQ3RFbNVvCYBOqbXXBAEg=
X-Gm-Gg: AfdE7clxAkMxrYlTpn0ahSVLT+ix2wsAwxPXNMdccFIUGS65VdEONfwHNhMAMa1R9TG
	efr/Kpj0CSiJx/DmaZE4an2e/WbNQgdHgHMpd8I9m5rJX19nk6+YqoH187WaGswAWPbOycWYH/z
	+5jpdnxf5BAFytA1f8OyLT0IN+6SetWLgC3aZWqwlQYurOIQCtZaAnRvXKOpTtJXmgx440QaHj/
	UbMzI2c+xl+mUUT7oqq7Jva0ibXVIL3BE0RQkJkkosp2sjourMUYs1YRsZKWlZBrluf/+Cu8s3A
	AY/EAD3F83kJl4xTnyZR+8LXyZv4oIIa5ulSHwh/Z6wJwwOHolA3cYv/EIDwvm4P8PVfiXOaiOk
	z41BnOTzqZVbOSTIODnVcA4GaPNXfd20Yvitl7fBWHnTOAuM7Y6yqRjrUb2PdZu84//+sJUX2d3
	yKnhOeTQg=
X-Received: by 2002:a05:620a:7014:b0:92e:4867:95af with SMTP id af79cd13be357-930b4323a4dmr197784685a.73.1784284835379;
        Fri, 17 Jul 2026 03:40:35 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-930b52dd4fasm121848085a.4.2026.07.17.03.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 03:40:34 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: David Lee <david.lee@trailofbits.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: reject oversized cylinder group metadata
Date: Fri, 17 Jul 2026 10:40:32 +0000
Message-ID: <20260717104033.38574-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The on-disk cylinder group size becomes the fragment count used by
ufs_read_cylinder(). A size larger than one filesystem block makes that
count exceed UFS_MAXFRAG and drives buffer-head stores beyond the fixed
eight-entry array in struct ufs_cg_private_info.

Reject zero-sized cylinder groups and sizes larger than the validated
filesystem block size while reading the superblock. Since a filesystem
block contains at most UFS_MAXFRAG fragments, every later cylinder cache
count is then bounded by its buffer-head array.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Codex:gpt-5.5
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
 fs/ufs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index c4831a8b9b3f..fa2effdec7b0 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1140,6 +1140,11 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	uspi->s_cssize = fs32_to_cpu(sb, usb1->fs_cssize);
 	uspi->s_cgsize = fs32_to_cpu(sb, usb1->fs_cgsize);
+	if (uspi->s_cgsize == 0 || uspi->s_cgsize > uspi->s_bsize) {
+		pr_err("%s(): invalid cylinder group size %u\n",
+		       __func__, uspi->s_cgsize);
+		goto failed;
+	}
 	uspi->s_ntrak = fs32_to_cpu(sb, usb1->fs_ntrak);
 	uspi->s_nsect = fs32_to_cpu(sb, usb1->fs_nsect);
 	uspi->s_spc = fs32_to_cpu(sb, usb1->fs_spc);
-- 
2.43.0
