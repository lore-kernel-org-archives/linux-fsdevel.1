Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE035E944
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778271050; cv=pass; b=UGY/rfLiHT05hLgbgZv4x65waPGqL3dTDUH3VXoKRr2yNwwBujwmv7zN8wwDS66r1l6n6ZlGRQOM9IcZH8xfy9jjXu7rkWuvj7ytVRrvW3AWwn23WNQUYPO0LsV8N8BM4gU22uG/YLoeGV6ronVzLgRRWSkBw1YIvdxXYOAoE40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778271050; c=relaxed/simple;
	bh=TFrVhtXRzGaWgGBXsdmPjdMWa4luc0ZPlbhrFgpSi0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uVZgAHkoje58cncdMEUsojRBtEj1GM7hmN4lwpu8+u0rxqahWk7cM62k1D+zaNUS4bxYKpcmC2s4eLeRwFQwdUlLZl7JEwuDx7ZE9388Z2eYQQHKQEC/0I5kFgGbDdKfxS9T/xIxz8h11tPxqHZcJB/NCQ7Eux2wPIHITPvZx9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Dilxkrhk; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Dilxkrhk"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-367c26471f5so261370a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 13:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778271047; cv=none;
        d=google.com; s=arc-20240605;
        b=ksXxCcxnAwRRiG984k06DM6bF9QepiBuKfQhxYs86dvHvatZIv5ovy162/k86wrWQ3
         fVmZ5+L4WsmUMV4f5obBcNRkj1GmSzUq1vwQk8bDsMeNuf97RdxkeHqcajDx/QPbqUrp
         UQZ8935RvuQW2jQY4MvjBUTP83O6Iidkb9uvS8gdMTWGZe/iotEZG/F3YJ9mtPqvMocl
         70116gua5+hNBXEFmOVoXN9rCTnYkicdKZdYk9gamsB5v5fVAVBea6qQK5KC+USjEfpg
         vXecOqQd3xC+C0VxqZD5ZQD4AXZfaC/aVjq8vHGnscwizqaq4HpG2GNNADI5uhTTHxXm
         dchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RHUkpCYBtC8f1kSrbyE8l06+fmWuae05jJfS+5AeM9M=;
        fh=j6xtS8ld1QFNg6wzMDJd+tqfou4NE3a2I84vRzEzgP4=;
        b=fic8OPqzXq4zubzrnG6bxOl8P3WhsyyNU/JeBpDAAzZWWD9RBUSZFf17B0UIR07QFo
         vy54DbJmceeXY0ZHcj9VDMGBs1RJNL2MQ64HeX2MtMwfwKe/JluMXtH5F7IG0rHlfiiO
         jz3DDC2ixzMx21nj6vX7gjcjFovsyjTAeFJFvA/VEDsYn9lCfg5jcUcS1I2lZbO6aFqi
         jS8dkHDXxM5WZELrXWJAnPLxRnTBpG9mpHuv6Hl7TJ30s5JRq/zelcfCTYWfAs4r+WxN
         bBTYKhhX1W3bVVwMfYcgo1v7GKDoNvAymI51asIpJDSNVsDTq7RR0b1norhMlW4LGnqH
         AlDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778271047; x=1778875847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHUkpCYBtC8f1kSrbyE8l06+fmWuae05jJfS+5AeM9M=;
        b=DilxkrhkAC0uzjjPyGt0+4VO4px4J2U/CkzkF2kqx27AeLOR08LHs5M3UWt2Kvvquo
         fMVYkhrJSw4aaKmdrPFCDeBTD2AHlTFEgj3YRXdyMqmCrQQfG7VgO/izsfsJ0ZymU7bb
         zJz4aDeqeyFHYcqlJDbqh9mdzu1gX/Ig/C6s3Ag51ph3iAEo07QUkIjSPcO0MZ/jL118
         wDyKByZuiGPjFI7X47aK5YlQUBYb1AbSNy0h/1vexTm3tXxZVG9nzk7sCCnrw3Bif39+
         pjedrbaWmIYZ/9st1s2dXfCj+9M+6KQ6eoxgjWIIJq0UHQo8gABcnLG241siBBnikFbe
         Asug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778271047; x=1778875847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RHUkpCYBtC8f1kSrbyE8l06+fmWuae05jJfS+5AeM9M=;
        b=PkucOg6Z0NKagjNPXXpHlzp09Drl8C0RNaKFRkDnsuB32OxV4zOwUSiNyk7lhipaRp
         HEUenqPtn8W0MdFswfY2JwVqNwBe2FK9swCebA/Da0d5bkIHN7if5N9K6AJxwkpNTATO
         8Mc3MuFka7isBRN1zt1howq4Zj5t16+ght6ilmlazujBxTtOmGe4h3YYNIoF903wBmTW
         P+wEgABtShddmqt42UAsGIQ/Z+HgqCYZX9uVb5PeiaYnfQJKAG7HYDjnclC01gTqR74M
         ueNFMCKmHH2HZPuDNgz78tsU61++0nYwYUATUIRzjLySV6UhDidHkPqlz80ULl4lgANi
         oGIw==
