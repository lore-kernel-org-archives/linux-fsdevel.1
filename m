Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC773E833F;
	Thu, 28 May 2026 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971969; cv=none; b=RrzJ5OQtARYKyXLgbF+UZ2w11FNuUVQN7FHVizmS4SRpM1BER0xIqU47L0qTh2TLOvSkekIq48MTuUWHDDv3JsmDFd3zZ2q8xWroJWMU6vm+R6KSr4ijr1Drbv0XAXnrfFTN+SxQN8uyUGLfb5GrnUnIEz/xuEE9nd7aVmiJ7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971969; c=relaxed/simple;
	bh=Rx5Ey5gkbvhDJ36QB6ixIVYV6U5tfbsQHnO5FzIQUs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzWHf5WIvabYO77lmBgTfHcJ52xRq/ykdYv+WfQffKAJeIWuTc+0HaU5aYlNE65ONTwpqY8gOcHq7yG+0WM7uzB5CUf3vK61OyjwSKhuFPLjq6ug4CjlBnBf54e/j3HLlsguzdoSYBG/pD5h7gelVlkEXjeW8t/1VtmSb4N0t2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdX3A6Wh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdX3A6Wh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1981F000E9;
	Thu, 28 May 2026 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779971967;
	bh=LjOzL2NyUyCTma94sZKS4fSd2UcLIZWOihtjlrGif9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TdX3A6WhsV2nqy6+cmmWG145Nlh49u8GVavjcX97KRruYVRyz/sGeGpKyv9mPrkSs
	 Cxe1Rjip23w422M4eSOW6H70usxBTO+ieZzkGKi7P0PG4PBRR4cgQV8cTfgypLhbpF
	 BM57rT5leqcqmysGGsLIUlfyEuDNh2ngYqxbiSTKKWnDOtOz5BkqlffrhOjWow/75Y
	 NQ28Q+/UQReKL7O6PWOxTBcJVBszmh5e+45Z7BJGTSDyAglZC0gCtijikOwx63voFo
	 A2khGbG0CIOWxww3k28B4ahItobPCUnsScQP7aeohU5zh+P9EHxV0HBjeDa6hQXXd4
	 bF5ivNkVQEDHg==
Date: Thu, 28 May 2026 14:39:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kiryl Shutsemau <kirill@shutemov.name>, Peter Xu <peterx@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/2] userfaultfd: merge fs/userfaultfd.c into
 mm/userfaultfd.c
Message-ID: <20260528-raumakustik-absitzen-verzweifeln-885bd6a70835@brauner>
References: <20260523173759.3964908-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260523173759.3964908-1-rppt@kernel.org>

On Sat, May 23, 2026 at 08:37:57PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Hi,
> 
> These patches merge fs/userfaultfd.c into mm/userfaultfd.c and make
> functions used only inside mm/userfaultfd.c static.

Yes, please take this thing out of fs/

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
