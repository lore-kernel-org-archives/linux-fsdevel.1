Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270364;
	b=QBnK1waQ//1P2Dj55eCbJ3RPD8eyP+qQmE2MDjPbRCPY89MnIK6wC5KyM41phw1l7BGE
	 +OcaY9Xd7dBrmAg4LS+ZjzBTtFH9TpTuG5snaz45YITIAaQ+2VHWyzY9HqbgxazL2BfHu
	 MMr9paqQQFDnJgQ6B3uBGmykvFr+LzNyVlWqCstrjh6jw/CZHAY9eH8uOv2Ox1oXD+9j1
	 fM8Dr23ekjoE731RyyL6zvVUsGc004FfrZdeOQ8zEGb/b1Is1e3KWHlqeB4U+RhX99RN1
	 xdmmBJLlrQ5FqrZJq6C34v2X77JPS990B3hhxha1Y7TlmRJnV24wsac2AO4bB3EZbsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qi1ti4izdBvA4FPvYxDV0dCh2GnisjK7L+m92EFw0NM=;
	b=tk443BYg/CM0nOOz1B8vN5UBuW3gyopAk5f95mtvzNrIrv2COzfw3zJ59abZhySHI5nj
	 O0dgCpc/wxN1rdsmhlsMUUndfWBVU3NqkUil/LyuF6Nt0P/aGngrXNfR7DWp9OoNTBL00
	 MvbaqmsgB7sdrcbTMyCnKTQAMYBVyNQUwzdrNBax8OdGHR0CDqe+cSL4QyGJKXMtVpwwU
	 YwsWxjFBTB2VF2NrgDxTcTmAfd9RExLbqbfdv07IwaVW4cHS+bZAyajiwyaA75zDxWqbo
	 Rv1KwtZS6yY5NlHi6HWzQ1Aeqj6NRE8a/p2h34EBQgCtWnudX+BfvVbXlYPLMGd3rPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZDRv2pLU;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA8606A33C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65EA8606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZDRv2pLU
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c434376dbebso124707366b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270363; x=1793875163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qi1ti4izdBvA4FPvYxDV0dCh2GnisjK7L+m92EFw0NM=;
        b=ZDRv2pLUJPbNgSZHNvl7mvVRFXQCtghrzmmFCGGCTiaj8CrYAuuwIXlsUeMNrjmUyt
         /dYiXN4aVTQdzMwRtrGWdKFDsSFbsvmN/jYilysuxX7hKt0N16+nEbkCdXtrRcNPf27p
         XNoVxO/s32vhIS80Z2MpIJX2hz5Taoe1H0Dl6zftArOABJFcHSU1J2D5cP8Df0bklADl
         lJqyJT+DBrGppLr1LF1Hcr7BURvNSGiGfD5R4DiD0esrtk0CWafNoQHh+jvso3fQJD4E
         UajTQ5N1kFh1EI8tTwsHe30CtdFLRZ23GAdKBFnE1zfh2ZfnsfRcxGvIXcUHFO109HPn
         Z3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270363; x=1793875163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qi1ti4izdBvA4FPvYxDV0dCh2GnisjK7L+m92EFw0NM=;
        b=UKlNc7/j+tCt5MY3rsfsGzGJ6fhKXPe9vH2ZvDDHmQq+G8Yp8OaRstS/8Fqrl5nCEB
         eyIikkumPegTP1ZCidb7YTWxbqWuZM993GXfYOtzhUaH1EOy7pmdGVsbmCo/E9c34Yu4
         TKfvmiYUGs4skIpwug0OyjKRKJ6uTEfQoMXpJ6uGXKaAPz2lY6gse+CrSZLNkfbH5ThB
         dMgUiHCX4Lmwv67XgTE4QRSwxMwbdpi2asDrdc4p4/bDrZwywE3xrLRTNecnCq9+DYel
         6OguOItkr8lNkGRzsYiQaamGkgBgycjBYi5sNiU5iLuvheQHv34TarHX08+g71ObufQT
         i56Q==
X-Gm-Message-State: AFq9FYIC1SRvz1BsKPA3wUygkCeLS/PrYLNLz7r8EdTuIX8X7l3ILMIA
	/ON4q4YJV25hwE+a1owOY1j2Kj0pnlSpCFEvv2+MyA9MWUq8PZCVWykD
