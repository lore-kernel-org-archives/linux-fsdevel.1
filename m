Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00292224AF9
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 06:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776322634; cv=pass; b=cQoaRGu/BpxH6BDVF7OiVWQLlWSxM0oAHFP4SeQSwfNyQYUEKzgKRXfl46fQ8SViEJnK7xhqanf5iNuPQKmZW0IZVHpZjTBg4+bQ8HEnnFMrHGPUvPFoim8q2OvNVttFQnhFh+1UMIjHyWDznPAEfCwTiRHAYXO8ehDx9DCoJmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776322634; c=relaxed/simple;
	bh=OfShf0VLMGnvSiOswV6/gBDGCGI4tubxxzKOYZNMA/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYFjI1SP0+IgXzr3m/h8k8iwWRgah6CJwctzfFIr4u3+Sk9aq56T71KbaaRt+HMC1jti2AYeEuZ8lVoHvFbDkX29PVzWrdCg/2WgXjMjwp0dZ44uMeeWcufle48GVRy6A8RnKAOAya58vzyJt0T84P8pJJqaNBjW2ddx/b48aQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JO1R4sz3; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JO1R4sz3"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a154cc6a48so89602416d6.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 23:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776322631; cv=none;
        d=google.com; s=arc-20240605;
        b=gtVXZBRTP9HaLHxpD90LeIW7FI0d/IOYjguMSXQr7KqbbWECQovqPG/KOxr5IiBaDo
         LUav3/U+F5yqNmgrnQG6+XBHmH5Mkay6mFHR7jlU+bM16YZeqRWrjK4aVpZ+xyIAru9t
         cn3FZu9YtTuC/LVRcs3lmIEjrq1WdmnzS0u/5YxgR2iGt3z17rNR0eVbPR/qlhFM4NR6
         39Nsg41OR6Bso2Lm4hEZqTcfe5PY31xJmRYnJAwUqsVXQSQMl4LrTw2fett0sR8GylZH
         jdaugCidHznfe+ynLNv4XKMQnGMUFgAe8nLJXc820tyC+XWczW2+JCJ3uJL/5S8IchPD
         zAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9wyKt7dB2xgvWQv2qXCoO+0Fz0ExblxmxyFH5bkv4ho=;
        fh=NtNMrUyvPAYMmwIwAmfqQkRdTtsb8Oo5YrLcVkAQlEI=;
        b=U85oGuN9EUwYUKKFSMl3AHHB01FJ+SCJQ+WwtWzZsuAWq6pVbJgU+qJsAHduKcJuRB
         qAO1ipwxigxfLcF7HGahZnxIVMPEc8cKiRtWaFXdb3peOdB0yq2FQpH/vnMW0TYUnc6s
         c9hk4BzXB9lKwiTASpK0VDfBRS79u5QKqHi8yhKsRg2o5shfUXm5UWQp03pwDRyyhRvR
         tWhp1MOF5C3NnR0C36V3eYKNTwdjTsmGyfuLOgVE6IGv0bpRddpCN049MWw0c8iELlLC
         jI6uVIlSOLMDDeEpF67A1Jtb1sT8mvQuruQO2XWWt4zL4UE+Cq7SI1NG8PFPqyXlBHqr
         BfGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776322631; x=1776927431; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9wyKt7dB2xgvWQv2qXCoO+0Fz0ExblxmxyFH5bkv4ho=;
        b=JO1R4sz3uGXXWYZREM79Rx9MEJtR2B+Fh1+RckSPRgg7aDa+Ywq3CHfJrU8eWwb/fx
         iUEkGbzw/zaZpGQlUKY2emjrGk1pflWeOPwmCo1EoKkKn2Wt0Jlx2lCfke8faCAdD/Lm
         xZmJRkxWAuAO/8oEvjAYjizMoSqPGlyevq1Cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776322631; x=1776927431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wyKt7dB2xgvWQv2qXCoO+0Fz0ExblxmxyFH5bkv4ho=;
        b=pCkk/z3AysFoM0qzlGqmhJmqMBj9pAKW0a2fs0j4Jp+0Gv6lu6IHLibQvhqxs2Omzh
         aCGsTziHQ/YSpWDIXNskOP/xGEWhVlUCnfQWSz21U/B+FqclFa056zv/YM+KQZa4Abev
         g66cSxYvmXQKEXTUrXSqToSoQpa+79ILB9GCfbXvB9DLYldHnXY/QE25l7Zyfc5lE8df
         UnIFxD3zmEYr5ZZvk9lRieCkp6iBTNoImnwL16WwKzR+NOxdCy9PLMa+U4DeokAdTQH2
         AuH50jcSPJMAs6p7lENO4YCj5BpxbEYk3LmIyBS+onF84sXzexF73EFqNRODUOWK7np6
         WXCg==
