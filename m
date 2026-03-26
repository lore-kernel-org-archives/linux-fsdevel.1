Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073D391838
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543387; cv=none; b=RRa8PgNzrdlRl1oNj+0abza8+M1emsWEaJkciROKBDmymJ9kFfZ7VZQTS1HASkWO0x/VoE41SaAYTDuuXOgypoHid+q61lqpqIIRwVwXCElNQjLQa26OqDMIenrUVYjdvu+JhNDkGJ7RVJSpjtotFVt2JVUOMO3Nyq+eZavYZwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543387; c=relaxed/simple;
	bh=Xby9R2NcCwm233UXveKiwtR+nRZs0VQaXB66BIDECc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBQKcfnRPoIN4z7pyQfWo+Wlkz6n70gyLijiMuHNR1enVUSylz07kU9l5ozRlUWFDQGI8dCjRlJd8oFj3lmxc4JBpcd6xum3T7KWCbFEn7FYJRIE1dd3jSmIoJA0GiYuqMiRFYC/x1V794FIbXiszTV8z+eC8O9+XYsGcgqX8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sQltC4VC; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sQltC4VC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774543381; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7cQHkdASFm9EuYVUJ/ln2rhyJFRl+lXAxaoa2QDX7yc=;
	b=sQltC4VC3++RVyJxpdkhDIjF1mf5weaz4KBe/7zeIjijvTY9EUsqyeD/G/rU37QNKt66+TQDcW1mFq2OR5T1pziIXSp0l5gZNjkUm1fLwVDDN8XJUAHG9jkRoiODTzgBY9BjA0bCUDpfxYPUenYxgm9hrBKV4cKBdBY4HMgUBR0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X.lodwL_1774543062;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.lodwL_1774543062 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Mar 2026 00:37:43 +0800
Message-ID: <2b1ec557-bf79-4d8f-8383-41a0d54e8966@linux.alibaba.com>
Date: Fri, 27 Mar 2026 00:37:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Demi Marie Obenour <demiobenour@gmail.com>, Jan Kara <jack@suse.cz>,
 "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>,
 John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
 Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>,
 Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
References: <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com>
 <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
 <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
 <68116ee5-b1f7-484b-a520-7dc5aefd7738@linux.alibaba.com>
 <2gyfmxfnnxrglpzb7kz63xbve5vnosl6gi54c3umgrpwbjr4og@lz4e2ptqanfe>
 <20260324-hilfen-reibung-9783005d5d0f@brauner>
 <b8f5bff1-27bf-4934-9297-0aad551a550c@gmail.com>
 <d2d5c218-7063-4ea0-ab03-1433449f4d83@linux.alibaba.com>
 <20260326-gemindert-vertuschen-fd3a507eba94@brauner>
 <f1cef32a-1c35-41dd-88af-a8c504d41a93@linux.alibaba.com>
 <0b8a0d24-1c20-45b3-abd9-e95b3b4d4caf@linux.alibaba.com>
 <CAOQ4uxjR2h9+=DPKUzV35J4ageNCn0oMHL0QvZSjJiuH5Gfo+g@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxjR2h9+=DPKUzV35J4ageNCn0oMHL0QvZSjJiuH5Gfo+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/3/27 00:24, Amir Goldstein wrote:
> On Thu, Mar 26, 2026 at 5:12 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2026/3/26 23:10, Gao Xiang wrote:
>>
>> ...
>>
>>>>
>>>> I don't understand what exactly people think is going to happen once we
>>>> start promising that mounting untrusted images in the kernel for even
>>>> one filesystem is fine. This will march us down security madness we have
>>>> not experienced before with all of the k8s and container workloads out
>>>> there.
>>
>> Yes, my reaction about this is that still depends on
>> how you think this.
>>
>> The whole Linux namespace mechanism is unsafe compared
>> with traditional virtualization; no one really imagined
>> the implications without implementing, enabling these
>> namespaces and trying.  These new mechanisms introduce
>> many new CVEs and vulnerabilities from time to time, but
>> containerization still drives innovation, and
>> cloud-native technologies are heavily based on it.
> 
> Interesting example because of how this played out.
> Every distro took its own direction, some still carrying out of tree
> patches for userns policies to this day.
> 
>>
>> This is especially true for user namespaces. However, I
>> don't think we should remove them entirely from the
>> kernel just due to potential CVEs or because they aren't
>> implemented in Rust, for example.
>>
>> Regarding FS_MOUNT_USERNS, my experience over the years
>> is: three years ago, honestly, I never cared about this
>> feature at all. But soon after, several new attempts
>> emerged to resolve the same requirement in different
>> ways, which already confused me. I wondered why we
>> couldn't work in a cooperative way instead, especially
>> since neither of them looks like a very huge project with
>> enough development resource. Then, I realized that as
>> long as you don't implement something, there will be
>> endless new attempts and comments from various small
>> group of people.  And the userspace policy will never get
>> in agreement.
>>
>> So, if this is filesystem-specific, my current thinking
>> is this: if the security model can be formally documented
>> and fuzzing is improved, could it eventually be enabled
>> via an opt-in Kconfig within a single filesystem group?
>> Would that end the whole story because the Docker image
>> requirement is fulfilled?
>>
> 
> I think that what you are proposing is so controversial
> that the chances of reaching a consensus in upstream are low.
> Doesn't mean you that you cannot try to sell it to some cloud distros
> as an out of tree patch.

No, that is not how I proposed, just my bad experience
these years due to the fragmented container community.
I'm exhaused by those new attempts to prove who's safest,
some in Rust, some with ~500 LOCs for example.

I just don't want to play with that game anymore.  Of
course, I could drop an out-of-tree patch on the website
later, and honestly, for example, for docker and containerd,
FS_MOUNT_USERNS just impacts DinD (which can also be
resolved in alternative ways of course), since containerd
is privileged, let's see how is goes with EROFS native
container images in the following years.

> 
> If you have buy-in from some downstream container distros, and it
> survives the wilderness for a few years, during which you fix CVEs,
> you may have a stronger case to present for upstream.
> Just saying. Maybe you are charging the wrong hill.

I just react to the userspace groups, I never pay too
much development time on this particular thing. Just
plain discussion with my broken English from time to
time.

But of course, I could find some time to implement
the signed image way instead if Christian accepts,
it's of course still useful, but just doesn't make
everyone happy.

Thanks,
Gao iang

> 
> Thanks,
> Amir.

