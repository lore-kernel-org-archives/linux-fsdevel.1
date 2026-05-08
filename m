Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7D3E4C9D
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273629; cv=pass; b=iKxDHCsQ+hS8Mpv3+M9OHqYMa5hu2VpFlxWWHmGwWhuo8fkUfhdm2zUweydnWNj0fXaPW+rOqAlNueya5v+S/SRt+mWDuXRjukn5HrfwIH2H9GVaFKIFSvlG9OfzSi6N9g+UZiuTHAX5ShkC1PDurRNbmjaqpY9gclOTGtB5fBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273629; c=relaxed/simple;
	bh=95IVxcvqWG/JPgHLoMmXlIvgmhSj0ZnffrludpYS+b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7t1SYU/U/P0BDuoGZf2pW7a7xeVia5McTe4oOeUR9Y1yxlCOMwSlVaaJTSIalPThpXOhmqMsLyGSxNIxFXvoKk5/hp+v1UQbGHiDjvbrxsoq47zJWnWXqntwpp2ius7xrz5lnvRbFiq23IPTFVQsB9SQ+IL4xisVmnLpFHm0pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dO9DTlgQ; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dO9DTlgQ"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-367cbac9cb1so148120a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 13:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778273627; cv=none;
        d=google.com; s=arc-20240605;
        b=MNXURsmK8VTsOwWLtBQ1azT09eqwVutaP2MULGbBqXm6I5d0l5sNt99+qzBDkdy4DM
         2yTw3yNn9APeHyIaXmhMxZ+4MVO/H/rAwYvt0I4lbIcbHPx1HMPLtpJtulWMc14+TwOW
         2huOh58feZYZ9NP8fGPqd8M2/LdB/ktRRzTFBryM9AGl4JVXMH5D2UZqKFyzUYiDaQke
         YQMM68W2WQdPjdzSNgLxlOEF9kTMbRVfpEBsRJpviXeUjKTuQrG5CZV1dmdsGNBaKbCM
         7vsK6zAGyg+ATXZUITaRL6HM9HDkYYEEg4dr+eewJK/tDFB8S2P8d8zGMNOwhe2VhQTu
         CSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWh1iviHf4ogJ10OkMdUK6imNF3ForFBNVwSW2PZTR0=;
        fh=qfCmepgiAOiOkHO1qhjBdNzcWAIFD5W4mqyMypNpLjc=;
        b=YXTELjBcgX1gsuQCJCVLwWoldWqEVlEuOhND+BwcWzSUO7OuKbqg4nnIR7Grbx1sFn
         CAZ6/iCHtW0FTt7j4PlWGWvTbOBDXhE/L/6g4AxvDPxjdBQUsGglA3seTY2dCrzuNap3
         bRSV45C1UKvMJvOYszTD+DY7ozyVkQqgI/4GDYoiE9tWRAfXB7Ti0aNXmPW4cHndAEh4
         R6Q3q8chuHeKBuvnbr5b5ezdLl1gYMzZm3vBzqAw5z7JvK9CjQCElQRtj6ahYIGGyC73
         il4f+IW3LVF5riYazNs/UESbSXtkxZC0j56ZCjyL7oYs3QL86ULQ6b+DyxqF2cur9EdD
         mnMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778273627; x=1778878427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWh1iviHf4ogJ10OkMdUK6imNF3ForFBNVwSW2PZTR0=;
        b=dO9DTlgQfsP6r2/MbL7aMUDkGQ4OLsZv0vYaf15PRIss3gRaJnowuxUHcSTUva6W85
         j/J+VjqQFgVev2klxrYTwwe7wgIO74KBi8ycfATzCDimRON9YD75IEBw3xION86Y4N1t
         NjrhyMDHgZmXM4viWlybsq1Qt9tp3H+flY1WSkGRX/mJRBqcNybrwAi88BJWKbzj7tx4
         VLh0co/3VJAuzXKuJWe+SzfSACIdNtKXKNLmK2ezmduu2usGOLUfBvb/q7sVfyYt6BpJ
         FXSWp4s7M9aklH2uiCsBM/jSbStdmCIISoPD+PHofmTIhlSMS4yGPETjhs7ejJOMsnJ+
         YokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778273627; x=1778878427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWh1iviHf4ogJ10OkMdUK6imNF3ForFBNVwSW2PZTR0=;
        b=XdsO1ld/Y4asNCl0y2U8qZPxet+sOtopef0aF7RsKzcxSbjE1K+VtH1MAHZW+kgrAJ
         FszKCySLi4EvhU00GwazxrcnZrZiP6u02ed0hvHpAZusiN3AJWabnCXf3NP/ihivxlWV
         Wv/sneia5BstChO3Q1KVAGlOAT2JlwNjjEjnaWWUGUOrL2cIAriq0hho4vD31gJW+sqI
         8S4c9jaZQSJODwtNrTwVT8HKWEh2uYtQSLgz6mACADk2yZ6FoeZZ+yUOfSkOcsXOVPWb
         J/Dg+JFk/7Dm36ynxHgKjWVBLs1VO+7SAvWu1uywq+VCE36fC6a25HfiW/SlX5o5Xy+T
         PKgw==
