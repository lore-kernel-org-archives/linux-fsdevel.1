Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CEF201113
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783040954; cv=pass; b=KUmdr+jYkMPoJEMkyz4KzRgVZtuXr1R73kZpUugCVJCjeCqeImJSPcJGVtcW5q3dk56bQ3ZbOPpuuLu8HQWirH2tyF6kSeG+73GdimZ0pans3VFJ/iV2MlxGZ5jM+hyUch9Mel51Xzmqa8NN9t6jigNihVsBOvOJYVPoJR4I7Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783040954; c=relaxed/simple;
	bh=+PeQLIUmmmMgIHSXGFK8qpsgRcvLGFGUUJJHkFN2P34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaZTSw0V/QXGCKpxKHCBYvVO0f8UzhemDjWcBgy1II61YE6vl4ycI0Uci7+S/PzTsF/on5SeEB9OMrYoxpjImkhFZfc6NdikS9w0TXhsWMvp4G5kzCRm8wql+aNzwo8boRkbCMrTtmnXJKeinvlB3AC5l1VxCGx8SsECDTym2rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaW6y+B1; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaW6y+B1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b68b4643so25115e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 18:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783040951; cv=none;
        d=google.com; s=arc-20260327;
        b=Pczyipv0q5Gom50JQkL5pVUKyvY1T0gfsWuY8tkbGNVr6HQKYDqCe11QN7E560qe9V
         Ewvm7ex17gognaiSbKsunjANeeg3Pw0NPOBpcXjg7Unhc/SEZdheuR0S1bJzrb1XUCfm
         B8a8KC0runqaNQrerIK7B3pmSVwtVR1LOs87FH9KjRfJEtUtDjJsrzTGVRODcnLCYYkZ
         lJSQek7pFM8NGB2bfKEEK7uaoY7bxGH/BA3Dg1MZPbotG6698DaLmUHeYOrXQ9krbGDO
         EdDUby9TT1OkBPdBPzdmMDXgl7CnHRuo9HZewFxdev2vz/KECNC90Kb8g9GG7L1cjOS0
         opow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mKtUjpcLEtae9EYATJ2n3P73/k/uWxtMsjVu1YWxYyc=;
        fh=Be93fckRd0upT+6AzKOnHpeRxJzG8sKXuh0yVTDpCmk=;
        b=r+VyqXfRH/bL96Hfy8iAno9JQh1qec7nK1Jbagrv4sOiJIFt+FAQz90O5pOV4QCyHU
         LRT4u/EkBRv2PkeNO/0ZGX9YW5v8hxZy7UM4mp83os1gjMNjFWxhSGFbfk/JypCG36s6
         kVUVL5cpMm7IIsuRU41H8AvuZHI97YHPI5F17znaghdjjAMbHFXsGwAQTBQq906vyFna
         yq5Z5AOsza2quPDYlVborTuGHm2fiV55Ho11UYo3LgB8MmTF47hAzzrRbN0FaoakdOFC
         pAveyLL++5pEQeuo0PfuNz3Tgm1fnnH1evOAgPsQzHP9NNgsVWDLP7fQprKZsVGobxyi
         /I7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783040951; x=1783645751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mKtUjpcLEtae9EYATJ2n3P73/k/uWxtMsjVu1YWxYyc=;
        b=YaW6y+B1f0dDuqfUYmvofIB/SSkroGSQTUh4VfJRbYVTEi8dzX8L7iNQ00YXWCY9nw
         CJ3UmSwQMeFvC5HoMrOHsjaq0Yxqb0APyjZnC0y9el9e5JkkuAGwKzdQyUpJRIDFkyf9
         e9yTuGExnyNHOZnmDEsKxUyb5RfV9WbK7Qi0D6WFu+eU5XGe3d08VGpBs22Cf64UJyDy
         /L9JvAmOu4WYOZZMUGvCbnCZ1wChP3ls+f8tYAQI5S2m8zD3cGEjCaVVkHh1fihLxHYP
         dXFDfP2drv2GcDqTUdTXVLIzxxE9KZRqg4pNG4Pd4z+qZAWIgfxE4PTtIpeGar3GrOJv
         zGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783040951; x=1783645751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mKtUjpcLEtae9EYATJ2n3P73/k/uWxtMsjVu1YWxYyc=;
        b=ZUxDYN3+zQa0m3CAUmipkNNo4KQNvG4kiFggJgzYKUIXhtbOC5gV242hD1W6aa4+NE
         OlO1U5IrxhDa5lh+Chp/zrbSkf4o+2UXeJemENCxVTX4dQnzF25+fXsg+Wn1Q3bj/epK
         4DLjSFNm5t10DsOBot1/FwefHKOjdj6J4Nz4rpjhedaZ7KEMlbCbnu+Y12zCKYH6h2Nq
         mQqKL4AawAfF+yFXM53aJ4p4RPIBCNaEjIYvU38oXBNnVZLNl11oazSjjhAzfCcm3xrF
         8vI+jk8pOED/IWDPww7yl5aecjqLwAsoyNeDTqgNS4gl5HX9Ro9GkRm8kyBPj828fkOY
         g5lg==
