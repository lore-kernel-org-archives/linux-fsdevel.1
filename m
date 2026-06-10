Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3F405C50
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097495; cv=none; b=BfEP4iJt3GiRSNIp2zyiKt2VVlYEcG7P8uioxlUGAfy38u/J8qO6ItK8oReJZlk2Rvdp9XC/2y4VT6Mu+XTyItwoSUdZScQZAsFZZ6n3ZGcmQL9ceiwiXnDSnZq0ln9WGaHYFS+9CoDedV78hSfRedmN+b6FPDZy6BMfYWlzH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097495; c=relaxed/simple;
	bh=ujxIaLnlVIvCadkNke4HMhO5zez3kwvI70DtiBU+Pys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rI890tiUWw2uKtp1MunCPQii3A3vBNeKpH7jPx6yr64HJysz3AKGPsk/8WSsa1ZIhDN2X0c4uN6F9Eit0OkvaVAtCTab+cjPlWpXe/QUeqAWYOqas1HDvBe35lOf7j4CHTLecpVzuSAQD8YWLHwWudV7cgnLytQG9DZcqY4M/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TBQL4ylJ; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TBQL4ylJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781097485; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=A/HoLO1vkb28BfXkSR6vswnuPkF0Ts/nxZYlD2WzISg=;
	b=TBQL4ylJKbSvsQpfBUvDD+0E8h3QulXEEdla6Yj7SEKZyo7UZ+HaRf9bcdl1MnB0qHDWN/4fgId2jUc66k/Xsz2OewGyrT/t2Bt1ZCstTPjYc49dvMdY3BRHapt4MoP32g/m7n0EkmWHFS1Y9if1Al8CGNqVJsstSjwtqnC8psU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X4aj9G2_1781097484;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4aj9G2_1781097484 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Jun 2026 21:18:04 +0800
Message-ID: <64f23c85-2a83-42e4-ba09-c815dcb7c98c@linux.alibaba.com>
Date: Wed, 10 Jun 2026 21:18:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stacking filesystem deadlocks [was Re: Fanotify (hsm or erofs) /
 fuse / nbd / ... + write(mmap) deadlock vector followup]
To: Jan Kara <jack@suse.cz>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Gao Xiang <xiang@kernel.org>, Song Liu <song@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>
References: <d5f62836-62d1-4b8e-9694-bbab27112e7e@linux.alibaba.com>
 <649fdbbb-64f7-43d9-afd5-a3076e3ec946@linux.alibaba.com>
 <CAOQ4uxj+WAe+99FFi9RfMd5tpSwwP=rSH4dNuJEdhV1wL+5CDA@mail.gmail.com>
 <dff837f6-7480-4984-8728-802ddd78dda4@linux.alibaba.com>
 <CAOQ4uxi7DceKuh6+qGjuQJEFiE=HEFu4dMrc++VXUknRnX26JQ@mail.gmail.com>
 <95371379-97e9-4cb4-8358-ec014b765b74@linux.alibaba.com>
 <CAOQ4uxjh5VYkKLAKxhMsy-ZmrbRrgX4pFgBLFqsDqWMXeiqg3w@mail.gmail.com>
 <ac05da56-eb2a-4862-b887-8081f249d8ce@linux.alibaba.com>
 <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
 <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com>
 <5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5uvlflfxc5lq4rr@thr4hrkw67d2>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5uvlflfxc5lq4rr@thr4hrkw67d2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jan,

