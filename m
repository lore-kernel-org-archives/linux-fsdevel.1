Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC74BC001
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650406; cv=pass; b=bMEErC9rMLAXQrcXkoxk2FabKh8nuWVdHFvI+zwU2qdH7+e6m8XVszw69hHtgrPoVV6+J/XzZJuuVJ2wCAbsmVdPfoQ+hu+pEk1zMddR0sKVnvqL+u71iKg+gJLoKoSVJuLRFn8yu42F6wf5vhS+LCWEf1S2ALXQwXRWsH8lxNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650406; c=relaxed/simple;
	bh=N8qtdxMc9FvLeauKjzXElFTLChhKrM4qeRXr0Gv5hMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGtZ3/ngsLKKPr1RkmfMHp1kmptg6J04ZL3XHHkAuOFMJPPCyQJ1lj+Kfr6ujlsCJ2czpXb/PVNpqw3yB8dnpNRDLvyVEw0rlIeQI/nKq4IQKEnSu8E7YcAGAS3CNDbCiV7KYToKAMsb2C5wQCkTl7gPtkfG04lvbs2tFWr15XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTXAfYmt; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTXAfYmt"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68bac6e24fdso2369498a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 02:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780650401; cv=none;
        d=google.com; s=arc-20240605;
        b=DAzwxs3JS8WxglEeNFFroq/Q0TTHwfL0ASjbwnmp6XXXcQCs/NjxUX2McY0KmyhvWM
         HV7hX8Cz0+SGDgupv93f6nTEeSJ3QbLkbEIg4dxhkyX6iNCO9hSTVRADY2E5EhdZjuWw
         8vL/EcYNhgkrDmKlzTozEYWt2Jw4GJVgwBRIFqNoCXnX4Bsdg5ud/kTlaMHpin6v3XGP
         T6FvKsldTozAQVFFNrn7oCH1r4I0eZ35WifwkX3PhJDHJI/nerS4cAUQBJ5REToiavtK
         6G5F6TK9K9p6SKULcUMOwlhx2ysT5VdhU4ciOxflVUSyCEW0febmnGWQCtFg82afku14
         voJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zFzbZMpTUnNwaEuH74pi471fj/IDldYJaiG/NWnnyFw=;
        fh=4vWnLqpz1FuEF3+M0ETCC3DPLATB7uaPepujXUn7GrE=;
        b=SKaIg8eXnNnR5UhvGiiCCcl6/HBPkP7m00dOjD+np86SEW2Me0HIpooWc7dKx1ANLG
         0fkIKUv+YVP92HmSHw6BTQe1E5LfZwxXfKywIVdmiCsGMAU73xsIuKQJEoxhh48UVND+
         sd83kgSYLz3a3Jp8DheFgDD4wLKMpLj989r5RAy6x6gQPVZ2yQIZjQUFT/UlZBfyOCec
         m12AVZ/H5OzTCdLMMkNdLDbGjphByuHUcLedMXjblD10bDA49dEt2qDRvYc+n6QdQpY1
         sPf7vetoeMChvAuIJ5AifgBlKfBNO/STDYkbU+LQMMdvwrmLR0C9M1kVy9G0AWEIR9Yi
         1oUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780650401; x=1781255201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFzbZMpTUnNwaEuH74pi471fj/IDldYJaiG/NWnnyFw=;
        b=sTXAfYmt4agouPBgEoBkOi0TXT37uN+u/zZcStaNLykIo81IvdGEvAj2TxpsV1sngZ
         c4zjUWxweAmgn7gAP8pQvZ5f+kNxIpmOg0rygWD+9QS/qUfnxs8GZUrNbTZSSOyE6Jbk
         mgVKruyzlRRi8xGXw68qwYwYX+l2ujsZ57vpr4r+R/kK6DHmmQtS1X+5E6Sukd3g3LYT
         r1D1VBbkouAPHLuXFmzpADM7YR6g1ch9MMtIU9Njto1/YqMyKeSdNe9LDUUQNZrmWUtP
         WG//a002TAa+bmN9T/XabSA/kvNM1ZxYzLLqt9mcFHBvUo5AnMaYlsd3PLp6+szDpUqP
         Ag+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780650401; x=1781255201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zFzbZMpTUnNwaEuH74pi471fj/IDldYJaiG/NWnnyFw=;
        b=eVbEYVVPoSGhubns68F5wSVXWzqJF4fkLyPIWk1n8Dc37qFcdle1iCsRDwddr8zJxa
         ++VkKQ0jcRamXzDGt8n8vNRu1llAWpSn2M5JW3U7EMicaXwi226+dd7nDHluq0sd5Qwk
         BcVEvhEAxD5YOANxCl47cKE1D0K7LDpQ9/XFDdkl45aPqUdnR5jT074R6wN3F5oFxNEI
         NkgP1fl7wvxGe/DWY5fO+4hu2qSOv9K7SoNMLDjjwKwrdZxXKcogakkBtSxA7obHjhmc
         s4e8j9rqMIVffJQv3oWIQ4Pe/ZEnIXotEQkqtp6el7pu9NlQrHH91TJ47AG5PTvA1gZ3
         dEjA==
