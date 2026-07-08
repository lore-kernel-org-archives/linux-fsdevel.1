Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59A93E3C4F;
	Wed,  8 Jul 2026 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502061; cv=none; b=FQY7GcGdm78J7HmtXJj+OOOy89dCP4kXms1BjRhlm70idnmFwB87KygRaFwPv/Iey3LhaZYJpivaSO8iZQEPS+Wpl/TdSHLK+q5NCMc5H3NtI39BQlqetXPNVvUcs5LFAn9x7bnWgiPrVlhbZehFYb7ApGTKRo8dmL0ZjmP7vX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502061; c=relaxed/simple;
	bh=nQTJehsrNjH/qX4EOyzAlTO+RBHcG/yjYW9gYuuUFIA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=To7PLUTDovCA5wlF5oLc3Gaz+QTJ6bp/iFKfg2G8nN24Vwm3+LYN5emhKJ903iY4Xl2VWiJL47D4cshKzrCwVWEjh3AxhtIsblSP7biJro8PnLuU63zfwybVbMlPsxTihbC6AB5y3UrDnrl5UsAkQSFPJLxSVv2eWoIihqCWABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDfjEVLN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDfjEVLN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511C11F000E9;
	Wed,  8 Jul 2026 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783502060;
	bh=AXXHqKxP6hZn4M2zHTw2/0ZaLNmtz5Sx6sgLJ6b0uwI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=SDfjEVLNuk28Tl68PJynCZdX2Kqgk26eXL56PM60LwXTOto0CWSTAjFNmFJ1ICrYq
	 vqKrIquj1RTSThYPAkkuZKFMEJJILzNSscRunJ+pgIFSSh08YkyGtgsH+nZaKdzukn
	 iMDAjHrz9fsaEewNzgyTNI9QMu4QTS+qbl27g0QQgeEfdyLidSY4tBRWjVFvII4m6L
	 Mg/MUO6Uw6puC7rRRegBzohlNiUOQs2CdfsxP6+YUfd7hMmehUFo1qX1cTgCMUcWIL
	 wqzswdBa2dXxFUhqGkvLSZImHcXAPEpFi5jpruDOtR2AEu7JW3YD54smjQflkIk7t1
	 p8lCaVreY3Ppg==
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
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, david.laight.linux@gmail.com, 
 jack@suse.cz, jannh@google.com, kees@kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mail@johnericson.me, 
 shuah@kernel.org, viro@zeniv.linux.org.uk, Gemini <assistant@google.com>
In-Reply-To: <DJSPBVXTF02G.3SKLB9EO89GPT@gmail.com>
References: <20260704-kochkunst-hauswand-blass-7226e9443a9f@brauner>
 <20260704211409.1978485-1-farid.m.zakaria@gmail.com>
 <20260706-uhren-raubbau-sinnkrise-e40a8337414b@brauner>
 <CACCo2jm5=xrQNfak=TdO=2oh0DC5pe+atj=UfuTa8Y9s8GVkqg@mail.gmail.com>
 <20260707-campieren-fingen-himbeeren-e4b682bd8e63@brauner>
 <20260707-wortreich-kanal-zensor-9386ef4f38f7@brauner>
 <DJSPBVXTF02G.3SKLB9EO89GPT@gmail.com>
Date: Wed, 08 Jul 2026 11:14:09 +0200
Message-Id: <20260708-welken-dystopie-ertrugen-56a3b5f7ab66@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nQTJehsrNjH/qX4EOyzAlTO+RBHcG/yjYW9gYuuUFIA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5iTy+4ej3eN+rzKsRBx4ms/YfnOB6fLmtKfum3MBTZ
 v/k56+f1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARdy1Ght8F4v9ZvLd8PqCw
 cTPv7+My2zQPTK7c/yLBYM7VFfW/Jr1iZPh6ZUP0oay2dbVyE06brmj+s+j8sXc2qYsnh76+F7G
 2WJ8LAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-07 15:44 -0700, Farid Zakaria wrote:
> On Tue Jul 7, 2026 at 12:45 PM PDT, Christian Brauner wrote:
> > On 2026-07-07 13:34 +0200, Christian Brauner wrote:
> >> On 2026-07-06 09:47:53-07:00, Farid Zakaria wrote:
> >> > On Mon, Jul 6, 2026 at 9:01 AM Christian Brauner <brauner@kernel.org> wrote:
> >> > 
> >> > > Ignoring the blatant bpf abuse here I think this is quite workable. So
> >> > > this can be turned into an actual design and patch imho...
> >> > 
> >> > Glad to see you think this proposal is in the right direction.
> >> > Just for my edification, when you say "balatant bpf abuse", you mean
> >> > how it abuses the socket bpf type?
> >> > If so, do you have any guidance on a new type or should I just take a
> >> > stab at it.
> >
> > I drafted a POC for you that should be closer to how this should look
> > like with the bpf people in Cc. I'll let you lead from now on. I just
> > wanted to help you out and illustrate a more viable direction. Might be
> > that the bpf people want it done differentely. Let's see.
> 
> Cool. I just saw the POC.
> (I'm trying out aerc to view the patch series. I will also try b4, I've
> never set it up before)
> I will rework my qemu demo to use the struct_ops and go through my own
> testing to see it work.
> 
> That looks very similar to what I was researching with an LLM. I was
> just going over the idea of struct_ops bpf (a new concept to me) and
> using traditional bpftool load, a new bpf program type and kfuncs.
> 
> You put out a surprising amount of polished code -- thank you.

I would not call this polished and it also lacks any tests... I've not
given the locking much thought and maybe there's easy wins on the table
I haven't been considering.

> I would have had to lean on an LLM (heavily) and from the patches I've
> put up so far they still have quite the gap to cover in terms of polish.

This isn't my first bpf ride in both kernel and userspace.

> What does "take it from here" mean in practicality?

Bring it over the finish line so I can merge it into my tree. :)
If the bpf people have no comments or worries than we're done. If they
want changes I'd appreciate if you could make them and slap you
Co-developed-by onto the whole thing as necessary.

Also, please ensure that this works for all the cases you're
considering.

