Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764342;
	b=ZBSBrXkFjb865FwAMvWD/laqfAxNPFM0VDXH/u7S7dDxCTlioVHPFVHFfz/R9GUXgNNP
	 iVA24ZO4E+/4I6jyCtSUvkpMYh5Ibgdcea/j5nbZ5PWArUTYqD7iykGvWj0gcKNuf/r45
	 TaAhgso9HDvJ2dzYkE6X6SR5ielA950RqehiCqV/NSftbWbVoHXXYQf1KlOFFukUx3det
	 rUzhZxq1lFRLw2P2C2KRiQ9HqKf5xUNNO2Ze/PC30RaTC+eBxLQvuHCvbpdv4oZ9XSZ7I
	 TRSMNgZV7fJnxiJVuW/Mi6ozpTNxLpJOCoPl6u5mdOCa4ykYTmmNS5MXmkCH9W7aCMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BUJVWluZQW/qDMSCSzMsGJRAgytWrmfDDzAkl2tvmys=;
	b=SEUa77USO24W1PDGm1eLdFiKdS9EOFy+fkGjO7HILgshm2rsG0uivnIDD0HwDQ8UWqyz
	 AtobXM2JMXeI7lx87Bg472eGd3ourR/SX34IPoTpeN7EBNdvX1SynAi6ryz0ViGuCLLj9
	 ITomFPpXtyrylDw5NlKunnub8thLZINoQgpr7FVDFO2rjCouTxprerE7d8ZLancJxkiyi
	 ITGYlUzMHZeks9DXerBqMPx7BWOHsyEc2E5pyZ+tgmYb6oFDEsSAoffaBxXKwxBwTmDOV
	 gI+k/tjt+i0me/yvn/tTRLoyjgfbwHo/fOUwQWstwNqIo/ieJ6W4Kg/qQ58DSLyiv/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qCHc+pkS;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB0E606A31B
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 14:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BB0E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qCHc+pkS
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c414e5d282eso110280966b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792764340; x=1793369140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BUJVWluZQW/qDMSCSzMsGJRAgytWrmfDDzAkl2tvmys=;
        b=qCHc+pkSgGjiEkB+YGvSGYu0lSGIfzJY5pAXsLur0x09rjShylBp6MESq/gj/bUUeh
         oyclnk95Q/C3POCVEUbNXFP4IqJXHSma/pajCGqeZyhCELztyVVVdT1KzN0/DiuOzsqL
         9Y4ucHy3nxyJX8Jr5ptAo65RP1pHINUXa+j66SYOcgsW/4w3zWYQGyt0PS7DblO/Nj+F
         6cR6Vpe8/G0OSomPI6w+IJAo/Vvsu/2p1/hH9GzjtiMu3Z4Skvxb6kisSSA+zwoRq2Uo
         musg/d6JQTXlZ7Ewkk5COEiWzZeK+DPYSAkEQLuXc3Fsm1pX+6ug7EsLGn0NAOACqha8
         +nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764340; x=1793369140;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BUJVWluZQW/qDMSCSzMsGJRAgytWrmfDDzAkl2tvmys=;
        b=1KCtFCM+6z2oDtHpTF8/psfbmDsHyL7ACC8qmWjuvyPQPCkGfs20ZlPJjW7X4nQ0VP
         xmLOJ5ulwQEgZC2ue24ThHdUzittB/6Vt5z6g0uYiGpIPfBoizN4riJQns6MZPys0Uwd
         7N6boE/2hYnM2RwDgu2w224aS/7ZCiCl6bBKx9Bnwd4wuDqi3r5mcTmF1kAavnSbvEqI
         lKM32ZBoAI8DAn3mU5p/EW3iIlmUj/A3t+ipdqeQKF60AHV18x/iPB+E/PumUAN5qmq0
         FH5KBpskqSsPYdxZzFOiVm8jaO3B5BOtTe6jYpmFT3fHCLJjXPAnDzFiscnH4m51E7+c
         F1yA==
X-Forwarded-Encrypted: i=1; AKwUvBxNbVXZ1n4HBkpj5BoNUD1RLQfOjmm7PYzZsdpsxMw2ENvT9P1GE2kqAIra/69mTiRtYke7rW7wXKRR3gfw@vger.kernel.org
X-Gm-Message-State: AFq9FYKl1Y6AmHxGORkUbab8IPdkdhldWBMFiYhuWPCuHCqZ8yoWxIET
	Rm+4ehtKvCML2pGFTKzD3iIxFq72u7twv3G3MD0SEwR6hNFUSsQKdnZG
X-Gm-Gg: AYBFou3iqrvp11NX9roLUHnxqT24vmNSirv8RQeoOm4VABk6s9eZxdwrlMhht6zCyVV
	ee+Xh2CQzAq/G+Hci5LjJuRXA9pA5qRVxkTW7s8nFipgeEar0a1+kDpvQ5LDXb/xg5V/eNOn1MD
	rea9J1mtD7dzS62/Qy76fydN5ai/4FDgfOyBzxjdgaw7BQW072E037PJTJHZNM3x3/JY6+ZpAhN
	uj+KLxOTWRfrXjxiJI9cjtu1KrdTPWzGIscylle/Fc0DLsy9pBLUX5uBJxYWLMK7jr78kI/Yz8P
	495yT3cC4Pf/l3GzZPzTCcobZ7UipM5KObW762b7m2WNylsioN2W9CzgQ43ktzPQQxkrSYKXllc
	NoboZnUeKShbRDwe7PFmjcaI+NLV6tnHJu8LDeQH4fprKSmgjTOMK12Q+IfcoO22oNLZAarUj/R
	+ibcsHZQ4JoeW2Wwun24FKd4BgoKVSrwfgAyHOlPOxiWGYBp4yN2r39mdCkjJ/3H5LINP+PaeVK
	V45yxp11qMUr+HcZ0x2gzcFMo0GH2ewl8c1mlmTpYni7P32h7zKfnjYQ6cIdOeLO7hgpBON/N7F
	RzSIa0WvPzn2eoStv+walhXoApxW/Pclztm+N6T1Ntv3nneSldxgdwv5OiTv2njwxYbRTYWJDPs
	x3ybeDTVzUYmUSWfwrERwhv5zJzN93o2pDuDmlpKfZS0me1YSqUgp/omp09mlDymbROPDzEoJn2
	WAo7tIjuk+8nXiWA0=
