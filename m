Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877C037E2FA
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529182; cv=none; b=hQBuLotZsVhxvAzpI+7+6Qqbyx7BdeN5mtS5yquh+UObetI55qLxShHCzJmo7QdrQ8KmlfKJViuHTvCpHuc9NMGCBuQUT1P0HMNgQesWV7hPKxiAHzJ+RiV1Qd8BViLzq1Y3LLZcoGdN4cV0jA2HBnlXut+s28wj+L15Mgiuuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529182; c=relaxed/simple;
	bh=0WCJDrovG+9Ixg/ZDeUHkV8CFYfHBfClr3tW4/3vGfk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=rkmY5HffPFmT5o4GcwzWg38wlMOt0762+FDKokOR2Xrp1+OGH+fwhCjBmjiQ7zTLN+29auXdZY69m6KAVnC9foDEDJO4VY9f3aCgTJkoeRQvHvVeWAnJzsJ5o1CB4FF5lfBNee6fsaGNwg5lOJdC3eI//3JtGj3CWz3EzSek6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dgfw5eky; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dgfw5eky"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8ef2118b478so484136885a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778529180; x=1779133980; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOo8mqYuky3aS2A2U/I/xcFROUzPmcuioh4GJDlL7KI=;
        b=dgfw5eky/vNSYe7KOPr0mC/55FldRPmK6JpEUGd04ANvzHrZ3Oq9jyDs8GRC1v82WJ
         bgqFWZwHhQSZiIJvz6D3M5PYY5kULi0uZgu1XK0AckylhVRSL9v4RYU0XLr6tOWhNGAx
         RA/DjGOxaBYVWlodjur0Rk/Zovo/XXYHCkLburqQrDmBR8sj1XQJ2FKzLg8UUi9YUm8m
         z0e9ttjsVe2Z8vM4bgmjSIjs1Rmrto+LX1ODdwGKGTgdcYrIXgQUGLq2y/uyQSlOgrWS
         JcbbsB4Imt4+hemmAspE8biI/nEuPnDRMqi2DoxtnI3VW52Z7jw270TxkoUOlrneZliZ
         4uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529180; x=1779133980;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOo8mqYuky3aS2A2U/I/xcFROUzPmcuioh4GJDlL7KI=;
        b=QY88nAhSxO5C5kv8+pZJoSMWPzX0Ov9rFknQVlkj1WSBaCswuVUGfpFqVT1hHPxZQ5
         K1B1sKW83fUzabERwc6qPMiVkFwg9eAIb9GqcA24u8a6VKh6bCHvPyyPy98Iluh6tpmi
         3ebalvhRiSn7eHfHFdKmXGIjEBqD5dEfUZKiy6VPQP/84fd+fxdPABzGvBcbVMKgUNhc
         wAiZn7h+8nj+deVimqAEWsZjn49XBByEfWR4XnJljmDiK7F1nJxpSkskWumTenI0fsoV
         V0Inp+pXxzaHTvCwFfWB9nt36Ypv7VfNMWBS3iiMwNlUSBmJf3Fl3gAkCSdZrC5xrQAA
         Y26w==
X-Forwarded-Encrypted: i=1; AFNElJ8WLjSnaLnM6N6g+GJV2DahzWF1LSCVLVqlQfPqTU+TbjNZjR7DM9koozK0WZTUsa7MaNjFXZB+aGXDbC3f@vger.kernel.org
X-Gm-Message-State: AOJu0YxIfzanRKoWFLn5ZiB9ZMB2EIxUElrYeHkhuIavzrIKVhUnxyOS
	uNx8yKhO5dq96tn/AhQIw3vxd/HgIDpX2TqdGcxrK9Qk4RJ6sNMY0DsgFYZJ1agvoQ==
