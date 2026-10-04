Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0FB2367B8
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Oct 2026 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119887; cv=pass; b=TgqJv7F0yjT7T4lsUigUThHnxdkz4gCoAlVY+i0f6GQ5/HbldAgiH4qoSORVhcS9RRQpdKShSsdok+OOAA77Y9EctN/aSNvm6Lb9C6nYeJw34PM3mITJsu1LjLlZbl+u/iZqvpDRAeS7hogrRxIDlfA7z3i/UOIRW39NaiSn9DU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119887; c=relaxed/simple;
	bh=kYFPIdi5qIwk5fFvla5ev9INmB4S2FDhesXe326Sjh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgpibkWEagizWCqjOscGMlCnST/Hh5kkqMG3iZvdMtQxbVwAGyQ2haHIVVntSiOqb6mSnquiXcxZcopnBP69py08vjD6iosyHbWYt/KN+qL6zqH99zSLG73dwyQ4F9LuKGGT9s39hhjfx6OwLsIu3YxIScghVB8f6fyjUFtYw2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ewifg35h; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ewifg35h"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-86aecf49833so118911b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Oct 2026 06:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791119885; cv=none;
        d=google.com; s=arc-20260327;
        b=D2W+10nlv35yMMfEXRwJN67STFWRXqYAR//awvgFcLdr8eO07xsHc15vPrWRcnkIL2
         tLOMb5jrptRxwJcCH08APRvac+UONtbopZP0CP9kUWDjsu18pSkIP0m2F6NcmEIyzDxS
         xc2DlcbzsHqCl1lhiiDJemnVBZfoIyRV1NVYl8U5XR9a8WD7ZPSAs1faS7jECfLAUJac
         wcTmApmHzKyDd+ymsREjPpUbnxNwLgdJfVUWiEdmEH4AmjXMd9ktmc59BxHLv6IwT1TI
         2E1BhSmUkM1YN3UbGLjQ/cc8Bw1p9vYdPfb9Im1xhj1s5CasulHnvL7NFhPvbQ5jrTrY
         /99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iqK29hcraqSjkwKPoayt4W5plvnH9pNitz/JPZ6I+94=;
        fh=XJ+SEZ69T9lzJG+7r5W7XFZd58Q7QxpaWKf8rGTUKA0=;
        b=cO6N1D8a7XFXvXCecyqG/07bjbGIVZbC3YugldTCA6MrfLIS4Hq3P0/XHfhn2vKIsx
         h99p9LCwi8oBTlaOqF/E8dWIiaBVgUMXSpvH4QfHwQ8lzyfQ6poAQep8A35MOlL20JFR
         QCXH7QAOBlSxZxU9bO0eWjQ1bR4t4hoqqaU1YRVbBgO4jWdneEi+6UOROCHvS6cxrGtn
         lHUH/u6x/zt8Btotzz2zwcq9Ea4sRFKUMyHlSnzepdzPaWXSFfZIIljEHeRrPLoj1M3l
         bU9AX7SUGoEtFYbQw7Ee04YdusB9pLGp7OE9ehXLvmhAH6fAQ6fH6D+ZgaoACn/UPEig
         jQtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1791119885; x=1791724685; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iqK29hcraqSjkwKPoayt4W5plvnH9pNitz/JPZ6I+94=;
        b=ewifg35hKNmJo7++/l6XBeGLxab3+vtVPZngOj+k5KRUjKjiq8Z8+GJs9qmVkSTsrc
         ifyXUqwSftzmJzFTgA/W/VlRQEM5ncCLeRv0/8yV/GlzfjLKnXsXVwp2vwIyfnoa44y6
         oYHnPfGHs9PpROzwgyHINRGGZJKHky4TxXmeEKNRbdq2mU37cfKRpz2Q+CBfW1BDUzo3
         wy+gIbvlRDWJQ35xharx0Qwwk0j51+dZbFvmljKQXDDToBUWxGbpJum5imAtoRAwlbeY
         MF+0nXQNJocCXY9CFKvl9CEx50parfa35sbNYugCRSvU1M2uFw5waw4/Hv1/tP1ykCN/
         2kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791119885; x=1791724685;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqK29hcraqSjkwKPoayt4W5plvnH9pNitz/JPZ6I+94=;
        b=Cs5wVMXTZjnQY1WaOPaMMQA+YBqGYnf0o5KvbC1o89iFVmkXLQ0ZKt+DGLe1b4uHCN
         eZ/JUvGUgBcD4vkbLeGix8sXJqlfQN1ItdUj1CFeko0iNW4FGqF4gVdzNe5aq+MORDo7
         0v5IsBcC95qevBaHBvQsPlAzde3m2M/kSt36rlQ5uu0aA08WXemBNf6TbAhr0xF09Jju
         bNF5zBoE33/tY8QYnjumczOMAstTUda4tg1IUI4kMRM8yaegLuCJoJUY+tXGjDL8HLsq
         MufQU5KKDCDFD7rseUjps4sgFCp4A+K9cL42TBNCoaV0Of7sxa0dA7s0jA5XF5fvoOBD
         nSCg==
