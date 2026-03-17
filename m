Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632F2BDC1B;
	Tue, 17 Mar 2026 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773717179; cv=none; b=YoRBxBeBXdb2WfGmmtFUcY24QYGWj12+GVEohXVpcCx6s/tPI9XZiRzj7CzZVrdROBETJh252bstZ5yDYR/Os8xMjpXisb5JdSQ2MGb5y1x6N5sqRo/aiK3LbKVgS3YwVWEm7KoaIgYoie2C85b6N+GJCHv6NgMUOgBx227gPK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773717179; c=relaxed/simple;
	bh=wj0ephWw75cma3VIbZb9tR8D3DLhc/9vyNBrB+ptDgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZwSuyN8VWufiEvUo1wf9qETySht13/GZB9wiIzgm0lWS6MS42Nm27Sp0m8hhdFUICr4Gr760+kd9Z+yJrg21yiiPK8n4uEDiIwoxBcPhkns6CCC+TOfrSWlNM9mt+CFVX37uHIlnZcNve08yOQNruH0iIRD4bU6bJmbLgSudCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=FWpkc9nD; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="FWpkc9nD"
Received: from DESKTOP-SUEFNF9.tailb3ad3b.ts.net (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 373255ad5;
	Tue, 17 Mar 2026 11:12:44 +0800 (GMT+08:00)
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
Subject: RE:  [PATCH] hfsplus: fix held lock freed on hfsplus_fill_super()
Date: Tue, 17 Mar 2026 11:12:45 +0800
Message-Id: <20260317031245.831887-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <054d2ebe267ef9c13468a05557cb099c49a0b872.camel@ibm.com>
References: <054d2ebe267ef9c13468a05557cb099c49a0b872.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cf9c8122d03a1kunm8ab794e511959d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaSE8YVkIfTEkZT0lCHkoZGFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUJCSU5LVUpLS1VKQk
	tCWQY+
DKIM-Signature: a=rsa-sha256;
	b=FWpkc9nD8qAmzuJbeb8ccq/LAspAC8LDtljpSXjq8RnaUwiRetWMryAlmyGgj/WhGqsyctiMQHnR9kxNYO60Jj7M4xY0UXepH6F41ahsEXCQ1NG1c6twaEmdaKEUs03hvYkVpR1ZafuW9tVFos86646LF0y3N12RMiSXMGDcNqs=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=9BUCZsCXv6+UElY2CbN98RVfEfVtSh5fodPAhOqOzcg=;
	h=date:mime-version:subject:message-id:from;

On Mon, Mar 16, 2026 at 10:46:14PM +0000, Viacheslav Dubeyko wrote:
> On Sat, 2026-03-14 at 11:36 +0800, Zilin Guan wrote:
> > To make the helper completely correct, we face another issue: the original 
> > code ignores all errors from hfs_brec_read() (which can return -ENOENT, 
> > -EINVAL, -EIO, etc.), treating them as non-fatal.
> > 
> > If we combine the fatal setup functions and the non-fatal read function 
> > into one helper, it cannot simply return a standard error code. It would 
> > need to return three distinct states:
> > 
> > 1. Fatal error -> caller must abort mount.
> > 2. Non-fatal read error -> caller must continue mount, but skip init.
> > 3. Success -> caller must init hidden_dir.
> > 
> > To handle all these cases properly, the helper would have to look 
> > something like this:
> > 
> > 	/* Returns < 0 on fatal error, 0 on missing/read error, 1 on success */
> > 	static inline int hfsplus_get_hidden_dir_entry(struct super_block *sb,
> > 						       hfsplus_cat_entry *entry) 
> > 	{
> > 		struct hfs_find_data fd;
> > 		int err;
> > 		int ret = 0;
> > 		/* ... init str ... */
> > 
> > 		err = hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
> > 		if (err)
> > 			return err; /* Fatal, fd not initialized */
> > 		
> > 		err = hfsplus_cat_build_key(sb, fd.search_key, HFSPLUS_ROOT_CNID, &str);
> > 		if (unlikely(err < 0)) {
> > 			ret = err;
> > 			goto free_fd; /* Fatal */
> > 		}
> > 
> > 		err = hfs_brec_read(&fd, entry, sizeof(*entry));
> > 		if (err) {
> > 			ret = 0; /* Non-fatal, but no entry to init */
> > 			goto free_fd;
> > 		}
> > 		
> > 		ret = 1; /* Success */
> > 
> > 	free_fd:
> > 		hfs_find_exit(&fd);
> > 		return ret;
> > 	}
> > 
> > And the caller:
> > 	
> > 	err = hfsplus_get_hidden_dir_entry(sb, &entry);
> > 	if (err < 0)
> > 		goto out_put_root;
> > 	if (err == 1) {
> > 		/* ... init hidden_dir ... */
> > 	}
> > 
> > We would have to invent a custom return state convention (1, 0, < 0) just to 
> > hide a single hfs_find_exit() call.
> > 
> > Given this, I think the current inline logic in my patch is much cleaner 
> > and avoids this convoluted error routing. 
> > 
> > What do you prefer?
> > 
> 
> I don't quite follow to your trouble. Any function can return various error
> codes and caller could process the different error codes by different logics:
> 
> err = hfsplus_get_hidden_dir_entry(sb, &entry);
> if (err == -ENOENT) {
>   <process -ENOENT>
> } else if (err == -EINVAL) {
>   <process -EINVAL>
> } else if (err == -EIO) {
>   <process -EIO>
> } else if (err == <some other error>) {
>   <process this case>
> }
> 
> Does it solve your trouble?
> 
> Thanks,
> Slava.

Hi Slava,

When considering the solution, my primary focus was to strictly preserve 
the original execution logic. Therefore, I was focusing more on which 
function returned the error rather than the specific error code itself.

The issue with routing by error codes is that different functions can 
return the same code but require different handling. For example, 
both hfs_find_init() and hfs_brec_read() can return -ENOMEM 
(the latter via __hfs_bnode_create).

In the original code:

- hfs_find_init() returning -ENOMEM is fatal (must abort mount).
- hfs_brec_read() returning -ENOMEM is non-fatal (clean up and continue 
mount).

If a helper simply returns err, the caller cannot distinguish which 
function failed, making it impossible to safely decide whether to abort 
or continue.

Since the helper approach adds unnecessary complexity, wouldn't it be 
better to stick with my original patch?

Thanks,
Zilin

