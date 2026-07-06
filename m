Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075C21D596
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303113; cv=pass; b=dGNXDHEOGsh2fy8peDWNTOQ5s4dYjGWTvfVE/89QVT3AkHsB9MnEickW7vHWfdSu6JG5zjc4IiBba6tzv1/DE8C2zgeEXjRPiZm0hS15vUeKaWnvWz6jAy2Gnsu+RxGfSL+zaw3CJ238hNPnjZDFp1wmma6VfH0H+zVBGxnO2vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303113; c=relaxed/simple;
	bh=ujy0JkK1tlZdf3p4IFVek3ozFaGityqkuakLhMqO7xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVLxgEvMnQccRPjurAnVmWLDLQjaUIcHrnZTFfWOstajdzRQROP/lc0ktjcopdyGk6sWaIYPa07kXo7swAxXq5EzWLOAZ1ZpXW5kiocZknY9fO/jameNIbYXXS6pxSdu4VdtDrWbPu5GCfHAaWthSb0xFciG3kNbjfEaPJlYN3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdsLYbNZ; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdsLYbNZ"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb77b3afbso2290949e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2026 18:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783303111; cv=none;
        d=google.com; s=arc-20260327;
        b=oOdm4egTS5c4Xlgsxv5SZJPDLK8FKzaUbnJBaO0bWpxq8NpMrF6NDacC7PAJ8zn4VC
         6CUxKdTCzc8gltDj7F8EeXs4f2qyySN4JQE5NXmc3EG92C2p06ZO3m0NUj8q/jCxzmDg
         IurNxY/fgnRXNni3XCNepz27emDb4sY8Jm/OmOuB55fV8I4Ap8Zdw3ztaj2rjgcpdHbT
         Krkm67wPgmDXNIxrhyyEKBbnCIfIC0nu2MU7multc7+yezuL9adI27oFjNOiHE16jw2z
         mCiy1B9VPeVPr1dJsb07xBdqNXN8aRvC6wTaczpf1QBURK7R23mAad6H4tSDIDOdH53e
         LUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hfeozLc8lfROroWi4fuwydRuWdXvG6VBqX8p8xBH/ZA=;
        fh=KO8PAlXJek2Oz/MHMOqHtJbiK4gPRfr1iqdHImnlP9A=;
        b=Ja65YNqTFETlZ65MqR/IKTw4PvBXIflRpkejC5YdiBzd5i7h5sTFNyrM4F3reZ9wKX
         QOh/Q0UA0DX8cU7ir+aVvEYypibgWsCOSwIcGSkXvrRU8Y9xmi2aluKdg0GomE8PkdK8
         ldXeMSjOettH96REwiB4vzlr79YZXDIfRw6xPMtbaaA9BuKJ6p7TKBDGW3fEXO8h5T0P
         X7VhD5+P5/Qy8AP2TmIUda253OzrZ1mpQRe+crUkRJRn5xQ7CurdsAaNCKk2HIqhQ9Rp
         n/Ze5AaddHKaXTiO2CTgsFYlhXpBOazS0CkeJS1HO8WMZvUXp9kSAoeaGW70qMWErmEI
         BFtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783303111; x=1783907911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfeozLc8lfROroWi4fuwydRuWdXvG6VBqX8p8xBH/ZA=;
        b=RdsLYbNZ8Gj9ZtEy5tkDHw4kvEcUErebFoSQn5ZcB/lwW8E81wzGk9pPg2uIJPoBJi
         dcJrKBGYWRnT65Ggo10O6b8aKCcuYbqSLOJXD3D0MgX2hgJNhPvWkR2/G0+lYxRssHUp
         CqL6QaU64HpTJyN972st74AM+x0wNcmv94KyDZbW4ALp0EGzZbo4zwzRorKzJj7mVwSU
         WdB06MB+EfLuN++D5UIs0F6Q8qxrjSmpBSi2aGtcs7GSSQ8r0jQhqKduCudcqykeN32R
         sv65ai8wkDrPg3DJ2xhQMLpeRQxuhImol6HwuKjqCRf0AKaBSkbtWXe47Pkn5dufFDdr
         1heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783303111; x=1783907911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hfeozLc8lfROroWi4fuwydRuWdXvG6VBqX8p8xBH/ZA=;
        b=SGmN86EbkvrWCbewaZprrHJVwuOpyWLQ1MY6WhdbJrgYu47EivHURnzaaxeqPL1L1P
         CE6xyuVYEAA2NT8DYK72Lto2lgdlz2wwxBuaWBPY0XJh3g7Uvoh03PNuK2tLAxMwSZIr
         SxUsOKyvUFsyJOUWMVF7J8MexeVdpUoIkR4OUy5YGFyj/tuSXs/qQKAnXpDxr6Ljkt2j
         eNc7yCm7dURTCW6/zX/+q+qo+rJ+YIhWHlsjn5ROB8n0t447hBSadFxDaCnEpsV42nJt
         q+AYAdij6a7s0EQDqP9QQuMNBKiu5rFT3ik7H5RDXY0P7v1TzTIg1u2OnDdyE1LstlwU
         Wggg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7KvRh4CiNMiLcnEN4wU7A86hxeTv82wkyxeAQdNdBYCK0bW8JfS5dMvC8fsv7k8EE2pE0RwklLTFDcjYJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzivoFbntkkH2Vb18qXCADMSMwLZEj9XKkM50vJbxytEbmCTNHS
	yFymncq1YpiqSw30YjEGhtFb/MTyzXrFLZHk7eBLcJaw7Or9bKpkNHM1yoFvbEpxEqVhdl9Esgr
	RQSoOcOHMDik11GZXDBJ0TsLMJy6jpv4=
