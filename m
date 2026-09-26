Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F6638F633
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790396968; cv=none; b=sYWv2re7RzAsdROJI04GkIJPrG1BMdpUk1dh7OBWeorGH71UzsUvViy8styeAo5P4zoyqsdGe1DT829vuXUJ7iMeONRQSZ0u7at6nEXll23mfJJb561EZ4ljzzgDeWn2gQW6mwRdtV3gAEGh02F+Fp+2Snn2m3vI+PCVtX+WGIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790396968; c=relaxed/simple;
	bh=X7V+Jn5Qq3Sog5oU+YzvPzTUvdvvbvIZvcwrOUk4nQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flJ0DJNIxFBIz4QVBPZyiSJdFgsvOWljnF/s51AUhosJVask6NQg8k10FH8sZLc9fH5Xt5BbJ1yrXDkwiasNn1nUYV8RMZWG21gvjIh9JMwfRaFPhTxfa3uR2sJrvZ7byEVkLUd2zKkTX0XEKuKKbUfsbTvp+TaNiAfG12SL8zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWgn/uEB; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWgn/uEB"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso1877139eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 21:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790396966; x=1791001766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zF7ToF2Odw+9aOZdfGrI1tThap+ZGFopFEIX1DDCAew=;
        b=LWgn/uEBmAhhYINpinGboTdDAqNjzk7flvDs3/j4gdjXWHa3DXvCw/qpTyPSG3n+0I
         4/hlF1sfiKR9/iV4tCC0ccE255eMiHKFYDm0YJLF7+V+dkiDLJxYK0zo+7RQn7XnosM5
         OGKTxnKaf3hJjcUl61g7p7L4M5YX8llsR26CytnQybcRFyHYG85TNo+ikSznCCu3r42O
         QZAquASP3sZ/Vm+1X790BxHdfLnxk3gbTJ+Tb+hUaqzWfSqd/QNWjFgj1Ui/+lPxr2qO
         qs+HxdaW0BES1hnX2B4hqM/2zqeBCW1B+0x+c15VIAzvtTfggOOBDKc730Tf79EeTfCc
         8/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790396966; x=1791001766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zF7ToF2Odw+9aOZdfGrI1tThap+ZGFopFEIX1DDCAew=;
        b=IXynv8HvaaMr9ym0h+baeo1xeR2r9IEE2grCppe73vZBm8inTCx3hM0xjIfS4/WaRI
         Z+wv+AsbAN1hDgI32MrpbJkSBL8fj7dIQ7z6qMUkOtM8kNCde9SksjeyLwR53zHyXg1N
         xKiJTL55s275uExN3D/obKUONFY4+2vpmkgnyrHXrXWwnsh6gpWcjjGt0G4J4p+8aA9B
         U9IoNMzwz7bi/ZMUd9JBUCHHV6dk/VMShZ9lZkNUXm18lsBVPQwrYe+W80GC+CWKnyU8
         kGGCgSYk++sttrPAWbXPSBup9Cyc+ihkqW/yppEVPlt7hkH0DSfW5Uo2HD09DkGeLWjD
         6Dnw==
X-Forwarded-Encrypted: i=1; AKwUvByygcvLO+jK3ETi7kd8khUPu7Wf7hswL4199lnwoMeM+sKDWa6nZCclcSCE8VGzJ5wuVxXdO8txyzjz3Ydg@vger.kernel.org
X-Gm-Message-State: AFuF++nuOk2yj3XGt3ANFPooM1DGoX5Tn4e3jArARMd/+GKWI1u2eXUK
	gzFwqs1IBL3iWlkZMQI7hAovw2+cPiJX66tDODmFE34hfndreOY5MbfGf8R87x2YofKcxcHW
X-Gm-Gg: AYBFou0foXuniYRVBLRdZ3DFiSdhWNF977TyNqombUDmtfX9vEOHH0Y4flbufq0ioRK
	RsEO/Vbdj0KCOaZ9Q7EwI66Tcfr2hWUv9vGddbtDswTvo9taxLMJ5iVTFObzHAorypdEO2MbvOf
	eeUpoNLEenR8yQ4EyMu4ygIDfLHHXDrO6IN2vm5jiguwd5aIRN0bQA/TZpJlY1MEK6/WrlaHOB6
	KLbpf16ifAp9EFT1ZMW/e5dBgC3CBq16AuENGs9N40QBU7lXl0GUp3iKFDBuW74T8H2tLifM01R
	xjYLDcC9BfgQYjZRIcU080ickZ+YDaUXEsIJi+x9IJ961Et6YH11BRl1RQSLQ3YC241uFE+f497
	KNrNAPoEBUONFdhDfyMU3UexlVpUtkHuMKzmJXogU+IsPMDWhjsa+WebDHjcsfzqqDJEZGyWfKj
	XJCmLxTthnfLKPbOne1HOD8kCq01rr6aNoc3ZZVOkkuOGMjQSVU6htxkgK/7FBnjuVeZ5e5gncW
	mrNCvEbtUmKgqCZnU4B8YM4J11SRxvp6FeaSrVPfPASeQY0SXtdP4MlQ3QVo2rAz93N+U4EMx6I
	5EUiOAMeMRRMcNxZKCHu7Ipr+upmyZP4jHSGVPTv/dF2ruNrErKOIQqjWCA=
