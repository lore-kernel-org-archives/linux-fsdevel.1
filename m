Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794825152;
	b=iUze/QNs/Wbj8x5s3iIY7X1WQYqLpYPSzjgYvDEWijYry7OFtCC3Ep4RKBI/pv1j/+eC
	 1JLzxlcax/ThrGEc745zicMFQYS9woTF7CReqVG05BCxAbWFd3rcn6aUxsz5Xw8SIVmxm
	 tacgfI7ThdmrJ10Gvf0H9OsiA3ga1njdEfp6JdKdMYtwm3TODlUZZLYzDel3/vQRV3McQ
	 nR+qx05IiNMpmSN2yRFUk/smyiqpUjQpVDwFEu5PqKx8UIJGIxWNvKnji0qS3Dp218udp
	 epJTyOCXTLcgcDobYF2wdQ0ztXjUIbBL+p/hu9IUSt+q6w08JmsNPNuWs1zBUddLfZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0YW8PA+wzviZIV7gLvSi7w98vAeEHHR/1zk731Y72iw=;
	b=V8boDCpHj/wgK4TxpU3TSATIwy0HMKgkZ6TIk5U2J6jVgyC8waV6WxS21jv4ejKRRVqv
	 mB86HiX4Ewm+H+lbWNZ41FZpD4kngz1q47Qe9GgvWBqs0UAWSJg2jHbDqqBlYPBD26mPo
	 JF1gRbrJAc+rGaau/H6RE2w0SB/gXIYKCvatSWkbEh+CboeB0hK5HG9+QAHpj6FNor35Y
	 rlzmnsaXKZcP1a8gthMTFgW+XDO6ztuZLPCPvdII/iVdkf0++U50vbuBONrrrJpr/JkdO
	 uSZGaSMS/ETPzd7I6Pm3LpgCnqOeYC03RCB7W+gHSZ2GIKtPbijrEnhZBvDv65ehF+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vx02WRbu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E281606A329
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 10:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E281606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vx02WRbu
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so5463385a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 02:32:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794825150; cv=none;
        d=google.com; s=arc-20260327;
        b=XIE2of0vMsXDr3QsNRLt2b4qY/kU1gIGI0UiqkKmKH1iSaCQVt4+M2Lqt69SHQ/qM+
         fz6kmqEN+rEs+pV6cjoTAo0tykF+afMjHzCvLbgaKbzirUxosBu7ISSYZUkyRaRGcv/0
         Oi5CCZrTj0v9180nczLwG1S1bUlXEyy7UbksLgPWy3SXLSP7eUHuNvRAm85RmClgjTYh
         su1Yv8EMPhAZdnuE6clmOVffuVhKy8yonq1TmKWTefzCltNw1XdH4hmjsRIHGqEXBQgv
         p3I21aYCdmvTqiT5wxbx0i7lAz6WooR5JZlsANTc/Rk6UI6VcqNl+Hm90Z3jncXdplPm
         QyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0YW8PA+wzviZIV7gLvSi7w98vAeEHHR/1zk731Y72iw=;
        fh=NV4yUpBF7bDCCsgppxM0HuHnVRvhVk/cSmx1vSg/JSI=;
        b=RtRUzWbbHSp098tQOcJNpQHhJDfGaS6pFqvfd/syTHKaBCz7RxwXxN7rGpfvg2HqvM
         zCOMGFTD5UQUxLKRKM280AfqC0Iyj2YYNcQmUacpIGP1GXf906GVg8imayMxWJs/hsQw
         +AXIQFe3pQp7L4tdFtOLgI8C0WSv841y5lTBEfbLamQAN0UBx7F9olCsZjZA09MhdGuC
         QAnHhgOPqFXTMD0GRgFk/wm0fYK888008/5sMHnFaC9SCC0/0iKbiXhrD5p0iYwI72cX
         R06+rVO0e19F2bnyEKFCwKoETj1esUn3wNvKeRAoAARAfXyXxni1Z/SuwPeIczhXDrSV
         DCxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794825150; x=1795429950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0YW8PA+wzviZIV7gLvSi7w98vAeEHHR/1zk731Y72iw=;
        b=vx02WRbuy3m6IuoTmZLjbXEH1SVf/+s2e5NYMP8zLIkFB7TDuM6FN77vlgdxymLlm7
         7GxcqalTg78KplnStO5kUr72C32hXL+t09BYxJ8ovOh5oqhyNx4iSVbeNwcBqRTR9yS5
         cBqGMAsFjR3s+grQoLxemWsbgtL2IkczGUUizL9DjmxiUAGGEWoZgF4vC4xcKDDWry10
         Em0NZ93TUoj4HGlvAS+ffvhR4v9we+WvcUTf9usRaSJNiE2Qk+VB4XlDBb5gX62pUHEj
         vtUOTc/E1vyTbCYb2PH0vA6MlhPqaCmjuVELDgD5prTge3q2muHag2AnKU0420jXFrPG
         MniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825150; x=1795429950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0YW8PA+wzviZIV7gLvSi7w98vAeEHHR/1zk731Y72iw=;
        b=jJQ9zOgwAjgP/OMtU6N59qhVhyE5KdF+xl0EQXsn8mcpuJ6jLPfmEWGqIU6UDth69p
         HPEMeM1wbKZRXjvxvwnDnicoFdMhxb4vZOBhl0eTKCmALRWAQKuLvSoXV+6ZtBFYlIQQ
         2+OLNEPvJNjO6jtoWPGe4sFPyO6Kd6vOKPW+EhNHcjf6fd7geRUyLUWQmISoFekXKjcU
         uQBb4k6kZN9oO8Fag1ny1TB+MEWkSC0SEi8YkZx5sz5WJmqdryClb2rH6sRkbhkJKVPa
         A/7gnYxUkDlfoRKO9sxpR2htoQOlfvFUBTjU7Te5U4FDdlptz6MeOLhCUzc33pCZB3F7
         sIDw==
