Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3438A289
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773869492; cv=pass; b=a2/BBr7u1RQ6py/Rryh/T9h7rDRyYJdVno7z/LXxbLhLqTMHqdmLboVYM8jruVufCyIT0DwBkFIDrEMJYZs0P2wKG6aFfaNVO8sW99sXzuz9OQi+PQmquSOQAUIsCFsGbWIbGN8sqcu2XU3PGXeWkB7ocjftVstXeFGyzQ3vYJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773869492; c=relaxed/simple;
	bh=vROh1KOVXMRBxqYuZnoPeuLETVUs0NmL8sinoayId/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paD3Oj+6S1PpKNa2sKUfMrEFqi+hL+zLuhvk9fvoiVCZpF1/dzldUW4Qj1+SMI/p3NapKYX27i2sx2XGFHcfzFcfT7/ctsXpbhlvepGyu9itz/aex4rIvUTurklJs5HPz5azhw8nLpQbi0tMf6YCSr4rMiGRQZKO8gHOS/X2STs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwCanvAL; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwCanvAL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so2259135e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 14:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773869489; cv=none;
        d=google.com; s=arc-20240605;
        b=MYCAAzLOM4xG1l3PAmRvO86haECtCqZrO/ioDhy2TvQDTN3CobVXgX7Z/Bjjbna+28
         BxpaWSD8dRoGfevTb9SauMYfItNe5OC2TP7lZcdejR+dPIuVKCVs1J/XOO6iW6Ld+2hg
         EakD/oQxBrkFPuJLFaePHl7E0zSrdLpcHPHme3fmdxf01tTCJqaksOsCkGRKRxuQnaOd
         1+WBF8l4KhFyDRP3y8yaUDQ7ENoGAjjhlCZLywahzPFqYhDocPVwth48UYfjsFQtczgd
         pt7OV0NstnR7dAvadwOhgcp1ZdAQPoumOQQ7r1OKdKeYbND9h6YoAndUd1R+Brxcdpay
         DAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L2cRBpJlsNrhvxK4M8BB6Wl2EZ0E6vesFsEYNG9qqD4=;
        fh=nBSvL5nSymPkGJVETTj6PhkYUWuE5xyxWLGXWQ9J50o=;
        b=Wq23OU0Hk2rnDDg/hfWCBGdQ4f9ON1hzOn9I77UWUnWbb90eZHvGXZd/uiC6VTIdL3
         NfzoltFMcbaqtzgoCSbh58AO+MIJnJODgO16ENmyN2LYJ4+OXEwWZ1mqbEb9IrxKHsEk
         2PSGLMWLfrn76nTkx/NqXfqbW3eODAVBA7fZ33xsuRZ4IZW4g6eLsA/ALifZ/+Ns8ma1
         XR1E+Yb+fG97xHzKHjzfJDgx7MggIHAYd2EBYVb8pd1gf8narYZB+Fa173vxWkgeYPoW
         VLPOI3ydAsOkOpRTJ8xqcOV7KrY3w3ckK4f5CkGkoSFni9cJVkoDSeXUeeCNOXOmUdF3
         luvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773869489; x=1774474289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2cRBpJlsNrhvxK4M8BB6Wl2EZ0E6vesFsEYNG9qqD4=;
        b=OwCanvALp4NMgon12j3g6bySFD9GrAbx5L0weww9/k+uUMcLRPg+bmQ3B2ja8iv6bo
         Lwf5z9stSv+B8EaTnDGrC8c+dpZXq0nFHE/fyTYY/ieeueHG5J39oIqfyqEqKxXeyUGu
         njCD+pW4Y+h/h83yRF1EN7lT6aN7BlnpMOjqNKW9XZbnGjy25u/6wUG6AlIa/VtusbUx
         bHD2qAZflWdgFmodCjvs5c8pq/XT7c0AMM5xoqZQW0ti+92Nhxw2updq6nHETdNDUu1Q
         ThgBOsMOaC9ofBtiaeBrPZbnHhPZJDo+oSpmd+H1X625YBkoqwHAj8Pm9ZfbU8yRETcI
         rnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773869489; x=1774474289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L2cRBpJlsNrhvxK4M8BB6Wl2EZ0E6vesFsEYNG9qqD4=;
        b=IVZcWOQiZS+xzRK0fzzv3Hv/MrrXLc1BApSKhOpFjAzDuhQGFKyjNU7fYIkdvfz0dg
         1UDZzstV3SCDGBlIH5J//IEyPc6h9zYXJ+1YQTzGieU4i3pcMnl4JGP8Mu7gztLyjMXS
         ntgI6crBEnE9R87222RHSvRwtKwlGqXIJt7TXcJdsnECwyo+pXkvVdhwxyzpaYr5OUbu
         Z/4FDrItqYZXnIAke86hKkkH1TllgbV/iiO2elxkOz99nE0kwRgAm77fiAXJGBWa7UFy
         AOFUvuLlQX7pJgvbP2O5wiPNV/Z+50yK8Dxw7O9bi59USGs2v5MbjdzczF1LHr0nY8v9
         y0/A==
