Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B20B313267
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311010; cv=none; b=vE1dnAKK53h05IK/RESLHZvdjQBH5az9c12ZJNxg805oT96gtLrpOVh9WaLsRzGc9g5gdOmTd0s6d9fN6tN+kNBfKHgy1o6jphHyhCwfneapS9LLc401/HrgAiR6Aq+ulKAa7KqCtXh2Qtq7UffN/LjhenLhcTJm9gLiXnO2hnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311010; c=relaxed/simple;
	bh=P9Op4lsJc/HwOr9jdCJ522h1eE0TJiozb+9WvD8ELRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btSCRhbzh45uakyDlictqJ1hYD+66TAXqdWgUWC2HTTQdV96kn8GYTz1zjUEhJXVb4U5KgUrlS2svQ1UdCG3FJW4itFO/br4nszOAyy9UuVdHtSdAIz2MmRTOEg2sG+bgIfvWZDPc684AqFZ6rYMENAxdzU7fsJ6kk90z1VCpIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khCppjpA; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khCppjpA"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b965f447cso7987735e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311006; x=1789915806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45V3oYN24WWaNfR3SZkM292e3snBgoENKm4rPxJfUnk=;
        b=khCppjpAcYgGDeEjzqEkgRhOiUO9qjGU4FIzciMSeyNqMmIzlskEdQjEtSD4Z6en4V
         Ip2427+xIinUkxDVBbTnD0lhoNvAN/I24nUBYGOLzuTHb5bvchN9rwLlka0DQUFsy3hR
         EPq0fTUpMDZssbXXyFP1yIQj3iHMg9+F3EJPuV2gIZVLmHEpUPYaIdamlQhcqFtQv4/t
         RzOKYYPu7HY6EmmYPQz4UXSBqB5jvdt3AzA/Mwb933FZSZ8bQ2dh/LlevqpHkpNDIMLE
         laUsY+UigUL7wtNZFdLc+FnVPD0LHZ4y8U2BdxlHyqKRczE+8oR8fE8WAONLcLWEE4Tt
         Mmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311006; x=1789915806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=45V3oYN24WWaNfR3SZkM292e3snBgoENKm4rPxJfUnk=;
        b=SxtKEQatySiX37tXyhuwCMfcmjOjPiki3N6Q2925ciakOiiJCHxgtzdHmdHi2KL18u
         2wUIEt61rMG10Dso4dkgKf+t3kSHx2jHsS+bCdKiPFOEZR9cUKx4cm8mt1kHfjJsx+h/
         BXaqjR5v8gbV51/HUg8LGs9d9li2Aj3G4P+undyTtCBDIw6F+tgpjR+oVqktxHQ9WY7K
         5ygHuoLcYgzmcTnO28qv0DfanKX0YGaAvEkg38EAtSmeL+YoF4qi6EH0AB46ZAaXm7aX
         YXlMeqt48o1DPOb8+Twb9trtsBHP2LNKoFtgJQ2FW9eSrUCpqDt7ou62jGakUo2Olggq
         3WbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmjtyeOq46WVpWeIYHPjBU4YBz+LxKemZUMwusWDk7t1la4LwqZr9sGFODyVZAecSJVTgNnn9OLrjSoFz2@vger.kernel.org
X-Gm-Message-State: AFuF++lqlMjfGkN8q/Qo9X6hdnwMMjcVSbM0EHcaMHuUCEU5TTYgisXZ
	JL65B+nRlKB5ttmgX/b+KmYrroVa0T6cfdZxTZf9MbPhPTJvTC/LuGlW0bjRgQ==
