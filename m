Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270363;
	b=OgqSSjLTKuHTUbUi2EGKEni29kchGFSeI6muQFCbmRWCk66F5eqgTTG3K3ZxFBj+V5YV
	 RqObaIc4HFF0sZHH9fT1bKBDZtP//SWDMYc65KSa1qOKAX7bk8I77pS+IsL6xYdsQoy3Q
	 hjcqfhVyIg/55rWMBC8OHtCpIYel7eJMh/nwIt+U5oPk0AwU6GwhOqm+p+pqU7VFatQ8U
	 Ybx7g/pAER1aygWM3DoXsDlfy86VcCtna1gHwxCI+FS13AIv1pwptY2cx7QnZn1GqHW1Q
	 8C+1eZA2nPpMjdGOarwf4QaxmSjaqZk2lnVWDW0XCJoufJdXCMNsPf5v4B4i4v6Jgdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3MlxG84R00yGGxmXTm5ZKcg9R5+P11QL2D2DJLHVQG0=;
	b=1/sQ4oqSrfTu3pp109heRafFMYudnfV+mObl+UwqDvZXtqFFCxobvpv0Cfz8bzbUovmm
	 cseKnzJbZ/aNDchJddJTdXoZ1KEC1rLr9PDADzvYBTrHTh3vy8X90Jrb421ikunKYRMLU
	 HPBJxC2TkQd5Ry/vhWKb1ZGF4UntbIK3zetgCvyws/eyHYpXlXmgH/QrrzIpQWHzTPTB5
	 SrQBcccyIyYQlR9pAWIit88+1Do171b6ILiF5DQ+WildaQFU7xAj2yOtfDnBojuzb6gWY
	 EjwED6uM/LYt7kGJ+oBMoCAD49JZQFNpz9RGcRMXpp2m0EqcFNguqPMJIuYdBIac7Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYlsBv8v;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A756606A334
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A756606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OYlsBv8v
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c445c95d553so272069766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270362; x=1793875162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3MlxG84R00yGGxmXTm5ZKcg9R5+P11QL2D2DJLHVQG0=;
        b=OYlsBv8vyvkJqTtf57oBzP89SQSd01RC9xptYsctoKzU/Z22VM3W7AQInaDsQ3k8Kq
         bZ4FLR9JEI1fq0ocyKOnqAod/xgey7xsqUwRYKZ1o7S5BSUZKd0gZPODfCMqWndIpEtg
         pbmJDmgOmoKvAFdoGAHvQhL3Ht+9rmiOETpdr4eSpMyvwAVO3JS04YUwQAkYwxqyKqfu
         iHqMkeCMZ0qVfA53yYq8icsY3Hf1golYpNHyUJwdzMn0OKEf9mdRjC5i4AHZsCySSLGc
         p7JuTrz+G/+3Bl76ef6zKpj/2MhcbZuPE1r8dZdFVlew89Lwd+qNUqRc5lVfzfDsgQ0z
         eRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270362; x=1793875162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3MlxG84R00yGGxmXTm5ZKcg9R5+P11QL2D2DJLHVQG0=;
        b=2y1DMMKbjQ0RowZLbsrkQAWb/qGi5RL/eHrFujExVW4ZzJGz8Tyc0eHcb8DqWEgcWT
         tZRcwAxmhDRE/3tdWbq11aucJ9cMe3orL90TumW8AOhlYfsKkSq6IdGbOubs9fSxCRfC
         OiaVSS7sZ4hgqAh/+a2Vx0/ZnICnhdPTvKShj2OuQjloZNlVLXbbg9TGamZUBRlrczyw
         IWIjoserBE3SFGY3ApVoBGFDMWeiFkpSGCK0bClaE5hpq2frHzdAnLcAWYxdSouE1LoX
         4n+eUdY9zJtN4eBn/PzifrgytzZ/wTpc+en7IW7UmucwfZXPRd7kML+Eq35FID7CD5Dr
         bmTw==
X-Gm-Message-State: AFq9FYIGpeHL8PC+dWejyW0rFOGXGcBIAjjA5UefnM9qCvrWxdkVM5od
	mECTi7FjN/yNAk4CIXpLGkNsFRWikAXRC/qtAy7ZSqIHdzFV08dLqeJU
