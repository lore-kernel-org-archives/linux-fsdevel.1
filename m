Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206BE41F35A
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2026 03:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788234615; cv=pass; b=F6qskNw0AzvOX9Yqe3h18AEJ1xrYNB/E99+2S1fHjygueM6exUJGJ8KLebsuCoVjfHBShgQFAtkRFSh/LVXBJ3+m54B1BRPazrARP7/31PQhMy2wyPpZ88d6D7NTDWf9azwcDJyFxs2Iel/JM7OwgVjwc54/N9+zFpVoDJEqwqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788234615; c=relaxed/simple;
	bh=7FzqKOy31dFK2JByQDOuvX61eLKgIqvkGkZe4Vjl9BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aG2xp3oFZSh024u1Tmnnbqlec1X4v+FFtY7ekszPnTjM7hgvbgOxm0zmzqYXeb8UdiG6jkVk5rJtxusXm5hWneLv8nQPQ4/e4quOTgb9YL0S/kbtRWSlwJQJJCcDLEWyJuTGCitOtq4DeecvI3ffOR8XY87ZH/06MyyNIEYFsq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXi60cKZ; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXi60cKZ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66bd7857841so629864d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 20:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788234613; cv=none;
        d=google.com; s=arc-20260327;
        b=hlMouHNaw1nL6XJg+4FK+9dZGupAfi6Sy86Tm11JbG3yyntHj2RouPYe4AeYnF17Zg
         uxjDwgGFBcsvCMJepjLiBB9Z528sqZ4QSFGu5gkt+R46k4CWQSn90QRXFeKk7IdVzyPw
         ++p+nCSOmAlHkEQ1ZcffB2PUif/X38jwNRjRlZwteRMqC884DdE13FUqt/j3+hP1fdfU
         ogaliC9V1HhnQCZd8tsO5f/+v7YSnWSVUB5fC9NHTHg9DmK3/cAEydq8jrpMX4uEGUGA
         U/ksnnvgv5ttjmkG+5mwM0MVOPinwFNQyyFPpCNyaXGG8KDzO1gH2RMDiWSntYdXhgnU
         KrFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oS+YgxWiYLpVEf2e6Auv3kRGzGPNIEMUh3WyA4TvRpc=;
        fh=2UFpC84tFOVVaU2OY77j/w/Yyjum8W2zgp7goVvhoAc=;
        b=QnK5jDkaMNr7kHGafJSMXCuyZDhZP7tkmAprcOPUf5eKEsnFvlPJzw9Sgrj+rQpskg
         ymwzRbVNkFUOMCXlBe27z6gWons+ni2vV6nF94cuN/3oCkuGfAUI/I1/UmlJ49tfv1Um
         qHJ8jq9pJM1WjWjHXcanbWAIljOcOWOAXxcQQ01BJ8srOXxPIW1dp7xYwjxHrQFevxG6
         f+cJTpjbNTARrjtQn6kROw+XKTmgO+nJsrgeIGypeHEsWmtVsmxxBsHg1ZfdbWQHNH6F
         1kL4oG+N/RMxJ7YojSF1MaUUoDaWIjQX049CnwMLZf7i6QX/4VDzm5bFDBqkbdhi+xsT
         5gnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788234613; x=1788839413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oS+YgxWiYLpVEf2e6Auv3kRGzGPNIEMUh3WyA4TvRpc=;
        b=VXi60cKZ6KLoOfpQas1D1MZa9jydnFHL089jOajoV5u2rImq27zhvC85UYKe7utpYr
         mXXetnAJBtv/HXu8QQ6u4fwetu+DK6jsBqf0CFNew/kEw/xNNP9f/nNy/JLfNwcNg/5z
         Fs+A0t7BvqIIyyMIeMltoF4wOzuFEpwP9AD43p0ag6C4YXgRnCAyo0v1j7hbHkRbbjWp
         nCOaeW1CuBJ05066zK5BL2xwJYbO2hGcKcDPCHr3fl8CwMeyDYKsPWnaalQmUXqOj015
         rCAHxNebnhHekcZPaQ8CJH4WIiS66ZvBQ+WwigePSyp87+r7rt9LkhhAM6Wleplg+nSU
         7q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788234613; x=1788839413;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oS+YgxWiYLpVEf2e6Auv3kRGzGPNIEMUh3WyA4TvRpc=;
        b=O55syhR0scmQspd1o/BFRJC/RN0Ov1aDLz0QPIuSwblT69sKw9nY+Xt+W4SSKCsjds
         UzmLZoaYRZErPVVbwCb9+oKiTNMLWtwI6EzqElrfjNA8Up805B0M8yR3QmZeXFZibjTR
         sR3isN/+q4/sgcZhoLnNsN6g7rYCSHjV1B+xqag8kGdJB//e65Uk+ViH09q6Qby3Dx+c
         c5GwZ5BrhFWuqelDG2uWp8NnZ4PwQr4NZU13GyLWQm56aHnrwanfx8B52r42Mbwdf+e3
         Q08vIvJWQiietTtj2mfxfi9oPVNsXHMVaLRtbP34tUfd4GkgSA+iXosBSSSq9wTtuncv
         d9zg==
