Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB9377017
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642171; cv=fail; b=FDNfCg4A2q4+V9X2V1wWM0hNhiExyIaQR1n8r79yai/aeKctvneqC+t1fRMdWDHmS8L8aMiIYEaKtvPGUh/xbUE5WAOZ3tX/ubGOgKjxw2dQNODfludlzUL+Bc8NFZBePTlQm0lQI8ZBFsVvou6eqtsycgtZkQ/V9vyg4oVIsfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642171; c=relaxed/simple;
	bh=d20n5sWTUR/SxtNPNI83SivTx7S1OggSDmHJWBU/VTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bG/PZUWm0OuOcvgiuqLgsbjjN2z9+DcVtZsJh5d9ry7mbl3MZEE0gArsi7HEAvkOwhwBX3ZwRREyo8yZUlXEsoiA9tAAJVeTXMib0el7ddkGZRndxTkimfhf/LOv41DxJOm66w1V1czag0KekBZ+zedJLpw8/jhrGJasbv4H4AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eqHt/L9H; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eqHt/L9H"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDlDVS897282
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 06:56:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=i39j9ZPSo0Qr2xtMzm51tKekm1oxcgLbT3Wlw2yCCUw=; b=eqHt/L9HIE5K
	foimN4Kxyx8g37MIUm5hs5xTLxfBxDh3a1NFffPtJaWTbPk73wAl1YJlfSDnuDQe
	7mEZ8SzAPxCjfw0nbzv0hzjke12DEoPpDWXfzeTFiEP4q4TDgDGH9e23X7p//O4i
	xp+6i6SmdU/y3wdzL3QPEbZwn4ZiHeqldTVTfbV0jCRqZx3+LPrNW3qSs5HmCvr6
	WaOBMK4hNXA3+AN3iA4PN5zx42uSu5cvm7JPFXKPof7+ljLN/PMybEla2xOBKQTn
	RcTS90gm9eD0KzzqCCzX7GGiN6YQqlVC07QilsnP0pqU+s3+aFv+U5KIkJd8ZINA
	8tgkuRtTuA==
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fg8sggvr5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 06:56:09 -0700 (PDT)
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-69c0f3a15dcso6753887a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 06:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784642168; cv=none;
        d=google.com; s=arc-20260327;
        b=LJBqFmT5Kc7PlXTL3cB0SFkQ/iFq2am4eBv0qEyezGmCBdq/oQu6TB4lhtxJu4TS5u
         dVZgzalCx1WxPJFd6vAn3rNmEFt0qAk2bPcWJcogKj7jU1XfvBawJt4PBYwlYKN1l+wj
         vbtXU3LIlOnVwOMqOM6V0mnfCN6L/qdSGGJwkqn/Gw6LEe7+1WqfDz4MHcY4okAwg+ro
         rR/qo6qLi4BvcwbF9ld6U4szmmcj1Q0RYQzXz2eXE7RytbxeqAeTidxR43m/V6COBKjx
         YFqPD9mAQi4lMbwQMp1GOh0u1lEt3CgPwXdYnsUUAGUUrx7ifqQF75b4NDSHfiL48cnl
         +YGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=gaF4gINzHeE0i2qJRc+ZrgkOrkJg7hRSLG75jHpuL7E=;
        fh=ecN958MMlbJaD+6JgfuQvWS3cQnrjr+SriJM4tvntPs=;
        b=TyNgH/Q7unx4Uf2Tyie7nAxIluiaOA81TALQ9ceyWctI8MoNx+vYIy/XKpaCGIOsC+
         xfBKWWysiwNQ4MMyrb+thBmnk9UdapI4qeBjwpAJs4BjoZj6ndhzmoVVznX0QxbYSEtZ
         hgyiFxlv0Ri1cx1ByUfbknRSNDa/hciTVqzz4BIb6zFEXrVlIiCLypMND1kMXmVJJ/Pq
         /pH0RVWZxYRoBfn+PRpiM/8e+k0JisBSk8+6U0cOG7D4kP3pIVNmsro94UJdbDBSnpEN
         brqzhjoPy6ZjZegReNRXsi8E/ROwO+Dy9wUC5AoVhB+Uf3le2/hzSxk/LiQigV1wV8qf
         EZTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784642168; x=1785246968;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaF4gINzHeE0i2qJRc+ZrgkOrkJg7hRSLG75jHpuL7E=;
        b=jWxW/Y36Ki32WsB9JScaCIqwfNYvSCxD4HtgIY9DGjOfZKhRE/ljerIc5fPs0M7wEW
         RVb0CPml0pEZfm4dvSLDk2TysY89qSMtSj6GZuFlhD3Drp4QhLKmGyi84bCQzkfICFZB
         FZmy2+JcMESvRf0dHWZ/OmeTgnuNwCbKTCnpu/f8RcThnJZsRVUF91kCaQ3zBs6tBgth
         0FVOPSZ8S769zOYA8ohcTjbRF0reDlhz09GdZr3fkdQJWW9yLh6R4okTpJ7lu3kjNUon
         FZ+TY5a1uMlTD8pMqyak3OYHg7RdSnEk1J/YoTg7/bftkXCORu7U/KwZlRFyhvI+ftiq
         GRcw==
