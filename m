Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9221E531
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jul 2026 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784461616; cv=none; b=TqKuZz3/LsxrRmqoeSUY4KHHoHil9YXAWOouvoge5zo9clCa484T4cAPgklTxfqUE2I8RaaYHYotn/cOLNJDs78V3ve0Cd6SSaM8gJDmWX6OhV5oTfJQMpTqavvWopvBt0mxqkH2Gmz1H8udTyiin/J/MMljOS3iHez7KANIZLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784461616; c=relaxed/simple;
	bh=ZbftnE++g1Y1/pJKdWBUdVCrFjD+MX94mgAyeQaXS+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjAjv3wfO9nvqFDEweq+nQ46pUFGDQjePOm8wAbLUsL6Eiq1vPpw9FjRz9Cc/7q0swnty3Vg+Esz8nVXJi1uVsLGmprM2F19FKQFz50hKQDxVWsDXNAI21Cc9lzhR5eWQI5edE/eXnts0ij5GZRMdyU0lUCmwM4lFcczFbxzao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Qj8b2pLi; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Qj8b2pLi"
X-KPN-MessageId: 5ef9e726-8367-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5ef9e726-8367-11f1-861c-005056aba152;
	Sun, 19 Jul 2026 13:45:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=u4Yymmqy9NrtGG2Hi4dcQjprWopTAV0yjjP/PaGttDE=;
	b=Qj8b2pLiE3jyo8g8iUiONmEdwPDuT915lo9Vn13Ogu1H0u62CfQL1fccK5SVS4qkhlbM+2TcEhQch
	 nRJudQ4zZlxrxdFWu6wfSXsQDNogX9aIdZSeyhEGfmtxBd32aHBEwEssi0tOCg4IwnDEY9tSNbquyV
	 1iBfTy1zaPOQWqQRaRqcF2PNiavLx2vwdALmmBvzYKvlwYKxHJrJT+zsPCBp6uc/F0wANA12xIjzLe
	 tm2ctJ7PuzybyfVLi+Jwzjgp7WOhZ/qitfvijqgCx3e201yinWqNfE9ys/91Jx9L5Wq/nj9EH+8BFF
	 nF8TT9uY0nJCrB1LXbrk6/SatxQuBAw==
X-KPN-MID: 33|rZT2IGBvhhm8NoW0Bh2xqh8uBkHDHZIzTouy7488pp5eEQSBWZ8bIMP2/+SDP4i
 cD4pPIVNJuQLwk4+Q1kNQwdxHmgOf9KbFpf2mkwXAcIk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|jM+CxdX4fF6uAIaYZpXdddd6HxSK6NwCsZ89+PALnrXV9fqI4PoNkRJZwuh7wkG
 0b1WFqKz16SA18aAsfmbwLQ==
Received: from localhost (unknown [178.231.6.19])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 5ebb7cce-8367-11f1-9211-005056ab1411;
	Sun, 19 Jul 2026 13:45:42 +0200 (CEST)
Date: Sun, 19 Jul 2026 13:47:10 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Vivek Parikh <viv0411.parikh@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [REPORT] binfmt_misc: leaked write-access denial on F-flag
 interpreter inode
Message-ID: <aly4-PR3FQQb-zAd@daedalus>
References: <CAHKnOm098q+3rjU9Ybo9vJYOW1K0h+A1hPFt8nw+6bEmcwywSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHKnOm098q+3rjU9Ybo9vJYOW1K0h+A1hPFt8nw+6bEmcwywSA@mail.gmail.com>

On Sat, Jul 18, 2026 at 10:13:46AM +0530, Vivek Parikh wrote:
> Note: this bug was found with AI assistance, so I am treating it as public
> per Documentation/process/security-bugs. A reproducer (unprivileged C PoC)
> is available on request; I am not posting it here.
> 
> Summary
> -------
> put_binfmt_handler() closes an F-flag (MISC_FMT_OPEN_FILE) entry's
> interpreter file without restoring the write access that open_exec()
> denied at registration. Every register/delete cycle of an F entry leaks
> one i_writecount denial on the interpreter's inode, so that inode returns
> -ETXTBSY to all writers until it is evicted from the inode cache or the
> machine reboots.
> 
> Affected versions
> -----------------
> Introduced in v4.7 by commit 948b701a607f. Present through v7.2.0-rc3
> (fs/binfmt_misc.c:162-168). Root-only from v4.7; reachable by an
> unprivileged user from v6.7 onward, when binfmt_misc gained
> FS_USERNS_MOUNT and can be mounted inside a user namespace with no
> capability check on registration (on systems that permit unprivileged
> user namespaces).
> 
> Details
> -------
> Registration of an F entry opens the interpreter via open_exec()
> (fs/binfmt_misc.c:821), which calls exe_file_deny_write_access() in
> do_open_execat() (fs/exec.c:800). do_open_execat() documents that the
> caller must call exe_file_allow_write_access() before releasing the file.
> 
> The registration error path honors this (fs/binfmt_misc.c:834):
> 
>         exe_file_allow_write_access(f);
>         filp_close(f, NULL);
> 
> The teardown path does not (fs/binfmt_misc.c:162-168):
> 
>         static void put_binfmt_handler(Node *e)
>         {
>                 if (refcount_dec_and_test(&e->users)) {
>                         if (e->flags & MISC_FMT_OPEN_FILE)
>                                 filp_close(e->interp_file, NULL);
>                         kfree(e);
>                 }
>         }
> 
> filp_close()/fput() do not reverse the deny count, so the denial is
> leaked. This is the persistent file opened by open_exec() at
> registration; it is distinct from the per-exec clone made in
> load_misc_binary() (fs/binfmt_misc.c:251-254), which is released
> elsewhere.
> 
> Reproduction (conditions)
> -------------------------
> - CONFIG_BINFMT_MISC enabled.
> - For the unprivileged case: kernel/distro permitting unprivileged user
>   namespaces (v6.7+ for the userns-mount path).
> - Steps: mount binfmt_misc; register ":x:E::x::<victim>:F" for any
>   world-readable regular file on a non-noexec mount; delete the entry
>   ("echo -1"); open(victim, O_WRONLY) then fails with -ETXTBSY.
> The victim needs no execute bit; open_exec only requires a regular file
> on a non-noexec mount.
> 
> Verified: unprivileged (uid 1000) on a 7.0.0-27-generic host, and as
> root on a 7.2.0-rc3 build.
> 
> Fix
> ---
> Mirror the registration error-path fix on the teardown path.
> exe_file_allow_write_access() is NULL-safe and skips the same
> FMODE_FSNOTIFY_HSM files that exe_file_deny_write_access() skipped, so
> no imbalance is possible.
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -162,8 +162,10 @@ static void put_binfmt_handler(Node *e)
>  static void put_binfmt_handler(Node *e)
>  {
>   if (refcount_dec_and_test(&e->users)) {
> - if (e->flags & MISC_FMT_OPEN_FILE)
> + if (e->flags & MISC_FMT_OPEN_FILE) {
> + exe_file_allow_write_access(e->interp_file);
>   filp_close(e->interp_file, NULL);
> + }
>   kfree(e);
>   }
>  }
> 
> Fixes: 948b701a607f ("binfmt_misc: add persistent opened binary
> handler for containers")
> Signed-off-by: Vivek Parikh <viv0411.parikh@gmail.com>

Thanks!

This is already addressed by a recent patchset of Brauner.[1]

Best,
Jori.

[1]: https://lore.kernel.org/linux-fsdevel/20260710-work-binfmt_misc-locking-v3-1-a162f7cb58d6@kernel.org/