X-Forwarded-Encrypted: i=1; AKwUvByQ2R4zS17rgGr91DfiTpFC6foCkgvF0X1975iWENdrenypgAhxFrVIj+OOYIvVwOaCTRfRjXCsAmMLR/lx@vger.kernel.org
X-Gm-Message-State: AFuF++msT+TxFuJXAv9Gf9PCyenaRDY4p8ZkRgilXhDdRWbCGS2G1iFA
	6hJ6k9ZDB1+v0bd7DyGA1noVqSRFRX720X2Qowbl/YZuZ1I5sAe1jwVT3fBqfjzl5lTt0dlbiSe
	bKgKk4tdaSn1Asa6rG2uuCZyJ7F1whDRk90IQ2Fg0
X-Gm-Gg: AYBFou3sRH6tUB+FswoyMsyV4mifLRBbWqzxlh1Y5QG73vLguDlt0HnDUdlOIqxdmOk
	Knaka+oy9I0ZHuXbnQuLyEiVS7Tghsa6SN8Mb+guYiyW3c9vDNqRDs2Jmr66N4/hHfODcMyVJiN
	1i2vinaafTSwZr2/suCQAZ14ajJcTT4/ORW1j2MIBoKh4xQ5MHmL9xprQV83XzUdkHd23ofoe5s
	V6gX9Bo+RMjRd9nUtPI//bLAht7GWDPB5AeldMb0u/kcywhBxXGjtMDvwG75UEtZkWnEFcaZXbF
	BF6MLRXsUEpwAvuJ3VMgjADYUqS8qFa12wARqCrjD/yL55tzmtmpnhwBxezfkR5LoPr2KVq3KOL
	d39KZ8anxnyY=
X-Received: by 2002:a05:6a00:a0f:b0:880:7f48:5f07 with SMTP id
 d2e1a72fcca58-887fb5cadf3mr7829367b3a.6.1791119885275; Sun, 04 Oct 2026
 06:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703122548.1623981-2-rrobaina@redhat.com> <alaO+HZ7qJ1Iv9SP@madcap2.tricolour.ca>
In-Reply-To: <alaO+HZ7qJ1Iv9SP@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 4 Oct 2026 09:17:53 -0400
X-Gm-Features: AclHuK93CXILhWqVoyyCiJV7kNi7hXkohGtKrcJ5HI3-Ast7QrPAddVZAM79UGo
Message-ID: <CAHC9VhSosDsvCZyq0yY3Y61r5Od52WJecqcEjrT7XGkpyBi-xQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit: add FSOPEN record to log filesystem name
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 3:33=E2=80=AFPM Richard Guy Briggs <rgb@redhat.com>=
 wrote:
> On 2026-07-03 09:25, Ricardo Robaina wrote:
> > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> > syscall. The generic SYSCALL audit record logs the fsopen syscall but
> > does not capture the filesystem name string, creating an audit gap for
> > filesystem mount operations.
> >
> > Add an FSOPEN auxiliary record that logs the dereferenced filesystem
> > name string passed to fsopen(2).
> >
> >   type=3DSYSCALL ... : arch=3Dx86_64 syscall=3Dfsopen ... a1=3DFSOPEN_C=
LOEXEC
> >   type=3DFSOPEN  ... : fs_name=3D"tmpfs"
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
>
> Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
>
> > ---
> > Changes in v2:
> > - Better placement of audit_log_fsopen() call to avoid UAF.
> >
> >  fs/fsopen.c                |  3 +++
> >  include/linux/audit.h      | 10 ++++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/auditsc.c           | 13 +++++++++++++
> >  4 files changed, 27 insertions(+)

My apologies, this patch fell between the cracks, but it looks good to me.

As this patch touches both the audit and VFS code, I've merged this
via a topic branch in the audit tree, topic-7.3-audit_fsopen.  The
branch will remain static and it will be included in the audit/next
branch as well as the audit PR for the upcoming merge window.

--=20
paul-moore.com
