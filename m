Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793293768;
	b=2Ye9M0dCrO/k0I1vrD7+8T4TiCrYwMYZygMtwvjNVZGPVoJkKC1SdYt0TY/u9kaomLYS
	 ngISaYftPbG6VmB3nT9HOnDuC+aKGBPVV4JdnZX017oiha2zLlo82grx7uAyOj+j097yu
	 SBRS3e4NYZ6XV9ZK1EtOP8iHK5V9F747gf3ciEscL/sGCuYVwHUBtjOPcuVt0QZGGlxhE
	 yR1IPxlHENyL89ivXJH9w2gRI3soobk4AINquY2v1vzrD+EkwrW+QhuW6C9hluWbcQ1TJ
	 iMN0GKD2iHn3cildhoL8b/+7LpbA2kbHO3NwyUAlWyJAG1xiS17aXof6mPxUUzI68Sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=n5CrxIdnLHrI4ftpsB79WHBSJ2U5HNFlrN9+LthF+nk=;
	b=izrEbtKybV9z2EZR/OKpGtZG729gA2AuE3KtcrRq5q8n3Vt9mc5lnTtFY1hRD0hTlkG6
	 pZPJQ8XdPlWysXokvFIPyBWyYBB6n7l6lK5/CjOpM/7dma+DZFiZNU16t5klhTU8m+3iI
	 Mv/OHm8jupVabFHor0gEEm+CHjctVOzTwY+6AK4MxR+e47ti8qQY1IYEFx81Pk1uC6rXf
	 Usq/L0V4KGuyx38FaKY1u45c3Ig+UPZGZ0UigBGC9nicPN/JdE3WK4VO/YOpcLUtk0GVV
	 /isvjKXRjw22+kBb7VGztdnvAf2lK2uCAdlUFa10EGFinIaMKk1WAVywEuEH7Qxmg5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sHRgtcfR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F4D606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 17:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24F4D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sHRgtcfR
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so2790257a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793293765; cv=none;
        d=google.com; s=arc-20260327;
        b=elmy0OUSEaFtAi/fG1eA61x5anCQsiScsXWO9M7qNLxFm+/+Afg3GjB88dbaXgpAeB
         FyOQ68vGHMVh97Tlvc+hCqNLIa3Z5hPOP0kQAsNDn6gDa6sQ19j3VAkybTG+TABv5Y8w
         w3DeBuGwah5kctOqANrm+EchE17M/j1pwQ9IDTHs2+V/09KAzPGoQwugr2PNMnB/tarf
         66WtsSeu/gxwS/PlgoU0i8drM/RpoiVKsZpWyBVXtewoy5TUFd41J/K4AgwnjxYi5Njr
         oLONZ49IO6/S/9DQyfmD8JgA2ZxcMelAm8pGMDj5V5FFMDnKxoUJlr5dFLY6Sa/e4hNw
         nmOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n5CrxIdnLHrI4ftpsB79WHBSJ2U5HNFlrN9+LthF+nk=;
        fh=VX7lyIlz9gimaeYDZqYM5zZJsC4aVqd+s3QdMnoVAY4=;
        b=ouqewxGh2EQsgYxBbEWGFJRNPZ5I8kwiZdIpfxJCfSgBYS04IkGBYfjImGsZZD9L5y
         tXUy3YQJkySx5BaZquLqM+LduHBYI1gGyFb+bI1qf9kooesUu0Z1LSBaENl9VBhrzJga
         Z26Trae1f7si7T4sbPpr4GvoX2q8ayLITfHcfLHSfSto8Uy0cu6fF1y6gc5Ows8MfJU0
         bvplyGvuf3DJUFHnAI4EOuXsfYiDYUhuMVFHIik0+88BjDrGiXLHJNPoOgyv9dRpLzpl
         GbE46WZccBFx47c4ixghE1tRHQm9OYMnyZOnaJWEvIJe7d3GDM/cO3ZWqIzGwapxq1D/
         aOVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793293765; x=1793898565; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n5CrxIdnLHrI4ftpsB79WHBSJ2U5HNFlrN9+LthF+nk=;
        b=sHRgtcfRtujwso1fgJmrsF7rrmHv4F4Zpr8X8fxVKLW4d2rVNFOobOOT2HNMTlLxhj
         t9BGwaIcJOr71hQzS/kLIC9q7JEX1n47xSmGpayt5S1slWaCjFgYmMEDG9iKpJPzOye+
         Wc1qCFquAx8KpLo0bRsLsrhb0R4hLSAhlzpQIXw11kcTQdvLV0anIwvbBEV7esRLbN5V
         +qUbcH4qtagqLVOYsHOV7OHedWMONIV510vMwUI6HRnhEum0hY+Tq9nrnx06LqubKUrm
         +B+ivfLUac+hoT0zXmT/hfrXvZDStmuMeN7jAsYmt/NfrkdEvCW7QYMfRTK3g8zOrspC
         qAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293765; x=1793898565;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n5CrxIdnLHrI4ftpsB79WHBSJ2U5HNFlrN9+LthF+nk=;
        b=yhZz6gxMVlZcBjAzqBMpdKzmq2tjX10BesAlysJIWvbyYtVP6Gj5MnBxD2c+Q5tldI
         HKuv0SRfMEAFxoVlN6WxysrLk18vQ5UEOisBlz7LzsTLRIjqjosEzRaXAxnnM8QCFcKK
         6wHxwSGKB1pzT5YIjhvz7Mpb/kXobQ3yQSSdyawuPQtj/JeXTGywH888RR62YuFuIWyI
         BQC52m2kBkZcY6pfA84Sd/WEeADl8wdrIUGO2D1OnRveZzzvU+cHD5qRStHiWHUndMT9
         dRCKipef0RCPPdz35tRjn3nd/yJcM5aOXV3+yzb2h+EYR+IkV+SGUzFLzux1E8eHMWgD
         Qqug==
