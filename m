Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB212D21B
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 04:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778906674; cv=pass; b=mTjnt5UXlvgzpaXeSFaBAjZDuFh4PnC5LnBrJQxNzLdNnEZHI9VcsILLVzmp/sG+SeklOIYun/6n3Q8DkpBRYaJhVjj77trO04pxyGkfd8yqt7MXpK+TNvkqIhOFmqu9VlIOOBqOacIvqg5CFCXzlopmwEUzq7Pst/mGHzOMo0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778906674; c=relaxed/simple;
	bh=4QBQXNc/n+kRCp4DXOoFL6yVIhrRoM0TndDU3LEXdII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3rmDHnwmCUTwlFMQJvLWYuNx1YNG7aNriWwW4ULSFFL9AtqX0GW/UCkdn2e+c6Rtrbcgq5+PFNS47rzCiM5Hrvhd4e7la/qprNeBExYWeRqg85Dkz+waZb2sLkQClwHHelAr2kq6zk9kzeuYfrHpeGfjgnNHGouM4RWYpwoHbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAUpbl/7; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAUpbl/7"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-6312f28a760so15791137.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 21:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778906672; cv=none;
        d=google.com; s=arc-20240605;
        b=QeSxWGugGltUxhVkwzTih4O2dvYOpMyyKZDrMGz3nfvzP6hWK6dqPJpXvyjfegliq0
         fbsC+qNyye+3q0RD2AwSe53mO+n2J+f5oGkyi6ZuFvJP4zC6cTJR51jmTh98ng7jVMvH
         meJf/FJX5hS8lyGQJS+Yj0l7OAFtJBc/coqBHHCTu4wnVv+xhJKQ1/7INBgpcnMz/ePi
         UYu1fcxp1DRBihheIgtth8YPpvwFhlpx93lNaAGX3cvGSgUhCiAuOcQyYdtXLGq8nP/F
         rF86k1TVRc60hmeMjQU2Ol0yWE+zjs4H76V0WQtJ5Izt0QYM3uGH5oKG2sjYIAeQNEtB
         gnWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DYDSXLhOHj1s+deQAJ+TXvpGa9Fd2DyDL2SVrwFSgpM=;
        fh=zmk7N7c31TP3GTxqPHcpDx1KKTWpA6AxMuFKXxEhLr4=;
        b=Q7BZ239u4nWH2QtyNbMeL1iPizyZk0M73kCB4ghUOYCPv/Pu2sbuKhfYk5m+uJ4b9j
         e1waNhzMCYq1fTt9ojugS+df6YDpbi2+wD9WQjcpeCMgxlHlV8VVgPM/XZ7xGj91DNyw
         kKL0DGWSNr7rUDIuPPus8i1Sr5tpZ6MnJPyl1mcSIA9x+zYIXudOAhepvq+lGzgg1pG8
         QIan+Hkm8NIJgThG7+XyIEvjVlDDbPlCVuW5N39Q86c+JpSJI9Qlk1A22fThlEoiDZwt
         gioGpZa9Ki1g4IkKNPLWWQ4bMPUCSN+Y0W8ixXK9BQRyQ29q4i/afErCAywLjfiau6Xz
         F6Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778906672; x=1779511472; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DYDSXLhOHj1s+deQAJ+TXvpGa9Fd2DyDL2SVrwFSgpM=;
        b=JAUpbl/7SjYYqHaDjLj9F9ecmG8kbt+1LBc8oyF9bd3ZgSDZO7/DGGmc6SmASCneB3
         3X2OwY2Lmlmn5QZmf5fT9Qt69n/CNg9zhEeLgKaRMdExDlbPtP8MJoCZhaPHrPLWKmGj
         IuUU4BvY2LwLF25r3q7RPYINY5/e/EZaz5xmnkyUX3kSIPR/3dVMD95vokmcsSAo/usk
         xPsAR6+fYo8jda4zG7VY9es65cRuqoLkb7pQlACWJ4nZ/ERr+cPsTcMCxY+zgiGacnYo
         LsHIM3VUnT9wDbLkJCYqX78Zn22iTPqY3fEL5egoVZ9t7Z4AU4J+OAPiwhAEE+eVHUA6
         rXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778906672; x=1779511472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYDSXLhOHj1s+deQAJ+TXvpGa9Fd2DyDL2SVrwFSgpM=;
        b=RlYxb03lSqVZkQAeNVpCEMJr+jIjPvmzzeWzmYxfYNydCIfcBfW8aDI6Dwg/2sDgtw
         pv+SW4R3WryNpJTe8uGfKURBjv9tXUYXAbnwktATUSjjR89zRB4A0JssmU/zx4I2THLw
         F0hM0BAnMOrXK8TrupgfsrUsYldLg3bowhICpaY3IDTbgPtdI5EfDAY6LbeFq8syYZsK
         cNySJWEfVt9sSCr3R5AVFVARtsZSSJgVRCCel8pEkJim7heOfroZe/GlCNgCH2TxB/kb
         unpNkrGZ015rjur7levtWWIv3TsOQvn3LVwJeRaKVtPW/faYf/pFktyK/En2b5y4C3Zi
         CS4w==
