Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC22E2DB7BD
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784816294; cv=pass; b=HNBrbtq7mKKBR4i1osG8k42+qi4+xnEyBLkRcu75iZnJHEOxEh6BMNX0qhpYWmNrzyPq9EaFkibHC8rYrmyeSoubLj1JqbZXL+ykPSbIiBl940ebOFSLgArfNdVzl2WPXYWu3j6s7VkJ30Io5WXSO9ydhszIIpt58QBaqsNRnOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784816294; c=relaxed/simple;
	bh=N8tzJ8ycigpnp8bKwPx31LBLGqpkPT5YWOo9LUDjlg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXrTrX1+3Ci/aNEAorUKT3T8Q9OZ1BaVJLw7aiuy4ZvWGXmqo8UtcwSAaZnhTEWvZ14dl6b6l1hfFkXMHI8LVzJjWR3FaejOpfmTiK5yKLA+zyTHv4nSUUi1HZhecV1WbpVmaUT+3K+5bPYag8xBtFy7eGMFMAS8IEDazAyP31A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtVHNDyt; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtVHNDyt"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c16794450aeso90493866b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 07:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784816291; cv=none;
        d=google.com; s=arc-20260327;
        b=jOG+b+8rl2fLH16P9ggVE63OYEiF9yLW6f02O6GgeYuDtXAbnzTnv1PYrqug/ndSHo
         gB+NixCALJtu5RK5czw0pHTW3rMfqzFHHYdM2oKtKpJa09AYay8vJA74dnVMdcjaM3Rg
         7ZWa9iYQH6anrSiwyWiH1F24ivS4sgKFqsHaafs3spjXo5rpPE3CHtHG8pg2MgKVW2CF
         DaGrl+2gK0ke/6bl7WknqmDqWpEoAaiUVUk2ric/8bSC209J1qYMBuhd9TGjxrtJIzZO
         4MWMxStAkkvaTTLCY8kMAwk+c1RyfaHcigZaDyb7DkrNalH+micZAMpFjFO+062mwGdk
         J8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N8tzJ8ycigpnp8bKwPx31LBLGqpkPT5YWOo9LUDjlg8=;
        fh=/pXN4gyiY7+nNY20JKUDk92bxHmAtXA2YcUchriGVZc=;
        b=FLwH+gFtMrM6Lw6+tSwlDEvw7ZD1OWi3n3sGN4xtRuoZu+jyHuUjMXSSNyLmu6qHCz
         r00XtQILNJr9HR07XV7BlRAXNph48Tqo22sEkeiwXywiB38crHrZewJ/gaGhzhnUY+EZ
         KYYj4DzG3RDI9ez1Ky8Z3KXHitWAVFubwfa+ArteDBzOgivW9+LxF+eqtX3YXKYCPbwM
         25nBhU4whzCLDP/Obtz2QiumNZe28V3KJCUNH6DqlApPx2IBdsQSP3F0r7byIwzyXzX4
         q6zY25EvEvOJhAw8qXZC81LoRPCgQcb4YHF/x0I7KScXdzhxYfxax1UujJf/VdivHBQh
         N7gQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784816291; x=1785421091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N8tzJ8ycigpnp8bKwPx31LBLGqpkPT5YWOo9LUDjlg8=;
        b=FtVHNDytHJqfU6emlRjNT1JU7rpg2wCmDDrDQourbT4qK1I0FHOzCfMgUisdmO01IX
         eM61Bhp788CHkEo/FEE1HtjX2pZ/bQEyZu8qh5AI7A+fZrTuvHSSbbqbA3cXvQPNAuTi
         zlVSULROKQXDNWjJ5BxDFn0wu0KcVDGXUs9nKL6LBTSZYZYqDIHfYtVeQQj48J3tjBnM
         t/eFalhMIEzgEzrtHCAJxTjUSeEIkIk+Ic08gNWSB+3urbW+MtP3M6V/j4XYen7y/1Jw
         XfkFICMyL0Oe/MVJ7sE9VcrDEA8qhjRkrtKtBPMvVFLVe7183Zxpn/K3J8J1g+06F/ZG
         6T+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784816291; x=1785421091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N8tzJ8ycigpnp8bKwPx31LBLGqpkPT5YWOo9LUDjlg8=;
        b=Padjhv+Ea6NWDNvEaiuwPqAxiOruoygG+GnGSfXr5pWSa0ULlzKNxsH5RFPucBQCMh
         LrB9hxbI2b1D5mKY92LQDDHTYP6eeJuu67rMdnBX/G4SEBinFBo9vXOWKa61txJPIaup
         angJbTdJ92Xuzwf/jknNW2sYhxa8fLzd99GExh7ygkdiF6ibIqAccQkUCYkZeNYDVKMp
         JmUjYu57178aj17xzjRnWoAATXRSGIfd50WTK76Zk67dHP17sulaA0a2B8txqenf2HVj
         dQTSad1gULcq7DWq2ye7k4Ud1RfEvd1qLxvDjjitCNm1b3xbTfHuXrBHmSsi6el8rxih
         Mu8Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro5c/4CYICfB7gxhnJ6d/gPLUhZZcsgof853uRN/DR4t565UiS7xRZTYWBBXYQCx7DoVffabpAPbgocn95Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCal7nAJuWODpEJRCOlw9FhMf7PLlgllMT9oWM7LC1NiJV9UF
	hvsjuZ5b2Q8xD/4uFhiwyYS9yKxtRNcxaq/0Oc+qDuqBG4ERHkKKEHShpvMAzFqTynSnHyakUOa
	oBYUKlsL9aGqsoPVjluQxw0lLTTRAGkByi3TUzLHV7w==
