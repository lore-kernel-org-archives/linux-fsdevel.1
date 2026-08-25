Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42293B585D
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688431; cv=pass; b=p4ELl8C3qxxpR+IediipIe1zph0WGts4DfxPF3noTPFCnHCMhW3reuO/tcwsKiYKBxZCEqJAWt4tG6AGNW0fhb71lvZzsBHhGNyTS2tJZ5TgzLhb7+crOWn7RN6QqZEWWiFweTCnlT5VVtL49Jq9f4sVNJ7AccssiOdBSyZ+cqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688431; c=relaxed/simple;
	bh=YuDwdWxWI5Vzf2u31gjFFz05KsfDHJyOtaNcUhXTBZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOBYXm1EKtSHJVpD3b0dGOfRue9YSg2zSOpq5RCB5pJyLpTO3HmujuvD8IRtytg4qiMoWMMUM8mkecFP44E3IYcfB+liwtkCMqhCRE941Prbwa87Kz9NmpFfpnYZcBaXnE7Kx7XAWVQxAM4IYuBqk9QNBXji6jRRa/C75uYTxnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKpEO3uP; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKpEO3uP"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d3b440b97aso6455ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 13:07:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787688429; cv=none;
        d=google.com; s=arc-20260327;
        b=kj4N6Puln+JlPI6vopOHlFisgPEvO5WRobxS+CwpI0MGgd30TZoNwksVnQuWTfGCRR
         RKXTHkvMkDLRdjvAyE6ad2y8pj6aqwariEf2v9qnv7UFFxI4wyz++GRdw92aurN9vEhA
         kSHMBqh/uUJBDGKwYHDGk5aV7yl2Ut1DJQALcw12rYXE/qyLMqYi6h/g26zm9g8cPJwI
         wQA/+2E9DT7AvyfjUlVFrdwN5SnrzgT4+2DbyI2cJPszHgsJ3HJMPPfV44xkIXCyeWL3
         b4/Yz7+uQnhmGuDabTbYduPD3LT8Uq77qSR6ECEnOFpRgrlHghfYYHf29pUIxUgRGlSs
         vuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QmpPvlugr4sJVMK76hZIVWaN8XuXLrWZ5bMIrs2ohCE=;
        fh=36dnAV2SKhvrZ45f7laxbSr8QMSWvs4m/+1rcChoM6I=;
        b=ahZCI4Mu7i+h0aqtqgisMVDM1K59KkXRddI0V1AG/uVECbWltBjTFIr7/rsyzd6get
         clalgjh6OBRaN9bBHBL54WY4SqPHwmozdDD9xxW0hIjr3TuAp44ubonlglAiN/9J0Rpc
         e2UDyFOVr7bpUZ48ghhtcofY9VOxxHfWlaMvyecCmz2PwSvdU5doWXDEWJoP3G9+Orov
         CiTLaQJMr4Qgzq6okk+jW1gQz7kG8Xvcl99HfbMHGdrqpez9VXkvdXGN1+8oHhPwm4ja
         WpBdBhNrjkf/Hb/EKPR9urCbGiQAKX+7hwxvH/JB40jM9YZKeF983kugTD8CLFjY0fni
         vvgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787688429; x=1788293229; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QmpPvlugr4sJVMK76hZIVWaN8XuXLrWZ5bMIrs2ohCE=;
        b=NKpEO3uP3XiMvqGfLcqjvFeuJ8D5jsq8I30qKsRalF3gtJ3h4tH5Lafr1necQfKysZ
         XQRl7e2mqv37A2Y/hJoax2/URWgHbgF2/9EV7ks01fPYeDmugp3BOYx/jOQ5mfF4wh1q
         dwEZ1M8UNmRseI9gwbmaY8S1g6twVjXOhhGNJFTN0V6xYaVLSe5URyBq2sAcCeaW02zk
         lOtxG5ieucnN1r2q0ZuCkOW/k4vvZNLBGn5ByYKUilxok7L0S27kYw7+IVB08EPcvwU9
         g/orUJwfXzxLC72dfLYIKNoFLdSJ9opP8lsBuAR3J2zIgqq3dnNK+qz55nJ84H9kgK6p
         z7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787688429; x=1788293229;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QmpPvlugr4sJVMK76hZIVWaN8XuXLrWZ5bMIrs2ohCE=;
        b=dnbtgYHYnAdDePqEUkz+7cjRgel9hc9RStijZv702kZD9aJhAVTdiz66FLKKj+whDb
         FK6HgxdGoW1wcoIbjt1Q1xQsN6vdg1nWtRA01FvYoRxnj+ksgODLuu9w41gwrkO5+RW4
         SMW7V2WOGPHIulFScDGsq0bJ6aa2/dkGcPvbm5uJQ7kf7RirctnpkXktfydb3zzqIpcq
         Ecg4dR9GnncsdT22HQNpY4Ct+8LgwuKX/3wKPIyO86LJwP+teaYr3a/9KcA/hY2/gIew
         V7SmMM3UPkAvQGWFUVKeJRD0+NKbTlFCrmxewry1DxY180GAjp0g58w7/ue7cKJ7+su+
         1P0g==
