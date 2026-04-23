Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA781E834B
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776903613; cv=pass; b=hpc5Jtt/8XFNv4TgfICbruwDySnBTxOWoQatoRfvy/bsCst5ULK41nkNE4WKfIEs3wcAfO8MeUDMRjVF2f4/0qsecfqpX5qpBGvfIOSPMeM4V6ILSXasO1G5wfiCYpA6nMP1Cc/qU16Vn8ui71oymUtexV20iouL+dtzRDksM3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776903613; c=relaxed/simple;
	bh=2MilzRt8cmnGQ2F/kJxBuopP9nkbS4u7gug4FqwM93k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvLBbX19LbX0x8xURumssYCuO4GC/8cUCxYqywAT2UAvG0fOuKwW8FtKn8k5r+FlyiRlp37aNcnWFu1ETefXfGkHvHox7HBMqJffWUeF9QHF7N6dlMM1Zq2bYuuJpUIQ0iIAAf/EPPqsv7GaXkdIbDtD4HxmPkLf/yUEi5OYZWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d3VEdHR6; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d3VEdHR6"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c7b9f54d3deso328067a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 17:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776903611; cv=none;
        d=google.com; s=arc-20240605;
        b=jvHNHOjdKJTEP3KRgHSUQcya0Rhed0fkCnDHiiw71RQO3RrnvpQMgeKgEp9e6l8I4F
         3LnTJoAJoI1dfbxkoK5EsEEbSYD8DgoP6JjCWnNIYgHlKNS5mkxEWJYcnztGKhtvS3D/
         7CBXynrf+jP2TwkjEHr8n8JsqL69wOt6DerrMvANKKee+7Cj9kH97B3zDzGDuFETq6jB
         1hSiKQTTmVfVFs7RjH3OkU2y3cE4FF2fe0fPXRvQ1dLVnhqWx0x8jNSDn+b9bQigY76o
         nhZH3V8UwUra9jGJ5rLYqn1iWkVAZgtg77m1ED78ImPMZecA67hFpVCbjPhTQlg/qiIX
         Q8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWnOdG2Qc8EhlLJvMnlzyDWOPt+Zq7olkDLmxANGXE8=;
        fh=LMVDFvLubNoH8Zd/SazFYv/G+uLqXcf0pmnIbtDpATg=;
        b=URVPxz7EjxRJvupGWXIqdU0AJ32O1fA/ZCbfgcxKdzeAlCQ2HUryNDOKPhnd+whzwQ
         cvYmlug9L1gMVfFApfar/lbyAUZi11rQEivdh0IRZFtGYE+dhZPFn3m0Xibre/vzbI8f
         0S2bC760y8LxH5hmlkxWosqp+AZeF3SGCGl9IDWCy4Bt9i7yOoGaLz7VKdjXI6m0dEka
         uHPe6aoAzBDFVuC3LF86Q3xKWlpzT2P+eOGNIXUR/9VCbrsVYTVyM0riDt0JUXOUxw5L
         YYu49YylHAgn34wSeYas/KDYPwHsCX2gSMj84uSA2Imi6MxtLMXLvkcn99+jhe5nFtRg
         +z1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776903611; x=1777508411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWnOdG2Qc8EhlLJvMnlzyDWOPt+Zq7olkDLmxANGXE8=;
        b=d3VEdHR6RyGpsB9+8Jz3IPyIkUzdxKU18XKE91Y4PnVvVO8C9sLg0KJGmVYPI1Z2/s
         0/N3sptOMmr9bziQT0VAVdZ4hcwDylqnzph1SWEgx3j4K3JgxvFe5Ixvss/oC4lpAo0y
         PiUhLDz8gwzIUIYFrRLf7iAFXbofTefZecbmRuz8dIT73SoJvXnZ7RygNwi7u4vy4B4z
         fDIV0bGcErZFTBixpKfx6i1GHMX92noCPyCHgXoXYD96+cKs/5U+h+DZk/qixpBJbB0O
         BHL2UugxELqy3UiPUAQlaftCNErsbAK4dzHa/8a9PYhKOeyQkhUk03l7KxSjxQ2I4LgY
         Yaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776903611; x=1777508411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWnOdG2Qc8EhlLJvMnlzyDWOPt+Zq7olkDLmxANGXE8=;
        b=mEnUKwc71bPWsoZInks0fRgOaLJ6zIU6HKv4C3lw4XxZgvdGWjUjW54+8CGa7+LXJe
         klXLlnqNLqs6l9VqOzOeeMuG5uHXgNO1VFYF++6a0F3asttWIqbD+jdPyKKVyI6jdwvO
         rQOhCAURlEgY1YJ7hs8lGiGi2dGON/2KxRroEYDoaq7wd7nh9RyQwHAfFl+LFZ7IDzQF
         HTfdpIkrnvVgk/y48dxSQ6cqfv4fprB532yvAmiyHynk5y223oJJN7g5ywDlg8TDpq/z
         PKw7DaS0R4XGhL2AjPjPKzcyni7/ybl057rr5tFqZtXo35L/CjQGJDeFo60CI1X7OOEz
         JIrA==
