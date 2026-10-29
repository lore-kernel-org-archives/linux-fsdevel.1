Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236188;
	b=U+WSSdygDZEyAUNGfe/V6GhVK+G22fSWeVy49jQKrQi0XVuweoHvlJ01UYiWbI2FWcIZ
	 Ls5UNU7vOW3huTfY3y6EUU8FX5SfmItiZthoCwLj6NVwSugN92xrURmeBMy5896xgyxkT
	 ngmTxYM56Y71RF6nVhHLpEdTxeXhntVUk7pvhvhLBYF/sLsLsQw14gQhOoB4/fYA4NGv6
	 7yruxN2aDVFEOuO4NrwidOjlJs1te8vvBmUdr1MEU6U0aPN4b5KzlW8dZb+OeAB5mizAc
	 MTUF7OeTKSBL62+67x7FK0e+DOoVUGjE02NLzpvC5h49wwqZeASPX8dvYRCrChzKG9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=zsf5W+NaLCkvQlcPGx1mRCkHFxbDj0TsI0bo7unh56w=;
	b=HSDOkk5/qWVT1Nci/hvHr0zc5J1cxc8la3Kidxo9ItY95CWrrdP0636n5EKB9v4wtxxi
	 kBst0zfJSfUmM5pHXsrNyXSTg63j58bEIQUAGLljFG6ss0AkIeO5WQIlo+DJ9Tqs+RC9W
	 efQIiUlw+05lZh3AH7a1N+3LEAfSVKXoCTZaP+YYr+k12VNTl6Ns1MTOAjggoiVT8D0xc
	 LKHYl1EyQUjK5W/GmI49QZfACw0b2FoVOMfqVYpOKYDbCaXlKgliJsPZbaoonu8iIOiRc
	 V6IP5QlYSs4rg8JkF/f/0Du2SwcGMi5B3qzi/InneeViJsERB/7SqK3/hz16vXuWFpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=e7oAeNzP;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F72606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 01:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F72606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=e7oAeNzP
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93efc0452b5so104324285a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793236187; x=1793840987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zsf5W+NaLCkvQlcPGx1mRCkHFxbDj0TsI0bo7unh56w=;
        b=e7oAeNzPyXwtr+ukA9mdzZtJcqS3hkdm3gIMpJ+yYCQXFidkafUrt/6aMC2KAbzScP
         mgAlGb+e0nj1R/bDAw47tyJAcYVIfE+EDUts4z0bLKPZ/gv5ooIQ/yj/xTsoTr33la/c
         Au3eEA26dtDN60zDI5wVbT26VYsv5n8O9bhmLmlh8RzXEPDmmRsG/lDZZgcx/BvlDi1B
         IP92nrmh62HZGvAUfAUfd4Ca7aL3E2L55fhLH7CeGF26Qx93ddqoeBEHJVRJ2+BItXIz
         8eddOpgUB7sxKFpkn0hl8muacdZlGDZjliQ3o87EDwPvJ8//Z9GpZMhat0HmFZIdI/Cd
         TH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236187; x=1793840987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zsf5W+NaLCkvQlcPGx1mRCkHFxbDj0TsI0bo7unh56w=;
        b=NbQo1VVB7IuzZoCOxCEFrkhLyjzYyBJuJRrnaluvrLEWVoT9pDckd6DjcxEhduBb04
         CUPAE7uZN0aR6yz2WOYoKa6EV1GsaV8/D35b8koYfUJ91soOB83W5Cg+sG9VoRrvNWwy
         5G8uIJB5z9Gw13vQBAirRCwieiz+5BapyBuboO/ro2GW2RCjHSNwdbBpZei8DFeaDZjN
         nGIsdD5UVoNEjlCNMVMevccUu+xU0JHzTVaHtVWI7h/o7e3bIW8ZcuMlpDaKtEtAaBio
         jeZ0+VQG89WxUasWvULnV5cNk0Tzc7VucHhTiw/B4qiJuvDymOb9E3liv4Fl/QsBTHoK
         VW8w==
X-Forwarded-Encrypted: i=1; AKwUvBxoK+GaTSshddZ5v2uPA3x1LekCAK4jhgZNrIOvKIpYoL0qD/Z7GIrbWI6H4rofEp41DK2voXBDlyWc+Y9b@vger.kernel.org
X-Gm-Message-State: AFq9FYIJk774qyvqcCAL/CVO9CCAELRsx/ODO4zoNp1VlPFY56oz/Nr7
	EwJLlj21krDYi5CZGjR9DBZW3k1SmRfRTy5V5WQh5rDjDHO9MzqvAdQBiYP7jAIvSPI=
X-Gm-Gg: AYBFou0aLi7ENe1tE8eM4zLcZ8TxCfJOrASAN13w7x9eapx3SpgzEXPXg7k0yjUbU5g
	2c7m8wpW2W+in2kb6HhT8lTSzv0VGbDJaGAD77e7BrR/l3iuAH7nDbVVeHb8Pt/4ibneONn1JCa
	JdaVZiGm9QrrzvpX3n9rhUk46Nqi388bhRPu7ucFMcKiI9Y1zpBjFdO8FfX68dj0pYvui/upoKl
	aFtvirUZDUH3VVR48xTWVy6hPQ5qCbzsg6l9wwZOS1rKJC1GoJZAMxCpm4TR1rZ/Da+blK7eAFj
	7/w2kdG9E2xx+OGoZnXKjnRqB+rFHfuHsxtW6tO5S/NqjxRdsJg+is+HG7d293o70gGxOkdc95I
	gLzhONqpE0P4vqcdxV3XdfDDsmVOg7lSWcYCvKi/Xbu3Z6uFjo55w57VhXQqGOECXpTwdAGhm/H
	7N7jmjIwzPXnCYRqWQljqtsPowZB6GHegpvbVQ5A+AfjYrbYpCKgrDdCDbN9rg74R1cxwQYcIK1
	1hAFicawCGRl1P6IncP6XThGU4peup9jdQe7tPxqkKcWF94u1F1nKT+tgQsY9Bnssn7ozZvkKbp
	ZjhsrFlDF+RaiKKCAMwYfysFJVgRZXACko6LDRYrSxZcEw==
