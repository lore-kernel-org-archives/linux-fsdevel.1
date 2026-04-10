Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6893CCFA0
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775835471; cv=pass; b=JWNqzl1EHlHi3/gr29ew4HYFflit0OvmrFa/dlWSlepPC1OEt0DXIRapDF2BomQO045MvuucC3RHjI0UbWVYV3NGr3QdUBCWQyx6G5ckE73RwsqyKswcyaOuHcwHeLkrt9EBLukFeQfDL9YEjarSZIXWKd1YsoRvr5qsMndK8sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775835471; c=relaxed/simple;
	bh=MGuRD/MCalLka4OdrY/XtMVyueCoLmTPqP8ySD9Tju4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PuRykfbrjCd5l3buMosJ34jXNbaOFF1PkDT1QCXLQa8S1I5eNjGfNTfJivfKLKBTr9Vr6feLMg84Kht9n8S8he3R54rm9+hQ+7cUL/JEWLh7kUTJMlejKfYYE/7E6n908SjqtyeiFsTss+pWepTJ4jY3s03bMhFPErJ/YSdRMDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KArir2ge; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KArir2ge"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso2909628a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 08:37:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775835468; cv=none;
        d=google.com; s=arc-20240605;
        b=SzOCrykpq3yVV8BC2BXEPEjDRF71qc8kFffw5EBLAYM9Dg5znuyYBmQoSTpDYejadm
         BrnwklPDZs2leV2TAee8NuHWveWBCyJgQ6SmufxOw2KHrd6vCBJBX7vOfVP6c1ls4pEu
         y4C9nAbJicvfCvKS91DeegO4sm0J5yaXBdtXygIAbNfayClEItwmntgEcoslOoAlVTdC
         p0d6qx5mrJGz6boeQC2UVAXSww98/rvCpd6Eq/cGPSbiuzPjW0uhXKexHQy3TlH2atcD
         1FRM8GVTMNNRaBkyGsVqtqOsirNxLGqZVdVkNIHT00AInyDc5ZpuiyhAhCXBWSXZOE6m
         sbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MGuRD/MCalLka4OdrY/XtMVyueCoLmTPqP8ySD9Tju4=;
        fh=Ab9oeLisT6RvSodLLP62OTJghGgBf46YnNNMuMzrpHY=;
        b=By7R1kuq+EuT8Ys/IUN+loQ3BAAEIxnY6s2aNNlKXU0zXmeGw6XvdfYuTG1N2a3mB6
         0KdcUZr5NwWvD0o5/Vr0loM+MGV4SWgKyyhnk1e09fZAwqdINFDfhw0JX7L3HMT7yAE6
         atF0kDA/cIzwN85HILtUWjReKKubLDJ4tejf/ug2aIhyWgGflvJL60cKCKpiLUCQ7jEf
         xsnjVYNSgZlJfsFHTWL1Tjea7Y1ixgBcUsiJ+omk5Swffo6xnqjEwRxo2Y+bNQfE76jp
         OFoWRFXtt+Wf6oELypivM+MKZQ807ZtUQUPPsNorQNi3tLv5Vz01am38z3gfwRz4EN7H
         5H0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835468; x=1776440268; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MGuRD/MCalLka4OdrY/XtMVyueCoLmTPqP8ySD9Tju4=;
        b=KArir2ge2J4yBkHfGfWkV43Iob4hCtb9RItNqY+IPQTKkKXiIWj2DmdzTGkp+gkVK3
         0k1IT1BdJru/bp9i7wD5LF9Wj/lFwOPZVFhR3QtDYxma3dhZN66U7AH7AcCqb/j9Z1Tl
         JXX80AtKsHwYTol3P42W7WKmElrQW+Mg5ZotsvmlG+a0fx3KEFQ4RwHIQMjrFgsrqeak
         7pcIO4Bp0I4pmOK1jJBAgGc9umGhJNaNn3qej2TV+A71115v3P7AM1Q4X3kPPAgdZ5ie
         kd92QBffyAh5yfd+NhomGugrJv/IFUaiCVfXoppzVOklFXgd+qXuh5qavwnlE+b0VIlN
         f3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835468; x=1776440268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGuRD/MCalLka4OdrY/XtMVyueCoLmTPqP8ySD9Tju4=;
        b=mLLod12PpEarSn2Nzt2RxTlM2aGJfFmqlADJUiDu9oWYzOIuRtcHfAVK8Jz+falE7L
         o707K99n8FCw/MVfsB/BWRKGCBtu7R1zIRa9XVpcQSCx2UfcDu2fv+TM6J4NIujkjedK
         8yGvWMDbGDba5muZi0/I+1i5MG/6XI3Q+61WvjAkPJy0b/rkmebW6J4aXDZWKW7GC3bS
         1Fxo7+dY3Zo90QrPDiiWlX5602AbcOYWWBdKchg6aa7r4ipRelb+WtHyRvwpnarw/pIS
         TkOyVhApy3uRVs8h8Mh4KjzDZKUzxMbGYKruCRHhkWd+BrT7LAmToFWWL8BAb7VP5Vf6
         QnZQ==
