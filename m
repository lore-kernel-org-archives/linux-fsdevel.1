Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D3391845
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 15:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538378; cv=pass; b=UPnv7zuUS4vF3Htet10q0gwF3x5Qa7jj58ia4EGoBJvdy9rIGLgyPrQxK9A/ysedG60nhcwEYbWIjNJbDz+4dChzAwDU3HENEQ9ZYBW2C/VhuNYuCKutn55GmOG3bp93Mlp6H+nR30mcqgQtlnw974/Ll630Uj7xYimkWEeLeqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538378; c=relaxed/simple;
	bh=pOuDFTI5oPKxTRicUNbifCShATQV82yCzxj/8ZVK7js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFwKRAfzyiL4AiedLlX836TiBEwXwITKqZKgRbDtsDtR9KUwrHER8diAfTXIO6FogD69VcRMWvarmB3jlGwPY4sEU+bwJFkwzNwiwScg9UUqk0MLv7Gat9Hj+utihJ/zB/l1t6QoFki/WONEt2elhyM4c/ZP0dK7YrpUK31EwzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EPaEUteF; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EPaEUteF"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50b35f3e489so20465501cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 08:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774538376; cv=none;
        d=google.com; s=arc-20240605;
        b=I+wWQ+igsBw9u6DXJ1YYm4hkE9hbM6UFwMSUC5wcL8GPWfQNFdn4wnrwOW7BcPN/7+
         WrWjoO1jQXkcKvybxIHaTVgA948SZH05duqIk47DhodPvdneyrh9AjIWKhzJXdYjDkhv
         UGD8W0YHbFMSUxVlWepDP8CypF7PFewypMgtlgU6/ZRI4m6Pzgnwg5Go/buotTLX5Poy
         S9WinHr8IzCiWXf6E+G3PNLGXdn83Ypb1Vv7ZsfEvs6espqqxuLQsZoDqNwexWs/pc72
         RUz5ZxstG6qhz599d66+djocTF+biojNxLKSsJGJAW1Nq7gTFV/Qii8rJJwF4zYjClgC
         J68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ND5pR0tpIKZoeQWp564NMVpge7oTj0xheSTjMYH28fQ=;
        fh=vccEVKWdZmzIRlpCEpqCCVeKWrAX/UWCjI5arH9n/BQ=;
        b=e267h+q+ZROnjdwKVPQv9Zpq9io6+B4/dP0jrI5zyBk2p3KGUloKEt7LhyZc140hkW
         ATkVUM5ET97MSebQyb3aVsJ42Wjb7ygJKZZqsonisin8gJA12TU4dWc5DB9qJsB0skTo
         krrTiNMovo6f4GRxHgUoCcONsUCrduUmNC3+1jgkaHUOEFrjHgCW9dvNDM/gTLMKABEq
         b7bFMnSY1+UnYUDAVm6+bEmsJQH02FFvVKr8nSlmH56jn07vI3ka1n5P6Z/8F3/KJb+Q
         ov7fCSwjTWu5dKG7UqJuo3Bbgr+59vu19eZ+onxtZG8QPB+vvtXR26d1CCptT2JcXQMB
         kMYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1774538376; x=1775143176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ND5pR0tpIKZoeQWp564NMVpge7oTj0xheSTjMYH28fQ=;
        b=EPaEUteFf4xa2rk5m2k0rJC9Z8OXy0k8orbTxMqlyINI6AoUWLr5i0s2zY6iYhQmoX
         9Q6zlwGnXzVKoUa1+jjzMrKSRDRxoOGwmau1oXz+vhC9TbodQBvpViM5YXj2TqwgxaZU
         ZVX/3TN29FdPMqgILV+XQLCHCBm/sSYqfYc9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538376; x=1775143176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND5pR0tpIKZoeQWp564NMVpge7oTj0xheSTjMYH28fQ=;
        b=MZDJViYfaRYZUm/Wii0ECwSciTIZU9tPbMD1lF3NB8GrgVcgJSzcTogWazMHbDT1yA
         BN8eXbBBjXWC3AZumzVqhilNNfEUEil3vonv4n0MFJyW//XZsKiWI+UakLXmI5/BuHJZ
         wc0XAxJo6+YYxNPTWdkF4UDMxFsynJmXoth0nupR36Tgz2lCeNfQZeOHnO7u6BHeWSbu
         0rh3mOIfgFqsqhYPPpF+c8aZPnEQrgIE8/sHCCgwsyD0Og6DmlBJ+IlgEaYu5aSpyRE0
         cTgmnM6xZ24yVCMLPq5wQ3bacTDf5dWS3h3RUS1v4qGsR2XlNLWWwdMZ45pjodO60cF9
         DzSg==
