Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93D82D8796
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581373; cv=none; b=IchGsJRTtLjEqKFmBAIkUipPMhb9tP6ntmkHgo+XUzwGMMINhE3TkUcjVGFPKwmo5kCrQaXeKk6YuEOPjUAn7peV0opksQJ8Y8aZlEKv/XTLO9jNZ66u2vZHTAqgdu7XGYcqZ1OrXMy+NDGhmQ5thUn0Ygb1ck5262Upq414vNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581373; c=relaxed/simple;
	bh=hO9BVEVDVTibuJZMVYXFHe9ALsfmpCG5uaHtXvvyI3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcLAgF8OJtGd8wjIrcihcFG23G+aJP1HuTbVjc7ydlkHypNf6G7T5U8i/VO9T2qYwrjx1sgA+tkkGX7m7KGq2YA4ZaUJly+V+GOKatJkqCuwszHhHvXaQ4KCfdOyfbWpwgryjNEjif/U807pxK2+F3U0r/ZtzjPOYEvkJOGUFGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6lDVceP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6lDVceP"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso6636649a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581371; x=1785186171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3q4MaAeCWMLfgx1kYWaVbU8CF4qrvHugeV3unQvXGK8=;
        b=O6lDVcePMiMko97uBqSAjYQUwza2Z2ueDOfcvgyGONJxnfDwkLNyskgumSy44J4x7L
         SyBP0w9Siquz/IiLHziVDgETzF6l8iEsHuDupQogrobizPuJnLOfhNwTVJK6HfpKk02B
         qHQ2I7DdIxMQetRkYsxeL4LntEtaZ+sWKf5cn3adH6jahFf4PCq0xjcTeszwAr7G/K+i
         PS8vB8krnsPDmb8oNRyOsSjSWwKH0jEUnkE2n19yOCsX+YYuvQz2Ui69NNG173H4Jxag
         uZXCuwmKz58W1KEWxz6Mhgc7aIkK4LLYfmc6wA5TP3p71WZbg+ujGFecrh+mBHVJfxZj
         uUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581371; x=1785186171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3q4MaAeCWMLfgx1kYWaVbU8CF4qrvHugeV3unQvXGK8=;
        b=V6cSjJH2LIf/GuYGG0+btLaej5qu0Bkgy4SqIW4g5SfM2OXQoLjQWgTub1ddtTKLFy
         lkdcUHr2mvPMWKR8YpF6wxkLzulzG6AavNZ70LLW4yZeAkIznxVuXsQTohAcp/atngZw
         ERhTZ0vzmCCfDvqHpcp8DTR3NsZBkXVozkohVEsI26L16Yu/PxzlUSe1HwhtpNHlJZu3
         8Wdv591rMadSd8VbkhwcDmkbGaP39WqyaxqFfUWysZ2ozJCMDX74AbgYWgRSCsMtlkUZ
         jVR6SqZnnWuqX7mkPKLxt8iFYsOeO2Va1ADRCY63D7xfodtJoDyciw556GAErVKSRwNd
         VApA==
X-Forwarded-Encrypted: i=1; AHgh+RqVe3UUsqp29CuUy7dL5MfT/RcdnorLJv20ULhbEMHOCk3c+m7s3wQSPvaV078QYE9DhIYNefSfRaD/vRY6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa3qWtqVR2H0gZS1OUFQNbqZDv4wXfQcPd5OZX8Tj+9LEXEjGx
	xFMmQqXzY++p0NamqlDowYwAEqGlOuTKFjtaQ2o88n/WTQ+Q0cZ/vp0d
X-Gm-Gg: AR+sD12IAWRbKNQPD9bYdGsES6b7R2uFpeyfjGOSN+jL0lNIplbSrtm4VO/kWzJCB7X
	+W84VT2UDhRbhdHXonOA1f8zslERU1P1maJ5RBRwkZMx7Uf5wircENyRJT6Oyb6mfcasHlYoZyA
	R+FvxFNo6slmBlNvh/xlMrGIoZemRR4TCUlFBEPhjH5dSeaZ9u9wcA3jmw9RyN0n9OICnviCn/U
	tW/CcwH8IR6LMqHfRzUSI9o+IhV2AfHfuV4FoI/FuEsxWMwx5IfoH7ikYwqPg0j9oI4phnEt/IO
	lsH5iKJI+eJfupENc5CutiEMqBnNmi3Q07Q9wRMPomPfbP3Y+Ay5CjYsi5RmPbnD2PhxxMTz5fO
	3BI0oKuvh08PneDgHNe5aeJeF6MpAvVC49ubR1l3ppfjH0GlnH+AXsH4O70l1IlshUIY3avSaY1
	QEq3GqVJz02utW6rTS9HZvXLxHyFiB43Tvsr+4sWIf1oTAeup5npwoA1XRrUsTRYJ9
X-Received: by 2002:a17:90b:2c84:b0:381:3b5d:30f4 with SMTP id 98e67ed59e1d1-38e4b422c19mr16180544a91.1.1784581371265;
        Mon, 20 Jul 2026 14:02:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e923006e2sm293383a91.3.2026.07.20.14.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:50 -0700 (PDT)
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
Subject: [PATCH v3 17/20] exfat: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:59 -0700
Message-ID: <20260720210202.1163861-18-joannelkoong@gmail.com>
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

Convert exfat iomap_ops to the new ->iomap_next() callback. Each
callback is generated with the DEFINE_IOMAP_ITER_NEXT() and
DEFINE_IOMAP_ITER_NEXT_END() macros, which wrap the iomap_iter_next()
helper to finish the previous mapping if needed and produce the next
one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/exfat/iomap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 1aac38e63fe6..b6dd396aa60a 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -151,8 +151,10 @@ static int exfat_write_iomap_begin(struct inode *inode, loff_t offset, loff_t le
 	return __exfat_iomap_begin(inode, offset, length, flags, iomap, true);
 }
 
+static DEFINE_IOMAP_ITER_NEXT(exfat_iomap_next, exfat_iomap_begin);
+
 const struct iomap_ops exfat_iomap_ops = {
-	.iomap_begin = exfat_iomap_begin,
+	.iomap_next = exfat_iomap_next,
 };
 
 /*
@@ -186,9 +188,11 @@ static int exfat_write_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return written;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(exfat_write_iomap_next,
+		exfat_write_iomap_begin, exfat_write_iomap_end);
+
 const struct iomap_ops exfat_write_iomap_ops = {
-	.iomap_begin	= exfat_write_iomap_begin,
-	.iomap_end	= exfat_write_iomap_end,
+	.iomap_next	= exfat_write_iomap_next,
 };
 
 /*
-- 
2.52.0