X-Gm-Gg: AR+sD12hzwcwOZ9qxge0g7JDMfQ8PCJBMAfoVpJSCuZryOR5VtL9sqmsHUTXP7X6PfU
	yY1tPF+sn1+j8lqWDScJjReXRl61uFtOK0xoc23DLb8q8EVDQNPARek2ZHwr+dIUBKcxiqPxgNi
	UYXKWxxvTvEvzJRs/8U7sToJaAKfLQPmlF3arb8PL6ZVUTmYpmDY0JXXFWVZNTt4B2JDArbdtWd
	99gv2nvrRe0amJTmZq/wc1oTruRPJtIjffSKwQBhdYr1EBNUW8P14c4IwNy9pc=
X-Received: by 2002:a17:906:478a:b0:c15:ff7a:e56d with SMTP id
 a640c23a62f3a-c1c50d8b9famr145409966b.51.1784816290701; Thu, 23 Jul 2026
 07:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723114848.1212429-1-amir73il@gmail.com> <CAO8sHcn=b94SL6KTfPtnqau++-g9CXD0LOpPjp4L+b9cu8mMSQ@mail.gmail.com>
 <CAOQ4uxjk_Se3dq3exxd5WS98g287HUMjVAucipxBX=T0W-8d6A@mail.gmail.com> <CAO8sHckGrgfPnyOC-V6AP+DakG8LBXTFRHZSchXxi02LPyfMFg@mail.gmail.com>
In-Reply-To: <CAO8sHckGrgfPnyOC-V6AP+DakG8LBXTFRHZSchXxi02LPyfMFg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Jul 2026 16:17:59 +0200
X-Gm-Features: AUfX_mwXdE-m0mzicDGGryu4GVMv_y80ZcvNzhuqfcDSPCqC27mGT47UT9hEgKE
Message-ID: <CAOQ4uxh7G44sJi2A=bueC=MNGjd5V+zoyTCs5USc6i6bCbFxDw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/5] Proposal for Cross-fs copy_file_range()
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 3:54=E2=80=AFPM Daan De Meyer <daan.j.demeyer@gmail=
.com> wrote:
>
> > As far as I can see, OverlayFS-to-OverlayFS, which is classified
> > as FS_COPY_SAME_FS should not have changed behavior at all.
> > That was my intention at least, maybe I have a bug (?).
>
> I am sorry, I forgot to mention that all of these issues are issues
> with upstream overlayfs,
> not with your patchset. I was trying to make the argument that to
> solve the issues that are
> already in upstream overlayfs and to introduce cross sb
> copy_file_range() we need to move
> away from recursively calling vfs_copy_file_range() within overlayfs
> (and anywhere else really)
> as its internals are really not intended for being called recursively.
>
> `ovl_copyfile()` locks the overlay destination, removes privileges,
> and then calls `vfs_copy_file_range()`
> on the backing files under the destination OverlayFS mount credentials.

Yes absolutely by design

>
> This has three observable consequences:
>
> 1. The recursive VFS call accounts one userspace copy twice.

I think that is fine or at least not so bad.
same "problem" exist for overlayfs read/write and has been that way
forever. nobody complained.

> 2. When the files are on different OverlayFS mounts, the backing
> source permission check uses the
> destination mount credentials rather than the source mount credentials.

You mean that after the fix [1] it is *also* checked by destination mount
creds after being checked with source mount creds.

There is no security risk here, so I think this is something we should
leave as a known and documented issue, because solving that would
be as complicated as what you posted and I don't want to go there.

> 3. Backing permission hooks run while the overlay destination inode is
> locked and after privileges
> have been removed. A permission listener that accesses the destination
> can deadlock,

There are endless variants to these potential deadlocks with permission
events. This was discussed recently on this thread:
https://lore.kernel.org/linux-fsdevel/xycqm3qrhjg3uplpmozwo7nterl5tnuarghow=
mh3h3mv3thh6u@apagf4kqlkg6/

> and a denied
> backing check leaves the destination setid bits cleared.

Nothing new here - not even a bug or a problem IMO.
The state of privs after a write that MAY have started and returned an
error is undefined.
Always been this way in all the write APIs.

IOW, all the problems you listed are overlayfs behavior by design,
which AFAIK have been like this forever.

Do you have any reports on new issues specific to this patch set and
the new overlayfs to/from basefs copy?

Do you know of any real world workloads that are significantly impacted
by the existing upstream issues that you listed?

Thanks,
Amir.