X-Gm-Gg: Acq92OHT/XaGIwleEOjMBKWcorxqHfeUN3RB7W/HPWHg9SnhkUKuETmOkvy6kTnlU4l
	s8MUeFNtB2qTBG3ez/rUIFLQxotytL0TfzZOm1VxjRmV40/1sPUz0zOYt6hb4laGXiIN/U1iKyC
	MEHHPTZbWw3QTFHyTRcDTLEE4dRknP2uW44SgOmMK2eXl1aytQ4XZJHErAXgeBxA+Ml/4tHeZ2P
	0qq0GdqwbL9mqpocR+K/9M5guaEuRVrzOi4n9z79ZYW5JyHzuNw4MlrbBX6Bnig5afQ7JV0PeZV
	a9C7W9Ygj+cE0l+DJ6puZdMkHodGsX8iEKtY5zb9TmRJz9lwVxDF44O9IR/qkBjaaU/NFDKlvC3
	O9INDmHKBADlSoW/aI9+lAo89E3zfio1qSXqP9rUuBvhx82gHJNO9+Pd6B+L7gN9jqKqDmsX78/
	d2v1ziue7XT4bHwwgmlVbEM/eXDcCi4HFjfD/kkiPVFLM3n4yu9T3pt6rLe4L8Fka2R5xp
X-Received: by 2002:a05:620a:698c:b0:8d9:3cb9:9905 with SMTP id af79cd13be357-904d6fcb765mr3693957985a.54.1778529180332;
        Mon, 11 May 2026 12:53:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b918cffesm1179663385a.14.2026.05.11.12.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:52:56 -0700 (PDT)
Date: Mon, 11 May 2026 15:52:56 -0400
Message-ID: <37ceb04c4c37370a2359f73a24b9c07b@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260511_1539/pstg-lib:20260511_1103/pstg-pwork:20260511_1539
From: Paul Moore <paul@paul-moore.com>
To: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, john.johansen@canonical.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@I-love.SAKURA.ne.jp, herton@canonical.com, kernel-team@meta.com, Song Liu <song@kernel.org>
Subject: Re: [PATCH v3 7/7] lsm: Remove security_sb_mount and  security_move_mount
References: <20260509015208.3853132-8-song@kernel.org>
In-Reply-To: <20260509015208.3853132-8-song@kernel.org>

On May  8, 2026 Song Liu <song@kernel.org> wrote:
> 
> Now that all LSMs have been converted to granular mount hooks,
> remove the old hooks:
> 
> - security_sb_mount(): removed from lsm_hook_defs.h, security.h,
>   security.c, and its call in path_mount().
> - security_move_mount(): removed and replaced by security_mount_move()
>   in do_move_mount(). All LSMs now use mount_move exclusively.
> 
> Code generated with the assistance of Claude, reviewed by human.
> 
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com> # for selinux only
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/namespace.c                |  8 --------
>  include/linux/lsm_hook_defs.h |  4 ----
>  include/linux/security.h      | 16 ---------------
>  kernel/bpf/bpf_lsm.c          |  2 --
>  security/apparmor/lsm.c       |  1 -
>  security/landlock/fs.c        |  1 -
>  security/security.c           | 38 -----------------------------------
>  security/selinux/hooks.c      |  2 --
>  8 files changed, 72 deletions(-)

...

> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index e0a8a44c95aa..b0de7f316f51 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1705,7 +1705,6 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(capget, apparmor_capget),
>  	LSM_HOOK_INIT(capable, apparmor_capable),
>  
> -	LSM_HOOK_INIT(move_mount, apparmor_move_mount),

This should be in patch 3/7 when you convert AppArmor over to the new
hooks.

>  	LSM_HOOK_INIT(mount_bind, apparmor_mount_bind),
>  	LSM_HOOK_INIT(mount_new, apparmor_mount_new),
>  	LSM_HOOK_INIT(mount_remount, apparmor_mount_remount),
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 4547e736e496..7377f22a165e 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1983,7 +1983,6 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(mount_reconfigure, hook_mount_reconfigure),
>  	LSM_HOOK_INIT(mount_change_type, hook_mount_change_type),
>  	LSM_HOOK_INIT(mount_move, hook_move_mount),
> -	LSM_HOOK_INIT(move_mount, hook_move_mount),

This should be in patch 5/7 when you convert Landlock.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 864a3ca772c9..c8de175bde04 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -7586,8 +7586,6 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(sb_set_mnt_opts, selinux_set_mnt_opts),
>  	LSM_HOOK_INIT(sb_clone_mnt_opts, selinux_sb_clone_mnt_opts),
>  
> -	LSM_HOOK_INIT(move_mount, selinux_move_mount),

This should be in patch 4/7 when you convert SELinux.

>  	LSM_HOOK_INIT(dentry_init_security, selinux_dentry_init_security),
>  	LSM_HOOK_INIT(dentry_create_files_as, selinux_dentry_create_files_as),
>  
> -- 
> 2.53.0-Meta

--
paul-moore.com
