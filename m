Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CCA2C21C4
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151728; cv=none; b=stA/snq1xEj2FuHKys2VCBd+Blt3EL3ys81Wd7k6fY7OBYWUnuqZ4r1suChX76DnLs+d9B4CJARRLIdpH+X1eC0+y+/mwFM+OWOb78tmAi/89sc8zc15eWFXRrk1SuW2YIQkLmehQLP5cPyUQ7TUCBOeHfx9vRTYZpOWpzoO2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151728; c=relaxed/simple;
	bh=MSDhO8kmXxGFOzcEOVnsceyiE3UMPChHvO3j6B5hL9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7dxkGzkzckBnL1QWWAS2BhIrFOlouSDaFXXQ0xiTSfLi/8aRniWiDOwyJG+GWOTQlOzfiqNxWoVLEN6+nQ1v38GH/ctTB6ovdfH/6cYIO6qF92EyxTas2y9yxmgm3Yz1westhrZdYUVdVMoTikIC/6Rm+53B3Upv360iksHmsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUEPKShl; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUEPKShl"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8576ae4702so73076a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780151727; x=1780756527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzViUSPWZPFCueI/zqrhP6OZ0oxKngJz6Ipnb5MmOes=;
        b=jUEPKShlVtxxIOX3XsyUcw9Zb50MqYe8ch5Y2kahN7S7TwSByWFm82NgN5D7c5vDth
         MeYSiguYyJwCZ3F06QYQZemdcQjx4OyXK6U7Od5p6G6EzJ6f3AForUXw/2bE0QVPfEfW
         bvqKpMauCThVJpWdPgtkF4NAG6tj8A1StqqRZRe9THauMhid45EYd9r24nhGImXhP4XW
         65920tWaO6NPxYXG31Ey4M03h9hu1BBYbrI7dMelsJmTEwL1/PtWwIp+tUdb7OJC6fey
         Ih9hFnnIWMUI9WvMhZ+YkCDtBH70KnpcwlnFvhSHPX+smkpLoniTnPCNyzMV/TLEN6qE
         Jy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780151727; x=1780756527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hzViUSPWZPFCueI/zqrhP6OZ0oxKngJz6Ipnb5MmOes=;
        b=S6n9L+d6F+YOI5uXn8aLnEdRNZ7HQhXA8boXyMvLb45XgaE0e4a2NqPsazZ8otapT3
         Jrx6OLGtkwFhwe1mVTptRC62+A5o6bI3D+MlrZW72OmDqU/AEOewNure/zjkEsHISN/2
         BpyNk+awxTzOv+IDM5auY2NV1qhLMqBfMaAO2v/i5aXe08S3mpQdGvipdceOOOPqTJlV
         GZZYVdiO/Rfc95OEr1SKFL5TcGr3roA+1nMm81rVNOhI/1JI6x2woLRMxP+iTEB1nkSd
         lbITlaxXrWElLUC6f6PrYIKEM1dLtnuE2xWA+WSVEbu6ywEo1KbSbIEtSKY0Q0KONJ0Y
         d+SA==
X-Gm-Message-State: AOJu0Yx9hbs1u0P5rBpHDl093DysjR+Rnza2OsmclXuQntCLNdajWEF4
	UQlp7ar1R2CuGTI3izdoBEZ5Xn7CeQi3Igk/o8iFr0AgjNCNyv6U0Ffe
X-Gm-Gg: Acq92OGfr2xp8Yrag71t6jqUGypzO8TJ5LCFfbPglq6oKzcpi+YD3BUQoNBedTTuIUe
	R2f12qPbvO6rCXVG+NJOoeirSa5cYBwvBK1rV2RBy+hpc6659+pmMAtgD8DGpSeuy1siHYpybXX
	mbtL+bLtlx19CDeVCU52zD/UuCbEiq86tyujzsQ+N5O195VmFx7sQh+MNvW5mjmS8ShGErzXAas
	6+isjOe94/IC0w8wJ8s/VxUxy6YQ74XB6hDkw0FI3BciPF2o6w7xY/Muyy5SJo7UALMrLxkzuXz
	j0HIkIMqhBlc8Fzv76RTwTUD4q7WpB2JsCNCVjiIvVT/StQN8wbpW+c0nDFvmrMsDh2TiOydDM8
	4AEuEvHJ03lXS6LnU0boTF5KemeDTuZvDV1SkKHWHPt5IqTL3guU3DXFcnmz1VvBPoVTLrBSfng
	1iZAFuAxlMLmL25OoOFTyCQK9fztA=
X-Received: by 2002:a05:6a00:3c89:b0:841:dc7e:b42e with SMTP id d2e1a72fcca58-842251b90d8mr2102711b3a.0.1780151726961;
        Sat, 30 May 2026 07:35:26 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b2acb7sm5832280b3a.13.2026.05.30.07.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 07:35:26 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v4 2/6] ntfs: do not replace volume name after lookup errors
Date: Sat, 30 May 2026 23:35:10 +0900
Message-ID: <20260530143514.3083601-3-charsyam@gmail.com>
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

ntfs_write_volume_label() removes an existing $VOLUME_NAME attribute and
then adds the replacement. The old code only distinguished lookup success
from all other results, so any lookup error was treated like an absent
label and the add path still ran.

That is unsafe once lookup-time validation rejects corrupt $VOLUME_NAME
records with -EIO: the corrupt record would remain in place and a second
$VOLUME_NAME record could be appended next to it.

Only add the replacement after the old label was removed successfully or
after lookup returned -ENOENT. Propagate all other lookup errors, and
also stop if removing the old attribute fails.

Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/super.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index a2648d1c8fd0..140b8c8a811e 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -452,10 +452,15 @@ int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
 		goto out;
 	}
 
-	if (!ntfs_attr_lookup(AT_VOLUME_NAME, NULL, 0, 0, 0, NULL, 0,
-			     ctx))
-		ntfs_attr_record_rm(ctx);
+	ret = ntfs_attr_lookup(AT_VOLUME_NAME, NULL, 0, 0, 0, NULL, 0,
+			       ctx);
+	if (!ret)
+		ret = ntfs_attr_record_rm(ctx);
+	else if (ret == -ENOENT)
+		ret = 0;
 	ntfs_attr_put_search_ctx(ctx);
+	if (ret)
+		goto out;
 
 	ret = ntfs_resident_attr_record_add(vol_ni, AT_VOLUME_NAME, AT_UNNAMED, 0,
 					    (u8 *)uname, uname_len * sizeof(__le16), 0);
-- 
2.43.0

