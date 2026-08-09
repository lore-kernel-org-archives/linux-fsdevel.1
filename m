Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B51C370AC6
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Aug 2026 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786303389; cv=none; b=YwGcfl8z3nOHiGDfzx+mWiJiPV7zRnMAQCThxXC4yUtmb2PRvn+T0W+dZXGQQ4eDMYy02yykVM7y+ds+VaBhFQAs2qAA8wE8x482dGwqsysJ3nuMbgmSo3RYJO7sDsdI9sHEoV4NCZC/xMaXX8Rhm8p1/t6CCkDR3StzrOL/Tow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786303389; c=relaxed/simple;
	bh=96rQDAZYYc/6pKZoBNYGBwf6x1MhSXsQhnqCgV0k3lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3MB390Z4/JJgGHbkzq1DDDdLP1p+wfHni9pYcSZz58LkwzFzQqvmX37TZK9MFPapl2xZqCJEKB6ZYUJ09AxVVLwl6wD50XLbUbn9MuFgwD9+DQFjaBgHen6BuNJU2LD7pp+NpPB1KMm4hb7obCGgWkwaM356t7g+TgvMXdicHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OF29N8yX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OF29N8yX"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c998fd549a8so844582a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Aug 2026 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786303387; x=1786908187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uaI14rzojwBORu9iSQ86dtqKJBlbBaWS482UBa9YKaw=;
        b=OF29N8yXokCuokIoC19Y51FH5OEl3wb681J1cL4+rzJ8al6TfbbVeNYCX6L+mlso26
         aW7ygvOJy0YXBaHi3Il2AK4LydiI7A8uJyPPVFIYxhFvEhOsGku6AGIs3Y0ZqVq2J8ys
         eSidKSOqyvw81/vxraZ2hrNx/HVexAdlMYq5K6ymfjRWUmmot4IQTKrhj6d5o6nAIHqC
         VIbiJC7u/VODbKddK+DFeTyS9MuDMkBiClwtwPBA8/suk0C+6jHTH0AR1wgBTRtRw1S3
         GlV8sl6ZrTXCAhAIWzAnBG+SdRyN+wfd9lXomAQ4yZysVqaam5BXbhxn4/F+sIqZA2bf
         cReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786303387; x=1786908187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uaI14rzojwBORu9iSQ86dtqKJBlbBaWS482UBa9YKaw=;
        b=QVPpHDfr/tEgnsmbKATWzURfHz5T/XSkFoNoCMworl81ID+Q9oLsutQXbAzIeQTHhp
         yF1xet7XhWrgFLNpTH6NC0E9sPV72ucAaOVGrXyC27cWAYZAVq5atxf5GVDPmBWJFO4N
         aOSNfEnDdwcvYQUMm0VHgDcD77TJLtssDAf0dhFSVFneH612EjiPwoFmN7SE1PjwquO6
         YyPDMpHmotgxFJnQFQX1Jf38pZkHcqMKG3L2GK2zxuvCEWntLCivahOinpmubwwaTS+X
         yWAIxDTx2unEgskuABpjqjtSNKYE3m3uGku5SDXwx2Obus9sIs7B3QIM3F2higzGRUYB
         FsTA==
X-Forwarded-Encrypted: i=1; AHgh+RosrxoGyQj1T0qYdkwNDXV3EaIkCas3s1VR0+C/14DklDNbEgSXZejwDYuNY4Rk7wGM6Rp0hubeDgWeUMCT@vger.kernel.org
X-Gm-Message-State: AOJu0YzoycBEvRaWoe5mwV9DnqnLwDRwznaShBbFHza+O2dLZ8JI+4cL
	bQqqPflEgYsWx1L5nK61f7GXGCUNhwHMysTfFug25jqj7tB4WNd9RIB5
