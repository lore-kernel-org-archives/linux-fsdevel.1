Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A142CB17
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187491; cv=none; b=tFhmdbPfiHZHsH0h4ps5TSanfw2MiDFrygJ14CTdZRbGzvrSe7l5JH/nOETbUqNcnQeS7653bBce037v5Oqi6jscV8BXZEk2+Kn/7TpzotuLDBA90E+j3ebGUAZQ5NXTfZ2AQydZGQ10vQHEKdRfH1XyQ2eT9AUEb2hpklYK0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187491; c=relaxed/simple;
	bh=mjtFePw905Ih8lZM0jTOp001M3VsZYjlem3tQ4B9G6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggVjGaBCOai3jrkFdgsoIOpwed02mGkxTezPmeDLbeNIJGu1QM18OQVnU0Paq0M784HmCmsN5ZiRwAEWGNKOWo9vTKld6Uwb0yxodvbXvupnRdfSTgnr0lBv6g8yAi1eVetSVaAGkgt2h+rRJE5Za6Fgw/iTTa0Q0kVaXA8SQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gm4VlN14; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gm4VlN14"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ceb096e675so38616305ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187490; x=1785792290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t0HucSFNwCrhhqVsgsZLRy5u6x5BGWTlUoNlDXYASAs=;
        b=gm4VlN14wsV7YR4qhAHoqFHBZUxX8+3x2mYK6mKE4zZwsqvCeuqdEHWN+C7fWS6Mzy
         jL7Tgi9TmiK3bjUS4nyVE31Jxjx0BsHZuGkmi/sFjKa9SSuyGa8p4OibJxhdhUcr6wg2
         qY1QYasTXpjazlU07jjJcOxluStQBMy/jWqorkQMSocT0i6rjN4y8tyOSV2SR2dC0SXS
         hMiRddeHPFvl12HR1kxZAwGhWDnn+klXCDUe2ctbriydlxCasnbxhPwk+cTzkK0H7RR+
         j07wPLm9afZw/J2AeTuXeA3cmMBPToaS71p0AZ5MZ21oZTexkFPi9JRM6ewpEuS5uXa2
         1e6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187490; x=1785792290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t0HucSFNwCrhhqVsgsZLRy5u6x5BGWTlUoNlDXYASAs=;
        b=HKxPzHEPmrM/UWRiOTIDBYDzX1mn4Q+yylb8oRKJP/6jHY5hPholmJHde8vJe69VJZ
         vHhCN7hxUoh+Fzh1u0L4U9p/LIL460AfV4oEG2L/dYruMZYOZyFCOtFOf8QTh07zd24e
         a458aoAP2wor91ei1KoVVGAMlvW42NkJJMA5sTk8wR85fP5kzAILNUouH2+W2WXBBIPT
         ssFfaXNNMQE9wDyU9iHV+nes3CV9a3RvsG+hFiyIi9wxUr7pkwF3quWDJRJvHYuK/HwS
         IUAs/+kk6v//t9Jj2rV6fJhY4pD5XVSwa88LUPwz49UdJqiOaejQGPDfFT9IAnP2CJCT
         LigQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYJ1llRkOqgTqxjDDoQZs0TERKXEKDsghr/yUzWY+rTdjrh/gYjv6fhe1vtg4fZdCfHwdOGFlaIQify3cd@vger.kernel.org
X-Gm-Message-State: AOJu0YzPwuODUckifjsh405mTzaD3dPlV63f/XJzwnXG/Y5cYv6xY8kp
	sW5oVo0X8OTAYmU3aGFOPfwBOsiEidnOuByxgQDwq4yzHohyAbW46Fjy
X-Gm-Gg: AR+sD12pZa6DIBsMZ9d1nHcyPJe620USezNVMlRGlpEDQAgWWBPw4hOjXLEfqWo/9vw
	qAGq6s7gKsBCgVFCI8chZKV23XSXhcVcaQs6npNe2Ef9t6QTnyX6EswktPrCx2SpIwuqsNlLUL2
	FmVfkWdUtT2v0qJCu2V5mL/H+SvGrQ4+1N9RY3ZjQQNkLdP4axvUJzEXyzTOMOtcw7IS4/YuzH+
	fh0cedmiG9XqR5baz61hnvyD2yKWyo4esCoG6lzp4PQhASwC/5w4fr/xn7imo0RxkmDM0WzElUq
	8y+RYiw5boWm1PQdhYwkgnmM3+eb3yN2wcsEk1ZrOGN6SPSIDSfIIkr6LEhVNY/QnfQYvYJgKHy
	OXH87yjtp+C8WWG0Ynd0dewYIMPWwsuYV1zXXM5R3laVzI0WaZPVJPlEsw9kaWFD5nAUfGyyN3X
	+V1SnAEfVV5MgM1Ij2BpaV6sXkoAxH9090lT2+WE+Kf0RhtJo4ysTGWg==
X-Received: by 2002:a17:902:e5c6:b0:2ca:d7a0:1312 with SMTP id d9443c01a7336-2cfde85f826mr100366845ad.25.1785187489988;
        Mon, 27 Jul 2026 14:24:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7bbdf6sm40458485ad.52.2026.07.27.14.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:24:49 -0700 (PDT)
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
Subject: [PATCH v4 11/21] zonefs: convert iomap ops to ->iomap_next()
Date: Mon, 27 Jul 2026 14:17:48 -0700
Message-ID: <20260727211758.1116539-12-joannelkoong@gmail.com>
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

Convert zonefs iomap_ops to the new ->iomap_next() callback. Each
callback is generated with the DEFINE_IOMAP_ITER_NEXT() macro, which
wraps the iomap_iter_next() helper to finish the previous mapping if
needed and produce the next one. No functional changes are intended.

Acked-by: Damien Le Moal <dlemoal@kernel.org>
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

