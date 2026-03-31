Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF753D890A;
	Tue, 31 Mar 2026 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950855; cv=none; b=dcpxO5o/40FYZqzxbr/52mQjNMFNEBF5FimmlOjgJXNCYH6IHF1SIGMUKDC7A4VC20qlMBa590pzmqjgKVIlxd+Waz5k/KdI50508V2x6MCs9hGJ4QDAt5ytUTqP5CFswJeEX1weCG8h3XF8uQc/Lm4OpU2IEugGDphh+KtedI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950855; c=relaxed/simple;
	bh=f9ns15r1xwk5sR4slcu1NEUGIOE3AUuwDHqrtji267E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYS+mvlsyOVIQsPzdsujoY39Z/kfVIZmUBjlx7HMzBRhGqtE+6/odMX70b/B5ASmApsPpDBVNojHRTmT3J4tWZRTdCmV7wWefwwaglwjIHMEZuXnBzlsOxfOIlPsgZIq+6nOrXgZfXSCtoHTkxz4mHapQL1Qn6pRsr1wo7yBx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pdq2aUo3; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pdq2aUo3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774950845; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+1CK2WU7wxeMjp+cmJBinVyHFl9o+1lEgcOBYJ1X+2o=;
	b=pdq2aUo3ZimDYqx5WlA9wbc28tpv17qY92U8H+U7I2yheCWThb4bFBavOe/7IUVlYNt+0vCEsgpzQoBqu5Q6lpqtAjgHjTft7al/9zTjr66yk5GLYQxtUcFGV5Qtwd6vT4bF/CV8Mt8upiN0ZWvgQyV6/9HgnT8a4iQ5eLpxeXg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X04749J_1774950843;
Received: from 30.221.131.145(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X04749J_1774950843 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 31 Mar 2026 17:54:04 +0800
Message-ID: <4184b060-2923-4722-9899-c85238b8e3eb@linux.alibaba.com>
Date: Tue, 31 Mar 2026 17:54:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] vfs: limit directory child dentry retention
To: Christian Brauner <brauner@kernel.org>, Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>,
 Eric Sandeen <sandeen@sandeen.net>, Frank Sorenson <fsorenso@redhat.com>,
 Jay Shin <jaeshin@redhat.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Yafang Shao <laoar.shao@gmail.com>,
 Jan Kara <jack@suse.cz>, Waiman Long <longman@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Wangkai <wangkai86@huawei.com>,
 Colin Walters <walters@verbum.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20260331012925.74840-1-raven@themaw.net>
 <20260331012925.74840-2-raven@themaw.net>
 <20260331-engste-raushalten-f66cd264ce77@brauner>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260331-engste-raushalten-f66cd264ce77@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2026/3/31 17:39, Christian Brauner wrote:
> On Tue, Mar 31, 2026 at 09:29:09AM +0800, Ian Kent wrote:
>> If there's a very large number of children present in a directory dentry
>> then the benifit from retaining stale child dentries for re-use can
>> become ineffective. Even hashed lookup can become ineffective as hash
>> chains grow, time taken to umount a file system can increase a lot, as
>> well as child dentry traversals resulting in lock held too long log
>> messages.
> 
> Fwiw, there's also e6957c99dca5 ("vfs: Add a sysctl for automated deletion of dentry")
> 
> This patch introduces the concept conditionally, where the associated
> dentry is deleted only when the user explicitly opts for it during file
> removal. A new sysctl fs.automated_deletion_of_dentry is added for this
> purpose. Its default value is set to 0.
> 
> I have no massive objections to your approach. It feels a bit hacky tbh
> as it seems to degrade performance for new workloads in favor old
> workloads. The LRU should sort this out though.

JFYI, another issue we once observed on user workloads is that

`d_lockref.count` can exceed `int` on very very large
directories in reality (also combined with cached
negative dentries).

It can be a real overflow, this commit can help but it
doesn't strictly resolve this, anyway.

Thanks,
Gao Xiang
