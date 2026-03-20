Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD52FF669;
	Fri, 20 Mar 2026 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002707; cv=none; b=iPMHyhh54qwoitmk+eiITUPBe54j/3gHsvmHyHnQq/cS+WEVCmZ22/PKDh1HbP00Wtcj9Zric/olKZWUmQLtm+U48OU/+zHgD0dhOgkiqVJB5lWXGZQLdqqJqpT3glL5ffzFEmIlNwFG6odmtxVI5KXCVyuXlT0ex1jV9ID2aiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002707; c=relaxed/simple;
	bh=fdYUtgNUf1B4oA+xB5yvpsYhFkxtjq7FGYokCbIiu0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fje0Ri/ApkdaxuuwaAZ/IRUWKxxGPFFELc1wCwMj2pDPJqIq86bVlJaqkIaykc+KUF4YMoutYU3Bv6HqTWLOjOLAsau4ZCJvY1ZPHotyQ0B/ztm2t+oxW1c9U+ut4K9LOPOzA9tvz/Y7oeas8iQ9/gQwaWbd8kACAZELES8KcpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5/o2O+K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5/o2O+K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2C8C4CEF7;
	Fri, 20 Mar 2026 10:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774002706;
	bh=fdYUtgNUf1B4oA+xB5yvpsYhFkxtjq7FGYokCbIiu0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V5/o2O+KFWdkeRlhtYWRN5RmzMYy9awcl9ZDXj85s2SX/Lsv5/R+/Z1VyIGtv9qv5
	 /4/aUDCSgchXpXd7ZYBx7nSK6KjdY0uzfylfTX+2TzGqKKLxmdDCaawc0qZ9/BkMX/
	 btizPaUB7QbGdYHemXdGBaF/C/ByUgxDE1iPJ7S2G7a5qOYEhXsAKPikDDZ8eLmrLc
	 rS8gU9Q5Rxq1gQh2r5j4r1Wlw8EK5Hfr1EJRsjllMyKp6CzIjlvCOdHbOs2v3Z8WHZ
	 weV3XYyGAncXMdybLxGz/63VeJeZWu+MEsaErRGnMIHYkXWb0ILCZNS5bBMjplRzmZ
	 XcW8mqtKtkdMQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: viro@zeniv.linux.org.uk,  brauner@kernel.org,  jack@suse.cz,
  rppt@kernel.org,  pratyush@kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  akpm@linux-foundation.org,
  linux-mm@kvack.org
Subject: Re: [RFC] liveupdate: prevent double preservation
In-Reply-To: <20260317023834.487682-1-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 16 Mar 2026 22:38:34 -0400")
References: <20260317023834.487682-1-pasha.tatashin@soleen.com>
Date: Fri, 20 Mar 2026 10:31:43 +0000
Message-ID: <2vxzqzpeaj1s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Pasha,

On Mon, Mar 16 2026, Pasha Tatashin wrote:

> Currently, LUO does not prevent the same file from being preserved twice
> across different active sessions.
>
> Add a new i_state flag I_LUO_PRESERVED and update luo_preserve_file()
> to check and set this flag when a file is preserved, and clear it in
> luo_file_unpreserve_files() when it is released. This ensures that the
> same file (inode) cannot be preserved by multiple sessions. If another
> session attempts to preserve an already preserved file, it will now
> fail with -EBUSY.

For consistency, would it be a good idea to also set this flag after
retrieve? And then clear it on finish? If we do that then I suppose we
should rename the flag to I_LUO_MANAGED or something similar.

Other than this, LGTM from LUO perspective.

Acked-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav
