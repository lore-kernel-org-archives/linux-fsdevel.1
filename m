Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F7F3CB2F8
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149563; cv=pass; b=UUhiMJwez5/070xbXDBrM0pyQ06LQ07mdmHnrhAPRlvne6lb4ljBAT/2j5FGECgq4N4QTHRc+WLQX7Daspt+h/wwagflawRjX5wPKqdhN0wtRamkvcuObjFTdghTBXWav4AHO3AT10xipNdRm2goBCKZvEXleqxrLHTKHqGjvHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149563; c=relaxed/simple;
	bh=ohcHmnwMMSDmJjfmYivpS1QS5sro1hDQqWxGQZCr6A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlk3uPxUFaAjGRVdltkOIWU0SzraJvHNkWQJFJmcXEzZomfuMFCpwflMMVDyuRZTYA5/TGnlvSUHtnBqATOcIzv0WZi3iDU1xjFPcZ/SbP/NjKocmZh5A+J5p4hGnccU1AszM8Yab9DbReUM42SsvYmda+GRdwxvHV694QQQBTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wOU4GZJt; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOU4GZJt"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38759bcd877so5177370a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 14:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784149562; cv=none;
        d=google.com; s=arc-20260327;
        b=GnFq7OlQVgC2cMO9d9Ca3+EVXhbMwTEt/gWJuOU27M/GHphomjtJaeBOzTjV3xatoP
         1qIkh6cH6vl/HCy6Z1wrMuRoXnAKgsKBhyvnusmKXF/KWQGMEbpwnkWItVwcbY2zFCfh
         3ECdis7f1fdLJtixLiPs0yaYdGV5TnsZ817bwLmkCTYTv4VhdW9S5w+7gGLyEq1PF8Cm
         WqB0ISQUC+FNKUkLtnkZIYJsTqaGOmBIHy1rywvROvSbITGCb562ZFBhF9NJtHDorZGU
         0eZxCcNhkTOADlmMkdfdfAkfrt1HPMxFaMlxRoc9RWj+EOfn8aH/pQpu+MZ32Dh/GS33
         TOJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ohcHmnwMMSDmJjfmYivpS1QS5sro1hDQqWxGQZCr6A8=;
        fh=3GJUXYmWFZnMcCE/i5oPYJa5JXUazBzy5PjAr1KF+s0=;
        b=V0KztN1M0dLJJ/vLvlHT0Sh4HvuZ8tAUC4pQRoT5IREEHHA7Uz6CS4PrCmkcEpVfEF
         90svN3Y9OxxNe5sm17snzoSIlfhM2EoqkV5+ZL4vvME1qvw7fh3UO6xdPWTVkS0D5cX5
         Kijt1avTg4XKdxRSz6qLL8QO92nuqziZg9ZktBsBhnFkqYu4o/yNnduEECm0MJD9iR4j
         /Hptypa4arbWngtvKG34+ufGSJrN3hvZ+6Z2KcmckQiq6X1LeLeuRvRNjx+qzk3x5A5M
         hNc+dRu0bV8QbpQHSk853jGszRCMVXvtnMZSqb2TF4svA4XiOwnXpwWSBcfz9jSVGOAj
         EL6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784149562; x=1784754362; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohcHmnwMMSDmJjfmYivpS1QS5sro1hDQqWxGQZCr6A8=;
        b=wOU4GZJtSU7Lwga0jExKpSsyOS5owiRux3+9bhSuC5A3nsnBPX69zxGDrIgFa+wLEw
         xmkJSpoXnsKplAF51qLQ4QIQasfo/qLp3mRAIxTKS0waoIoq0ORGX+RsM2RLqA2TGuLV
         rfgaEbVK6Qh7yE8yr5oI5ar2kKU4ruwxkmsEq2SkHvqzCEFlMoYY7Wxd7E+tcQLEktMT
         kWDiRTL6185fjIE9tuuVElTHyHfp7slgZ6sfQ9hsEyjVfYfxnccDKTXfBumVP92YbKub
         q+OrF4Kq/9BzK+pVaw/vKAawjQTJtBO9U4U8yhl0JuVzzYA7wJzCaa1iT9CCo6mpYr7H
         B+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149562; x=1784754362;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ohcHmnwMMSDmJjfmYivpS1QS5sro1hDQqWxGQZCr6A8=;
        b=D2AZmbNsy4gbRo8ST3R70Pdrcee7+ThNAxYRXsNuCDT4l8FFwbXUbyAGod/Lgbqf0R
         2eW5PmDk4uXHUfp25T73LF7fHlT+WXPQciMixvaPMS8iniXRUoH8PpnAE1g8XuV7ProP
         oAol/oCNToeO6pUH3OsCeefT0E/3jyWOCTtaVlXKNbj/2AIjWpKL74yyNBztZfLIhaOP
         Z10rNmr3l/t2+2yj0YbDKQeeyPDVT8ocCt0MY0liPleGV4wP0Gz0595pD54MMTRcGdYc
         s3K8xkrfihCl5MyQxJBjF5lJG370a/2wxq3vARvtmYgArgfZ2N83MrwV76o9XwGRCx52
         bIEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFMjYe4nPCHVfhUw56rH6EwGhnZW/ofeaabkFHh8LvmfY7JohK6l6MLPFNhRlOhsFIcBzSftV3vSjKXMvV@vger.kernel.org
