Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2223B38AF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577717; cv=pass; b=aOpGJpRcPmR0h1BJ+jS+jLmAmXo4Qh373MgB2uJqN7hV1V6h16SHiG4z7BZcKgFaaMJS2mUEKB6Xe4nRmoUKI7bEksZb45K9P4hIVuVjsUDoF3X28TNHpykShkP1x+raeQAzddki6oZoYRzWGvw9huwJyHIKbD954g6w+DY3l9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577717; c=relaxed/simple;
	bh=JrbsYVzEGqTfjZyxrQZpuPhsJ4MZ4qmxAe6eVAvM7JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRHjFKCiCPogSJMPPedB8Hd4EnFDyFvAdnCkJDYCjmzjy2IUygz87P6+yij7VqC5d2nzWVagKEXofRnpIX2QT0TELEYN94P0TpQekd3v2MpP8iXuqjtyE9bD8PESMY7j8p6Tnxc8571/sh9QbUQudI3IBWjeCNRp2QTq9/WXEdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbfdKeed; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbfdKeed"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aeb6bdeaeaso5772e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 23:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783577714; cv=none;
        d=google.com; s=arc-20260327;
        b=Z9VD1+g1vbFWwSZliUZT3xNAORiLtOgNA5HztbuwQ5GD4zjqn/IIpC54aoNQ9Vbx68
         EAMqvjGWju+MkyXX9iaqR/fZcyRMsgWKU00jPDUv+oTGa/s/+0CL+4YONa3G6dOa9aoX
         Nb/P+MGsG3cJqkG3JxEBVEzeeNik80oltpE8dajRdA62U2kwFTCz3GFmkR9xNX/meqp+
         t38pEmqzpOybQ9UPC+/WF1fBaUGXCnq5FneovxAgWbQ5pWUYS0a6huTPl0L5lXV2qQyP
         cZs8fUVg/DefrFzDCxlTgeA+7IRsFEkCLS/LHtL+cMdLuaGS98CLppb+NE3ixA47YRdl
         4tRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nDhfXy+JFjOkSTFePIfLU/zhbaeABDCklVisKt6pztc=;
        fh=RGmoHmCb03i0DzzgOGiMhc8bAZWavQzAvczghSTKFK4=;
        b=Iztw+8w8GQwOhQPjyxZ8DFKtJ7ObZr4UxpWsSZ+GA2mzizRhfASaDTIjePvxLo6Dx5
         /fYnFfoCKVS69sZ0DfQ4jT2Dq4P5GjBBL/F3nTM5GuUPfja1zorOXkf4IVHZuzSUv7AS
         m4aoVcvwqyNb/Jq1wXK4DSlX5n+zgPaF5To7t0JYOoW0pJMcp3M9RHn4pBIBEHXnzF6T
         ai41tqOIdJEC7X8oQRNnfChKSG6x9wnGTag3FWhoYRysun0ccthA8SPaIjXOsvMGCKOE
         oJDrZU8IAYGqkavX9T1d+B0hiQ2KsFSGbzp3zgltjcrUBSlaUsrKbpT666wnrD5++YI2
         Nzcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783577714; x=1784182514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nDhfXy+JFjOkSTFePIfLU/zhbaeABDCklVisKt6pztc=;
        b=NbfdKeedlVfuphQGQYH6kLAcEX5b202OPDgMjfj5jJZGqapl8IGXO1a8CJvhtiWr6a
         m1RE5KtAk//9YgLj4VQR1GPN7LOrW48+qOvE21jwyA0eGty+oo4dGeNZlOI+xKQ1omcP
         IZ3n1ZI+bFEahBVkjcJiAa7GiyYqiR/SU1Oz031O0eF+Xylhq9XTofjH9fHX2IC8fM3J
         EDu4rg7jW2kE60b1E/Y5f6tACWqvd2cCmP/QSGetA+8Id/G5x8zylbZeLAL9CWhlFaBj
         +t4ZRQtcPE3X23SrrpB3HIq8gNZt5MHcEcTnTwyTkWxwktLC141Kwqi5Cav3HXshce4m
         Gnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577714; x=1784182514;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDhfXy+JFjOkSTFePIfLU/zhbaeABDCklVisKt6pztc=;
        b=sgYWCshonxSXDrDXIRUMl/o+RhvupSv9aqRmeHKhOL7fP+Cjlc34wi71D308gwhjQh
         1QWdhhSKjQ2PfvXiPP865I9poLllNOUl7FJqme91vWEb08gSISDz3KAW/za2AUOazJi0
         ljIZa6ZtAFcnTzAvba+XWJvpREsU6ge0EhD6mo3vUfH4Jq5r4EaqBRGINAXze2hhKcJ4
         YYfqeCv6wytCWee+tJosa8FpinA2RKHMca5dLu99Pb6qNttk3N+LUHdXj7cLDmQZ9Zdc
         SuvBuohkN7K+QD4bxeJQJw+HAMZbUoLUIu6dEyDOzM+erjDkTMGEsRaJv9eNE0/PLhLy
         1EKQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdQlXsCBGaXPwDPlZ2H53/Yvzfm8zcNivGhSCfS1ojnC9Ccs7ejsqzwlt3dXXhdHGmgMIL0dCbaM53IsaE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1PHTA/4MkC+/pj4Fy6fzqz1p1L94AngWrhwMpsFlG4pjquNV
	7cIfHMr0h5GeRxaPAvnxknziEuq3/Jxro5LTL1Xlp23+I6qL74HXTVhAR0GRsvNsv8JVLRqtGIV
	5WY8QOCZn+MUoJ9H4OPw0VHca6cmbSpvkGW8BtwGb
