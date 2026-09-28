Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721774FD28A
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630680; cv=pass; b=NX4HUk5hXivWwsUPw2IhuW7NIla7IVfR898OjPXVT8pCiSSEHjDVfFgy3oN/lRjMVT+AIc/UqzspRRFs6qq4vmmx0Vrb8kMZTj6FzIdqcOtaLJv/lBu1jFNQ6mbIM7uFReQ3AVMUyUeJ3NIQze9O7BPWLNb7ZAn/o7L4QG90bbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630680; c=relaxed/simple;
	bh=VwmjfRX30qlLvfHkzdIlAW1deTn0e9Rmr1qO2nmwcHo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/WZi0WMXkgTHW4vXX52GY57MEgKcX+/afksQd/wsUA8l3Bgu+K9CB8+PTm2MjdUruanMrXipnjkQTytY0S6HHfAaT5X00WeXSxZ2zYrbINNs2cwpPAfCoatlkLyFNtgziw1sf3cLDRyu0jmHedFtgPTqfOtiOb7xtl0tUHIXMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fgmqGjz0; arc=pass smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fgmqGjz0"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-53321c5743fso41582391cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 14:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790630668; cv=none;
        d=google.com; s=arc-20260327;
        b=oyPzeEZUswoOeUcTSWWECHNlFZRvwqszCuvjlZgKKVVnwvvIBw6rOkQBVUibmwMQSF
         lt53w9M/8dxRFaTdoEke4e50fxS1CSP7JgQUDNVVBu2KUMQ0nb9oZG+NaXIMc3132De5
         gVmLZM0t7/hi/dlxqX5QYWGt4vRkB1/Lruv2L5K/CjW51an0iLDL8pTxo3vRhVbxvYhR
         lahLx5y6qRuvM0n5MJNbcMkyVQNcXDLLBC8xdWM08Trl15osZWBzljdCyNsVZjkrnaBG
         aGslwsSKvDtOENpFguMvo5tp2ONo0upRivdy4KupF+ErEGVxmXPll6Q4p/Vo209G339V
         BMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=VwmjfRX30qlLvfHkzdIlAW1deTn0e9Rmr1qO2nmwcHo=;
        fh=MAdlSlqcGmdQokZ6YW+dna86KSaV7w2dNf5OnWDZBMU=;
        b=MdzEqt5QNYu7lD8N95Q7/lmhOEwlMwIYzuh3mlXz1r288ruywV4YqYNdGyK+YcDgqW
         SEHjGO4tB06bmuAJ+WwEsVPGuXFX9oDMFnn+uByNIHMkLSWwCqXi/o7O8kN6pftQNWcG
         tP6/5hwZnlMU4dVuypeduQdAmM6lynzIEx7wjjwNZfcTCM5Kdw71hErqMovrNriDz94G
         dbH5b5kbOmb1YjdiKSfwcg0+ERXY0AOQM8q9NhWP2M2VEb5w/0fxQMznomkSqaxlyL/A
         2/uOYQfu3BIHvNnk9vaplZau2WLL8+FW2n+fRNJ0Y2k3b6nrBWMbQZulKxw8X3tDBYXN
         td9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790630668; x=1791235468; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VwmjfRX30qlLvfHkzdIlAW1deTn0e9Rmr1qO2nmwcHo=;
        b=fgmqGjz0XKEqVjk00R1DNnhMArHsG5qPGBjp9Hk+kq8A0JBQXLUiaMTIcPI9P25THG
         3b5J233ccdGiP8jDwL1h1eH635Owie6FA/P8Gw14vNiFyoTVBsW4FbXc+hRduGnxiRrz
         oAoHCEOKYXm6/Kd0dJjPRv8yGhDPNlnydEVwoU5rCXdqAT//S0A/7S9qNjV6EpdXO/XM
         5/FrNdnUfC+QWr51cdW92LUWv/uRUpe+OBxvpOHLxDv12XZ+u/Y/xROz/MHKEQeFmf4Q
         qMJ4CpVe+6zVOlcCFVELXDFN/5Ws/KOjCyD2K9wEq4VN5FP7SkAC1ypNabeLmO22GNLt
         0YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790630668; x=1791235468;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VwmjfRX30qlLvfHkzdIlAW1deTn0e9Rmr1qO2nmwcHo=;
        b=JmtNDkv7b8f0JZaKTEvbCvdsPWMLazxBNIBeOTIildDLBJr1odgP+wMsdnL9H8gFOV
         zyXc9pVV3RUkAE2bzij9/4hN+7pnsAaCACrrWeUor1dNdDFjg22WB3opugXzkpzYfVtn
         NWCLa3oW8p1v82hvCEdOUjbN38pLYs5uaOcEjnxZ166E8zttxt60N6JeMEp4/YZqLsOm
         69W88YJz2+vdTE87Wn21oYekuMhG/FtFCUx8wJDd56gQu8d+loIUi7U+PUWijDOYiajh
         TRb43chzz7MfLE2+4eOtWqQlpd545/MaSFrFCcl/Tw4VFITRuS4rqehKPMMUTJBmfE95
         hKcg==