X-Forwarded-Encrypted: i=1; AKwUvBxydnMQzT3Hc/ZLl4ufoTIGrKXau9oL6lDatAYUmH0ADfo+0jWWL+J42fzVwevlLmCJEdrtv+nG3QRrPfYE@vger.kernel.org
X-Gm-Message-State: AFuF++nMR2TThAUv4N2p9NrF+erWEgp4cX+Ybgz9TOtOpx0VVHkKM86Y
	HUrUc9LLDiJd/8KhjGLhdxZU7sJkR92oHbpyy5EZaepK0KJmLxWeRkkQGWqJ9s6CD1UicY/Q0wu
	RS6oUlkJ6oQzShdnjCtMrYFNoOpiKK20=
X-Gm-Gg: AYBFou35fsyibLNNhJ2AI2zf4bCP4YQ8WE4Xu1yId8xVZdtFI+iXAyulm7+tb7dHCqF
	814FqsnaNoihJ7uwwm0vwpwCJN+CnfIUsgW3yPFM2+Uy1h6Up6mjmHSV7bXazKZGgLR9eBc2KvL
	GNEmfYiW1wffhmJdmXOaah3jL9KSfftCxAFf9e6CWtpPJ1fEXoRP3r+hBOAg80+udJ8VP1chvQd
	eOiUgmYkC0CgtdS1AnB2Qalxo6WDnEmjS6pPMyH3m0LItcnaiPwyZUkQxZ8nhWy7IkX/rpiOmtu
	aPWZm52+H9zwj7BqJH5mmmYVtQ/unqidaJkHBVLvko9aJeQ3MozafLPTatiBalIFDTBjEd9VbUL
	Thns4b4ezR7Sty0n5+VFQCfM=
X-Received: by 2002:a05:690e:4888:20b0:66c:71a4:6ef7 with SMTP id
 956f58d0204a3-66e4c76ec48mr7226022d50.35.1788234612985; Mon, 31 Aug 2026
 20:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com> <20260831092305.42062-7-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260831092305.42062-7-tasos.papagiannnis@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Tue, 1 Sep 2026 11:50:08 +0800
X-Gm-Features: AcwNN1U-TrFQ78uGmPSlh5DKr82QMmwSDUwbspb3nZbsW6N1XhgnhGW6LFmWno4
Message-ID: <CABFUUZEwY7B0VOvhbhieHXHuvms4dx_GO3gw99vL1zk8q+ESTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf: Mark linux_binprm->mm as trusted-or-null
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	akpm@linux-foundation.org, david@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	kpsingh@kernel.org, matt@bobrowski.net, song@kernel.org, 
	utilityemal77@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 5:28=E2=80=AFPM Anastasios Papagiannis
<tasos.papagiannnis@gmail.com> wrote:
>
> Mark linux_binprm->mm as a trusted-or-null nested pointer so BPF programs
> can pass it to kfuncs after a NULL check. The linux_binprm owns this mm
> throughout the bprm_check_security hook and clears the pointer only after
> exec_mmap() installs the new address space.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 386401fe051d..584c79326b9c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5958,6 +5958,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
>         struct inode *d_inode;
>  };
>
> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
> +       struct mm_struct *mm;
> +};
> +
>  BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
>         struct sock *sk;
>  };
> @@ -6012,6 +6016,7 @@ static bool type_is_trusted_or_null(struct bpf_veri=
fier_env *env,
>  {
>         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
> +       BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm))=
;
>         BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct=
));
>
>         return btf_nested_type_is_trusted(&env->log, reg, field_name, btf=
_id,
> --
> 2.55.0
>
>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
