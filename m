Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793304533;
	b=azrBF0ula29roRfaIhbzbNEQYEiAxw4IAjBhQXzAGbno57CyxFs/GKZUGK5hMmwhbrvw
	 xtpqXaw8BdT2IXcRJgSt1Xb/37AC/avNfujPw/AtC5/xAZcNy3GaV9qKE7N1yd5XCC6mG
	 yMFMfcyXkwtuqEotI60TOOYtwkrnw0BiTShUUxO+6hlEivPU2/tzZfSfetQTpEVB662KU
	 9hF3esVdZZVH25aZfM9rAwIU9Aj8xX9jJ2QEq2PnEwVhr4L1en8+6MxBLM4rz6SFckiHJ
	 ZhI1vkNY9/AKQVUEklRahDinQJXl/lAQ3guxxJQm1SUJodi7tQVplm8gWOjVffSFL0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=a7zkNlVrzlPSpxoUpXt3vRmcwmTKMbpAgzHY1qs7+DM=;
	b=oI2Cr+MOkdqhjsy+tr7nsjRtzOjoXJ+7KgeuIttS36CZ3MunnSG+yZk9LObIYYS05kGD
	 91+EEK0sHHzZjAs2ZyD0cVwL26s7p4D91aCDabwnBhUFRvxWPXOqsX5o5FY44MJq8tXzw
	 DOqSs2D6oma1kE45YBlLl0MqZvsFlzBwy1susL5IVScsZt+lKyPqk3wUK83Xk9PsTIMyL
	 VxJWoA/Xco1z89cnjFDg5Gr87+RIOx3qRNhi6AyZ6v3NvbDe4jpclJYS+C6UQSzo7TbEU
	 wFsn/yd+ELhjpkwTNIlqqgw0aKjh1aqMlr/SyGLzLchs45Le28bk/OWaNyau1vdQ1sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cF5c8VtD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38838606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 20:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38838606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cF5c8VtD
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso6618f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 13:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793304530; cv=none;
        d=google.com; s=arc-20260327;
        b=QY63WroFz8UkyLFeY9sAuISdj7hdHwXuhDt5oYQlD7UD29PCn51FPXvEhQ860tDSr5
         FsAV9s5KYjhPloYNoD+7pONfFXMleu9Pp5JpaVZmrsJF0BhiXyRYr9UXS75Tdb6KvcTR
         Xwqsh+elPy7ursVPAuODliGaSp5KUwTBJnxI8GvJ9X+7fo0M6f917+MP9ieZgHiC2H9N
         jBAizt4K8apcauXA5f1bQ2f10YjMz7XUi3VK0D7yEc0QJLWVfmcAUcntV0M5KF9wqDU5
         462wWDtSZiXcI7y2yuT/ZfduYnc2p6fN/Y9tzhN+N1kHjskrtsSp5lK8qMmCHBGtuAGV
         kpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a7zkNlVrzlPSpxoUpXt3vRmcwmTKMbpAgzHY1qs7+DM=;
        fh=qmlEDRwNNxetyPachvEmZzk01R9LDNG81YeHwkvkhoA=;
        b=SxVV936mdk/R5Hm0/4aUpnkNLznN1yCeB/ms05zfWlqJXvqkBFQYyYF51IvIvJWpsC
         6WTcbYR+xUtfQTC3qs03DrihALt2hJ/voJF2CaIoaFWl1Nwp0AP2EMLSmqmwWobtdcI+
         gdXFxW4KU3upz4ft0KSTZEjIiHE91c8vmuAe8jl7juExmj18rboPgAYEmMc1X3to7rKM
         aVHsG8CJkuVLONJbY2sFgoo+4M3FHcKy/DDi8M4AvphypO0U5Xm7je8LxyGLk0ESoucp
         5rdwNPB26di5IFQ1BOA8PhQAFsG7FmZq1Ugu+K7bfNKOSWk172WdlAvKYm+y0K3tmJm+
         4vyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793304530; x=1793909330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a7zkNlVrzlPSpxoUpXt3vRmcwmTKMbpAgzHY1qs7+DM=;
        b=cF5c8VtDD9mtXXMfx73tPPZP6ZGyc7Iyom5qIfSSirBoVjl+k1aJU9TlqtCNPsvv6t
         YUj/b2XjUvWOJEgA+rmpLJCfK19zhHTB1E2NO6z0KZh+kricy7kJQ9VZbjQpkW4sHs2H
         GNH8iRpemMGf5zAL7uGgGkMT+qaLFijGwdUVsaYuCiPasfiKk96yNECS37KfKjR41wvN
         zZRT7TKNKbHpIe1WqHXSoQbXF9sNULGInMaoyeU9alUXbydvm6CBahzyFHaCUh+Rfvjl
         KIIq9oRgvQUrNMFu9mgicexxTpmFPnBWaby0bq75EL6n9D5+kcYsM2Ye5O9qfRLcDhDk
         D9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793304530; x=1793909330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7zkNlVrzlPSpxoUpXt3vRmcwmTKMbpAgzHY1qs7+DM=;
        b=afa40p4fQbFQ+v4wNnoX8VUaSMVvx1vnKGMMLqeWL2zK9XRM3caxSeD8Sg+gV190J2
         kOtBQYazi4f5uL9GGSoUo82wmIFy6vhWI5J3DSoDkxIvnDJWp+0k3sboGuDlx8jx6yTP
         3IQOVLl2vtJTPo2r336l1KzV6iTpYxixEB29/eegcrcsbt9DZaLCBMvsW12D9e8LBUUy
         mQkeFdyzyfYylMPMS0nvZHNtJ3FVU1HRSmEswGRphMD9W+n1Q5RAwkoLherstG6O2XCo
         AW9L91ua8+UCEPt4GJ692ivZp9nEUyixsBxDR441EYNCESTTRJf7icw6qtzSuQKfJnTY
         EP6w==
