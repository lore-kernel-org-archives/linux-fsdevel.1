Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5F4C6519
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349309; cv=none; b=e0fASHtyUkqEHGh3xEF5cIhIVaNB9IOSC6KbwX/ZSJcjWul2oEHKLsulcurk6lRZUp446TPIGC98gIw+3wcU6L+KYRUWkgd5bE6HwCG+y32e6v6YZipnX/NmKMrAJEWsQCBe4LMSm3cuwVzPNB4eDOC1jgeh6PC0/0BRpXOc67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349309; c=relaxed/simple;
	bh=c8exgZhRSt1K9Xf24aLucJv/jHBFcEoxLoxElZuV0CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQ9BA+XE86rKmzIyk9G/vvLgQXKKqbSV51eZiE9TRLXwFXhErUD+XFK+spLnALY0fItuJxaYzNWKyD4si3uYSTVRRjL5ImVGGouYpa67BMAt/Qibx9FlUB+QL/GMczyp2Jq/1EkBo/ZeIvHvlAvY/w/iaL+xIoOTcLXSI4+2u/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1BNY1nn; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1BNY1nn"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a147688bso748720a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 08:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790349298; x=1790954098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B/+1mK2LTj63lAp9a9sBW+bMXSaZjbdP0wXTk6wt0C0=;
        b=K1BNY1nnnotVmMJFSnB93TlwlOquaInQY88AMov2CtswOd72N1VcYitVPze+N26WV6
         VHdhknGx/K6b6JClS/5rG0+rQ8J/MVcSRhGMJzALObDEjCJA8LRtbddN1YxfbN4qoeBW
         aviKMFbVrDQfNLw4usl4kBA8xlkBXHDTOha1wEJ40H26np3AiGaaAq4uWZLZ9Ht10gfM
         mLIipXyIQQWcoBU4RbVqwdgBxLC4J7ASzQDG32UfxzPDaiksD3f5/xbPT3Sc7HhkiytC
         91qQNA26ZjwO5ccwmfxshftU7zfDHvWchQbqdjt0n8w9gY/ETJw2gSK+ifSVo9DlnAqT
         +e6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349298; x=1790954098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B/+1mK2LTj63lAp9a9sBW+bMXSaZjbdP0wXTk6wt0C0=;
        b=yJQxZXuJFUTuIcwtey5ye8fgoT5P/ToXwh5vRjaf6ADWPJXb0YimlFtvmKrUF5hQwd
         jzXaqm/V3D5eTnOi2Kutb3BFm8aJ3wkSxn5er7cNgKI2iyRXJS0tYO3fe7/8XNAfA9dS
         j9ikpOG3jO+RioFHL1wMyYn19nUju6nZ7Z7f4A3PyEQxfq1O9EYRaSXGGKl5qaNm4ghu
         Mn3Yo8Z5weLC+Y3nbK9/2j0mEqTxHNUYmxMVH4aKwDPK7mgmNv+6Q6E4p+/RuN9vWptG
         vsHtjGAnL02j0s4GfIaBmyjQnlG5IIq8h5TapdtONInT1ZFzsYSYlC3M6PrTMImD/sW7
         Ga+A==
X-Forwarded-Encrypted: i=1; AKwUvByAFDkU8fWGO4IZ3PVz3/W86n82XaEBrWUi8faMldoqRQJAvTuesNtODDVBKquF69Co3p5WCFkiZYS+kSl5@vger.kernel.org
X-Gm-Message-State: AFuF++mZxoZKwNGTWNExCN5MhdIlgNQxPu3FwWPRmupu/679MisIUNq3
	Jtfl7UkuHYaHWyiOzEU/Sa41DLyaEuZkVDHNUoRgjdQNStyvaTZWfWFk
