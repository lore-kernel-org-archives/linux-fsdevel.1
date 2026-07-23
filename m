Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4675F40861D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821771; cv=pass; b=bgxuTX2M/L1Gt5wKWkPrVI5YwbXdaBvnOej1veiIW+9MFIyN/vr7WTG3j+qJTasaZYxixFpuFHDdgP+k10uce2NOeCtg9u36iVAHCil+sCfyCRa238lgZqFZ0ilCmOhLnQVkm6QnWvKOB6h3fWsCoO/8Yog5+rjlLt2eLGJ+qkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821771; c=relaxed/simple;
	bh=VOEwoWxhkHAzPl7z/kfmfgEp6lBpU3TPL7nXC62jp0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiFGsKZW95uUISMBpPGodMbwH+2VzMcONq2YkOeba4yFLKjjIQaYn//ZUZuOp9KW4gqNqZj6toRxJMvUjizhrtnN5l4/Hujum0NuwY5+t4l3LauGJlIGzg9UIPt9ulhpqqXVkZ6Yb4QelO5z6UkISgPtceIzlBoS+L15nt5Epo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qydzhXXx; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qydzhXXx"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4728c12ba97so511693f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 08:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784821766; cv=none;
        d=google.com; s=arc-20260327;
        b=IYN54WVZRab2s6zmARI5D1aHnb5sThMic3wOY95ltM+NpFhgV1m7mXkALUUoLcRBeH
         OIwB4iFuPxcuFCHpz6H5/fh/kcSx/6Cw/4NqgW6pcQrgR+UUs71U1hSwkaToOea0hsl8
         QPsqG8toHEVKh3ZYkVL0Q8sYEh0FXsW/PT4ZGAzVayGdQY2HDc5JBWriGlPPqFzOZuxy
         7bt+Tt6A8jqzMHzHFMfhQP8LsdlfdAhPZzzwSESA49e0RFDCTWyhqsABDE5vDULs5NZO
         VPjQM8JLS+MZc1ZiXjHHkEwnhV+PuiaWFhFf9p0MTAdbBe55yq6c10ADVqJgMTj3PLJA
         8MJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VOEwoWxhkHAzPl7z/kfmfgEp6lBpU3TPL7nXC62jp0M=;
        fh=3Cs28Wq8/W/Xmtp2gjKigllgEUhzGrCZICJcE1I0qrQ=;
        b=Q+lThyRhBBNVbjKKkvKAv2yCqCCzqUcno3uRU0oGx7mGmgoESRpa6ySnxLHe9Pn50y
         PKMX9m/wbMCBaZ4FphQ2/2pTtBrmOE1J0n8niXgd6lturqZSNQNETDQ2Wmwu5JHBK1Qv
         pG97KRSgOAM3CHAVj/P7whZtS55GOcgzzs8fm0ZpWWK+kai4pmZue2n6GezY3MqVyNzQ
         CrjbBom734KXhjDKU/zMCgwPxwm3LWK+rYi35UOB/NTeOknDnfaHMIyHqUhdb5Oj4jnn
         T63/Le3BdqtvVKveHWhoDvkUmekVqseEiT5V7e405vN17fUtFwIryG8QaWCkAIcAabcg
         SGNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784821766; x=1785426566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VOEwoWxhkHAzPl7z/kfmfgEp6lBpU3TPL7nXC62jp0M=;
        b=qydzhXXxoUmQUHcuX0XxEnYV0oUiS9+jjqrtrgxZlH+xI6BIG2GSoSL3uzqge7v7+/
         sHtbE8aBM7q1+1Z12jrrYsx3RqUTlFtyeYU6OB0r+LUlCsJy8z5sLai1ry7B69/lPbIL
         5hbU0mqHzRH8H/0HPuCmgiDqphisYlm++yw+2UUkv45H8ehdMcJNrBkLYaTRFtxg24rX
         VvQ6x6RH1gggbahKKr6leCLpLGbmcwtsDfA8jNie6VGe/y8S3y5SgPFRBJMk5A0554RG
         lLkrzRn83K35xbxQIdIiZ4O+IqEXl4Wv8JL60XxOFZ0Z2PABaLCqu4ri4g5VqJYyoeHc
         c+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821766; x=1785426566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VOEwoWxhkHAzPl7z/kfmfgEp6lBpU3TPL7nXC62jp0M=;
        b=XG5cEdUOIA8fziLk1r9yzRLyVJG2STNi3ExX3n7Brc0m/YpgmJ+R7sbxflRQHjhmxy
         rUnMpT71gKhxGV9XHSdzdlOzQ7wmeiyO2K8nDlgWFFje1q0Qu4oNeYWVMn3sjTsJUaBq
         7lBm37cfdVbNlu5S2XmAH0y8bYLwucf4Zpkxgdbb5t0e06fyGMsL61xxmOvu9qUWJ2oS
         noGbAUVkv6XR6IFehbRkITDpxDbPw30LfhIpfCbe+00Xzw2TqRHKWLTnDazLPX3TwL5k
         +MLle/FNbAIu+wzaZQ7j5vcTu14YGo5H21Z1f2Kv5323ygmptuleSXLca5aMn3Q5Ydtc
         JwvA==
