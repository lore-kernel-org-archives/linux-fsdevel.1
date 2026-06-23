Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFBD3D7D64
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228387; cv=pass; b=lSjBskMaUXoBHOFZSku2hT6eMmRQ5rFOa+5meiG22MS61ZMvNzUBG+nmSy77IIzVhtQSiFDkt5/y3HRQ0ejxGPgkGS1RNHRP2GyQjNMw3WzYRJfMnMPV9chEdlInfKu6VIMZ0JyMU45VOZS7PBdmbjcbHvQ8nxgRT7Fu0X7RGzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228387; c=relaxed/simple;
	bh=YbRh6514ZU2RL6NtnUKsdEeupviuG3XLTy064lm8j7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shEyqP6pD6+KRPsKrv3x27GTeM/b7vsmcjbJYIB/mPjo/oNq3OytkXJCDlnooWnGIDKPdxC5x/IJkZq/9z56srOEtqHajI8m0VAwe8xSOThVoTMT7dL2UwYY7OCTSFoCraazR26Pibw4HPhUhlh6oCUNDRDpG4rjEwJTQKHOPrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIC8KhNR; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIC8KhNR"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-697df404e32so1162226a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 08:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782228383; cv=none;
        d=google.com; s=arc-20240605;
        b=FMO0jZNV5Wfrcebm5Bu4LOkwM9CB/PT87z+zqlXepEVFQT2pYJ6vjDj7zEYbjeys4Q
         OLJKIGxKZPt9HwtczI+ZLXHIX6y/BKe12CUa4G4ClMTmO3HD1C7YnFSuT3ptX9S8vdP4
         90lvmMFbRLt80w76BunI6yiVZd4SN1aCtCpTkBlAZJSNYoeABhn8wM2yAYi9t9zSRmGO
         aJ3VyJwZyzCX5VTGz8R99/p8uGLD6U5zD3zxEHwFbYFnhG9DSLsL/H/M5BlFrU7al1bp
         NQ9h8rSxjvd2Moq8l2dzjUTwoe2l69y1cZBs/ii0vdvFckVfOLWZHHHVXDpDJ9FrGMqu
         YMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r/cZXqF8tr2DhWW1MyXGMQoZN3ZKgmdfxneLAbvm50Y=;
        fh=A97bGFvKixAQVNFZNeq0fXPdn4o/MyjoWlV0Oc//fwE=;
        b=bJbVA60W57BLD+ad/6d0BM5a6FlQwLKqosSZ+dLQjQKONx9elHY8azAdWAlTwnt6vp
         ialOKZtRt/MtfYioBoz/6feiIjOJyNEOhjfqYrxxJHWcAS/LEcXul2ZX8prPPM7/wtrf
         E3DCVkZTIzk5J83AFGrEii1v3trlzJ4JRu3p8lAig4fkMv+aw8fWj5Un8oM74OIgUO/8
         z7WOndHPOoYjinMaRUPaU21cRteq4fQVeMawmtNBBcfWyjyi/JokY1KIhJ4hUzx4gb6c
         0m6p3mQW3G+X5vkOpLdnF/x3FnN76I1CPB1jk+LH5gAYBDnx3xQYxU2VibOVjAtJCQ8N
         vUCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782228383; x=1782833183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/cZXqF8tr2DhWW1MyXGMQoZN3ZKgmdfxneLAbvm50Y=;
        b=jIC8KhNRJWeyVOXyowMQyyv0sGI4eZsMG0SioOIkbDqcYAAS7YMOKbF+F/BrVVJy6A
         R8gEfCrX9s6GrM/o8dYDCvfnP96TaRusFNBOoHYDTY0MaKGkM6M34rsWf5taVD+/tDeN
         5IBkR0ANibK1gQXtB1Yd3kX7niCaqkD8Qi/JjvFYb6fNQNbwxtYwtX9V0dl8O4FpLOy7
         JIixH4ZpwRvB3Bm8J4JDHYHyAOzm5lmG7VZOv4uiLX6SAjXwN05QV2RErB8VYb9H5qNc
         cLzbUlkYEHdpq2dLSx9eKgJCkqjtergDC/BadwEWU8V3EjhUf0Ivaj+MVptO5Fz2tf2l
         Iltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782228383; x=1782833183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r/cZXqF8tr2DhWW1MyXGMQoZN3ZKgmdfxneLAbvm50Y=;
        b=SeXzrIQ2lBMJQN4LKyRUc8gSUN3GxPA82ABQEgDlS5yHMr7I5Z/hJ08Q2R158RSydY
         yMm878T5CoQi7GGdjMK7QNUQPtOq64/WRbZyAd8WDuGUgyA79EY7KIdx/v11YbgH00xv
         NUTA8+cIv3t/7g/HoqzoHROMYw/qmCxurtMb4WCdf+oKu3gGhhiWJe4Hp2oVdiAdG858
         xku45lcXW07yeI/FywHnbdJAgYJ/aZvcWVYEtNRWgL5R2C+qoKIpCnUf5/wTduPCab56
         SFeuS1dtqa8pVA+Zeisrbsle45/zqu5K902XU52DOpfsyryzN8WsLmV9b2PpxLZakOJp
         Mw5w==
