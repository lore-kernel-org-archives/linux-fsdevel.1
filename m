Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C3399351;
	Mon,  8 Jun 2026 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906474; cv=none; b=p9ES/qEC0YHAlYHZbbaBxeSM+ToZNHUjJ9a6wu01tfh+bcH9GDSpS3xsyPf3gIGBb1QxCtKjly8Uke38ChSVfmNU4LJMO30tjTSlB1NY2h6E34Rq1QmTmmQ4Qc3Z33Zm9y6R26+kwSCIW4955n0A1I/kCN/igh2eQQEnBLtY91U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906474; c=relaxed/simple;
	bh=DpH/zlRhHjTc06tdM4f68buEiSq6Vkp6kXQ083ejESQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiKQb+fa2JQfFxcatYF6Db3njlET38mqZyVhe6qYC/QV5VVGqxnSh31RTzxRi3hRk4jzl9YFuaO3neqhJfjG8Lxtr/vHwDxsu+3Jsna8Rm1nIdbMQmkYpGh47UEdrAkYv1BX+VhVwShu9JJlRXl/4mxdezUDE4RZiAO6CaRa7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojQPN562; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojQPN562"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F9D1F00893;
	Mon,  8 Jun 2026 08:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780906473;
	bh=DpH/zlRhHjTc06tdM4f68buEiSq6Vkp6kXQ083ejESQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ojQPN562QoWHR+TdTkN2GuTZAwrOuXOmiNT6LECGD7COALg4AS86+0sKiH1uBpJMO
	 Kg0vgw9TGCD6GLK6Uz/VhkD2wzkETuOalxPtxAwkbuShvJ6Tjjjmr9V0iZPKH3DSBE
	 PZ+Pyei59ZIUTVaiIyDqWEP9dmZS80grN7kQ5QrJo3Jh5mEQgKPNfhXZY35X0QiZKo
	 xNfjO5YbTpx2Xa4kYXd/cO/3BTKlFhcAd0PDCU9LPjf9m0KZnU7rD/GXyJE46ajNla
	 cavlrpYUhCOXOfO3x2W86VtqeoC5/5HJyze+kwZQWD2KFmjXsJ3cG/aI1BuTbtzimc
	 ER38V3Bir5fVA==
Date: Mon, 8 Jun 2026 09:14:27 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs/proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
Message-ID: <aiZ5qFTc6XDMsqB9@lucifer>
References: <20260606015729.1837935-1-surenb@google.com>
 <20260606015729.1837935-2-surenb@google.com>
 <aiPWD6xZLg6g4DTO@lucifer>
 <CAJuCfpH74gRmgm2tgwB7SHzL9DrU3Yc4LyS8XLa0tR7fJqaw_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpH74gRmgm2tgwB7SHzL9DrU3Yc4LyS8XLa0tR7fJqaw_A@mail.gmail.com>

On Sun, Jun 07, 2026 at 12:45:23PM -0700, Suren Baghdasaryan wrote:
> On Sat, Jun 6, 2026 at 1:12 AM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > (Will review separately)
> >
> > Sorry to be a pain :) and I know it's a petty thing, but even for a 2 patch
> > series it's easier to handle if sent with patches in-reply-to a cover
> > letter :>) also makes it easier to track overall updates in cover letter
> > changelog.
>
> Yeah but the first patch is a simple cleanup of about 10 lines, and
> writing a cover-letter for a single patch seemed excessive. Andrew
> would have folded it in with this patch anyway, I think.

Makes sense, sorry to nag but I want to be consistent in nagging everybody
the same :P no matter how well I know them or otherwise ;)

I will take a look through the patches properly in a bit, I meant to
actually do that on Sat but got distracted...!

>
>
> >
> > Thanks, Lorenzo

Cheers, Lorenzo
