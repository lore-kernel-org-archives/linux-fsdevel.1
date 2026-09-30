Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316551FCAD
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790805350; cv=pass; b=R3fdRCm2Tz+gq018+7K/Ar5cl3ym6Y4IG/MkVxR7vrDD08q2uw4y0migbUV7ALWpIT/MweHg2HNSJUVE7N33ql6KdgAIacTtpItczEY04EWWvZnz5zgNSfTfgAP6xMUKlrRs5Hhqvkor73i/EL1uSbJ8CfbLz/wRdAYvJqDLngo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790805350; c=relaxed/simple;
	bh=QmWl/AmmgMmabSUiwRaKQe9VaGRizjY/KG7QhS56eqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pd1uTnKlp+X58UVWHq8KlkGvr+OTzjHAoK+VSa2xo0+MCf9I9AptDeX/jKYD1mjBy7e4j2zHC7lV9G49LUvzPA538tcCkUxfgYduJkJXwrmn9w/DGBkx+auweaFityC5KdKCZ9IFxEqDs4xtUSdnh5WPlvE+YTyjshnexPBbs0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QbMSNeR7; arc=pass smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QbMSNeR7"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-887c067c816so355863b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 14:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790805347; cv=none;
        d=google.com; s=arc-20260327;
        b=soFTNN55D0LwLGWOK69VKXrS1L6eZZUN8XuHpSm6L1O9HAZZk2zkX7KqzPmbeYVwVz
         P6w/66HkuWeG64QzArb+2T5NgyD0FuECQWRYM6ctiRucc/vAifHdHZfozXnPyWzx+Bfx
         lOrIaZ/kiCyPCWei5ccFERsbKB+1hYKDG1PpgKBSl4f43U+1BuL5PfFiP4TL1vax2h3I
         Q912ddmFbPfFKKsDWixsfdtGND/t70rzDaWvV6KuhsUIFXltswOBLnCnZepZ37+U3/od
         LQSQ+Wfpod9/C07sRUAudvZCRQ8gVFswBUjRLom8mYhDk8htlPTjt7OPgQrwZBBctFNh
         ZD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KOrZ7yXLzKa14m8tKGoSyqvqIE7nI/4PIailhByJN1E=;
        fh=g469RbHsO/V40FMua4ax3RvzVbMms95MBUxaMMcl5qk=;
        b=jY2dXb+3xv8NF5pamoB90SVlKcqL7OyrLoyHhn/UHTkQiMB9Kkeyrnti05X1IMJaaw
         jUcknVv/U7MBROSwYLl45t1g5IC356TnevBHK5CviTsMhbkRycwh6AZ3dsSdUtDYsYk8
         w2q7wrpGT8AsFm9uJM2vbQPtig0Jo1wvPN+GBIwKHJt5z4AS0kmaVbPuDI1ZAuBYi7Ru
         6tLpiQAkCuAj0wSU2anHGUnrO0n8ZzVRIZepSNtjdcFoqIqioU7UbYTf0nbcs7BTK128
         NPW0SIwWpdoUJaonax9aBFhtrIRCiOaPBXuBXdcRG0GPEa4HGnh+A7KxBEu5r0WK7GXU
         Kspg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790805347; x=1791410147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KOrZ7yXLzKa14m8tKGoSyqvqIE7nI/4PIailhByJN1E=;
        b=QbMSNeR7DDtZpzxTUKW8CXKN7rB2ni21B0sGhvFfmZBuekqKN+mITEfR/Kqh1VrQI2
         ZQ2eDEeVZd/VpSdlzXW602GmsPJnZ6NxOT5cggxqmLhoh+HzeQSpty4Sb+CBSD/E58ds
         KSymEnr3o764IXWID0J6DM5r9hC8T4/VxNaNx/MvmTsbBd/6pgnNa3ggaK4eyXDEDj+9
         h/ziqMQvbu2xGSZW46sO8PfsJenxJLD1WJgJGt6GA67YWI3ROwOQp74TVPkLYym/Ok+x
         gp+ez2uFNDT345eT5Srgd/FkAxB5Vxr66j3OmLg/ZHIgxEZ+QM/u5RBhY7oriPRY72xR
         O9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790805347; x=1791410147;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KOrZ7yXLzKa14m8tKGoSyqvqIE7nI/4PIailhByJN1E=;
        b=FPL6lA7L5pyi3TC3RcAjYcxVQzSfKw9FPaVpnclnqvJVT67vNh3j44s7KnNQP8Mrd7
         sQIXX7vGB0Na4dIWHCtFICt9nelZugw3dfkXTcodxkPoqiBlbr5ZlkEixW0E6imTbalD
         TKqpe/F8Xmecnz2r03F+X/UBCnP+0AgvQop4VPr04kWZLwSOWN0pICtleVrVejisvpYk
         FM3nFeYHkpD1NFeVV4paRH1TtEln2yDekbBDqQfF5NjYwH3RLiu6hp/0JxAh5wJ8+nKr
         cu/jlwFC0AAGn34bZyxpbqZzKvHFNlNvgU9Bxgqbjei59UMRlb3PugEcI2et85oqFMdu
         wFPg==
X-Forwarded-Encrypted: i=1; AKwUvBy5n+NHnBYPr6cPlD0Px/vhMP7LQJgrsgbHJKgntjJ/BGQkJ/oXHKrfR5J+2Zp5Niw5OOCdgCHC3mAu9QTX@vger.kernel.org
X-Gm-Message-State: AFuF++lGLpIZ8U72AXZuvEt8AhTpkCkrP+wPDfqrOVkU+QiIXpkbDIAn
	uQZRhXVTPHyQliViW8RFVDc0PkcuVH5DJVIjeI2BrQA/aTKQvRAtUPS5vDdeNn84czdtksD8eWh
	q/7eI1RP9pQR8iJs0su503rwgYMQbYyLY470RPhkL
