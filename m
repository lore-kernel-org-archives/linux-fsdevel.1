Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C441B466B7B;
	Fri,  5 Jun 2026 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643477; cv=none; b=T7op08rk91YBpHtM/DZG5q7W2cUEaT3S5hYeSWmEfz7tqWwHi4tz/fdRdJhNkNJZMdPw1TDvbt07ZcuUXzpjgHwKlRKbpQorU0dIrPOoZfxSZfgg7WV9akz6VETC8Bb8fbDiyTC+xC2EGt5fXPGffoiOMqcp1+M+QsTxm3NZvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643477; c=relaxed/simple;
	bh=9YzHfib5neIno6PJMmidOBHPmujVrHn8bcHq05Ewz48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPvELvJMa1DFZH5QqZjq1ZT/Ns5tWjsLTHN9mC3M+qekEQH9hfpCF/rGu83T5MdP3O84UE82AezCmXILZl6tfUi1QzQQbHjyajq2R9vW/frAZVo9cya2lPHC9EETVuj2cM4nU4twEM9RWWrsG6g3fblLxLWexQjed8bCwail3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rGvDyLUT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rGvDyLUT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EYBmiuQpiCAOquy0r5JrYQN+jT1v9vlOQoLycUsYt7U=; b=rGvDyLUTvr57DepeobbBTKec4+
	ArLZcbUkR1WO1rg02bSuBSfXdnwiTs1a5Opd5a4mKnJvOdMgUGHavCQAEQRaAh+2FJ9gYJ/lQgtEA
	E+vahcUsuM3L/ccRITHf/G2AybsUlrDTmzpljbQj9KH/XlbGtna3nNwbZ7Dax00WOI/HnoIWjIUXk
	6EmGSOrVzE25Uw56WnLaUlhC58C77RtajFqnGGNQ4+CVZpQrs8Y/BORdXhRH4oaIUGzcer2TkRBJ2
	NIYJtg0nwbCU99zsIF6O+v404wNpl9OX7W1jFFdjkwcr6HRyL+wDRstvRBGCEwoVOhlKosGaY/8OB
	sbNtuHTQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVOi0-00000005x7j-2Adg;
	Fri, 05 Jun 2026 07:11:12 +0000
Date: Fri, 5 Jun 2026 08:11:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:more.configfs] [configfs]  2bbdcd7eab:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20260605071112.GD2636677@ZenIV>
References: <202606051115.319be2bc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202606051115.319be2bc-lkp@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 05, 2026 at 01:52:28PM +0800, kernel test robot wrote:
> 
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> 
> commit: 2bbdcd7eabfcd3a5bd2614ab75ece19323d5f4c2 ("configfs: attach the subtree only when it's completely built")
> https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git more.configfs
> 
> in testcase: boot
> 
> config: i386-randconfig-013-20260604
> compiler: gcc-14
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)

D'oh...  Minimal incremental to deal with that would probably be something like
the delta below, but it's probably better to have configfs_add_subtree() return
the resulting dentry instead...

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index dacf0187f814..da5e554de58f 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1448,7 +1448,7 @@ int configfs_register_group(struct config_group *parent_group,
 	if (!IS_ERR(child)) {
 		ret = configfs_add_subtree(group, NULL, child, frag);
 		if (!ret) {
-			sd = child->d_fsdata;
+			sd = group->cg_item.ci_dentry->d_fsdata;
 			sd->s_type |= CONFIGFS_USET_DEFAULT;
 		}
 		simple_done_creating(child);
