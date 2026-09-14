Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB6F46D555;
	Mon, 14 Sep 2026 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387875; cv=none; b=WMIbyM2cgas3C9tRy2Ci0SROhLIYzcgfT98Y1WiSvoLknpDp3k8M8HmhTvV3I+jQsu0Dtn38PIo2DcoKmZnbzPLmAsMY98NwccneIfKxiz/o05q7pVoUcSjsG0efnZcGXrcJOMc78wb1Ipku/i/f/wo2eBCHIxkmYPes4vdlmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387875; c=relaxed/simple;
	bh=BfCF52edpp8mH2plXPnBsGk/siPwAVEpfm8El73Bf4w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZVxcsQfLpNfVfZZ2qD9B+FZ9ufnwfwV4R7X0T7NwRSAmL7uYLfg/pGFZ078NW4RJSwSJOBhfpxtv1UFKP5yP39mY0hvTP/02bP+BOKXRJKOpL6pFLDUcswiCFN4ZXcDY7qAV39ydFJPBh2Yutwim6567iHw7p5T7HtA8XPcBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hk3rr5s38z2CZqw;
	Mon, 14 Sep 2026 20:10:52 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hk3rp6G7Sz2CZqw;
	Mon, 14 Sep 2026 20:10:50 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id DE797B35D;
	Mon, 14 Sep 2026 20:10:47 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 14 Sep
 2026 20:10:48 +0800
Date: Mon, 14 Sep 2026 20:10:45 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <zhongyuan@hygon.cn>,
	<fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>, <jack@suse.cz>,
	<dev.jain@arm.com>, <ljs@kernel.org>, <akpm@linux-foundation.org>,
	<hpa@zytor.com>, <ryan.roberts@arm.com>, <mjguzik@gmail.com>,
	<joel.granados@kernel.org>, <jannh@google.com>, <oleg@redhat.com>,
	<aleksa@amutable.com>, <legion@kernel.org>, <kees@kernel.org>,
	<joannelkoong@gmail.com>, <tj@kernel.org>, <libaokun@linux.alibaba.com>,
	<ebiggers@kernel.org>, <sandeen@redhat.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] fs/drop_caches: do not scan procfs in
 drop_pagecache_sb()
Message-ID: <aqfkRSO-Fa9-_754@hsj-2U-Workstation>
References: <20260914061449.4024632-1-huangsj@hygon.cn>
 <20260914061449.4024632-2-huangsj@hygon.cn>
 <c566b9eb-7cad-4a03-bf53-ae3b3e699559@p183>
 <aqfhiHlogbbADDkP@hsj-2U-Workstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aqfhiHlogbbADDkP@hsj-2U-Workstation>
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)

On Mon, Sep 14, 2026 at 07:59:09PM +0800, Huang Shijie wrote:
> On Mon, Sep 14, 2026 at 12:19:03PM +0300, Alexey Dobriyan wrote:
> > On Mon, Sep 14, 2026 at 02:14:47PM +0800, Huang Shijie wrote:
> > > There is no page cache for the procfs, so do not scan the
> > > inodes in procfs.
> > 
> > > @@ -20,6 +21,9 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
> > >  {
> > >  	struct inode *inode, *toput_inode = NULL;
> > >  
> > > +	if (sb->s_magic == PROC_SUPER_MAGIC)
> > > +		return;
> > 
> > This should be some flag somewhere in superblock.
> > Other fake filesystems don't support pagecache too.
> yes.
> 
> It seems it is better to check like this:
>         if (sb->s_bdi == &noop_backing_dev_inf)
> 		return;
> 
I find check noop_backing_dev_info is not right, the tmpfs may also use it.

It seems there is no flag in superblock for us.
If we have no choice, I can add a new flag for it.