X-Gm-Gg: AYBFou0bV1TvBe/6qyy7j7eBP8zwwphHvfEOkO43jUKXeIfaXxEFlC1zxiiQ0OnCFjf
	rHZNLUiFW0CUSXArcJoaOHCBHRBiJYCLjN2KXgEXVGUTf1Gn0tfo17Bqqxqxxs//iLawlHCOQWq
	oh57rqxgsFs9xKdnJAxjpQ0+qYDCJvQ6EJKI42Lmh/BUyyDLsLMN8v00SxxDf3rAC3twj+mjECE
	0Yy2I6x4GM4TxPepKqVSOvtVAuTE/2L3SXIySzoDXaktdETwkrOigYYdMjD0gWUVvJhIOM6u8Z1
	WGNXVTdTzAKdRO5ngjZSKRdXxeUZUrUznbfKzFaYzuZQ0GM/sJfx/jmpq8mONczFUtI0/SnPHuY
	G0L7z0uSHPIX7fiGe5LPD2BV9Xddjx0kH1Ws45Rjo+dmYMX3JVSshcL7Oc9897oljTp/tUox/Gw
	HPA4kKWY4/qC4g5px06p4SKgFtkqLikEzLFvffhom+j+F2UrRGZfM8FqfCcwwCe+Jlv2yy885UZ
	KGmYbAj7+NgKy0N/HafduaZQOcgj+sja22t18tKG2c=
X-Received: by 2002:a05:600c:34c2:b0:49c:fea1:f792 with SMTP id 5b1f17b1804b1-49e6cacf765mr67544475e9.12.1789311005425;
        Sun, 13 Sep 2026 07:50:05 -0700 (PDT)
Received: from f.. (cst-prg-84-1.cust.vodafone.cz. [46.135.84.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6420de77sm109534235e9.3.2026.09.13.07.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:50:04 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 10/10] nfsd: use path_clone()
Date: Sun, 13 Sep 2026 16:49:17 +0200
Message-ID: <20260913144918.1606123-11-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913144918.1606123-1-mjguzik@gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/nfsd/export.c  | 6 ++----
 fs/nfsd/nfs4xdr.c | 8 ++++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index e5a0f1ababe6..84ea833816b5 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -233,8 +233,7 @@ static inline void expkey_update(struct cache_head *cnew,
 	struct svc_expkey *new = container_of(cnew, struct svc_expkey, h);
 	struct svc_expkey *item = container_of(citem, struct svc_expkey, h);
 
-	new->ek_path = item->ek_path;
-	path_get(&item->ek_path);
+	path_clone(&item->ek_path, &new->ek_path);
 }
 
 static struct cache_head *expkey_alloc(void)
@@ -1533,8 +1532,7 @@ static void svc_export_init(struct cache_head *cnew, struct cache_head *citem)
 
 	kref_get(&item->ex_client->ref);
 	new->ex_client = item->ex_client;
-	new->ex_path = item->ex_path;
-	path_get(&item->ex_path);
+	path_clone(&item->ex_path, &new->ex_path);
 	new->ex_fslocs.locations = NULL;
 	new->ex_fslocs.locations_count = 0;
 	new->ex_fslocs.migrated = 0;
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7d1b2d6f57f2..65a805501b75 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2966,14 +2966,14 @@ static __be32 nfsd4_encode_pathname4(struct xdr_stream *xdr,
 				     const struct path *root,
 				     const struct path *path)
 {
-	struct path cur = *path;
+	struct path cur;
 	struct dentry **components = NULL;
 	unsigned int ncomponents = 0;
 	__be32 err = nfserr_jukebox;
 
 	dprintk("nfsd4_encode_components(");
 
-	path_get(&cur);
+	path_clone(path, &cur);
 	/* First walk the path up to the nfsd root, and store the
 	 * dentries/path components in an array.
 	 */
@@ -3216,11 +3216,11 @@ static __be32 fattr_handle_absent_fs(u32 *bmval0, u32 *bmval1, u32 *bmval2, u32
 
 static int nfsd4_get_mounted_on_ino(struct svc_export *exp, u64 *pino)
 {
-	struct path path = exp->ex_path;
+	struct path path;
 	struct kstat stat;
 	int err;
 
-	path_get(&path);
+	path_clone(&exp->ex_path, &path);
 	while (follow_up(&path)) {
 		if (path.dentry != path.mnt->mnt_root)
 			break;
-- 
2.53.0

