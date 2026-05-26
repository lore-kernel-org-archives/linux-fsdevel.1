Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB03FDBF1
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804208; cv=pass; b=ijX9ugZ5vn/1H749jditWhl1GKg4wDf+N2FfzjIFsAo0dRfvuceHGybtvd3e2Qbipl2Li0wIoiFVKyICrmsyx/le/dRZvRzZ14/dYeBt2feazvWGF7enxZT2mmveaSEyPyQoZ6DWGgibZnaN+ZsQNZsA4dhTMb+kpKlgDjQK9D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804208; c=relaxed/simple;
	bh=j1GKwUDpWvhOZBhkaO+rpncrchzuft3RI84XNRPNJsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkRfgR5tnWiGnmp8KQt7gYJBcOBOxUuHPIIfcBMKsaqtgg59V4ttP/mieSgctb37Byd2uIT+hyeEufkkr/f/7NWYzCU97HwyWC5N3QQWECth8FF+Jy5pPG7l2Bv52JAql15l3oz2yCjyyFQsY68th5s46714FIXdXhavVHRTSH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+i3Dc2l; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+i3Dc2l"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68719234fd8so4028628a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 07:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779804205; cv=none;
        d=google.com; s=arc-20240605;
        b=YdaZX+PADvAC+q/8X9MWaeROQh/Hf+7ZgJp8QknqMk8p3g86wfC8XkUyhkyZh1wgGI
         FhyHDupdZwSg7e47Iq4BP1PqZg5H1N455bUTNlqe1vU7rzLri+cOZt3uDFHhNI2MbI5D
         ZGozFcgh2Sp3QrOOiZOQsF8GLOXDhyVt5Ko0+h/MZCh2hoQSjwKK6TGKqzAGeku+RGlj
         ua7Bgq3E4RlmidlkNxMa3S5EGp92O6x2BcqqVdF2/svsyhy/ydeRsUPmOx8T+kmFmqEv
         plR22yUFm2eSaKv+2XyrYZceFLOIRjmDrf0ucI/N5tUlOLg2BIl7apWRhYeRa1zxvnK0
         JF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9XDZuMXc2hNe1igpILUdvrH8nE+95WDHTRv7db2FxhA=;
        fh=o7ds5aSrdtBJy4CTy9NwAc331E0viM6BmgIEMBGzE3A=;
        b=l3UWMV8vacDFgg63XvGBpuHEI/b3kbSknQfBFG3//7gk/1m2BqERv0QGCLBdHJDY8k
         PABXoOwRD2w6UEVbc3Vo79/kUiuFl5MDP7MEWTbTreBszAc1OUcHSbNxF/hYHyQ0h4vy
         5aZHAcMOxhRMDIgGc7apyHfyaofoPIH/dyJWA2H/Gm29nPpB+jSFISJAkAXVBO+KSA6D
         eFgzq43rJV0TuhELiIghRnaJkECdqCwIY1ajnPM22XB79uJzAeLoonQssgWsl7uR/0yj
         7WhKQ3VC5bVv3wsNdcQ6QfM/JlsgooRK+y1Bvq952/gLJ4N9Qbop2GyghpqVRYDkLrBA
         ReIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779804205; x=1780409005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XDZuMXc2hNe1igpILUdvrH8nE+95WDHTRv7db2FxhA=;
        b=N+i3Dc2lep5K6Vg2xRkndhF54piZR1D92s/ceOdvMaBFKuHaI5iY3uD57/915aHbq2
         NFxrSUry1sQZL2nxxj+osdTrCS0XjzTuIkMpP/t247TiaFpUoJJr6IXU9kWwmzCB+sb/
         qGmRiq3LKVR8q1pGMsmT/QIek/KUF7gGuNfYa2zXrdPRGX9pknJRcMu8mVEZ0jl0sOhs
         pBt+OVqNBMAK7Z/xPkRGE5MXcwkJmFA/ruXDvbDU/Wk8YCq3OYq7mymVoEPm4dAIom2X
         q8E2Wuw1ffRZXCt+EH9iWLutoxpp/BNNPWMiuYr0/TfoFZGxQ+HUOTRWKbwMylTxyTa4
         iicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804205; x=1780409005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9XDZuMXc2hNe1igpILUdvrH8nE+95WDHTRv7db2FxhA=;
        b=fGHH1JOPDfNqHgyMWxyl49vZwnWKoKPAukMezCLHJ1KdBim3rwMp5x1JJRIDCPONW7
         +QgUU5PDGtrHyt5ODwCeVOZgxPktklXUtsrOUCNHC9HDdhPCiKGAWDI9jhoJSCwqDqIs
         IWOASsxHGCRMJuwYGX5aAt5uhCKAcgcgUafRvAR2pWkgYM8KP9OVd/2ADD1UP/mfZWaw
         vnQxZFZvfeUtNkTvhBHEceGne1kxY+hwU0nQuEtQCg8Js1SPmOz1COGEVrO0OhyVWwcr
         wtjrLSpAW0RPeH6Jh0bsDaiVzgyJQLRMfzdbJSUrf3Gjnn2sZhx2RLjWZhZPsF8qARSG
         QU+A==
