Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174C37E5CD
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581350; cv=none; b=Yy5QA+bGOywh+ag/Dlnoo5D4l67qQAi6RRn9BR7MUeXawEp8hJKTfqPyWhCI/+QVFwg3q9kUHOY8xIP2mkGKCEEe5NwI/m+d5526Kr86iFIl40tCwkiJDjFnBpZEJJZb+e2e+Pf+iq13vrY3bDouPCP9I8Ox3lZ7WwurgQxJsFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581350; c=relaxed/simple;
	bh=bxFgzOsSwkN6V9YYUeHkLxqOkGrjNAkAhtGiZalF+jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGJ6JDTB+ioyxqThugVQzpV4/05Gof6zv1vnCPeF49GOdFYgrSTQClYEumDLKYlHzFCbydO8rlArNYy1rXnpJGG7HB3awitpaPWg7/3SAIUAoRSC/Bb46DGu3bgd9G/cl/yhV4dphrWB9LuljKyVHiO5bKo7LlihU5zplIlhzhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijdE/5+F; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijdE/5+F"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cad4170e8eso146774225ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581349; x=1785186149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yp/aquJGzhxfLrf5vlVUIXqEiLBtVhzqseptm8Rf/xE=;
        b=ijdE/5+FBXfn79s4zJVGWw6Kuf3TS3646fddTSbOzEk0sjjRv4bu8sFhkyfkre6uex
         mEAy09ZvEVo1btx01+qHRuiLroL6Kd7OUrBmEHdEiKb4a2aw/PShjHgaVizWejMOR+uE
         3CXVqtXaBERhv3Zm9haxuhpkEftUwh+dsOfEv9uvfeDYSCkFWRWWnupqkBNbHK2dBb2p
         CtwG0815aP+yTlXSW/bBeUWROxPSD6hC6ZcElz5uRnfMVZa6+gSGrM7LuWNAhTm4WQNx
         4xkDVseSbilSURGIkpdHNdkz2oeerDq/V5+hqATSzofC82A9lXiwRS7AwjpRrsj1kKVb
         03Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581349; x=1785186149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yp/aquJGzhxfLrf5vlVUIXqEiLBtVhzqseptm8Rf/xE=;
        b=DHCi+ZJiBpV1jWAs+eFw6RjFj0CFhMKWlygDeFah++USb9JxlIamDUwGjW+5VmXiMg
         TmhcJMFWgbPMlpVJV8faxwZMAC1gzsXJ4+RL0SbiDCrD2farLyxPU9HBkJ5c4I15q9FK
         NXYz78am0l0cElXD1hJy5VSRzfD8S01+BLxBbD9rjI2fjqsVo0MvDNqw6q1baEro2dEX
         0k9KTd7k0XdyaxhX7cNTeEj5Da5Y4UQ0cYZm4+3qxCqMo/uwHQAjKVFFft+d/+b6d0PF
         KVHxdT9Qk5BpcuD0IR7KeGEUMHTGU9QwnfUZd1dm43MAJCrwBOWN36g+8nyTVUH343MK
         BqcA==
X-Forwarded-Encrypted: i=1; AHgh+RpIU2kuh8ytsyAzITINkL4kMNGMYgRgtte7mXUf1zv5xrCk5xfCdBY4/NGotxaeBPPW7hxK+mnFRhHWQV3a@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RbnpgRDJe03n94rpKoC4zeTclWNQUfZbbS6LGOFyaimQodUD
	GxVynPanNa6FZ4u7VXtGgxfhqxZp+CsTUEPB9vD1xhrG/b1WDZ6L9cPr
X-Gm-Gg: AR+sD11Ff9BEYMeMW8E1Gsw3SRxZ2HDzzlD/87Vf8D/VsxVaOvurXZEEp/YJFP1vw0c
	pLBxBpA42qwbY+a0j2gud30OmdpAAg1oNBPPb28DGL7aDywYHYRwLouSIwVA3ANRBC2ozGiVyWT
	PK8Up2U8okPoqy431S/dAJu/fF34K+1D4GfcY4W0/BE2KHx5U65JdoU/dEIwreJcm1jcNP5Qc+g
	QRxzLujnFvVKQEf8+41sS6qfes8/99tP2Yk6gfy6fOCgXRvcORTka/YyOIe2EfQboo5hpJUJf4S
	7aqlJbXAxZmGB9/GjV3x0miEg/FBhip++gYULaXzVyOQAbUrIETzuEJhibzdAMXKkLih0IhU0HF
	dVHQaAPbSa6TiZTDh96u+07LHqs1JslRydwivgiGT8lpm09lOb4+p77uxDoU8kC/bTvo3TuKoCW
	6EjLK0VRQhDxsL3FvNUnvazmQChT3vugp1B0bC8G6N528hTMtCZ+f7MOrHzJpBXgJP
X-Received: by 2002:a17:903:1a87:b0:2c8:25c8:85a6 with SMTP id d9443c01a7336-2cf3481b77fmr166400615ad.2.1784581348845;
        Mon, 20 Jul 2026 14:02:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3471f42csm62594205ad.61.2026.07.20.14.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:28 -0700 (PDT)
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
Subject: [PATCH v3 08/20] ext4: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:50 -0700
Message-ID: <20260720210202.1163861-9-joannelkoong@gmail.com>
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

Convert ext4 iomap_ops to the new ->iomap_next() callback. Each callback is
generated with the DEFINE_IOMAP_ITER_NEXT() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/ext4/extents.c | 4 +++-
 fs/ext4/inode.c   | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 91c97af64b31..15972410d460 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5171,8 +5171,10 @@ static int ext4_iomap_xattr_begin(struct inode *inode, loff_t offset,
 	return error;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(ext4_iomap_xattr_next, ext4_iomap_xattr_begin);
+
 static const struct iomap_ops ext4_iomap_xattr_ops = {
-	.iomap_begin		= ext4_iomap_xattr_begin,
+	.iomap_next		= ext4_iomap_xattr_next,
 };
 
 static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ce99807c5f5b..278a032b300c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3850,8 +3850,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(ext4_iomap_next, ext4_iomap_begin);
+
 const struct iomap_ops ext4_iomap_ops = {
-	.iomap_begin		= ext4_iomap_begin,
+	.iomap_next		= ext4_iomap_next,
 };
 
 static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
@@ -3905,8 +3907,10 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(ext4_iomap_next_report, ext4_iomap_begin_report);
+
 const struct iomap_ops ext4_iomap_report_ops = {
-	.iomap_begin = ext4_iomap_begin_report,
+	.iomap_next = ext4_iomap_next_report,
 };
 
 /*
-- 
2.52.0

