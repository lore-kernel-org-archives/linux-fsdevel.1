Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D8C40B392
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107137; cv=none; b=l9lFYOqhVycIN93POGGbE4NwABrKnCpSJ2AHxxKeXIO2NE2T11LWZ7y94ujHx9w/xwfDpJTxFGNJ3rvzvfnpXUGu1rnJvEndy7zXzms31hYTvTXntvWUPOIabhx9FBISzjKpwm5Jc+sOy1Gmzp3EMk7aFsPh9X80k3wGEfODQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107137; c=relaxed/simple;
	bh=sPKj19FGuki1tXoWaOcH83aMxdQ/hMgFTbLhdwK5Oq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rnkfXo9QMKhjdHL5GxqSuUdiVWz2vzgeoQQrKcESjWvtYNtlh/Gg8d7JT+ytPVkMLs3a4tqivZg1IJRkjIRDMiGKDFWbuv2AY/Ldk4h602zK6XdXT9m+Xj4G/5U5Ja/JPQLbf+2iIZHgB+YumhqPscr7u98R3bqmUWOHceUAecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YC5iwpYk; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YC5iwpYk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781107132; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tQjSIO2x6yXWrKAeZpr4bH9seY3LfLe32rAz685GtMo=;
	b=YC5iwpYkOiY4SQrAx3EvaLCn8v+ua3YZfLTlKrq5qf4eR+zPgWg1J5gEdzQPdkTqc/17wDwDEgTLnwS7ndR7MEwsmA1txhEN2EJZlrxiI0+4HZ7J2COYP8tk7Q1WShnLwUCC0c5H09SQ6X68VjHG63r/Ba0zkbE1JZZMHtqWIzo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X4b0uks_1781107130;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X4b0uks_1781107130 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Jun 2026 23:58:51 +0800
Message-ID: <f6758f23-5467-4fbf-a111-504fd379c800@linux.alibaba.com>
Date: Wed, 10 Jun 2026 23:58:49 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stacking filesystem deadlocks [was Re: Fanotify (hsm or erofs) /
 fuse / nbd / ... + write(mmap) deadlock vector followup]
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Gao Xiang <xiang@kernel.org>, Song Liu <song@kernel.org>
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
 <64f23c85-2a83-42e4-ba09-c815dcb7c98c@linux.alibaba.com>
 <CAOQ4uxiaYCt-kkLk=UHML-9bVxqin=5mEAB+uFPVGR7Hq6ppDg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxiaYCt-kkLk=UHML-9bVxqin=5mEAB+uFPVGR7Hq6ppDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/6/10 23:40, Amir Goldstein wrote:
> On Wed, Jun 10, 2026 at 3:18 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Hi Jan,
>>
>> On 2026/6/10 20:21, Jan Kara wrote:
>>> Hi!
>>>
>>> On Wed 10-06-26 16:17:33, Gao Xiang wrote:
>>>> Amir just suggested that I posted a long off-list discussion
>>>> on the list right now, but since it seems to relate to
>>>> `sb->s_writers.rw_sem` locking design, I am not quite sure
>>>> how deep I could help generally: But here it goes.
>>>>
>>>> The background is that we have discussed a generic deadlock
>>>> timing for several months as below:
>>>>
>>>> fsA is a filesystem which supports fsfreeze, such as EXT4/XFS/...
>>>>
>>>> fsB is a filesystem which have some relationship with a
>>>> userspace daemon (e.g. a filesystem with fanotify HSM hooks /
>>>>     fanotify + EROFS file-backed mounts / a FUSE filesystem or
>>>>     a filesystem backed by a virtual block device)
>>>>
>>>> Thread A                           Thread B                                 Userspace deamon
>>>>    write(fsA_fd, mmap(fsB_fd))
>>>>     file_start_write()
>>>>      (take SB_FREEZE_WRITE read lock)
>>>>
>>>>      handle fsB mmap fault read
>>>>       -> notify userspace and wait
>>>>
>>>>                                      freeze_super
>>>>                                      (try to take SB_FREEZE_WRITE write lock)
>>>>                                                                               received/handling fsB mmap read request
>>>>                                                                               (do random something...)
>>>>                                                                               write(fsA_fd2)
>>>>                                                                                (take SB_FREEZE_WRITE read lock)
>>>> The problem timing here is thread A does
>>>> `write(fsA_fd, mmap(fsB_fd))` => file_start_write() (rwsem read),
>>>> then hits page fault and wait for userspace deamon to finish
>>>> the request;
>>>>
>>>> Thread B does fsfreeze on fsA so it is waiting a write lock
>>>> (sb_wait_write(), rwsem write) and blocked on thread A;
>>>>
>>>> And the userspace deamon is a handler handling page fault,
>>>> and trying to write to another file (fsA_fd2) on fsA again
>>>> and blocked on thread B (file_start_write(), rwsem read).
>>>>
>>>> because of the specific locking timing is `R->W->R`, at least
>>>> the whole workflow won't proceed so the related processes
>>>> (and fsA above) will be stuck.
>>>
>>> Thanks a lot for the good summary! It has helped me to look at the problem
>>> from a bit different angle and I don't think it's actually specific to
>>> filesystem freezing or fanotify HSM. Consider the following simple setup:
>>>
>>> You have XFS filesystem fsA. On it you have a file imageA and you setup
>>> loop device loop0 over imageA and mount it as some filesystem fsB. Now you
>>> do write(imageA_fd, mmap(fsB_fd)) and you get a nice system deadlock (tried
>>> that and it really works :)). The problem is that write to imageA_fd
>>> acquires exclusively i_rwsem in imageA, then goes on to fault page on fsB
>>> which maps to a read from loop0 which maps to a read from imageA and
>>> xfs_file_read_iter() wants to acquire i_rwsem for imageA again.
>>
>> Ah, great catch, but mainly because XFS takes i_rwsem read lock
>> on read paths LOL.
>>
>> Yes, yet this deadlock sounds more like a fixed flow/pattern, which
>> is somewhat slightly different than fsfreeze issue since fanotify
>> needs racy between threads (causing RWR order casually and cause
>> Linux rwsem model deadlock) and may not need stacking filesystems.
>>
>> I'm not sure how this deadlock can be avoided easily since it's
>> a deterministic single-thread timing, but as you said, at least it
>> needs privilege (like fanotify which needs privilege too).
>>
>> btw, I remembered Miklos once mentioned some i_rwsem deadlock cases
>> too, maybe i_rwsem could cause some generic issue.
>>
>>>
>>> I would not consider this a real DoS vector since you generally need
>>> priviledge to perform such nasty write but still isn't not great the system
>>> can be deadlocked like this and I think we should fix cases like this.
>>>
>>> Arguably, to address this particular case, we could block writes (and
>>> reads!) to a file that's used as a backing loop device file similarly
>>> as we do that for swapfiles but here I'm seriously worried of userspace
>>> regressions. I've seen userspace scripts setting up loop device and *then*
>>> running mkfs or editing partition table directly on the backing file.
>>
>> but I think erofs file-backed mounts can just simply block write to
>> the backing file to avoid this: I don't think support this is useful,
>> but yes, it's also priviledged...
> 
> Block write to backing file? Didn't you want to use pre-content events
> to fill the backing file lazily? How will you fill it without writing to it?

Sigh, yes and sorry, I think at least we could find a way to mark
the image file (image files can be tagged like swapfiles) write
and block such mmap read for example: I don't think support this
is useful; but maybe just ignore my comment on this whole thing
for now.

Thanks,
Gao Xiang