X-Gm-Gg: AfdE7cll5P2QbMIDx6ZOpqcgj6INYf33Sd0BnbQ/oykeZmINWmUaV3wsDLD6TUj1v+q
	gJZKHb7uurBEaYJoE519wRynVCW+78uuQbPJtBMfesdJvbhAEn0FMCbIaQmPLagKDIfF+AJOTnr
	zgP7kDbeVy9b8vs4PEau8bBRHKp7ZzFJeqtzBplHS8lowLOFKHtUNtniHVymFMmyRzQukaew3NU
	t2cnbY9u8FmVRaFHjRU6j4SO9HQlI+oQB1g2ryU3MTfO9oidVQ/25xKrRT0QgBdMNLhXLkZ
X-Received: by 2002:a05:6512:8358:b0:5ae:bd5b:c68b with SMTP id
 2adb3069b0e04-5aed50b80b8mr920536e87.37.1783303110567; Sun, 05 Jul 2026
 18:58:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608210618.3437216-1-willy@infradead.org> <20260608210618.3437216-3-willy@infradead.org>
In-Reply-To: <20260608210618.3437216-3-willy@infradead.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 6 Jul 2026 10:58:18 +0900
X-Gm-Features: AVVi8CeDqc8BYSLiYYk2lLX6apbCk_RkRARPEBX1R5X1hq38Hbtq6M6jPVakieI
Message-ID: <CANFS6bYc5uSSYWvwJZ4BgjzF0_bO9rkcFNvX2vVHnzWDi3kpuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Namjae Jeon <linkinjeon@kernel.org>, usama.arif@linux.dev, 
	lance.yang@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

2026=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 6:06, Ma=
tthew Wilcox (Oracle) <willy@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> Nobody is supposed to use page->__folio_index.  Use page_offset()
> instead, and simplify by working exclusively in loff_t instead of mixing
> up loff_t and pgoff_t.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ntfs/compress.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index c904858dff3d..b279f38636d6 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -105,13 +105,14 @@ void free_compression_buffers(void)
>  static inline void handle_bounds_compressed_page(struct page *page,
>                 const loff_t i_size, const s64 initialized_size)
>  {
> -       if ((page->__folio_index >=3D (initialized_size >> PAGE_SHIFT)) &=
&
> -                       (initialized_size < i_size)) {
> +       loff_t pos =3D page_offset(page);
> +
> +       if ((pos >=3D initialized_size) && (initialized_size < i_size)) {

I think the following change would address the review comments for
this patch and patch 3/6.

if ((pos + PAGE_SIZE > initialized_size) && (initialized_size < i_size)) {

>                 u8 *kp =3D page_address(page);
>                 unsigned int kp_ofs;
>
>                 ntfs_debug("Zeroing page region outside initialized size.=
");
> -               if (((s64)page->__folio_index << PAGE_SHIFT) >=3D initial=
ized_size) {
> +               if (pos >=3D initialized_size) {
>                         clear_page(kp);
>                         return;
>                 }
> --
> 2.47.3
>
>


--=20
Thanks,
Hyunchul