X-Received: by 2002:a17:907:930a:b0:c41:30be:4f84 with SMTP id a640c23a62f3a-c46a90ae916mr376211766b.9.1792764340190;
        Fri, 23 Oct 2026 07:05:40 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46b8ba181esm4707666b.25.2026.10.23.07.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 07:05:39 -0700 (PDT)
Message-ID: <7a212208-74f2-4d79-8ca2-a1502d0e0a1c@gmail.com>
Date: Fri, 23 Oct 2026 16:05:38 +0200
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] kernfs, autofs: fix pipe lock cycles through sysfs
 stores
To: Ian Kent <raven@themaw.net>, Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 driver-core@lists.linux.dev, autofs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
References: <6aa23178.f81106d8.2ab401.0006.GAE@google.com>
 <cover.1792577179.git.krystianmkaniewski@gmail.com>
 <649966b83b39fcdd25e892fc3c6732a1@kernel.org>
 <22d41f2a5546d3bc90a1b3ad24ed3656588a854f.camel@themaw.net>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <22d41f2a5546d3bc90a1b3ad24ed3656588a854f.camel@themaw.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tejun, Ian,

On 10/22/26 04:46, Ian Kent wrote:
> On Wed, 2026-10-21 at 11:48 -1000, Tejun Heo wrote:
>> it doesn't make sense to change the locking scheme for it.
>> Can we just disallow splice on /sys/power/resume instead?

That would address the direct case, but it would not make this report
go away. The lockdep report combines two separate operations.

First, the reproducer splices a pipe into the cgroup v1 devices.deny
file. This records:

        &pipe->mutex -> &of->mutex

It later uses a normal write() to /sys/power/resume. That records:

        &of->mutex -> &sbi->pipe_mutex -> &pipe->mutex

There is no splice into /sys/power/resume in the reported sequence.
Disabling splice on that file would prevent some direct deadlock
cases, but the first edge of this report would still come from
devices.deny.

A complete restriction for this attribute would also have to cover
both splice directions. With an O_RDWR open, a splice read takes the
output pipe mutex before the same of->mutex. Another thread can write
through the same open and reach autofs in the opposite order.

Kernfs splice support is established behavior. Commit f2d6c2708bd8
("kernfs: wire up ->splice_read and ->splice_write") explicitly
restored it in v5.11 after the VFS stopped providing the implicit
fallback. The pipe has been locked across ->write_iter() since 2014.

I agree that changing serialization for every regular sysfs store is
too broad for this case. Before preparing a v2, I would like to
clarify the intended scope.

> Not only is the description hard to follow the example is flawed

You are right that the cover letter was hard to follow. I should have
described the two operations separately. The automount itself uses the
normal empty directory case.

The reproducer creates a detached indirect autofs mount with its own
daemon pipe. It changes its current directory to the root of that
mount and moves out of the daemon process group. It then writes the
relative name "0x0000000004000921" to /sys/power/resume.

resume_store() calls lookup_bdev() on that string before trying to
parse it as a device number. The pathname lookup therefore starts in
the autofs root. The new negative name triggers the normal mount
request for an empty indirect autofs directory.

The dentry whose ->d_automount callback runs belongs to autofs, not
to sysfs. There is no autofs mount on top of kernfs in this
reproducer. Kernfs is involved only because resume_store() starts the
pathname lookup.

The change which made this path possible is 1e8c813b083c ("PM:
hibernate: don't use early_lookup_bdev in resume_store"). It replaced
early_lookup_bdev() with the normal pathname lookup in v6.5. That is
what made autofs reachable from resume_store().

> The other possibility I was thinking about when I saw that report
> is to disallow file systems that don't make sense for automount.

I may be misunderstanding this suggestion. In this reproducer, the
filesystem which owns the automount dentry is autofs. A restriction
based on the filesystem owning that dentry would therefore see autofs,
not kernfs.

The lookup from a sysfs store is also not unique to
/sys/power/resume. For example, with CONFIG_BCACHE=y,
sys/fs/bcache/register also resolves a user supplied pathname.

The exact reproducer records the lockdep edges with different pipes
and different open files. It does not deadlock on those mutex
instances. After sending the request, it waits killably for a daemon
reply that never arrives. Related setups can deadlock when the daemon
pipe itself participates in splice or tee.

Given these two separate paths, did you intend to prevent only direct
splice operations on /sys/power/resume even though the reported class
cycle would remain, or should a replacement also eliminate the
lockdep report?

A per-attribute splice restriction alone cannot do both. If this does
not justify new kernfs infrastructure, I can leave it alone.

Thanks,
-- 
Krystian Kaniewski
