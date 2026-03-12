Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471C033D507;
	Thu, 12 Mar 2026 02:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282770; cv=none; b=o0F/itEu646CSJlRO6lNqns/7Q4CrST/AS3JqfCYdhHA48WHj3A+tJTCEEKqcfJkHS2t31pE2Vx6Eh1ScI/AugTT10kaVK6O5Oov+/s3okBt0qXJrHwOGoZHaKIr5M1VqPfH+kcX9VJaN4UhqDPqZlNsRZC4ohvciylfXf/hADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282770; c=relaxed/simple;
	bh=k+Ne3ped2Jd9193BfFYKMJGxDHiSxuC2PFR2Oy+SPIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0rJ22OR6yaYwY+6KB8LtfUJno9VkqpT4Sx+QJQWzrtj8RwqN34g90xn7Q63v9gSwwIfNtvce/2g6RRNLomCN2HFKynbpC0UN7WfjWQ1cCMm4nutUIsDFMLUz5Ugr1FSs8XGgv+rcL9EoElKnC9R1pNsruEvaBCr/Vp7l83Thho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=hEVVg/7h; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="hEVVg/7h"
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 36a2432cc;
	Thu, 12 Mar 2026 10:17:27 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: slava.dubeyko@ibm.com
Cc: akpm@linux-foundation.org,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	jianhao.xu@seu.edu.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	sougata@tuxera.com,
	stable@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re:  [PATCH] hfsplus: fix held lock freed on hfsplus_fill_super()
Date: Thu, 12 Mar 2026 10:17:28 +0800
Message-Id: <20260312021728.446944-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <afab59a14da6ee4dd23d8ef85301ccff451b87cb.camel@ibm.com>
References: <afab59a14da6ee4dd23d8ef85301ccff451b87cb.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cdfd5a6c403a1kunm1d5e9d55263e6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTx4eVkhDGBlLSRkdSUgaSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQktCWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=hEVVg/7hHKsmjDBlvoKj1IWBEYYDqitEBzUJfYF8sg6jCeRjTMCkWcyCZkX/zM76qq2AB/smLRY0AWeSoEGxXmPICbFY4U1cqwfyNgJzvad1FVx/dJRqNEW1dQxwvHOg3bvx4I52SoaecNctl2/35gG+y+odbhHaSwp5428YwEQ=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Ujvh4SDEcmnNJUUfXaquApesA8XXZa3dzQCOsqyLgOE=;
	h=date:mime-version:subject:message-id:from;

On Wed, Mar 11, 2026 at 09:17:59PM +0000, Viacheslav Dubeyko wrote:
> On Wed, 2026-03-11 at 19:43 +0800, Zilin Guan wrote:
> >  fs/hfsplus/super.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> > index 7229a8ae89f9..f396fee19ab8 100644
> > --- a/fs/hfsplus/super.c
> > +++ b/fs/hfsplus/super.c
> > @@ -569,8 +569,10 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
> >  	if (err)
> >  		goto out_put_root;
> >  	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
> > -	if (unlikely(err < 0))
> > +	if (unlikely(err < 0)) {
> > +		hfs_find_exit(&fd);
> >  		goto out_put_root;
> > +	}
> >  	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
> >  		hfs_find_exit(&fd);
> >  		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
> 
> Makes sense.
> 
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> 
> Frankly speaking, I think, potentially, we can introduce static inline function
> for this code:
> 
> 	str.len = sizeof(HFSP_HIDDENDIR_NAME) - 1;
> 	str.name = HFSP_HIDDENDIR_NAME;
> 	err = hfs_find_init(sbi->cat_tree, &fd);
> 	if (err)
> 		goto out_put_root;
> 	err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID,
> &str);
> 	if (unlikely(err < 0))
> 		goto out_put_root;
> 	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
> 		hfs_find_exit(&fd);
> 		if (entry.type != cpu_to_be16(HFSPLUS_FOLDER)) {
> 			err = -EIO;
> 			goto out_put_root;
> 		}
> 		inode = hfsplus_iget(sb, be32_to_cpu(entry.folder.id));
> 		if (IS_ERR(inode)) {
> 			err = PTR_ERR(inode);
> 			goto out_put_root;
> 		}
> 		sbi->hidden_dir = inode;
> 	} else
> 		hfs_find_exit(&fd);
> 
> Because, hiding this code into small function will provide opportunity to call
> hfs_find_exit() in one place only (as for normal as for erroneous flow).
> 
> What do you think?
> 
> Thanks,
> Slava.

Thanks for the feedback, Slava.

While I see the merit in refactoring this into a helper to centralize the 
cleanup, I’m concerned that doing so wouldn’t actually achieve a single 
hfs_find_exit() call without compromising the resource lifecycle.

In the current logic, we need to call hfs_find_exit(&fd) as early as 
possible—specifically before entering hfsplus_iget(), which might involve 
further I/O or sleeping. If we were to use a single-exit goto pattern in a 
helper function, we would end up holding the search data and its 
associated buffers/locks longer than necessary. To maintain the current 
early-release behavior, we would still be forced to sprinkle multiple 
hfs_find_exit() calls across different branches within that helper anyway, 
which defeats the purpose of the refactoring.

Given that this is a straightforward fix for a specific leak, I believe 
keeping the logic inline preserves the optimal resource release timing 
without adding unnecessary abstraction.

Best regards,
Zilin