X-Forwarded-Encrypted: i=1; AFNElJ8Zjt4vDhk/4nLz6h8sqUpcB85ElL3ZSTqwfUcl6wUoDITAeDp8YJcGY4c13XWhhMjE9osrxh+ODXahezOG@vger.kernel.org
X-Gm-Message-State: AOJu0YxEkIFbk7ODK4uk3UNotA60B6MgaX8+0uywLKHClKkeInyv2H9P
	N3gx5q8HDehHjWktipOhfsTP7p1K30BOmnf8lzdQZV0dGvN4mtTKFRh8A83cD+wqPbbIPzYeGAm
	SeJxs/nYROwUNByBVfz2jnW3dJ7V7qU0iM9R16zKtF14hLWPwF1M=
X-Gm-Gg: Acq92OFtmEbJiGNG2phB6+pUk7fxjLKyp4GHmxJdw4IdQR5ah6NQKZYQjZG/GHTZeYK
	qCLQNxs91sHLVP6idb7YzK+qhxQ/QHdhETq80dKUVRfIQonQGXA1TQ7eOknAhL7WJXeE8ZXr74W
	l0m8++lfJsqgdTXR4EhJTsdpdRagnl46oAOBB+QgqNU/f3CKwQEB5kxTHKhTXSe20w6ho1ppDbC
	RfrwbOspY0QZm0V6g1jXHQ1cmYKgvkPsTXPrQ+QVgFigIN0Iz4/ZnKOEJMFSqGUe0frMM7JckN5
	KobaBq7B3CVUTapeUZhlrP8JSeeP
X-Received: by 2002:a17:903:1b07:b0:2b9:eb6a:68b5 with SMTP id
 d9443c01a7336-2ba7a36022amr136938945ad.38.1778273627590; Fri, 08 May 2026
 13:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430000315.918964-1-song@kernel.org> <20260430000315.918964-2-song@kernel.org>
 <CAHC9VhT6YxJQqSkBbSeACFL6+AoL0031u2VT4fuRqPxDkGzSfw@mail.gmail.com> <CAPhsuW6VqfPGnMqwSu-3EC9suWScOBZDHh16d5Bsg6dcjcB4ww@mail.gmail.com>
In-Reply-To: <CAPhsuW6VqfPGnMqwSu-3EC9suWScOBZDHh16d5Bsg6dcjcB4ww@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 May 2026 16:53:35 -0400
X-Gm-Features: AVHnY4JRDMNUmX4JH5JunmLlULux3slQY9_dADVN9V7Jbwgw1Y6mP1Hb0ty2Ukk
Message-ID: <CAHC9VhQ237o27ej-_0tgv08KF-FaX9nrRyUF_9pE4uaVMGqU-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] lsm: Add granular mount hooks to replace security_sb_mount
To: Song Liu <song@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, jmorris@namei.org, 
	serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	john.johansen@canonical.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, mic@digikod.net, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 4:29=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Fri, May 8, 2026 at 1:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Wed, Apr 29, 2026 at 8:03=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > Add six new LSM hooks for mount operations:
