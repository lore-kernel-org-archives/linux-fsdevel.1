Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF022472B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629834; cv=none; b=L0b3BSTlgnk7mT8TJRmDZkY58zY01LVDYF2GJceBz8gfCw4kA6RZK8do3PF2QF/IiaF6gowsCkP6GvGhfx1lU6499rOwIJOFNWMq0ClnmbgmVfweqbjhUw5GtsgxGcJd0GYoCrnu+gXu3QtDBlvPAlFk/c58wl9saDAfANdCU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629834; c=relaxed/simple;
	bh=49n5rPh0i+d7m07JBxE/RU/O/1/iCOaT6ntiWMwKaAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq+0LHjf1dVBVmXKBGaB2BPAGx4VuolXS0GS68Q19ei22rlOiZbYkUWTDjLSVmMYZ5OCQ8Q+z1cs+cA7+jqrnwwBNOybmxX5Mjbu9ECFE1ym6LXlGXQrZny7n1aRbE74H9Gzum5zVgqdpw7jx/jHV0XAa94415z4PLWAsnCtf7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hzWZX15B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hzWZX15B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE361F000E9;
	Thu, 13 Aug 2026 14:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786629833;
	bh=GRXjly27287JPwSqMXmTIq8mszAlDFNhT/jjwcIFZaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hzWZX15BHKu15HreRJydCFoxS659Jk4h2R+GVJCKF+kt5n8RXqN2CLf2+gl2NhsRX
	 RO+2G0Qg6ee9mjb8GlIlYFNwHRmSkw2cykHp4cSHANPBxYGnN1fRNg45zJUSEfk8L5
	 EJVvD6xlIH4JIpc+VqinT0pZtar8kx0FhIUwajtA=
Date: Thu, 13 Aug 2026 23:02:18 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Palmer <daniel@thingy.jp>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org,
	geert@linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to
 /dev/zero
Message-ID: <2026081308-amigo-paragraph-3afd@gregkh>
References: <20260813063401.1786548-1-thehajime@gmail.com>
 <20260813063401.1786548-4-thehajime@gmail.com>
 <2026081355-remold-sterility-84f9@gregkh>
 <CAFr9PX=zC8GnxwrR=wTwA4xQq89cHYpxZWooS+-=Q-WuNbjanQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PX=zC8GnxwrR=wTwA4xQq89cHYpxZWooS+-=Q-WuNbjanQ@mail.gmail.com>

On Thu, Aug 13, 2026 at 09:43:37PM +0900, Daniel Palmer wrote:
> Hi Greg,
> 
> On Thu, 13 Aug 2026 at 21:26, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> 
> > Given the age of this issue, I don't think anyone uses no-mmu systems
> > anymore :(
> 
> There are a few of us using it for hobby stuff[0][1] and there are
> apparently people using it for actual commercial stuff.
> There was a session about this at LPC 2025...

This patch is fixing a very obvious issue that showed up in the 5.10
kernel, which was released in December 2020.

So I think the fact that no one has reported it before now means that no
one is actually using it :)

thanks,

greg k-h
