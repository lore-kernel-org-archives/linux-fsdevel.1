Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088D368941
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776724695; cv=pass; b=fCy66WFkL0gtbcHDKeLYEQeSUjCJuClXwFp6ba6QkfuMGKmdkk9gZt035Lz19iz4zmO0etYzTSxZTpP/ox7Oa5UV10K4F+Vi7oGdOT9xhh6zljK0YgudKQg19Wtl3RvcYbkjtN77AcRqAaVTTvL6yPVXIdu6xR+zhMxKNk5C3xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776724695; c=relaxed/simple;
	bh=YYnx4sLb80ijbJvn4zw1kvIKkR66X6GsZ/8Q1oe/0mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHYtZVsuKV/6zDPBafY7AMsrR7jJ261dAl1NWs5DLl/o9bwG/EQ5plUnZnWF2rzOhXh9xtsOHHATtWTt9BEQB0Jpm2AKxtEFIVvKUyzSx8m+y3oIxYgfmPDOglL+qganlUWlM+DgwSyVVYjH1fYMOTu7xZBuWHOG4X7FRCLuS+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TExtJIby; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TExtJIby"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d572f7437so2402527f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 15:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776724693; cv=none;
        d=google.com; s=arc-20240605;
        b=J0/c/6QaNDe1PQW8ue4qhErkvzINZdhQ+IKouYGCwqEVParCzzSQmOcd5erLr+eRXE
         VboyOuEG90bEE3tGe95ziXzxvAGX9f9NzAXsNR6xvcNcOdQ13uGNF5RZL0oVqCCvwrKC
         Rr1D6ZFv1iOWfhAB23dcFfJQqJb3vR0/d/AhQ4s1G2dP5rLPl3WunsiliKAMPdSOhAYl
         OC18Eq8FnDsBbb//gVUniT0NU5cs1GFV1ZoIP7JwFNfP/n91iFcvse6KQqgKwWUQJUeF
         vRMP8V+wJmgxdHkwjEi4zW4F/ZChpCZ9slb3TmVRrN0zC4VmOR/f9OOINtYxdTCRm3nf
         fp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SmgtPItFh6D0b+UMMxDZMWg4v0bUjrs6A7Q0+zWSGEk=;
        fh=WdTKjCjBc1VF/6/aHCD+P2Slu7ckD0XreUGwpHlzlTM=;
        b=IOAmhDgVsmc3zEeTTR0mDIoAr4krvzZ1UtsoVDL9X0NtDi58vEx/vkKumcjMFZo++B
         NmZKj0Za4C4UvsNn37hMb8E9JXpy0MKkyV7DcJuckCOEOVVW874bnfHOA2eCvguyoZ5C
         E49+tuXECkxYrhEoQKOr3i+VgLUWtYGTeROFDr6qcWxj8GOQ2q7QEk78zSEh4lnV9qFm
         wxTFMPmdQgE0oWxlwKZqgMgg8DibhXSO9YnU6yWvCST98+NkRuSMmRvpfsENrGkinioi
         67oSPDoH27DaiukZUFdBPnSDdmPhMtswqrRM8d3iIDSiGhwOJsX1iSZM3PqTEr9kL5+t
         TmnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776724693; x=1777329493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmgtPItFh6D0b+UMMxDZMWg4v0bUjrs6A7Q0+zWSGEk=;
        b=TExtJIbyTWf5YlrZ6DAv+w8B5Y0bbghdVcIYJYL2cZKqJDEKTjs02j0moTNBQaWBUa
         txaakjw5Ra9Z+yf3zy/k9t5uc4JsRAhDZHjuFtZA3KahuzLXgEv0rLMz8dBcIlIbtaeo
         Wg9fNQnWNfVtdOuoOxrUw2kWNhRBAgtl9v1A/rpUbfsEyg7klDbLurSw+7vHWWmiTUm7
         f5gvoO5bxrcng4uisqDkVcFGFKWHemQxlQ+QkAUJjyOLUWQCJ7ov4QCcYXHYdULso8Da
         27TVeXds2NPembcbctSGXmHyb8Z1upnp4ldGQp/34Q7JIlVQTrW7uOg745sMUEcfX+Mm
         gZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776724693; x=1777329493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SmgtPItFh6D0b+UMMxDZMWg4v0bUjrs6A7Q0+zWSGEk=;
        b=caiTfZOdmfD01N8CKYTWV0iU0CYaGGY8su8FgII4q2XpmTd2RsrrYHVowfwy5G6LFh
         f3Y9H+RLX1LOJGscf4B4gxQvFW6HzaNNJ5CGjeOogU7F/IyDxy6mnsAH36bLLngvT7Jb
         BoUXg0W283GuqR8fN817A/IgMxiXhF3K//jO93JEvBa9YwmQ2NUBoh2ctkjLzfuJ7EF+
         GcYRDYt3zm02NcJTyyFLOQh+O5CSGdS9vQW7vc399Ky7xoNcLYpZBILL7QTmYJ94ESO8
         zFYknyYo1bAwN9Tl4OlI3Pn17+oEOXFzYIsyXElNeDG36+7U1Kv9l8iqt+TNhhi3aqVk
         2nEA==
