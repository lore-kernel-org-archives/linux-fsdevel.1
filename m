Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972237;
	b=yZykPuFI7LrIZOzJxI6IV6VcudnejGWd0fqdE6iY1XZTa6MxtN0HXt6sULUtrEVuNXJ3
	 e+FB0ChHANN72+u+T9BibwqjwgdZ9mkikJm9mxeVGMNZuiChplPegsgMJcKcXFjpQPQLf
	 YJZN4WzocJIDhbNMCEfNCdhz0RY2yqvAc71YxbUi3pW0JUN/szEnSVpS1XXwuMNpKXJ39
	 WlFvC5zEVUUoScBBKVw1Gx5O+3vs19oy6PkF9Gl3tCy5zRAe11R3aiY46dQN1sRgAR3sS
	 17RD3AVNBBXq+LWbQROQfsPgtvIL5et1uLx0FnkJG4OleEil575Wozg1IVyZY9m3t8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=aoZSxD+M4Ix3Nzdinv/kkvM8PFIKv0qH9kj5OB/mLsY=;
	b=Bo40oKp9ST4aG1e96jtRNFww+Dk7XxQ84lHAqHbB5elfCOGqJMeHf+PiNOlwccGS7Ipn
	 KRrURbZnWst1uzNmR893X3ftccYOFcvGNFU3V7ryFXZ3S+yhSchlLBlfGU8qP5GdKXkpM
	 PlTT3YrrPIv5PojfCNC7n2sIUMx3oNrf3NahfFKw9+4m5zefbDTOg/30ln5lbb2OvucYo
	 PM+Q0UWhwfMHaWthVIW+AjSkQmpUz0k8IZfF1qPLPtvXE0+RDgypgOYzz7mo6IifZJDt3
	 eubB7UC6ubPQcbkBbcvQ40ZNp3hTaK8ZR8dIAQbyXaDJNoRU2l6RJJA9UuO00z/Pz7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EOIY1qX1;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC56C606D804
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 13:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC56C606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=EOIY1qX1
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5365d26ccbdso7256231cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 05:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793972224; x=1794577024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoZSxD+M4Ix3Nzdinv/kkvM8PFIKv0qH9kj5OB/mLsY=;
        b=EOIY1qX11hRw/xhofNwHlde2BW/gZLNG3g5NViKPdF1DRopQ3uBRzoHHVhKT3WajUH
         KVYMTVmFKwzIz6G61stuPke7PQoM5t1gNsJwSAXv5UTdbxfaG2AO0hP4P1h43giIqeAo
         g0VjMJkPgi81+pBH+ASezpiosfKAmjNE/CsMfCc8JqOBZas4To0n5f9YPlgWTv4O4JZT
         43xq86Zqz6sY+2ca/UaZLXFkFdAFBpKeM5xKTanQ7exkblvfSz9cIvty7ZQB4vZSUPKZ
         CZ/5+0dRSgwbKPJ5UG9kL6wEW4m289TokPmy3P6rXypzzOuNYEmKa3VxcPF8lhaeFB4W
         l+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793972224; x=1794577024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoZSxD+M4Ix3Nzdinv/kkvM8PFIKv0qH9kj5OB/mLsY=;
        b=D1YUi8y8/TV9yKxTIelIG2oHfiwtsJ8AexqM1HCzNnaOLJPOEoP2Qm7B1pf7zGGlZ2
         P1xfedhPmUpYCjGNVCENujrwQIwiM/87Ykxo70KgeUNtzkbssQNF80RYr0gaNXEBJfF6
         Kh4p5YEaVu1QLyjN93ZfvdAhAnyGeV06+FzslG0U3cTn8XA17T0hMo/2diVYXgG9BVzD
         ynXWzq37LA2EP/bZOpo8wvRvj2mZOoTWGpckTB+yMS+KrIQDNy1WPWJpH/53pbWDdXJk
         yKh++gdGxMiH/prmiDPogxeu28X8h0p7MlNcBcbsR2Sxv9CHbkzyYuwdiAmL/gXhDg13
         FgrQ==
