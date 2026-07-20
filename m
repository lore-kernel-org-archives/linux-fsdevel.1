Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9501539934D
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581354; cv=none; b=WioDzX02YO2R9a56zzHWTTi55xslKC36O3HhbnfWWNX4OE2InA9StEXB1mZ/sPt5Bob8jTMlMSvqLceUjzq5AstzTyYaXFMO6lkCdpIZTgO+E6E1iPlW2wwiwUg1xC58/bHgDscrDRuQFWegY/1NEwCUIZrjUN4t6fZYweo2NOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581354; c=relaxed/simple;
	bh=I1/B/VCVgJY8RSk3e5mUZAn0yn3CaqIYyFG9pA3BMgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Llxu/GR0KWBhY//0dxSF8F1ewNpkeSoSWgYP3oABu1yVicqiTTCpi4hIQltjEhb+R7Av1lga+jihNC0QUmbxY30+oxVXAOwaW+41TfzeHw9vcPLBYMkV/yR7xh9VWzs2xzxCBPrit/20GJRTKHh5LY6CloSIvhTHsWgKbs9mpsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrA0yyVw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrA0yyVw"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso7143304b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581353; x=1785186153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dLU/L6CsROrofzjMpXdvaYiNOeRCTsS0HzdVX3uerqM=;
        b=JrA0yyVwyj410+LPueUNWzrrvRaDc4RqNUFsOnfq4pwjdKMBhdC5i/iwbsOJPl3GTC
         27dgNu0MtYi3s4A4qbL8iuumqallodlh56hmpSF87RB88U8rNnv8GvuZFJugOscc3/sl
         0yt7OKQM0MQgPONhMg0Yi8JpzpOvRJUw06DByCphC/kjmb6pTxBH+e+7brtta/t1SFXv
         3p19G/BqBNJgwRhhH13QKJb1PFw6Lkk3imz7Wj+R7KI8U48xti3nip2rAJ1cl/hz6Gk+
         QxVRuic2zDWxvghZ3C24NtZd7ZQ5+wwreH7qWfmZlExBsJfFk+h0Iis8GyxrbzU164RZ
         eakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581353; x=1785186153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dLU/L6CsROrofzjMpXdvaYiNOeRCTsS0HzdVX3uerqM=;
        b=V32Bj/ve4X7z+4gOHlGtXx5jw/o4wzf5xFsyacrp14qeqbeVJi9t0xREklDHQz1mti
         VAizG7C3OXoJUGqbO1gN2+kToVJT4TPPvgbNGhO0zUM01n5uqpCUjCpZyr1ISVUN3ps8
         2Y61uWDtt2pBGQAJiiSVCCS0rpOpLZc8kdBVw4QxsQvPwnBSesPfh0RcdcVLMITvU7f7
         Tb8fUYRUUE2KfzDAoun3vmsG7BYv/sd/bjHAhShxDUgAE7EkULswa4+dQCjtukOWeEnN
         oofK/OwC3QNF5Cypt7urYO25t7JAemZBueX8L9Jqi7zQ0RU8lXRiXXGCmyD8ple+SGf/
         aiHA==
X-Forwarded-Encrypted: i=1; AHgh+RoyeK0NokSe5DjjS8P12LS2qpqQFod2o5Wg485OzlcFD7aJghAbqr7xvYNR1z1dWFXlnqUd1Sfu2SuT7Wnw@vger.kernel.org
X-Gm-Message-State: AOJu0YzSP8/BSU9tZwk/F3eX8ObmJjefg6BshdUYXjtnTdLtgcCB0sdg
	Dt3sR9uzNh1z0mdyN9U0vEvURTwo/cBVrxbKIsh/69+mzw+zxcmLMjeJIr8SMA==
X-Gm-Gg: AfdE7ck+S+YX3u//q8fYyMnkkpRY3uE/wBO+0S9vQz3dztsQm0KyyqzX+sSUljLbn+h
	DRRFRSg6o+nNGt7nThMChtHkTjSqKFPckCEXqusfO2+obEaczInOzAV0/6ESY/MCZUmhNKoOBP6
	v2s8hSR+I8ujvreyTdbxnsixs6QjENck5NJBxFNudH92yisHwlLzcIsdn9t02vqt3k8WbTLUl/T
	0nnjqzviXS1NCcRptOdkL2IYG8UN5duRp28fSSS7IEF3wj1d9E/+pqT+cmdZiGh1V4I4yfogpWt
	aCG9QTk+JgyN+GG0d2gU6DA38IrBsz7m+JtD8VCPTBRqxpVf0uBqW0oXACRW9LF2KyT97jnmOtb
	MhI6zPEcNDG3OaCEqqaAXoJ7R7L8nYv35YEawfkG8a9FG2OzolLuonh3toPSvbkt8FfU9awSbPb
	Y853tVvn8M+0C9PrPjdat7L8WJk4d3PmSvqPKEnHzw/tGkmGVzScNPNw==
X-Received: by 2002:a05:6a00:928f:b0:845:d286:1fa8 with SMTP id d2e1a72fcca58-84c294a70d7mr16295457b3a.55.1784581353098;
        Mon, 20 Jul 2026 14:02:33 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e05e4bbf7sm6336b3a.8.2026.07.20.14.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:32 -0700 (PDT)
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
Subject: [PATCH v3 10/20] zonefs: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:52 -0700
Message-ID: <20260720210202.1163861-11-joannelkoong@gmail.com>
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

Convert zonefs iomap_ops to the new ->iomap_next() callback. Each
callback is generated with the DEFINE_IOMAP_ITER_NEXT() macro, which
wraps the iomap_iter_next() helper to finish the previous mapping if
needed and produce the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/zonefs/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 5ada33f70bb4..5b34849be7a2 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -57,8 +57,10 @@ static int zonefs_read_iomap_begin(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(zonefs_read_iomap_next, zonefs_read_iomap_begin);
+
 static const struct iomap_ops zonefs_read_iomap_ops = {
-	.iomap_begin	= zonefs_read_iomap_begin,
+	.iomap_next	= zonefs_read_iomap_next,
 };
 
 static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
@@ -106,8 +108,11 @@ static int zonefs_write_iomap_begin(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(zonefs_write_iomap_next,
+			      zonefs_write_iomap_begin);
+
 static const struct iomap_ops zonefs_write_iomap_ops = {
-	.iomap_begin	= zonefs_write_iomap_begin,
+	.iomap_next	= zonefs_write_iomap_next,
 };
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
-- 
2.52.0

