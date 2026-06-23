Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC57388E5B
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234755; cv=pass; b=qMdHmw+schdSxOULAMF/lkyOj7xPi5h9AVU95NEDMTlXPBt5nDK1y2feMVGMKUCZGyAvefjraeebV+FPNCVuXcc+oJI+XFgLwBRdLLmaJVAogKLnFfsQPt7anzjfQ1Pdf7ezq1w0KLaFAZUx2XxiL9lS9pd3CJGzJr7x9tJNyyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234755; c=relaxed/simple;
	bh=hmR9D8Br+YBjZG2zebbyzPQBf1lj2xBVoaEGicS5Dc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQ1M8Mta9BZj/CanFNmeEYKXLtZT11OvOdi6wByjyqSAHUFvz4MnTvToI/pnMr2+v0qjJXVjjXasrI2I5LWGubxbCpoxMa8WymRd/9hwE9e7ycXJegKMbnlKWl24u+kAws2U6o73dDULMADN02af9jHom/xvBiyatypEetoq7cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIInnUlR; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIInnUlR"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-463f1165e16so166744f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 10:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782234753; cv=none;
        d=google.com; s=arc-20240605;
        b=UUstmMRBDfJdgFna5lYWMKdhH2vNeE3Ybq7HP19f4ZP+1UFREvbXg+NiBpwdDM9AmR
         i/cFvn/VTX6RdXqnfcvmkGlmzDuIMPW5cI3Eg1WxSW8frB8/VR0oEEm+Lay+9QxLea3I
         Zd8zQ2PHzfy0SCDsEPyL7wFuKbp0VFN/9BNTG9WfscMQ7w++gYPFNr16YZDYbcG+oHDL
         o/r8igwCANCbrriDkzloyXLECgNwVZ8SbHxu2a53V6rL8HJVf+WoklvjmsxUKjzzmsx1
         c9MYWJJmM06sW6g7QLJdFwn43rkKTOOuKre65aIUDiw5bHoLv+Q9sAxpmxkETylj1zZS
         IQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GQis8KO7+Cr37wQe2wy0qBtYljKSNFAIw/U+lZxu9Bk=;
        fh=c2X1Co0MBnW/8ycFUKn1BK1Irw5iAITAfes40up0HIo=;
        b=K7eQa1PeWTsSBHAQJB/3OTJgLdPn6h9CbolUYwb0xjeNOXqT3VC02gdcOLKlTK8q0d
         T8AEzB83/lhRsekIQdot80iS+JivtLB464GDog+lZov7dwbYhdIbYb5bX8TP1a0SRIa3
         XR/PXDOqfiQ1/uOcrb5zOivHETUYtjwFoPZ1Kr+hp3oMKNmRcDtIs4+wJ9scei9xt54N
         kBBjO2+d5ouohPSRkXkSHDjbjp56dhgxPEox1JSDUX837JWZihIzQAfAN59tEiYUXsch
         bQ48VXuSAgPSX8kk9WyC4eDoPMfRcT8lZRou2IJ0CeX2HBX8agV2U38olmRgqjTZVSM9
         vWzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782234753; x=1782839553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQis8KO7+Cr37wQe2wy0qBtYljKSNFAIw/U+lZxu9Bk=;
        b=ZIInnUlRpJBrBLa4YHmK1T/YeHww3CriuYJ+s05YmBTe9hKCb9ZRskiq3iOgtmPzFd
         BO5+sawX5DP/dYIkp48lyGPGLZuMlU2B5ExSz6tAaPXbflRW58jxxcbYBY3wy3+6VUHy
         BuAv1K2BT2xt+XlBgLMoXmDB+Us7uSmvTTxbrDRRhv5nnWvjCsyd7yvFRxohrkF6M/PU
         KImC9eeyFb9l/9wbKy3v/jFfZV5c0b6MFsfYsy5jWI5o1kvtNzCAVMMBR2X7c28sWRoh
         KkRWX0jEeHOEQo/qs3fbGUlQTtm0uuWVbu/2igo1pXV7K+rMeUPCowk4apnjv5mQ8zxO
         ocmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782234753; x=1782839553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQis8KO7+Cr37wQe2wy0qBtYljKSNFAIw/U+lZxu9Bk=;
        b=GWkuZrX3xPdTyjWSnYhzHl5GT01dDtukikK3orjXImZ3It8CfWlMoqQTgA99Fa63Su
         tHyVuzRyNMwUfoV7QsB1/Y+INLcz01Jj6Ox9k1V5R59TztuygQYAWb45SDy9TJn6ND36
         0dmbqh31xzqxnPxNWz4ubxCx2WgIHlMbp7JbFXdimHiZKYqqUoCSNi/H68YuFwG0vF14
         KDeANZJemcYhxBSzNDPIjGchQN/Q4SI5CKQj9u8BY4A4JitgGMHhqLRk/qzRSuZF7HYO
         f7O5kkjAF7RkVSxneMRCYQjICzK+dWy2Aj0xMKsMaGzCFMJdrA4mDxGf9NEwaEHzeV14
         /vRw==