X-Forwarded-Encrypted: i=1; AFNElJ/gKhn4EPcT4EGTEg8Dz9fuj0bijy9h5ET0QrytcykJhKIEBPXXdlu+ZZIUcQgneBpmXhSukXBwCPQ+HaAD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/Im/r+0kTDtQOvQRhEl1Lvnt5QJDnSY9nXu3M+BLEUANr2OK
	5R0q1fp+MTuIDNwS4Hctq9YKP8gb4j03QdLNBciEuJbbRxvkM4nWWLbziCo+bzor6aK3PGQTeDN
	3+jYOczP9Ym8Qz8QXj9HFe0geBaSw4A0=
X-Gm-Gg: Acq92OFOiVXZ3JYFQJ3earje2wnvf98aJ+Dd1xi82buQLOPIFJIx0bgODny710jIaw+
	MiKiROBsaDKEIkqOEEyBvKwmXhv2CNDiTC9+wPg1Vu1o4yvoLuF1FcGqmb5iSq2MPnKFyegvDNV
	gHvz7AvHh7/FHhRdwXBNFzgMbtB2WvJkprJf2CxBeGN3WMk6aXCGzW/gqeE01zj1IywMNYRSGf/
	frfmYtkpwkfEqQpYlgpVTi+Zrw7cLfOo6m+iAUBtOx+YunBk9k4UFKoUwcAxsPk5K/PviJeS6I9
	TFs+9tktCPirFQn3MiWVh5fkKd/msbirzdCJg/4=
X-Received: by 2002:a05:6102:116d:b0:631:267d:157b with SMTP id
 ada2fe7eead31-63a3f58f189mr1179218137.5.1778906671586; Fri, 15 May 2026
 21:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515163424.1575298-1-michael.bommarito@gmail.com>
In-Reply-To: <20260515163424.1575298-1-michael.bommarito@gmail.com>
From: Pavitra Jha <jhapavitra98@gmail.com>
Date: Sat, 16 May 2026 10:14:19 +0530
X-Gm-Features: AVHnY4JGJwyaJDa6wW1v8xk-c24D-8fldPvZ3sXcfC8Z3PVJ2ubMA72oRNfxato
Message-ID: <CALFbBicg4oz-MoQue-_MCYaROeWJMkDUySaMP1_Te9z5wP_1Jg@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs3: bound NTFS_DE view.data_off in UpdateRecordData{Root,Allocation}
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Thanks for fixing this. Since you cited my original report as the
basis, would you mind adding:

Reported-by: Pavitra Jha <jhapavitra98@gmail.com>

to the patch tags?

On Fri, 15 May 2026 at 22:04, Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> In do_action()'s UpdateRecordDataRoot (fslog.c:3489) and
> UpdateRecordDataAllocation (fslog.c:3697) cases, the memmove
> destination is `Add2Ptr(e, le16_to_cpu(e->view.data_off))`,
> where e->view.data_off comes from an on-disk NTFS_DE inside
> an INDEX_ROOT or INDEX_BUFFER.  Neither case validates
> view.data_off + dlen against e->size; the existing
> check_if_index_root / check_if_alloc_index helpers walk the
> entry chain and validate the entry's offset, but not its
> internal view fields.
>
> The neighbouring read sites (e.g., fs/ntfs3/index.c when
> iterating view entries) check view.data_off + view.data_size
> <= e->size.  Apply the same bound at the two memmove sites.
>
> Reproduced under UML+KASAN on mainline 8d90b09e6741 via
> pr_warn-only probe instrumentation: with view.data_off forced
> to 0xFFFC, the memmove writes 32 bytes past the end of the
> NTFS_DE.
>
> This is similar in shape to Pavitra Jha's 2026-05-02 patch
> "fs/ntfs3: prevent oob in case UpdateRecordDataRoot"
> (<20260502105008.21827-1-jhapavitra98@gmail.com>) which
> proposes calling ntfs3_bad_de_range(); that helper does not
> exist in mainline.  This patch uses inline checks.
>
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  fs/ntfs3/fslog.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index acfa18b84401e..127860fd2ab50 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -3497,6 +3497,18 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>
>                 e = Add2Ptr(attr, le16_to_cpu(lrh->attr_off));
>
> +               /*
> +                * e->view.data_off and dlen come from the on-disk
> +                * INDEX_ROOT entry / LRH.  The neighbouring read sites
> +                * (e.g. fs/ntfs3/index.c) check that
> +                * view.data_off + view.data_size <= e->size; mirror that
> +                * bound here so the memmove cannot reach past the entry.
> +                */
> +               if (le16_to_cpu(e->view.data_off) > le16_to_cpu(e->size) ||
> +                   le16_to_cpu(e->view.data_off) + dlen >
> +                           le16_to_cpu(e->size))
> +                       goto dirty_vol;
> +
>                 memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);
>
>                 mi->dirty = true;
> @@ -3689,6 +3701,12 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
>                         goto dirty_vol;
>                 }
>
> +               /* See UpdateRecordDataRoot for the rationale. */
> +               if (le16_to_cpu(e->view.data_off) > le16_to_cpu(e->size) ||
> +                   le16_to_cpu(e->view.data_off) + dlen >
> +                           le16_to_cpu(e->size))
> +                       goto dirty_vol;
> +
>                 memmove(Add2Ptr(e, le16_to_cpu(e->view.data_off)), data, dlen);
>
>                 a_dirty = true;
> --
> 2.53.0
>
