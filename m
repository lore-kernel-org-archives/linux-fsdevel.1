Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C5954706B
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790391697; cv=none; b=rbyyJTC5MZjXO2oJ7+2jqrpb779m+W44epJ3EKjF5KlJ02P+xB64YwyGrjsqlGYg3vsQMSuTu0whUAWRbrsEA01C/+Tj/Azn1Ii3g7fGz+lsZyqwKhsvD/X+PAHNyx7NGA26zFgfUSrzGccYVn5VJ0XOi9hriy934naMV4BAJjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790391697; c=relaxed/simple;
	bh=WreOkf+pubCB2YPqHxKIYu9FitIBbawTqQnqjeNj3Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAIv9oz9RluwXPQhg2+BubJLi3tPK2C/pQw6DZs/E6aHrdyzCI1uBkq7MHJqPXXne7gtT1rNvPG5QtwdkKHMWT4vOZg8mCZAx/yZamN4YAa61A7IuwlcFnmMykcfzFMMKeJp+R2ZcgtJW2Ji/yFpImceJbE7cLl40pbQbUNxpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=hsUiWEM/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TPwKzn74; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="hsUiWEM/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TPwKzn74"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8AB927A00E5;
	Fri, 25 Sep 2026 23:01:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 25 Sep 2026 23:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790391695;
	 x=1790478095; bh=kSu31aocUzcYzaV1YdEEerwyVEPUaUyVfqAFCDz4HSA=; b=
	hsUiWEM/zKfr1aiLvfemk5iWYR5QKTIiDtl+ZjPZ3L7FqClq7ypEgjHHjtyYZ5d2
	NMyR/rvTBuk4Jg1jig4C5WZe/AX6u6pZf/KeJcrg+jUU3slsqsqjZ2hSB84Afi/f
	ZylUV8cHrBUpD/iTT2LJnGhQYUvdRwPrnu47S3aVS6S3rJKJgFzzPSYVjdV8K/z7
	t7NjGQji5mqgqW4rvd0m/J93kwB0COLzL4qFDrlGoLBWL5qd6IpoLhApnPPPhQ+L
	7UpuLf6fzI9dS7X7oNv894o9A7rCtIFx/5LAFC32tQvyKhf4LhYkwFZoI6bIlmow
	1x6074xZIcsBJUJkPkhFcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790391695; x=1790478095; bh=k
	Su31aocUzcYzaV1YdEEerwyVEPUaUyVfqAFCDz4HSA=; b=TPwKzn74ZFeYzpgGQ
	NTsYi9m8RnBzmnA+sLhKjw3oYkoKnMfscxk+p1edJynycOlpUvPFY2fYoad3ggtH
	9Bb0rMFw3gGyS0NwIprtwbPRG3J/7JF5QONJQbK73iDKJfh7+ClHzK/ylSrjYSiz
	DEC+4BQI8I1CwAikNPn/i95X3uNbF/vOraciLB+MQAfOHSme+DPJ1aXQq5nWPN1Q
	IuhP7g9hkkfeOa2DBt+FxSYz5mu2v97L5F6wqTv2AYA9Y0icaehcil25LkBMVzkg
	OdVNjxK7PUDxP8WPgi+TgZ/37gSuB4YHuElyjEjv2SND6Ouf9CGvYMQWskMnITDD
	DSFTQ==
X-ME-Sender: <xms:jzW3as2dmr7XvlxlghzBhcRjgO68oNjfjd64vbNXZRY8c3fZSUm9vA>
    <xme:jzW3apo-S4Omu9AoHi4W5VtCRS6ZMjJAcKz9aE7wyUGEZyD0YCUCMFosw3u99BzsF
    N_rHUcxcaq7MBIB_j-wBCzJGFgZqOK41tItNq78oYn-OaiKM4vD>
