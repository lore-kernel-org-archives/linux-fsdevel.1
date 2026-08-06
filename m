Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B745336F916
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040529; cv=none; b=PORoLcXugM8IWcyRdfT07da/cmqHqaRA4VDPllu6t4UdURQBak9fVdgasH7RblbEx/D3ICiQ1ngdBHF+4Z3RhqVI/WV6HSRPSk0EY4dNSpP+wyKtFyjw94ibJfzfpHdFY4iVLgkRXy17nBiciDOsTKa/R6FZklK047AZf0C/cFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040529; c=relaxed/simple;
	bh=9BRzFZVy4zKx6m7/bhK1JfFyj65ASnZXRSc9F2yoeeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9nPvpqJ3xpGbz91eqS6X9irE9mm51c47QNfdkNJZEW9YmGYGqx5nMg7yDT/O7VRu4jyreLqwLd+DK4/y1UR0x8rz6KO6okQgKZrFyh9H5RPQNdNO2xXu57fM+3fyYNU24A5c4V8p8wGnLP4Drp00NlYegtvod2t9vd4UBw4DUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=FTNQIO9b; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="FTNQIO9b"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hGFx64yFGz16ps;
	Thu,  6 Aug 2026 20:22:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1786040522;
	bh=vc4db9dlLjXPzCYYOSOgOswJHqHMqmmneD5cZW73c68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTNQIO9byojoRV7z2fq67n+YYqG/OYHred6BLWe1Wx249UHZNZF8dEO4RXhkZyXZM
	 K0edI2MMY4MvYO+r8MMEVYGlJWKatFiRBjhXWLxpgqGADSoTRZ5sGjvZWMkDJ26DB6
	 3lzZzoWWoHEL20G+nx5CKyRfCKJctxNnosQKdZIs=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4hGFx46CcPzHwB;
	Thu,  6 Aug 2026 20:22:00 +0200 (CEST)
Date: Thu, 6 Aug 2026 20:21:56 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Justin Suess <utilityemal77@gmail.com>, Kees Cook <kees@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/17] landlock: Prepare ruleset and domain type split
Message-ID: <20260806.zi7ahDoash5r@digikod.net>
References: <20260406143717.1815792-1-mic@digikod.net>
 <20260406143717.1815792-2-mic@digikod.net>
 <0e6fe895-9c3e-443d-a928-35640ba8c184@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e6fe895-9c3e-443d-a928-35640ba8c184@maowtm.org>
X-Infomaniak-Routing: alpha

On Sun, Apr 12, 2026 at 05:29:24PM +0100, Tingmao Wang wrote:
> On 4/6/26 15:36, Mickaël Salaün wrote:
> > [...]
> 
> Hi Mickaël,
> 
> I like this approach, as I basically ended up doing similar refactoring
> previously for the hashtable / array-based domain changes, and having this
> done first should make it easier to adopt the domain data structure
> changes in the future.
> 
> I assume it's fine for me to add:
> Reviewed-by: Tingmao Wang <m@maowtm.org>

I couldn't keep your tag because of the refactoring, but I'll appreciate
a new review.

> 
> > @@ -175,19 +163,24 @@ static void free_rule(struct landlock_rule *const rule,
> >  
> >  static void build_check_ruleset(void)
> >  {
> > -	const struct landlock_ruleset ruleset = {
> > +	const struct landlock_rules rules = {
> >  		.num_rules = ~0,
> > +	};
> > +	const struct landlock_ruleset ruleset = {
> >  		.num_layers = ~0,
> >  	};
> >  
> > -	BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
> > +	BUILD_BUG_ON(rules.num_rules < LANDLOCK_MAX_NUM_RULES);
> >  	BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
> >  }
> >  
> >  /**
> > - * insert_rule - Create and insert a rule in a ruleset
> > + * insert_rule - Create and insert a rule in a rule set
>                                                   ^^^^^^^^
> 
> Should this be rule storage to be consistent with the next 2 lines?
> 
> Alternatively maybe we can just say "struct landlock_rules" to avoid
> inventing new names?

I realized I didn't replied here, but the v3 now uses "rule storage" to
be future-proof.

> 
> >   *
> > - * @ruleset: The ruleset to be updated.
> > + * @rules: The rule storage to be updated.  The caller is responsible for
> > + *         any required locking.  For rulesets, this means holding
> > + *         landlock_ruleset.lock.  For domains under construction, no lock is
> > + *         needed because the domain is not yet visible to other tasks.
> >   * @id: The ID to build the new rule with.  The underlying kernel object, if
> >   *      any, must be held by the caller.
> >   * @layers: One or multiple layers to be copied into the new rule.
> 