X-Gm-Message-State: AFq9FYJIdjSBDkDV6kIRf5Lf8z39fZHrq4SwS2iD9D0q1r6L7lSu8sB0
	O6rTr1kya5466IOV6HRoMyEfBAHjKTAT0eHqU2CyJoTRl+SCwVovzMqhClWkmNY8lgFHggOiJAi
	4QylE1N5CNohUYgrHTtpugBfEyjeUydA=
X-Gm-Gg: AYBFou1TFb1yG18SneG3CS+pgyL16UO70imn3ssLTGaEj5N0+9CAoVEd5xjkxxcAI/8
	JGO05nBjaQEaQdlp5milmDWQaoT0DcbfybYkCQS2mwmwGTUSjbSJCocR1DNlBZC5jRHD2vSjrZC
	CvyaMW6j4r0pfJyJYXD0l7PatJPFlTTNqikGZG06Qo7+FWhakMgSGX2M1WtCkJ//Y3194fJKISi
	y+sGeM5z7PPxKTxw7jEyF7ufpa0WiQQdh2SRiaIWUPz18Sx4LWpmWlaYXtCOY4Pqzg3BzrKLs2l
	JeCzpof8GtEASDXhXgm/tV5Aldp1y/SfdFN7SIkOsoF7VpzMAFRaD6fqGV2Kj64UdbKYv/c5SLv
	4cGS43VoMNeyUZpnfTOszkBXmz1NlfCoZt0ptPsZ4mvpruJ3xNNs1srVRIuXt8Bn2jkmbmxiez+
	cZu9zB4N+VKet4w1Q=
X-Received: by 2002:aa7:cfd1:0:b0:6b3:c382:364a with SMTP id
 4fb4d7f45d1cf-6b49cc12254mr3101007a12.35.1793293765251; Thu, 29 Oct 2026
 10:09:25 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-fs-ai-fixes-v1-0-88f22792f6f7@kernel.org> <20261029-work-fs-ai-fixes-v1-2-88f22792f6f7@kernel.org>
In-Reply-To: <20261029-work-fs-ai-fixes-v1-2-88f22792f6f7@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Oct 2026 18:09:13 +0100
X-Gm-Features: AclHuK8Mk1uWay8TR8m6wNWSt-hr7nW1jofiuRs6EA2tpf0YUkmH554XzChvDMw
Message-ID: <CAOQ4uxjEa=bMJ+oMJs+EhSDo_0mhUx93uAy10AJ-y8wnHykoQA@mail.gmail.com>
Subject: Re: [PATCH 2/3] backing-file: enforce append-only and immutable
 backing inodes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:00=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> FUSE passthrough opens the backing file anew whenever the FUSE file is
