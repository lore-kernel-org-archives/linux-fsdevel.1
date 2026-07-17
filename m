Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353783DDDB2;
	Fri, 17 Jul 2026 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285723; cv=none; b=Isqpw2KqkpAvHTIzJ8v13/CEDX3jOj/Ze9aEVeC4oy2FM5zLST+D6z/qwtC7PCllDliefGEE+g/Lp89slDN/mRe/bTIjm1LiGoZzOIXfLWlgeo5SP7Aa+gYj1nwyOkzR2XC6rY1Ash646ch5N1P93Wd1P4eLhLVhHm4GTjWh4Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285723; c=relaxed/simple;
	bh=+E6Ce0ajxA7PBQzSxtDiOlCAOHj9uIkTi/FEOwR36P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9IfCyHUOoJeoxaLsRtn5ssrJYMZRGdb0zjJGOfCXBIiWNyoGIxyuLnLEyZivHwOywjh1Tf25oxjfVln0JaMw697UKWgMGR+6zeijmC6o2m/M3m73Tsjgq/MusA1knH+mqVlBmPmRCBu/FzAjXDA6YYtK6+zBueZqVYQ+SQ4zD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQK56LSq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQK56LSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1631F00A3A;
	Fri, 17 Jul 2026 10:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784285716;
	bh=+E6Ce0ajxA7PBQzSxtDiOlCAOHj9uIkTi/FEOwR36P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YQK56LSqHWt9qIVQxfgXt1kam62Wn/4L31a9SKd+pWDeiria4iIhIZw5fkoWIS0XB
	 zJhi12w+EgE+kgh5H5BVr5F5++c1HU96fokeW7nImBbmcmQ7ghKcKaiqefTZfNvGrC
	 RE9UCXySAwFoa0YXyO2fAT4CUCVpd/AbOO/yWdhSN13HQiJFM5tlDyA+R8l8eXHtpy
	 5r/xNObYVUp2KPAS21nVA5661tlAD8shaYjr7P/j8MJnYeYyHMhwvFe/4Bl1cjGy1c
	 PZ6xA8j5fVvjFFRrQFWN3NHh9aHznE7EbOWK4wisJrs1X5JAFnHMy61ltB/JWY440O
	 1PCU4B+nX1Vcw==
Date: Fri, 17 Jul 2026 11:55:00 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm/mseal: remove further superfluous comments,
 do_mseal()
Message-ID: <aloJ9hK7-0iJKVg2@lucifer>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
 <20260716-mseal-fixups-v1-3-3a9609bf041b@kernel.org>
 <c8e5b263-1368-4fac-a935-345cb6aa9165@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e5b263-1368-4fac-a935-345cb6aa9165@kernel.org>

On Fri, Jul 17, 2026 at 11:50:13AM +0100, David Hildenbrand (Arm) wrote:
> On 7/16/26 15:43, Lorenzo Stoakes (ARM) wrote:
> > There's no need to abstract do_mseal() any longer so put the system call
> > implementation in the system call declaration.
> >
> > The comment around do_mseal() is strangely formatted, overly long and adds
> > a lot of superfluous information that the code already provides, so boil it
> > down to the essentials.
>
> Lol, just what I had in mind in my comment to #2.
>
> Nice!

:))

>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks! :)

>
>
> --
> Cheers,
>
> David

Cheers, Lorenzo