X-Forwarded-Encrypted: i=1; AFNElJ+8+u+U2zXK7gQrZM8v8gPq/WMR6MdtObrJw5VnMeNowPdTqeBUQhR7R9CjJ62XFETsKKfiIGUFNqHkgtEy@vger.kernel.org
X-Gm-Message-State: AOJu0YxemcvjrxOJ7UQELB613UFOXhIdmdZml4uC3uhHanMuTn7g676G
	akqlgLJMuCoU6MDTO27jHtIhOmigwmuuP2ciFVQxCWM27qvsHVrguUrbh81wggbO7RVxkKiAPYK
	trou6Y0n/fuhdelQjTaxaTzauW4OEVB2BOoALvFRe
X-Gm-Gg: AeBDiesKJvHBlv8TpYzvA1ttnG9xv/QjkmgfEPiPMMrTikkwWgTyz632v4seErDuUx7
	ZQoF/mCByPWWnhEjec6fuLh1x/R1XcF6Larvki+hAsurTwrZ5UxjxBFhqURw3Y3e6QTkCnjDQm0
	t5n+E6fQjX+KZX/t/EbUicWIogHr7g3Z6gRQq1jC8sa+dgiPmuhkauYQSamY9Jp0AG8V7PMnXH1
	l9sATP+MUQ1RVYwf9ozTtcF6n37+Kq9dTEomzuAcrA6R5rq4pv2Y/SuFDo+ddLcIhYXcmIVcqPT
	syl056I+LEQ9ZgLmog==
X-Received: by 2002:a05:6a21:6da1:b0:3a2:c685:f9b0 with SMTP id
 adf61e73a8af0-3a2c6860b22mr18691201637.49.1776903611025; Wed, 22 Apr 2026
 17:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312100444.2609563-1-mic@digikod.net> <20260312100444.2609563-2-mic@digikod.net>
