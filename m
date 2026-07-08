Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545D4A33
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783469322; cv=pass; b=umHocdMjR1MQLXS7eDnlaAJQ9aR4ilg4uduHcrF0oIf4C+iz4Cyb0TDGdPBWX9/+a1JVcOIwSwMTKwLPEknI6m3w9ujQltfKAqQ66H+265pkfJLLrDbMzpRUlMo7R/kr5veNGBxU65YDxfzieRAVR0DmZtWn+apcv8rLtmGxqA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783469322; c=relaxed/simple;
	bh=wrCxhT9q5NGhmorul0PiyOdgEDEIBVXjSk0TxVXo0/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cg/v5/+k7kLW3vNyoErM3NmGgTjD3Rdyg4c6sH8hlEpvykSmwyrsRTPJ6rA1vrHL3k6MX+Cy+EsGBY4xLUKwPjTZJpVm3ZJu6j4dvBBNQY7rawTnJMZ7NqmQMtBWQpc3uY+XfE9rdzeyGZPOAv/tm/YZgAtZYnoR7hSHkd5CRbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck3uRqrx; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck3uRqrx"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aebba706b3so126689e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 17:08:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783469319; cv=none;
        d=google.com; s=arc-20260327;
        b=ZMA2XXyaNUfQn5reoguQfO0eYvCkhDoM3rWGMdwJpS1bxiCqxGB9ihjY9nAVsN5v/S
         OIOUC5nOK0NXlZLEBHNFB31XCfYE/36TDhaKV+qulp/dq7wIi/+otlcaLb6PNI73VM3Q
         gfiYWk2nMBNNytew0DhmrakJKK+B/DkVuhBH6mVSws0iWafBaJ6FJrGFG+SsG4S+/5XW
         zGaFWjMuTDwalVyyUlHb1AIFJpciskDvHjlGEc5NtQJqVFvGzAjdN/1ja9k+SeCH005c
         g9ARFVTW9PlzR1mnkT4HrUc4Nv7L3iIbKsCnSG1fPxwEHJMRjYfvB8COaxHWbHThO5Wb
         A8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kb/xvVbvZ2c9F92U8pIkmxcQRFXF7zJtJ9eluQJqJNk=;
        fh=G1f65XRtcAnGPwo5ZC2zQWTG7G4SZYhOQowlONVXRBA=;
        b=PDgfMPkNxrNuKHLZXe8pdQJVby4/D3Uf3QfkkfvY+BX8Ik/givxr7wu4yZ7WzILPQs
         cW2+06ixnVFekE/ZMfCvidogwoYd4/pGdEwEykVRrWEIPv7NGFUWaayGLBXQAEJFQM60
         SCMWIoAnsmkSiP/WNAX5++7ILJOTzjyzlhZMdgG5P+qtRI018+Sk/Ua6zFEL0qFhMzW8
         JTd3Jq7e2N4NoQ3QqeCHNjNMstivYwDJvWABroTG/t1FCDhQZCeUtqbL3iw4ZZY2s7s1
         ifp1dWzYwtn5zrrW4ZAAhILdqB59XnNhrIiqGmE48Wwwu/5AxvPl4J5lDuxfTMqMtESr
         iz9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783469319; x=1784074119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kb/xvVbvZ2c9F92U8pIkmxcQRFXF7zJtJ9eluQJqJNk=;
        b=ck3uRqrxnmVl44gidlAEU1/NA4yTTQVPQlmgtH67aF32cBtpoBhJl8+EjjmlD2Y8Zb
         1gasXJ9vxv7I8RmAdnEWjXkinE4e/zzdWKVf8lgEooTyUY1AZSC9pV+9GexT5RQh3fXv
         R2+jKAdCPjMqp8/FJoUY7zdwWHq6NaThNMnbKkToMSBC5W+2A9VGYMEUbwCaTuJS/bdB
         aofEFCYzmZ0kLSUdInxe4X/68wEDOLdqBIU6wVYttaYpvDm1eqy3aEv5LZ6Wic69xUeH
         aIxEqkscJh12WUYPKFjodP5n5cZLLgEd1+WcMNeu7kLJTmnqI2JjSf9hyhyywc3SbIcw
         bOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783469319; x=1784074119;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kb/xvVbvZ2c9F92U8pIkmxcQRFXF7zJtJ9eluQJqJNk=;
        b=bJrMwZR5kJbQE1cNe2rOUuxrxj4Z+Oh/uM1VJ56n2nTCc5TuAw+etO4xqrMbgBfuLr
         oIF9VfHuFkrPUY4/7LbdRP9Kut+3EiouXwh7B/N+SS+d1ken3rdUtPwIY/05ZDZLih1R
         92M+Gq9qtxfSBXng+7fMhjr4Ylh+Zsm0dEU3ohwiJMDO3NOt2zd/uLnnswzlceoEKwLv
         iPO1ZBd8VYlnyqIEIT4ifXywcEWdjYRCAmfNles5A/nw+CjybvRwXddQBPzDD0qo9J1h
         yuSucuP2+KoKZmUlTwyHKLMoRRvkO5/i8ASFlC3yGPRKP5k8NM8DXCdFzR6p9v4CEOwE
         1Cuw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6OYJgJlutvSgkA+zgrtx7mFQg5ZURKNfYIUXJkhM/xyZhpd+DjobdxHJX8/Tu8Jxj+bh7kCRo1u5dnzSI@vger.kernel.org