X-Gm-Gg: AYBFou0gh9o67i0gn9CFcX1THvst1jauKjL6zD/SIDFO7WGWecM2T4mAhT7FzI/UXgT
	r4aKipqBHeeqsPsqO8Jmor1o/DS0kCoYkvPt2APfMlV3FX4hK2v8fL9lJciMGPw28mhIP0UhVNz
	L7GnYbgtg3x0RcC1V/RExrU9lXYW00FMqxkm9X+dNpNzYn/kKftrmPfP5LWgEKyMDBH0lmR0mQQ
	CLURVzsmU1uHLSsX4dlqFyFzyRC0XhoHKjb7QgljIHsmuhgHjGZ4ZG7vMylWrg95k/5naHGtXFP
	KfNzw4NgOsXqsvhIs04wuIp5tCedMrG6/bgBQ8mGb512nWFBw4DvvbyCyGr0bL8FGnlzzaV2Jj4
	fJYf23LPEIB8=
X-Received: by 2002:a05:6a00:1da2:b0:874:705d:f659 with SMTP id
 d2e1a72fcca58-8874bf05bf6mr1951607b3a.39.1790805347530; Wed, 30 Sep 2026
 14:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner> <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
 <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
 <CAHC9VhQVVfKkRaHOp90E-WVGEVy_MYFBreUYPMc9Y79rLaviRQ@mail.gmail.com>
 <CAPhsuW5jQCe89LT_22dvQWVnw2cvpceODjvKiHEiYT9Wm_Npgg@mail.gmail.com>
 <CAHC9VhRdn-jrNJY1K=1RsZQiO80QKR3nD+DHyUM5n_a3TrxLhA@mail.gmail.com> <CAPhsuW5r0Uqu2xUzxkLAakA4=waE-1LLORSqU4SSD5sX_NEn9A@mail.gmail.com>
In-Reply-To: <CAPhsuW5r0Uqu2xUzxkLAakA4=waE-1LLORSqU4SSD5sX_NEn9A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 Sep 2026 17:55:35 -0400
X-Gm-Features: AclHuK8j3JJsG9N_X2Nst_6_FuY0gcEZPJUGwr_MZctj7YLOb-QGGZskV69W31E
Message-ID: <CAHC9VhQvaQyx35M-DJmfrVVqXNcmS+_5uwbtDgMB9SPERaQvog@mail.gmail.com>
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

On Wed, Sep 30, 2026 at 12:37=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Tue, Sep 29, 2026 at 8:41=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Sep 29, 2026 at 2:21=E2=80=AFAM Song Liu <song@kernel.org> wrot=
e:
> > > On Mon, Sep 28, 2026 at 3:35=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > [...]
> > > > >
> > > > > There is another question here. These new hooks do not have any i=
n-tree
> > > > > user at the moment. This appears to violate the "New LSM Hooks" p=
olicy
> > > > > in [2]. Could you please give more specific guidance on this?
> > > >
> > > > There are LSMs which implement mount level access controls, you've
> > > > been updating those in your patchset :)  I believe that some of tho=
se
> > > > LSMs do have some (full? needs verification) coverage on the new mo=
unt
> > > > API.  I would expect that a patchset that adds, or modifies the
> > > > existing, mount hooks would also update those LSMs accordingly.  Fr=
om
> > > > what I've seen, you've done a good job updating the individual LSMs
> > > > thus far, but if you have any questions or are unsure of what to do
> > > > for any one LSM, please ask and I'm sure the associated devs will b=
e
> > > > happy to help.
> > >
> > > I don't think the scope here, adding hooks for fsopen, fsconfig, fsmo=
unt,
> > > fspick, open_tree, open_tree_attr and mount_setattr and using them
> > > properly in all LSMs, is a reasonable ask for a single patchset. Give=
n
> > > how much time this simple refactoring patchset has taken, I don't for=
esee
> > > this work landing in any reasonable timeframe.
> > >
> > > Please consider reviewing this set and landing it before asking for m=
ore
> > > work.
> >
> > [NOTE: dropped herton@canonical due to bounces]
> >
> > I suspect there is a misunderstanding regarding the new mount API and
> > the LSM hooks.  I believe that we have all of the necessary LSM hooks
> > already in place for the new mount API, but since I haven't looked at
> > that in several years, verifying this would be good.  Beyond ensuring
> > the hooks are still complete, I was suggesting that if you are going
> > to create per-operation LSM hooks for the legacy mount API, it would
> > be good if we had similar (same?) LSM hooks for the new mount API.
> > Alternatively, if it doesn't make sense to have per-operation hooks
> > with the new API, it would be good to document that in your patchset's
> > commit descriptions.  Either way, I think your patchset needs to
> > address the new mount API in some way.  I don't want to speak for
> > Christian, but I believe these comments are in keeping with his
> > previous comments in this thread.
>
> Thanks for the clarification! It appears we can indeed add coverage
> for the new mount APIs without much work.
>
> Attached is a quick draft for this change on top of current patchset.
> Is this heading in the right direction?

Can you send out a revised patchset?  I suspect there will be a number
of people who want to review your draft, and it's a lot easier if we
don't all have to apply the patch separately :)

--=20
paul-moore.com
