Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADC43D1CB6
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859751; cv=none; b=o/Y01KqnZOcYUxBC8q28i+pe72omWQgneg05CEkDAwpjgxhOTjHnh7fTSZ/i982TtOWbAeP9cC5hjMbgl+HGJVnSGBOyFmtRHZvMzYrvJd2SYu2w9hRvdv37o305lBEFKM4qnmkqvYewAhJPxrqQdiFMh9f/fvbjvO5GrSJ4iwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859751; c=relaxed/simple;
	bh=afDepP8KOaeIJWN1IDrEhyDitQLVzbnoZPs+gSTfGPQ=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=R9CavVOswLxN91NnKHm6W8C7PZIube978E/pW9HQoYrBYirbP3Lc6GfwgGpK8fvEq6WM5GOOiun52bVV0toytSoHiffczn9j8j+NPZh/46OKnaAs6zyZg85VKX7hC6TjDNV8XQuTchK6ojyi7tbqW+ghGACdJobHlcpEyC7BD5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=LbgtVUv5; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="LbgtVUv5"
X-KPN-MessageId: 0f81c15a-3e44-11f1-bea8-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0f81c15a-3e44-11f1-bea8-005056992ed3;
	Wed, 22 Apr 2026 14:09:06 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 0f942ac4-3e44-11f1-80f3-00505699693e;
	Wed, 22 Apr 2026 14:09:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=Wwle9PGUhoUuAfsPYjcKmM7CUaVVCG+krx3i0HEGB1s=;
	b=LbgtVUv5ooREapLvaZzjX2NLIgh/2NR9NJ3U8ENhV/2M+0KK09a7l9EoUUaS42ZDvcPYtlhYemCYc
	 Hi6I/BnYKmsJA+6z5ieC8iF4uXrSJ6tKZdlmHhZtHdqs8PbrFxADvIMYQVzUQZOFfUJpX6LdjlqN+B
	 HvfSZl/Xe5TWp8WNi4lyns++/EniCEQcixPx/GqMgl38EIDXcDbn85gBMmgp5xnkhs8Wqhy6lz2E14
	 NQAsGQOBGtFgGdJweQuSqhrpf+p0R4MiZdbJoiMOAiYpx4IRPMO2np//q9GkSzLyKAkjzpvuFdFo7G
	 HF1tojm8olvrmDY4x3g4xgpMPQlnm+g==
X-KPN-MID: 33|4UrUhFud/UdfJesfnwWrLYZUNkepteBtOQ5YqTUaPe0uJEZabz2/z1wbCa0g07N
 Wv91XibbzYxS1L85YWowaUQ==
X-CMASSUN: 33|AsvmB9GMf1A8lX8vhYwyz4QvBZTViCaK12YJLkIrfwfhQjHeHIngynkN3jZkfZS
 bQxyh6yMRTQGDC2iet8eq1Q==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 0f8267a1-3e44-11f1-b8d7-005056995d6c;
	Wed, 22 Apr 2026 14:09:06 +0200 (CEST)
Date: Wed, 22 Apr 2026 14:09:06 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Message-ID: <1270238484.1040011.1776859746395@kpc.webmail.kpnmail.nl>
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem breakout sessions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

On Wed, Apr 22, 2026 at 10:58:25AM +0200, Amir Goldstein wrote:
> 
> In this setting, I would like to open the stage for people to talk
> about whichever topic they like -
> An idea they have been toying with,
> An item on their TODO lists they never get to
> A WIP branch that is bit-rotting on their work station.
> We could of course use this time for FS specific BoFs and
> Ask Me Anything sessions with fs/subsystems maintainers.
> 

Not sure whether I may bring up a topic, otherwise just tell me to GFTO.

In relation to the doc changes you've proposed over the last week, there
is another gnarly topic. Namely, what to do with the "kind of deprecated"
filesystems like minix, efs, jfs, etc.

Months ago I contributed some patches to minix and in the ensuing
discussion the idea was floated to maybe replace it with a FUSE
driver (perhaps in-tree under /tools or something). I am quite familiar
with minix, so I suggested I was OK with doing that. However, naturally,
other (more interesting) things came in-between and I haven't moved a
lot on that.

One of the reasons is, I wonder if this strategy makes sense. minix is
not too difficult to port, but what about jfs for instance? Who is going
to spend time on that? And if I remember well, Linus has been quite
outspoken against just removing them.

Some questions I have:

1) Is the FUSE driver thing the way forward with old filesystems?
2) If so, do we want to maintain them in-tree?
3) If so, will we accept for instance a Rust implementation? Or do we
want to stick to C?
4) In the mean time, what is the policy with regard to unmaintained
filesystems? Are we looking for maintainers or does this come onto the
vfs people? efs is listed orphaned in MAINTAINERS, minix has no entry at
all. jfs is odd-fixes, but I remember David Kleikamp rather get rid of
it.

Thanks,
Jori.