X-Forwarded-Encrypted: i=1; AKwUvBx0bGwvWXOdx0r4wM1yc8LAH2zSlwpruZ0xEOXA9DmTau4laMh/dYXaV0d87SAD/2gBTneY9ATee/lX9B5u@vger.kernel.org
X-Gm-Message-State: AFuF++l4JsYAngGACxP0FDv7KI1Hxk6pVQwh6ioR+WCRJyted4PaNAZ/
	2OULz+//ShUEGNabeXBm4gRiqfLrb0MA+SBViKjJki/bxUeZ1/Y76FpArUpnV2h/57i8C9sPUhV
	GhHtWPyHyORS3Ud0gl8o+JJ97/ihHSZe48V+M4l2h
X-Gm-Gg: AYBFou15TnLmSVKHOArt2ST9h+1EBh4Xqlowf+nSFzFu56i+Xl855rI3YnZ7UGx3Me6
	71hh9Kd/cuqYYDcQL+rONeOQB3ujzUvycfvYrqB60onjj/OX9qO6t3RgfPR2OStwUm+B9jJ5SXP
	ZuOQLSnnMeEMFcBBXE4fan8kFk3jnB+gAhYnlP5yfg0ozoiNITZ1gwMY7VqlFMzuu659Ad4zPB+
	48Q5MGD4c40em8iwq6HbcZllqhG4XVSyPe+vpKxstoya/vEEgBU839r4VEEQkCABGWbUAcADdnR
	ZBk0C5cwWV+jZDX8rsDkASizIA+Oa4jA3FokFWGs3rlo0F5ZDym40vTjPG2CioIkI0trm6Pq1Hp
	SL5SnonyDRJzjKGeBkc+FY7sLTyX15dxiysU3tEdKFQ==
X-Received: by 2002:a05:6214:2c08:b0:910:6d8f:a2b0 with SMTP id
 6a1803df08f44-9142f78af11mr227967976d6.31.1790630667515; Mon, 28 Sep 2026
 14:24:27 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 14:24:26 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 14:24:26 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260825090827.64550-1-iprintercanon@gmail.com>
References: <20251117224701.1279139-1-ackerleytng@google.com>
 <20260824194755.216000-1-iprintercanon@gmail.com> <aoyqIBz1EoY0R8qw@casper.infradead.org>
 <b682a12f-ac03-4032-851a-f4f7ced4ffa0@kernel.org> <20260825090827.64550-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 14:24:26 -0700
X-Gm-Features: AclHuK-TDRyZzfWZa_wtY0yn_v3V9XO6Vja5ihTxfsBMk6gZzeWu994aItDlqUM
Message-ID: <CAEvNRgEQdasV3i4xcs6WCgrOjxDvrZWHqaPa6OVKqShW9iOQxw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Extend xas_split* to support splitting
 arbitrarily large entries
To: Artem Lytkin <iprintercanon@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Cc: Zi Yan <ziy@nvidia.com>, Kiryl Shutsemau <kas@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Artem Lytkin <iprintercanon@gmail.com> writes:

> On Tue, Aug 25, 2026 at 10:31:34AM +0200, David Hildenbrand (Arm) wrote:
>> > IOW is this driven by a real need, or just some completionist thing?
>>
>> I heard some use cases using 512M THPs on arm64 to back VMs, but it's mostly
>> anon pages, and not really ordinary pagecache.
>
> No real need on my side. I took the pagemap.h comment and the selftest
> skips as an invitation, and the one 64K user I can find on the list
> (Meta, in Kiryl's collapse RFC) says mTHP is what they want. Dropping
> the arm64 angle.
>
>> But a buddy-like split is clearly preferable. (or avoiding splitting in the
>> first place :) )
>
> That path exists as xas_try_split(). What's left is the uniform split to
> order 0 that __folio_split() still does through xas_split_alloc(), and
> the only one asking for it past order 11 is guest_memfd. That's
> Ackerley's call; if he wants the rebase I'll do the mechanical part.
>
> Artem

Thanks for the interest, for now my plan is to figure out some other
ways of handling this, like the buddy-like split. guest_memfd has quite
a lot to go before we get to this stage requiring the xarray changes
too, so I'll defer this till later :)
