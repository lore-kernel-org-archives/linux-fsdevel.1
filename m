Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD35338DC6F
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 04:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396967; cv=none; b=HOH0lNUc8l0KMNjfgOwdF+NVm3nuvYoni8IFjxtOuCHpcFj84eyf7gmfDU1WONo1QJPb1jaCS3Lbe5tTbYnKzl2jT/mJxPa1oiJnrt7rZckg/0WlDXdaRXV6pX8HWg9jeVPtwUDoUdwi7LwYqWKpG2a3uBSbWgwMyZH9wClpeUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396967; c=relaxed/simple;
	bh=spKpAUXngFxsVM0qnH6/+pLbaXvLBd2IZu/RdN6M8RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkc8YmMbTPDEv1CvKvl375gx0Q7zOMcSwQ9CByUhX1wmkaTZZ+e/RY35naZT0CUP8bDlPsZMGu6hgamQn+1jYy212oTmL5CxrlxMG+143MSeopSSOE3/FGb7aMt8WgcsxuXEa1DT/LB4mp653TV45KyYm4v12URh11Ac1/X9NHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4UpQoGz; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4UpQoGz"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-142dd025d07so1270349c88.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 21:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790396965; x=1791001765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qtXgsIphoJ+iugY86vkQAYkei5C/jpRmVM/XsX0DpDc=;
        b=B4UpQoGzbK1E4wLI/kyjnsuYrSkj10ygS7CI5jLvdLMn27izrk9VDzDB3RcZfzSA2R
         BFQCjFfGdT7QK8bqzTUjLFjJ/W8UhoXdiB1N5UxwcLZNT5q7GKoKuXJ8ZUmjVhJep5or
         BlBnbBC2ncgfSHkFEDGYJe3wXCWpbmCY1cChI/PBQ/Vhn6IelfzBVtuXf6dBrjMxpWuY
         0bzaNABuKMjxL94YcPDEhuarRA/jXt9SyxqhVqfN8DzLj6EnZ/GI/9JlYN4td9g4g+iP
         EmljU6tZLHeHJ86SasdY+q8061hJCdS/GOPHIuX/C1e8bLvx4CehVbHvLxD1Gvh1MNJ+
         Xpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790396965; x=1791001765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qtXgsIphoJ+iugY86vkQAYkei5C/jpRmVM/XsX0DpDc=;
        b=QvcafD9OGIhv8W8NIni7PXp9xXYHOKfzRSbUaZSiaK4rp70saGobutgl5lUdwepgs/
         stkMdA5UzUvIolnw+pit7ZlOnpPX4EB6ffkJUpVHflQK0N/d44cQW2CMKf06aYkU2443
         Q9vc4AzHWypZ6/beLQS2vBwj4Fr+f4Z0fSMWE5tvyEGopOO01HGABMomerWX4cV8h1lc
         NwabZlYipu/Ocxnd6fExAGoCTgJMn1ERn69PZkAdXJQD7SWq7wmxV1GEuv3c9qotVFLn
         OsCs7SkDot7eTrdYREU23Z+UIk/opTt29zHTd78aehwXKUrB+BUKnsYT0fXEN/eFh7PZ
         TEzw==
X-Forwarded-Encrypted: i=1; AKwUvBxbz/S6TcoUqD4ON02Y/kz7frNoH8L/S1OwbHJpElu//5NNwDG2/vKXYPdQFv1VHIpH5PdfIBX0FuAlA8YN@vger.kernel.org
X-Gm-Message-State: AFuF++m4Aj4YwN/W9YPi+MVbjQS0i9ypNCnNRuSt+Ej2yMH0mgwbS42r
	cb7gsER5e5CMG5i6OfI6SalJupSj19j6vNQLEYhk+ksfY6+8w5yQeyP7
X-Gm-Gg: AYBFou0zUhKXlOVD5M6vmc6IavHsnTWGAQqaB4RHidS8++r7ex3P6BXalo3P+V96em6
	tPh+okpusJP3Ho2dDH/9bR6Me8hLqlV/NvfjA3aOmJzBmwSTXj407IgtKGlu0u8qVH0EweYybzT
	NmTwM46CbAdw0yCOC0+Yf4b3M44zxrS/0tKli9yHifrufOE38h3XKU7ppNSfIGLsE4r4Slf/i+W
	dEJvcbiu4xjFE5b63+Bv5TOmHfQU0CNxEnf3/mMyQvlaMS7fyGOD43iMiM9jm5vroC7kT7TGVBp
	HGGLzFAt9k2RxnpAoBl/mibmqQng47r4yty8AhAE0Gt0GfBqRtuPF5OEZy1P72MkybydKTtAS/y
	vL+nS6YhEJqgxuh/yTUPRljeeThoIne0c05MZqQFakEb5edl0n7ZdQISMtU+BVrDb7fyH2AbqgV
	C0jqbdSjoMhJFgPZ/Zm1lukiMHOJuJ/7ykFMRdLs4nqGAFNGyugGNuvK8AVOrQC6qR4XjZ4gNyc
	MWHagHL1MoTqbXtMwy9L3kkA5CKK7T+jLgZgM2oBd8yJT5NyyqgJFNtrp3P7mskoLnj90DKX7Mx
	mucUAMWa1kN7N81yeRGF8UT8Iwk+VyL/lCsDWDopn1qGixDlxUDmrv/gbVg=
X-Received: by 2002:a05:701b:458d:b0:13d:19da:9370 with SMTP id a92af1059eb24-146ce67ee18mr1788031c88.17.1790396964671;
        Fri, 25 Sep 2026 21:29:24 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm6342963eec.10.2026.09.25.21.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 21:29:24 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] isofs: report the Joliet name length in statfs
Date: Sat, 26 Sep 2026 12:29:14 +0800
Message-ID: <20260926042916.3277409-3-matthias.goergens@gmail.com>
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

isofs_statfs() reports NAME_MAX as the longest name, but a Joliet name
can now be up to JOLIET_NAME_MAX bytes long.  glibc answers
pathconf(_PC_NAME_MAX) from f_namelen, so a program sizing a buffer from
it should get room for every name readdir returns.  vfat has reported
255 times NLS_MAX_CHARSET_SIZE, 1530, since commit f68e542f3478 ("fat:
Fix statfs->f_namelen"), which followed a report of readdir_r()
overflowing a buffer sized that way, and exfat reports the same.
Windows reports a maximum component length of 110 for CDFS.

Report JOLIET_NAME_MAX on Joliet mounts.  Rock Ridge and plain ISO 9660
mounts keep NAME_MAX.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/isofs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index b766b5c9c593..23c51eaf8356 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1012,7 +1012,8 @@ static int isofs_statfs (struct dentry *dentry, struct kstatfs *buf)
 	buf->f_files = ISOFS_SB(sb)->s_ninodes;
 	buf->f_ffree = 0;
 	buf->f_fsid = u64_to_fsid(id);
-	buf->f_namelen = NAME_MAX;
+	buf->f_namelen = ISOFS_SB(sb)->s_joliet_level ?
+			 JOLIET_NAME_MAX : NAME_MAX;
 	return 0;
 }
 
-- 
2.55.0