X-Forwarded-Encrypted: i=1; AL+hErFsdWi+8hVETz/NzqySGgF2t2Pjr/2d9aO983v42C3LUCeuc7AXhqw5LCqR+/BVaCrLTx4/sr8W4PtIQoMO@vger.kernel.org
X-Gm-Message-State: APuU4Z/oXiD9OOFQsZoSd4YjeDOelLPfBtGzbUfAPBpxMmAiPVsSptk9
	C8D+RpbJJ0oq6ywgR3fEQFixCwMkaYBTIEm+nQzVuXolKImHDbg4K0F2dCvc2jk/DOI0utrzM4J
	2tPR/vTUpj03/LTQy6Yn8J5dJWxKuVbhrayICjAM=
X-Gm-Gg: AYBFou16cWPCAUbOe+25y5ie9RFXqNV+eBytumOTIhP6f+l+okepNDa9gxcNREzj9ud
	Cpirf3OCy/z2v0f6QjgWpWdIkTpbFx3FkBtRDLJJ9SeMmiDcr3aVWQaK2/YMtT5IRK4Zag7txQE
	/JrTR4Ntl4mluXc7j6/nO0i9gfRL4FM24NEeaO/lqsTQZEaGRNBS1wRYcpfnt+qMZYgHmXy7YCo
	68rFMTZCor3xC20xKlcL//AlvkqHv/uYj+FqUYlnbVi9OyouF3LFzuErR/xtp73QVmRSrvpVlL9
	yKlGHZe/jJK5QekPyg9J6halckfucpRhIm/iM5WUTAsnX5WcIkp1rYb1fk7VOh/CoVJUGUTg7eI
	SbF7ksyv3kmlzajmFw7hJ1RwtiE+G2qwK2Hst5KtJ0z1yZCf9FFcT4zIJmwiMVXtyULEzIg==
X-Received: by 2002:a05:6402:a514:10b0:6ac:9a44:d3ed with SMTP id
 4fb4d7f45d1cf-6b7c08954bbmr4966094a12.5.1794825149341; Mon, 16 Nov 2026
 02:32:29 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com> <20261115210952.2140036-3-graypanda.inzag@gmail.com>
In-Reply-To: <20261115210952.2140036-3-graypanda.inzag@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 11:32:17 +0100
X-Gm-Features: AclHuK8XXyhaCAgxTbITMp8zV3Fd6NqncgeiQCT2joxj7Z8uLLH7t09QB68vJSg
Message-ID: <CAOQ4uxhR=ERNBYsxQ06-sKGrTXvePpzv-xi+62oceNff6Mzzbw@mail.gmail.com>
Subject: Re: [PATCH 2/3] inotify: zero-pad event names after an embedded NUL
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:10=E2=80=AFPM Junyoung Jang
<graypanda.inzag@gmail.com> wrote:
>
> inotify_handle_inode_event() allocates the variable-length event with
> kmalloc() without zeroing the name buffer, sets event->name_len to
> name->len, and copies name->name with strscpy().
>
> If a dentry qstr contains an embedded NUL byte (for example, via a
> crafted FUSE READDIRPLUS entry aliasing an open directory), strscpy()
> stops at the first NUL while event->name_len still covers the trailing
> bytes. copy_event_to_user() then copies event->name_len bytes to
> userspace, leaking uninitialized slab memory from the tail of the
> event allocation.
>
> This mismatch dates back to
> commit ce163918cd33 ("inotify_handle_event(): don't bother with strlen()"=
),
> which replaced strlen(file_name->name) with file_name->len, and remained
> in commit b8f2688258f8 ("inotify: Use strscpy() for event->name copies").
>
> Switch to strscpy_pad() so any trailing bytes up to event->name_len + 1
> are zeroed.
>
> Fixes: ce163918cd33 ("inotify_handle_event(): don't bother with strlen()"=
)
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
> ---
>  fs/notify/inotify/inotify_fsnotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/ino=
tify_fsnotify.c
> index 6e3af6452dcc..78eb1e92a14c 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -121,7 +121,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *=
inode_mark, u32 mask,
>         event->sync_cookie =3D cookie;
>         event->name_len =3D len;
>         if (len)
> -               strscpy(event->name, name->name, event->name_len + 1);
> +               strscpy_pad(event->name, name->name, event->name_len + 1)=
;
>

I am not sure it is inotify/fanotify responsibility to hide awkward names
which filesystem emits.

First of all, I think the solution should be consistent with d_path(), so m=
emcpy
instead of strcpy here may be enough to avoid leaking uninit memory.

If we want to be nicer to userspace, then we could for example pad the
garbage bytes with "???" for here and for d_path(), but I don't think
this is worth the effort and also don't think that hiding the fs flaky name
with strscpy_pad() is the best way to go.

Thanks,
Amir.
