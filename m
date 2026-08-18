Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A2476680
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058913; cv=pass; b=heng79dlp0GsQ+jB9uCgvjYnSZSj32i1m9/KbLDQWnaMKYe3YjqVPTCPCec9XOWRWNopYJRysoToDwZq0qp8PUGCBmOxJboSWXV0yfgsUMwP+e4eiTsDFyExIcTiOHtXUBdGLZjjWIkJGur+5qUVO5TFNRyFnRwDCZWWy0t8Puw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058913; c=relaxed/simple;
	bh=KmOPgecutUsmjwBlgKM8KuaPjy+z2DOw9/Sj82TrOBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVBjwav5lghAIdVu0wm3puM+PaENHAtDyBTefvii53EZhnnxiqSvo1mRItVqW2cVdD27jLLpdInhLFUk9mRjrqAtM3icd0wc341EnNxIXhjfrD2u4KDfW9BmzW8gxHGQhCw9DotBEpN7sVjarSAVlJHC36pwUBubq4ax5oHia5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=R7WpH7XQ; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="R7WpH7XQ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e6a434cabso222894485a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 06:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787058910; cv=none;
        d=google.com; s=arc-20260327;
        b=hmpsrzTR+aiY7If7+YO9+3K2vOaQfQq3PR12/wCbt2dmsrBc1vYvkXyPK4Ez/AAJXn
         DNd64tGlyiVtHE4sZrC7X1p7KGDLV87rklvCEfOQRm2DNEGOc//Pk3phSC9cUMbQNBJE
         4MYovvPQj3VSLXpql4gBzs5D7OWnZ3qXuc4U3YmDcYB0W3kICL8RVCmgKokQA2hk8y6w
         e49gOROpkQchw+KNdRwiDVNEewPonT5bQFuc+LmrEv0hn9gL4yiNgU7AaFgGFKQSC6j8
         wmO/gxA/3Iy1U9vHxPes+DIW3VTT5WAKf9N1m9VDHs5fh4IXPfmY7FfuNDRuwZ7lt9aC
         RZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jxh5XpAHdieXwLPBDP0ROoYTT/Q1CVkQ5V4OzfSiXHI=;
        fh=h35f7xRbaiB63mwm79PLf/J8XGg5O8M2XlKPmkgllv4=;
        b=PSn6hF3Un+1O6QeGgn/1/rSUyL7Zu7nzPo1ClJ5XoGaQQQX5GYuZuBqWAxo657OYdE
         2a5qre7TIZrsLwMzhhIsiObgQtR5lYPEOJcT55LwZ6iSp88WcMymTzztRgYsZk6bdBrP
         H0cH0aRUX91CrCku9Ghzg13xoyxkjWYZYfvYhQWbxROhOpLQy/3facLfOAz1xkazwEEi
         pi+rjiXU61vE6Ve56ri0d19/lzI1wkW5m1P4k8AFrcJDlap4wdXFp9gGIc0o5oBEpu3a
         r0tYHydHb7kQWPVvmOja/eMWQWX8bbFyMs8mfb24Q/bgu492De77VD5Ob39pitq6FC4E
         74IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787058910; x=1787663710; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxh5XpAHdieXwLPBDP0ROoYTT/Q1CVkQ5V4OzfSiXHI=;
        b=R7WpH7XQU+s1dPr0CcPCikdC0N2EQs40h248ps8kh/hFM5N9xQ/hD2TfPWcl9xaOqz
         PWrcFWccreowAZlgmWR+EvyZYndrZ96uTCaa8V4GzKuPrf6C7X8+VoTjCI4/WSAJ65KD
         4AOjAy8XRa03bEX8khTR8J67UGihvM+9P8HEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787058910; x=1787663710;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jxh5XpAHdieXwLPBDP0ROoYTT/Q1CVkQ5V4OzfSiXHI=;
        b=lU+ko/fL67MUlyYGf4JWiKH603I9fXdcTIn9qKAhpsoPD+0qBpZRB47M1zVJMAH6WS
         lXkeoTq6kTcU8n8MQQq1Qe6MbTx1P8RnvB7w+ndGoXQUCWvjTKfVHeSSnegjmAN1faOJ
         fYs5OKIEugbe1So2NTcSr8NBqeCOofTmQhb+CEyiZkYMQF7FEmAg9hCArbSYpzvOtfpi
         3EP2hJsZyUO7LdJU3CkSWgusM4bpk3Q8uXnvC1tw5FtNNr7crg2CL6NWExaTNQmLxS70
         Z51qGluYs2POOLSiVZt8VotC4LkeE614dGRvCzdkpYE7ktsR/JSKIryvwKCPymfCJxNj
         0LHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpu69J5aTimx5vmo/6+8X/NAbCAHFSeqRvTNh8jpb5usYXMlj3rL1IOmwY5sQtJsShxrK06WgzWxH4Wf4SW@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRJIQ1HBy3Ppn7R/ghV76UT6cLzPv63UVqgImat10RNbw7Sad
	vZXOa/C4eRg96Z4qngPtmeodoZKHmBdvBZ1g/1ZdppfjRETaDWXsMNNE6HCLAA/2qon4mYn5ipK
	1yUPCXv7imbHm/EEyPqXJcvdzHR54KTrGdkY4aKRJ3w==
