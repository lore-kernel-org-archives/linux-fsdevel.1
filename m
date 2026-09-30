Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E16A4F3EC2
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780904; cv=pass; b=k199DWgis3cSaoeAi2nPzIgt2HqFt/vElUgmNOZ6ieMdDdeJVRmLboH4Q7TSii55TsGdPB1XjLvA9OCmiFYKlbb75Z9F98kz4VPfm/x5tZABwTfwMzOQZXOsdvC/aVI4ieLV6Sl2dIUrlPTvtN4lrlDRZyHjXCsTfV4AIr01qDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780904; c=relaxed/simple;
	bh=hT6uKFtdqOcRXKAyppkXaaDZAfO63Yhh/JoACrj3WRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plStjQeOfv6V7Pzj5v0r1q0FQ0T4ZtqoetAjADmkeFn54F0Mz1Oij0iBtg+g0upS4PHMLuawoDh17Y8TyTD5IlpPDGvuzE1ErpLiG5YfiHKPdjfdH63gIL+eiQVbQV/j5ksB8cVSsrspu8J7eog/XvqeqqoE+9YfBCZpN8Sl5Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJlmgC4A; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJlmgC4A"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c294ad260fdso341556766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 08:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790780889; cv=none;
        d=google.com; s=arc-20260327;
        b=JRjtLIu92uG3zsUamgLrL9P8Ujv7Em/XAIabaruZHsPFJkbxL43FOEe9/2KB+vBJqI
         5wx5u48rdF4OMSjSmoZRpckG2TQ/89Jq2u7lr+gv7MOPfGKHvmTEZee07Ml2TuMhJG47
         y+Z4MEnZ6GgQjVXNDHT1UE7mTz0rG5lFtYaZBsMZikfbBxrA/x/yFOyr2U23PezJEgAh
         JiAq39MrTguoJnZWSfSGQAIULEemuYi+nabtUPP5PkGfg3xQV9x1SINIO3nhvKdNtDyi
         OyGdUHaRlfUINQI2hiBj33PItRJ/dB3k7eBzrjSf6a3pDeRaHZml9APiWWmLtq5rOv0R
         Y8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NaO1mAirnPnJy57tYk/9v6vRmGk3M0eQnaIUpib3e7I=;
        fh=hsW5S6NwNW/W0v2j6yvzArIGocXyH0sJA5JGYSkF4gk=;
        b=WuXBjX8dzXrE/JoPLXKsA/0E6j/XN8rDbFwEa7tXF/CZBf+YoWMZaSpglmo7x1F64z
         iosIYajM0Lk//osTwSlcxJ+NfyMXUxZd8S9dQCmoLE0cv3NqMSWiUqBIm6PPFRzE2zE8
         FL47Xurvb/nME9oL11KN0wfWi8pepBmkt+KA4SH/H/5u3o+1rJIOoGb9VnGGXEpOwhOM
         Awlr+YEdyiU7fcipZx2115tptOLuCAFaspVPIcdciwybTRBMkhcpq/jJpf0UYalFthk7
         zsIQU27dgZDTA9QnlA3joqPnl5yR4T4L7LlBwA+2oH7GpKi44f2YSKRIlEvSKUMQmYqx
         c7Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780889; x=1791385689; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NaO1mAirnPnJy57tYk/9v6vRmGk3M0eQnaIUpib3e7I=;
        b=iJlmgC4Az06kmQAbbfD9zbPJsV9/ylzCsEQbvsJ+MV/8PIGfPayTaXW9kb5f/Cuuhj
         OapNpxXGKNN8j0TVKGWz9pUZ9a/ykvwHM0Xhp/eUCDxmg1lENLal5MakTWShYfY1qqC9
         hheETli6dYI9nX7Q5+/vL885hOk4VnPYxwQXENBb6h0LiSl05+3TOOO5mtCqn3YUu7hJ
         BGoH1+SDzsktVDBoNzAkZtg+3jltOvrm+SpWuD3ec7b1HODqB5zQPML+TWOm4aFBWCWZ
         7GU9zjOwFGOfJDhiH3BRJq7VaDK9Ubfen/30XVS+O21N/Wp//+Iq87oduyO0KdZ8wnS9
         kKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780889; x=1791385689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NaO1mAirnPnJy57tYk/9v6vRmGk3M0eQnaIUpib3e7I=;
        b=HoqbEqgKlaUf9Aq1mJu94sL87heyMcM/vojmO/chMy5M8ZeWSvKoluNij+QfCKNp6N
         A5zpS33u2w1DO+DdKXB/bQtz3MSTUtxFcvjRJwQCfPdnhGQbXMpFPDrWyrOEo0Gd3rX3
         XOUYMs4mwDJIxsBobgN17RBAx2udF3sCktPiVi0rbwAMNZqQK1zrVE0vCid02gnVFHh8
         nnW8Ody6vWWdcJo3QbL4Pled7JufaqcyYs1gC9SH+VO0wlGHI+fN10mpjA8K4hhpEuCW
         toazAYAEV7DSh0NwCyoBdoEONrGnf9GBdeb+mAkhL9YX8Z3WrUxMrhbh9R3V/K9mBhmS
         MlsQ==