X-Forwarded-Encrypted: i=1; AFNElJ8lpf5kyurtoohsWZS0FR1wxs+abQZucWUcRxiE7QrX965cAQ6nSWT4ebJgWODqnpxTT8W/V0WZwvusHmmv@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDkglnZs/5e3uYy35dXBZCj7c3HMwpUST3sZuwjCpesrFh6Kv
	vBQ7hPxyL+3ZK88JEwNpFnX2nUIzE88CeSFVE4i43vKLG3qnF+yVNqGTcEY0o5iwZMEbhECKDKw
	HZELAerdxCFT2v0ycq8fALCLKM5FQdNU=
X-Gm-Gg: AfdE7cmUXQRHQdMyKiZ2ObH7NcHRPUkrBzaQsz3Zc1pl6ONwkMAICanHWAGim97ogpY
	GOAFsNwBk76oL4poWUQBd1LMfz3SwPFopiQR/Z3+tO86Wbx4bV5SnRVMZbRQqmsiFBmWd92ndpI
	FX+Lvl3brBuea3eA69hH35BWk6RAph1vj1Ru2EtsH7t5PMAExXCrKPx9Cve94RCwDoafKZ44TdF
	nnfI1uV+JGI7UAl7JNHQcLEXgbW82x0dIj7MO2xGFsX4bkD7fVy/ZzySX46NmrZC2YioY096pMb
	sElA4E3u0ZjtW1pANgsqtVR0l3QwNLA=
X-Received: by 2002:a05:6402:3506:b0:697:e8c5:f6ce with SMTP id
 4fb4d7f45d1cf-697e8c5f85dmr1114322a12.0.1782228383503; Tue, 23 Jun 2026
 08:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623-work-bpf-real_inode-v2-1-8e8b57dd25f7@kernel.org>
In-Reply-To: <20260623-work-bpf-real_inode-v2-1-8e8b57dd25f7@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Jun 2026 17:26:11 +0200
X-Gm-Features: AVVi8CflCeyuhGgdY0pA4nGSNZyvvrxdUzij31TYdu4fgqAwW4JW8TWopRJ_jU8
Message-ID: <CAOQ4uxhQnB8kAwHTKhDsxZ51Jm=gwCs2UHs7UGYboy0SNzVN=Q@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: have bpf_real_data_inode() take a struct file
To: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 11:32=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> bpf_real_data_inode() must be usable from the bprm_check_security,
> mmap_file and file_mprotect hooks for systemd's RestrictFilesystemAccess
> BPF LSM program, so have it take a struct file instead of a dentry.
>
> Amir Goldstein <amir73il@gmail.com> suggests:
>
>   While doing so, rename it from bpf_real_inode() to
>   bpf_real_data_inode(). For a regular file on a union/overlay
>   filesystem it resolves to the underlying inode that hosts the data,
>   but for a non-regular file it returns the overlay inode. The new name
>   makes the "inode hosting the data" intent explicit and avoids the
>   ambiguity of "the real inode backing a file". Document the
>   non-regular-file behavior in the kfunc too.
>
> Both the signature change and the rename are safe because the kfunc
> landed this cycle and has no released users.
>
> Fixes: 9af8c8a54f6e ("bpf: add bpf_real_inode() kfunc")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
> Changes in v2:
> - Rename bpf_real_inode() -> bpf_real_data_inode() (Amir); the new name
>   makes the "inode hosting the data" intent explicit.
> - Document that the kfunc returns the overlay inode for non-regular files=
.
> - Link to v1: https://patch.msgid.link/20260622-work-bpf-real_inode-v1-1-=
4014eb4cbefd@kernel.org
> ---
>  fs/bpf_fs_kfuncs.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f0..f1863a891db6 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -360,18 +360,23 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup=
 *cgroup, const char *name__s
>  #endif /* CONFIG_CGROUPS */
>
>  /**
> - * bpf_real_inode - get the real inode backing a dentry
> - * @dentry: dentry to resolve
> + * bpf_real_data_inode - get the real inode hosting a file's data
> + * @file: file to resolve
>   *
> - * If the dentry is on a union/overlay filesystem, return the underlying=
, real
> - * inode that hosts the data.  Otherwise return the inode attached to th=
e
> - * dentry itself.
> + * Resolve @file to the inode that hosts its data. For a regular file on=
 a
> + * union/overlay filesystem this is the underlying (upper or lower) inod=
e that
> + * stores the data, not the overlay inode.
>   *
> - * Return: The real inode backing the dentry, or NULL for a negative den=
try.
> + * Data resolution only applies to regular files. For a non-regular file=
 (e.g.
> + * a device node, fifo or socket) on a union/overlay filesystem the over=
lay
> + * inode itself is returned; for any file on a non-union filesystem the =
inode
> + * attached to @file is returned.
> + *
> + * Return: The inode hosting @file's data, or NULL.
>   */
> -__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> +__bpf_kfunc struct inode *bpf_real_data_inode(struct file *file)
>  {
> -       return d_real_inode(dentry);
> +       return d_real_inode(file_dentry(file));
>  }
>
>  __bpf_kfunc_end_defs();
> @@ -384,7 +389,7 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE=
)
>  BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
> -BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_real_data_inode, KF_SLEEPABLE | KF_RET_NULL)
>  BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
>
>  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_i=
d)
>
> ---
> base-commit: 5b33fc6492a7b7a62359157db0f92f5b6e9af690
> change-id: 20260622-work-bpf-real_inode-c3202dbaf0ab
>
