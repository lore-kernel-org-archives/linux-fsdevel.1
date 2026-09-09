Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5E48167B;
	Wed,  9 Sep 2026 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941085; cv=none; b=iROoQkSg1gsMNFBJEWHxsB1WjtzJ/x9Tm3e+4up1rLjqbI6q4kFNg2NFCaogUXx/+Fd7VngjaBPV7B2D0kd6bXVpcrZ6aSxaPZkA1PPFm0Ss3J7eH+3PjKj84N7FJNki6JATizMn/HpzTVXhGl1kQJpEeRKW+xH+nM/rrX/muMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941085; c=relaxed/simple;
	bh=a5yCGqaS/DMTpDVyJ72faZ7aBJHc3LDP4cXflNP1Q3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrXlqtU87g3+QsJ0Acwekoe8W9zyiicroMLdVIlxqm4/4J9CquzP9TRYaCljPsMc0fZO1lxbJjRks/qFhvH31RB5dvJulMmWR33nSUxoEbNQjG/0VQ3IF97VuNasQ7mysjzN66bmV0mtzw0+qJ4OZTmqXoT0+3aqZzCNTJFff5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i01kD9A2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i01kD9A2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D1C91F00A3A;
	Wed,  9 Sep 2026 08:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788941084;
	bh=R02bc+J6KL2MRGiL/2wGzw0MT4aaXMJzfoQvrhoWDas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i01kD9A2yOS+6RP5UUHTWnW1K9RMKV1PXoSwbor2lElBjluKk7Bk3pBFQr2Y4m4Lc
	 mA93qPGQMDYu9uaSn1nrACYsP6wWbIzs6qGoeh5/QWSguQHjzobH4/ziE6hQ4FQc2F
	 TIvt6f6o9+RMDbd42CaVprlp7sx7V/NlY/C/WXCBmavBTV6ueJTAgWk9vrAaegW9+G
	 01/FKfScc4LhMnu+BBzsF3zBp62jXmcjtZi2d+D4uNuEkFUj+1VQSDyjIZpKwoo+Pr
	 dwp6qKi1VfAPoO6cfRioA0dJu6i8g7vaH/iuHO92FpCMpIubBWts6o0rgSuVqFafjQ
	 qoh04ZLAGZmOg==
Date: Wed, 9 Sep 2026 10:04:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: Norbert Szetei <norbert@doyensec.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] nstree: check listing permission before taking a
 namespace reference
Message-ID: <20260909-hergab-abkassieren-besten-0d6e314eedd7@brauner>
References: <F8EF9799-CDCE-435F-97E2-13B6CC92EC6D@mainlining.org>
 <A0ABE170-488A-49CD-8A6C-4D9EB94A18A8@doyensec.com>
 <F86352E4-FECE-49F6-98B7-8B5DBE49FE0E@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F86352E4-FECE-49F6-98B7-8B5DBE49FE0E@mainlining.org>

On Sun, Sep 06, 2026 at 07:26:30PM +0100, Bradley Morgan wrote:
> On 6 September 2026 19:25:22 BST, Norbert Szetei <norbert@doyensec.com>
> wrote:
> >On Sep 6, 2026, at 13:52, Bradley Morgan <brads@mainlining.org> wrote:
> >> 
> >> On 4 September 2026 15:28:05 BST, Norbert Szetei <norbert@doyensec.com>
> >> wrote:
> >>> legitimize_ns() takes a reference on the candidate namespace before
> >>> may_list_ns() has decided whether the caller may see it. The
> >>> __free(ns_put) cleanup on the denied path can drop the last reference
> >to a
> >>> mount namespace while we still hold the rcu read lock, and put_mnt_ns()
> >>> may sleep there. This is the same problem commit 2ec2aff3c8e2 ("ns:
> >make
> >>> sure reference are dropped outside of rcu lock") fixed for the
> >put_user()
> >>> path. Neither ns_requested() nor may_list_ns() needs a reference, both
> >>> only look at the namespace type and at the caller's own namespaces, so
> >do
> >>> the checks first and take the reference last.
> >>> 
> >> 
> >> Great catch!
> >> 
> >>> Fixes: 76b6f5dfb3fd ("nstree: add listns()")
> >>> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> >>> ---
> >>> A reproducer is available on request.
> >> 
> >> Please? Or a splat, or anything?
> >
> >Sure, both reproducer and splat below.

The repro is available under the patch link in the commit. So no need to
dump all of this in there.