> opened. fuse_passthrough_open() passes the flags of that open to
> backing_file_open() which opens the backing file with vfs_open() and the
> credentials of the server. But vfs_open() doesn't go through may_open().
> So the backing inode is never checked for S_APPEND and S_IMMUTABLE. The
> checks that did run were done on the FUSE inode and that one never has
> either flag.
>
> So anyone who may open the FUSE file for writing can overwrite an
> append-only backing file anywhere or write to an immutable one. The
> server only has to register the file and a read-only or even an O_PATH
> file descriptor is enough for that. Registering requires CAP_SYS_ADMIN
> but the writer can be any user that the server lets open the file.
>
> The FUSE inode is checked instead of the backing inode in a few more
> places:
>
> - do_mmap() refuses a shared mapping of an append-only file that was
>   opened for writing. A FUSE file opened with O_RDWR | O_APPEND passes
>   the open check and can then be mapped shared and written to at any
>   offset.
>
> - fcntl(F_SETFL) and RWF_NOAPPEND refuse to take append mode away from a
>   file on an append-only inode. On the FUSE file both succeed. A
>   synchronous write still appends because the backing file was opened
>   with O_APPEND. But an asynchronous write is submitted with the flags
>   of the user's kiocb and lands at the given offset.
>
> Do the checks on the backing inode. backing_file_open() refuses to open
> an immutable inode for writing and an append-only inode for writing
> without O_APPEND, just like may_open(). backing_file_mmap() refuses a
> shared mapping of an append-only inode, just like do_mmap(). And writes
> and splices to a backing file in append mode fail if append mode was
> taken away from the user file.
>
> A FUSE file that was opened before the backing file became append-only
> can still write anywhere. That's what happens on the native filesystem
> as well and the backing file of such a file isn't in append mode. Two
> differences remain. F_SETFL succeeds and the next write fails. And FUSE
> reports EIO for a refused open because it turns every error from opening
> the backing file into EIO.
>
> overlayfs uses the same helpers but it mirrors S_APPEND and S_IMMUTABLE
> in its own inode and a chattr through the overlay never sets them on the
> upper inode. So for overlayfs this only changes something if the upper
> inode is changed behind the overlay's back.
>
> Fixes: 4a90451bbc7f ("fuse: implement open in passthrough mode")
> Reported-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org # v6.9+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/backing-file.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 5614cb7801e1..2424dc38d21a 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -36,9 +36,21 @@ struct file *backing_file_open(const struct file *user=
_file, int flags,
>                                const struct cred *cred)
>  {
>         const struct path *user_path =3D file_user_path(user_file);
> +       struct inode *real_inode =3D d_inode(real_path->dentry);
>         struct file *f;
>         int error;
>
> +       /*
> +        * may_open() checked the inode of the user file, which need not =
carry
> +        * S_APPEND and S_IMMUTABLE of the backing inode.
> +        */
> +       if ((flags & O_ACCMODE) !=3D O_RDONLY) {
> +               if (IS_IMMUTABLE(real_inode))
> +                       return ERR_PTR(-EPERM);
> +               if (IS_APPEND(real_inode) && !(flags & O_APPEND))
> +                       return ERR_PTR(-EPERM);
> +       }
> +
>         f =3D alloc_empty_backing_file(flags, cred, user_file);
>         if (IS_ERR(f))
>                 return f;
> @@ -263,6 +275,14 @@ ssize_t backing_file_write_iter(struct file *file, s=
truct iov_iter *iter,
>         if (!iov_iter_count(iter))
>                 return 0;
>
> +       /*
> +        * F_SETFL and RWF_NOAPPEND can take append mode away from the us=
er
> +        * file. They checked its inode, not the backing one.
> +        */
> +       if ((file->f_flags & O_APPEND) && !(flags & IOCB_APPEND) &&
> +           IS_APPEND(file_inode(file)))
> +               return -EPERM;
> +
>         ret =3D file_remove_privs(iocb->ki_filp);
>         if (ret)
>                 return ret;
> @@ -309,6 +329,10 @@ ssize_t backing_file_splice_write(struct pipe_inode_=
info *pipe,
>         if (!out->f_op->splice_write)
>                 return -EINVAL;
>
> +       /* splice refuses a user file in append mode, so F_SETFL cleared =
it */
> +       if ((out->f_flags & O_APPEND) && IS_APPEND(file_inode(out)))
> +               return -EPERM;
> +
>         ret =3D file_remove_privs(iocb->ki_filp);
>         if (ret)
>                 return ret;
> @@ -338,6 +362,10 @@ int backing_file_mmap(struct file *file, struct vm_a=
rea_struct *vma,
>         if (!can_mmap_file(file))
>                 return -ENODEV;
>
> +       /* do_mmap() checked the inode of the user file */
> +       if ((vma->vm_flags & VM_SHARED) && IS_APPEND(file_inode(file)))
> +               return -EACCES;
> +
>         vma_set_file(vma, file);
>
>         scoped_with_creds(ctx->cred) {
>
> --
> 2.53.0
>