X-Gm-Message-State: AOJu0Yytrz7bMU/rCQ9+1z/9895eyTyaUEPrUWvs4EI23m44FSjX2f9L
	e265daHMb7BXJW8rPAxYaTTwmyqAorzcBHmz+/UXq29k7guL4P/T26RjEqWylwXUBUGzF7tw80n
	59m3AorH7EcUB5Q9YE1znEcAQAtU9azE=
X-Gm-Gg: AfdE7cmfhjaIEp1o93PTZk8OKtZ/tUpoqeE1O7t3Suelv8N03HJ7UIhEUAt2I2smDj9
	LjTMoDmNZSlaf/6gvo7LRjSpu7//0fdkECn+HzJ6zhHhOoiYdwOFV2GgaQlYB0W47YiruKQiLKU
	2NmX0R1mmWVhTN5rQwFfXHSSyF8rQcHFGve8vlmVnXiQQNsu40GOTODyv6Kd+OeFRUyJBk6yi06
	bNdlOlIABWSWgyn1CdT0RqVik629/P4XA4MNGkt9lBZZMcE3mfTZwvVlDnF1R1Fvvj7WUZh
X-Received: by 2002:a05:6512:8046:b0:5a8:8db6:b3d with SMTP id
 2adb3069b0e04-5b01147f555mr40151e87.24.1783469318736; Tue, 07 Jul 2026
 17:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608210618.3437216-1-willy@infradead.org> <20260608210618.3437216-3-willy@infradead.org>
 <CANFS6bYc5uSSYWvwJZ4BgjzF0_bO9rkcFNvX2vVHnzWDi3kpuw@mail.gmail.com>
In-Reply-To: <CANFS6bYc5uSSYWvwJZ4BgjzF0_bO9rkcFNvX2vVHnzWDi3kpuw@mail.gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Wed, 8 Jul 2026 09:08:27 +0900
X-Gm-Features: AVVi8CdGi_C6rE3txMZQnG-e3IT5Ry6oWBkUYMiraSxo4xYpBWUS0o-T89fKM6o
Message-ID: <CANFS6bZZN6455QLhPE=yYi5fAHMt+MuqumtW6BCg__pESLiLaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Namjae Jeon <linkinjeon@kernel.org>, usama.arif@linux.dev, 
	lance.yang@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

2026=EB=85=84 7=EC=9B=94 6=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 10:58, H=
yunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Matthew,
>
> 2026=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 6:06, =
Matthew Wilcox (Oracle) <willy@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
> >
> > Nobody is supposed to use page->__folio_index.  Use page_offset()
> > instead, and simplify by working exclusively in loff_t instead of mixin=
g
> > up loff_t and pgoff_t.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/ntfs/compress.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> > index c904858dff3d..b279f38636d6 100644
> > --- a/fs/ntfs/compress.c
> > +++ b/fs/ntfs/compress.c
> > @@ -105,13 +105,14 @@ void free_compression_buffers(void)
> >  static inline void handle_bounds_compressed_page(struct page *page,
> >                 const loff_t i_size, const s64 initialized_size)
> >  {
> > -       if ((page->__folio_index >=3D (initialized_size >> PAGE_SHIFT))=
 &&
> > -                       (initialized_size < i_size)) {
> > +       loff_t pos =3D page_offset(page);
> > +
> > +       if ((pos >=3D initialized_size) && (initialized_size < i_size))=
 {
>
> I think the following change would address the review comments for
> this patch and patch 3/6.
>

Would you mind if I continue working on this series?
I would fix the above if-condition and add Co-developed-by for my changes.

Please let me know if that's okay with you.

> if ((pos + PAGE_SIZE > initialized_size) && (initialized_size < i_size)) =
{
>
> >                 u8 *kp =3D page_address(page);
> >                 unsigned int kp_ofs;
> >
> >                 ntfs_debug("Zeroing page region outside initialized siz=
e.");
> > -               if (((s64)page->__folio_index << PAGE_SHIFT) >=3D initi=
alized_size) {
> > +               if (pos >=3D initialized_size) {
> >                         clear_page(kp);
> >                         return;
> >                 }
> > --
> > 2.47.3
> >
> >
>
>
> --
> Thanks,
> Hyunchul



--=20
Thanks,
Hyunchul
