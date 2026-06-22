Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D161126BF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148566; cv=pass; b=I6SP3Yx6b8+1huyWz+cBsIyTLIE+HrUFZ415frpW3BNUsPTmd4/OFMWFqMafwhZDKwLcajFNEoTGFbk+xDrdPzdpHooETppJggaH6VTNcYDaRJmQU2WCFNd6ajvIulRWyel7SDgRov2s69xIL9f2VFeSYzjKNA4MV9sVhoDQvwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148566; c=relaxed/simple;
	bh=VWTc9i2eMckx3nD8rqmrFjjK7XQcPakZvpS8iypxNkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXAoUYlwLUsqBMkqSNFhZAoM/uqq44IQR5FWSehnf/OgozcF8gz4l6TXd8CGtdLS+mqfN7Vs3pZOkRNAaUikKR2HI2EZdvsmDfYI5NpkKczsw2plMcR6xKl64xENeQr29iAeT1lxiE0pHuxpPIshlyFQ/0c77QgpDMorTQBwfh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3+Kjwm9; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3+Kjwm9"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697cd68d7adso1114066a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 10:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782148563; cv=none;
        d=google.com; s=arc-20240605;
        b=QJ5LwJyWdWmOH6o097zcEIvNM07WczJhhQQEo6aigYdYTyC063QWDXOkQSQTBe+VE6
         jSg45avfTk/IeL1OQcE880fSlUuQTfaQm4RNAdihceYw9OFB+oZa19Vp/eke5C7pdb2O
         hK55D08edCsM/lCTDhyk28aMI3SG/QOTHiSk7/ho5QTNgNH8wX3G3F2Ln8ftSFjNeGot
         mc6aazkZAo7v80Qxf6v1oQt28KQlJMo1FTH1R3X1rip26BM7HeXR5RQhkfWozNVrF1vZ
         dWMhO4CrBdifn7gob/3E1iYiloY/0k7yI7Z/1zomAih01/6GWCzmUcuS3c/N+ArRL2uM
         bSpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cFeJG8pc1VJ0tkXqG1ecAN+uRU0QARHjaUDG2/HiEsI=;
        fh=TExIN1MoTEdPDXEwF228F9GJ36Xzd/c34S06uVNYReM=;
        b=EUxsvWzG0UN9by48XfLnIedmFprOqtahPqqWq+gBh0AO6rIhQ7+Lfxg9QTpPZAAdI/
         YEpG9lI502DAOwMQuishwHFu9JuBbkk3mEvt520UzcT76nJyRvdRubRnEid+ybW6Fv1F
         IddTnlekZa6XNGrNVDDbVHGUJ2igNYPyre+n5loHJc2WlxvBY+E3GsGWqd6SpQ9OYWkq
         7moaajllc4ljJZn57IIbN8NsEOk6nVbmpVj9o7Lxg2uwZachfQDIUiU41PDpsB8z5wFS
         XgB5C64Kai4Aiidj3Zntoi8q6wAmtrtX+qEsNqZ96hCbTo4xihXlc4r/LU37v17JCveZ
         mWmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782148563; x=1782753363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFeJG8pc1VJ0tkXqG1ecAN+uRU0QARHjaUDG2/HiEsI=;
        b=Q3+Kjwm9h/YwuQUaz9tEvkdIa28qfT0c+zamx2VoRTDGmI6zti1wo0+4jAnl8agNkQ
         t4A7odJv5RLjVUmgRiCUgomHSGDpht2XkffckuAcCGMQ3hXTVWeI2Gwm5a6oofdDBoQB
         qBPXhPLHvvjbnx66UjsuKa8nXhW3VEmB3LpHQWK7ncR2dZlYTWU10JsbAhIUqTWM+MI9
         e0Qbsv73aQfaV0Wn1jB45zw8YajHhl6De0AsG3Erq9RvWRsswdE/MDISuZsQ1mO3BgjH
         DD5MFwDksU9sLN/ndn4i/WDKZSY+EUjr2FeLh/JZKcVHKcFvgFrHEH6Bll/OxfZdljf5
         iN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782148563; x=1782753363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFeJG8pc1VJ0tkXqG1ecAN+uRU0QARHjaUDG2/HiEsI=;
        b=aroqdOPaFwCGiHjUBRQGCXHGzIFuuUeXKBpGP36d2xEdhOLUjqoSair7PtZu4c9zW9
         TTXWTyW5eRxpBbCPQ5kE1dXxnEH9YH0u2ItAi29hRdThWJqzLLrl5dKmwsWIjzsEMXz5
         tN10EylIsVmuoWZws8RcOTZhANrQCkM1Oh9M4W2tnRcbIHGQlzwoUIgPrYByvndpjxh9
         PeXhBV8QkI9nbTnGVCrJ7YmGZjR8f6MYkHb/XOgIl97OAH8KnnReUHiQp/hA41RB/scV
         wXKw+hyy3e5H8H6MVUSxqZT0JZokI8qnCua8yyajbabE/qFtlKh3Fg5CcW2afdE5iI83
         KSzA==