> > >
> > > - mount_bind(from, to, recurse): bind mount with pre-resolved
> > >   struct path for source and destination.
> > > - mount_new(fc, mp, mnt_flags, flags, data): new mount, called after
> > >   mount options are parsed. The flags and data parameters carry the
> > >   original mount(2) flags and data for LSMs that need them (AppArmor,
> > >   Tomoyo).
> > > - mount_remount(fc, mp, mnt_flags, flags, data): filesystem remount,
> > >   called after mount options are parsed into the fs_context.
> > > - mount_reconfigure(mp, mnt_flags, flags): mount flag reconfiguration
> > >   (MS_REMOUNT|MS_BIND path).
> > > - mount_move(from, to): move mount with pre-resolved paths.
> > > - mount_change_type(mp, ms_flags): propagation type changes.
> > >
> > > These replace the monolithic security_sb_mount() which conflates
> > > multiple distinct operations into a single hook, and suffers from
> > > TOCTOU issues where LSMs re-resolve string-based dev_name via
> > > kern_path().
> > >
> > > The mount_move hook is added alongside the existing move_mount hook.
> > > During the transition, LSMs register for both hooks. The move_mount
> > > hook will be removed once all LSMs have been converted.
> > >
> > > Some LSMs, such as apparmor and tomoyo, audit the original input pass=
ed
> > > in the mount syscall. To keep the same behavior, argument data and fl=
ags
> > > are passed in do_* functions. These can be removed if these LSMs no
> > > longer need these information.
> > >
> > > All new hooks are registered as sleepable BPF LSM hooks.
> > >
> > > Code generated with the assistance of Claude, reviewed by human.
> > >
> > > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for sel=
inux only
> > > Signed-off-by: Song Liu <song@kernel.org>
> > > ---
> > >  fs/namespace.c                |  35 ++++++++++--
> > >  include/linux/lsm_hook_defs.h |  12 ++++
> > >  include/linux/security.h      |  50 +++++++++++++++++
> > >  kernel/bpf/bpf_lsm.c          |   7 +++
> > >  security/security.c           | 101 ++++++++++++++++++++++++++++++++=
++
> > >  5 files changed, 199 insertions(+), 6 deletions(-)
> >
> > ...
> >
> > > @@ -3708,6 +3724,10 @@ static int do_move_mount_old(const struct path=
 *path, const char *old_name)
> > >         if (err)
> > >                 return err;
> > >
> > > +       err =3D security_mount_move(&old_path, path);
> > > +       if (err)
> > > +               return err;
> > > +
> > >         return do_move_mount(&old_path, path, 0);
> > >  }
> >
> > While the security_sb_mount() hook calls into do_move_mount_old(), the
> > security_move_mount() hook calls into do_mount_mount().  As you remove
> > both of these LSM hooks in patch 7/7, should we consider moving the
> > new security_mount_move() into do_move_mount()?  If not, how do we
> > ensure that we don't lose coverage when removing the
> > security_move_mount() hook, or can you explain why it is not needed?

Ooof, I just read my comment above - that was all mixed up, my
apologies.  Evidently it's been a long week ...

> Patch 7/7 _replaces_ security_move_mount() with security_mount_move()
> in vfs_move_mount().

Okay, at the very least you should probably change the subject line to
patch 7/7, or ideally move that hook addition/modification to patch
1/7 so patch 7/7 is purely an unused-hook-removal patch.

> IOW, security_mount_move() is called from both
> vfs_move_mount() and do_move_mount_old(), so we are not losing any
> coverage. Did I miss something?

No, I assumed patch 7/7 was doing something different based solely on
the subject line.

Let's also put the vfs_move_mount()/security_mount_move() change in
patch 1/7 so that patch 7/7 is simply a hook/dead-code removal patch.
This should make the patchset much cleaner.

--=20
paul-moore.com
