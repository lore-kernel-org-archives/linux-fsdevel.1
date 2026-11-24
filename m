Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795535948;
	b=dAJ0zcbg1v7QtgKyqyKlSFw/djMQ0y9twdxCnvz4pmWohLvwf6pf9ZZL8QN3oI9ZXZjb
	 7n/tM5zkpxLxcHiTpAxQIr0lAKQAFqbgwfq+CPtcb/AHRjTjnM11G157nd50eq3cD4CV7
	 7bzLGXLLQ0bK0rogS6vqd2wNZKdspsDzoPifICDrRWRJ2ACiFWdz9v67XBueVc+qBVWol
	 7ggi6G1028d5FWc0EgOR0Oumy4YPt30uyfnU+AYPSd2gI4MdqhjLhoZG+1JcSEUy5LE61
	 dRS5vz5+KoDpFcWKDgqeWCWiTDP+lCMoaCOelv1/qpnKcC0M8Flv9zq0wUlfUtboI6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/74Ri30W6oVFNU4eqK6RxVx2Up+VW7ByxGiC/VStVG4=;
	b=F6sEez8jvbaA55nhaAHqFCSpuVkisnB71JVXmL2Yo/CdtYyHqpFqjf/5E8Q+DVXIrw+5
	 jUZaE6TusCt0wVX6gg4JFG315SLExGeoZhYpc7I+QeSU8eOsqkT6J7cwYSqw/7TePTnxI
	 hvAKIGo0LROJ5Nz339ulCPIgDlmK4DyNtXjl63HNhkCSOFjKEIjB4QaVxj/E6GILYNvZS
	 cmzrPTD2aCVZMFf09UA6TIKqyw5s8VjuSLopRjpCTwqwJHHXYshiddlQm2TnwdOnYWKQX
	 caqwur0UlTVPlzwNuHVcb8CF07aKXJ1cbXazR+yyoxpqnKBVQ74NJbTJ4n1EWVVIp7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xe6FmElH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C616606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 15:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C616606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xe6FmElH
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e3b22e971so2465647f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 07:59:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795535946; cv=none;
        d=google.com; s=arc-20260327;
        b=NFFEnOF+6Jg8g8Lr2wySuurLdmv4ljbz2GleJuYwTWe/tzDAhvUCVqodY0A1yjXWJz
         21sHRxib9ZR7eUbUEAAqjRqCiZv5FZNmIB9N4nZoECg51CumZ7xpPhj4SDySG0g85czb
         IBBfn1FjM/s7LsfgpgTJgZ/yX7NQ+Ch3KcPC/05b9R0i8gPxnLptgjhepgnJOJWIz4ML
         Xkn13iTNZea+ne3I0ZjUofXE96f0Jz6nA11hM8hJC4/yuCwUHMBeTO/A64VvnoiHwJtb
         TugJHKWstSZKUxcUJDuQlxFBgkV/pCCz9mTv+14u1ZkKE3/OsLhoZ4YWPgA3VBj38G5m
         D61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/74Ri30W6oVFNU4eqK6RxVx2Up+VW7ByxGiC/VStVG4=;
        fh=NRdH7fNQWLIjNg5U37lK3RbJEj44uLdFYGNdGuZzeQM=;
        b=NnPNZ6n9FmVlcRxHOchcxbLKC6eVH8Sq5Mi8EnZpIA3A1ojwGSJEeTVN0Bw/sWYBhZ
         gnllzJKrD19qeGjzG0QvEx3SmQOawD++MCOTGWNd0y2xlj8KzGhZYknEcltsomVMXLRl
         S4FXByRGUKsyq/NHocfCFyYpSQIJc+sY4NTUYAlI7SgOO3ykwqpCGNk1yInDylukBWrx
         Lxk/mv0O891upTu9ClWUH3jWAidFtu6nJtjL0EappXQ1xLl/Nkgo2GQPT1XD343CTmOz
         yvW5U6Wjp7q9VRAInrfk9DlTJxMfZy0+PfdGSad4B2TJU4zg1SEqj/pMyuwtbSuQtXsm
         ZzrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795535946; x=1796140746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/74Ri30W6oVFNU4eqK6RxVx2Up+VW7ByxGiC/VStVG4=;
        b=Xe6FmElHRDHd8Mzt+qaORfLww3jW7bzp9w3MVasJYUJ2bJZdnE1Aw1mgy2NKI2sena
         dDG8JEAhbJYTTlbinXSZDegIk7R+F17Ou0v5XWKXNH5HlC58k8XA+UB8E75ye6x1hAxJ
         ga8Yx/qOWO+gSNY7Vkwg0B2Tu2ULmqkuiyfiTbxDBeLSnB8sybLjyPIk02kpUmWq/QQW
         a+gkQYsudrPJpFuZ7BZ/19Nccy2+fGjptuK6LRS0+5Tu0+jYay3+7DhvzbdQE9Wo/1A8
         xdns5t2s1hz6kYA3WVfIgT/6MY445hPydsnhJ/ULT4FlMJPvGlHi5HjWjed9/+gZZTCn
         d0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795535946; x=1796140746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/74Ri30W6oVFNU4eqK6RxVx2Up+VW7ByxGiC/VStVG4=;
        b=yuoEbsuGBg7TSMEUFWIMwTRyL5doCz78jDn6vOhNdz8d235WR4DsERyNCv50mi645L
         mnO5aAbR3+rVzNfJWVheQyfnePQJiyZNQ5A6RmgRoVuO82t34bcmBSU9JwyoUWI3m8Eh
         TXbW+NMJhiiKvBxfkxezY6dchcy5LMrcmKg1iwZ/0sUYFulIre6Rb8wKBL40PuoaEvq1
         5ZhVGvhQgYGBsLfdfEB3kHdW4GtLscENRGYDCIfFXPVaqwhgx+uY13gmGNFNgRN0ObvS
         2Af0JLwY+HFtm+Tkgtphm6Q6ou26E0PGSIZmN7Yti07QByc3NWsZ3hCCFeO4m3Ord+Vm
         LJFw==