X-Forwarded-Encrypted: i=1; AHgh+Rq5yGM18cPfWGEjRSjz3zKEqwjxyKmCA5Az8Mh6eIV2+YSPicEKTy4IskW0Sb8lvxZL6WIL7sJRSBvLAP8I@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGCCuSGDc2JNF1NETWf/rQ85dtuu3lCt0sY/itjMl+jeI/n8K
	HgeXz0fnItBt6SJFl2qwJWVwBk8NfT1hih3k63Ax1WYoCKK2pn2vLaUA38ainfSLb4/cWvd+Z5w
	FBnpaEbiyT5K8946+ldyzMgovozkNL5eft5AzwWAfVstTtMMEdiVPk3NkIjmemSY6NsLfMWGRtx
	ybKwBjeOFC+mMRC9cqh+rAisMS5umRT6/JMzUCxykA
X-Gm-Gg: AR+sD12bciWQeJkABJ0TChiOKwe/1KfqQao3mlOrV33NEbSbGy4lzI5AU77SFp4FQoE
	BV/lZo5TNp4IHL7ukJJMS3ix5nz4NfXOtL4C5DrjFgu4VtDnaN2rl3AMc/fyY6PlfUsnerzPTmb
	tvCz0iVJ+mDzJcjPcDoE50fUE+1g7/POY8BonLyoTNmG+ZoSMPhm08tA7SGmpK8fOQduTjeWFV
X-Received: by 2002:aa7:c556:0:b0:69c:5eb6:d913 with SMTP id 4fb4d7f45d1cf-69e38d4ecc9mr6571604a12.14.1784642167752;
        Tue, 21 Jul 2026 06:56:07 -0700 (PDT)
X-Received: by 2002:aa7:c556:0:b0:69c:5eb6:d913 with SMTP id
 4fb4d7f45d1cf-69e38d4ecc9mr6571588a12.14.1784642167406; Tue, 21 Jul 2026
 06:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718093723.153324-1-alex@ghiti.fr> <20260718093723.153324-2-alex@ghiti.fr>
 <al9cUqWH-72HUAG_@cmpxchg.org>
In-Reply-To: <al9cUqWH-72HUAG_@cmpxchg.org>
From: Alexandre Ghiti <alexghiti@meta.com>
Date: Tue, 21 Jul 2026 15:55:55 +0200
X-Gm-Features: AUfX_mxt3Cctj33aPUGv57TuKolyrbhcy_t6t_9xoWTK1h6XqlZegZLiUMOCUZU
Message-ID: <CAEmasaWbXLzsrR7VPUxMUOfU6DRd0_Jn1iUX=QaZm-aH61c4Ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap: free synchronous-IO writeback folios directly
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Yosry Ahmed <yosry@kernel.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>,
        Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
        Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=MKZQXsZl c=1 sm=1 tr=0 ts=6a5f7a79 cx=c_pps
 a=9KvDgq78n9V61H3VJbnhTw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=ufHFDILaAAAA:8 a=h8lhBcyy4TMpjp85FJYA:9 a=QEXdDO2ut3YA:10
 a=j5kO0B45gQVIxiUYEfTy:22 a=ZmIg1sZ3JBWsdXgziEIF:22
