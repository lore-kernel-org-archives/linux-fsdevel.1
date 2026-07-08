Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CE343079C;
	Wed,  8 Jul 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529287; cv=none; b=Zf6loPz5dUKa3YHxxAjhCD+PUtPPc/CQtFki+fIlJidI8LFLFhvks0xwxB5wH0wSF2cFjuy/VVjgvSay5WsWBYC/i7xlL0Ldx3HcvAt8jTFIRaScdXRyJ+np3foghSI+fx2FriqyzXvwwGD3RXks3hMk0AyGL0Nu20aaUfze84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529287; c=relaxed/simple;
	bh=YVFc7rBcDlwHKlUCwVkxog+6bJNAmkg4ZND22quLdcs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ZKgG8c7mrsIhArYQHHPLKejDVCz7vYqHUuiD5pHF73COiSrQoz8FPuuXsNZcP6MyY8Rs+ppwUpgeEo/11f8Zr3sLtX2WSStsLxbFeVXSHHc4GeRdQVVaPEKXLiY+yO5TcTEQmzxgF601INa7WXluxEqmCpntUdl+ppOd/oh3luM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS8hkoF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS8hkoF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E2D1F000E9;
	Wed,  8 Jul 2026 16:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783529284;
	bh=oLOlOo9U2JyqXVHzHsOC0fR47gawe6tnhfJUIDf4Krc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=WS8hkoF+jWFjItBjVm8PU6EB+hB7Uyw+tLXaueXy3NNaD9qM3FKyfYhClKqMe/2ZM
	 nSaRsO2HVyBZnDRKpDGZwiTo2dHKJLR70Oqt8vp97BSEOcgnMXpwV18xpYdcfXghKy
	 vN16vY+MrXfNiZ+2Fa12amxazjJRsJ6hdt2/PCZezYzxvuX/BFSogRh6aA8UWvt7tf
	 auTgCSyZ2M6fOgGcg5IhuDBAldpmy4vsKtRLWCh7brOYkBa9NMJeShb3lMjjDYlC34
	 GrhiANtyOOVy/1IAsaSrS7rPE3vdkLM7fF1WC+C4d4m0PLiokRbMhAtq0P0J64+NdZ
	 l/hd468SygJ1Q==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH] fs: binfmt_misc: introduce eBPF-based matching and
 interpreter selection
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, david.laight.linux@gmail.com, 
 jack@suse.cz, jannh@google.com, kees@kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mail@johnericson.me, 
 shuah@kernel.org, viro@zeniv.linux.org.uk, Gemini <assistant@google.com>
In-Reply-To: <20260708-welken-dystopie-ertrugen-56a3b5f7ab66@brauner>
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
 <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
 <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
 <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
 <20260707-wortreich-kanal-zensor-9386ef4f38f7@brauner>
 <DJSPBVXTF02G.3SKLB9EO89GPT@gmail.com>
 <20260708-welken-dystopie-ertrugen-56a3b5f7ab66@brauner>
Date: Wed, 08 Jul 2026 18:47:59 +0200
Message-Id: <20260708-kordel-laben-kopfhaar-1c0dd234aae5@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YVFc7rBcDlwHKlUCwVkxog+6bJNAmkg4ZND22quLdcs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT51TvOyDgpsaRyy4rE1SbJIR7Kt7OaV/baLolc77ioa
 sGPhdcfdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk7G6Gf5YRcy4tEGQ31Yt0
 93KTyTBrPeu14c/OstKoT/NEv3HmyjEyPLwm/1Ei7PHfmydzLq5+sJ6rpoL5YYTrFK+uJRdtde+
 L8wMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-08 11:14 +0200, Christian Brauner wrote:
> On 2026-07-07 15:44 -0700, Farid Zakaria wrote:
> > On Tue Jul 7, 2026 at 12:45 PM PDT, Christian Brauner wrote:
> > > On 2026-07-07 13:34 +0200, Christian Brauner wrote:
> > >> On 2026-07-06 09:47:53-07:00, Farid Zakaria wrote:
> > >> > On Mon, Jul 6, 2026 at 9:01 AM Christian Brauner <brauner@kernel.org> wrote:
> > >> > 
> > >> > > Ignoring the blatant bpf abuse here I think this is quite workable. So
> > >> > > this can be turned into an actual design and patch imho...
> > >> > 
> > >> > Glad to see you think this proposal is in the right direction.
> > >> > Just for my edification, when you say "balatant bpf abuse", you mean
> > >> > how it abuses the socket bpf type?
> > >> > If so, do you have any guidance on a new type or should I just take a
> > >> > stab at it.
> > >
> > > I drafted a POC for you that should be closer to how this should look
> > > like with the bpf people in Cc. I'll let you lead from now on. I just
> > > wanted to help you out and illustrate a more viable direction. Might be
> > > that the bpf people want it done differentely. Let's see.
> > 
> > Cool. I just saw the POC.
> > (I'm trying out aerc to view the patch series. I will also try b4, I've
> > never set it up before)
> > I will rework my qemu demo to use the struct_ops and go through my own
> > testing to see it work.
> > 
> > That looks very similar to what I was researching with an LLM. I was
> > just going over the idea of struct_ops bpf (a new concept to me) and
> > using traditional bpftool load, a new bpf program type and kfuncs.
> > 
> > You put out a surprising amount of polished code -- thank you.
> 
> I would not call this polished and it also lacks any tests... I've not
> given the locking much thought and maybe there's easy wins on the table
> I haven't been considering.
> 
> > I would have had to lean on an LLM (heavily) and from the patches I've
> > put up so far they still have quite the gap to cover in terms of polish.
> 
> This isn't my first bpf ride in both kernel and userspace.
> 
> > What does "take it from here" mean in practicality?
> 
> Bring it over the finish line so I can merge it into my tree. :)
> If the bpf people have no comments or worries than we're done. If they
> want changes I'd appreciate if you could make them and slap you
> Co-developed-by onto the whole thing as necessary.
> 
> Also, please ensure that this works for all the cases you're
> considering.

I have another cleanup series for binfmt_misc btw. That code is quite
old. There might be a few additional series coming out of this work that
we base the bpf bits on.