X-Forwarded-Encrypted: i=1; AHgh+RpGXZURp3VRxdBIjycwWFusHwhhmHGaXac64wEsz+gLIZEmwU+gLZQbD42pNAS8hayqyBaBT658E8FCal50@vger.kernel.org
X-Gm-Message-State: AFuF++m0bfUoq8Llw0aRYaoVpSyPz0F+4bmd57Kvn1kffj1fsz/ixUXr
	cYKtJGZj/D2Qv+sqzNo86FFCvLD6Mh0d5Tqa1J7i5cpmk07qO1PQsl1woeY1wJgsUhSf8B2/XMr
	QYLoVxNoYXZ3Xp11nZG0oeg79+iCiUr/T3/MWIE6s
X-Gm-Gg: AR+sD10Bn5JYQIFhrzTM3caMmAfNsJVux5qPXdu8DpSOTFKyq1p/OgPL8f0C3nPBzxe
	ErvNzhKtqBsKn76duVd3SVWELt64oQkzd6T3cjpOjMwQpW/kPN45nd3waxMdhhmZD9PaZD63G0T
	YFDC5hhuzHt1S0ObS0mEnJgBV6qb8qP1hmWLWj+P2fSjRBdE5kk6vKEhjJwJz0G0JG3klqwvdXu
	PjM5pKN9PR0v/1ZRX2b/MSrjgEhk7w4wC6sVGX73esyyPU/AXTszXbAclNtiXQY7cN83iJsMsE8
	3ReMV5zlxDcl6LAYM8AuHfp3EMtFZb2CRf9M9rrpUh5aeMXw/aIyb9AAcFxbWt0OTYnDwCSXQqN
	qDi8ARTn7jwc4NN/J5kGJsl7/Gx2g+Q==
X-Received: by 2002:a17:903:4b4f:b0:2d5:c090:3810 with SMTP id
 d9443c01a7336-2d70baa1fdemr376215ad.2.1787688428259; Tue, 25 Aug 2026
 13:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aoyWln-Gt-yvZQkE@casper.infradead.org> <CAG48ez0vXVUu9j4rYUeCqgwyHKAiN_6fL--D90WvX9q7B41V-A@mail.gmail.com>
 <ao3y8TtEGjniZ_4f@casper.infradead.org>
In-Reply-To: <ao3y8TtEGjniZ_4f@casper.infradead.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 22:06:30 +0200
X-Gm-Features: AcwNN1U7imKfFFWcqWcxt2X9g3kXc7_YW65q6sOXIrpi9lP4BGYdXKwulbCkr7w
Message-ID: <CAG48ez1yGUcS6AgtPXnmPQDmVCnJyptu64YGsTw=9vxAN9BO6Q@mail.gmail.com>
Subject: Re: Removing ->dirty_folio
To: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, 
	John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	Qu Wenruo <wqu@suse.com>, "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 9:54=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Tue, Aug 25, 2026 at 09:35:57PM +0200, Jann Horn wrote:
> > Could we strictly ban using get_user_pages*() for write access, and
> > use the unpin_*() helpers to somehow enforce that folios are always
> > dirtied on unpin? I guess the problem with that is that we have no
> > state that tracks whether the pin was read-only, and finding free bits
> > in struct page to keep track of this is hard?
>
> We'd need a count, not just a bit or two.  A pincount for all folios
> is on its way (eventually) but I wans't planning on tracking writable vs
> read-only pins.

My thinking was that once a folio has been pinned writably one time,
it should be fine to mark it as dirty every time it is unpinned, even
if some of those pins were read-only?