In-Reply-To: <20260312100444.2609563-2-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Apr 2026 20:19:59 -0400
X-Gm-Features: AQROBzA-RiP1h7rMGgAyQ5vVHw1O5KoNpY2Zr4y9YGn7VDWJmeZCA985VQDaF6Y
Message-ID: <CAHC9VhT4Cd-FMYhaKgt6Gv-Suu7YJm7YbKZ-vdMwQV7EiWDryA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/11] security: add LSM blob and hooks for namespaces
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 6:05=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> All namespace types now share the same ns_common infrastructure. Extend
> this to include a security blob so LSMs can start managing namespaces
> uniformly without having to add one-off hooks or security fields to
> every individual namespace type.
>
> Add a ns_security pointer to ns_common and the corresponding lbs_ns
> blob size to lsm_blob_sizes. Allocation and freeing hooks are called
> from the common __ns_common_init() and __ns_common_free() paths so
> every namespace type gets covered in one go. All information about the
> namespace type and the appropriate casting helpers to get at the
> containing namespace are available via ns_common making it
> straightforward for LSMs to differentiate when they need to.
>
> A namespace_install hook is called from validate_ns() during setns(2)
> giving LSMs a chance to enforce policy on namespace transitions.
>
> Individual namespace types can still have their own specialized security
> hooks when needed. This is just the common baseline that makes it easy
> to track and manage namespaces from the security side without requiring
> every namespace type to reinvent the wheel.
>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Link: https://lore.kernel.org/r/20260216-work-security-namespace-v1-1-075=
c28758e1f@kernel.org
> ---
>  include/linux/lsm_hook_defs.h      |  3 ++
>  include/linux/lsm_hooks.h          |  1 +
>  include/linux/ns/ns_common_types.h |  3 ++
>  include/linux/security.h           | 20 ++++++++
>  kernel/nscommon.c                  | 12 +++++
>  kernel/nsproxy.c                   |  8 +++-
>  security/lsm_init.c                |  2 +
>  security/security.c                | 76 ++++++++++++++++++++++++++++++
>  8 files changed, 124 insertions(+), 1 deletion(-)

...

> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index bdc3c86231d3..de774e374f9d 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -77,6 +81,13 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type=
, const struct proc_ns_ope
>                 ret =3D proc_alloc_inum(&ns->inum);
>         if (ret)
>                 return ret;
> +
> +       ret =3D security_namespace_alloc(ns);
> +       if (ret) {
> +               proc_free_inum(ns->inum);
> +               return ret;
> +       }

Since this is an RFC, I'll make the nitpicky comment that it would be
better if the LSM hook is called security_namespace_init() instead of
security_namespace_alloc().  This fits better with the convention of
aligning with the caller's name, as well as to helps to indicate that
the LSMs will be initializing the LSM state associated with the
ns_common instance.

> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index 259c4b4f1eeb..f0b30d1907e7 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -379,7 +379,13 @@ static int prepare_nsset(unsigned flags, struct nsse=
t *nsset)
>
>  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
>  {
> -       return ns->ops->install(nsset, ns);
> +       int ret;
> +
> +       ret =3D ns->ops->install(nsset, ns);
> +       if (ret)
> +               return ret;
> +
> +       return security_namespace_install(nsset, ns);
>  }

Do we also want a security_namespace_switch() called from within
switch_task_namespaces()?  Of course LSMs would not be able to fail or
return an error at that point, but it seems reasonable that LSMs might
want to update LSM state associated with the current task once the
namespaces have been changed.  This is similar to all the "_post_" LSM
hooks we have for various operations in the VFS and network layers.

I think we would want to pass both the task_struct and whichever
nsproxy instance is not stored in the task_struct to the hook.  I
prefer placing the hook after the task_struct has been updated, but if
anyone feels strongly that it should be the other way that's okay with
me.

> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..dcf073cac848 100644
> --- a/security/security.c
> +++ b/security/security.c
> +/**
> + * security_namespace_free() - Release LSM security data from a namespac=
e
> + * @ns: the namespace being freed
> + *
> + * Release security data attached to the namespace. Called before the
> + * namespace structure is freed.
> + *
> + * Note: The namespace may be freed via kfree_rcu(). LSMs must use
> + * RCU-safe freeing for any data that might be accessed by concurrent
> + * RCU readers.
> + */
> +void security_namespace_free(struct ns_common *ns)
> +{
> +       if (!ns->ns_security)
> +               return;
> +
> +       call_void_hook(namespace_free, ns);
> +
> +       kfree(ns->ns_security);
> +       ns->ns_security =3D NULL;
> +}

The "namespace may be freed via kfree_rcu()" comment in conjunction
with the standard kfree() in the function above raises a red flag.  Do
we need to take an approach similar to
security_inode_free()/inode_free_by_rcu() here?

--=20
paul-moore.com
