Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF346C826
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353412; cv=none; b=XrSJsYTO0omy6btgvvjcCRog1TTOWhXhu0GQg4JlKenua4w5o3ZYgJaWcIg6wowPe3eWSxf813S3geft3tE5I81KUA4ESNhJNrcgxUeW3cme497koK30SztcmhIh5zMPhXSrq6xLhzS0huN3kEtUCIhoKa3E1YeJ8vH3jLnVTq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353412; c=relaxed/simple;
	bh=rkaAcHNFcamz6DhIX2flj3zcR68Gq2Gna+EtwTYWD4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKKlsz6gksy+RWQOP68wDkNEewaNQbYMSC01k5VAejTjGI4eJQ78TqULybxy4xfqGXdftvUNtLfGaGfLauHOTm/XC1LiqLRhdnwEgFRLKQrIpQS0uPrKhi+f3eMd7QC99Kc49Rt5C+HCs5VarCgl/u3uvpXwoiyGyQxnumrs7Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpNiEzau; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpNiEzau"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e041ea211so1494758a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353403; x=1785958203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cm0YRaFY8SVNZm2g6Tmv3v7XKJUMSaBD7LFCYeNZJYA=;
        b=bpNiEzaueZw9jT+RJwzbN/5RD9L+57N817zQfdi7Jl8xNfn9tlnQG2Q7Je7izyy2Kp
         XKhRqPsnRfOfFSBF7BXunKe4VuUZfgrzt2t8wsd7a+nNYcpfmp3qsZWpDhT+Y/bJQxpv
         NiObsTGPFEEeSnOVwG4BhsJJGrq0k2JV4hgjjG4l5NrsI4agh6llUWzJzK4LyeEWep66
         0fJS9rrhhEWZhCmSIwOHpoI3SOHkUegyFR6KvHtfPrg6kADtz9RMmRbq/SXt4GH1HGOS
         D9D0edUhKKjdnE4Jd54N5xX/37WZcSmtmj+svhEdt4vXbCNGXrX7eahMEbBxOuddQXA0
         cUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353403; x=1785958203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cm0YRaFY8SVNZm2g6Tmv3v7XKJUMSaBD7LFCYeNZJYA=;
        b=BFnjbNstDspOgoZJWj/k3h4O49YD+NT2duDtr5xCNmkUYRdwuRp6QUmilPG64bSSxe
         Q71CiroKq/V4z9Mt0YlbjzkzS8K6DpsFxX3yIauvn6G0h6XlLqQG1LY3b+yDndMPdyT4
         PsG7UUWPiYeg4QJgJxtxerzeUGkMVBwzR8fMW+JCSN03usVkp7+AXRb+1JWFQJJ3ZcE1
         H1mKMmU9PYXhZIXzI/1Rhwr0fnaUzsupyKfGUsvSGJ3JD9+Uo0SxC2cWZDfa4crCJrmF
         VpGo2rv+jJ54C9hYk9GIklJOu22n+EuSQq5q09WmGliEqX2HhireglVvO5Eswcc+HT/8
         f3pw==
X-Forwarded-Encrypted: i=1; AHgh+Rorx0jfvs6Mfc9Yh+nw/d7o8EX8QyCwIJvE+VHq1EosScuXROSSabmegB6BqchPIlAU1XJlRdirMUMh1UdN@vger.kernel.org
X-Gm-Message-State: AOJu0YyJa3toALv2VpxL4FAG6A42EAQNwjujlAmjDOZgk0Tfjh1OvnLF
	FxYmpWxFyAi0OVfR1gpi+D3J4M7xAbo+gqFoEJpFIFUusaSczX2X4VZZ
X-Gm-Gg: AR+sD13LsThOa27j9ez+IYNSrh2GWbuv92ASmvIjJdaVHpXLzYZ83wKK2sRo8XEaXss
	0DJf4ZuzGP7K1NVeuYzA4DsOZxPp5MCYuaPhPWuL9KzryUVADq82o0mHAeDI3r2ClZlg6dXO4mD
	gh59Zpfp0u//Az5F7URpHrPJGV1GeZhDYZP1Apykosq3ocgfkZSRuCfcU7H9UH1NEjfUpxLc6DE
	lsTGz3+Y9ygv3TH1bJTmQ4hKIRgf2kjdXVw8VuCXpAKXR9QiFco/SSvftQODsx9IRmU+PVGL9VN
	Ax+y/UPxAcK++D0NkAQd3ElDO8lsqlzNugzHYB+m2B9oCOYPN5YnEfRF9d/vyttqXRbIl2PreHx
	dEkTt8gDgs56a6T+2exjn1yXvPFwFH2pC4/xpC/y6bha0nZ2qxjLW2TTxj2JV/e6SRQgwzewOYN
	yZtgIUv6ThywSX3McVtUDjG/0E4/b+pE6SC5Aca8zyNIgnU7Y4rGdr1eB1EXQXkKvK2gAlfoF3Q
	9wYECJP6ezphmx9jq+7+xEKasVGikhZ7E1urY47
X-Received: by 2002:a17:90b:1b0d:b0:380:873:49cb with SMTP id 98e67ed59e1d1-38f9913c940mr172669a91.21.1785353403298;
        Wed, 29 Jul 2026 12:30:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f2b9e1esm1792343a91.15.2026.07.29.12.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:30:02 -0700 (PDT)
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
	Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	bfoster@redhat.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v5 07/22] btrfs: convert iomap ops to ->iomap_next()
Date: Wed, 29 Jul 2026 12:27:22 -0700
Message-ID: <20260729192737.3190206-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260729192737.3190206-1-joannelkoong@gmail.com>
References: <20260729192737.3190206-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert btrfs iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT_END() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Acked-by: David Sterba <dsterba@suse.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/btrfs/direct-io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 460326d34143..d5439b06cdc9 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -798,9 +798,11 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 	btrfs_submit_bbio(bbio, 0);
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(btrfs_dio_iomap_next, btrfs_dio_iomap_begin,
+				  btrfs_dio_iomap_end);
+
 static const struct iomap_ops btrfs_dio_iomap_ops = {
-	.iomap_begin            = btrfs_dio_iomap_begin,
-	.iomap_end              = btrfs_dio_iomap_end,
+	.iomap_next             = btrfs_dio_iomap_next,
 };
 
 static const struct iomap_dio_ops btrfs_dio_ops = {
-- 
2.52.0

