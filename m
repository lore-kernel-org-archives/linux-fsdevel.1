Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.186
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877669;
	b=0KqdPLI3UoSP21KOt6D81cgZQcZmNil5yECJTgVBsRliSN4XQGr9FukNvRui9h1iH2sK
	 FZrKu89oXBjLCPLI/++2XxUCldWM4lguhTDMXpFnbHek7o5SmK30fvhv5cNxvVKE8tflm
	 IMRA7ImcsKXdvwx83sdMT22oiahAWBNPtpgAD0ylhlMs+bfVK/xZWBLXvfPOpR0Y2LdEa
	 k0pBL7YWYrqaKexG+IpPHiqcOpyyze60UQ8ksrzRG3Xy+pMG4XI29cloGz2sfF7yEqlpo
	 PswfceN05tP79B+7omHP+kOjzSTYWQ/Qd9a+kn+qq6jnytmc5Gu5z3qUbNIUp1hv7Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877669;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rW+kv+6vYJyaP/hD4IHRUviYRyfuSjLEi3DTzV1Xzx4=;
	b=uu2XxtBp9A2dZ4VBzYfTBWYcJrRgL9SqcF0+vCMP9Sz2q1Ehz3VNqaYdbOvbzVY+p/EK
	 vJMLjeJeHHdfrNF2GTH6WXHA+j3pphGFN2KJkBw9BKXX2kcnCpeVoPJv+PauqUvJ+fT/6
	 Ly3qYuV8MdZgVpUP4/zGGiQcYZLLBGyOsdbfeVWkuNB0zhGZwXcsxppn8Ui4wLr6VeQI9
	 cYGhMTfC7JKI2OWoWZbtUUJ7ozYW3zIbuVJyoY1IpB8ESJZXvHBUFC+ZzKUdJeQZh3b+A
	 eINZ/O1pU4UYSmr+cx5t6Emx6G0bbm1HZ0Yn3UQVumVPyEd+69SOVzsPx6T6Wkx82cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=oz4qxVlu;
	arc=none smtp.remote-ip=195.121.94.186
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912F606A329
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 21:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8912F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=oz4qxVlu
X-KPN-MessageId: ae950a77-cff2-11f1-87e5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ae950a77-cff2-11f1-87e5-00505699b430;
	Sat, 24 Oct 2026 23:34:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=rW+kv+6vYJyaP/hD4IHRUviYRyfuSjLEi3DTzV1Xzx4=;
	b=oz4qxVluCtLNWMhDWnQGHHjpZB4WMhWZY4HesTZMOOppvpKhzkHY2KAzJEDD3Tlr/jUm3TSwWwPoX
	 s1elxRHLXtdesmHSGicnUG1t685OS7i2QIfZrpbQeWJ0QZNvhitittYXh11xbN3U8VNrTQLJVtxL5H
	 JHEXS1es4IQ9OAE8eWWS9bBcuAd10dWQuvWVYKw7CpdR6GI5NsYZMcPxgtxz+B6IcqABptTaJ26OtJ
	 uz+ZXXtsDsAmqIWdRTAaeQuvHHYYhvZ+bC2FfUsMJfn6JkLZZnMQ8KZiQrbx03ppw2Q11p/6P57XoW
	 gVgzTyXYQLKVJAJOlDO8O3DjPW+nghw==
X-KPN-MID: 33|6WWWsZSe1oDbOrEw8rRGNxVbOXmdDBSibAkQVrFHg47BPIZPtyeGsHpZN9hltw2
 dWT4z9yHgvOqBRDz6U35E0vqWMwLbsXkE5isNvLmtu/A=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|hD/e1Fha0ibWkig3+/AwCiF8wgcpVwO8WnDY/yc9cKu64KW1ZNY/YRh0kjDkRTP
 GesfIopYCnwX2EtmYoszlQA==
Received: from daedalus.home (unknown [178.227.247.81])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ae5ab32f-cff2-11f1-8686-00505699b758;
	Sat, 24 Oct 2026 23:34:24 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	neil@brown.name,
	cyphar@cyphar.com,
	jlayton@kernel.org,
	amir73il@gmail.com,
	shakeel.butt@linux.dev,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v8 03/12] vfs: lookup_open(): move setting FMODE_CREATED down
Date: Sat, 24 Oct 2026 23:35:30 +0200
Message-ID: <20261024213539.1307600-4-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
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

In preparation for using vfs_create_no_perm() in lookup_open() we need
to move setting FMODE_CREATED on the file mode to either before or after
that call, as currently it is in the middle. If try_break_deleg() fails
it is currently not set, but vfs_create_no_perm() includes a
try_break_deleg().

Going up the call chain of lookup_open() we see that it is only used in
open_last_lookups() if no error is returned from lookup_open(), so we
can safely move it to after the filesystem create() call. This also
makes more sense when reading the code as you don't have to wonder what
the implications are of setting FMODE_CREATED before the create() call.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 9fa94e8079db..94958b77b371 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4582,7 +4582,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (error)
 		goto out_dput;
 
-	file->f_mode |= FMODE_CREATED;
 	if (!dir_inode->i_op->create) {
 		error = -EACCES;
 		goto out_dput;
@@ -4591,6 +4590,8 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	error = dir_inode->i_op->create(idmap, dir_inode, dentry, mode);
 	if (error)
 		goto out_dput;
+
+	file->f_mode |= FMODE_CREATED;
 out:
 	if (!IS_ERR(dentry)) {
 		if (file->f_mode & FMODE_CREATED)
-- 
2.56.0

