Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37A38BF61
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636156; cv=none; b=oGzAy+XaC51S1La8/nmwxWGwN9cu7GKNkOMIeNI+9CSDOhDYAh2SIrpcXEmgoyKd2UNSpd4+0uwOp0DepMivZ2AHZGiuBKapjSqwfsVtxAfR4v1xr0pWPdP6x1p42qlKYfPxl9WGxCD8o5jennm6FYV9w7HkDYtFxBiiNJ09opA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636156; c=relaxed/simple;
	bh=n3Zqkrhp3D3Ffh+EW6CmtgG24FMy+IaNJZiuFvjrAGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw4OKptWLHjiZxjyrfIhSfXL/NYrqBXSiWRy+INRSnC3/80U//QuwcNv7yVRfvurcKSnV+HdVPC8OY8qxmmPpukuEIS8bjyf8fySRJPH2ecM8m/YW2HAmvBt93owIytzr9DJVF+ATfD8fTeFlGihHZRGNHYBeAJgLNZFBu8A4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=G7bbADDL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G7bbADDL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MIbQ53XwewwXttoduAW7fVFTEVo/FQYElZb91wqJ0Ow=; b=G7bbADDLJyPEisKlz1Qd+87qlA
	qkWIP9FV8rLosqDnTCyqucRXrQ33jOfvV5W46hcEb+PdETESyyuExK/OheXMvCNWDnXGkRVXBRMcn
	F/Rib6xu6OprPUBevtCqjg5h5vkf0AhguMWQ5w5nsMLPI9Knh1UfGMvGoUZWYlAGk+UX1kTkh4IlH
	QKtcD8NAITv2i9fIf1R+Fvkbb8U0YuTpBWT2zLP/K6rYYS7XTVouA3y802qg7RbltorqsMcFHMvpI
	l2b3LN4EC5pWe5ig/bqW4qa2b7rUR5/gYfqKDjLvV9MvqbKa0d4tVy9rfm3DUaq+AiBJXHJuMwAjq
	Y/dWHoVQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnw-00000005Ts9-0KnN;
	Fri, 05 Jun 2026 05:09:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 05/22] select_collect(): ignore dentries on shrink lists if they have positive refcounts
Date: Fri,  5 Jun 2026 06:08:53 +0100
Message-ID: <20260605050910.1306432-6-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

If all dentries we find have positive refcounts and some happen
to be on shrink lists, there's no point trying to steal them in the
select_collect2() phase - we won't be able to evict any of them.  Busy on
shrink lists is still busy...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index fa12e18906b9..40031b806b73 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1589,9 +1589,7 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 	if (data->start == dentry)
 		goto out;
 
-	if (dentry->d_flags & DCACHE_SHRINK_LIST) {
-		data->found++;
-	} else if (!dentry->d_lockref.count) {
+	if (!dentry->d_lockref.count) {
 		to_shrink_list(dentry, &data->dispose);
 		data->found++;
 	} else if (dentry->d_lockref.count < 0) {
-- 
2.47.3

