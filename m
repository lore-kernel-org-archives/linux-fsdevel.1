Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513DD3D9539
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696485; cv=pass; b=WMgLtOoKhJfGc+LhAnnKfJ+ibJ51LJ1iROySG50/5fcrAOCnBpSVoodb7Ets2GuI2O2DAniXV21V5mRf0UBsmg/8JlnBsLw5K+VNFJPrlsfG62ioihd/+icVRb+hxmQpU7PBit8xhWltxbHYcAKtna6F8MI6p+kOuH43nd0YrBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696485; c=relaxed/simple;
	bh=Ff6kC5hPrRqY3srb5EBpmjAqOlTQzd0IBH6PRPcDfLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBZXmaaQYXy5Z0Ccak3o9XVMYeosf8PHHRy0E4uWhgCtOZMte07yCHN08+ABcwDMGu08cjhFGqoXKEvqH4syi3L0uimjrPxSdRPuz75MhPZzT/E6sJXHIA6ZeKADsChK7HpJB/N7Jc27FnNXHpyjsDn6nzSwkva5kn3MIxB9/K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VdY5z8Yo; arc=pass smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VdY5z8Yo"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4b4770191so279821a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 08:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696483; cv=none;
        d=google.com; s=arc-20260327;
        b=atfLIdrb3JXLG++kq7GEjvNNxHKw4nnWrux1cGd3Bn/LovLulTdDnoq7zvx0hCtovb
         lnJpuiL5dcLVrdHu5UtaLG7OxAEtPFuArml3Hunjps21fNX4JPSC+fWKyGCgggRWk3X7
         k2yy94SZN6oShI2U+M2DbDQuWjgRQp9UOg6XGr2VAvgaEvYO64mPKGEcMYZ+1LDLPwJR
         mNR2TmZUz2iNf/bhalLO1yYvqR8ZDxBWkeQ0DXp3eHF7ST5w6zshYh9GqbHNua+GdM+D
         X290Psupn4955JLULI+a3VRx53ELDx0QvUR6LNVBgJIFo7Y0tLQNDhCeN2pGXwbQ2E86
         WI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DloQ75v9I8tL4sabQ6zmS9+wLTDkp28GIOajsDW+cZA=;
        fh=lh7DfPOzNnKu2WwVP1//6PIQxbXuMng7GAKDmxn5acQ=;
        b=LmR8zr2Ms3JzxqwL3VKzZ99Qij4DP7pQjSzFZ7VDIdVO/4R6j/sviuc8Wr541GkOja
         M7DXnWqF8LTWuXIbEtsdnKjMuAMGX+6j0YH/TcIAHrfO6eZU5T1WA+azsCTL4gdvzZzx
         AKTNwotAyQtuHzUuYryHKJlqQrVaB2NMxVTCfpMdgg52bTI3EQo3J8rcLWpsOOEkevW1
         s+h4oFnB4y/ohc2Q31mIj1vYSkUcgOTQbO4VOyyfC1fpE6qhipTRz2hhOb0cOaqhBRrS
         5+rmcnXdUGzZejRc1bth7m8zSSnIOT4AMEzX9TXxROEgGgZ7pv650dFCBMZWQCLe5mmG
         2QkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790696483; x=1791301283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DloQ75v9I8tL4sabQ6zmS9+wLTDkp28GIOajsDW+cZA=;
        b=VdY5z8YoInDCnVPmPUm5T8INxeOb6a4PvVutNsPnGQMjPCHakCxQ7YRxDTJiehtUM2
         nSN/kYHZA3i5bIxkbPnO9xP4sdyyoMERSXUeQTn+/fW7jwDDC/n6ma9RIyHsAbhpJkpE
         Migw9a1iex6kLad5GdRNo2cpwj9g9EoeWdXQ7qv9gP4J07Tfb3hFB/xBwZD4Bykok7ky
         Vb4fzSZm4jEQuF83TmfGMBsOgeZ7wV+J9INpJeVL6R+lzdOJ8tbUynrrK+jWj+ZOorrL
         x03MuKlVvaRdTxLwhGuYpgaKsiQ2IlPvoM5B3FWeKYUYj+uTNOpPS6mBvowOQwbGIEQA
         4Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696483; x=1791301283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DloQ75v9I8tL4sabQ6zmS9+wLTDkp28GIOajsDW+cZA=;
        b=aphX9+5Dc2+sXnIY2uK05N09DdjvYtkVnXQ+xD2HxCkWiYe0mZHYBX9XRXId9vib4L
         j9zpmasbG9mvOp+eArH6YN/+Ri2KpU40+6wCp8YVjnot5z/Tx90VYUq7SdmKw1IwSe9I
         8LBcS3/Vd9y+E0ISQxzVwSWvRjv7+dk0ToUPXPIkwE86VhPkXqQ5tg7k6PMA8Yq3/N8A
         tSC4tLnVQTz+xybAb+XW7I4fh3ujRdUZ5lAFGsxPrAiwEo/kNGp/mOvlEDRtVHOCHtUZ
         mNdr5KB6JJroUKTfOlpV/RovsBeOYD7zYz0kbCWlVW7GsWWN5y4U/UTp0k9AFy9a+TEX
         IC2A==
