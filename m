Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93A2EA171
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546018; cv=pass; b=jVWuACZKZJWUBvwepMcvY7c7w0GmYGLHUEzamD6QgkK2KYVLJRW8Psbu9Gn8aLXwSY8kir2Ul72Pz94GWwnNv8voCkzALsjGNv9ViwyfpAg59eMBNXVcdNa0daGw/WPz97CiM3hKWVqloUkdvRRMSdGEcrEJDqYJDELcjuRbORI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546018; c=relaxed/simple;
	bh=0G/yNPJ/1m7tr38GWnPb4fAzqTIlXjcfwr1M3ZYOz30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsmCdjRXGXZmQCEVTNkGzL5wBocvxm/nwny6T94B+I6s9z0nGUL6DxkkGF/XlAICIfiNVG+VCksO0lKPZLeVmuQUeoIR2swKoKsgEjt2Hd2qq7sD5oCaxLCPDOLQNtKNj7IUWOewp1N5aGoubXmJE37F3wDytdIdhf08Ce/airY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNvqOivS; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNvqOivS"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bef47b1ac01so508125966b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 10:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781546014; cv=none;
        d=google.com; s=arc-20240605;
        b=ICMm8u2VzVU3RVOI0SIBNFsnCh3HLve620iWGY6LC0BdZXETFzmA0MShLCWaCto5cm
         kzZnnxxCUtiseCrX7vbHiqzBB6WnLZrMaRqxz5j2XhcV86glBVggmcSOSyjV1TQUEClE
         rg7Bc65ntYFLGOOntxION+JaCXE1PDdxj8h3DCO2NJHJmnjVThfQEY6DZw7u7RtBEv6h
         ywMH6CFH4wiuKieHlbwie9138FGOtxgJORP7K32HW5J3ieP36V7wvBDNWvWXrfOfgy8f
         3EqMvOpjr6+fuD8g196od21gJPCpc8Q8ezEvGtU6Sgtq/QfXK6WxSLvJp9kEPmnO5gGY
         3b8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FvfUWdyRuyxa3u2z5Qy4nMVVFAzQcvrFkMSMc+Z8Zvo=;
        fh=aqPOAW/3KNK9t6box+DoFVfk3ng5Kt5dNsUPhtjdNfo=;
        b=HnW7R9ep1ca1cwkAn17RsDASXmsnFwosdf3KNw2rUm2ts2FPGajLkAJfK/NsFU8Ovy
         cP4qPNFqvxAPvQWvgKhXmpTTIw/c/dU0guXkuBc3E/b1oltg+WIesITZYguK4Tktnya+
         oUctqg0gw4mq7bcHbP1MBlaKM/Eejkqu+qjguuvtejcih7u5O2zA6Y8FAxHbC8D7DnAS
         1PcNwK5BRjS1TfNONTFuMRmIYVRRNsDGLE0jHwwDSHcVyFjEGIuCeOOX6+hbN62haz/9
         5UUOBRt5+o6k3TcP1pcQ+2ABKpkLib+vQDVPBsiszkuQwNi4eF8cGT6zBV1CRPEp8qan
         Xvdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781546014; x=1782150814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FvfUWdyRuyxa3u2z5Qy4nMVVFAzQcvrFkMSMc+Z8Zvo=;
        b=cNvqOivSTswmk0Fl+03k9zzGsI2y5E2HVNdj6LZ9AVD4UFSq6LA1gBj18rg3vLBeyl
         bRoY7miW/U+O3znHcWMYJLoNwAy6NGUitHRIn4+t/G6m7pN6fpnr1Tk6MLXRDQQZzUFF
         QB+xirZfLJ/SZkM9v3SqS4kDXoG+EO7cnIl56iIo1UIAqn34zYim7FlJiOW+5vhrVuBN
         VaKaip1O+DeheXjCXyowzunSOgj7DhqkY5EB+ewMnMJAGEhPG3ANPSpnRS+aM/ljvrR2
         FD+d7MM9cqfLftIAWsbXqW7SJ+/6IcHxKss7P0rd6mM9a+VF+lp7hCt1X2XykJzEYZiF
         pvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781546014; x=1782150814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FvfUWdyRuyxa3u2z5Qy4nMVVFAzQcvrFkMSMc+Z8Zvo=;
        b=SuzDmpgkpUX1QnsX41yy1FTnjkbyIj4D3ypTOvy9MHeUvmwsIvkuWcGsRZQtkD+VTx
         DZa0YPeaRDug7s3u2pXR+uow98IaULtdpx9StJPu1xMM0A0zHusOXCH+qRNSfUc+7y3V
         M5/k9tTAeZ1fbd9uKs8YWFWSB26ho3qDpY8/mxMII1gFZxleBfdmABSvUHOK+drRGeSn
         yMeHZTmy3bw01sZB7wqyVb3e4jC1SYbSO95+1i7ExekPNkvm9m1r8CWXBw3PcV9h5ixc
         d+/rmS4UpArnud4kBBoPVF4X2l1Yfuwwa2ibO6NHmjAEiluK9cAMm4hq8d1f+7c135vx
         jhnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9J+Xy82WD7qrKoOc8iP+WuRJQFJC8Hrhy3AAk/jx3RU9r3kR9NBqkrTJypUOT1pj88116dj49WzDkMfcLT@vger.kernel.org
