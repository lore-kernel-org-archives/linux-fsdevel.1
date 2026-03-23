Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4C3ACEED
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276615; cv=none; b=qFWeWM67CIzFZuj8Bgyayd7Ve6F6FJBXY0rDgOb37MEAl9dODzPTee+uZgHemHvfCLNfSvvKYcDf5iNVGuhM4jZnmIlsu0YmHQUnMPanxtmi5EA28z26TQxQXY0uy+Pg049JsH0kI7fOS2UsQ4freLft5pQ0UyOAJPL9hzmLVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276615; c=relaxed/simple;
	bh=PUiUe+5MBqu04rVWdal2Y9UpkGxmj8rNHdbK8PWnG5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9Mt6TvFoMbvpOx3wJbqfqUxob4YCycEGpDBTdtBLiKtOjG/scWewf7pRYvJfvnCmSEcn8scP2eq9q5DhatVqKwTBNTPylOrIoRR2BeihN9jRm1PD9XaDE1eH8ww+Npk4+aCgY9RSUGMxpIR8CjxLfc4cTofl4BzwmM3Dcz85Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v1/nAXEQ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v1/nAXEQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774276609; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=A9gXGblNIOvJ9AMatJe12BN85nu9WBLMpJDi+i55ZbQ=;
	b=v1/nAXEQQaLrDlib6PJDH7xIQXmMywzesn92PedzyPgnYvr0LsBdkY9h93AJJS+itv1lgtGpe9tIQ5mywIrU0NUMV4jLSXApJhbJZXjbvKtVLJDqFey1+hQ1m2/eMXfJZTC8gy2GlWqaSd/Dn4m9BAXtV+GWPWLz19Abd/sFWHc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.YuA0Q_1774276607;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.YuA0Q_1774276607 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Mar 2026 22:36:48 +0800
Message-ID: <68116ee5-b1f7-484b-a520-7dc5aefd7738@linux.alibaba.com>
Date: Mon, 23 Mar 2026 22:36:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Jan Kara <jack@suse.cz>
Cc: Demi Marie Obenour <demiobenour@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
 Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>,
 Horst Birthelmer <horst@birthelmer.de>, Gao Xiang <xiang@kernel.org>,
 lsf-pc@lists.linux-foundation.org
References: <20260221004752.GE11076@frogsfrogsfrogs>
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
 <20260318215140.GL1742010@frogsfrogsfrogs>
 <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
 <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
 <j3gafvpt6r47trvrkttfvilejplluagdz3alcjxmc7xhnzmemv@tahjpv2ak6qj>
 <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com>
 <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
 <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/3/23 22:13, Jan Kara wrote:
> On Mon 23-03-26 20:01:32, Gao Xiang wrote:
>> On 2026/3/23 19:42, Gao Xiang wrote:
>>>> for example, you could audit the file permission with
>>> e2fsprogs/xfsprogs without a full fsck scan.
>>>
>>> In order to make the userspace programs best-effort, they
>>> should open for write and fstat the permission bits
>>> before writing sensitive informations, it avoids TOCTOU
>>> attacks as much as possible as userspace programs.
>>>
>>>
>>> Container users use namespaces of course, namespace can
>>> only provide isolations, that is the only security
>>> guarantees namespace can provide, no question of that.
>>>
>>> Let's just strictly speaking, as you mentioned, both ways
>>> ensure the isolation (if namespaces are used) and kernel
>>> stability (let's not nitpick about this).  And let's not
>>> talk about malicious block devices or likewise, because
>>> it's not a typical setup (maybe it could be a typical
>>> setup for some cases, but it should be another system-wide
>>> security design) and should be clarified by system admins
>>> for example.
>>>
>>> What I just want to say is that: FUSE mount approach _might_
>>> give more incorrect security guarantees than the real users
>>> expect: I think other than avoiding system crashes etc, many
>>> users should expect that they could use the generic writable
>>> filesystem directly with FUSE without full-scan fsck
>>> in advance and keep their sensitive data directly, I don't
>>
>>
>> If you think that is still the corner cases that users expect
>> incorrectly, For example, I think double freeing issues can
>> make any useful write stuffs lost just out of inconsistent
>> filesystem -- that may be totally unrelated to the security.
>>
>> What I want to say is that, the users' interest of new FUSE
>> approch is "no full fsck"; Otherwise, if full fsck is used,
>> why not they mount in the kernel then (I do think kernel
>> filesystems should fix all bugs out of normal consistent
>> usage)?
>>
>> However, "no fsck" and FUSE mounts bring many incorrect
>> assumption that users can never expect: it's still unreliable,
>> maybe cannot keep any useful data in that storage.
>>
>> Hopefully I explain my idea.
> 
> I see and I agree that for some cases FUSE access to the untrusted
> filesystem needn't be enough

Yes, my opinion is that FUSE approches are fine, as long as
we clearly document the limitation and the restriction.
For writable filesystems, clearly a full scan fsck is needed
to keep the filesystem consistent in order to avoid potential
data loss at least.

Otherwise, I'm pretty sure some aggressive users will abuse
this feature with "no fsck"...

> 
>>> think that is the corner cases if you don't claim the
>>> limitation of FUSE approaches.
>>>
>>> If none expects that, that is absolute be fine, as I said,
>>> it provides strong isolation and stability, but I really
>>> suspect this approach could be abused to mount totally
>>> untrusted remote filesystems (Actually as I said, some
>>> business of ours already did: fetching EXT4 filesystems
>>> with unknown status and mount without fscking, that is
>>> really disappointing.)
> 
> Yes, someone downloading untrusted ext4 image, mounting in read-write and
> using it for sensitive application, that falls to "insane" category for me
> :) We agree on that. And I agree that depending on the application using
> FUSE to access such filesystem needn't be safe enough and immutable fs +
> overlayfs writeable layer may provide better guarantees about fs behavior.

That is my overall goal, I just want to make it clear
the difference out of write isolation, but of course,
"secure" or not is relative, and according to the
system design.

If isolation and system stability are enough for
a system and can be called "secure", yes, they are
both the same in such aspects.

> I would still consider such design highly suspicious but without more
> detailed knowledge about the application I cannot say it's outright broken
> :).

What do you mean "such design"?  "Writable untrusted
remote EXT4 images mounting on the host"? Really, we have
such applications for containers for many years but I don't
want to name it here, but I'm totally exhaused by such
usage (since I explained many many times, and they even
never bother with LWN.net) and the internal team.

Thanks,
Gao Xiang

> 
> 								Honza
> 