X-Forwarded-Encrypted: i=1; AFNElJ/2GZf517Nht4/dPlCDG61MX0Xz2rw4HSGITehi/pi3NUnM6Qcc/nI0DE6GDYz3CiAYyPOiHMq1YBLXZoSG@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNDQPuY0D9DR+tGV3pA+C6Kc5vAceEfq+68u63K08aqodLXlb
	p++KOzbiaV4MC2d6shHE5M+EKEldhWIkB/xGIxMQlVyTpcY1SCZ3FoGTiMkjhFmQj7ry4Yz1Ckx
	/mpNbrjyNskkzIl7cxF7x1rjqd9j+1hg=
X-Gm-Gg: AfdE7cm1OMEwH7c5aA/ag/Dtq72iY5Flw6KqHdEkc0pgTJwmyGiJEH67Txt1BcJHYGb
	Cbkfv1btRlQML96vCMSGV5YXxNpYBWnH8gXzdh8xuT7daE1RXIn1IuaEQH0MQ5Xt8Gpm4em798i
	YcReyxQ7sKkjv+aGEu6f/1wfAU4qFckBylNRqi73l7LV0wkj4EzpwQ28rLAsIof3/Ykte8oaQj8
	hzTlrXEVbf/KXCpImDiAm9c07onhjrgzTD8iqGaAQSZLLGRif+5BpTM3t45tMVkG27Oa9kikDfW
	fXcn7+uVbHIpMbqdTB7ETMRx3bEeLiM=
X-Received: by 2002:a05:6402:158b:b0:691:55d9:fff5 with SMTP id
 4fb4d7f45d1cf-6975681fc13mr5977545a12.10.1782148563322; Mon, 22 Jun 2026
 10:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622-work-bpf-real_inode-v1-1-4014eb4cbefd@kernel.org>
In-Reply-To: <20260622-work-bpf-real_inode-v1-1-4014eb4cbefd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 22 Jun 2026 19:15:51 +0200
X-Gm-Features: AVVi8CdbPXHukBxq22dST9DVayoEkEf4SCjLmu4AI3jOv2CLp0y2j943xEfTOrU
Message-ID: <CAOQ4uxiaD3NnUDBCTYzjS-8+y8boxzwVs1p8QsWaC4AkVFPu5A@mail.gmail.com>
Subject: Re: [PATCH] bpf: have bpf_real_inode() take a struct file
To: Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:58=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> bpf_real_inode() must be usable from the bprm_check_security, mmap_file
> and file_mprotect hooks for systemd's RestrictFilesystemAccess BPF LSM
> program. It should take a file instead. The kfunc landed this cycle so
> changing the signature is safe.
>
> Fixes: 9af8c8a54f6e ("bpf: add bpf_real_inode() kfunc")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 768aca2dc0f0..f941c29d26ef 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -360,18 +360,18 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup=
 *cgroup, const char *name__s
>  #endif /* CONFIG_CGROUPS */
>
>  /**
> - * bpf_real_inode - get the real inode backing a dentry
> - * @dentry: dentry to resolve
> + * bpf_real_inode - get the real inode backing a file
> + * @file: file to resolve
>   *
> - * If the dentry is on a union/overlay filesystem, return the underlying=
, real
> + * If the file is on a union/overlay filesystem, return the underlying, =
real
>   * inode that hosts the data.  Otherwise return the inode attached to th=
e
> - * dentry itself.
> + * file itself.
>   *
> - * Return: The real inode backing the dentry, or NULL for a negative den=
try.
> + * Return: The real inode backing the file, or NULL.
>   */
> -__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> +__bpf_kfunc struct inode *bpf_real_inode(struct file *file)
>  {
> -       return d_real_inode(dentry);
> +       return d_real_inode(file_dentry(file));
>  }

The problem with this API is that for special files it is a bit ambiguous
to say "the real inode backing the file".
Is it d_real_inode(file_dentry(file))? or is it file_inode(file)?
The old API avoided this question.
BTW, did you notice that for non-regular files, this helper returns
the overlayfs inode?
This may be important information to document when exporting a kfunc.

If you take my suggestion from the previous round to name the kfunc
bpf_real_data_inode(struct file *file)
the intention becomes a little (bit) less ambiguous. huh?

Thanks,
Amir.