X-Proofpoint-GUID: dB4GH-u0Cbd6zlFvXC5Y4QRkgBXPkmjQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE0NyBTYWx0ZWRfX003lrFhl5mOV
 UpaxnvYIAnlmiU+ezjH95jMP9CnlFsJTgPI59Usb2yFGj/RojVWDQuvoRD82aFEweZhXkOHbNy2
 uE4P42PwfjUOITbKUc3ziHhatmhwctk=
X-Proofpoint-ORIG-GUID: dB4GH-u0Cbd6zlFvXC5Y4QRkgBXPkmjQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE0NyBTYWx0ZWRfX8hwhpx5BXyFL
 e93zdO9iOsv8qesx8PuMk1gRKhSZ8iK8XoTwq1n2ZMGUR1PKHXGFnh0Cq8niJbXxt+maBJnndkh
 tZ0XomfXvSO6dHvRc/MDmvQkewmzi5qS76Zks9rmU9RolBF4GhjQ3MlJPQsm0Y5yH7NyrjY7tq7
 7v/cvvfxwKVoTPtB5Dr5EVTZW2SQZ45m06KdaE/8uXKYbWdrH/OA9tpvF/Lp0MD+tyu3oCTaTSN
 JW+i9PQUz4GlZcXbeQv9cBUSVEHDP3p3FNWz1TqmF3LlFZgQJ8b8QOqVW+eK/NFA6XBqUnmutP9
 fdglkgx39uBRV7e+UeGJ6miPd738+jJtibJri2CMnrhZPn5oRWy8fULyV6P5HMoryjK9uPR5BoK
 WstWlPy87jhm+z9VmDvMgul1BrCSTlbmJuoDFeYMrPM58wkSSEQv1YdRwqTJSqjJiWtJaEjT6zx
 jxvcrInt+12WhCuxnyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01

Hi Johannes,

On Tue, Jul 21, 2026 at 1:47=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> >
> On Sat, Jul 18, 2026 at 11:36:39AM +0200, Alexandre Ghiti wrote:
> > @@ -972,6 +972,30 @@ static bool zswap_decompress(struct zswap_entry *e=
ntry, struct folio *folio)
> >  /*********************************
> >  * writeback code
> >  **********************************/
> > +static void zswap_writeback_free_folio(struct folio *folio)
> > +{
> > +     folio_lock(folio);
> > +
> > +     /* The folio was allocated off the LRU and nothing re-adds it her=
e. */
> > +     VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
> > +
> > +     /*
> > +      * Gate remove_mapping() on folio_test_swapcache(): a racing swap=
in may
> > +      * have freed the swap slot (folio_free_swap()) and dropped the f=
olio from
> > +      * the cache, and remove_mapping() must not run on a non-swapcach=
e folio
> > +      * (it would trip __remove_mapping()'s mapping =3D=3D folio_mappi=
ng() check).
> > +      */
> > +     if (folio_test_swapcache(folio) &&
> > +         remove_mapping(swap_address_space(folio->swap), folio))
> > +             goto out;
> > +
> > +     /* Raced: the folio is now owned by the swapin; put it back on th=
e LRU. */
> > +     folio_add_lru(folio);
> > +out:
> > +     folio_unlock(folio);
> > +     folio_put(folio);
> > +}
>
> Is this actually zswap-specific or should it be just swap code?
>
> Both this function and the dropbehind queue in the next patch seem
> like they could be reused if we wanted to make the generic swapout
> path do dropbehind as well.
>
> It looks odd in the next patch to have a generic swapcache &&
> dropbehind check and then call zswap code.
>

Yes, agreed, Yosry made the same comment!

I'll come back with a new version when I have numbers for generic swap foli=
os.

Thanks,

Alex
