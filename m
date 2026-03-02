Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1393D4133
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460115; cv=pass; b=McOdZWmr9BhiQizLBdUmoC5FQKehaqeC53Fd3WYvC2VRXHEGlop2dSdwNZHKgy7340H5XiTM+WUUi2nGIl+ur5y21GbE5+VoOC5dW0GYAkViAXQt8evRibrwtLcIHh4QCy4+ZUEy5vcukH/bcAm37mTn9iYJtLjJg0ym6rBn928=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460115; c=relaxed/simple;
	bh=cn4Q1z7eYPG0s+/rrH8sogr3zfNgU163mlMYVJCsXFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7QcXErt5L5DmdFhySGGS1qVxCPU2XrYsMAHNTStRA/0XXke+i/VPKcxA01ggfG6Mw3m+8hfsKEBZ4rNt86BaT/8KgKDft/gZswtZ+5UwNgVSVdTriYU1ADcCMCUFxcPd8KfjKB6CzUymKQ9UuscDFJaDtfdGJ0UcVxmUVyeUeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pnEBbNCg; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pnEBbNCg"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c711959442so455997285a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 06:01:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772460113; cv=none;
        d=google.com; s=arc-20240605;
        b=Fk7Xvzv76qGaZeeqRuFAQVEbAhdP/WcWIz7eQ1VkjIJzXXtR9ubdXNFptajVmngAmA
         vFu7BbDQkixTV5P4AA9prHLwA/D4Eb2pyDSXy1rECkkY/6AuQVSa5KBsl3BUo5UVqgyL
         0154XqGhT6fKLR2KwdArMOpKjJcasapSFooGnvjyPi/riN2cvKj47G1f26Mwoc+nw4tM
         Nut0zLuHZPuVDAFm5/Hpzw1OTUCdcvXJ0EWx7hOZfs1PYEGo6lbCJ/1hGq+fAwP6drrz
         3QVByRUlRwEmN0pIRaI1CCYTp/yh1AZ6icMyJyrI5sz3dHsJL76YkH/KHqrDCGw+Xve5
         c74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cn4Q1z7eYPG0s+/rrH8sogr3zfNgU163mlMYVJCsXFE=;
        fh=VCFDIVV9IRaoAgt5xBAQyLAnJoCZItWw3w58hCNWbEk=;
        b=TbTCkGqj0QzuPf26IJKPhp/Eq8VDDsuDSYFjgw9X4Jf+AAJfTCZYZV0FvYdmbze9vL
         iDXOKbzIsxs451Vr8AJklF44OlYO+himzgccQxkodnyN139zOZ60NXlZHwPf0RnaCjOl
         Gl2zwFwLutXP8JeCD9mK5vjBHnFJPziZMA+kEQOHTmEOhEtgaYb835K+i5Hkkz0UeA8S
         90o+zzX0Q6okf/b3Lo8BO5OcP+9ftnGBQps4w/S69DeIPkqUCieiBADOF/MORRvwXv6S
         MTBVsjDEzu3qL5Z6Svao5E9Utp4bCamTqPwEgVq5SWWS8sH7rLNtPd3bUohG4r4fhYP1
         qLQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772460113; x=1773064913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cn4Q1z7eYPG0s+/rrH8sogr3zfNgU163mlMYVJCsXFE=;
        b=pnEBbNCgqaLtGKz1dB3yeyXRZhfVcMxeHLVZngM0ntbYYi2ft3r9k2gtl4j62XI7Gp
         kKIlWubVEzwu8xKoCmv8WCG42/sJKHGRw/6IsCAGxC425wyzH6bymS4Gr7GeRUmYH8RY
         ndN8FOu5ANOvF/CgZVol/27VuUQRnmdBJSZVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772460113; x=1773064913;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cn4Q1z7eYPG0s+/rrH8sogr3zfNgU163mlMYVJCsXFE=;
        b=n3DKqiya90LOB8QShxKSdN/pUAYln36ZKqoEDRjfuKaBpWuFbbGAsiGUWGtECGDAMj
         eJesQ6+8Kp6VYhiQ1WQMOWcZ51ys8QQtXt83O1Z0aWiYDr+1d8KpWmN3rnKdsZRG+Tbi
         KTiRqnwXmtHWWiMfmbiUvpuq8QvNA3lrRC24klFQ3MlVyONcQYt1jumwtu85MPfEJDlx
         XkFRX2RKj2RGQzOH4yUrTJOVH13kJpFpN5R8HEJYkasyI9juNOqwerHpk5fF5G28dktb
         TYmcfU92xo1ihWG57QnLcxzsdUJwrXJfj+apRJs8ZHaYHCNikqWnTWRLtc9qyK/Sd6jR
         VbRw==
X-Gm-Message-State: AOJu0Yw+ii+yw0Hb2qgDlsg53ODP2ODQEgmhYqCl/glB2ZgJU1kC9WjH
	fBCRGLgGCzFeFX8Q42zsP6BblGga1Q4z2bmG7Z4PSUPDD/1feAZeyh1GjqO4TBt/o1eiJKFpW8e
	8wd4nMuco0h9SChxK87/p0tZarHs04mW+35+Dh+ICvA==
X-Gm-Gg: ATEYQzy3vXFF+h7BXidq5sjpE/dF4eVFRPcdhRHOi/7DP9tQoQz5pMPPTr24nUXXWLh
	OGVfFO6kr4F9FL46OG4059gDqLDfay46gr2KFkJcN6C5M37K3YhUpjknVMacj7s3YebRRfAMcsZ
	UR+39QNm+ear560U4fliMp++IWsVQGLVJo5rlRfaSojacLLf8bmbU+EYxI+IGTIoixjWi47BwCD
	ieUBSewGx5o5MD9JrRH3MG2WNeWIF5YSOFaO6s0ZrM+nZJby4MJ1Nh1CHj1KaKJGmHS2vRAXfuz
	hZuc5VOTiw==
X-Received: by 2002:a05:622a:1923:b0:4ff:b0f4:c307 with SMTP id
 d75a77b69052e-507523e002cmr143247421cf.24.1772460111313; Mon, 02 Mar 2026
 06:01:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131165056.94142-1-ytohnuki@amazon.com>
In-Reply-To: <20260131165056.94142-1-ytohnuki@amazon.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Mar 2026 15:01:40 +0100
X-Gm-Features: AaiRm51fyeKJitzEmL7QgSAkl6iDSucRyp0uyPHuyO9b-PDGpQdHVMhfRygG2xA
Message-ID: <CAJfpegvhAevmVpcAWhMsOVRJ3D_ZqC4vskcS=OxE9oi9AgoBhg@mail.gmail.com>
Subject: Re: [PATCH] fuse: update atime on DAX read
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Jan 2026 at 17:51, Yuto Ohnuki <ytohnuki@amazon.com> wrote:
>
> Address the TODO comment in fuse_dax_read_iter() which has been present
> since the initial DAX implementation in commit c2d0ad00d948 ("virtiofs:
> implement dax read/write operations").
>
> Simply calling file_accessed() is insufficient for FUSE, as it only
> updates the local inode without notifying the server.
>
> This patch introduces fuse_flush_atime() to explicitly send atime
> updates to the server via SETATTR, followed by fuse_invalidate_atime()
> to invalidate the attribute cache.
>
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>

Does this actually do anything useful?

Fuse hasn't supported atime updates at all, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/fuse/inode.c#n509

Thanks,
Miklos