X-Gm-Gg: AR+sD10Gjr/qp+L8JXxUzeFA3Abah3tpr793CAIpc0SXHqLXEvEzrzVFlAqCn9NMWdq
	Fc/FCw1aNCim9gQd1GGd8PACUY4f39UHzn+3zz0IxUMFZcOP77E7jL2aNDoMZEJEeNweoyB+NZp
	GThgPKTOhweCLZZqujkVWG28ZTDpzuMf+mrfduc4fHZK8ryscNtLAk28BKwG1I/ZuDkhKzgopW/
	4hj1Iz4oPyGJHczf4jI+yEMY4DaIYAFZtcIbdNWduX4WlesQaMEOm057nqQ2XJZCssDISnSToII
	yNBQDgoVTGnBRNKpxM8b+JHmbNCUx23mpfCPSUKFFdlj8ZD/KbPz7XrYunhOqcB7zM+jh/Ce9al
	euq7QCXZ4ODb/HPQwUI/E7CMh2UxkJAxuKF6DXFwzBvC3vDP49EJpmX6G5JaZFCCVjQfj6fvGKq
	WJa/iI/4WrKgquzRAAhGogAYazmm6MYrvj4PtTQIaqq0r31bwGwu0r383URXGlfBJEK+AQMsjGs
	As/NO00jbn4xxAgwRPyPMenX8qko3z4m0DcY1Ry3xDxXgbDlUC9/1Nuy3C5WsflVKbLGXol4kNQ
	bebKvS2KThq4JQ==
X-Received: by 2002:a05:6a21:3388:b0:3bd:187e:2de with SMTP id adf61e73a8af0-3cb85eef9eemr44274535637.25.1786303387433;
        Sun, 09 Aug 2026 12:23:07 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:ab62:887d:e555:df21:3318])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec128a0sm38531086eec.25.2026.08.09.12.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 12:23:06 -0700 (PDT)
From: Manush Prajwal <manushprajwal555@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Manush Prajwal <manushprajwal555@gmail.com>
Subject: [PATCH] fs: fix comment typos in bpf_fs_kfuncs.c, inode.c, fs-writeback.c
Date: Mon, 10 Aug 2026 00:52:49 +0530
Message-ID: <20260809192249.4485-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a handful of spelling mistakes in kernel-doc and code comments
under fs/: "Rmove" -> "Remove" (x2, in the bpf_[set|remove]_dentry_xattr
kernel-doc), "funtion" -> "function" in find_inode_nowait()'s comment,
and "paramters" -> "parameters" in the foreign-inode-detection comment
above wb_wait_for_completion(). No functional change.

Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 4 ++--
 fs/fs-writeback.c  | 2 +-
 fs/inode.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index f1863a891d..e8a5a4cffe 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -235,7 +235,7 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
  * @dentry: dentry to get xattr from
  * @name__str: name of the xattr
  *
- * Rmove xattr *name__str* of *dentry*.
+ * Remove xattr *name__str* of *dentry*.
  *
  * For security reasons, only *name__str* with prefix "security.bpf."
  * is allowed.
@@ -303,7 +303,7 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__st
  * @dentry: dentry to get xattr from
  * @name__str: name of the xattr
  *
- * Rmove xattr *name__str* of *dentry*.
+ * Remove xattr *name__str* of *dentry*.
  *
  * For security reasons, only *name__str* with prefix "security.bpf."
  * is allowed.
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index fdb8766d27..e19a588c07 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -233,7 +233,7 @@ void wb_wait_for_completion(struct wb_completion *done)
  * Parameters for foreign inode detection, see wbc_detach_inode() to see
  * how they're used.
  *
- * These paramters are inherently heuristical as the detection target
+ * These parameters are inherently heuristical as the detection target
  * itself is fuzzy.  All we want to do is detaching an inode from the
  * current owner if it's being written to by some other cgroups too much.
  *
diff --git a/fs/inode.c b/fs/inode.c
index 31c5b9ee3a..059094e40a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1775,7 +1775,7 @@ EXPORT_SYMBOL(ilookup);
  * function must never block --- find_inode() can block in
  * __wait_on_freeing_inode() --- or when the caller can not increment
  * the reference count because the resulting iput() might cause an
- * inode eviction.  The tradeoff is that the @match funtion must be
+ * inode eviction.  The tradeoff is that the @match function must be
  * very carefully implemented.
  */
 struct inode *find_inode_nowait(struct super_block *sb,
-- 
2.46.2.windows.1