X-Gm-Message-State: AOJu0YyqMim5+j9OElBW9mV5W1ApXV6CdjRPY2W/YEHwlQluXoJGbUJ7
	Yfb+5cNiGmz3bg2A3JXJkAs3uEJOctgD5Dyvkl9coV8prJVRw9z0cNZM/tE8UO54ZujO4FJ4B7O
	T4ndTfPUptsuivd0PfBlAchvULMXkTnqd4pk5y40yTw==
X-Gm-Gg: AeBDiev5LqWmopDD2/EBX2qYu+HPTJFSWDG6kxmHIhed8UqB6gjnTPGcyl/W7HXNibD
	wqbcVtQIKAomApZpmq2Z0VOwmzqCwbmRbNxQqVYTI+eeYmUs4pWRoUj2z82IFo6AyMVY2ig9ujJ
	1AYxY2BYzHYd3iJQGYeHZPaDJI2NoYWSTRKD4Qheym5XaCiHMemVv8sTgUcTWUyYY3tDYQOsHLd
	Wk+F2ge2hFYxfGXeOVLus7M+5dMp4df8VDNpooi0OYAeiWe2bCI8PDnDOA6BnBe13ttjC2mRFBi
	zNdCSFMXbp112Y9crUvN4ToHCOSVnAQ/fLRr
X-Received: by 2002:a05:6214:e86:b0:8ac:b677:c3fc with SMTP id
 6a1803df08f44-8acb677caf0mr224621096d6.51.1776322630650; Wed, 15 Apr 2026
 23:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <033E3BB729B194C4+20260416062129.408277-1-zhangdandan@uniontech.com>
In-Reply-To: <033E3BB729B194C4+20260416062129.408277-1-zhangdandan@uniontech.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 16 Apr 2026 08:56:59 +0200
X-Gm-Features: AQROBzDkZKH_1QlGnkAZIIDSUZ2poY3jRS6dojGR77ov6qnypToRhmTz9WAQl_A
Message-ID: <CAJfpegtfh9JkMQRY8WUNeEZJ7tO5Z1FiHbK2tmBj9ZD+NuGVuQ@mail.gmail.com>
Subject: Re: [linux-next] fuse: avoid double pqueue allocation in fuse_dev_alloc_install
To: Morduan Zang <zhangdandan@uniontech.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+a761f017e231803b82cd@syzkaller.appspotmail.com, zhanjun@uniontech.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Apr 2026 at 08:21, Morduan Zang <zhangdandan@uniontech.com> wrote:
>
> From: Morduan <zhangdandan@uniontech.com>
>
> fuse_dev_chan_new() preallocates fch->pq_prealloc. After dca5bba8d17f,
> fuse_dev_install() transfers that queue to fuse_dev_install_with_pq(),
> which expects fud->pq.processing to still be NULL.
>
> The CUSE open path still goes through fuse_dev_alloc_install(), which
> unconditionally uses fuse_dev_alloc() and allocates fud->pq.processing a
> second time.  Opening /dev/cuse then triggers
> WARN_ON(fud->pq.processing) in fuse_dev_install_with_pq() and panics when
> panic_on_warn=1.
>
> If the channel already carries pq_prealloc, allocate the fuse_dev
> without a processing queue and let fuse_dev_install() transfer ownership
> of the preallocated queue.
>
> Fixes: dca5bba8d17f ("fuse: alloc pqueue before installing fch in fuse_dev")
> Reported-by: syzbot+a761f017e231803b82cd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a761f017e231803b82cd
> Signed-off-by: Zhan Jun <zhanjun@uniontech.com>

Thanks, this should be fixed since yesterday in for-next.

Checking fch->pq_prealloc is not necessary, since
fuse_dev_alloc_install() has a single callsite: cuse_channel_open().
Since cuse also uses fuse_dev_chan_new(), pq_prealloc is always going
to be set.

Thanks,
Miklos