X-Gm-Message-State: AOJu0YweKL6A9/QARy4/pULPUlrKTt7V6YBayoJbMCxmXFUSQE7GW44S
	mEFq3tgIv0O5NL3zIrPVwFHGAvBaRflLmEfvA234KWdz3/xBn8DpQvt5QdUu5L42AlLbQOzeSWS
	MJOX6lETA5dc4Nd4Dvb9emtnDp4gXfmc=
X-Gm-Gg: Acq92OE1lPtHDAUTGlpe8EdGOwBmxGBlbZfPpxgExsrvTSbbSk6Q5slDN6oUZMpnlLa
	RAcnYtdWxaav2PK6Tmv6y9MCfrBTi/rQm2MeJa+eeUTcpx1Y5QX6kTJCvf/AEo8Y2CJySj307ik
	XTl+vLks8dXJ/hOPJZypgD+EDXsxBRMUUH8BWt1aRFLM014m3sCNEBdZ+Yv5PN5XffLX7eFQHhB
	fzClNQzT4TfjJjZ9m8IShc88uZ/zZwe2uV2+MKOyhYrX4h2Y+I5NTu4o+eE+WgUMZRbTpBwiC3K
	i8ZgZoyP8Arm8yZyFG604n9Qj+0E6J2btCxLEti2lsu5BdykLAAm
X-Received: by 2002:a17:907:d005:b0:bfe:ed16:283e with SMTP id
 a640c23a62f3a-bfeed16390amr666725066b.50.1781546013838; Mon, 15 Jun 2026
 10:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-overlay-idmapped-vfstest-v1-0-c6b3b2228092@kernel.org> <20260615-overlay-idmapped-vfstest-v1-1-c6b3b2228092@kernel.org>
In-Reply-To: <20260615-overlay-idmapped-vfstest-v1-1-c6b3b2228092@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 15 Jun 2026 19:53:22 +0200
X-Gm-Features: AVVi8Ced8cu6caxj6v_YSBuVL33Q__2az4mLoJJiSj08lOxoClHvwU7me3e_C9I
Message-ID: <CAOQ4uxiG22xqx_C+539hbH5v4NHdALWBn9khpomtVxvQ0fcfFg@mail.gmail.com>
Subject: Re: [PATCH 1/2] src/vfs: probe O_TMPFILE support on the base mount in
 the idmapped tests
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Zorro Lang <zlang@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 5:33=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> openat_tmpfile_supported() in the idmapped mount tests probes O_TMPFILE
> on the idmapped mount (open_tree_fd) as the test's fsuid -- but that
> fsuid is not mapped by the idmapped mount under test, so it really asks
> "can this unmapped caller create a tmpfile through this idmap?" instead
> of "does the filesystem support O_TMPFILE?".
>
> On overlayfs this is a false negative: the backing tmpfile ends up owned
> by an unmapped id, overlayfs opens it with O_NOATIME and may_open()
> returns -EPERM, so the tmpfile sub-tests are wrongly skipped.
>
> O_TMPFILE support is a property of the filesystem, not of the idmapped
> mount or the caller's mapping. Probe info->t_dir1_fd, the base mount
> that the caller owns, exactly as the non-idmapped setgid tests already
> do. The probe then succeeds on every filesystem and the tmpfile
> sub-tests run as the mapped fsuid.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  src/vfs/idmapped-mounts.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index ed9992f9..8f8441c9 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -3838,7 +3838,7 @@ int tcore_setgid_create_idmapped(const struct vfste=
st_info *info)
>                 goto out;
>         }
>
> -       supported =3D openat_tmpfile_supported(open_tree_fd);
> +       supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>
>         pid =3D fork();
>         if (pid < 0) {
> @@ -4014,7 +4014,7 @@ int tcore_setgid_create_idmapped_in_userns(const st=
ruct vfstest_info *info)
>                 goto out;
>         }
>
> -       supported =3D openat_tmpfile_supported(open_tree_fd);
> +       supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>
>         pid =3D fork();
>         if (pid < 0) {
> @@ -7733,7 +7733,7 @@ static int setgid_create_umask_idmapped(const struc=
t vfstest_info *info)
>                 goto out;
>         }
>
> -       supported =3D openat_tmpfile_supported(open_tree_fd);
> +       supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>
>         pid =3D fork();
>         if (pid < 0) {
> @@ -7947,7 +7947,7 @@ static int setgid_create_umask_idmapped_in_userns(c=
onst struct vfstest_info *inf
>                 goto out;
>         }
>
> -       supported =3D openat_tmpfile_supported(open_tree_fd);
> +       supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>
>         /*
>          * Below we verify that setgid inheritance for a newly created fi=
le or
> @@ -8181,7 +8181,7 @@ static int setgid_create_acl_idmapped(const struct =
vfstest_info *info)
>                 goto out;
>         }
>
> -       supported =3D openat_tmpfile_supported(open_tree_fd);
> +       supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>
>         pid =3D fork();
>         if (pid < 0) {
> @@ -8536,7 +8536,7 @@ static int setgid_create_acl_idmapped_in_userns(con=
st struct vfstest_info *info)
>                 goto out;
>         }
>
> -       supported =3D openat_tmpfile_supported(open_tree_fd);
> +       supported =3D openat_tmpfile_supported(info->t_dir1_fd);
>
>         /*
>          * Below we verify that setgid inheritance for a newly created fi=
le or
>
> --
> 2.47.3
>