X-Gm-Message-State: AFq9FYJZabDWWz2l9uvWVkNTwrbsukfOnz4SU3WOtD7TSqLFg+emWlvm
	uDmI1eBrs6Y8PuY5vA966H3ZfM6uglYmUaAaD+UVnDe8oZRkzVcx/eIyJ7WFzfBjmAkAouekZP8
	eV51C2Uw9765sGER5Lrn8WpbjG/KxEqA=
X-Gm-Gg: AYBFou2JlO8tFcP9a3VDED+yCJmmA7kl3knW7dyEZilMk1o5wt4H4k3GUXN7euIqiSn
	WIuj4AeQF2rPk07LTmP2BmFR5tI7QK5vAt4MCOkcBTVcZI5ChQNYWdlESCwqUZ7dEXOj3oRxH1G
	3Fnzec+0CC8/K3E0gDLQq5FhHocgcZtM34yVFgx+uSJaE6o0wcJwVyvitjtrver0db3ELsL2NQo
	rb+6QjG+q3M3fw/LNPIMgxkap/yj/nuk+eGSWBVQkZHL5E5qMGOz45e3d5t4rvmWmlZwIkw7vkB
	J8i0u3hAehQFqPBmUWOPiVHPy3O+RW+6eu1bhcAdmYGQSD1UFhcmuqTjJBCMOhfiLJxe/Cp93kU
	+NyEp6KDFa4wLDGRnrqThbxh+7oC+gMp8/G353lAHims8RGJadneUqw/dXPfc3SqQwQzOBRMG/B
	QkoWua5TNKsmcv5zfobQ==
X-Received: by 2002:a05:6000:1ac5:b0:48b:116d:56fb with SMTP id
 ffacd0b85a97d-48e6e2bbfe0mr1122858f8f.1.1793304530377; Thu, 29 Oct 2026
 13:08:50 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029-work-iomap-ai-fixes-v1-0-7eda63bc1b13@kernel.org> <20261029-work-iomap-ai-fixes-v1-1-7eda63bc1b13@kernel.org>
In-Reply-To: <20261029-work-iomap-ai-fixes-v1-1-7eda63bc1b13@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 29 Oct 2026 13:08:36 -0700
X-Gm-Features: AclHuK_mxORIH-qEHKr1ZEzSnp2s6A1zchn0cpynNg9TXiYPbvV1ECJaStfOffg
Message-ID: <CAJnrk1YiF=OEYQzwFpkzmBY_78+fNKgg5CafaWOa7KwGR+XN-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iomap: don't mark unwritten parts of a folio uptodate
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Chris Mason <clm@meta.com>, 
	Josef Bacik <josef@toxicpanda.com>, Matthew Wilcox <willy@infradead.org>, 
	Zhang Yi <yi.zhang@huaweicloud.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 3:35=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 907873073b03..d6e2f1ded5ca 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -920,6 +920,7 @@ static int __iomap_write_begin(const struct iomap_ite=
r *iter,
>                 if (iomap_block_needs_zeroing(iter, block_start)) {
>                         if (WARN_ON_ONCE(iter->flags & IOMAP_UNSHARE))
>                                 return -EIO;
> +                       /* uptodate once copied, see __iomap_write_end() =
*/
>                         folio_zero_segments(folio, poff, from, to, poff +=
 plen);
>                 } else {
>                         const struct iomap *iomap =3D iomap_iter_srcmap(i=
ter);
> @@ -943,8 +944,8 @@ static int __iomap_write_begin(const struct iomap_ite=
r *iter,
>
>                         if (iomap->flags & IOMAP_F_ZERO_TAIL)
>                                 folio_zero_segment(folio, to, poff + plen=
);
> +                       iomap_set_range_uptodate(folio, poff, plen);
>                 }
> -               iomap_set_range_uptodate(folio, poff, plen);
>         } while ((block_start +=3D plen) < block_end);
>
>         return 0;
>

The fix looks good to me.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
