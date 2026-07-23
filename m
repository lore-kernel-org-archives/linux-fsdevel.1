Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E33B7B64
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830795; cv=none; b=JFAyFDhgtAe80HLmDS/lhlSm+6Rmm9E6zAJ62KyCClNje7KwkaZ8cq/K7xEfNjNaQieWDAOH+Zdu+Vhn8kf77nURUZadpAT6adrTN5oTLaCQvZRs6EqQCjzLkpuiPUGd4QTDz5gyvfKR6GKv7sqafajV1nCbwXPLyvahAZKN/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830795; c=relaxed/simple;
	bh=pI7/WtZOHzSScov8+QbTEhBJxeSAlAowONsIBY+cVFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJXo0fuSLTYDprVuTZppctUD9yHMMgRTdasY1zDcKqgUFz1fa9l7atUTu5VKyGzzXOLLrbWbWSSxZ8r6r/Bml5EArEheOMrR+CyYDQp1jCo5ltLaWE4FtBEUE3OoVMjcSDOTOiCMOVzcL0GrnKfFYh82KJrdNwEygI12LZNVTzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIX+ISi+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIX+ISi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FA01F00A3A
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 18:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784830787;
	bh=230JIUQQh1B8eXgnA7apJW7i59Sy5/z4fOTfm/SVITY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FIX+ISi+p8m2LQGjwcY5IO97RryrbVBATylwHPO9/DiBjdg6lLiQZcKEoABhXwd9Z
	 G564zwbAleJdoGj1iPKN8OodQK/EbU5cGV983eLpJ8WciTNHTwNnFyddBZ077wJGOe
	 tLeX1HeLoMxbFRJOaLLGCc9vFII+Ax4JbzSvA3U+C4JXAz7Vw7+Mq5yYdrODYWqhFa
	 6/5sMVCrw2Pwh36lhHn+85Hb8Y1YFpvDCMaEK+L/voXnIj67PQbCr/UteWmGtR1KXD
	 Dv20aeUp4mX3TmFgVtKLiJSQsjxi0OX48wZvsAtn2ZHvyisxIihN8Dz5I49NA5Ij8W
	 Oe57jkjukf8eQ==
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ff88549786so11774206d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 11:19:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqvxHVe+7Cf0HRAE8z7BY00jL1QVBR0MqB55r2un7u0J+pUKMUwXn20fTVhgBv3i+z9diF14I5Qwcrt7E/Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgxvAVQUGS7uchXeBVSHoCKyBZ2mZ0hHW6V4Q0ADURZq6IEB4
	qU07nL8AKa/vajj7vCgAaT3qeuufr5ZmbCD8I+1d+OaTLjQcMwMI05dzY3OUlQJwa+G+Uiq5Pw9
	2YwzP1UTd12D08BTbxbQwr+yHpTx4xaw=
X-Received: by 2002:a05:620a:4606:b0:92e:c117:9eaf with SMTP id
 af79cd13be357-93103b4a81bmr439311085a.93.1784830781920; Thu, 23 Jul 2026
 11:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org>
In-Reply-To: <20260706235053.4104951-1-song@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 23 Jul 2026 11:19:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
X-Gm-Features: AUfX_mwQVJsDURmFHDnLlF8xG3as6jhlEKJ7pwuuU3MpfW-PPAUe3hPTNSoz2Bg
Message-ID: <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, brauner@kernel.org
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian and folks,

Could you please help review this set? Does this set address
concerns from earlier versions?

Thanks,
Song

On Mon, Jul 6, 2026 at 4:51=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> This series replaces the monolithic security_sb_mount() hook with
> per-operation mount hooks, addressing two main issues:
>
> 1. TOCTOU: security_sb_mount() receives dev_name as a string, which
>    LSMs like AppArmor and Tomoyo re-resolve via kern_path(). The new
>    hooks pass pre-resolved struct path pointers where possible (bind
>    mount, move mount), eliminating the double-resolution.
>
> 2. Conflation: security_sb_mount() handles bind, new mount, remount,
>    move, propagation changes, and mount reconfiguration through a
>    single hook, requiring LSMs to dispatch on flags internally. The
>    new hooks are called at the operation level with appropriate
>    context.
>
> The new hooks are:
>   mount_bind        - bind mount (pre-resolved source path)
>   mount_new         - new filesystem mount (with fs_context)
>   mount_remount     - filesystem remount (with fs_context)
>   mount_reconfigure - mount flag reconfiguration (MS_REMOUNT|MS_BIND)
>   mount_move        - move mount (pre-resolved paths)
>   mount_change_type - propagation type changes
