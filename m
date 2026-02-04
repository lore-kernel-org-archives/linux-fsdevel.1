Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E43176F8
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770245434; cv=none; b=pNn+tA9Ok4S9ZKmZvsbSyg2SWzL8f3FMiwrwcfrDoU5HwNwbxXZi+IMAPoc+PikBJSkI9Jx6m/jpj9s2f2U0Y9QY5K2IE3IxaMQ8xrqLxaBZPzSr21Cza+E/uGqCb53xmdhOmHsMqmbfaSWhlO+r1lwNNGHYgsYPrypZ2eO9p8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770245434; c=relaxed/simple;
	bh=fy4zE/2A2RRjhnzOxnIt/HjoT88fW75gHWl2Qh97kk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IluwPV1wsJ7V8HCpVv/HL+rCnF+quKyn+//ed0UPVUvZXzqLKfKfk+1S04ceSYpMMTgNSoYDLrVQTVcrC63WZ9qF9oUjQJdukuo+A8yBur5G88VyRfnnD1weogv253JwaQD7StEkEvZxwxDi88y77/Ns852/izo7uPdw63kOPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zil2W///; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zil2W///"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770245431; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9zWS6N0UuB89+YiaDLfIlkt1b9ylZBCswmKG2lgsLOA=;
	b=Zil2W///CPejMXNgVTz0YWFTn5wi7d2b5vv0G21v7wGZpR7MAUkNmoeK5BoGk/d54OzE8e43aU7zo5SfNhhRdPznQHMQyc4C0qU5KQN4jaSbrK4A1DVYpwmSHRXLwpMtz0xgE+e6sM6MehlRk2QvPit8ea8p+Siia+wHSD65YFI=
Received: from 30.251.11.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WyYdupa_1770245429 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Feb 2026 06:50:30 +0800
Message-ID: <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
Date: Thu, 5 Feb 2026 06:50:28 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: f-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>,
 Bernd Schubert <bernd@bsbernd.com>, Amir Goldstein <amir73il@gmail.com>,
 Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260204190649.GB7693@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/2/5 03:06, Darrick J. Wong wrote:
> On Mon, Feb 02, 2026 at 02:51:04PM +0100, Miklos Szeredi wrote:

...

> 
>   4 For defaults situations, where do we make policy about when to use
>     f-s-c and when do we allow use of the kernel driver?  I would guess
>     that anything in /etc/fstab could use the kernel driver, and
>     everything else should use a fuse container if possible.  For
>     unprivileged non-root-ns mounts I think we'd only allow the
>     container?

Just a side note: As a filesystem for containers, I have to say here
again one of the goal of EROFS is to allow unprivileged non-root-ns
mounts for container users because again I've seen no on-disk layout
security risk especially for the uncompressed layout format and
container users have already request this, but as Christoph said,
I will finish security model first before I post some code for pure
untrusted images.  But first allow dm-verity/fs-verity signed images
as the first step.

On the other side, my objective thought of that is FUSE is becoming
complex either from its protocol and implementations (even from the
TODO lists here) and leak of security design too, it's hard to say
from the attack surface which is better and Linux kernel is never
regarded as a microkernel model. In order to phase out "legacy and
problematic flags", FUSE have to wait until all current users don't
use them anymore.

I really think it should be a per-filesystem policy rather than the
current arbitary policy just out of fragment words, but I will
prepare more materials and bring this for more formal discussion
until the whole goal is finished.

Thanks,
Gao Xiang

