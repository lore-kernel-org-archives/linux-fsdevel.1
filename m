Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18BA39934D
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581356; cv=none; b=Re//xZ03odFwqb9+GQ+Fnzs7nYMjcJJi7Sm5TVhBtQRvCIkz0QwEuLBUpevEw/bhJXINzOepuVnxeeMmExTc8Je3LUnGVoB3eFe9hiVTqsRA8amm3OYa1xVnfNtCZEUD9PKq8n1JiDagdEahvlOP98+35cwLgzk5/8DkeqLDEJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581356; c=relaxed/simple;
	bh=NkWTxDB7BVf5kr2NeMKSqq0wtS9n6p/N2UG9HabFDJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEV/vmVtfyXCEdKq54P72qUjvMyjEumHVnHbeS1Jv3Ces6/UuvLa2h27rq5f5kwiL184goCn9V2NIsKPXHKwdwuz7FB49g6PsdaCnzaJCFPvQmJtuYfGxAkbqa1mCFVDtzt/56o/5C4hOB22Cg990OeBG0Q2vxENaWnomiC4ncI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6mvLuL/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6mvLuL/"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca12086c06eso8812750a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581355; x=1785186155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6+Ei9NFKggzOoAWAaPtMOQsJgv2L14jqLZIvC8zwcM=;
        b=Y6mvLuL/JwcPIFcadqDeS4YvB7i0x9vv2s8uyJQ6d3kVX7sc9t0+4/27+Brz6J+CvR
         jy4yMlsDE92MA/EXBLFEQveVvjXDnzlFk0+j1pzTHXaxGu0bAwKmZT8wseudW1AQYDcQ
         g1n/mFRChBOV+8wyLgWCO6qd1l3rUR3y8d8m5eL8MzgSj2tnN6iHKlCZsEcMRxfZ7gyK
         CryzSajaqLaCUqJ8yGZCDeixyHU3bL7qDAshryUZxvjjcQIPqisnmjZno3ju2erSgoMA
         0tkpBEzIm/L8KeE4rlkoCuNqjz3Y+HKjRfADNaHGFfdvBM80xmqLFcRmlkiwZW/xqXEJ
         g/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581355; x=1785186155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e6+Ei9NFKggzOoAWAaPtMOQsJgv2L14jqLZIvC8zwcM=;
        b=VzRwdKe9SoAG73oozOGOb/i5B/lWrSZinM5DIdVuggyrRdiKhfdqSiAP+tD+m55HTy
         YgOsWNlWsHx5uMMLT8Z0AArRScSnGjrgDNTI7Pgm9Xvx4F5kzIeNQ7joXcJh/w/d/uVx
         O3EtqiECp0p1JsDx+2dZaEowgJoie2gWBRKcnxbYBKip5XliRxTmR2a4OuRJmTmeRBVO
         3r19hVS0ZCle8f5DGldMw7Isl8sjq167q6W9QLB2mi/X5fo21EQbk4ZO2iyCTpy/5XZk
         8UwixxbPkAvhafJZUmCkzg6yfVPCKfpK/oF23UZUC8tEpoT6309MKX27/xlEZHwEAN0l
         1mHA==
X-Forwarded-Encrypted: i=1; AHgh+Rq2yN6w1DameJBRlSP29xBeEX1S34IZXHrdHZCai/T9AO9wnlG24H+IYOI5is7/IgDTetghbYPeoWgWPPEs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0BC3Oc8tAQGHQLN93nsj5qFKXhvsQyVlI0RvT88dTj/ehJXgo
	kGOTIOxSRrPFYtS/75mz0MZNtJ++2pDidTJTJ2/DWMZ78sAVobA+oVl9
X-Gm-Gg: AfdE7clMHrX3fmRZtUNE4CizMZsPIFtI7OFyzQ26KbFw52zsdiGtnQ1g2iCcTRY4EF6
	GiacD2xXmmv5EJiJGEVyHHdUFquOcLtR6wo+gH3A6Ut+jYLH5wgeZyYAsWm4337Y54j66orTK7H
	27D9EV8FWa91Xf+QYKtHL2yZMRgjlYJghfGUllZsxfOdLUKCgFYPCp+MlHbIxY8PZS3zROxVMtL
	4DQhyS+ZxKWp0s1YYFkuEmwBKTGrJo9bO3ETuW/2MDzyH2+AY0f3gLUn2rYMjS9gfXOqUVRAHNq
	rScFCk/CO523DhKGRnp1pNKZE33ieaGVx/p4+w/EtTCKCHgLFXWO54+5x8deSCQ6oUOR0+NwXZx
	bQUIPE69SmuGmcxLOX4EHjZwu8BZeFL5TR2hkMde9uh2ChKIFErE1cascZxtuJWZ8Ha9fWp2Uf6
	kHk0cd94/0hhYLmaGPKs2NiAQ/VpvdZ4ju16Jr7GQbZPIF08DMw2lY+qXd5SguFcc=
X-Received: by 2002:a05:6a21:7d06:b0:3b4:6cae:4a50 with SMTP id adf61e73a8af0-3c3ad7d2491mr16877603637.20.1784581355126;
        Mon, 20 Jul 2026 14:02:35 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb519de34d4sm5501621a12.26.2026.07.20.14.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:34 -0700 (PDT)
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
	Dan Williams <djbw@kernel.org>,
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
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 11/20] ext2: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:53 -0700
Message-ID: <20260720210202.1163861-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720210202.1163861-1-joannelkoong@gmail.com>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ext2 iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT_END() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/ext2/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 29808629cce5..7e0fa9c454e1 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -860,9 +860,11 @@ ext2_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(ext2_iomap_next, ext2_iomap_begin,
+				  ext2_iomap_end);
+
 const struct iomap_ops ext2_iomap_ops = {
-	.iomap_begin		= ext2_iomap_begin,
-	.iomap_end		= ext2_iomap_end,
+	.iomap_next		= ext2_iomap_next,
 };
 
 int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-- 
2.52.0

