Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15099175A6E
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Mar 2026 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774155127; cv=none; b=STxn8xRbNBkdH7V2Upzfxpy6WT0cnk2VYqH+ChX2EbewUA4s6G2TN1n6Ozyx786N59n0nVBUaPRqHwygaCJEp9+MZtYRhf7RkFRYOqEi1Z3q6FOPP8tyNh9klamyQG9TjMzkwoRdLBgTSsiIqv5tGLfg40OEjXc3UtYv63sXr1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774155127; c=relaxed/simple;
	bh=hUokHI1sC9FD2TILapIkDph9UQw2qBJPi+y7pHsPkFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LThwRrXzyn4j9OcF7nyRGYXX8jrSexmwBporu9wX7GKdCk9TT/bKOT5rjieTZeeoHzVz9+Qrnsu2h/YJ0P1zf4mzcBunA5zhR9SeHFN2/EoV/H76S1w/uJLkZJHWKO1o0n8bghzt1gYDfQzQpd7FPwFk5iv09haK7cYjWBlK7pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qCjRR0Yc; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qCjRR0Yc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774155119; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qWyMgSyD+3b0Tzx4xPd+ygLX6jCCKDnhqoLF9Yqrxwo=;
	b=qCjRR0Yc+PqBVaOWeawkZDZ2A0BMBxdzdkxN1epcUn51f+PGwmdgCpNcBiqKXUsDZurS9QICE+L0QzdpbDs5nlrdkScoDbyYZ90+Ng9eaPk4T7dXH6YTkffuH4c+L/Z2E6xhgtVFFbJ6pQbDvi1KgKTukHrem+c0F9H2Ru7S23g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X.QJQrP_1774155117;