X-Gm-Message-State: AOJu0YyV8NnbiisS1U7PYMlrzTZbPUTP/tTxXLl7tOJJGXh3/cw/v/Qm
	4flRF+z829dZQ2dalVNFZUiXissx6YuirVhyMy7EL4P/shLYj0yVhNZr24jTGiu4ZRv2FZBks84
	yW+nYMrxe4zcYUCmLj2S7fr5XKebs3Yw=
X-Gm-Gg: Acq92OE2hQ7zqs/g2D6CvqLkp3Pex4O3of0817zr9x5i+bEYM+dbv4Le3KcqtT6Ct/w
	p4K8HWOSp3JnmBPW0249RBbU9OAD4N1L3tzpI+9DmGz/kcqefsq8VVwGCHDrcOYBZQs26UZNyf6
	UmTg/reUwxbl4VT7L0zIrMnQK9Eyl7XSE+l86CNeScLKlmSdUTZ0WN6KD/sBeUvTzjRDB39bWAe
	jzYReQJq50qDMoXcP3tMZY3Laa2XO4SQSnoNVgHE8zxWyV94vz0M7VrDEygNLsrfYN5B+3Wl6k4
	jjl7cRQVlqSDTPSdUxZygQ9BJvb4VSpXEHl7qxXSB8x6CWmfSvc=
X-Received: by 2002:a05:6402:f1d:b0:689:5b3d:6271 with SMTP id
 4fb4d7f45d1cf-6895b3d667fmr4391044a12.25.1779804204973; Tue, 26 May 2026
 07:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-work-bpf-verity-v2-1-cd0b1850d31b@kernel.org>
In-Reply-To: <20260526-work-bpf-verity-v2-1-cd0b1850d31b@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 26 May 2026 16:03:13 +0200
X-Gm-Features: AVHnY4IFVP6dOFBmyLUEMMTjP_A2wIhTbvkrPjBzeZTBVJavqwOPIBXZ03drNDw
Message-ID: <CAOQ4uxgz0O+iC8rB_PrsA-zSJDXwMMNk9ND556HueedsUOzRzQ@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: add bpf_real_inode() kfunc
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 2:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Add a sleepable BPF kfunc that resolves the real inode backing a dentry
> via d_real_inode(). On overlay/union filesystems the inode attached to
> the dentry is the overlay inode which does not carry the underlying
> device information. d_real_inode() resolves through the overlay and
> returns the inode from the lower, real filesystem.
>
> This is used in the RestrictFilesytemAccess bpf program that has been
> merged into systemd a little while ago.
>
> Link: https://github.com/systemd/systemd/pull/41340 [1]
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Changes in v2:
> - Tag bpf_real_inode() with KF_RET_NULL and document that it returns
>   NULL for negative dentries; LSM hooks such as security_inode_create()
>   pass negative dentries, and without the flag the verifier marks the
>   return as PTR_TRUSTED and skips the NULL check.
> - Link to v1: https://patch.msgid.link/20260326-work-bpf-verity-v1-1-efe9=
edc46ddc@kernel.org
> ---
>  fs/bpf_fs_kfuncs.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index e4e51a1d0de2..761fbe0fec5d 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -353,6 +353,21 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup =
*cgroup, const char *name__s
>  }
>  #endif /* CONFIG_CGROUPS */
>
> +/**
> + * bpf_real_inode - get the real inode backing a dentry
> + * @dentry: dentry to resolve
> + *
> + * If the dentry is on a union/overlay filesystem, return the underlying=
, real
> + * inode that hosts the data.  Otherwise return the inode attached to th=
e
> + * dentry itself.
> + *
> + * Return: The real inode backing the dentry, or NULL for a negative den=
try.
> + */
> +__bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
> +{
> +       return d_real_inode(dentry);
> +}
> +

Sorry for noticing late, but pause to consider.

I see that both EVM and IMA open code the would be helper
d_real_metadata_inode()
while for d_real_inode(), d_real_data_inode() would have been a more
descriptive name.

The name d_real_inode() is from before the introduction of the D_REAL_
types.

Perhaps for the kfunc we want to use the more descriptive name
bpf_real_data_inode().
Could also add d_real_data_inode() wrapper or rename all the vfs call sites=
.

Up to you. Anyway feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