X-Gm-Gg: AR+sD13hPTiQAY9TlP5tNSoHVgywc3a3W/dCpE0x1lCHZ1gKbjiw/iK/eVJm8vpQ9Cp
	TfT8/e3sq0teYFI6kQCOXTt/tt8ih4eQ/Izzm5KUCwXdIpkeKS8yf1cZLhRCax8Vp6sLx2Gqiov
	dpymyc2byBU1lGVd5AXz2FnL0M2ysyEsShE7oXvH8HxzLBQRG5m2mob6TubU678y98m+Wh9AJmi
	4uOzr6Lfw9qROT3avH9Tw2KQ9cf+nI+mfsJzLQCfBKjiYFkhhGO9Zu49LC4s7HC2FNWGFssYxMs
	ad62qhR39cSb2WpEASh5sC/u/5nurjr/DVfwXbioaQkS1vdFdJUwwMwrHEBoqApFtL6UDjhcM2m
	L
X-Received: by 2002:a05:620a:404c:b0:936:e3c3:8cb8 with SMTP id
 af79cd13be357-936e3c38cc9mr2458814485a.45.1787058910323; Tue, 18 Aug 2026
 06:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-work-fill_super-warn-v1-0-4e987911a39a@kernel.org> <20260802-work-fill_super-warn-v1-1-4e987911a39a@kernel.org>
In-Reply-To: <20260802-work-fill_super-warn-v1-1-4e987911a39a@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 15:14:59 +0200
X-Gm-Features: AcwNN1UBQAWcx1tOEiU47Frr3JyAbsHxepEKWSi_zYBw_ITdoj7CtNDGWqz3aiE
Message-ID: <CAJfpegtXbdpFZmV2dYSbp6eL0DBGmZin98TFr42nxJCfuryfrw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ovl: don't warn when the mount is completed from
 another user namespace
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Laurent Vivier <laurent@vivier.eu>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Aug 2026 at 20:00, Christian Brauner <brauner@kernel.org> wrote:
>
> fsopen() records the caller's user namespace in fc->user_ns and hands
> back an ordinary file descriptor. Nothing ties the task that calls
> fsconfig(FSCONFIG_CMD_CREATE) to the task that created the context. The
> fd is inherited across fork() and exec() and it can be passed over a
> unix socket.
>
> Completing a context from another user namespace is allowed on purpose.
> vfs_cmd_create() authorizes the create with mount_capable(), which for
> FS_USERNS_MOUNT checks ns_capable(fc->user_ns, CAP_SYS_ADMIN), and that
> succeeds for a task holding CAP_SYS_ADMIN in an ancestor of fc->user_ns.
> So an unprivileged task can reach the WARN_ON() in ovl_fill_super():
> create a user and a mount namespace in a child, call fsopen("overlay")
> there, send the fscontext fd to the parent and let the parent issue
> FSCONFIG_CMD_CREATE. Both namespaces come from a plain unshare(1) and no
> capability is needed anywhere:
>
>   WARNING: fs/overlayfs/super.c:1551 at ovl_fill_super+0x7b9/0x1e20 [overlay]
>   CPU: 3 UID: 1000 PID: 3243376 Comm: fswarn
>   Call Trace:
>    get_tree_nodev+0x71/0xa0
>    ovl_get_tree+0x15/0x20 [overlay]
>    vfs_get_tree+0x2a/0x100
>    vfs_cmd_create+0x60/0xf0
>    __do_sys_fsconfig+0x4b2/0x500
>
> The child needs the mount namespace because fsopen() itself gates on
> may_mount(), which asks for CAP_SYS_ADMIN in the user namespace owning
> the caller's mount namespace. fsconfig() doesn't repeat that check.
>
> It is a WARN_ON() and not a WARN_ON_ONCE(), so the condition can be
> raised in a loop to taint the kernel and flood the log, and it panics a
> kernel booted with panic_on_warn.
>
> Keep refusing the mount and stop warning about it. ovl_parse_param()
> already spells a user namespace check this way for Opt_override_creds.
>
> Fixes: 1784fbc2ed9c ("ovl: port to new mount api")
> Cc: stable@vger.kernel.org # v6.5+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/overlayfs/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 60f0b7ceef0a..60b808b85fc4 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1544,7 +1544,8 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
>         int err;
>
>         err = -EIO;
> -       if (WARN_ON(fc->user_ns != current_user_ns()))
> +       /* The fscontext fd may have been passed to another user namespace. */
> +       if (fc->user_ns != current_user_ns())
>                 goto out_err;

Just one comment on this (I know it's been merged, will do a fixup
patch):  EIO should be turned into EINVAL.

The EIO was used to signal an internal error (commit 9efb069de4ba
("ovl: add warning on user_ns mismatch")) , which is no longer the
case.

Thanks,
Miklos
