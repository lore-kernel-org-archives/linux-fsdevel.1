Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856CB4854E4
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785353435; cv=none; b=Fl/K3CouPNTZruGO7bNetUa6sZetTJS89paF34/96T13mnKW66pUzSWfa2Y/AdM/ycjxiEDJo9CVa7g4jeB1TtnUksw/ShccxE739L878TvJJC0Qa/O50uW/iqsDHg9UugQFjoWmzcY3FY12r1Jba1tXUWUWQyxhOTF5zvBFYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785353435; c=relaxed/simple;
	bh=3Fbl5MaGSEhPrjx9pliGoJqPoQm8nDp7ZS+WKqitgus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMyp7tUgziQ/Oz6JQkMnClewj+5QaCZRWO+2zBt/NUqALKQBiBs/PBqQSV8kHxY0GhVguM3aRP011JDDmOSa1UkbF0U2AJwZNLIgXinYTZlsbtgOw6G+yQGKBlI7YSXQXEIacg/hQZOYmik9FrWLsmOWkniWAZtXRnM9k3vzVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H06m41OB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H06m41OB"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cedda2ce6fso11978845ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785353426; x=1785958226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jH+TeFe4eS2WsKabb3CNPoYBr5KTegiyeJHR2iqxc70=;
        b=H06m41OByIOb+7bpYmBbvmgaAAu5JSrdjwMfjBhS8Ju5+anz8twzpKFbzmc/07yDpE
         bTGsmLbIQPXeKV215TyGAR/OCymAFn/kSx+rpmRuajT4Ko71uKal1mCOuUaJCqqmcrpJ
         461Ze4ctidrkn5V1LvcJHxtxTYgLEFBA1MaPJgnN5sB1jkZsZWkBFPTMHx2Hc2LT9ITA
         D0TIJUCe5TZZa+6q1ia+5h3ROzEPW5yA1EWqkZFhiJCpVSZ74kxHFl/FQhDNJx4nK9Am
         S3tAmu08WpFNqaGxdalUlWp7G4/RLjXOwCs14EgQGwzvT7zFq9AM1Tmpjiyk7q+2xxj2
         3IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785353426; x=1785958226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jH+TeFe4eS2WsKabb3CNPoYBr5KTegiyeJHR2iqxc70=;
        b=QhX1+pbWQwoWeUsZ5JEllIgJM439OPywm471i7gSFRZI3R0LQDHu14YB6aV2fIcWZv
         1abKE1MisGU36ej/TPIvpdXBiwcyH9y6Imb6+v5gqfHc2HsUImPLDWCKv+nLx0OVtjQj
         lpu4rZqfcf1n0UzezMA7Ifvpx4UMGitDk5OJwNrR/DiAmIY3GCrhrW14jps5k8eOOXee
         gIKXv78lu1BgzCcuKmWEWUM41LTqLNrwamU9c2870JrODz6i6/SlhbCLVK00I0imX9/Q
         e5nTP6kGAHmvNp4SueQluyr1am6AhcdCfPUK8nEj7JIh2zuzxav8PGpbCLgfZJkhbOwH
         l+0g==
X-Forwarded-Encrypted: i=1; AHgh+Roq9MALWVDWqs1qfRXLNajggreTc9vznq/t4q1pSbNQkf+9hDIfqa7HrKWF5XXjo02+sVke/HqD+kebyjfj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+e6/rsMaOwDFZs6flTyXhqyj/YKA/86weqVQaZB/GZ7sYaIul
	88lU78oQI+oCSYEXGJHczOXUz4Cmo+k3cwWnpSznEgHGBPrux5bBDQnh
X-Gm-Gg: AR+sD12TxPXJVLXuMIPb6xV3cKHX/tH3vxD8cdauanLP6hbFniwq2hUZ67Jn1pvwjuT
	xEnJs+2HEMrabnOXxVQWSg/htQpUhirfvIds0E1kjsKZnfqWSB5msmrgMwvaIIHjGyx4JKi8cZR
	73Gsz5fGNBUVmrCAonRO/ai1apjq6S6AwbnpDrJHtnJUulGpMRzeiWSmiKYlfBhn0e6dk+Cara+
	5LLMFees7OQU3+UI57qDcwHTajhuM8Cki5onR0chFYBhci0nO7KfYJtoofwq0Ef86L8bSftSBaC
	4msiFwnm98oggFEL7y0OUlU0voM+NKkwqVF/Ihu92HiTzDvPr8xgWe/WvVXi9mtWYupqQZyUk5r
	itNJ4bumicGnWZitL4MsRtD5QKvJNK2t93jrH40RH6srRYl4JICyVEacUdfLRuwG7ML0SqyE9xM
	7CIFrKY5ajQnusaHvFwMLwpGTyl8lYrYpYFCktQIZHHxsutfp9b/pFM/kO6FvOgjfQM51WBZt4j
	YiYRd870j85eTLvzysBPaTd5Td1fKOfEO5wk4J4zX1zMt03Xw==
X-Received: by 2002:a17:902:cec3:b0:2c9:d55d:2d3 with SMTP id d9443c01a7336-2d033b2ad0cmr1860175ad.15.1785353425702;
        Wed, 29 Jul 2026 12:30:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a16987sm15596345ad.16.2026.07.29.12.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 12:30:25 -0700 (PDT)
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
Subject: [PATCH v5 15/22] f2fs: convert iomap ops to ->iomap_next()
Date: Wed, 29 Jul 2026 12:27:30 -0700
Message-ID: <20260729192737.3190206-16-joannelkoong@gmail.com>
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

Convert f2fs iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a765fda71536..8977ad379f50 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4653,6 +4653,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(f2fs_iomap_next, f2fs_iomap_begin);
+
 const struct iomap_ops f2fs_iomap_ops = {
-	.iomap_begin	= f2fs_iomap_begin,
+	.iomap_next	= f2fs_iomap_next,
 };
-- 
2.52.0