X-Forwarded-Encrypted: i=1; AJvYcCXnomBy6lvFsw36L68iL89s9Bl/7y/H56glxHasbDcLHXubMrT9I87O+eFpeuAtFBNaIjIrPRyt5CPr7vdm@vger.kernel.org
X-Gm-Message-State: AOJu0YzhH76cr5K/5ieozNxQuDnLiMklhZfIKxONxyK2w4aqyOStLner
	P6dORja72wZnLDGPImIcVRF6M7qfDR6AguJKwAaFEWXZi+0+OV0js+SdlIeOsIbYH/lHXFNaTlF
	TzG0JPjYUVvtagcumsPWb4rlQZq/pA50=
X-Gm-Gg: ATEYQzy58lf/Q34ifFSb8mvNmYUrdotf895b5oKdwOvQgXAW/Ggd11yOVkl8XyFmqfy
	Cdq8bGzQrGD+guI60nKXQP3H2v6xT84ZENAtUAZ+fZfy0TDwAbWq1y7pCCUzA9OqFUtEsH9JK7V
	VUBOlatdUOzNzciSmTiU/YCdn8tqcPJRQGuTs7ruhmI50FHb2Fi8Zq5Ahr/o+XEdTL1GnDOhvT/
	hC4P+4gQV/XM6U6DUVJCVs5pTnGPlE4foCk8dxWs7/IIQxRk9ATb7UMx3/r8RX3VL6678dxggfH
	88SZwA==
X-Received: by 2002:a05:600c:310e:b0:483:7020:864 with SMTP id
 5b1f17b1804b1-486f4451b10mr92298115e9.25.1773869489436; Wed, 18 Mar 2026
 14:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318182701.21697-1-devnexen@gmail.com>
In-Reply-To: <20260318182701.21697-1-devnexen@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 18 Mar 2026 14:31:18 -0700
X-Gm-Features: AaiRm50hB5hUD2Wmf9ltfznokOup3dgNJEMMuDIYCxLoYDDLaRbWMU85qyunmME
Message-ID: <CAJnrk1ZBV6p6gg2Fu2_6O=FBXYzDgRcYTP+_8i205MrMhC8FKg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add missing NULL check for fget() in fuse_parse_param()
To: David Carlier <devnexen@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 11:53=E2=80=AFAM David Carlier <devnexen@gmail.com>=
 wrote:
>
> In the OPT_FD case of fuse_parse_param(), when using the old mount API,
> fget() is called on the user-supplied file descriptor but its return
> value is not checked for NULL before being passed to fuse_opt_fd().
> fuse_opt_fd() unconditionally dereferences file->f_op, causing a kernel
> NULL pointer dereference.
>
> This is user-triggerable via: mount -t fuse -o fd=3D99999 dummy /mnt
> where fd 99999 is not open.
>
> The new mount API path (FSCONFIG_SET_FD) is not affected because
> fsopen.c validates the fd with fget_raw() + NULL check before setting
> param->file.
>
> Add a NULL check after fget() and return an error via invalfc() when
> the fd is invalid.
>
> Fixes: 3f2496deff35 ("fuse: don't require /dev/fuse fd to be kept open du=
ring mount")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  fs/fuse/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index af8ad96829fd..39b635651165 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -862,6 +862,8 @@ static int fuse_parse_param(struct fs_context *fsc, s=
truct fs_parameter *param)
>                         return fuse_opt_fd(fsc, param->file);
>                 } else {
>                         struct file *file __free(fput) =3D fget(result.ui=
nt_32);
> +                       if (!file)
> +                               return invalfc(fsc, "Invalid fuse fd");
>                         return fuse_opt_fd(fsc, file);
>                 }
>

Hi David,

I think this is already going to be fixed up in the fuse tree by
Miklos when he applies the next version of his cleanup series, as per
the conversation in [1].

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260316165320.3245526-5-mszeredi=
@redhat.com/t/#u

> --
> 2.53.0
>
>