X-Received: by 2002:a05:7301:1a02:b0:33e:84c3:a056 with SMTP id 5a478bee46e88-342710ae7bamr1860743eec.17.1790396966424;
        Fri, 25 Sep 2026 21:29:26 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm6342963eec.10.2026.09.25.21.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 21:29:26 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] isofs: pass the name buffer size to get_rock_ridge_filename()
Date: Sat, 26 Sep 2026 12:29:15 +0800
Message-ID: <20260926042916.3277409-4-matthias.goergens@gmail.com>
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

get_rock_ridge_filename() assembles a name from one or more NM entries
into a buffer allocated by its caller.  It is not told how big that
buffer is, and instead stops adding NM entries once the name would
exceed NAME_MAX, relying on the callers' buffer being larger.

Pass the size in and check against it.  Both callers pass NAME_MAX + 1,
so the behaviour is unchanged: an NM entry that would take the name
past 255 bytes is dropped, together with any that follow, and the
entries before it are returned.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/isofs/dir.c   | 3 ++-
 fs/isofs/isofs.h | 3 ++-
 fs/isofs/namei.c | 3 ++-
 fs/isofs/rock.c  | 8 ++++++--
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index eebea133094d..dd8958617340 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -186,7 +186,8 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 
 		map = 1;
 		if (sbi->s_rock) {
-			len = get_rock_ridge_filename(de, tmpname, inode);
+			len = get_rock_ridge_filename(de, tmpname, NAME_MAX + 1,
+						      inode);
 			if (len != 0) {		/* may be -1 */
 				p = tmpname;
 				map = 0;
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index 47c43a3c6a61..a2d28a23e892 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -115,7 +115,8 @@ struct timespec64 iso_date(u8 *p, int flags);
 struct inode;		/* To make gcc happy */
 
 extern int parse_rock_ridge_inode(struct iso_directory_record *, struct inode *, int relocated);
-extern int get_rock_ridge_filename(struct iso_directory_record *, char *, struct inode *);
+int get_rock_ridge_filename(struct iso_directory_record *de, char *retname,
+			    int retnamesize, struct inode *inode);
 extern int isofs_name_translate(struct iso_directory_record *, char *, struct inode *);
 bool isofs_dir_record_valid(struct iso_directory_record *de,
 			    unsigned long offset,
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index c65cc78583ba..9025ff74eb60 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -104,7 +104,8 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 		dpnt = de->name;
 
 		if (sbi->s_rock &&
-		    ((i = get_rock_ridge_filename(de, tmpname, dir)))) {
+		    ((i = get_rock_ridge_filename(de, tmpname, NAME_MAX + 1,
+						  dir)))) {
 			dlen = i;	/* possibly -1 */
 			dpnt = tmpname;
 #ifdef CONFIG_JOLIET
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 84e0d764c210..5a5984b72224 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -209,10 +209,14 @@ static int rock_check_overflow(struct rock_state *rs, int sig)
 }
 
 /*
+ * Build the Rock Ridge name of @de in @retname, a buffer of @retnamesize
+ * bytes.  From the first NM entry that does not fit along with the
+ * terminator, the rest of the name is dropped.
+ *
  * return length of name field; 0: not found, -1: to be ignored
  */
 int get_rock_ridge_filename(struct iso_directory_record *de,
-			    char *retname, struct inode *inode)
+			    char *retname, int retnamesize, struct inode *inode)
 {
 	struct rock_state rs;
 	struct rock_ridge *rr;
@@ -287,7 +291,7 @@ int get_rock_ridge_filename(struct iso_directory_record *de,
 				break;
 			}
 			len = rr->len - 5;
-			if (retnamlen + len > NAME_MAX) {
+			if (retnamlen + len >= retnamesize) {
 				truncate = 1;
 				break;
 			}
-- 
2.55.0

