Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D934CFC7
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464302; cv=none; b=nunke/HdyGB9ITWOicYVR/YCwu9eMjmPwQp0zDsVzK+CNOic0o8gU4kJfBow5Kiu73QMtSp599cAuiQATk9xuYtc9iEugtKROa2srKbxRHaIARlTQiYd8vyV53qCL+WJJ8DQmRNIyFl7nxZzM3BDo1WBIS1cCsqc/yMjbaLNur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464302; c=relaxed/simple;
	bh=lCug1I8b6MFkPMgcf/mWWZNgVLJfCCmW1l4/5r+/VRc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=H0AhKkvhw+ppIZSTTG3/ZCXxP/bJuub4+eRnZkv0KOYi9aZQPvyoXPpY30lxqAvla/EvrV1IoOfcPwDAW6wW6ay31Kv1mPlsPOoox9bl7Rf6PDPZD5HN1iJXgtA/1cgMQ9M1JiUkSaVcgeuGj5EPFJjsNGstl9WWtuD0ioZxMqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBwLv6VB; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBwLv6VB"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37e0a189b0bso52159a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783464300; x=1784069100; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lCug1I8b6MFkPMgcf/mWWZNgVLJfCCmW1l4/5r+/VRc=;
        b=GBwLv6VBG7GZu+zlpTktIcqayzF0lT+Fo0R0s+6wilMe96dz9sRvJZT6OEph3bu0AL
         FFvjK4AJAI1RzHjk6EbILw59xxO7zIJ27VzuUguLiMu1PPwbfQp2ANEjL6M/FevhHdz6
         papacuoumpNPDKSZMLsI2g0JVbHfUv30u9gzkTiVRB6Yac93uryBp1c1e7oKL7zypORK
         xEbh+vqJn36yvn9yffLnGDK/sEB+gFBF2pPi/s4z3T63AIz2xMZfxgPe5ulhWApxGEOI
         Ovx2hnuhra7/WWpLA8xfEidKq0Ofv0jx1hU7lB8jlF3pY3zBXkzDDTL5Vn4AHY79zudA
         J9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464300; x=1784069100;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lCug1I8b6MFkPMgcf/mWWZNgVLJfCCmW1l4/5r+/VRc=;
        b=aCUDOA8o0MmgW4kFcLFWwmRxPnE9RWCwEpSwkrUPYu+iLVBQO8YxMIqbbJqpksNrmW
         6eH+nZ3UO3k0gY1kGktoDeWTfI2gvym2L48BEyHS7Eyrp90Q6SAkBz0Uklld43A4VjWN
         ELlftWzDir9hf7TqZblgMMYpTj8DjHFnnOt6L/j+RGxzxSfgP+akmL4tWGvN2s0BfAws
         8QomgAOxwQ3/7GVfBnkMPX4v9krk1SdsJz5N48gnVuXfrQRNvLJALjJRYdcYYdGV9B1C
         UYJNBbPoWGB095e97oGEu7qG7NMLA/Dy9q4/++GGS+Gh+3c1Fa6dglKx9QVWs3ouwRfC
         uJZA==
X-Forwarded-Encrypted: i=1; AHgh+RrdfjjnTYPYRU5dbC1NI44FNlCj5U3LToq2ww7pJ4lddxIxBwi1ayg42K/vKUFhLn0t8mDexwdCnXlxrapw@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0ViNC4dY5l6kaFnWYM+CkWmRtvijD9ZqbcmB57olQlRyUeH/
	b7oTFY81rLQZGj8VL3JpAqvAzepuMM97ddO2Ezc1VM6lUfVQyIuoaogp
X-Gm-Gg: AfdE7clgpmsWfc8wDb+uqfPTgIQy/91o7NCtQCSWGhyqWR6ra66vwlk2v09OhzN3xfe
	vQs2OoFV4ubT8YHZaGyQA8SH3MvCEd5SibCWURQ3bnvVdMn6cz9nRDPaSO5WRdnqn5M9nQbogPh
	mjQObMmYZig+OG6Y9/b6veSGrsq5eusISgUnd8MX39QfmfGB6IpsoHbQ3DEm7YSXI3ytt4lhJ82
	+ZvdMc6mYFwYZRFpUBUiN8kFtt4a2ylMMAgwHrWv9dxPdgvNl9SU9FaEiUXDIv/e9fcMhLxJL3o
	mKBZs4w/A6WGfNcuqqeP7nSLqKgS51MtnBMC2ZtpEMdCAb/pbNcQ4h06VXErqtgMrjfDbCNBM9w
	66iX7X47qQdQAnhPadrclmoxrmArjMCKTPSwA/xA50UEjSZiHtqLYTZJJt1cP0tgQkZCxOj3yJa
	G+F4E=
X-Received: by 2002:a17:90b:53ce:b0:381:973e:fa08 with SMTP id 98e67ed59e1d1-38756ce1588mr6842488a91.18.1783464300250;
        Tue, 07 Jul 2026 15:45:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::3:c1a1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm11695855eec.4.2026.07.07.15.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 15:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 15:44:58 -0700
Message-Id: <DJSPBVXTF02G.3SKLB9EO89GPT@gmail.com>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Farid Zakaria" <farid.m.zakaria@gmail.com>,
 <david.laight.linux@gmail.com>, <jack@suse.cz>, <jannh@google.com>,
 <kees@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-mm@kvack.org>, <mail@johnericson.me>, <shuah@kernel.org>,
 <viro@zeniv.linux.org.uk>, "Gemini" <assistant@google.com>
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
From: "Farid Zakaria" <farid.m.zakaria@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
 <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
 <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
 <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
 <20260707-wortreich-kanal-zensor-9386ef4f38f7@brauner>
In-Reply-To: <20260707-wortreich-kanal-zensor-9386ef4f38f7@brauner>

On Tue Jul 7, 2026 at 12:45 PM PDT, Christian Brauner wrote:
> On 2026-07-07 13:34 +0200, Christian Brauner wrote:
>> On 2026-07-06 09:47:53-07:00, Farid Zakaria wrote:
>> > On Mon, Jul 6, 2026 at 9:01=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
>> >=20
>> > > Ignoring the blatant bpf abuse here I think this is quite workable. =
So
>> > > this can be turned into an actual design and patch imho...
>> >=20
>> > Glad to see you think this proposal is in the right direction.
>> > Just for my edification, when you say "balatant bpf abuse", you mean
>> > how it abuses the socket bpf type?
>> > If so, do you have any guidance on a new type or should I just take a
>> > stab at it.
>
> I drafted a POC for you that should be closer to how this should look
> like with the bpf people in Cc. I'll let you lead from now on. I just
> wanted to help you out and illustrate a more viable direction. Might be
> that the bpf people want it done differentely. Let's see.

Cool. I just saw the POC.
(I'm trying out aerc to view the patch series. I will also try b4, I've
never set it up before)
I will rework my qemu demo to use the struct_ops and go through my own
testing to see it work.

That looks very similar to what I was researching with an LLM. I was
just going over the idea of struct_ops bpf (a new concept to me) and
using traditional bpftool load, a new bpf program type and kfuncs.

You put out a surprising amount of polished code -- thank you.
I would have had to lean on an LLM (heavily) and from the patches I've
put up so far they still have quite the gap to cover in terms of polish.

What does "take it from here" mean in practicality?
I will test & validate the changes and just wait for comments.
If there are none and it works....then I guess it's done ;P
