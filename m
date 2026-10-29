Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270367;
	b=I9DErNB1Bhu1DOnsgNEbpklvEANsFMumxv4gOJBYOy+jB67NSaeRMYCKDUFslS9SImCE
	 s/tOQuqGmxfGReY+CRQpwLlfkSuxDFSn48JEpjOacI2fIEHXUO/9jaUFDNjgaUsUg+JJ1
	 E4VHK1KO0XUc08oxzKfnnsRO0MRPL1vY7mOxMd3LZWc/6wKpTBGN7RwSp2MGemkCCtkMS
	 jYvOKYxbIDSt/FMFOq61TA77+5BgxOsktpuBxd0R7JjWGpPhr7stisqTpzglAQCkn62/b
	 HBDzr9eCbAuLPFDLgbgsQ8daAmeRvGh27HxVcVUX81h3m5yVpn/AKQqif+fq5Ijs+CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gWikJcHMy/FGJ+Cip1xhfQi9ECC0Fi/XHUzFD+d9ZqY=;
	b=fWchgCRweSVKj++FPcLxiBySlzDx87oRuYe9s7zBRj6c7PuoMVYWCEkGc9/9c0Fc+IqA
	 wLahws2biIZc8y/axrDnjvjYtZJgTBaOEcJHSG8IananbHbM4JOWfS7QKWFb4OYSLMCNQ
	 m9jKI8df/MY+YN4RwcoQ8CCndpGOGf9DAwf54iPtgSt/ijE9/Mf00Zm6IfosnuC8/0aGT
	 9QQkM63gUbt/cw4qpiOMw22uFHqux3+umkWqPU7f38tMwJeglDDm9Ez2YCdWIB0gx0Sma
	 Nk2RdBs047DvTVCnLiZcOpZzcVNzRAFV4K0RkDI7jrpVkDNin7rh1uSVWltdwgpxrKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bZ0w/NtB";
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D018C60A260C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:39:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D018C60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ0w/NtB
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c468bd799ecso254808466b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270365; x=1793875165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWikJcHMy/FGJ+Cip1xhfQi9ECC0Fi/XHUzFD+d9ZqY=;
        b=bZ0w/NtBO1ZzNLjjNaLIkKRzCia1nz8IsPEYwvQoziTJw9T7LeTs3MtV8kiRJP7gSB
         OURibTMjZIDguMBcps6byDm57+Kr5kC6RXCeGNw5Ey6LnrZNwU+XzFh2ERdcEtSHLAJn
         3TouxcRwdk6vxRv1Hzkg6b27ZHDk4gvq+1g+8dFCPlV6oy51ti9sb5ondZ/eI2GIh1c4
         tuHSA1/5SqRBUJqe+aM62Cuj1bhSxNWh1VAHibHRhtH8dzZEMxCu9XClawK3iRb3BjCV
         40ZrRduc4p6Q4BPwJmcg1mlb9Xa1NF6CzfsCNwkFjBGs9I0GPX8d9SEMJPpTS74Xwh/H
         IZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270365; x=1793875165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gWikJcHMy/FGJ+Cip1xhfQi9ECC0Fi/XHUzFD+d9ZqY=;
        b=bMFSXG0u2ZcaSEWgDuYQa/pzrkieVuSAUNl6XUKd5xcKEZGzBU2J4mQbSIbYqGkswq
         VgknxQBHgWEqAjVKhZ6TB5luDJSpJn6ya7ZsO7EyMuhvO6/eH24nJidfXGRyl3v0O9qr
         5L161hOSzGAIQsMKi6MQy7kaaYu/yPz/rjXMGnkS0DomLjixIbsmmApefk5GPtUt0HLr
         Y6UJP7VcJFa8Ta63BL1GobN2tTBjHkGcW9iYmM+ytP4l5ZuT5hhN6KwL9Wn6tEGKowNv
         0O/xvwyxm2Ar/US0PIvRmOXQw7W5S85jXfMyyv+R9W9GZgvWpcJQEVWhOmy3WXYbzrUL
         xVww==
X-Gm-Message-State: AFq9FYJvhMesR2i8VLSObd7MInnCeBV5/DHbJ5bmZdzpebmKWyft10OL
	uNreyAJBsI8LCnXXZk48jWFiDg9Hh8vFpIPu4gl3PbqCel/sWG9OVWW2
