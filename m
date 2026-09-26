Received: from mail-dy2-f40.google.com (mail-dy2-f40.google.com [74.125.229.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D13911C3
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 04:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396971; cv=none; b=kN69UQaZF+iFX0GVqT3rIHVbDF1+tqscTQ+WDd7ulIM8sRT2FFfsfHFw7XNnIBKQe/jz7DyT405ZOqG7d5QtLF5mZGrPN+MLhmo3rDVA1iBIi7VZBWLVxuyV4LK9GsZFM4ClQ/82ti6b/Mn0YoJT0bNc13Hgpt8qezouvATk8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396971; c=relaxed/simple;
	bh=GpUUZlRSGDZdH9l14gIIKqilWznEEoD/ZnFf4baX0dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6oQZvZ32Vkbz9Cppwa6icxSSmogE4BtX3XS0s3iWFWuH/meXoR74/9aj5o47X/xiR9k55hOta5js0+/mfRpUX9xB8P7UgzpaDKDyZP4EuYC4TubAjVh4JqNtP/RArsjZtUmTb8b/mcYVKdDcO9y5VDsXvYB+8WP2N/vwWUQaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+aKNqdq; arc=none smtp.client-ip=74.125.229.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+aKNqdq"
Received: by mail-dy2-f40.google.com with SMTP id 5a478bee46e88-34346932d93so55082eec.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 21:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790396968; x=1791001768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0D44r2HU7mPFEg3suXmYiSPEArkz6cxgDH4F/lCy9n8=;
        b=o+aKNqdq49edaUmqOxV9wdMXAUpN2UdejH9ruAGkLUpa9wisc6YKoOG+VO6S4TFIV6
         DB02QVhKYW5CEJix3im32GHtcVsc7Tv5BQQ0w1+ZPhoCLWJxPW+ACgFeKUl9mT4CmJ0w
         lFAo9nibq8PtGz57bSCSzEIW0PH4Xe7K16Vl6orZTqFNObiSLCClZwjVBXEiRRkUU2p+
         I+toP5woQoWWwa2pPEEbcLLv0omn1h5eR9wp+eXxEtXh1/AYXurtiZw1gpkb2DBQ4hEX
         mho99dkAylMhIrQhke7WqH5CWZhESaZOqduMCxfTCKkIn3R5IgMQ0HMx6ez9tMZJxg88
         vU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790396968; x=1791001768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0D44r2HU7mPFEg3suXmYiSPEArkz6cxgDH4F/lCy9n8=;
        b=T61OuifbPNQ2TuwsjG3PN8u+4RVre55eIMYrEE1ZJTnsBsWWWJaMkty4eH2jdnYuqn
         dAHh07FV/co3z9vUu18yN4dzdxle/RJgjC8ttBHIvVdXUtghPFr9U12r26vyuZEc6KJ7
         9jSXQZMkXoFa5+rRmj9/xmlre4EY90QdtzVomSb2b6w1OXhA8kU53geGeC7271ShIe57
         fHExpg81jnrmydHyD5f5C9iX9+z6ulep5Y0lMqeiRwXVt4N7sJvzWTnxD/a2GMUvhr7m
         VF4ClSNtTxwGgjtuEPVWdv0CQOstuYJr64QMH2USbx/knSC6eYMsPYPzTMeMCoRdV7D+
         0rYw==
X-Forwarded-Encrypted: i=1; AKwUvBy3JvZBFi4zVfHHPwROQBUFK29vWRmbuX1g7SbMl6zkFwkrhdWvueQsKs1co/tsJOcMstX/4K5I+L6EKjOA@vger.kernel.org
X-Gm-Message-State: AFuF++mkTQQvWypFzV3U+rl3cDk0NmJSRktVZNKqlSLVMiWrnlgFx3jp
	IAnAF908jJcAkqMEc7hZ51QU8s5p52kKfQMJc7jLdcQTYANWrdmrxEyXsvZGd8ZK0kT1yyeX
X-Gm-Gg: AYBFou1JAzAMfUxsJPfqNURlaC+HX0AN/2SWzDOUh2njRLAtxvckjnPwqXaeILhr+Hc
	6EV6FsEMtn8EX6XLatKYKVqF6Gdqxmc4ae3JjJiEZnbe6swR0tHSr2k2DiPsU7spGrI+KAb6XTO
	Q+FFJxkwYDjBT0eHQGB8NHevB/9IVqwgknk2vjwYv3oc7umTzcabHJYXmGs0wgV3bcAjZbvSduH
	4TIGoNVJosKb3Ur2IxriA1ZXT6Z7NVtvU2KAvlS66ClQRrN8+f+0eBaq5tvEH+0Z9/qz+gPE0f1
	viI5eItHN11CPk8eOBbCnl8TrmRMJ/lG/1fAUVbq1fdiFqWK8c7ORwlZqdPNAZQ0pzqKLP8Pn9x
	lokkVCk9y70rZ3xMlzhBdemrNu40EukP6Ps1XmiWeLDq7Ye8S1qKv8uQkmus5EkN4/vMUgxZ8vH
	F+itwNL13T8H9i24r7o21B5KbdyvuMIcxscaVslBeYnLSEkhQdcONGtR5y278rHiG5NgLVxjNKz
	D9dEhHlbgr6LOaK8lRobdZPzNgvy38S9Vc5RHDV1OI6QpDmeqofrV6y60aG85cseCdcve6guW9D
	fhBG7+YOf/NvoMEOyakPhFV9q3oZ8MjLLN9Pv5Z7tu46rfSAjEVjvn7swYk=
X-Received: by 2002:a05:7301:b95:b0:33c:16f1:2e3f with SMTP id 5a478bee46e88-3426fcc8442mr1784295eec.6.1790396968201;
        Fri, 25 Sep 2026 21:29:28 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm6342963eec.10.2026.09.25.21.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 21:29:27 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] isofs: shrink the name conversion buffer
Date: Sat, 26 Sep 2026 12:29:16 +0800
Message-ID: <20260926042916.3277409-5-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926042916.3277409-1-matthias.goergens@gmail.com>
References: <20260926042916.3277409-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isofs_readdir() and isofs_lookup() allocate 1024 bytes for the name
converters.  Now that get_rock_ridge_filename() and
get_joliet_filename() are told the buffer size, nothing writes beyond
JOLIET_NAME_MAX + 1 bytes: get_joliet_filename() is passed that size,
get_rock_ridge_filename() is passed NAME_MAX + 1, isofs_name_translate()
copies at most the 222 bytes of name a directory record can hold, and
get_acorn_filename() appends at most five bytes to that.

Allocate JOLIET_NAME_MAX + 1 bytes, matching what the Joliet callers
pass.

No functional change.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/isofs/dir.c   | 2 +-
 fs/isofs/namei.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index dd8958617340..8b5f03b696b2 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -236,7 +236,7 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
 	char *tmpname;
 	struct inode *inode = file_inode(file);
 
-	tmpname = kmalloc(1024, GFP_KERNEL);
+	tmpname = kmalloc(JOLIET_NAME_MAX + 1, GFP_KERNEL);
 	if (tmpname == NULL)
 		return -ENOMEM;
 
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index 9025ff74eb60..c2222504fde9 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -157,7 +157,7 @@ struct dentry *isofs_lookup(struct inode *dir, struct dentry *dentry, unsigned i
 	struct inode *inode;
 	char *tmpname;
 
-	tmpname = kmalloc(1024, GFP_USER);
+	tmpname = kmalloc(JOLIET_NAME_MAX + 1, GFP_USER);
 	if (!tmpname)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.55.0