X-Forwarded-Encrypted: i=1; AJvYcCV1FMdsUsIPONcu5nURqrhx9tztOILLGsmfRn2DW+TfxqCtQNAwpDNa1Ft1+lUdak1q+jKkXo2SIxZCGzpD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/MNokXdBUpjFiMmtPNkcUJG4Sz5Iktht5m6kH+mDsXxx5t2hN
	v9F7j1TSpfG+ts2B6SM5QJ0Y2GoIG8Uole9StDG0WmyEk7CgVsH9lzVlchBqN774xVsOYl+yaIx
	Yjzkvm0cHrw3/BSBc2REytKKBIkwupbDTb8nS/S/mkw==
X-Gm-Gg: ATEYQzwLSOSSYNFFNECBspEb76rImZNLpghJ9XlBOW37h2Wae7+B7RQQDJKp3MPtZ8x
	p2PMkEjVdNoPKxUQ5sZfUjyi2xOFXeMb+o8r1NNLHD5TpmSQHo6qZkWCIsJ6GuHAKn1gQfbocR9
	apn7rU9R4stdRVp74Bj4iGpZhI+m24Va/vgfZ7RONHunWnfZlYzpLObLSzWqTtiQUCVQz9PcH72
	KHjWhEX4wm3Ei/8VdDF3ZywUCClWIbymot0HqP5F5nsRZFuCKnuLVhQPEMXebDHx9t8cMeFnMoK
	ATDtb2Nd2nhoTtoX5qy3
X-Received: by 2002:ac8:5a46:0:b0:50b:41ec:5e85 with SMTP id
 d75a77b69052e-50b993de828mr22922461cf.11.1774538376532; Thu, 26 Mar 2026
 08:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
 <3a7d36c3-0ce0-4f1d-9649-1742f752c5f1@bsbernd.com> <20260326-reorganisation-bemessen-c6643edcf629@brauner>
 <b53e0176-6575-4ec7-bf44-8dea9fc8121e@bsbernd.com>
In-Reply-To: <b53e0176-6575-4ec7-bf44-8dea9fc8121e@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 26 Mar 2026 16:19:24 +0100
X-Gm-Features: AQROBzD74o3wThl14uRsVdlzew3V94eaCh4FsVT1uLgwzTs4PyarvTNn4HuHODk
Message-ID: <CAJfpegtudVRas4gy2bTn+ZeLQapL76pCnvjgHnERUY4tWz-_VQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix inode initialization race
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Christian Brauner <brauner@kernel.org>, Horst Birthelmer <horst@birthelmer.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 at 16:13, Bernd Schubert <bernd@bsbernd.com> wrote:
>
>
>
> On 3/26/26 15:26, Christian Brauner wrote:
> > On Wed, Mar 25, 2026 at 08:54:57AM +0100, Bernd Schubert wrote:
> >>
> >>
> >> On 3/18/26 14:43, Horst Birthelmer wrote:
> >>> From: Horst Birthelmer <hbirthelmer@ddn.com>

> >>>     fi->attr_version = atomic64_inc_return(&fc->attr_version);
> >>> +   wake_up_all(&fc->attr_version_waitq);
> >>>     fi->i_time = attr_valid;
>
>
> While I'm looking at this again, wouldn't it make sense to make this
> conditional? Because we wake this queue on every attr change for every
> inode. And the conditional in fuse_iget() based on I_NEW?

Right, should only wake if fi->attr_version old value was zero.

BTW I have a hunch that there are better solutions, but it's simple
enough as a stopgap measure.

Thanks,
Miklos
