Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270360;
	b=olBvhx/g0qknQWWcxTFideEAIXWgDxgDbDEtJqEghB2GxR3sq9/UgWzjeOXPeXhcC1Xe
	 m37ZMGWZvUX9wMxtPIq3QHfxikKxh6JhyViNMbYxtfZPcBn7SAUmZgp7i0rNkF6EkU/AR
	 em7HALrvjjsKX4eQSXIG2QZ8zT6xolKffg8oTUTVl3u65FrjWXuPyhLR/oiE8uy2qn7Tj
	 0h3MpN0crwaX8WxVf7ry7FVMvMinsIqskNcjqOwEAUV7SONZiRena9dlcx2kB7hp19/Xl
	 hOkGmdTj+dVhOmB/LbOPJg3COp92/+oHxh4Tb3+vBXImikg2p1AfAfgc6jRkS3RkW0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8cu0Twbd3w2gzcJmrd4ZCL+JhFNI2Ni02bPrZLMEiF0=;
	b=1VSO31Nlrpadzj0oDHieaj6ftV0H+1EtGARZELICScyihhRvfRCujOg3GOG9Smpy1xGr
	 Wu+oXlJqoRV38nwe2UGMmAmKKL9IyPDqGu26AopgmDy1vbZsFGKkHssDnk0Su+IWNnumH
	 wLwGJCV+z0s1ZnmxrzWP4TR1TTbKaOalxMwltpOENPS40YRHrsxYQRGMNvDAV9JMbFl6W
	 NEntkyL7SosXBgM3QTJNhoMN1HR3vkABG4zbZAq58eiRaG3qHyGv4Z79An42JqGO8qQdG
	 7sSZJNTxXupkZe8VkZJPLZnfYDtUgSwt86+7Yn9M29TVZvDwtAcWGKTEU8Zc91AojRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kJ3lHANV;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112460A2607
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0112460A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kJ3lHANV
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c43fbcb4393so310777266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270358; x=1793875158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8cu0Twbd3w2gzcJmrd4ZCL+JhFNI2Ni02bPrZLMEiF0=;
        b=kJ3lHANVAveBa9gqWIMXTMDDH4J+p34Yv9FPML+MzmSufck4xJ68ugS9dMf66QlKYu
         eQ1Kf3ZnNSkmWe9nFVCdAbJDOwmkCKj7K9O7haIWVmQo3ol3BlTmbuNooKShGljryjfm
         E2WEs0tZK0ylUSp72o9NcrKXuH/n/0afZ6yLQYQjL7hNoxImc2lrodWIYcfjzEptJyJm
         5fmot/hSmtHPr7Y97soS8deN2PXEf+Ef/J/EQgF2zDazdw9rJTuqg3HJhcqg4jTQcW6P
         /lou2aQVR+W9U6RFz2I1eQd1VodClxu92VUaVSRF0tSklEPRvE0J9xTRll6hGUqIE/qO
         4xeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270358; x=1793875158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8cu0Twbd3w2gzcJmrd4ZCL+JhFNI2Ni02bPrZLMEiF0=;
        b=2jErGTkzgEvNvGlzTm51KS14/q15CO0MUBCTKr63PYg0OIb/tTqS7AxkqGCNZv5gZ5
         tAHoZcG0BIX84INsOjsTOPzARDfhkjoExrXli9c5wg9/a041PpBHLVEvD1PZBQXIKVWV
         s+waXYFjRgTsL965Q4wCtkQroVw5JPPHTSoeN8WisGh9Lq3Q1zMsxa/4RVlhVrP1yhET
         /9v89jiNbmXWGLjwBsuC/9eF/tDTXZvW7JOhTlqKN1VOLYEpIQSu7igF9yD9Q9ToNJhV
         X4WFuZp9iYIosuTa6aRiWs+pc+z4ks8ZPfsHJyvOvBGIM4ZQD4q0vdGZ4rIyH71tlqQO
         qCaQ==
X-Gm-Message-State: AFq9FYLiAP7CkVrg+G4Skqsgu5tKjhOWlZdB5Qo645usSV1vJ44u2NiC
	wCObLc2vQ7IAbBi1T7jDkCUMPMq4Tl0wd6dejkEjOkA/pl6jwlCb0GKzymSYy/6O
X-Gm-Gg: AYBFou3I4FwmYmYyCPmssfQc9/mQ+nMZEefwbb+JRah+rTVSyXI7+A207s6W9daib2q
	zdAuIGMWGdGJzmjkIFEltIzrzwmeKdVuJfKWCF+zLWvPrvHibEiLVlPmPr1kZ199uHgC21bwBPk
	k+61t+T90u6cEXB7ZD6HkdHfx8z2kuajjtaPav4oAIEBcxsmTPCeNmTQzlSNTj1UfiV95g/6+Ij
	rp0L04grqy5Xq/XBSDORCK6zQlfdNBQqTy09NexkPjIzM+WM1wVp2cL0PaTNm3W7ejyrwQ05yek
	OBtzIUFqiTpYNPSt4ijz0+loZlxiJsHdg553/FrgzAYBAf8t0iJ7EOe8G0HmJrubWsr9hThvIiy
	UOB48kvGsvls3EWeuDYov4oslwV9xobnRULnAJSNJMxVG8s8969MWf9WqVpjDW3YBsUrqd8zJfM
	7ET9VElddjrTpS6aVWtv1fjw1ZLDQe4rk9hjW/g8Rvgk1RVTMhUPJOMNKY6Mjly2gKm6FInY2+V
	ZalW7zhOe/KMqTjb8emtavIApYsYlP9GBayYPSaxEy/K/nExG8Stg/1BlJ+cyHAEgtJpln7kCQ3
	YIj2VnAP6tznpoF/jyTjWgHtdGOD9qP//s238b27Fg2aVYA0+Cdu4g+4Xaa/ffTSQpd2woaibqm
	5Sx7pvKoiLbPRtbBNz7ACWDMnOC7t613Ang==
