Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031442DF12F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773721083; cv=none; b=R1j/H++il3dfPwdd4a24QFknVhhKLcXRbswkPPGRq+E+3YEMhnaUejxvzJ2VqCA3KNPTe6ddALYoDDIDC2YM/b0i1CM4hV/aOHDoM41H4G/Piq2DWBNCQqeu0+B0zOpnXQtsgqkXK7DFQI3udnXCTKRlPfJxRcIFWI+mJwpSzUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773721083; c=relaxed/simple;
	bh=O1OA6Nvy/k0N0V1idnL+eVaURLIIbY7qRrFfXsugXog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYJMrqf7yshLvPu8ZimBZR7unXwFX3wlvc7Lw9xNSqCDs0fMHa6CTvhap1Z9eDIf+G7MYaj/2/gKDYOQdJ1JaJ9K/3wCmOdfhLxY3ezvfwHG25OYtlzXWMbidzPxi5M2U2HmayYy5zrDgwT4/hCqWqFMKduHaT2pFoAHW2dUSNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OFmBmDqJ; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OFmBmDqJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773721071; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=huJ+6I/4h2C6Rbj4IyRnvv3asu+etGZ2+/amA5VH2ok=;
	b=OFmBmDqJmDcr2okVfsUy8D4yIEJYNbieGfEZ1a8JFgkfMUyetVctbdTTmQqzScOZjps400vxBvd0whFX26Gld4vqTnssQq/NM8hD7jstzdbu3o8r8WT6vO975rQeXHV8YZLNSK9NAZ39VizNiPzELHrCTzuceKoy+RiHxGUqN/4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X.9XZRQ_1773721069;
Received: from 30.221.133.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.9XZRQ_1773721069 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 12:17:50 +0800
Message-ID: <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
Date: Tue, 17 Mar 2026 12:17:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>,
 Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>,
 Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>,
 Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
 <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
 <20260221004752.GE11076@frogsfrogsfrogs>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260221004752.GE11076@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Darrick,

On 2026/2/21 08:47, Darrick J. Wong wrote:
> On Fri, Feb 06, 2026 at 02:15:12PM +0800, Gao Xiang wrote:

...

> 
>>>
>>> Fuse, otoh, is for all the other weird users -- you found an old
>>> cupboard full of wide scsi disks; or management decided that letting
>>> container customers bring their own prepopulated data partitions(!) is a
>>> good idea; or the default when someone plugs in a device that the system
>>> knows nothing about.

I brainstormed some more thoughts:

End users would like to mount a filesystem, but it's unknown that
the filesystem is consistent or not, especially for filesystems
are intended to be mounted as "rw", it's very hard to know if the
filesystem metadata is fully consistent without a full fsck scan
in advance.

Considering the following metadata inconsistent case (note that
block 0x123 is referenced by the inconsistent metadata, rather
than normal filesystem reflink with correct metadata):

  inode A (with high permission)
  extent [0~4k)               maps to block 0x123

  random inode B (with low permission)
  extent [0~4k)               maps to block 0x123 too

So there will exist at least three attack ways:

  1) Normal users will record the sensitive information to inode
     A (since it's not the normal COW, the block 0x123 will be
     updated in place), but normal users don't know there exists
     the malicious inode B, so the sensitive information can be
     fetched via inode B illegally;

  2) Attackers can write inode B with low permission in the proper
     timing to change the inode A to compromise the computer
     system;

  3) Of course, such two inodes can cause double freeing issues.

I think the normal copy-on-write (including OverlayFS) mechanism
doesn't have the issue (because all changes will just have another
copy). Of course, hardlinking won't have the same issue either,
because there is only one inode for all hardlinks.

I don't think FUSE-implemented userspace drivers will resolve
such issues (I think users can only get the following usage reclaim:
"that is not the case that we will handle with userspace FUSE
drivers, because the metadata is serious broken"), the only way to
resolve such attack vectors is to run

the full-scan fsck consistency check and then mount "rw"

or

using the immutable filesystem like EROFS (so that there will not
be such inconsisteny issues by design) and isolate the entire write
traffic with a full copy-on-write mechanism with OverlayFS for
example (IOWs, to make all write copy-on-write into another trusted
local filesystem).

I hope it's a valid case, and that can indeed happen if the arbitary
generic filesystem can be mounted in "rw".  And my immutable image
filesystem idea can help mitigate this too (just because the immutable
image won't be changed in any way, and all writes are always copy-up)

Thanks,
Gao Xiang