X-Forwarded-Encrypted: i=1; AHgh+RrDY/bhH70LCDCR38NwwcS1WQFcP+LHSSiyOPRARpwbQrqQVg8lpdKoC0/8ikHMcyOMH1+EQ8btF9UcPuRB@vger.kernel.org
X-Gm-Message-State: AOJu0YyjdU7YUpPpD8/7k7kmPUoNhF5Vu9/z3UYzRHYc+d6NEN66Z+3b
	cnIoTNvumyKc885EdEOU1f20kehqrcKQAJYTwfZa7prq9u6Xz5B/0RF84VVvKd3H6wL9Q9eMoWt
	7zCAxHocanxPmKUUpvFr5oh1NfbSItgs=
X-Gm-Gg: AfdE7cnHDSNcsWU6Ao9o2BTUrGWdsEyN5EWDFVs2WT0nTwA1R5eTK8tq90RliOt0qkD
	h01T/QEMsHxTRvMakDUBGbzS7QVjD44NL2IqVXqBBccKyfzkgn1xaqzx9MGB2j+3t/nevmkNZzr
	NnTfdkPY2GrSQu26NQOpOsFgGN19ZaG+NqRje7oe5VBNUBoWLM9VhoXQDBQnWeAwHD/rd6c2DkR
	rpqgwi6KdaweTrgi7DsM8BtV26Z0rTvolpfQe+FLnml3M2rMRNOACxmhzBZmhDGWkTlwX45iHLA
	qsrJGQs7cfx2nvSLOiYrldByoEq16AhYPFh7QEw=
X-Received: by 2002:adf:f182:0:b0:460:6b0e:a75e with SMTP id
 ffacd0b85a97d-46506c35d0cmr25528866f8f.16.1782234752678; Tue, 23 Jun 2026
 10:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623111533.2285005-1-ptikhomirov@virtuozzo.com> <20260623111533.2285005-3-ptikhomirov@virtuozzo.com>
In-Reply-To: <20260623111533.2285005-3-ptikhomirov@virtuozzo.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 23 Jun 2026 10:12:20 -0700
X-Gm-Features: AVVi8CdfcxG5r5FMFto7l_ai_RfkpnO9NQCVALwgDokVA4D7LTvynw9skPuPn8c
Message-ID: <CAKEwX=OaKTfNqzwa=djLxZDeBbR1+DKdqDnxdfPfZFKB-K+ECA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ovl: support cachestat() syscall on overlayfs files
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 4:15=E2=80=AFAM Pavel Tikhomirov
<ptikhomirov@virtuozzo.com> wrote:
>
> Overlayfs forwards data I/O to the real (upper/lower) file, so the page
> cache lives in the real inode's mapping and cachestat() on an overlay
> fd returned all zeroes.
>
> Implement the ->cachestat() file operation by forwarding to the real
> file via vfs_cachestat(), the same way ovl_fadvise() forwards
> for fadvise.
>
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
>  fs/overlayfs/file.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 27cc07738f33b..a7e252a91ea43 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -518,6 +518,21 @@ static int ovl_fadvise(struct file *file, loff_t off=
set, loff_t len, int advice)
>                 return vfs_fadvise(realfile, offset, len, advice);
>  }
>
> +#ifdef CONFIG_CACHESTAT_SYSCALL
> +static int ovl_cachestat(struct file *file, struct cachestat_range *csr,
> +                        struct cachestat *cs)
> +{
> +       struct file *realfile;
> +
> +       realfile =3D ovl_real_file(file);
> +       if (IS_ERR(realfile))
> +               return PTR_ERR(realfile);

We're propagating the error of ovl_real_file() all the way to
userspace right? I think we need to handle this.

For example, we might get -EIO here, which is unexpected and
undocumented from cachestat's POV.

Maybe handle it and just return -EBADF or sth like that (with some
updated documentations, etc.)

The rest LGTM, but I'll let overlayfs maintainers check the
overlayfs-specific bits :)

> +
> +       with_ovl_creds(file_inode(file)->i_sb)
> +               return vfs_cachestat(realfile, csr, cs);
> +}