On 2026/6/10 20:21, Jan Kara wrote:
> Hi!
> 
> On Wed 10-06-26 16:17:33, Gao Xiang wrote:
>> Amir just suggested that I posted a long off-list discussion
>> on the list right now, but since it seems to relate to
>> `sb->s_writers.rw_sem` locking design, I am not quite sure
>> how deep I could help generally: But here it goes.
>>
>> The background is that we have discussed a generic deadlock
>> timing for several months as below:
>>
>> fsA is a filesystem which supports fsfreeze, such as EXT4/XFS/...
>>
>> fsB is a filesystem which have some relationship with a
>> userspace daemon (e.g. a filesystem with fanotify HSM hooks /
>>    fanotify + EROFS file-backed mounts / a FUSE filesystem or
>>    a filesystem backed by a virtual block device)
>>
>> Thread A                           Thread B                                 Userspace deamon
>>   write(fsA_fd, mmap(fsB_fd))
>>    file_start_write()
>>     (take SB_FREEZE_WRITE read lock)
>>
>>     handle fsB mmap fault read
>>      -> notify userspace and wait
>>
>>                                     freeze_super
>>                                     (try to take SB_FREEZE_WRITE write lock)
>>                                                                              received/handling fsB mmap read request
>>                                                                              (do random something...)
>>                                                                              write(fsA_fd2)
>>                                                                               (take SB_FREEZE_WRITE read lock)
>> The problem timing here is thread A does
>> `write(fsA_fd, mmap(fsB_fd))` => file_start_write() (rwsem read),
>> then hits page fault and wait for userspace deamon to finish
>> the request;
>>
>> Thread B does fsfreeze on fsA so it is waiting a write lock
>> (sb_wait_write(), rwsem write) and blocked on thread A;
>>
>> And the userspace deamon is a handler handling page fault,
>> and trying to write to another file (fsA_fd2) on fsA again
>> and blocked on thread B (file_start_write(), rwsem read).
>>
>> because of the specific locking timing is `R->W->R`, at least
>> the whole workflow won't proceed so the related processes
>> (and fsA above) will be stuck.
> 
> Thanks a lot for the good summary! It has helped me to look at the problem
> from a bit different angle and I don't think it's actually specific to
> filesystem freezing or fanotify HSM. Consider the following simple setup:
> 
> You have XFS filesystem fsA. On it you have a file imageA and you setup
> loop device loop0 over imageA and mount it as some filesystem fsB. Now you
> do write(imageA_fd, mmap(fsB_fd)) and you get a nice system deadlock (tried
> that and it really works :)). The problem is that write to imageA_fd
> acquires exclusively i_rwsem in imageA, then goes on to fault page on fsB
> which maps to a read from loop0 which maps to a read from imageA and
> xfs_file_read_iter() wants to acquire i_rwsem for imageA again.

Ah, great catch, but mainly because XFS takes i_rwsem read lock
on read paths LOL.

Yes, yet this deadlock sounds more like a fixed flow/pattern, which
is somewhat slightly different than fsfreeze issue since fanotify
needs racy between threads (causing RWR order casually and cause
Linux rwsem model deadlock) and may not need stacking filesystems.

I'm not sure how this deadlock can be avoided easily since it's
a deterministic single-thread timing, but as you said, at least it
needs privilege (like fanotify which needs privilege too).

btw, I remembered Miklos once mentioned some i_rwsem deadlock cases
too, maybe i_rwsem could cause some generic issue.

> 
> I would not consider this a real DoS vector since you generally need
> priviledge to perform such nasty write but still isn't not great the system
> can be deadlocked like this and I think we should fix cases like this.
> 
> Arguably, to address this particular case, we could block writes (and
> reads!) to a file that's used as a backing loop device file similarly
> as we do that for swapfiles but here I'm seriously worried of userspace
> regressions. I've seen userspace scripts setting up loop device and *then*
> running mkfs or editing partition table directly on the backing file.

but I think erofs file-backed mounts can just simply block write to
the backing file to avoid this: I don't think support this is useful,
but yes, it's also priviledged...

Thanks,
Gao Xiang

> 
> Also with the use of filesystem freezing on fsA, write to any target
> file (not only imageA) in fsA can create such deadlock if the page fault on
> the stacked filesystem ends up wanting to do some modification of imageA.
> So I don't think blocking IO to the loop device backing file will be even a
> complete fix.
> 
> I think the underlying reason why that write(imageA_fd, mmap(fsB_fd))
> pattern causes issues is that it essentially creates a loop in the stacked
> filesystem graph which can cause all sorts of lock inversions compared to
> the natural order of taking locks for the stacked filesystems. So can we
> somehow forbid that? Or do we simply not care and if priviledged user does
> something stupid, he gets to reboot the machine? Any other ideas?
> 
> 								Honza
> 