X-Gm-Gg: AYBFou34dFCeqzkC4Jq1qgJr/uZOxwSwMTWlwXfGOcvXvEGyPhGFiFbkgaByw0FDHNk
	2AcIXOSQZM9mPjWQpteWve7wUgmkUxqz1ESMmOnKYbxnaSV4V+Do5RUFxmp6MaN/0dO+mg5DoTO
	SNjvo9N+T/CyfgOUn8Bepg7mKb9dhYfxlgauWIMIytX2bjDC21eJDfD0OhNzTNoLlax1QaUT235
	y44H0mxTNW1qROVxA8lYNfr1NjB7pTxA9zfbIHHxTbYkQ1+9wUxAxYGJ999gZOynl/msS2b0cXK
	D+QoNQHleQTlIpXzrdRDZe0przr4EE6FrR69SQc8pWSH6bLaWsTZwiFQcKtg4szrsFuzGtOKSfW
	tgFzqMyutgoTDw9WILOeCgIhcYensqwpRe79XTdrubI85A5j86SlhgesPO/352Ije3tvrr2WSvx
	aBOduU+8HS449JpU4aLMZjpjZLlItJf/p+JgDzgt+2rjyN2hULnS66wPRb+fOAs9v/AhHruZp/k
	N1NoMSv7NYX+V4lhOl55wWR07sgfQvCblPeOYv/lOkx+WsXrJjXiEkNv84HJoOIKKMigwB6LzZN
	/n2fA2/m4wxfJUgetbSYBbi+BfyD6HfDBXmQGTpj24jddFGPKuJPTZ1KRP2OksZmLPISsxz/+TP
	7oXJUJNpsxHqM
X-Received: by 2002:a17:907:7294:b0:c42:4557:4532 with SMTP id a640c23a62f3a-c49d128171emr173949666b.5.1793270362388;
        Thu, 29 Oct 2026 03:39:22 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd7abf6asm708508566b.81.2026.10.29.03.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:21 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 06/16] ovl: take a snapshot of the name for copy up
Date: Thu, 29 Oct 2026 11:39:10 +0100
Message-ID: <20261029103913.2785828-7-amir73il@gmail.com>
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

The copy up of a directory reads a freed dentry name when a lookup
moves the directory at the same time.

A pointer to the name of a dentry is only valid while something stops
a move of the dentry. ovl_do_copy_up() keeps a plain copy of
c->dentry->d_name in c->destname, and ovl_copy_up_start() only keeps
ovl_rename() away. When a lookup finds the same directory under another
name after a change to the lower layer, d_splice_alias() moves the
dentry and frees its external name.

With a delay in ovl_do_copy_up(), a chmod of a lower-only directory with
a 60 byte name raced with a rename of that directory in the lower layer
and a stat of the new name, and KASAN reported a use-after-free in
lookup_noperm_common().

Fix this by using take_dentry_name_snapshot() for c->destname.

Fixes: 829c28be9bb9 ("ovl: use d_splice_alias() in place of d_add() in lookup")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 92b3d08a02349..12000e45fefc4 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -920,6 +920,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct dentry *origin = c->lowerpath.dentry;
 	struct ovl_fh *fh = NULL;
+	struct name_snapshot name;
 	bool to_index = false;
 
 	/*
@@ -957,12 +958,15 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		goto out_free_fh;
 	} else {
 		/*
-		 * c->dentry->d_name is stabilzed by ovl_copy_up_start(),
-		 * because if we got here, it means that c->dentry has no upper
-		 * alias and changing ->d_name means going through ovl_rename()
-		 * that will call ovl_copy_up() on source and target dentry.
+		 * ovl_copy_up_start() keeps ovl_rename() away from c->dentry,
+		 * because ovl_rename() calls ovl_copy_up() on source and target
+		 * dentry.  It does not stop d_splice_alias() from moving a
+		 * directory that a lookup found under another name after a
+		 * change to the lower layer.  That move frees an external name,
+		 * so take a snapshot.
 		 */
-		c->destname = c->dentry->d_name;
+		take_dentry_name_snapshot(&name, c->dentry);
+		c->destname = name.name;
 		/*
 		 * Mark parent "impure" because it may now contain non-pure
 		 * upper
@@ -971,7 +975,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		err = ovl_set_impure(c->parent, c->destdir);
 		ovl_end_write(c->dentry);
 		if (err)
-			goto out_free_fh;
+			goto out;
 	}
 
 	/* Should we copyup with O_TMPFILE or with workdir? */
@@ -1005,6 +1009,8 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 out:
 	if (to_index)
 		kfree(c->destname.name);
+	else
+		release_dentry_name_snapshot(&name);
 out_free_fh:
 	kfree(fh);
 	return err;
-- 
2.55.0