X-Gm-Message-State: AOJu0YwCcv2eVG1yAf7vDydg3Se7gUfX1F0So8MpHbU1BAAqirN+/Y3N
	/vupulehkQiwtoiCDLv6eDmOrgghcJ/0IKUUShjsBhPDVaqhGxxVx44L28R9xfdrAotoNIJd2Oy
	vSsVg//XRuNGeQcO/Xv03j6sQWGAkuxaxDhNBdgdj
X-Gm-Gg: AfdE7ck4C1FxytiWlqxVNLOcowQlD+pOAphzpCjraaaoiizIBufpSov4f3cdg7FHhCT
	1VsTS4odM7lvL6H0kMM/7h4L+mrBPNbB4Diy6seUTqrP9phbhu+bJ8VhWKtcyPrnBq8mHAuSNst
	Dshp3m4y4QgKVmxkkK+91xnYy6vf/T2Hz3M9hogRdZuY2Nd1m9YTwdWbK2HaeiBmE9MPy6goQTf
	pKTyO44TYjby7IHZejPPmRYCq9YS5LnuEqNKu6J1KZEAoyICwFAnHHmz6uj5g==
X-Received: by 2002:a05:6a21:68f:b0:3c3:5c54:b841 with SMTP id
 adf61e73a8af0-3c36c1cfa7cmr4647228637.34.1784149561545; Wed, 15 Jul 2026
 14:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712165610.366474-1-timday@thelustrecollective.com>
 <20260712165610.366474-2-timday@thelustrecollective.com> <alT2yHlfzhTZ9n4T@mit.edu>
 <20260713164417.350710-1-timday@thelustrecollective.com> <CANpmjNMfQT6Z9ke4x49sp6z8+pt_5ZLUoSh0da-99bwos5-8Lw@mail.gmail.com>
 <CANpmjNM5CmQc_YG_5=zhdLCr7gGL3QYPcd4R4=m2NzwNY03d3Q@mail.gmail.com>
 <20260714211246.1046948-1-timday@thelustrecollective.com> <CANpmjNNU_GiRW6y24hvbUsXze+jf+9ptx8_Acq1Y=mvPSr=wFg@mail.gmail.com>
 <CANpmjNMgH3sX-RoOjo4Vo2Dqx7=3rov1Mz02u+vKt4WkNuSg3g@mail.gmail.com> <20260715162742.280285-1-timday@thelustrecollective.com>
In-Reply-To: <20260715162742.280285-1-timday@thelustrecollective.com>
From: Marco Elver <elver@google.com>
Date: Wed, 15 Jul 2026 23:05:24 +0200
X-Gm-Features: AUfX_myRuHlqL0Vte2HOV7aqxou86jIYi-LrBKmgVTBcKZQHoVH6q4rRg3tFW9w
Message-ID: <CANpmjNPR0kEjBZHkODU-fwjQkue68Xbs890qHnVrZLiDp18Arw@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] ext2: fix ext2_xattr_delete_inode() context
 analysis warning
To: Timothy Day <timday@thelustrecollective.com>
Cc: Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Jul 2026 at 18:30, Timothy Day
<timday@thelustrecollective.com> wrote:
> On Wed, 15 Jul 2026 00:52:07 +0200, Marco Elver wrote:
> > My Clang PR was merged. Can you rebase and send your Clang fix and add
> > me as a reviewer? Please add a more elaborate commit description,
> > because it's a little more intrusive and the problem and your solution
> > is less obvious.
>
> I submitted https://github.com/llvm/llvm-project/pull/209796. I tagged
> you in a comment, since I can't add you as a reviewer myself.

Thanks.

> While I work on getting the LLVM change landed, I might try adding some
> annotations to other drivers. I have a series for infiniband/hw/efa/.
> And I've been working on Lustre as well, since I want it to enforce
> context analysis on it once it's accepted upstream.
>
> Is there a roadmap for future Clang static checks?

There are some ideas around Clang's lifetimebound (+cc Alex looking
into it) being used in the kernel.

> Other ideas for
> using context analysis? I'm really interested in using Clang to
> improve the correctness of kernel code and I'd like to help get this
> adopted more widely.

As for context analysis, there is still lots to do - mainly, enabling
more subsystems to use it (which is more incremental vs. the initial
infrastructure chunk). For context analysis infrastructure, one thing
on my list is to enable more context lock types, esp. adding support
for preempt locking (preempt_disable()/preempt_enable()), and IRQ
locking (disable/enable IRQ and all its variants). Preempt locking and
IRQ support is likely a relatively big chunk, and I just haven't had
time to get to it yet (I'm busy with heap partitioning in user space
and kernel right now). If you are interested in this, please email me
separately so we can try to coordinate.

Thanks,
-- Marco