X-Gm-Gg: AYBFou0zNjcGIo+L6zzrPbBdCkKB0j9pcXLQ8DW2PSXbIbpPYAvSa9dE8kAssH85FKr
	jL0eRm6UxyKI5kfZwR50zD20wmE/JR/lGztju4uI3GrNK3+lQBdUD8fE0Cb9/TvfSjl0TTmTn93
	M8GTl9uSeBRP8rtSO5OGZdQbGNaGkQklT+1JxZWd1mhFFMYGZIDpFQWqYZCsPGX5JbSq1Ogqozs
	Ovb8fRM21EvxnES9r0XWK9pvP5GlOyqVscyc6zwg9xUusaF7b7VqcdtYtW2AoQdJ3PCtvKIlu/w
	0ijWj9Qgi3ZUX9Y1sqtvTGslxUh72ig3517ZCBEuw5jZc/lL7jLseF5l1P9IdlZMe30Ok3aHH7/
	QPVJzsG702F//ZxBLP5prIHruUBYh8lBGH1EQ/OTxDtdwFI5/3nqgRsZ4T6X/bbaXQMFP+dXWFU
	FGVwh4+ozGuJ/aVCe7guyJ3Ds6pSE/c7hakUfSm50p4XC53M76plhCZyAArrdA11SkJK9HQVEC5
	PDBcFYf6MUB41J1XSVWSgOsD6n0ey50WLIyinyg2w8VZ5iVnXDcTVSEPvwe8XNeH2VJy0FyvfTX
	tWMUHHHO7RdXAHEeWcpKr1M5v7xiZPeWmW1I1A8N9u83gyfi1c9SUebOkgmq
X-Received: by 2002:a17:90b:2751:b0:39e:5c8a:33b0 with SMTP id 98e67ed59e1d1-3a098fe8b26mr4789508a91.33.1790349298062;
        Fri, 25 Sep 2026 08:14:58 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78794f224sm1503252a12.25.2026.09.25.08.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:14:57 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	benquike@gmail.com,
	dlemoal@kernel.org,
	al@alarsen.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] qnx6: use the active superblock after choosing superblock #2
Date: Fri, 25 Sep 2026 23:14:48 +0800
Message-ID: <20260925151449.1517608-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925151449.1517608-1-matthias.goergens@gmail.com>
References: <20260925151449.1517608-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When superblock #2 has the higher serial number, qnx6_fill_super()
makes it active in sbi->sb and sbi->sb_buf and releases bh1, but keeps
using sb1, which points into bh1's data, for the Inode and Longfile
level checks and for the root nodes passed to qnx6_private_inode().

The mount therefore reads the inode and long filename trees of the older
superblock #1, through a buffer_head it no longer holds, while the rest
of its superblock metadata comes from #2.  On an image whose two
superblocks point at different inode trees, the mount lists the files of
the older tree.  brelse() only drops the reference and the buffer stays
cached, so KASAN reports nothing and the mount does not crash.

Point sb1 at superblock #2 once it has been chosen, so that all later
uses see the active superblock.  bh2 remains held through sbi->sb_buf.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/qnx6/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 916de1e3ccc4..0dfe8a3dab83 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -407,6 +407,8 @@ static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
 		sbi->sb = (struct qnx6_super_block *)bh2->b_data;
 		brelse(bh1);
 		bh1 = NULL;
+		/* the checks and root nodes below must come from #2 too */
+		sb1 = sb2;
 		pr_info("superblock #2 active\n");
 	}
 mmi_success:

base-commit: 40288c9206c17eb66a603262e06a58d300d0f279
prerequisite-patch-id: 46f959e08f10dc22aa50f0dcf3b666bc797e16fb
prerequisite-patch-id: d556417ccc538855b2090601ca20abd209019457
prerequisite-patch-id: 66d4e443988c07ddde054c867da5ebdbb34c2489
prerequisite-patch-id: 873f6449aef25a36fb2a66da92cc2eb4f0a23d12
prerequisite-patch-id: 51ea17033b2899bab8950a36f880154df18a4afc
prerequisite-patch-id: 0a0f17ec064751ffb6558cedfaff3be7b2a41f79
-- 
2.55.0