X-Gm-Gg: AYBFou3sPo1g+bNzSenABVrEMIG1d97WeyKBOpf0ZRerepSWYRgtrNhJwCeQMpAQ5up
	8oVtXEB6appwwhMr8EX/cS20ioCU50yXUIGcg9a7I28cqZvBQdMOwRPcG4DJQSzehBfwFZX0sAJ
	WwHQItZtH2XYvRdurx1B4GnyfD62Gnk1pvx4iYal5Ph883HD61hWct6JCtLRgL40W/81oe8E1FV
	ncpc0ZNeJ0fKtQP54dhHyGrti3WJCh3qujtQJqpqunJcTUmmvE14q+Y4kbY2UO9yLLULJW+GaaT
	TZ3ZM/fdl2UnIi523tg2oWGIOSjNegnRYPigYxX31HLQHXp6PaGZkKo4fq/8BykuMYgZ3IHi/4o
	IJxSMF580hhj3RZE3HnWovt2R/i0uhltziFGkfWsnvi+Wc49yiuqlQgU2Fh0kb2Fv5a54pDF1Dp
	JnbpXYXuWfop7xr0tAMSISAWMWyvA+UHpsgD9fH6unz/IDtj0WurHRcOnwUEOjVL8uv7JwM0RVz
	k9yWxoLOVhEtKEC20TAWKy73u1AmsQwzJqIqnMOAr8zNibSj+VRIp8MfnzR6OJO/2kwmYiu5ZAF
	98sozR4dhsao0fx9G5zYXMYTAW3Uch8xM+ddwij68xAj6I3s0eYvzM0SeIjS7Gs3qzkU2xIxA+v
	CpWDKvLZkdYCZZwYvS2O6GbhVFW0nLzcV
X-Received: by 2002:a17:906:eec8:b0:c46:8c2b:8f7e with SMTP id a640c23a62f3a-c49bd9e322amr444578866b.0.1793270365070;
        Thu, 29 Oct 2026 03:39:25 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49a530f520sm391847266b.23.2026.10.29.03.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:24 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 09/16] ovl: use the pinned upper dir in ovl_fix_origin()
Date: Thu, 29 Oct 2026 11:39:13 +0100
Message-ID: <20261029103913.2785828-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
References: <20261029103913.2785828-1-amir73il@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

Renames made directly on the upper filesystem during a lookup crash the
kernel.

A dentry that is passed to vfs_setxattr() must be pinned.
ovl_fix_origin() passes upper->d_parent to ovl_set_impure() without a
reference, and the lookup holds no lock of the upper directory. A
rename on the upper filesystem changes d_parent, and only the child
pins the new parent, so a second rename and an rmdir free it.

With delays in ovl_fix_origin() and ovl_set_impure(), renaming the upper
directory twice and removing the intermediate parent during the lookup
of a merge directory without an origin xattr gave a KASAN
use-after-free in vfs_setxattr().

Fix this by passing the upper dentry that the overlay parent holds.

Fixes: 9678e6303057 ("ovl: fix inconsistent d_ino for legacy merge dir")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: add helper ovl_set_impure_dir()]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/namei.c     | 6 ++++--
 fs/overlayfs/overlayfs.h | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index ca899fdfaafd2..cf7908a39f614 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -942,8 +942,10 @@ static int ovl_fix_origin(struct ovl_fs *ofs, struct dentry *dentry,
 		goto out;
 
 	err = ovl_set_origin_fh(ofs, fh, upper);
-	if (!err)
-		err = ovl_set_impure(dentry->d_parent, upper->d_parent);
+	if (!err) {
+		/* upper->d_parent is not stable, use the overlay parent */
+		err = ovl_set_impure_dir(dentry->d_parent);
+	}
 
 	ovl_drop_write(dentry);
 out:
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 7f3558372c599..c89739e5338b4 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -572,6 +572,12 @@ int ovl_check_setxattr(struct ovl_fs *ofs, struct dentry *upperdentry,
 		       enum ovl_xattr ox, const void *value, size_t size,
 		       int xerr);
 int ovl_set_impure(struct dentry *dentry, struct dentry *upperdentry);
+
+static inline int ovl_set_impure_dir(struct dentry *dentry)
+{
+	return ovl_set_impure(dentry, ovl_dentry_upper(dentry));
+}
+
 bool ovl_inuse_trylock(struct dentry *dentry);
 void ovl_inuse_unlock(struct dentry *dentry);
 bool ovl_is_inuse(struct dentry *dentry);
-- 
2.55.0

