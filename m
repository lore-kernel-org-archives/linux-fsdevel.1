Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812EE35CB9C
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236367; cv=pass; b=r95Y4eeaSlXJdrsT+65Me8FdSt9ne8VzQz3TpK4bZ1t0RiNvPiv0FOCRbafwEDX4BXW0DGnagO4yiq78/Sxf/9ZgBqUMDHtLofzmPYRJvUalJQrsHqvwKSDZcj9NF74n95BBtQjvrEv+qaqbU7v8OVgRZIYcGG2L9tqzPqvWuu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236367; c=relaxed/simple;
	bh=N9qRFu4WM8WnVsbLoreYprSqHgn/OjQDC6eflC7v4CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unxfUHki4ZbAqIN9+3EnrLGxsSUxFkDiolKqCAu6rd7/I0blHVm4mvcgwe96Yp4kD50bD7KBzlwB6+H9wn4+niEGwIZR/ED6fBKBRoRpiEfEe1EURPE4GxIzjpZJ8puQD3o9X0LZi5dZGMYdZjgUoJjJMHEncC+6Ww9I+M+EKHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nw+n33BA; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nw+n33BA"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a3efa2b38aso3953922a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 07:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787236362; cv=none;
        d=google.com; s=arc-20260327;
        b=L3E0frd1kqjLpwX1UclPQN3UKXhGfJFT6zbEunRA89VWMxBpMT1VfRF64XBbUUHWyu
         lYIHhIUR9elEiO2HVLJNpRYqciyjLnmcUHgpT0PyKtBNFxbvESN467PRHxLHdqS5oK7N
         29P3rDXu6Wp3eG2ctJFyO91l+wi+CytodsdFv5XTvQ24V+Zk70HJ13jTtMuxRISDcuKx
         GJXyjzafxMznssoE5pgjAFbYIpjMfhCwzmQIPM9mLq84j6oKWcrsPsHT+WoH4Kmh2FPy
         OhIEe4OAdqQAAnnOynKzr0R1R27xlDIev7fzeVn96szf0E7H/WKvHFAsn8HAqizJ0wi8
         wX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+3owqiMuWuSPH/bhodOVPPoGcMgRZTIUNdlO0mdLdRE=;
        fh=JU6PyVtEjPWQSBH0leQhS9XHfAGciX3qiyHKEgZrTFU=;
        b=JvqDNDVooABIPuMnlA3PUdD5hAKzpXPCDgEKYlvaEO0AbfABLhGUlsMhNX9zGdqdNA
         HFk7T1VuQpFFE4v3XkGrxU+m0IOnXvFG46NfqW+NHM78Cs/A2H7bQHxheu1s0stguvou
         NweD29lS6VWGpSB++Gn6yHf66grUef1HqFKVu42WiePiLFhudIdiH70dy2go1jOno1dP
         naa15niZXmBeyHsSXJgy0jt2OfSxepaQQpH7hdgcMi0zxwhIFyUonkV9fTGMd9zBlQTO
         xQ8L2o3X4lUbUbiQDIeapIn54hi337z/0Is03NM028Y6ZV7BdV2Xshty21/rChSFNS8H
         fLYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787236362; x=1787841162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3owqiMuWuSPH/bhodOVPPoGcMgRZTIUNdlO0mdLdRE=;
        b=nw+n33BAxcbmIcTtLDMF4ZP4rgK2HZx+JLkvY8W+XXy9dFsoyMwYFpmoBPEDNFMZ6f
         Cp5jaOBVvcgy57gZy7CrzLtxvwNrxDcfLRFci5SF2bCKyKy62EnHr9WAeI+A4k+pI4Kb
         dsx2WXVOuLLev6LUgXvDXYDlqGhVE3heP4kX6EczFQkuSsQVnYESpuJenh2O5UWfAwHF
         oPTmqZ/BqpiuI1n1oSHDqi82IxX130BjBnUdu/Yb1Mtse7nZehMc4EcxZhlN5j4EUkPJ
         9wW6U1nB1V0IuwHNG1Tu7ocSQX3QYXz07XVlrFMN1NK0vk7dKk+452gDHSXX4dujdU+x
         E9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236362; x=1787841162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3owqiMuWuSPH/bhodOVPPoGcMgRZTIUNdlO0mdLdRE=;
        b=V4iRTfJKk0qk04csIWsq3jlZfjqVEnHH5F8xboDVss2e4ZQMsJZ3FUUKPVz3wI0CMa
         GEMyFCOP8O07O86xsUGK3DS9qPjUvBRLCP5dXt2MgsYdBteHbPStXNnG/Vsha180TrYh
         GznXp3mlrtOQC8bLugZsug0pvx1m6MC58YGMV6zwmSlfKMaPkI6AifzG8mLSeoUj/XiW
         +5i2A8QrCMwvI9FyedJ7hiBT+l1dO7oVMQhP5OFq4Jjf1Wmdi/z3tk7YHLJAoJdB/7Rl
         yQs8AK6PFfjQrTuSZJc9fO7oSF45h7/JWTuu2Gd+7PfO0IMyGQcghpQsjIirBxDwEHRJ
         ANIA==