X-Forwarded-Encrypted: i=1; AL+hErHpRis5mRrlO8q92WDEZ7AF/h2MudWSvTcYsPrF9doxMCxsBP+SdFUjxYp2E1CiD2U6oYNp6Q7D+cYeP2tj@vger.kernel.org
X-Gm-Message-State: APuU4Z+R6Fdsu/SxTk/bdeNlBScKAlXXuP5mNLTiIoazmaeO0Q+Y1df7
	Oqz3jq5jJ6Jclu+ZGGCw2UwZgCvlLYfLSA7sfginStlPqjVD0lVI34IogWn44E97AdyUGvflAg+
	sHSxWZ+xFuavQWHkYhibZTtAh7A7NTgo4Bt2WgcA=
X-Gm-Gg: AZFdTZdArhla+c5ZKs8DATu53Hjews3PecLid2ojwlgEUDuICZl4ZoJwSA68yCqVD1I
	oQtaGVcWQwPfwfI2F3qBwxMaUjvoyZIQ6GNfjHKHD8/kvPiQ6pgmnX2YE6rxvajnTaQLwZu5hg2
	1VqRdr6A2LRFVKZwJdOzCCBWr8ZUyFbqiOKNcCQfnivdoTuivwzudCFEaD6nyzSe1tBJg8DWPMD
	BpiCM7R4B2kx5V7kNU3PVeP0FJsq5i1G4SuAk3tCYG/JZgSKnKScj1iun1KfRvdlZwwz+fL4QXW
	Vgtz83KLFPVaYKxKaE39Eh6h9S78qOLBfP1tWsovshRwac74bWiki5jc66BtqmGFMsnYaFMckrH
	hFx8kv/WFHW6hJyNSqApM2oSSOJtRaCpovm5Ne3mOaqQuhrkTA40FPm9IICxr0S7qejTOg6vcuk
	jrnpM0CGTNDe445EiMrPerFm4yrDVA0AXyU2cLh467fYPIRJgsf1Ae
X-Received: by 2002:a05:600c:83c3:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4bb8880ad68mr297552635e9.5.1795535946309; Tue, 24 Nov 2026
 07:59:06 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123030014.3116755-1-bsdhenrymartin@gmail.com> <lh4cnpy2kw3tdtmhubwhhvim25kxpqxo6xttt7sihyx7x5hqdf@3tvivew2qh7m>
In-Reply-To: <lh4cnpy2kw3tdtmhubwhhvim25kxpqxo6xttt7sihyx7x5hqdf@3tvivew2qh7m>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Nov 2026 08:58:55 -0700
X-Gm-Features: Aa3M54pAoXL7yvOyF5JJv7RxaB2ypj1vzahwa9xON4kuYDyLqPQLjNR71spFULE
Message-ID: <CAKEwX=Py7W0vOwxKdWMCZu3d=BbF2OkgDt6Tu_AHhEJZ06w0ew@mail.gmail.com>
Subject: Re: [PATCH] mm: fix cachestat NULL pgdat dereference on DAX mappings
To: Jan Kara <jack@suse.cz>
Cc: Henry Martin <bsdhenrymartin@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 5:42=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 23-11-26 11:00:14, Henry Martin wrote:
> > filemap_cachestat() treats every xarray value entry as a workingset
> > shadow.  On DAX mappings, value entries are DAX exceptional entries:
> > same value bit, different bit layout (flags in the low bits, pfn
> > above).  Decoded as a shadow, a DAX entry yields a bogus node id;
> > NODE_DATA() for it can be NULL, and lru_gen_test_recent() then
> > dereferences it:
> >
> >   Oops: general protection fault
> >   RIP: 0010:lru_gen_test_recent+0xde/0x300
> >   Call Trace:
> >    workingset_test_recent
> >    filemap_cachestat
> >    __x64_sys_cachestat
> >
> > Any writable file on a DAX mount triggers this once an mmap write
> > fault has populated entries.
> >
> > DAX entries track present pages, not evicted folios.  Count them as
> > cached and skip the workingset decode, mirroring the dax_mapping()
> > split in the invalidation paths in mm/truncate.c.  PMD-order entries
> > are counted as one page, as value entries carry no order information.
> >
> > This issue was discovered by Tencent CodeBuddy Security.
> > Cc: stable@vger.kernel.org
> > Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
>
> I think that for DAX mappings, cachestat should just return all zeros
> because none of the fields really make sense there. There's simply no pag=
e
> cache for DAX mappings.
>
>                                                                 Honza

+1. This sounds good to me.

Henry, would you mind sending v2 along this line?

(and maybe add some documentation).