X-Forwarded-Encrypted: i=1; AFNElJ9s6venWBwrlsKWsw/4pm4rssdxznr/LYNBps3u7Hr2RpBoPfjvZd7hGhE1XzCpt+6DoFo/szs6OuRY6uT2@vger.kernel.org
X-Gm-Message-State: AOJu0YwTESbTrEbBDjl/xeSiP6ozG7ODtVlt/fcr6iPK6vtAb6/CsMIb
	1Zg5gh+CYwn11ZJ+JzVPTDpoAomgavEdWpZ8jjr5ui5F+WM3k8URV/mzQGW6CCs2e0t5NQf4Wmi
	CMeEnGZ3w576dN2+QHctG5ZlHsiYFfI8=
X-Gm-Gg: Acq92OHkXoHCAScKDER9zpE2af/4efo9Stgt2DUfojc02GJ9Wiom8tKbXijTgqRg7L4
	vD3MqtvxqGkoKPpBV2WoRmcqqCK+ET3RTGr12PHrPoJv5RebL/CGruv4LbwKBczgkfqq0UpH9gw
	wDKcxxFFx+sA9A0COaAu+vLywFbLHBl2DffoEKEoXFnEwXafcmAqQlcVyzDzckutjjAzlisV8CN
	anuNuseBm0nzHwzlI8Z2GIanIMDFKEGprqMe0Wq8zit3Mgp8CVobLfJNpB/G2CkrkChe0a8mFll
	tDPs/Wjdm0Vc3lld974GaFuCuvIMnb9tRrpvk8xqEcWRchjCp3PN
X-Received: by 2002:a05:6402:3553:b0:66d:d2f9:520c with SMTP id
 4fb4d7f45d1cf-68fa514446emr1215917a12.19.1780650400982; Fri, 05 Jun 2026
 02:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601152327.2069787-1-mszeredi@redhat.com> <CAOQ4uxjFg4rjwGjU2LvZT6AhC+gBk_6Ej5S4p4DKuk8=a71cRw@mail.gmail.com>
 <CAJfpegt5Q0nmK0JKAfa4Bp_SydR1qiqu7pB0JKkXSCFOYSVDDA@mail.gmail.com>
 <CAOQ4uxgc_pW57_xeHjm6xauB3Cfx3ZY3Y-NaXO_xvL==vKcFOQ@mail.gmail.com> <CAJfpegsiA9A8tc0w4JdQ52k2qMr9UrYFF3PRsxRTd1PAfhf4Wg@mail.gmail.com>
In-Reply-To: <CAJfpegsiA9A8tc0w4JdQ52k2qMr9UrYFF3PRsxRTd1PAfhf4Wg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Jun 2026 11:06:29 +0200
X-Gm-Features: AVVi8CcdRAlIiPloYzw5RSnvG9yZHwiE-X4GIMxl7DFYongGg09g6ymP-gt1ahg
Message-ID: <CAOQ4uxgQUvpp816ZNX5YZXm9pAzn5DyAwxX4npTfis=0FZOLKA@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_FAMFS_EXT_INTERLEAVE -> FUSE_DEV_IOC_STRIPE_OPEN
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, John Groves <jgroves@micron.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 4:09=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Thu, 4 Jun 2026 at 09:39, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > struct fuse_backing_map {
> >         int32_t         fd;
> >         uint32_t        flags;
> >         int32_t          id;
> >         uint32_t        ops_mask;
> > };
>
> Or make backing ID 64 bit (same as node ID, can cast from/to pointer)
> and ops_mask be part of flags?

Feels wrong to mix them. I would rather extend fuse_backing_map for
ops_mask in that case.

But note that if we support 64bit ids, we could not use the idr map
and fuse_open_out and FUSE_DEV_IOC_BACKING_CLOSE
would be incompatible with this id, so do we really need this widening?

I agree that it would have been useful to map a backing file directly to
an inode on lookup, without having to go through a backing_id mapping,
sort of a compound LOOKUP+STATX+GET_BACKING
but there is this security risk of writing an fd using write() syscall.

This risk is not relevant in io_uring AFAIK, so with io_uring we could
map backing files without a temp id unless the same backing file needs
to be shared among different inodes or referenced from backing stripes.

Anyway, if you think we should reserve the place for 64bit id just for
extendability I have no problems with that.

Thanks,
Amir.
