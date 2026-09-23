Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CEA38A725;
	Wed, 23 Sep 2026 05:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790142582; cv=none; b=l0I0xk1CBohLejTuOAeia2mY0YN0pazdmxk1wpA9ErreJqZg9j8I+4+OvYm63FA2tzd8w2EC/EL3Wb6QFv5BmNVxcGUS5DVuLzFsLR80QL6B6eBbx+wq31/q0Az/AiISvURR2XwNvLnjqrrG6xGZgPa2yUYEKy3wpJxVG2p/NlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790142582; c=relaxed/simple;
	bh=vT8RJz34w3HJasV0jOxaSYHk/g/wYgfzEFBwgejv/c4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoIvl5Du0dcSCnLVboDK8kUuZ4h/BxLw+LVyWQzE/Ie6aFSC9+06vWjfMYTjEYtj8pff1iSp7bey4OrOf+FWyh1JzdKaMtyN1iQuq5OfD33nDBQzZrus38flZthljj/dKRJzXP14JmS5EVrKtE4sAjFD3tIFSp95ik0gCGW5COY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hqQyQ74GSzTSdg;
	Wed, 23 Sep 2026 13:49:18 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4hqQyP0TLrzTSdg;
	Wed, 23 Sep 2026 13:49:17 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 7B6DF1032;
	Wed, 23 Sep 2026 13:49:10 +0800 (CST)
Received: from hsj-2U-Workstation (172.19.24.226) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 23 Sep
 2026 13:49:13 +0800
Date: Wed, 23 Sep 2026 13:49:11 +0800
From: Huang Shijie <huangsj@hygon.cn>
To: Christoph Hellwig <hch@infradead.org>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <zhongyuan@hygon.cn>,
	<fangbaoshun@hygon.cn>, <yingzhiwei@hygon.cn>, <jack@suse.cz>,
	<dev.jain@arm.com>, <ljs@kernel.org>, <adobriyan@gmail.com>,
	<akpm@linux-foundation.org>, <hpa@zytor.com>, <ryan.roberts@arm.com>,
	<mjguzik@gmail.com>, <joel.granados@kernel.org>, <jannh@google.com>,
	<oleg@redhat.com>, <aleksa@amutable.com>, <legion@kernel.org>,
	<kees@kernel.org>, <joannelkoong@gmail.com>, <tj@kernel.org>,
	<libaokun@linux.alibaba.com>, <ebiggers@kernel.org>, <sandeen@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/3] fs/drop_caches: skip filesystems without page
 cache
Message-ID: <arNoV2MdtTK-Ruw9@hsj-2U-Workstation>
References: <20260920072811.2064247-1-huangsj@hygon.cn>
 <20260920072811.2064247-2-huangsj@hygon.cn>
 <arIVBpMZk5-O2AZc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <arIVBpMZk5-O2AZc@infradead.org>
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

On Mon, Sep 21, 2026 at 10:41:26PM -0700, Christoph Hellwig wrote:
> On Sun, Sep 20, 2026 at 03:28:09PM +0800, Huang Shijie wrote:
> > Add a new flag SB_I_NO_PAGECACHE for superblock.
> > 
> > Skip scanning the inode lists of filesystems that have no page cache
> > in drop_pagecache_sb(), as indicated by the SB_I_NO_PAGECACHE flag.
> 
> I don't think we need a new flag.  This can check for
> 
> 	sb->s_bdi == &noop_backing_dev_info
> 
Okay. I can use this method.

> which is actually the more relevant concept - not if a file system
> uses the page cache, but if it supports page cache writeback.
> E.g. for ramfs there is page cache, but it is the only data store.
> For shmemfs, there is writeback, but it is driven in a different
> way (through the anonymous memory code and not fs writeback).
> 
> And most importantly it just work, no need to mark file systems,
> as you're currently missing a lot of those that can have a fair
> number of inodes, e.g., sysfs, kernfs, cgroupfs or configfs.
> 
I ever added support for these file systems, but I deleted the code before
I sent out this patch.

To Jan Kara,
   thanks for the information about the issue.
   I will check the inode iteration issue firstly.

Thanks
Huang Shijie