X-Forwarded-Encrypted: i=1; AFNElJ8i0Lt+BqvaMbIe8T+CjvBGnAjPixcMYKmJgPj2y7oKel+QWWxUdtJd9954FT1qQ1Yog67fW53dnyYnm+cp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2s4VTP5M0knFayRJNUYtpqkMg8xBhMLSBwGPICdP8tjhBC635
	HDJDjtO+9Ok8InGprmlvQlFHldNobmNVupTYVMfawM1T6ERViD2d32cgfaSUX9T3SyMThju012s
	dXFZd9bYnKe3Gh0SNMyA5l7+g4sBcmaM=
X-Gm-Gg: AfdE7cmsAtilq9I+2SX27vv6Bo9cDTQWanQ9XcFYpbia3nZDxCwm3JpS9fxHrRpEnWD
	iXzd82riXyMjCt26D8O74j5AP6Pr+BAJS20ci2kZq4quiKmd1ybvURg5q4eduvOsheV1cCg49vA
	dvVvXukIdv8NWQGFTYm45rOsBLrfYNYeXv6Ii2CttsSyb0XZABS8W1/E/h9TLuOWW+tbDVEA48B
	16Yg/wGkBm2yrbCavuyyWEIaC7AxpOAhF68k/HoqOSKIdKv1g3wuL2UP5fZFTBrauMlHHc7abBX
	j/jnEnp9tcX5iMxJckyQzjAl/AxURk/zkPaJb6bK4zUjNGjmVEoG
X-Received: by 2002:a05:600c:35d2:b0:493:c3f9:65a2 with SMTP id
 5b1f17b1804b1-493c3f9664bmr124524785e9.5.1783040951341; Thu, 02 Jul 2026
 18:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com> <akZsZ2KV_-jsNZl9@infradead.org>
In-Reply-To: <akZsZ2KV_-jsNZl9@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jul 2026 18:08:57 -0700
X-Gm-Features: AVVi8CcMR_tmj_vpU84RWRMXO0CqEvDgbM61sr0zCq5c_sRYQUpWHXFzI5ZJoX8
Message-ID: <CAJnrk1ZZCBexaYUCe0s2_kfbAZVKrdhSXFCRv=cy1ggcxRhSPw@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] iomap: convert to in-iter iomap_next() model
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, hch@lst.de, djwong@kernel.org, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 6:49=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> What tree does this apply to?  I tried 7.2-rc1, Linus current
> master, vfs/vfs.fixes and had slightly different failures to apply
> with each one.

This is on top of Christian's vfs iomap tree (vfs-7.3.iomap) on top of
commit f2727952b21d1.

>
> On Tue, Jun 30, 2026 at 05:09:15PM -0700, Joanne Koong wrote:
> > This series implements a suggestion by Christoph for finishing the conv=
ersion
> > of iomap to an iterator model. This revives Matthew's previous RFC [1],=
 which
> > had the same intention.
>
> Btw, this evolved from my original suggestion to something that actually
> looks much better, so don't give me too much credit :)

This definitely wouldn't have existed without your suggestion and
guidance :) Thanks for reviewing the series!