X-Gm-Gg: AfdE7ckauIr44YLptZGzDVuK3GwRD8poW9csVC2txYzVrw5YmfYTL/bVicD3KXCVCSD
	LXdnuIUEoGkNIMwG2n0ofjtdaRl+zjmL9M9E2ITHeKkGPRom8wNIF6eOKOGT7OfKVrgopStAQW1
	QZA+iBjK5xSsEDmumO5Bf3SOMQ9n1bPPDEjLImBZMwbv16e9VEnqir54xnuSyV6b2hMdfFijEHX
	lhIxzrWrYkH08s2hS4TsiFODasTWa5/b+9uPqz1lv7RpKynTtrgsrHghNDdJjTfvJyqijIK9v3N
	+asWZ8+wyUYbZUkbsnBGCrHhMXdhZHQnTlqROvF0TxIZmmFu0iCfn75hkUfcnHrTlUU4u53P
X-Received: by 2002:a05:6512:3d8f:b0:5ae:ba90:8a21 with SMTP id
 2adb3069b0e04-5b0163a0071mr87384e87.0.1783577714119; Wed, 08 Jul 2026
 23:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707064235.1386552-1-souravpanda@google.com>
 <9624988a-366e-4884-9408-3f3b88c27290@kernel.org> <20260707062428-mutt-send-email-mst@kernel.org>
 <b9a48d89-74f1-43d4-b7bb-be988b6855c9@kernel.org> <akzZr2jfJ0J8zox4@lucifer>
 <20260707095843-mutt-send-email-mst@kernel.org> <ak0xWgpJPSaNWPsl@lucifer>
 <20260707152755-mutt-send-email-mst@kernel.org> <f9bad4b3-93ee-4daf-84d5-97f6ca305240@kernel.org>
 <ak4JiBcvi29sYx0v@lucifer> <20260708050547-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260708050547-mutt-send-email-mst@kernel.org>
From: Sourav Panda <souravpanda@google.com>
Date: Wed, 8 Jul 2026 23:15:02 -0700
X-Gm-Features: AVVi8Ce9AmF7X4hV5ixsxIF5PZt3E2eW-xAowBuyJMbKi0GinxpYNGmtl7bX_VY
Message-ID: <CANruzcTQbfnsx6dMxbc8=2tQVF2gK1ROm3LOKiHc-sdT3xV2Ww@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] mm/hugetlb: Dynamic, NUMA-aware HugePage Cache &
 Free Page Reporting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, muchun.song@linux.dev, 
	osalvador@suse.de, akpm@linux-foundation.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	mhklinux@outlook.com, fvdl@google.com, gthelen@google.com, 
	mike.kravetz@oracle.com, pasha.tatashin@soleen.com, rientjes@google.com, 
	riel@surriel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 2:16=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Jul 08, 2026 at 09:26:18AM +0100, Lorenzo Stoakes wrote:
> > On Tue, Jul 07, 2026 at 09:46:14PM +0200, David Hildenbrand (Arm) wrote=
:
> > > On 7/7/26 21:32, Michael S. Tsirkin wrote:
> > > > On Tue, Jul 07, 2026 at 07:46:28PM +0100, Lorenzo Stoakes wrote:
> > > >> On Tue, Jul 07, 2026 at 10:01:55AM -0400, Michael S. Tsirkin wrote=
:
> > > >>>
> > > >>> Fair enough.
> > > >>>
> > > >>>
> > > >>> Lorenzo, do you know *how* you want it reworked? Could you write =
it up
> > > >>> at a high level?
> > > >>> Because if not, it's not really practical to make it the asking p=
rice.
> > > >>
> > > >> Michael, you're an experienced maintainer, I'm surprised I have to=
 tell you that
> > > >> the burden for that lands on the submitter.
> > > >
> > > > Oh sure, "fix bugs A,B,C before you add to this mess" is a classic =
way
> > > > to actually not end up with even more of a mess.  But I usually do =
try
> > > > to be explicit of what are specific issues I want submitter to addr=
ess.
> > > > I don't really feel figuring that out lands on the submitter.
> > >
> > > Sometimes it's certainly easier. With things like hugetlb there often=
 just isn't
> > > a feasible way to integrate it nicely into core-mm. It's just too spe=
cial.
> >
> > Yeah exactly :) once you reach a certain level of 'specialness' it is m=
ore like
> > pointing at a flaming trash pile and crying ;)
> >
> > >
> > > --
> > > Cheers,
> > >
> > > David
> >
> > Cheers, Lorenzo
>
> Well as long as I'm not the one being asked to put it out ... it is just
> hard for me to get motivated to do cleanups if there's no actual bug to
> fix, or a feature to develop somewhat proportional in size to the
> cleanup.  But for example, and without calling anything trash, after poki=
ng
> at memory-failure.c, *I* want to cry, because either there's multiple
> races, or I just don't understand the code.  Some of these we discussed
> here already.
>
> It seems to boil down to the fact that when people start getting lots of
> these errors they rush out and buy a new system, so hey. But maybe with
> RAM prices spiking it will become less practical. I'll put together an
> email with a list later, maybe.
>

Hi Lorenzo, David, Muchun, and Michael,

Thank you all for the candid feedback :)

Lorenzo, David, Muchun, your points are well taken. I agree that
adding hugetlb caching and shrinker logic to hugetlb goes against your
long-term goal of integrating with core-mm and reducing special
casing.

Michael, taking your advice, I will strictly focus on Free Page
Reporting for Hugepages as that is a regression in the page reporting
infrastructure.

I will send a single, isolated patch that wires up the standard
hugepage_freelists to page reporting.

Let me know if there are any objections to that!

With regards,
Sourav Panda

> --
> MST
>
