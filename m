Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80F35DA69
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719484; cv=none; b=l6oeCevTY6S51H47tcsSGQXzEYgJO3t4gDQr8iSasfKJj3e+i+bEEK9lldw4dHRCnL8a5Im9Jmnwj7Vvlv8U63X3+2kPMEn7jUExzyzShM7y7m1Q49jWNaZ4XpaXDH0uN4lF4gXLRuGF5nlnYLWUUZseko675dubRvoVrEvHK84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719484; c=relaxed/simple;
	bh=+6kQ5TuwA3Fi0+2iL+PMkF07HNQHAFGeJbDyNB9NlFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rg4w3go6ubS1Ut7n6RgR02MW4jk92P5N0iDcFWXm41p/c0gllVgmPGy7cTH64RVLNXuz6lDOPw3sr584cVLrlx5VFmUWd3v3OFs6LxcXo7S9+16C1/ZhEW7IAQAw28ZIIAr1oaP+6ZuLFToPjLNbwrCtBYTbJbgonWdeiPslayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vXOhyxBY; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vXOhyxBY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781719479; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RjzhlNHUa4cRoFhUJMHNf0i5f0rlS8WcU832jyg7xVs=;
	b=vXOhyxBY+iHTNJphEeYMQ8VOciViVRsNIXmLAF0kTDrClfVWeMHKYHYCuIB2kAO1ipLeFaS1PEBF5aurGvzwzFTyzc9hoSgqmtuhMJej0N9w89JemXF/J/vqUo+pj4x4fH8EShpW1A0UVQpcdr5owgtX3UBIRmddKiKcsUcqhRA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X54FlsH_1781719477;
Received: from 30.120.66.214(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X54FlsH_1781719477 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 02:04:38 +0800
Message-ID: <f332b36d-50d2-4417-b999-0e88308f45cd@linux.alibaba.com>
Date: Thu, 18 Jun 2026 02:04:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stacking filesystem deadlocks [was Re: Fanotify (hsm or erofs) /
 fuse / nbd / ... + write(mmap) deadlock vector followup]
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Gao Xiang <xiang@kernel.org>, Song Liu <song@kernel.org>
References: <95371379-97e9-4cb4-8358-ec014b765b74@linux.alibaba.com>
 <CAOQ4uxjh5VYkKLAKxhMsy-ZmrbRrgX4pFgBLFqsDqWMXeiqg3w@mail.gmail.com>
 <ac05da56-eb2a-4862-b887-8081f249d8ce@linux.alibaba.com>
 <CAOQ4uxi0yRavUeztRh-Eb8_HvpfmqkpPbWT9JgQhUn7EKXnryw@mail.gmail.com>
 <e36c9ef5-4cd0-4281-9598-c1bfb8ebfaa0@linux.alibaba.com>
 <5lz5jq7gzoejbywmh56ayfkdiuqsjd2s5pl5uvlflfxc5lq4rr@thr4hrkw67d2>
 <64f23c85-2a83-42e4-ba09-c815dcb7c98c@linux.alibaba.com>
 <CAOQ4uxiaYCt-kkLk=UHML-9bVxqin=5mEAB+uFPVGR7Hq6ppDg@mail.gmail.com>
 <yguigvx3sapcemq2oudlc6lmiwmxr27zx572oyqocbvefnpt3s@z3oj2pzgdjuj>
 <CAOQ4uxi2Mx4ZB48DhQJWOvt6UBur3LnrkttgRjo72U4+Cu81iQ@mail.gmail.com>
 <xycqm3qrhjg3uplpmozwo7nterl5tnuarghowmh3h3mv3thh6u@apagf4kqlkg6>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <xycqm3qrhjg3uplpmozwo7nterl5tnuarghowmh3h3mv3thh6u@apagf4kqlkg6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jan,

On 2026/6/18 01:33, Jan Kara wrote:
> On Thu 11-06-26 17:25:56, Amir Goldstein wrote:
>> On Thu, Jun 11, 2026 at 1:32 PM Jan Kara <jack@suse.cz> wrote:

...

> 
>> But if we did, it would have been nice to validate that LOOP_CHANGE_FD
>> does not set the backing file of loopA to a file on fsB ;)
>>
>> If we only wanted to protect the case of pre-content events in erofs
>> backing file (readonly), is there any solution that you see which is less
>> complicated?
> 
> Two ideas:
> 1) erofs on mmap could issue events to download the all mapped content into
> the underlying image.

Personally I don't think it's feasible in practial since
the deadlock vector is pretty common among all approaches
(userspace/loop) but the impact (drawback) of this way is
too negative for all end users (considering executable
files in the container images) even it's just an overkill
for our real workloads.

> 
> 2) Just ignore the problem since I don't think it's really a practical
> one. I mean userspace would have to issue a write to fs carrying
> erofs image with buffer mmaped from the mounted erofs. If you have sane
> access policies, apps on erofs shouldn't have write access to the
> underlying filesystem carrying the image. And unpriviledged apps cannot
> trigger freezing of underlying filesystem.

Yes, I think this thread is mainly used to come up
more clean solutions, but honestly erofs typical
applications never face the issues mentioned in
practice: just because both erofs and fanotify need
privilege, which means the system solution will be
formed for sysadmins to avoid these common deadlock
vectors.

For example, image files will be isolated by mount
namespaces so container workloads won't write image
files with mmap read like what mentioned before. Also
fsfreeze can also be resolved by 1) image files stored
in another local filesystem (separated from the
container rootfs) or 2) just don't think fsfreeze
happens in typical cloud workloads (and as you said
fsfreeze needs priviledge too) and 3) sysadmin can
kill the application to recover from deadlock and 4)
other userspace approaches (fuse, nbd) also have this
issue.

I think just because erofs+fanotify needs privilege,
and these vectors are common (so again I don't think
we need a harsh approach in advance considering
there are other easier unpriviledged way to lock down
the system e.g. by using fuse): we could just mention/
document these somewhere for admins explicitly.

Thanks,
Gao Xiang

> 
> 								Honza