X-Received: by 2002:a05:620a:4001:b0:93c:ca09:aa34 with SMTP id af79cd13be357-94408cc0ed2mr621645085a.46.1793236186850;
        Wed, 28 Oct 2026 18:09:46 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a771c9sm1396738285a.34.2026.10.28.18.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:09:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 29 Oct 2026 01:09:22 +0000
Subject: [PATCH v2 08/10] ovl: pass the ovl_fs to ovl_do_rename_rd()
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
Message-Id: <20261029-b4-ovl-containerized-sync-v2-8-4e9f08e4a052@toxicpanda.com>
References: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
In-Reply-To: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793236166; l=3810;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=NM1I1v4Cd+302xpWk23F33TayPRCWrPMQmEPHoo2GAw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGBudy0BlSLKWCowzrdoqc46Z6F7ygO69vTIhP92EGLQ2rNNjUCCATTOlLX6sAuL1ta8o7raZTG
 QmSWlhSax/gg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

It is the only helper that modifies the upper filesystem without getting
the ovl_fs, and the next patch needs it there.

No functional change intended.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/copy_up.c   |  4 ++--
 fs/overlayfs/dir.c       | 10 +++++-----
 fs/overlayfs/overlayfs.h |  5 +++--
 fs/overlayfs/super.c     |  2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 40486d2a4b30..c1e00ceab8fb 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -563,7 +563,7 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	if (err)
 		goto out;
 
-	err = ovl_do_rename_rd(&rd);
+	err = ovl_do_rename_rd(ofs, &rd);
 	end_renaming(&rd);
 out:
 	if (err)
@@ -819,7 +819,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 
 	err = ovl_copy_up_metadata(c, temp);
 	if (!err)
-		err = ovl_do_rename_rd(&rd);
+		err = ovl_do_rename_rd(ofs, &rd);
 	end_renaming(&rd);
 
 	if (err)
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index fc47beffa67e..6f7a513bb5a6 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -141,7 +141,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 	rd.flags = flags;
 	err = start_renaming_two_dentries(&rd, whiteout, dentry);
 	if (!err) {
-		err = ovl_do_rename_rd(&rd);
+		err = ovl_do_rename_rd(ofs, &rd);
 		end_renaming(&rd);
 	}
 	if (err)
@@ -449,7 +449,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (err)
 		goto out_cleanup;
 
-	err = ovl_do_rename_rd(&rd);
+	err = ovl_do_rename_rd(ofs, &rd);
 	end_renaming(&rd);
 	if (err)
 		goto out_cleanup_unlocked;
@@ -560,14 +560,14 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 			goto out_cleanup;
 
 		rd.flags = RENAME_EXCHANGE;
-		err = ovl_do_rename_rd(&rd);
+		err = ovl_do_rename_rd(ofs, &rd);
 		end_renaming(&rd);
 		if (err)
 			goto out_cleanup_unlocked;
 
 		ovl_cleanup(ofs, workdir, upper);
 	} else {
-		err = ovl_do_rename_rd(&rd);
+		err = ovl_do_rename_rd(ofs, &rd);
 		end_renaming(&rd);
 		if (err)
 			goto out_cleanup_unlocked;
@@ -1300,7 +1300,7 @@ static int ovl_rename_upper(struct ovl_renamedata *ovlrd, struct list_head *list
 	if (err)
 		goto out_unlock;
 
-	err = ovl_do_rename_rd(&rd);
+	err = ovl_do_rename_rd(ofs, &rd);
 
 	if (!err && ovlrd->cleanup_whiteout)
 		whiteout = dget(rd.new_dentry);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f884e6695d2c..83e25700c8a0 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -372,7 +372,8 @@ static inline int ovl_do_remove_acl(struct ovl_fs *ofs, struct dentry *dentry,
 	return vfs_remove_acl(ovl_upper_mnt_idmap(ofs), dentry, acl_name);
 }
 
-static inline int ovl_do_rename_rd(struct renamedata *rd)
+static inline int ovl_do_rename_rd(struct ovl_fs *ofs,
+				   struct renamedata *rd)
 {
 	int err;
 
@@ -399,7 +400,7 @@ static inline int ovl_do_rename(struct ovl_fs *ofs, struct dentry *olddir,
 		.flags		= flags,
 	};
 
-	return ovl_do_rename_rd(&rd);
+	return ovl_do_rename_rd(ofs, &rd);
 }
 
 static inline int ovl_do_whiteout(struct ovl_fs *ofs,
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index de3e2d0b29ee..c43f8fdd6230 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -732,7 +732,7 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
 	/* Name is inline and stable - using snapshot as a copy helper */
 	take_dentry_name_snapshot(&name, temp);
-	err = ovl_do_rename_rd(&rd);
+	err = ovl_do_rename_rd(ofs, &rd);
 	end_renaming(&rd);
 	if (err) {
 		if (err == -EINVAL)

-- 
2.55.0