X-Forwarded-Encrypted: i=1; AHgh+RqdJBW/dB/EuUOngv/D3mtY7dOBhPOzaRPe/ZYdGV1vL44LRMnsHjEmVLbUnWIPsJFiF3Ev2+/SvwgSPad3@vger.kernel.org
X-Gm-Message-State: AFuF++nnogI+GwHMnXJSARGYxmaIOe1prQlzEpts8cpPr9Y32FKOyI60
	NBOf0nl1EWl19zRd0MwyCQ/HpdtjMZXKmqIswmPyyuTLVOEx7076qgJbZoZ0zsr3bnsvsdmBe5D
	qPLrpZuEukVWktRl94G8vWDOkZ+IKisg=
X-Gm-Gg: AR+sD11eNz7ATdtyR0yMzCm5+Z+7zxtBuB0Veu6oA9uVXDIbCyrj1Cs1lVf2UwhJDCg
	7FXVWclKgFotcbZH1ITsnv/IP/xCEImJS9k3zkuiA8OtQa3gSp2S/B6nyYpsF5CH5y+/bGauc6L
	draZuXHhmVWgWYrxFUvjcTMeV1l9Aqz+FJskkOSeccZGr1kaaaQ+jrVl+4AP3qu8VEJTaDFhkOT
	fZNQF7Hwy4cJcfzKJtJq7CKPZcBHzik48uQGmHYLfyHE7KRKAFMiVqGCBYjt5ch+RcDEN5eVm8+
	Pjv1PvJ2RsARLFK7KWTdKr/4BZtJzP1OBtB7rCq7w/XdjQ+FL9wZTW3w
X-Received: by 2002:a05:6402:454a:b0:699:728e:48c3 with SMTP id
 4fb4d7f45d1cf-6a4032fc5c5mr7757816a12.9.1787236361471; Thu, 20 Aug 2026
 07:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820061349.10542-1-kmehltretter@gmail.com>
In-Reply-To: <20260820061349.10542-1-kmehltretter@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Aug 2026 16:32:28 +0200
X-Gm-Features: AcwNN1XBsXitogIEUq0ntdJxL2LGIShvPphxQse83cuHfD_u0whlH1Af-ei3Mks
Message-ID: <CAOQ4uxhgMNvFxauLzm2PQif_D164+rJqmGdU5T+XDfhMJTVJnA@mail.gmail.com>
Subject: Re: [PATCH] selinux: preserve user SID across nested backing files
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 8:13=E2=80=AFAM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> SELinux saves the user file SID in a backing-file security blob so it
> remains available after mmap() replaces vma->vm_file with a backing file.
>
> For nested backing files (overlayfs over overlayfs, or FUSE passthrough
> backed by overlayfs), user_file may itself be a backing file.  Its
> fsec->sid is the SID of the mounter that opened it, rather than the user
> that opened the top-level file.  mprotect() then checks fd { use } agains=
t
> the mounter SID.  This can incorrectly deny access without a domain
> transition, or check the wrong target SID after one.
>
> Copy the saved user SID when user_file is a backing file.  Keep using the
> regular file SID for the first backing layer.
>
> With two nested overlayfs mounts and SELinux enforcing,
> mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
> mounter SID.  With this change, mprotect() succeeds.
>
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Tested on arm64 QEMU at fd6e2388a3ea with SELinux enforcing and two
> nested overlayfs mounts. The policy omitted only
> base_t -> mounter_t:fd { use } among the relevant cross-domain allows:
>
>   baseline: mprotect(PROT_READ) returned EACCES with that denial
>   patched:  mprotect(PROT_READ) succeeded; test exited 0
>
> This patch fixes SID propagation only. backing_file_user_path() still
> resolves to the middle layer for a nested mapping, so the audit path and
> inode do not correspond to uf_sid, and that layer's mounter is not
> re-checked. Preserving the full user path likely needs a VFS-side change,
> such as having backing_file_open() store file_user_path(user_file).
>
>  security/selinux/hooks.c          | 4 +++-
>  security/selinux/include/objsec.h | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1ead2eee1944..8b96934e9992 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3849,7 +3849,9 @@ static int selinux_backing_file_alloc(struct file *=
backing_file,
>         struct backing_file_security_struct *bfsec;
>
>         bfsec =3D selinux_backing_file(backing_file);
> -       bfsec->uf_sid =3D selinux_file(user_file)->sid;
> +       bfsec->uf_sid =3D (user_file->f_mode & FMODE_BACKING) ?
> +                               selinux_backing_file(user_file)->uf_sid :
> +                               selinux_file(user_file)->sid;
>
>         return 0;
>  }
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 3c0a16ec978b..853f7266ed18 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -87,7 +87,7 @@ struct file_security_struct {
>  };
>
>  struct backing_file_security_struct {
> -       u32 uf_sid; /* associated user file fsec->sid */
> +       u32 uf_sid; /* top-level user file fsec->sid */
>  };
>

Sigh, this is so confusing.

The fix looks correct to me but I would use a helper selinux_user_file() ak=
in
to file_user_path() instead of open coding the condition above.

Thanks,
Amir.
