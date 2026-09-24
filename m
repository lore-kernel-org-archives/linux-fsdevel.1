Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31888434987
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235569; cv=none; b=jF+QZD0LPy50HEQ0i+MKy8D72sR+9jURjC+x8elRb4+bAQIKGUpG/Z7nVPkRtES1S0TRB8Cv+qXQwRDIf8xuopryAa6OQkGpkLMufGTkCuISPYiTtNHejBIVa/GOOr9tPOdvJh+NPmjBPnBWuUytWcRY19XyIxQd4Ni1PZhMnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235569; c=relaxed/simple;
	bh=IXQA/g2/TtuU53NTwmNM9C9/HvhvdSxLCYNOlhYyQQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLkwz9GiUmKxCTwhk37YLTAFV2M4Dy5ILwn+Uq1obiVNeR/RBtvpmsHb0Z3jxHf/wXSypBPPYYZQ2i8ICogVCuV+b1wBzUm7gd09RS5O2QgEzifn8i7mzmJMzULMDqT0IPsBCk56sxMozhVhiuYCvhDVh6ye9HLF0HZgdNq4uYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s48Ceb5W; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s48Ceb5W"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8692a856865so790022b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790235564; x=1790840364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xs8AxoWUxhLFlNeCv96y8zKxhfgG9jkD4bCJjaoeEwo=;
        b=s48Ceb5WjJjdaSHK23h4CqYfxo3dVqtXQc12NJfukJducfTqJgnlGR+hSAtVIxwZ2g
         1ljXhTxmObVEx/dv/kEEKvYoXSdfY1+O5ue3/vKahh/GzfT9xKKICGVnLsmR2DSshvFe
         pKxhhN+pNui89pw+ypXgELjtvA5oSSP523MPuvszMCvWa8D9jC2edBS8a5O53W0H+6rP
         id4EvZfy/GjxcWgNPiebN0l8bGnX3TxC1dSrYF/VFURcbnMR9JdCoopkIoSqJgf/En2h
         1QIyyhbalTVuKuy4NYJSRib+iWxZUmNhiOWLG2YMJ7Prm4FXOWqd/gLmHykWzlLFu9do
         B8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235564; x=1790840364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xs8AxoWUxhLFlNeCv96y8zKxhfgG9jkD4bCJjaoeEwo=;
        b=kTcO0MORhho9m5/ngcihKStYt5iPCPz8mv5PTnHzI9dByiiq/IfJFYlRfmsSX5+iOz
         IxwJfWwRXbEkMSrkn/dT8e4XdJX5w9HL3rezeGZ+njsQ2DKMqwetDiQVIfi1v0pUgjmJ
         ZW1lf7tdSl7oeBebGfHn/0fx/wnkuxb8xoLcLzdGu5/o/nEeGliYkC86I+1Ik49CmjKJ
         PkwRbYWqKqjaCaYhuEaZayctLK3/mZr0Hs/eppS9xlnluWbv3dZHp/7PkpOQofGdJegE
         Fo2hemMFxQguTxEHUQnQ4RRGwOggL3jZ6tPXGfnaM10VrpNtWTh3Z1f1AUZAv6LtIg7P
         D30g==
X-Gm-Message-State: AFuF++nxLTOZ2XUIKgd3497wwPAkU+cHJpy4uCBCfFQtZPCDJNl7uczv
	y4L786FuMvAeFbiXiqYE/FrXrj+6lcaO0HRW5YzGFAdaMvLrDj7toRVT
X-Gm-Gg: AYBFou2K5Ljy4SDS1WMT2v6HE+946QXQu3seC/Ko/v47QrpdqFkYgokqqZXd7xTWLMB
	6DO6pEWs3C2MwYlZj/Ohfkw7soddOyM4Qpll21SEz6GG3bBP0txejg9WNvLWBWB09/g0uKu0jhr
	l95Dd/i9WHGTnWbNoUxArayXMl0r3DhnGNre6Le6Dj+qkoYBQ2uaQYLJfZslSf1mUtkOKqStqAk
	fa8YkKzpv6JWOmwkTjrUJY3e/Ggb8OCJDIW3eqBT5UP5C8YtUDe+B+B2YWLtR8gFerCus4XTQwH
	paopa0dimJYbzIKRQ9c20JoE7H6TEBvqhhpAPpWXVYYET9e5XVnaHFlj4liTek95Ei6vP2taAjV
	pMq3qYz79TS8dxPs6HX8MtbI9UrcvlbpYgHz+QwUgXdu8p3xFO03QS2rIod5e0dTiz3oFGFUOei
	tE+mLKhlJZgk5qfD20na8I+SriO6zYbhUwzsIomSSTv3vw83kow78j3Xge4evEi2xliU8cmUfYM
	VcX/qVtq2W892Uql2/NsJSj1FWj+MRbGD586V9exi/yRHgzaEQL9ENIGoOp2th+JLzwlk+VrqK+
	WThSQLt8CZyMJm/gPHMz
X-Received: by 2002:a05:6a21:3d95:b0:3de:13b3:e964 with SMTP id adf61e73a8af0-3de13b3f96cmr775896637.79.1790235564107;
        Thu, 24 Sep 2026 00:39:24 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dad44c6sm2393739b3a.42.2026.09.24.00.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:39:23 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: al@alarsen.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	matthias.goergens@gmail.com,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v3 5/6] qnx6: abort mount on superblock magic mismatch when silent is set
Date: Thu, 24 Sep 2026 07:39:18 +0000
Message-ID: <20260924073920.2782917-6-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260921042511.1473629-6-benquike@gmail.com>
References: <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-6-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_fill_super() and qnx6_mmi_fill_super(), when the superblock magic
number check fails and silent is non-zero, the function prints no message
but continues executing into superblock parameter processing, resulting in
invalid memory accesses on non-qnx6 filesystem images.

Jump to the error cleanup label when superblock magic mismatch occurs
regardless of the silent flag setting.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Add Tested-by and Reviewed-by tags from Matthias Goergens.
- Update Fixes: tag SHA to 5d026c724220 ("fs: initial qnx6fs addition").

Changes in v2:
- Split out as patch 5/6 as requested by maintainers.

 fs/qnx6/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 49e29a918a2d..a32066d98188 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -328,8 +328,10 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
 	if (dfs->s_magic != cpu_to_fs32(sbi, QNX6_SUPER_MAGIC)) {
 		if (!silent)
 			pr_err("wrong signature\n");
+		brelse(sb_buf);
+		sb_buf = NULL;
 	} else {
 		sbi->s_bytesex = BYTESEX_LE;
 	}
