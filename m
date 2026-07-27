Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB934322F8
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187500; cv=none; b=XR+QuAsVwhPBsBGLfOK7JNLiYvwPL91y4L/fYNLuNmFMsDSWBz3+kUpdj0dUEZkfRaZFJpekAN/7iuAJgmVwQLOLmllBuxBbE61a6TshIxrM5hHfZbSWd8HL/JsGUjT2nr2DqY+14me79FA9gSAkc5kmlGwOTdZqKpQpcPNoYQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187500; c=relaxed/simple;
	bh=HHxOrJYOsxXujbtNOZYiKxqT98cJWgSli6XX9Kw9VZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXRCUNfXwZncypnZ4oJiLOcTnM6Mv69p7a5HazjTW86k4WLaN1+pFsZ4EjzbRKDbnifTg+Hm1GbpW/qQDmEyQgtEviY+pCDTGUY6UAgc/YQG2h+W0xkaWh48pA74qfuunuKkPtHQwObBKkrkmTe6qs/W5Pdd6VoWkEDURiX+e2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHN0newo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHN0newo"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caed617615so33021425ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187498; x=1785792298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t0Y5kYgnq47GiPzAl5xZ9gQOM4CGwKa3ZKYndZjd3EM=;
        b=IHN0newo77L8e/SVfqvpElYI10zdL2Nn80KS7kUZ2NljqU26OSC7r9eGXdU4a+EBJn
         BqP4G5qxxyeb2q+V2EltZrv9/OWlZoppETN8UBjZCwv6I8dSykUP+c+oNVImElqXXSDe
         +Zv0G2oFAJ2uUMaFNuebx0iz8Zcp+sE9sL+Vfgg6VQVlUFwKbF3kM1RZO+J6BlQocfcB
         sJpt0R98dOh1WxlHbZ4NdZFXNjPoIox3jlNXRkI8wr5vWvZAvNRVfKjJUJNbJXZUCtX+
         g3uxJitFlpURw8mdg95jNYXIWkHxOWukoUn76/dUdqMxrgpBOfQMCDvFHRCWHFo/KRKW
         KRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187498; x=1785792298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t0Y5kYgnq47GiPzAl5xZ9gQOM4CGwKa3ZKYndZjd3EM=;
        b=q4ErSK5hrDbTdCtNHZeKMR0b4YcJv6lSXXI69jZYbqFJZMXD9NZmRh0lIRGD72Db8O
         TGGNM6/O3iW6RbRkaY6dO3CnyZ5ujlisrduiffIzZte1kRJhn6KAEKH/o1QOnyq+5cUa
         5dpUOwhhpVk+rOOeXUk5bBa0CVlMrvjqG8SJ8W6jmOdzpyagS0PYP403uoUYmiKZpoe+
         vxLvs2Q0AOuRV4WsbSRsqcoaj/Kwjo5yWAIs+3KQtYJayAnn2uhuHT1tDx8hwnsY7wU+
         NSGVu6mPOElAeQlfCasD3uhLwbqz77C0RRM2maOmquj1EcF/j5gcq7Rugv0Lfw2wq7wp
         kq2Q==
X-Forwarded-Encrypted: i=1; AHgh+RoLJrg7IWzRvTomTluGsExHcWwfohsoBZ31akSpooPvscuSBMVbBZg/DB8jy/aqN2C5AD1XAceFy+Fa79XP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9e0I+xMeerZGhjdfW8E3XcO4z1JnPwoK9ygBfTtXUwVN3Djh2
	MqQSHnK1llZJWVpzkyTPMc9BZgJTHvDxDXn+P0eAojILt7nizNtYgcAp
X-Gm-Gg: AR+sD106ml0ErdmhW0MFVmJk65H9J8ZtHJw4DhxMuVpF9JGmvYdhPszMJbFebCeJSIG
	6/ZzQgLG07tqnE0nG4VM+/hztHWNhyHqkbwiRFAmyktO9Q5wAZrTcJEWlC/FOT43hEVOozUSb0o
	TZulOMAiHvueV/1egglmIQNGcu1yhjMTU/fP9QZBLSMcIZfWgmn9kAmKAe6T/s2QXZztG/Mma4L
	6pUmZwKHDwA+3t7jAH0RO/4SFat2lecBdukm4x6w0o2ntIhdy9nggL3D/4AOmdtezR7pQ5epK7m
	T54Agy1icy07tTorbThoMav8Ke+ijxksvGHdd88VcOAc2v969M+1hVD6mHluwbs+IE4VDrHweR/
	6nG4TkS6gkcDoPcdOMGK58iqszfhDlupO5z3i20oo9I52pqWqfyAVTbgRY4j2NNJ4V8PpaD70u9
	1I0ePzaLqnfemh9dzzbYIA+IVAnfkK6dmQhAYhvxUY3WEtJQDtmWSe2Q==
X-Received: by 2002:a17:902:ce8e:b0:2ca:e3f:6a4a with SMTP id d9443c01a7336-2d00f337248mr8663625ad.21.1785187498085;
        Mon, 27 Jul 2026 14:24:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bc5asm40856345ad.6.2026.07.27.14.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:24:57 -0700 (PDT)
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
Subject: [PATCH v4 15/21] gfs2: convert iomap ops to ->iomap_next()
Date: Mon, 27 Jul 2026 14:17:52 -0700
Message-ID: <20260727211758.1116539-16-joannelkoong@gmail.com>
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

Convert gfs2 iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT_END() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/gfs2/bmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 51ac1fd44f78..73c626971163 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1200,9 +1200,11 @@ static int gfs2_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(gfs2_iomap_next, gfs2_iomap_begin,
+				  gfs2_iomap_end);
+
 const struct iomap_ops gfs2_iomap_ops = {
-	.iomap_begin = gfs2_iomap_begin,
-	.iomap_end = gfs2_iomap_end,
+	.iomap_next = gfs2_iomap_next,
 };
 
 /**
-- 
2.52.0