X-Forwarded-Encrypted: i=1; AKwUvBx06H5D9h9FDD9fb/vUJMgJkdtk84c3SZ5zlrVbRXSXl+pSvJWLRKLr5vzHK4qUa6zBlNS77Ip9yA7syDlZ@vger.kernel.org
X-Gm-Message-State: APuU4Z/hWPx2RUIn3btp9l7FTxESGqAkK0qbaYZHecMlKcx0o1FYG2te
	In6n+pHWWLjjauqdtuPNjZYBvsFuUkT2UgaFJQnCQh4kAM8vTV1vQachaql+//6KCU0=
X-Gm-Gg: AYBFou0FGmLfLP5WgbQduKeWhFtPi09Esa7jGMzDgSmU3oKpGAsU0tUcy1isD60cA6E
	H05u5ymytifKVHjOU8PGXEWFIuzXgwJNXYDVm1/7pH5hZqTbxlndo4Ow+A4G78VjvZVeY8fTi7k
	yedfpVbnJjIIcWn5wJqghptenhLt+ij4BZ6nrqMHgzqnZEePPBey/6ZMN+qv5gsiy0t6vEaY5V9
	ypg3JBnVwvsnwmyDgR0xiuEWFjoPMCfQQwdho2oEGBSfiElQmiH9rboFP2HnlPeODYgP7JNUy4y
	3tgV6Dj0GITnc4dH1okk2BgKT5jyPZjPuFZMQ8T14zE88A4iIaEO9pakK3U/o3wF0Ji8cjDfkEV
	mAso58mGKik9s1a2L7CyxV/nzNtvnhEdke3bxj4Ng8kD4KpA6Ol01uMd6Okdy9lny1eWpPHz6JN
	maw2G79naSs7oDE90qr459TUKFvtHvhssUXtff5Tv2VAZeJvMoBess2Er31RgAs+ZCHSQ/szENd
	B3+umDWqXVXmn4hVxs1QngiazJ6935BHoCoOQgeldv9VC8u31DpwMCRe+ASRTGevrAcsEb0mcYt
	//rH44PtHgb7SHCmaVdcRv8Rj4B8HmDOmbbA2QLUO+soEg==
X-Received: by 2002:a05:622a:4117:b0:549:9438:8c47 with SMTP id d75a77b69052e-54e1309dec4mr38780521cf.23.1793972223702;
        Fri, 06 Nov 2026 05:37:03 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e270179f0sm20538911cf.26.2026.11.06.05.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:37:03 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 06 Nov 2026 13:36:45 +0000
Subject: [PATCH v4 3/8] ovl: make the root inode appear hashed
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-b4-ovl-containerized-sync-v4-3-6ddde0b7dd8a@toxicpanda.com>
References: <20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com>
In-Reply-To: <20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793972217; l=1088;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=b2F4eGdbpOMxJXXK78nupdaZI/TuEjSLWoRn4Q7cKAw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHJ31XEy6WjwNNRqX2i98eblVslKDYOiu+4N9/wDk2vVO6TSNHfrhlaeuyrPUhIhqIPg1Ru4EWt
 FHgpEiohP2gA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__mark_inode_dirty() does not put an unhashed inode on a dirty list, and
the root inode of an overlay is never hashed.  Use inode_fake_hash() on it,
so that the following patches can track it like any other overlay inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 22a8d4eb3b7c..9eb6a5e485ee 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1371,6 +1371,11 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_set_flag(OVL_WHITEOUTS, d_inode(root));
 	ovl_dentry_set_flag(OVL_E_CONNECTED, root);
 	ovl_set_upperdata(d_inode(root));
+	/*
+	 * Nobody looks the root up by its hash, but __mark_inode_dirty() only
+	 * puts hashed inodes on a dirty list.
+	 */
+	inode_fake_hash(d_inode(root));
 	ovl_inode_init(d_inode(root), &oip, ino, fsid);
 	WARN_ON(!!IS_CASEFOLDED(d_inode(root)) != ofs->casefold);
 	ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVALIDATE);

-- 
2.55.0