X-ME-Received: <xmr:jzW3aojYXUrtyaISpBJPbomKHrnRk-unBCbfLOuVwn_IgxixXjrr3SjfQwRyFqVjqvwZWmPqvc3rnMxC2nTMMtVultYBZfM>
X-ME-Proxy-Cause: dmFkZTGF7YpWubyzu579fb3slujvEFieLqPzpCtc5hxEQ6L4lVNSnbIULlGqjts7qW58y+
    fiT0LsxSLxPrEUq2phpCF3WfxXmMcNSrlRUtslDj9DY6InNnwyG5ElgIv0P1ksEjQOdF4f
    dY7iP287oVHqnyKstxicoV/3t1bbil4uJDXOkyrpw/L3I98BXHu3TNEDIOa5p4FE0sizkq
    a6AG2exOvowDXytBfSSY7xF/1KMITKSh3ACkC3VrNC1i2/q8qpt8TonMIY4NtHxPlpqVK6
    U2Aym4WtB79iItXHKNcF2C4TdawhSdOFqwrf15bpfAvErmeqoRRzZIEbgC0Miv6VTckMsl
    dUonoI3154Mz+SdTjdA0/n1Z20bIhHLC86wNAAC1ElCGscG7QDG37CsgmZQBIRuE8LUoKy
    WGP5b3ygfdmpjfGf8D6rxDuXVL1n1oOvlrx7tFyjVBnDkiwt4mQ+S8ukrnWFrPmWGsyIgh
    ykPtG0Rgxh4yfFl5hkbHkxZUKsv0UBcIabVshp7+QjSApuZmmpHFnO7fB1YpvvNTP3B8GG
    tu7BrQTmgnsNb41yKdD0RPFtIt2FxzxpW31T4Bv6lIwVP3pzYWM/TV/MHHD434oHKwJySI
    +3liCazQ3VTfsz9XCugiXw/3quExwcwdhsgOZaRozgsQ4xvBzzypLbLm8D/A
X-ME-Proxy: <xmx:jzW3al8XbJW0ES4T_TMdrS0ot6SGEdDNqgmB90aiMPXnbWnxx_pkLQ>
    <xmx:jzW3akV9GSuVFNVntk3dw5ezPC0hwkWLcNS-MKHkEdcUi2aF9xkUSg>
    <xmx:jzW3apAKpKPaIKjKrcCp4v9-fqe3y5HOSmJyFF2VpJy3O9pMp0fDIw>
    <xmx:jzW3apHbHHR951SF97wEnWBeuJY3XF8QCjLXngLEpQTFb5DuWt1U2g>
    <xmx:jzW3aqXCioe11fvSWyrwdch-cMhIU6S6srQSScBvkkEflljltlESPmJx>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 23:01:32 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org
Subject: [PATCH 5/5] afs: use d_duplicate()
Date: Sat, 26 Sep 2026 12:57:24 +1000
Message-ID: <20260926030052.467448-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260926030052.467448-1-neilb@ownmail.net>
References: <20260926030052.467448-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

To prepare for d_alloc_parallel() being permitted without a directory
lock, use d_duplicate() when duplicating a dentry in order to perform a
silly-rename.  This creates on in-lookup dentry which will contine to block
concurrent lookups after the original dentry is silly-renamed, and until
the final rename happens.

As the resulting dentry is in-lookup, we need to call d_lookup_done()
before d_put().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index b8773adc4e3e..dfd1930e2282 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -2075,7 +2075,10 @@ static void afs_rename_put(struct afs_operation *op)
 	store_release_wake_up(&op->dentry->d_flags,
 			      op->dentry->d_flags &~ DCACHE_BLOCKED);
 	spin_unlock(&op->dentry->d_lock);
-	dput(op->rename.tmp);
+	if (op->rename.tmp) {
+		d_lookup_done(op->rename.tmp);
+		dput(op->rename.tmp);
+	}
 }
 
 static const struct afs_operation_ops afs_rename_operation = {
@@ -2213,8 +2216,7 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			if (d_count(new_dentry) > 2) {
 				spin_unlock(&new_dentry->d_lock);
 				/* copy the target dentry's name */
-				op->rename.tmp = d_alloc(new_dentry->d_parent,
-							 &new_dentry->d_name);
+				op->rename.tmp = d_duplicate(new_dentry);
 				if (!op->rename.tmp) {
 					afs_op_nomem(op);
 					goto error;
-- 
2.50.0.107.gf914562f5916.dirty