X-Forwarded-Encrypted: i=1; AFNElJ+2FtzO3RmZnZiPb1pJfIuX2vkbhnQla2WQNjngrUXBoHc998rXKsss+EQCZ2xU0mU7dTx84jruT1aHgLar@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJnF/QNKqjXXvKsx3gJSOFAQDO9y5oN6NUMUHRgbJHKLwbU7X
	VIlaMAq0LrXvuqfuj2MZbFRJr05EFaE9/CXRjjKbmhdY3xPJvJKgo521s0eRY9ZWqTccLZ95+wE
	zZ+ngHSj77dzaiVNtPQTy3VWQk1K5vELPn5pN99ac
X-Gm-Gg: Acq92OHP/AohCFlwYbHwReaIy+GHlE0WOK0rcE2Yxz4ztc7PQCAQby1cQrNFY0LYDo+
	eayoIzjQ1cBHdoe+wpYEzPA6TjBEvH6u/+mA7r/Oo0nfiRxvRLClR6BZQ8wo4wnktyLAI4/567T
	2Q0y2MsEz6tw6v2micYS1XAUsrRFJP1GDjm26niFyAmHdvSaDfs6kWy1phk0vMGojhxlruATsGp
	QtsWRWnNEjjgF7F4kWIMwvqI9zj2aSKy8PmY5rt+xPXlflzGc2Nnw49C7sWwxzQFqbGXWKgrsnq
	0b+Z932PkpFM9vptaA==
X-Received: by 2002:a17:90a:509:b0:366:3ac:f730 with SMTP id
 98e67ed59e1d1-36603ad3f55mr6058264a91.25.1778271046680; Fri, 08 May 2026
 13:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430000315.918964-1-song@kernel.org> <20260430000315.918964-2-song@kernel.org>
In-Reply-To: <20260430000315.918964-2-song@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 May 2026 16:10:34 -0400
X-Gm-Features: AVHnY4JzYJuAYc9q9BmVnJzCXV6FuyRu5-uJafEtOUSW60YQOAJP4PpQpgO2G2Y
Message-ID: <CAHC9VhT6YxJQqSkBbSeACFL6+AoL0031u2VT4fuRqPxDkGzSfw@mail.gmail.com>
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

On Wed, Apr 29, 2026 at 8:03=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Add six new LSM hooks for mount operations:
>
> - mount_bind(from, to, recurse): bind mount with pre-resolved
>   struct path for source and destination.
> - mount_new(fc, mp, mnt_flags, flags, data): new mount, called after
>   mount options are parsed. The flags and data parameters carry the
>   original mount(2) flags and data for LSMs that need them (AppArmor,
>   Tomoyo).
> - mount_remount(fc, mp, mnt_flags, flags, data): filesystem remount,
>   called after mount options are parsed into the fs_context.
> - mount_reconfigure(mp, mnt_flags, flags): mount flag reconfiguration
>   (MS_REMOUNT|MS_BIND path).
> - mount_move(from, to): move mount with pre-resolved paths.
> - mount_change_type(mp, ms_flags): propagation type changes.
>
> These replace the monolithic security_sb_mount() which conflates
> multiple distinct operations into a single hook, and suffers from
> TOCTOU issues where LSMs re-resolve string-based dev_name via
> kern_path().
>
> The mount_move hook is added alongside the existing move_mount hook.
> During the transition, LSMs register for both hooks. The move_mount
> hook will be removed once all LSMs have been converted.
>
> Some LSMs, such as apparmor and tomoyo, audit the original input passed
> in the mount syscall. To keep the same behavior, argument data and flags
> are passed in do_* functions. These can be removed if these LSMs no
> longer need these information.
>
> All new hooks are registered as sleepable BPF LSM hooks.
>
> Code generated with the assistance of Claude, reviewed by human.
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selinux=
 only
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/namespace.c                |  35 ++++++++++--
>  include/linux/lsm_hook_defs.h |  12 ++++
>  include/linux/security.h      |  50 +++++++++++++++++
>  kernel/bpf/bpf_lsm.c          |   7 +++
>  security/security.c           | 101 ++++++++++++++++++++++++++++++++++
>  5 files changed, 199 insertions(+), 6 deletions(-)

...

> @@ -3708,6 +3724,10 @@ static int do_move_mount_old(const struct path *pa=
th, const char *old_name)
>         if (err)
>                 return err;
>
> +       err =3D security_mount_move(&old_path, path);
> +       if (err)
> +               return err;
> +
>         return do_move_mount(&old_path, path, 0);
>  }

While the security_sb_mount() hook calls into do_move_mount_old(), the
security_move_mount() hook calls into do_mount_mount().  As you remove
both of these LSM hooks in patch 7/7, should we consider moving the
new security_mount_move() into do_move_mount()?  If not, how do we
ensure that we don't lose coverage when removing the
security_move_mount() hook, or can you explain why it is not needed?

--=20
paul-moore.com
