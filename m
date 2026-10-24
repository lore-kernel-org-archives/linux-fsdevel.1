Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877669;
	b=pupT/ZygpM7NpTL0FHLAkQcWdpbisKoH1eWNsNahTwjUUjHFVkBdp3h/+7HxKQ1oBd7I
	 IPHAEKppWWadiwitNIRQTmValtgAoXfkvjmp5qmqFROjlqg1TwGCAphpoCfCzbwKtnvZU
	 5PMiIQvVDLwr06kL4YNdpqD96pMpjxSaQEkmNKSG8X1AI4JiMZQ2bD2ejAuvPekzfbOmW
	 tgAdz8iV5Io1SgTsu1lFCHvzmqqQYmuMUxQ6DYM9X1BPi+m0GH3rS2ExvWjipIel0Cy8u
	 KLmVPQxXkvjIOMR1xqNtVdLrQ6+b15SEy8znGu+E0zMzfBjnwq0hnB6jUKePx3JP/PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877669;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4rq6SNd3qgJAF7LHCk9l0O7pVqpDieM+QwGPe5DTXZw=;
	b=DRcLL1S3JwSZlkXMrarjMdKre6qu2zXHIxhlMKkayaz+t1il0wPosU3aQas5zisosqpP
	 uvO3yqegaC7f1MLDKc5og/kTTbGkVqj5BKHydbQNUbjX3yum00RC0ED3f/vRSZf6xWLhA
	 n2cViGNa1C+Nx1Ggdc7omu71ub6lcqRkRzjlbV6ZcFE+BfsQ2/KofywC0PR9NxOjc9ntq
	 xdcZNoRSj0XMAuRkwCA5HuaCfY8omEAHCltpZ3eqXzUAPTioAjk0tuA9EzeXiSB6oCZ9Z
	 uNquZwyziXnck77OsH1ffRAetNr8xObiKG+P4mF7URmvyNwUduILUNdI9hjX+L0m6CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=DyHGawhM;
	arc=none smtp.remote-ip=195.121.94.185
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C81606A31E
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 21:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24C81606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=DyHGawhM
X-KPN-MessageId: aa069e97-cff2-11f1-9136-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id aa069e97-cff2-11f1-9136-005056999439;
	Sat, 24 Oct 2026 23:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=4rq6SNd3qgJAF7LHCk9l0O7pVqpDieM+QwGPe5DTXZw=;
	b=DyHGawhMsxSOFSDzydXxUzU8ujN3tgJkKAKuAKnj0t5GXcyZ/AQRiQ6y2AQLV5Ahr/Fe7SpxeQjae
	 igIB1N60WyjTHwwZ3v7zPLtcGwkQbh7WoxrENzb9DzxG+CW1QZzwkQXPPRhuN719qj4D7diwj+prYn
	 BYHzwgB2Pz64oqcYX7VO1GjjAx1LEUELgIYLOwf7eiyB0XcGSEUpudAUvnMd7CxnLJERnpErTeDtvF
	 WQjH0kELGQlZRT0KAFOOJW/L3idshFzqRUrWfHby+Q2Wu5NM58IiDiJppggD+q+OKB81i1RpaNo5Co
	 /XqORKZtTXFFUc0+ZSvaLEPUDEUNhPQ==
X-KPN-MID: 33|YdICPgyF075u80d9SmzFn2/DvwaVx1dTlFexsJA0fjVv7RVZjDu9PFx7EqD66G5
 ezgS1qFlZ8ngxtmvj8k/X6XhKAYXZExckAJ1yp5r224Y=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gj2cmCZew2x5bTEp/moicMlZGw5ATxqWXOek1ANYA8bNTgcDIXHosRK4uJPtePH
 Xkm/M4yP/1uoetxM/lwRvBA==
Received: from daedalus.home (unknown [178.227.247.81])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id a9cb24ec-cff2-11f1-8686-00505699b758;
	Sat, 24 Oct 2026 23:34:16 +0200 (CEST)
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
Subject: [PATCH v8 01/12] fs/namei.c: use trailing_slashes()
Date: Sat, 24 Oct 2026 23:35:28 +0200
Message-ID: <20261024213539.1307600-2-jkoolstra@xs4all.nl>
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

There are several places in fs/namei.c that can use the
trailing_slashes() function to improve context. To allow this broader
use its signature is changed to take a struct qstr instead of a struct
nameidata.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 22c4f328b8a9..b90263a07e4e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2781,9 +2781,16 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	return s;
 }
 
+static inline bool trailing_slashes(const struct qstr *last)
+{
+	/* last->len is set by hash_name() to the length of the current
+	 * component ->name, terminating with '/' or a NUL character. */
+	return (bool)last->name[last->len];
+}
+
 static inline const char *lookup_last(struct nameidata *nd)
 {
-	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
+	if (nd->last_type == LAST_NORM && trailing_slashes(&nd->last))
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	return walk_component(nd, WALK_TRAILING);
@@ -4697,17 +4704,12 @@ struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
 }
 EXPORT_SYMBOL_FOR_MODULES(vfs_lookup_open, "nfsd");
 
-static inline bool trailing_slashes(struct nameidata *nd)
-{
-	return (bool)nd->last.name[nd->last.len];
-}
-
 static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 {
 	struct dentry *dentry;
 
 	if (open_flag & O_CREAT) {
-		if (trailing_slashes(nd))
+		if (trailing_slashes(&nd->last))
 			return ERR_PTR(-EISDIR);
 
 		/* Don't bother on an O_EXCL create */
@@ -4715,7 +4717,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 			return NULL;
 	}
 
-	if (trailing_slashes(nd))
+	if (trailing_slashes(&nd->last))
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	dentry = lookup_fast(nd);
@@ -5097,7 +5099,7 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 * Do the final lookup.  Suppress 'create' if there is a trailing
 	 * '/', and a directory wasn't requested.
 	 */
-	if (last.name[last.len] && !want_dir)
+	if (trailing_slashes(&last) && !want_dir)
 		create_flags &= ~LOOKUP_CREATE;
 	dentry = start_dirop(path->dentry, &last, reval_flag | create_flags);
 	if (IS_ERR(dentry))
@@ -5713,7 +5715,7 @@ int filename_unlinkat(int dfd, struct filename *name)
 		goto exit_drop_write;
 
 	/* Why not before? Because we want correct error value */
-	if (unlikely(last.name[last.len])) {
+	if (unlikely(trailing_slashes(&last))) {
 		if (d_is_dir(dentry))
 			error = -EISDIR;
 		else
@@ -6315,16 +6317,16 @@ int filename_renameat2(int olddfd, struct filename *from,
 	if (flags & RENAME_EXCHANGE) {
 		if (!d_is_dir(rd.new_dentry)) {
 			error = -ENOTDIR;
-			if (new_last.name[new_last.len])
+			if (trailing_slashes(&new_last))
 				goto exit_unlock;
 		}
 	}
 	/* unless the source is a directory trailing slashes give -ENOTDIR */
 	if (!d_is_dir(rd.old_dentry)) {
 		error = -ENOTDIR;
-		if (old_last.name[old_last.len])
+		if (trailing_slashes(&old_last))
 			goto exit_unlock;
-		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
+		if (!(flags & RENAME_EXCHANGE) && trailing_slashes(&new_last))
 			goto exit_unlock;
 	}
 
-- 
2.56.0

