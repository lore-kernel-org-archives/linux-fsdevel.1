Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9BC2EA
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785298630; cv=none; b=YbMRZqsnuizPVAbOPta8T8KGSdBTgtj/hhpaPhQdEXhBNIwPZ/lk4gni3UPAQPwkvSdzUDRrqSFC+DZsz55VZfCk2DxyhYmVUlio0qDR9V/c7BL7pEgXX4sxulba3aJdL/pbLabnt/8YUZAIbYsZdKYN0+PEXdZEJvR3gb8qXH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785298630; c=relaxed/simple;
	bh=+f93yqpB0vWTCoxVOTnikZ42TYA/9hQHZf7/f9OTlIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQRF7NFd9fKimNjZhD5T6ri4RYcmzRNsoe9OCxiAqpB9TqCYbbr1KHZJw/ePHqW5Ffu29EpE7pph5721YZdKtPIJAdnDGKVfYbvSAv1kxdLZmjpdh7W1ehgYn9oCO19lQP6oHo1zh2TbDItUGJwieQpCjZaHXniIK/U8A/rkVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHmN7dIu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHmN7dIu"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso6141455ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 21:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785298628; x=1785903428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cfXUKL6KEgJ9xC0lbVLlHmoRQoa/+Lwi/4872gF1r5g=;
        b=CHmN7dIuuj2RMBWlN5fJVKLsAU+WCRSyPb2BPtKwo3Z4W3hbypnRGMa3vw+0BmQu4e
         L4HyTt3RPKqHVioyJ803CW4pIWLusrfUCDhBBc6zjndNrPNiMJy+LeUrEVhJraJk8nBV
         qFCxam0irIJ1h2S8AFf20uMuFd0XvtanKoxK+ztMZsmRIk5PAqGjJ7vX9dlXvnh0EJgd
         EFB1/THElzwd461P2wCg62Ny83P7EPcIwLqBJrRIKT1M5/nxYBDRqLM8RA4VfUtzZhgC
         Hb3RS0jbWk1FpfT0sAdqJAR2hEvlOn/W8WiZAiiTVa9vpnHL3nP7GiJCHMh/rtU6pthe
         5aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785298628; x=1785903428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cfXUKL6KEgJ9xC0lbVLlHmoRQoa/+Lwi/4872gF1r5g=;
        b=KMoZ1XrrAQSDnxlzrs6e/4L6Vs80dzkr06DaRwcRn+M6WThz804Tq0wY797Ic/o5MS
         fBGoUK5flIQ8UeRrQi1poG6Mv9g5bbjlRYQIkUsDgu+kpyq4/GUj9972pPWwHJkq49jY
         L+fJYgpDLnlTQ+L710B7iFB3Bt1A/hUmXqlBuxsB8D75e1ZodhC4w6L5nD2/yJQqCfNI
         4Fhq4xhqvZbaHhSTa3yRmfRLNv/cyeBauXyWfmNtOGIrvMPk/GIkmYeCQo63KNdeDs8M
         iJ9zWgz5qeaiKzOvvOgjpwhJCfnwF8ZDHDTgXprqUB9jD4i6p9V3sXEJpneoQpXqPMmz
         IZLQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsVIDrZr0dPlebWvZNe6m1dQVFilH//mc7cIap9Y6vEr2aOCxEc5fTi2c0mBCACF870PooC8Xv+qjnGPH4@vger.kernel.org
X-Gm-Message-State: AOJu0YwuCNooR1GgoR0SKEKBEOBLCrIFWNY8GqZIsmNFeKxdyTbEV8Lc
	lDimavDc2Tm6PrP/4Fxt/VfC0WfqqSyd7tLArrb5WcnyqnsgaSe58S8=
X-Gm-Gg: AR+sD12lKyHXIJKoLHlIzWNJKSq1pwJWe+wkovUFWphvhcEv/QbUGypXO82G479/rwR
	RPC/AR41uzKTYxf1krLu31zR/peGQZWsbCl0joj6qX4LgAVffKgH2IsrAPlulaHMS7ee+zusj0Z
	zVaYZl0ToY5r9IE5dprtvsEFTGfakHULzwYzYwt1i5o53O/KoFuZXORVMwDZT30vOgxbt+j+9Hh
	gCvdkS3cqdDKm2nzv1nQxXnWL1GHaybc0vs6gi4l4+Yop24lU4htpInlNogtj/AYzqgZnDYSRtU
	AJO9+qvobw2F99BkRGpIdXmx5gx8eWbXuNFdnHqHTE0j20y7RuVotsIZLKHSCFNWkIIHQILVAr5
	D3O3uC11gvKKaMK55sZicAsqf+vj08rGDDfZtU++vN9niO7Q2btUTBkFuYDzoyt3iimZn+bHrz7
	7P+OtNeqWdWAEnlO0o0ngwSArWVADo28yJZIbkP3bttyxdTE2+3q20ClQI29BRoRePR4YrwjdPb
	uDDU8eM1FtllZtPPKpbaxJYBX6Y3o9pBCKCQeOF
X-Received: by 2002:a05:6a21:2d43:b0:39f:59c8:f302 with SMTP id adf61e73a8af0-3c8ba5d0a12mr6192619637.37.1785298627978;
        Tue, 28 Jul 2026 21:17:07 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:88b0:bed0:1488:2a4e:85f:d739])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b6d14bsm4507589eec.10.2026.07.28.21.17.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 21:17:07 -0700 (PDT)
From: Rochan Avlur <rochan.avlur@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Rochan Avlur <rochan.avlur@gmail.com>
Subject: [PATCH] f2fs: use the mount idmap for the owner check in f2fs_xattr_advise_set()
Date: Tue, 28 Jul 2026 21:16:56 -0700
Message-ID: <20260729041656.51967-1-rochan.avlur@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs_xattr_advise_set() calls inode_owner_or_capable() with
&nop_mnt_idmap before allowing the advise xattr to be set, instead of
the idmap that was passed into the handler.

Since f2fs supports idmapped mounts, this compares the caller's fsuid
against the unmapped on-disk owner rather than the mapped owner; resulting
in the actual owner to be wrongly denied with -EPERM. Use the idmap
argument that was already passed to the xattr handler instead.

Fixes: 984fc4e76d63 ("f2fs: support idmapped mounts")
Cc: stable@vger.kernel.org
Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
---
 fs/f2fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 610d5810074d..281e2fd6c778 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -118,7 +118,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 	unsigned char old_advise = F2FS_I(inode)->i_advise;
 	unsigned char new_advise;
 
-	if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
+	if (!inode_owner_or_capable(idmap, inode))
 		return -EPERM;
 	if (value == NULL)
 		return -EINVAL;
-- 
2.45.2

