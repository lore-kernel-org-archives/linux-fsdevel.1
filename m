Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B8436361;
	Thu, 30 Apr 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560996; cv=none; b=WUj8voU79Boft9EkJGnjcs+qNjjyveaI9Sp1pynvT4se18oNKUIbZHcwUb4dH1VfbXicq068dNGmMLWUg8S4t4DyUDClwOEprMNC40wcwix4ee1dUGn2F8JVfGUy9xCIWuHrTnXFU5ZHqk1+Z8Qo7wz2S/64m8t5GobA+p/CpaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560996; c=relaxed/simple;
	bh=MhaXLcaOIUpIS6zO/5Y+oRQiEEf192SsMRoae4gOcu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QntvJuL9EMoWJHyr/2XZ87oSRgdWhZi4O5ph8gIhb2hPgUmMMjAWwiXkli8VbdK4PUFIx8t7zdBjWMiGEhc4leeWueQZjqHyr+R5DiDukj8VhtgdKUv/TiyZjJeXHorG6m28NkpzMJRMN25USKBuM/eet9nGYz8pUyWM6ps6ZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8bQI+Pb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8bQI+Pb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3421BC2BCB9;
	Thu, 30 Apr 2026 14:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560996;
	bh=MhaXLcaOIUpIS6zO/5Y+oRQiEEf192SsMRoae4gOcu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q8bQI+Pb/x7MEMNOq0iqHVTBFXiTqnZmjatZgDZl/BiW7FO1WC1SnKIgzHgqueZ3P
	 m959rNSxoCR4pieHDgzCE3mhqyzG3FNP3nAdOqXUx81siefAeVFfhGL6mcQN6ObATM
	 EaCzyQgzBGOvCUuLGw9h6eyYcytP2vI+JU5hSbN5acsDjklmaUgnhtaMdBfqWGK45x
	 R1HPTeeW24REt76cAT4F4MO3hTrZRYJa6ZlGy5iRe0iCq96yB2bt29iiHojpidbfLW
	 wJeUdFEKsebFeIb3vIEL9RWudEVs1ImnQOh0tWxrWIcOA6BqauGUzA+j8uhq3lwVxh
	 N1Z++goSMa/Kw==
Date: Thu, 30 Apr 2026 16:56:29 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Peter Xu <peterx@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] userfaultfd: merge fs/userfaultfd.c into
 mm/userfaultfd.c
Message-ID: <afNtnXnU4J6syETa@kernel.org>
References: <20260430113512.115938-1-rppt@kernel.org>
 <d5f17a01-4504-4a7b-b58d-c183cedc37f1@kernel.org>
 <b31e1b5e-511b-4213-a8f8-d9721959d709@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b31e1b5e-511b-4213-a8f8-d9721959d709@kernel.org>

On Thu, Apr 30, 2026 at 04:23:08PM +0200, David Hildenbrand (Arm) wrote:
> On 4/30/26 13:38, David Hildenbrand (Arm) wrote:
> > On 4/30/26 13:35, Mike Rapoport wrote:
> >> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >>
> >> Hi,
> >>
> >> These patches merge fs/userfaultfd.c into mm/userfaultfd.c and make
> >> functions used only inside mm/userfaultfd.c static.
> > 
> > Yeah, makes sense to me!
> > 
> 
> Thinking about this, is it reasonable that the kconfig stuff stays in fs/ ?

But it's in mm already.
 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