X-Gm-Message-State: AFuF++mA+egwn4kThstzpkCKWzY8hFRhxXiSVMhTIRUCLUrT8a2dBHCp
	vQXhWp1Ppr0TqdhcWlGeLKtCg9J8IKoAmmWUv9r8Ho+XC1ahCiHWK49oMHMJnQGKi3484EL3JCH
	yCONQhfK30z+l7ABrsGJHM8gQzRhOOsk=
X-Gm-Gg: AYBFou0HtdOKzTdhktKSZYpWqvnRsRt7uixGLb9v/YTm5YrqYxlGk/hISX2rG96nWsQ
	ZxSDR7GFAvNhnEsCU9x51gdv3NiMeVK/AKXasnIYf4/ojDUyLnJafNK9RsbQVcwBa9rUbcak/en
	72K47tJZ4mj/gJaqeAlf9rBR166iWV/mDwv8Q28bB1XNMVrW/ofZdeIzYXmLSKL1sHc00pW0BVr
	WHOpax8s3XpVQeAtu7vCrS9+/EitCYfn2nwaY5CA6kGpWlJydqtm/2icVWyUhicjK8N1wRLjNQ/
	fJMMXiUKXLxO4J6cTYXE63WZ4iitJLUEzb/f2AjTvmrC2PWSJLQ80Kve
X-Received: by 2002:a17:907:3e1a:b0:c2e:2275:1168 with SMTP id
 a640c23a62f3a-c2e23d9558amr152172866b.19.1790780889315; Wed, 30 Sep 2026
 08:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org> <20260930-work-mount-fixes-3-v1-13-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-13-be34c83956ae@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 30 Sep 2026 17:07:56 +0200
X-Gm-Features: AclHuK9qZXCPpQtL11D39UCo-F3cSnL8zEaPtult057jKkP0CoRv6AK3ktwziVg
Message-ID: <CAOQ4uxgJq_UsqfAxJGtnyeyyoB=2XD=UTXp1Lgr-Ze+XNKPVEw@mail.gmail.com>
Subject: Re: [PATCH 13/17] namespace: remove the fsnotify marks of a mount
 namespace in process context
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <mason@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:32=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> mnt_ns_release() drops the last passive reference of a mount namespace
> and removes its fanotify marks via fsnotify_mntns_delete(). That takes
> the mutex of every group with a mark on the namespace and the spinlock
> of the connector. Fine from process context. But mnt_ns_tree_remove()
> hands the reference the namespace was allocated with to call_rcu() and
> so the marks are removed from the RCU softirq:
>
>   BUG: sleeping function called from invalid context at kernel/locking/mu=
tex.c:623
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper=
/3
>    __mutex_lock+0x113/0x24b0
>    fsnotify_destroy_marks+0x11b/0x3d0
>    mnt_ns_release_rcu+0x57/0xa0
>    rcu_core+0x6b6/0x1e40
>
> and lockdep complains about the connector lock being taken from softirq
> context. A fanotify group with a FAN_MARK_MNTNS mark on the mount
> namespace of another task is all that's needed. Root in a user
> namespace can do that for a mount namespace it owns. The task exits and
> the namespace is freed with the mark still on it.
>
> Remove the marks in free_mnt_ns() before the namespace is handed to RCU.
> That runs in process context once the last active reference is gone. A
> mark is added through a file descriptor to the namespace which holds an
> active reference so no mark can show up after that.
>
> Fixes: bf630c401641 ("vfs: add notifications for mount attach and detach"=
)
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 0a7d50db228d..3c90d853e091 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -130,7 +130,6 @@ static void mnt_ns_release(struct mnt_namespace *ns)
>  {
>         /* keep alive for {list,stat}mount() */
>         if (ns && refcount_dec_and_test(&ns->passive)) {
> -               fsnotify_mntns_delete(ns);
>                 put_user_ns(ns->user_ns);
>                 kfree(ns);
>         }
> @@ -4279,6 +4278,8 @@ static void free_mnt_ns(struct mnt_namespace *ns)
>         if (!is_anon_ns(ns))
>                 ns_common_free(ns);
>         dec_mnt_namespaces(ns->ucounts);
> +       /* the last active reference is gone, no mark can show up anymore=
 */
> +       fsnotify_mntns_delete(ns);
>         mnt_ns_tree_remove(ns);
>  }
>

The question should be not if new marks can show up, but whether new
fsnotify_mnt_ events can show up.

I think the patch is still correct, but maybe change this comment or remove=
 it.

Otherwise, feel free to add

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
