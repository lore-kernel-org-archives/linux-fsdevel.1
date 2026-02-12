Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CA286D60;
	Thu, 12 Feb 2026 23:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770940648; cv=none; b=m24lo9a8xulCFdm4wp1fzp4IEBipPCmzgvfBSxv+oCVrEivTDRkPJURebyCdUo8adpskrKcTIyOBjXg6TreMLgUhUXl/mwFCfjCDhYieG6ppo6MHp2+dA/RPoGczO7pf5YyEkC52WgWxu7RKYmaagLK8HExBKhS1UD2f7A3pZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770940648; c=relaxed/simple;
	bh=qH3sZOAXgsUDZ09GEG/CPzjzapOeWhbOfDETc9hIRVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7HodA4Gpq3tTpBn11+dwPaRsm2flxo7Po0iFvuf4z/9r7Vr6T6Y/oJja+7najYBOTiC6rElnepfXoSlqx95ob0vwVzT+5xYABkc2CMWyiiBomKSacu02dQTRmZWvnxy3XBpOyIENQyuWIAkcEMMQvW6bLMXDVMKu//c0GFveAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8dUK+eV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8dUK+eV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1A2C4CEF7;
	Thu, 12 Feb 2026 23:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770940648;
	bh=qH3sZOAXgsUDZ09GEG/CPzjzapOeWhbOfDETc9hIRVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8dUK+eVatdS5vpKnijzt3yXjpo4a1kisPNMV6Nj89YrPja2m61ACXdWvBHURZEaD
	 BEfYrXT9BR7U1+yaiyVHk4YUOEC0x0h9Qq+md7gpf7By5/rHIhpCQYwTEdS0WZRVHe
	 G9w9+g6xy85JEtNj9JkmpDEyBJlI0gXfU864RlU8t2GcqBezA9IiC83UG8w8rau1by
	 OKGS7m4nBKOcLRflfVy8bS5n+CsDQKjB4VIyokrnxFHkBBnKbuHyC7sRSLjcU1Nzzq
	 uh+MGPtj5UN4kwaQuj8ggpZf+UTg3tHTHMOHQIg2YEF9p/Lc/vwFz0CUpI+GLYYAHq
	 0LuO6W5jzs+8A==
Date: Thu, 12 Feb 2026 15:57:27 -0800
From: Kees Cook <kees@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, criu@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Koutny <mkoutny@suse.com>
Subject: Re: [PATCH 4/4] selftests/exec: add test for HWCAP inheritance
Message-ID: <202602121557.5C1249F@keescook>
References: <20260209190605.1564597-1-avagin@google.com>
 <20260209190605.1564597-5-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209190605.1564597-5-avagin@google.com>

On Mon, Feb 09, 2026 at 07:06:05PM +0000, Andrei Vagin wrote:
> Verify that HWCAPs are correctly inherited/preserved across execve() when
> modified via prctl(PR_SET_MM_AUXV).
> 
> The test performs the following steps:
> * reads the current AUXV using prctl(PR_GET_AUXV);
> * finds an HWCAP entry and toggles its most significant bit;
> * replaces the AUXV of the current process with the modified one using
>   prctl(PR_SET_MM, PR_SET_MM_AUXV);
> * executes itself to verify that the new program sees the modified HWCAP
>   value.
> 
> Signed-off-by: Andrei Vagin <avagin@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