X-Forwarded-Encrypted: i=1; AHgh+Rr/RLIwTM2/wYofAJFuYAsh/fjJxFQgJ7NM7Jd4fI/HRdNYp57oA0VZyDWITP/uwDs8EkxNREabtAB01Stn@vger.kernel.org
X-Gm-Message-State: AOJu0YxasSzeQ7XXSjUS+AQFF/PC/BdLtQc00uSH6BxjHeuE0TB94gdO
	VrA14II7z/4oHob2xBoMpkZxcdadiu/7lXKo5EfxWnanPWlyHf4WTo7pCBpZPHIdp3Y7ZCkZC9q
	lPOX6Uf6uXol7O60pEBMHV2YF5w3Azlw=
X-Gm-Gg: AR+sD12TbNeIjZ7frizXasMqjwJXwcUOXR5TbzuK6dH0c29fKMW0Ur+HDLoOt6pfvBh
	s4V3GzuLpVzL3G6MYmaYtWHZT+XhZwnSMGHEeYLfWqt0uqY1M0XZQp8Me7lsjW9gKsTz8PqoKW3
	KZiiFBYRqVsUoXvwzmSzkDlWENnY922mHTdpoQJoane8d631+AyvVPyi6NMtwsSFXnNfDRwDwNY
	5l1neNZ/YcFbeEvN0UPPIUGpz1565L/Wc7JdHqjhVKUKyVJnCGkGmwT+wLSf+ukPDN8NoylZ+ZV
	BhplD5ZrXE00XFkh7SiCsyWDKPO9
X-Received: by 2002:a05:6000:2501:b0:47f:93b4:2df3 with SMTP id
 ffacd0b85a97d-47f93b42e91mr1757333f8f.60.1784821765658; Thu, 23 Jul 2026
 08:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718093723.153324-1-alex@ghiti.fr> <20260718093723.153324-2-alex@ghiti.fr>
 <amIZp7Ual_6Gu86T@cmpxchg.org> <CAKEwX=MxufM5aNw2xW0f1UcyfcCJbtXR_u3cK+coRaC+_bLspg@mail.gmail.com>
In-Reply-To: <CAKEwX=MxufM5aNw2xW0f1UcyfcCJbtXR_u3cK+coRaC+_bLspg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 23 Jul 2026 08:49:13 -0700
X-Gm-Features: AUfX_mzB18adyCkRw-msPjHBQg9MLv97pbCpvES0UbLhVV73Fu4FFLlFb-JLgCU
Message-ID: <CAKEwX=NmAuo+-sXzQj51-sRGdfcjTb3_KaW2x_4DnjQM6n0piA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap: free synchronous-IO writeback folios directly
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Yosry Ahmed <yosry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 8:38=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> >
> > I just chatted with Alexandre off-list, but this path does not store
> > an eviction shadow like the reclaim path does. That means no refaults
> > are detected from dropbehind pages, which can fundamentally alter
> > reclaim decisions, zswap shrinker force, and pressure detection.
>
> I think it's a zswap shrinker bug even before this patch. When we
> allocate a new buffer for the writeback request and add to swap cache,
> we erase the old shadow :(

... and count it as a refault :| Which is even worse than just silent
erasure. It throws off all our workingset tracking heuristics,
inaccurately reporting refault on a really cold page (writeback
candidate).