X-Gm-Gg: AYBFou2mTCnUptj8ohAuUQH6C6R948uz3IwPzegLJ/t1K7PEbQL5FkMATTVSqnjsuuK
	qGBpaFxdBYiMO49zsD09q3/PsLCCuBtkcP1h4SzlKc5GMifHI/4OO5O5WrsKCiCrMrxDx3YItED
	KFsLapZBBy9Iv7bE8a24rETcQnSrEvOQRQxSRuXi79MYcrdIx02cfom+Bh/h/RcfqPV2go2a2qe
	HNWNWOR3qWZI/wbnE0MWibd5Fav2fE4hdKNu+pQvHuNVicuAPMgZV4d6SdRkyNhhj9UEE1/Y0V/
	gAd53tsvS4Ozi4Sbw5YJ3ScbQu4YevMbOhNn8q9SC9fgsexrtoT2KkdM06rhKSjwMXO5nXKydqh
	UrmUL5y6bcG2JA/9pbDVsOGSVblNYEzf15RuPgM8zyJstdS7/oWo6svXmkh+E+EACRBIPx9de8j
	5zAzIP2V5vW8eM5RIFRkcmVrqHAikE1Ym8Ql9G9M7nWrU/FF+RH1OTNghPEjWtB4I9tk0KYabmt
	QYJZPlxNjz7bRiiziRKujYpND7FaubCiIXKuhI8dhjsR+0fhMZ/gWOPAXE8FxvJmL23YabMgm3Q
	SzXCHZoGLL8qx8Tf2obqbLml7YgmNLEBUdBTQ2refouRszE+NEzlPRkoya5Jkws058l+0dLS/TK
	fmfEL/gpAA9g=
X-Received: by 2002:a17:907:d15:b0:c2e:317e:d711 with SMTP id a640c23a62f3a-c49bdf0b1a9mr401098866b.27.1793270361414;
        Thu, 29 Oct 2026 03:39:21 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4992141068sm496431666b.60.2026.10.29.03.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:20 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 05/16] ovl: check that the parents of volatile/dirty are dirs
Date: Thu, 29 Oct 2026 11:39:09 +0100
Message-ID: <20261029103913.2785828-6-amir73il@gmail.com>
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

An unprivileged user crashes the kernel by mounting overlayfs with the
volatile option.

A dentry that serves as the parent of a lookup must be a directory.
ovl_create_volatile_dirty() walks work/incompat/volatile/dirty by name,
and ovl_lookup_or_create() returns an existing entry whatever its type.
A file or a symlink that another task creates during the mount becomes
the parent of the next lookup, which calls a NULL ->lookup.

An unprivileged user mounted overlayfs with "volatile" in a user
namespace while a second process created a symlink named work/incompat,
and the mount task oopsed on a NULL ->lookup call.

Fix this by returning -ENOTDIR from ovl_lookup_or_create() when the
caller asked for a directory and the existing entry is a non-dir.

Fixes: c86243b090bc ("ovl: provide a mount option "volatile"")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/super.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index bd0a3f9039d25..18f56d463572a 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -621,16 +621,21 @@ static int ovl_check_rename_whiteout(struct ovl_fs *ofs)
 
 static struct dentry *ovl_lookup_or_create(struct ovl_fs *ofs,
 					   struct dentry *parent,
-					   const char *name, umode_t mode)
+					   const char *name, bool is_dir)
 {
 	struct dentry *child;
 
 	child = ovl_start_creating_upper(ofs, parent, &QSTR(name));
 	if (!IS_ERR(child)) {
-		if (!child->d_inode)
+		if (!child->d_inode) {
 			child = ovl_create_real(ofs, parent, child,
 						&QSTR(name),
-						OVL_CATTR(mode));
+						OVL_CATTR(is_dir ? S_IFDIR :
+								   S_IFREG));
+		} else if (is_dir && !d_can_lookup(child)) {
+			end_creating(child);
+			child = ERR_PTR(-ENOTDIR);
+		}
 		end_creating_keep(child);
 	}
 	dput(parent);
@@ -652,7 +657,7 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ofs, d, *name, ctr > 1);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}
-- 
2.55.0