X-Received: by 2002:a17:907:962a:b0:c33:dbe8:291c with SMTP id a640c23a62f3a-c49bdf43b4bmr451277766b.20.1793270358157;
        Thu, 29 Oct 2026 03:39:18 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd34fa1asm719578366b.6.2026.10.29.03.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:17 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Fahad Alharbi <fahad@codepure.com>,
	stable@vger.kernel.org
Subject: [PATCH 02/16] ovl: fortify ovl_copy_xattr() against underlying layer modifications
Date: Thu, 29 Oct 2026 11:39:06 +0100
Message-ID: <20261029103913.2785828-3-amir73il@gmail.com>
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

Adapt ovl_getxattr_value() to be used from ovl_copy_xattr(), by
allowing to pass it a pre-allocated buffer, which can be resized
and by handling the ENODATA/EOPNOTSUPP return codes in the caller.

This replaces the retry loop in ovl_copy_xattr() with a single retry
after resizing the buffer. If the value changed again by then, the
underlying layer was modified, so return -EIO instead of retrying.

As a side effect, ovl_copy_up_meta_inode_data() now returns -EIO instead
of -ERANGE in this case of underlying xattr size changes.

Reported-by: Fahad Alharbi <fahad@codepure.com>
Tested-by: Fahad Alharbi <fahad@codepure.com>
Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Link: https://lore.kernel.org/linux-fsdevel/CAJfpegsVoUyqy0dYkTvBGRZvgdv_nmzmCw_uF+LP-Vq3EhEkSg@mail.gmail.com/
Fixes: e4ad29fa0d22 ("ovl: use a minimal buffer in ovl_copy_xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 68 ++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index c220cb5d0b70c..eee22581b14f1 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -72,6 +72,9 @@ static int ovl_copy_acl(struct ovl_fs *ofs, const struct path *path,
 	return err;
 }
 
+static ssize_t ovl_getxattr_value(const struct path *path, char *name,
+				  char **value, ssize_t *value_size);
+
 int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct dentry *new)
 {
 	struct dentry *old = oldpath->dentry;
@@ -129,34 +132,12 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 			break;
 		}
 
-retry:
-		size = ovl_do_getxattr(oldpath, name, value, value_size);
-		if (size == -ERANGE) {
-			size = ovl_do_getxattr(oldpath, name, NULL, 0);
-			/* Nothing was read into value, so it must not be used */
-			if (size >= 0 && size <= value_size)
-				size = -EIO;
-		}
-
+		size = ovl_getxattr_value(oldpath, name, &value, &value_size);
 		if (size < 0) {
 			error = size;
 			break;
 		}
 
-		if (size > value_size) {
-			void *new;
-
-			new = kvmalloc(size, GFP_KERNEL);
-			if (!new) {
-				error = -ENOMEM;
-				break;
-			}
-			kvfree(value);
-			value = new;
-			value_size = size;
-			goto retry;
-		}
-
 		error = ovl_do_setxattr(OVL_FS(sb), new, name, value, size, 0);
 		if (error) {
 			if (error != -EOPNOTSUPP || ovl_must_copy_xattr(name))
@@ -1059,26 +1040,39 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
 	return true;
 }
 
-static ssize_t ovl_getxattr_value(const struct path *path, char *name, char **value)
+static ssize_t ovl_getxattr_value(const struct path *path, char *name,
+				  char **value, ssize_t *value_size)
 {
 	ssize_t res;
 	char *buf;
 
-	res = ovl_do_getxattr(path, name, NULL, 0);
-	if (res == -ENODATA || res == -EOPNOTSUPP)
-		res = 0;
+	res = ovl_do_getxattr(path, name, *value, *value_size);
+	if (res == -ERANGE) {
+		res = ovl_do_getxattr(path, name, NULL, 0);
+		/* Xattr changed underneath us? */
+		if (res >= 0 && res <= *value_size)
+			return -EIO;
+	}
 
-	if (res > 0) {
-		buf = kzalloc(res, GFP_KERNEL);
+	if (res > *value_size) {
+		buf = kvmalloc(res, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
 
 		res = ovl_do_getxattr(path, name, buf, res);
-		if (res < 0)
-			kfree(buf);
-		else
-			*value = buf;
+		if (res < 0) {
+			kvfree(buf);
+			/* Xattr changed underneath us? */
+			if (res == -ERANGE)
+				return -EIO;
+			return res;
+		}
+
+		kvfree(*value);
+		*value = buf;
+		*value_size = res;
 	}
+
 	return res;
 }
 
@@ -1089,7 +1083,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	struct path upperpath;
 	int err;
 	char *capability = NULL;
-	ssize_t cap_size;
+	ssize_t cap_size = 0;
 
 	ovl_path_upper(c->dentry, &upperpath);
 	if (WARN_ON(upperpath.dentry == NULL))
@@ -1097,7 +1091,9 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 
 	if (c->stat.size) {
 		err = cap_size = ovl_getxattr_value(&upperpath, XATTR_NAME_CAPS,
-						    &capability);
+						    &capability, &cap_size);
+		if (cap_size == -ENODATA || cap_size == -EOPNOTSUPP)
+			cap_size = 0;
 		if (cap_size < 0)
 			goto out;
 	}
@@ -1127,7 +1123,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	ovl_clear_flag(OVL_VERIFIED_DIGEST, d_inode(c->dentry));
 	ovl_set_upperdata(d_inode(c->dentry));
 out_free:
-	kfree(capability);
+	kvfree(capability);
 out:
 	return err;
 }
-- 
2.55.0

