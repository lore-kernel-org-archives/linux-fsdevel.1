Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604029B78F;
	Sat,  6 Jun 2026 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780733540; cv=none; b=RM15secYZ1dTKxJYq9b0mjf569PbvRJvXhrLeH7q6BrayugvmhQJYJD/jEDmIvJtlN7Y7S4eEmezIf5eRUkyRJRkJHMcDYMQiUq8hqf+S7VKZ57ckmsuVhDKDIbxWhOWVfB4Zm96ixdFh/l6VlOVgRpU5ibDSivCb347W1TOXOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780733540; c=relaxed/simple;
	bh=Hb81cKk8ZcaRz8ybKR9zbQGjFY/W4p3t/TQe5KAtgrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7tzUekvOYmlekj8StGR3xQ9/GXDJyCMCvZxzkSALnGE1mlCGQE++0KwIK9UIgo7gWAHWPMoUBm2pOWX0UWSXa5Tj20j8mjEIcdPWnWPa3GDjzjntzEoVw//5ocw5/SrN/AAVKWhmekAzz+DsnJQjdQCCmAYd2hXzxpIj86CFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAjhzykw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAjhzykw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B701F00893;
	Sat,  6 Jun 2026 08:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780733538;
	bh=Hb81cKk8ZcaRz8ybKR9zbQGjFY/W4p3t/TQe5KAtgrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oAjhzykwaU253cFmil4zCN6AYlfqQp2dLxUH4gu/nMahHeu0g/Dkfydt+lTW10EVw
	 M7bsJCm+bMkL9wbN7HJYy4ytn/J1UrXMRHB7vId+zorBxMz//smUqBWppNhCpID8XD
	 OlVFwpASzaltdb1uGO3aT4dwLVQHt0PG2pKH8SMGGSrexlh6rM3L0M3iojWp0LkiIW
	 IqvS9r8yct3V5oG4IccL8WCLg2I9X2tPfsgsEeZEa4gO4hNYPT+ZiUY0qHXQzOI6gK
	 UWuc/PC4/s+0AqT5CvAtqa15gZ+Rhco0OjrMO4yuN5wL2BEYSMG3abBfSevZE9lmsH
	 Odz5K7xA7wW2w==
Date: Sat, 6 Jun 2026 09:12:12 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs/proc/task_mmu: read proc/pid/smaps_rollup under
 per-vma lock
Message-ID: <aiPWD6xZLg6g4DTO@lucifer>
References: <20260606015729.1837935-1-surenb@google.com>
 <20260606015729.1837935-2-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606015729.1837935-2-surenb@google.com>

(Will review separately)

Sorry to be a pain :) and I know it's a petty thing, but even for a 2 patch
series it's easier to handle if sent with patches in-reply-to a cover
letter :>) also makes it easier to track overall updates in cover letter
changelog.

Thanks, Lorenzo
