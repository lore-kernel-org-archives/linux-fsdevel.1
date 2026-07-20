Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10B8315D43
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581344; cv=none; b=BQ6Qt9Plx/QKJpi0fxrQnBrVIaiGZF2aAg00guX8Pohx7PUbAzGfkMsSuC7AM5FteDApybgdfEQWhE2/fGeTMUy3fKzZEPtDNP/+usShEkAtQA9x42i3SZzhXIR7vgQrMzX48HYhuQgVvC29PTvgwyQJwZwRilZstvlK56VSJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581344; c=relaxed/simple;
	bh=uX6UTSIosPSfjXfEToRIKKLdnGQ8+uvn2Zhf6+AzVMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdMRp15iK0gGbOzDLYWOCmlpNJqh6FWxfK0TFIqVz5ancBMLwFQqNm2C7/cBPGX74i3Vs8Lsg14O9MGHoFFeyiaB8WfJZvJSjWyN3gLbFl83jbJcUfLhTlu60mgabxXASmZheajI1xfuWlaIlzhnnwwiUq73tp5pssQZasLNlJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyIg3OQv; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyIg3OQv"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso7413346a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581342; x=1785186142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrifaDueWyvXqKv3qan5Xo6mvpZ9taRZWXeie0uWK78=;
        b=QyIg3OQvTAsDet8ngEbav69Y1tKzX2cfhEaV7SCWDZ0quOwR4dp8hwg0MUnTPoiLG/
         bwcjzib28TrQq8rnfzDH28WA34hZfsw9utQsqpvzvsgOy710zBcdVVQ21O9GkJFfJGqg
         3j8YBZwRLfv+z777xRyIQOa1dNV0fO2bPPDbOpDtvWdZ7KCvriRhoLbh/L5hqhaQZAeg
         fI0yLpCgIYGdtEsDjWo7G1i/tyTfvwf/AfOl3G+SbhjMdPnZOww40bU/XYIcX0iGBGsG
         XXThMCYjPBYU64wsgUOtG5RqfJ/xSF7Zf4nECXpgx1TiG5++NLZ1c4OvQR3bj64z8TQw
         r8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581342; x=1785186142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrifaDueWyvXqKv3qan5Xo6mvpZ9taRZWXeie0uWK78=;
        b=OeNfwM4WCIY8OC4t+bGRDwY/UjNZQaWXiv9fVggwNutGw0hvEKEEUMJPBVP5761yl0
         6qTx8WoGVTYqvTSQPzft1eDcAAB1vpgEszUx7pZHPYkyzfEuADepUbUNpWxD8D8GcGa7
         V1PKkVgOvcOu3sqlMy9VIGp2l9zIBs93Z7Zp+niSR5J8uXLVFd9QfuQpJ3OR3Rqk/6He
         PKEz3XBn+6P+zjQ4VKYTqHQ2z2W9EUh8XLRlUArNR90a2PdH/PDM8SsdSftQw46X+1WD
         Q0N7tI4r+Rh4jH5Yh09t61GF3uwEs+4qOvr/Y9Q6/vTklG1Pu8oJDYgV7Ue5LC3xXach
         CgIw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4fZn7cktW1hdHEXOiYi73umDbmITCIPFHh6D2Q8wiB84nS7hsQwgoc80LmYteDwRj3l0Sg/gfeogpo1QN@vger.kernel.org
X-Gm-Message-State: AOJu0YyibSldKZYEl8rV8DmMfO5X5jzA6fE2d6pM5TBUF+lIaQ3W/7+r
	Bxx0ivTRq3n43YxeaThbIOay8CqOdAigJ92R7VYQpr4cNosKPY5QrQFs
X-Gm-Gg: AR+sD11b380zX6UIKPj7CbTeT7rMPKpG6qsevCJgR3KQZsf3qbktvPztey15MkJBuLw
	gnohAZtsd01cVmTzWFFzQmrPYaeImRltgX+lNPWXCwaHEih225kHt5ngq+Uas3OSVzVkEl7bKLH
	WgMbseV6nsZ/lGKq8z2/aJF69XDl+oS2figUzCYmpvJs73vxfQTPwxpGjSFz6TR/UvxMzrIODSZ
	YEcgWJhm428mT44HbFKNaYM1tdpx/m4jnwMI7fIzwqrJOzn3WtappKfjw2yrhj7ifjQaRxPwhWr
	53YXIxpIFx0+3sYpv6H1lA9vtU0TDhSnMWzVWXWMQ6pNLtlUJLSVEcEHRiZ95Tt6ogJ+gO5MQ6g
	z3lMDLN0ao8dXCV/pac+d+RM2GtNJHTKe8N71AK+9ZZ9q4CDOD2+cKGvH2QVDpbgbgI2XCcRLBH
	qx0ZCuIsjf+t9+x3EyxEo8U1DHHcHgqhjGBHVQ5urHU9XAjG08fH9l
X-Received: by 2002:a17:90b:58a8:b0:380:9504:9780 with SMTP id 98e67ed59e1d1-38e4b562810mr10521245a91.29.1784581342023;
        Mon, 20 Jul 2026 14:02:22 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e923006e2sm292924a91.3.2026.07.20.14.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:21 -0700 (PDT)
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
Subject: [PATCH v3 05/20] btrfs: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:47 -0700
Message-ID: <20260720210202.1163861-6-joannelkoong@gmail.com>
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

Convert btrfs iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT_END() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

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