X-Gm-Message-State: AOJu0YznRnE0PGXBr+v+Nc7NwqBEV2vy0CUD4seHSw8qksx5Xn814zMi
	G0mVB9MPlgDC5B6Pa00Sw2fL9j133c/Xn6NlVAJ7+jbdlTDKfxOqO4lMgd0HHQn2WEg6id8kJRn
	SJ9gaLh8zAP805zo728Qz/juzuPJeXTaTyQ==
X-Gm-Gg: AeBDiev4KrNpaC7dZBuNo5aDJpkhmiuEyaO7P0f/Yf1RyqHTJK3f25M6i8tBr8e3k+c
	aDGSxfBYpoSHqYH9zAtMrATZHoj93HafA9/f9dv7tfmYz6r+mCdQK2Pz470NZgLiyJdaCZol4lE
	e2OyO/rdtfph1JH23vBXvHzPs/81lSizeIQkFSmRf852zC8L0/bPyhOb0NEZ8Or5GhcleDh0TJb
	/JR0nk2F76eqzKnEZoh1CIolgC+bU1PVEb4K3Kq29NhABFRUguza70JQqZelAlfcfhEBp/94KMm
	vWf/tF2heBucqcSsR/Cw44X2TyiJVdkHaFknr66eyGyUipeJzMK+i1zu/QSCV+ynbtdkx4cvRaF
	eYX+EAS5XDkU=
X-Received: by 2002:a05:6402:4548:b0:66d:ce62:7d4d with SMTP id
 4fb4d7f45d1cf-6707950821bmr1385987a12.12.1775835467901; Fri, 10 Apr 2026
 08:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410142403.308108-2-adrianmcmenamin@gmail.com> <adkLbCyI7ZnxkSAp@casper.infradead.org>
In-Reply-To: <adkLbCyI7ZnxkSAp@casper.infradead.org>
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Fri, 10 Apr 2026 16:37:36 +0100
X-Gm-Features: AQROBzAgT5-c0AcllkeOjFCif9qHBMCPsTIdqHoJu8Z0u7xpAgRCkNNHohwrNk0
Message-ID: <CACwZE5SctP1QAy_5_sBTC--O8ubGwFpFry0KF+CS72W=EXn7Eg@mail.gmail.com>
Subject: Re: [PATCH 02/10] Add support for VMUFAT filesystem
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 15:38, Matthew Wilcox <willy@infradead.org> wrote:
>

>
> You should add an extry to Documentation/filesystems/index.rst too.
>

That was sent but I had some trouble with it, but you should see it on
the mailing list now.


> > +An executible file (generally a game written in the native machine code of
>
> That's spelled "executable" (both times)
>

Oops. Fixed locally and will be in any follow up patch. Thanks.