X-Forwarded-Encrypted: i=1; AKwUvBzDDBEYNcXFFDLZYN7FHlZD5Qn6R+omCyW7O/9OT0LAzWg68GILsdkhm1jfg3ev88NqItOsMLrGyeBAzZdu@vger.kernel.org
X-Gm-Message-State: AFq9FYI0E7QP83vNN4pc4Fe0w00ZxbCbyJ0TBcF4nh8Od+NbX+1WK5Hy
	+++JZ9cVDk+p23uWmUJ5cumNJDBmfz18isyW4802X9RNnP4rnrM6VKeJEgP1iEjqYKSC/rtd0JA
	y4x5L8Ca20NH/DSR6FgWWXWNlehZWq4t2Ynyct4qP
X-Gm-Gg: AYBFou2SorFtRVQzEMQ4CXpCf0yV9Z64sG4KOv7AM+rzoNsA6tWe5zs/afD4j3I/0GN
	dHyTaIywn6YeluPmS6pkka6FATU5m8dVtxenW01r4WUGCx3uzMvhVoPL4nw/CHu083VJp1sKDNX
	wB5kzWwY4PFGea22l4gdgKO40CUXPdFzAvW1qTOWtgMd65Q7Wx9lvdO1lS928Oyt3qyR+eokt6R
	/xvlKEzuMYwXARdegstzJ6nqXzRaIHDa5LTyvpC14EES9UQ0s18pQQ4DP3ewdKCjVzYAbSoVeip
	2w2nm/KupjJu/f/qJoi490Pm8OQxs6s2GbL+IPWkzyxqsscIbisTDtRVp4i8Twfs/hOE2y8/VBi
	TSdh/0oeRUQU=
X-Received: by 2002:a17:90a:ec87:b0:3a4:a2f9:f2f9 with SMTP id
 98e67ed59e1d1-3a4a2f9f6b7mr1995395a91.52.1790696482601; Tue, 29 Sep 2026
 08:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner> <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
 <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
 <CAHC9VhQVVfKkRaHOp90E-WVGEVy_MYFBreUYPMc9Y79rLaviRQ@mail.gmail.com> <CAPhsuW5jQCe89LT_22dvQWVnw2cvpceODjvKiHEiYT9Wm_Npgg@mail.gmail.com>
In-Reply-To: <CAPhsuW5jQCe89LT_22dvQWVnw2cvpceODjvKiHEiYT9Wm_Npgg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Sep 2026 11:41:10 -0400
X-Gm-Features: AclHuK-k4dcV8AsNHD2Yr0ha3qdtOhv_YrLUXKayEeb-M3C-kGGNkoHEhnTeD88
Message-ID: <CAHC9VhRdn-jrNJY1K=1RsZQiO80QKR3nD+DHyUM5n_a3TrxLhA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: Song Liu <song@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 2:21=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> On Mon, Sep 28, 2026 at 3:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > >
> > > There is another question here. These new hooks do not have any in-tr=
ee
> > > user at the moment. This appears to violate the "New LSM Hooks" polic=
y
> > > in [2]. Could you please give more specific guidance on this?
> >
> > There are LSMs which implement mount level access controls, you've
> > been updating those in your patchset :)  I believe that some of those
> > LSMs do have some (full? needs verification) coverage on the new mount
> > API.  I would expect that a patchset that adds, or modifies the
> > existing, mount hooks would also update those LSMs accordingly.  From
> > what I've seen, you've done a good job updating the individual LSMs
> > thus far, but if you have any questions or are unsure of what to do
> > for any one LSM, please ask and I'm sure the associated devs will be
> > happy to help.
>
> I don't think the scope here, adding hooks for fsopen, fsconfig, fsmount,
> fspick, open_tree, open_tree_attr and mount_setattr and using them
> properly in all LSMs, is a reasonable ask for a single patchset. Given
> how much time this simple refactoring patchset has taken, I don't foresee
> this work landing in any reasonable timeframe.
>
> Please consider reviewing this set and landing it before asking for more
> work.

[NOTE: dropped herton@canonical due to bounces]

I suspect there is a misunderstanding regarding the new mount API and
the LSM hooks.  I believe that we have all of the necessary LSM hooks
already in place for the new mount API, but since I haven't looked at
that in several years, verifying this would be good.  Beyond ensuring
the hooks are still complete, I was suggesting that if you are going
to create per-operation LSM hooks for the legacy mount API, it would
be good if we had similar (same?) LSM hooks for the new mount API.
Alternatively, if it doesn't make sense to have per-operation hooks
with the new API, it would be good to document that in your patchset's
commit descriptions.  Either way, I think your patchset needs to
address the new mount API in some way.  I don't want to speak for
Christian, but I believe these comments are in keeping with his
previous comments in this thread.

With all that said, you did identify a potential issue with resolving
dev_path multiple times in both AppArmor and TOMOYO.  That does look
like something that we should fix regardless (I see Tetsuo has already
ACK'd your patch, but we are waiting on the AppArmor folks).  However,
what that fix will look like will likely be determined by what you
want to do with respect to both the legacy and new mount APIs.

--=20
paul-moore.com
