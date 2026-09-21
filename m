Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67747A881
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987219; cv=none; b=b6qRfpbUdPCDt9r+fLiEhCJRpXdSNICGdU2Ixvaihptp2jL4YN874MZ6/G4MGmjR7CVbYX0gmVkFjTY8/0f7WR3pwWPNcrZW9XaMv0jcJ+2Cc8sH3D3Tfnyb5R0kREF1NZ6IVGnpLkaciLwOXi5ed+oC7vM/4qNrP45peByU4B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987219; c=relaxed/simple;
	bh=dDPQGMPxWDL5Md4UKKAaE12b5eDFg7IKombAhZ8/EIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqWqI03N+D3gyOisM35Qo1X5uju27inTu0lpfFbrkOszv/qsRIC6V7H/0C5Fna78RW0fySSfgDz9UwcXRBJtsTBsNtAcz5U2wp1+8PfJNe/7GMQQdlz3N089x1zYrLUrdiU+8FOdHjar7m6UJsvC3hajdlmMa7/c5xipxWbpVVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+zC8Rjg; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+zC8Rjg"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f560398so421387066b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 03:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789987215; x=1790592015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IbEEZ7owdYJHLjt2CUeGmUfepiIuH0Jeo8fewfZ4bvY=;
        b=C+zC8RjgB5aCJHwSCOmI6rs0LhflVG+NLp432F4hQbPsNm0w0Cv6nxfJn4b4sWI9Bg
         6AoUamME659LVBOX0KNfVgDxlQ6Sr0/Y7jCAzFDeSvLGXe+hPcIpkoO3YaeUDhlp3FNm
         wN1JLjTfju4Yrpa+XK+7WboxETZ26qdow6qd2+YG1RPpmW1c6Pf572vmC9nDJHHKoDLt
         r+2yEEyl3BiaEjN9r0OocvwJ/VdzLkN8+IbW6rbY1FLQKg8xB0Xzx76jiePiUEfaFl/h
         2wR/zlMD5QVmM2QfQaqsd6nWYhs/xQ1pOTrfEORlXTOTPZyrvk+FJHd4SzrEyTTbOmcY
         ljUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789987215; x=1790592015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IbEEZ7owdYJHLjt2CUeGmUfepiIuH0Jeo8fewfZ4bvY=;
        b=tWGdfB2lZgXl3ThiRN6jmCz/YvFPML0mtZ/iMPnkbqneSSdvkEyEI6s8Ei6wVKiFFh
         cYpq55sPv4478OoForyGQ3ZDFpGhWxiRywEmKBDCW5TvF77odB8Tc/mz9pVxHCEZy3h5
         Z/dI9L4oagFvce7tAoUkE4teTwS8SQaN7wJvpvVXpZQ7MtcPMSVRN536D/6NDIhkTE7Q
         EEEj4hmgodsNu1YzZJ4+qKCujAUq9zgtI697G8Li3q7UMOwbqh/zOFM2Ro161x3QMsG1
         C3hhhdj7KGysWMqZffzK4p8iITOXHvMXJAkgXxt8/nxUu7sapCFZXxaaVYLLAyNBQh+Q
         k7bQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSg8hxrtiwGc41e3W90mvT7vSwUGHD5/ZgdaIZKIK30zmB/qYCluliZx/fv50c8PLaztRG0gIYY48r3Npu@vger.kernel.org
X-Gm-Message-State: AFuF++nAghdQfAiVUX6Vdq7aaN3pRBAIffjqc7yOb+Mo4ERESQa5XsHl
	m1ggYO5J6ilcyGp2auOwngNbQV888OwBqxRSUzk8rY7BP618E0nGXx3r
X-Gm-Gg: AYBFou2JP8XkHqqZ/FTBuI4cggUrF4nA2OVeVB7amwzswN3KRSjyealRHeaqIDQXWGb
	282y4d3PaftVjgAFG///hw/BWNQFiAP2SJMzLjOsHfr5KJO2GBcGk8DlzPF6rUujmxJfsgRLa4V
	ypNG8d45eKSu4W6fjk3EUu6GQ3+01Q6azAKgKH01uUNeINU+usNrLJbROP5GQ8a+8oKv3jbqz+i
	q5I9SByQLl5y5k+NthTPstIb/KrcuVOAC6/k1/d1TpJhUoN5np9IDNuuilrO5YW5tBCQynP/nv9
	5bnMMc/MeWmVvnCNuGLkHIokfq8MHWgxKWxtXAVvrxyQrDljKWW9EDEG8o6pZJj+5tBXvaOYDfW
	87qOEY6Vfx2gadMOWyDoS3jcTuN6ovUUeBIr4MS8Q5uNeMu9BUkA5UtTFCMjL2uG/H1y5eYJfMZ
	+HtfseqMTOSuPIi6nsn4WyT2rfBBvCNvMLtAOdXGeXv2cUZwVDdoVT06vZDNNM0B3SHNv36V5Fd
	3NYGtGLZpNpPJprHekyYEPRDg==
X-Received: by 2002:a17:907:7213:b0:c25:cb9c:2e3 with SMTP id a640c23a62f3a-c2a157c014bmr881902366b.4.1789987214613;
        Mon, 21 Sep 2026 03:40:14 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a46a8ce50sm257548766b.4.2026.09.21.03.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:40:14 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Neil Brown <neil@brown.name>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+ced26b784bf977d223dd@syzkaller.appspotmail.com
Subject: [PATCH] ovl: fix UAF in ovl_do_mkdir() debug print
Date: Mon, 21 Sep 2026 12:40:13 +0200
Message-ID: <20260921104013.40475-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovl_do_mkdir() prints the input dentry with %pd after vfs_mkdir().
Since commit fe497f0759e0 ("VFS: change vfs_mkdir() to unlock on
failure."), vfs_mkdir() calls end_creating() on the input dentry on
failure and may replace it on success, so the post-call %pd can
use-after-free the dentry when CONFIG_OVERLAY_FS_DEBUG is enabled.

Print the dentry before the call and only the result afterward.

Reported-by: syzbot+ced26b784bf977d223dd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ced26b784bf977d223dd
Fixes: fe497f0759e0 ("VFS: change vfs_mkdir() to unlock on failure.")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

One more fallout from directory locking prep series reported by syzbot.
I have asked LLM to audit the kernel for other similar uses of %pd
post end_creating() and it did not find any.

Could you take this via vfs.fixes?

Thanks,
Amir.

 fs/overlayfs/overlayfs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index e0d8c6152e9fc..7f3558372c599 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -254,8 +254,10 @@ static inline struct dentry *ovl_do_mkdir(struct ovl_fs *ofs,
 {
 	struct dentry *ret;
 
+	/* vfs_mkdir() drops @dentry on failure and may replace it on success */
+	pr_debug("mkdir(%pd2, 0%o)\n", dentry, mode);
 	ret = vfs_mkdir(ovl_upper_mnt_idmap(ofs), dir, dentry, mode, NULL);
-	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, PTR_ERR_OR_ZERO(ret));
+	pr_debug("...mkdir = %i\n", PTR_ERR_OR_ZERO(ret));
 	return ret;
 }
 
-- 
2.55.0

