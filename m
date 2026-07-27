Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD042D767
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187487; cv=none; b=jqp5Frq+a4swbQVk7gtowVgfC3A/WF3FZTI+nx6sAXW7tRER5fkamGhFJu2AwlmG4cHNjDZL8bA2D7HR75Yjx6sCxH40wrYDqZO4JyWY8aRmbo69I6OK3YD9RcHja71PKyE/u7hR+FtUjAVo4H2gKrd2s7Gc7TMh2dQLe+bcze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187487; c=relaxed/simple;
	bh=1LODBsXTJz074zPmHlKPolHt/XzrgN7p/Zc0cYoesy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oreMA0CGvCcUznvq29IKCkQTGyy+OWaOplYBKBnqbO4sIpWE0mDKeJmgsmnLE7LN/x8v9N0qk3y0LPjCYBfVuVbfhoByVbee9R5X2hHpZNdAvOeYDcjTq3qsQKg8jDI+iGunTc70IgNtAR7wHRKAQ5DavHGwoOh/e+UtbSwlsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAbLykFf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAbLykFf"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848743155bcso1196106b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187486; x=1785792286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Cj5pCwh9UiKuAyGTCN2ecA2rWhLN61eKI8rtelBEo0=;
        b=eAbLykFf/DczSvuITBALQTFGTaG9iu6EdNWGPfmziuDcvY2Vx814nnsKLXupim4pm+
         irlsgwtVUUsWoom7k/FNyTT7d5lZ0cKFr6amwnUBryAZ0eWV9V7KNGNDry7Y7P1cqdzg
         Fz1KSyf40Jfa1zKFLCwzNR5WfuM4k7eDCt8MzOx34pJyAtlkn4pAKNe0VdAnYBMKu6n2
         cU9On7awWeoqYQBWPWQfRS+bxy6Qkh1pbnM7Bc9qIYuisxF4E2RYeMa1+P5VCMje6t/o
         SaDK+QsUqi9y4vCsE/hSEhl2A6aTCNwSvZUEA1X8eMFi7xb+36YxDy9QqXAhJsu3tQui
         qamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187486; x=1785792286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Cj5pCwh9UiKuAyGTCN2ecA2rWhLN61eKI8rtelBEo0=;
        b=GuOAEG+SoWr3UfB7Q4DQW8tGWhGbRYu8pXL4he+YJ5EoAIxfH6RgICQJy3C6WDPCLr
         hq7qw/IYhZ7WKSR19PoLz5SbElQv1SFCJXnzeLlqQfussDPsP4dtn4lhVGPas7D6Wn8G
         PrHz4Z8bTjX4ACUjKIFQZVtG2hKzHP5XTbVKxaKJuIugoYekWEmAXjhJ45tpAqt2b2B0
         kLTnYkFm1kzYkUY7OkIaODnonCUI8HqkFTXPMlZWP+YFaiM73F7lwb77bz8IS/BWhdfU
         BC+n13awn31TXJbgdCF5cKhMdrZ2aBdjLBajzluym2eQVZLMGIejW+OStct0CrnG8gVd
         B7ZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXIKY/aP8MKljDrfL60AJoX30BLH6pUS8UyAR7L/4nzvzMFyaE65TNNgwwOKKmVbTIi6AXkVv0JLfj0pBg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Mp1Wxf6NLbTAAbYMmMebR9k+dTk77L/szKTe+DE+Smo4RZ9+
	ZzdsiI9Cxc2Z9NsQD/jBj4BjZFG1/At6UWtoUO9/CIbHCUNOJ1h7DLcc
X-Gm-Gg: AR+sD1270+WwAO6m+d0rf0S69FsPDWvUIp77/hZZbJ6SUSwOQYKaltoK9AIObBClInp
	mQqUwKcxgfFLYDzT/jbpj/kJoJK6EAW3bUD+aHz4IeRjR+dVTtjvETAyfX5aguO6SaB2AJHknKb
	1gXlJkrZNvGY3nI4HiXV+03oS+Gnpz5NfQVwktHrHLCc2BlV7LChoPM5pqFwnpMZ8+n16kBvkAW
	i4wAwq/oH5Z8Jau6AzmZRIJKWpLeDbu7swe7nc5NVAxZsO01gFCWCX+gKE263yTYQ2xMtFtego/
	i13VONqA5beA+h8LfTQhD1AfpBB10swuTUPnQUwQxhCRv2S6EyXzV0PuMOPcPVMqTkZdhrpVNnh
	540ComvoTt7SHoIxeFNan+Om8Q74UgPH76V8/mvP9rKtsZ8G8Ov2/lgZXHtCollRETkYKCOc8Lw
	gro4jhjsDgAf7nDOU/3ncmstgk/d3wcXVO25zEkhHFXWuP3XR3yOuDMw==
X-Received: by 2002:a05:6a00:1790:b0:84e:831:9a1a with SMTP id d2e1a72fcca58-84e594683e4mr8243554b3a.21.1785187485740;
        Mon, 27 Jul 2026 14:24:45 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e53425989sm3543194b3a.48.2026.07.27.14.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:24:44 -0700 (PDT)
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
Subject: [PATCH v4 09/21] ext4: convert iomap ops to ->iomap_next()
Date: Mon, 27 Jul 2026 14:17:46 -0700
Message-ID: <20260727211758.1116539-10-joannelkoong@gmail.com>
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

Convert ext4 iomap_ops to the new ->iomap_next() callback. Each callback is
generated with the DEFINE_IOMAP_ITER_NEXT() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
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
index b48c54f3312b..bf9755b541be 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3850,8 +3850,10 @@ int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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