X-Forwarded-Encrypted: i=1; AFNElJ+obK+KaP67RQ4FB+czncp53bQ59ZGlpn5ckKnwEPAAgVohF+HirDUWn9Z5au4RdLj8MkjaRH9FM+YBAvR4@vger.kernel.org
X-Gm-Message-State: AOJu0YzIi6PfYDL2d8S1rsT+MUfzUNpMQ/tDFNWNizzcl9aWh+/B3Cb7
	jpEFTdBS9pBTbmGXV0nS7m5X+t26TxeKMtv45LaE3mfPQFWLAsa3Ri1u2/X4TnupK8NN6i3xlNs
	A0UxsoAOCakLP3IEH+TyRYUsuCE3I4rA=
X-Gm-Gg: AeBDietTmBiP1B8booOtRB30266rBiNgnyurJKBxMp9A88mzUZ/BkF8KMCcB2Nhj3mT
	omlnQMvUT7wRMvOy1R6Nv1eOjwvUOZAG1fZAicPSJC0+QhXR9eAaOaAAVYV9amAt0lNvDR2Pea8
	1sJJi/2za016wyq5B9L7BE1vVZaWjx/XafikiC1yCaM61oIAJHJAOTmOrSru2Cio8p7njRw6Yms
	p/yDA+9c8IRBXHXgSeZq5NuUSsyamIadBoGp16R4CBJOM/ZK/k1YeFdfepDJiDDbLJmpNN+2I+Q
	AqYcpYSKMiXOGmoX
X-Received: by 2002:a05:6000:22c5:b0:43d:4b00:9ee7 with SMTP id
 ffacd0b85a97d-43fe3e10b0dmr23222864f8f.33.1776724692579; Mon, 20 Apr 2026
 15:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420030900.4944-1-liwang@kylinos.cn>
In-Reply-To: <20260420030900.4944-1-liwang@kylinos.cn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 20 Apr 2026 15:38:01 -0700
X-Gm-Features: AQROBzD3TedLIDAn5Xv_Snwtnfw9_YKt0AWjQwgcDvmWeyfNucVMV38iDU0YLGk
Message-ID: <CAJnrk1bo4U0rzDXP-per8KLy=XgWg0GMdX9q_oTFA3BxcguD_g@mail.gmail.com>
Subject: Re: [PATCH] fuse: drop redundant check in fuse_sync_bucket_alloc()
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 8:10=E2=80=AFPM Li Wang <liwang@kylinos.cn> wrote:
>
> kzalloc_obj with __GFP_NOFAIL is documented to never return failure,
> and checking for NULL is redundant (__GFP_NOFAIL in gfp_types.h).
> Besides, its caller fuse_sync_fs_writes() uses it without a
> NULL check (atomic_inc on new_bucket, rcu_assign_pointer).
> fuse_fill_super_common() passes fuse_sync_bucket_alloc() directly to
> rcu_assign_pointer() without NULL check either.

Sorry to be pedantic, but imo the commit message would be better if
you dropped these last 2 sentences - the way it's phrased reads as if
the callers not checking for null is a reason to drop the check. Your
first sentence is the complete justification for the patch.

>
> Signed-off-by: Li Wang <liwang@kylinos.cn>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

btw just as a sidenote, as per this post by Amir [1], there is now a
transition where fuse patches should be sent to the
fuse-devel@lists.linux.dev list

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260419113529.1523179-1-amir73il=
@gmail.com/

> ---
>  fs/fuse/inode.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 33009227e91d..e5069d2f8e90 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -676,11 +676,9 @@ static struct fuse_sync_bucket *fuse_sync_bucket_all=
oc(void)
>         struct fuse_sync_bucket *bucket;
>
>         bucket =3D kzalloc_obj(*bucket, GFP_KERNEL | __GFP_NOFAIL);
> -       if (bucket) {
> -               init_waitqueue_head(&bucket->waitq);
> -               /* Initial active count */
> -               atomic_set(&bucket->count, 1);
> -       }
> +       init_waitqueue_head(&bucket->waitq);
> +       /* Initial active count */
> +       atomic_set(&bucket->count, 1);
>         return bucket;
>  }
>
> --
> 2.34.1
>
