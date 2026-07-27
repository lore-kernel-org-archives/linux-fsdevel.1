Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D30142A783
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187482; cv=none; b=ZldlqXA0G0O0ByC8MTtpTL5pSF7fZuEofK58rriuDwI/ByYQY4GxnxxSQ792Ph/8DnJHqRWvCEedc/0azzlrvbXPThQ2qkB9WBEioDwbt8kJ2B/6sdWwpYIGblXE1Q/HYMqGPDounsplV96K1xa7kvpTibxQitidet5iPrIRzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187482; c=relaxed/simple;
	bh=BB0sPqRZ88+T3km26e+GeLS3s0vMjVM5Qt+LGf7fCk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JewCegiUwtROXU4Zt4bYha0C7QWVEnJ30osDxgVRYnJ9efhC9KS8JtkGuHm3GpzM6KsYevintOjS5+wFzucBxXDDdsI8Zzt7+iD3+zqbY4nLkxmHWI4mlyEBE6onLyRISL2WxtXDIYn/41LaJ9TUvKyU9K0wYnOExG0PJlg8z1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErjXzn2c; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErjXzn2c"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e584c7a5bso1534143b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187480; x=1785792280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q8M3ZYr7j0Vv2huOSINRreA5KjJf/RGJ9R7Nsb1zC5k=;
        b=ErjXzn2cimv0WR//cUytoT91+c77Jc1q9RLDu90FdL+LxX8/ofxi+CchI38NsFeqY/
         28kEqvBxfQCeRM3RiI4+sK/V42roZ7wqTeYEqDbwUv/JV5HqHTjZEJhVwmUd8x6ZVYLF
         dUtI0P4Vujz3CGd0Rh9WyaCdceyCR35ShJt3e5Rerkv2h4khXmE4bq/nMZ4tNs9SHKcY
         O0oS+Rj8nKJw+pHxAPspoW8hWsF/ikryWWRP99iVHsTmaFdrnPXuhqoaN1i+kQUhQ9uc
         ZtMApConb5Vci08QPAQ+DT1WaKdFmBhN9NZS3F3m1QaIc+aykSoicHx9NWOsMsLYD7oh
         ycaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187480; x=1785792280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q8M3ZYr7j0Vv2huOSINRreA5KjJf/RGJ9R7Nsb1zC5k=;
        b=Dtz6oLgl6z+OgT9XABue/kNihHhCnOUoEJMVG1LGo53nvbHEJRzjBWZNX/1kdcpBGI
         v1g8tXh+n2MCnhY+J8PxtYSmR3djkmcdzaY/w6VKM1BufNFnVnLCOl/oLmIHN/Obd7TY
         plRbmaREzDJpX+DYfkBwen4RFTe1gp8Sa94nX5uFCR97LuH49DxI1pzbUeLA4OeJtbRF
         DGvBNcSq7y723z+jtATqUfjI38FeZ3P9g19n6n0zKWY1dRA8gYhVHvcphftFbrLgzE70
         KebPAm/VPTdOcDv3SoQ+YP64+frI4R6QtgwYsLt1DTzNXfNIN27F1v5Y1vk27T1dki25
         rmKg==
X-Forwarded-Encrypted: i=1; AHgh+RrFaPcZn91JKHQBSVy67iUIoGiNbzNRaJzvn9+N3UVk4cqClYL1+SSDvVx8GIT3iyrt3rNR8zVgeTHsGJlt@vger.kernel.org
X-Gm-Message-State: AOJu0YxpXCWYFaONS5PyPMRimoILIZ6WSp5PzOTrvOg0hAcd7GHfa5Lz
	UEGQWjZwdC3ssXLMvR0minrh+TSprO8x0BWKkssWEju+R903TqWGMQh3
X-Gm-Gg: AR+sD113ZCjr9ZQWk2j77V1YVU5I0gFh58Ke+23Ii54lhKC/Keufbc2pb5bj1aEyyGw
	0i/ZZHR8F/PdyB/Y2jFMvEIDVNT29qf7fF9QZuWUo1PWAtMpw0NWMG6mDTCenwjpno8Kzv4KueT
	mqAkGEPugjvW+TDPMJVkEhn336A0OIP01Xsk6tMZRkRYV2J8CGdcYdB5UDstlvul3LY8UKcRiEI
	i0Fk/Dn5raE4lfKzOlIZ5h62dnuX4sqy8CGXaEOOd8uIndVr7qA6YDw+EaC4sx5Iwlr1UdYGyBT
	Cs5U17MnO0vdrSmCv3olNScQrwcnvoeQlRUtPvD1SDdJsLLE5DRz8pZqRAXzsg3Mf5AIJylj+iW
	+uac/mrJLhjQfuo84W2H7HRuQ3LgaoHM1tP9jyqemmlaeEoxRHcOz6We7a2JnaLaqvQ7wO/dRS/
	80EAhvcu0ncd8iMj+mTlDdUe2ZlOrb1pD/mGm4rUsjb1zH0R6wi3Rq
X-Received: by 2002:a05:6a00:1ca8:b0:84e:88dd:5942 with SMTP id d2e1a72fcca58-84e8d372229mr882823b3a.41.1785187480563;
        Mon, 27 Jul 2026 14:24:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e533cb54dsm3520606b3a.31.2026.07.27.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:24:40 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	tytso@mit.edu,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v4 07/21] ntfs3: convert iomap ops to ->iomap_next()
Date: Mon, 27 Jul 2026 14:17:44 -0700
Message-ID: <20260727211758.1116539-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727211758.1116539-1-joannelkoong@gmail.com>
References: <20260727211758.1116539-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ntfs3 iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT_END() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/ntfs3/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index c43101cc064d..53031e71c8fc 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2101,9 +2101,11 @@ const struct address_space_operations ntfs_aops_cmpr = {
 	.invalidate_folio = iomap_invalidate_folio,
 };
 
+static DEFINE_IOMAP_ITER_NEXT_END(ntfs_iomap_next, ntfs_iomap_begin,
+				  ntfs_iomap_end);
+
 const struct iomap_ops ntfs_iomap_ops = {
-	.iomap_begin	= ntfs_iomap_begin,
-	.iomap_end	= ntfs_iomap_end,
+	.iomap_next	= ntfs_iomap_next,
 };
 
 const struct iomap_write_ops ntfs_iomap_folio_ops = {
-- 
2.52.0