Received: from 30.41.54.139(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.QJQrP_1774155117 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 22 Mar 2026 12:51:58 +0800
Message-ID: <390cd031-742b-4f1b-99c4-8ee41a259744@linux.alibaba.com>
Date: Sun, 22 Mar 2026 12:51:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Demi Marie Obenour <demiobenour@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>
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
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
 <20260318215140.GL1742010@frogsfrogsfrogs>
 <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <361d312b-9706-45ca-8943-b655a75c765b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/22 11:25, Demi Marie Obenour wrote:

...

>>
>> Technically speaking fuse4fs could just invoke e2fsck -fn before it
>> starts up the rest of the libfuse initialization but who knows if that's
>> an acceptable risk.  Also unclear if you actually want -fy for that.
> 

Let me try to reply the remaining part:

> To me, the attacks mentioned above are all either user error,
> or vulnerabilities in software accessing the filesystem.  If one

There are many consequences if users try to use potential inconsistent
writable filesystems directly (without full fsck), what I can think
out including but not limited to:

  - data loss (considering data block double free issue);
  - data theft (for example, users keep sensitive information in the
       workload in a high permission inode but it can be read with
       low permission malicious inode later);
  - data tamper (the same principle).

All vulnerabilities above happen after users try to write the
inconsistent filesystem, which is hard to prevent by on-disk
design.

But if users write with copy-on-write to another local consistent
filesystem, all the vulnerabilities above won't exist.

> doesn't trust a filesystem image, then any data from the filesystem
> can't be trusted either.  The only exception is if one can verify

I don't think trustiness is the core part of this whole topic,
because Linux namespace & cgroup concepts are totally _invented_
for untrusted or isolated workloads.

If you untrust some workload, fine, isolate into another
namespace: you cannot strictly trust anything.

The kernel always has bugs, but is that the real main reason
you never run untrusted workloads? I don't think so.

> the data cryptographically, which is what fsverity is for.
> If the filesystem is mounted r/o and the image doesn't change, one
> could guarantee that accessing the filesystem will at least return
> deterministic results even for corrupted images.  That's something that
> would need to be guaranteed by individual filesystem implementations,
> though.

I just want to say that the real problem with generic writable
filesystems is that their on-disk design makes it difficult to
prevent or detect harmful inconsistencies.

First, the on-disk format includes redundant metadata and even
malicious journal metadata (as I mentioned in previous emails).
This makes it hard to determine whether the filesystem is
inconsistent without performing a full disk scan, which takes
much long time.

Of course, you could mount severely inconsistent writable
filesystems in read-only (RO) mode.  However, they are still
inconsistent by definition according to their formal on-disk
specifications.  Furthermore, the runtime kernel implementatio
  mixes read-write and read-only logic within the same
codebase, which complicates the practical consequences.

Due to immutable filesystem designs, almost all typical severe
inconsistencies cannot happen by design or be regard as harmful.
I believe the core issue is not trustworthiness; even with
an untrusted workload, you should be able to audit it easily.
However, severely inconsistent writable filesystems make such
auditability much harder.

> 
> See the end of this email for a long note about what can and cannot
> be guaranteed in the face of corrupt or malicious filesystem images.
> 
>>> "that is not the case that we will handle with userspace FUSE
>>> drivers, because the metadata is serious broken"), the only way to
>>> resolve such attack vectors is to run
>>>
>>> the full-scan fsck consistency check and then mount "rw"
>>>
>>> or
>>>
>>> using the immutable filesystem like EROFS (so that there will not
>>> be such inconsisteny issues by design) and isolate the entire write
>>> traffic with a full copy-on-write mechanism with OverlayFS for
>>> example (IOWs, to make all write copy-on-write into another trusted
>>> local filesystem).
>>
>> (Yeah, that's probably the only way to go for prepopulated images like
>> root filesystems and container packages)
> 
> Even an immutable filesystem can still be corrupt.
> 
>>> I hope it's a valid case, and that can indeed happen if the arbitary
>>> generic filesystem can be mounted in "rw".  And my immutable image
>>> filesystem idea can help mitigate this too (just because the immutable
>>> image won't be changed in any way, and all writes are always copy-up)
>>
>> That, we agree on :)
> 
> Indeed, expecting writes to a corrupt filesystem to behave reasonably
> is very foolish.
> 
> Long note starts here: There is no *fundamental* reason that a crafted
> filesystem image must be able to cause crashes, memory corruption, etc.

I still think those kinds of security risks just of implementation
bugs are the easist part of the whole issue.

Many linux kernel bugs can cause crashes, memory corruption, why
crafted filesystems need to be specially considered?

> This applies even if the filesystem image may be written to while
> mounted.  It is always *possible* to write a filesystem such that
> it never trusts anything it reads from disk and assumes each read
> could return arbitrarily malicious results.

Linux namespaces are invented for those kind of usage, the broken
archive images return garbage data or even archive images can be
changed randomly at runtime, what's the real impacts if they are
isolated by the namespaces?

> 
> Right now, many filesystem maintainers do not consider this to be a
> priority.  Even if they did, I don't think *anyone* (myself included)
> could write a filesystem implementation in C that didn't have memory
> corruption flaws.  The only exceptions are if the filesystem is

I think this is still falling into the aspect of implementation
bugs, my question is simply: "why filesystem is special in this
kind of area, there are many other kernel subsystems in C which
can receive untrusted data, like TCP/IP stack", why filesystem
is special for particular memory corruption flaws?

I really think different aspects are often mixed when this topic
is mentioned, which makes the discussion getting more and more
divergent.

If we talk about implementation bugs, I think filesystem is not
special, but as I said, I think the main issue is the writable
filesystem on-disk format design, due to the design, there are
many severe consequences out of inconsistent filesystems.

> incredibly simple or formal methods are used, and neither is the
> case for existing filesystems in the Linux kernel.  By sandboxing a
> filesystem, one ensures that an attacker who compromises a filesystem
> implementation needs to find *another* exploit to compromise the
> whole system.

Yes, yet sandboxing is the one part, of course VM sandboxing
is better than Linux namespace isolation, but VMs cost much.

Other than sandboxing, I think auditability is important too,
especially users provide sensitive data to new workloads.

Of course, only dealing with trusted workloads is the best,
out of question.  But in the real world, we cannot always
face complete trusted workloads.  For untrusted workloads,
we need to find reliable ways to audit them until they
become trusted.

Just like in the real world: accumulate credit, undergo
audits, and eventually earn trust.

Sorry about my English, but I hope I express my whole idea.

Thanks,
Gao Xiang



